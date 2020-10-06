using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Data.OracleClient;
using System.Data.SqlClient;
using System.Configuration;
using System.Globalization;
using System.Security.Permissions;
using System.Data.OleDb;
using System.Net.Mail;
using System.Collections;
using System.Drawing;
using System.Drawing.Imaging;

public partial class FormularioORDENHistorico : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();
    public static String servicio, orden_servicio,username,visita,id_proceso,cod_instalador,atendido,cod_improcedencia;
    FileInfo[] MisFicheros,MisFicherosVisita;
    public static Boolean inicio = true;
    public static String[] correlativo = { "0", "0", "0", "0", "0", "0" };
    public static DataTable mi_orden;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            try
            {
                
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                PRO.recSession(rutaXml, "RUT_EMPRESA");
                
                lb_id_usuario.Text = PRO.recSession(rutaXml, "ID_USUARIO");
                lb_id_perfil.Text = PRO.recSession(rutaXml, "ID_PERFIL");
                lb_hoy.Text = DateTime.Now.ToString("ddMMyyyy");

                servicio = Request.QueryString["servicio"];
                orden_servicio = Request.QueryString["orden_servicio"];
                visita = Request.QueryString["visita"];
                id_proceso = Request.QueryString["id_proceso"];

                cod_improcedencia = "0";    
                //atendido = get_procedencia(servicio, orden_servicio, visita);

                mi_orden = new DataTable();
                carga_combos(); //cargamos la información de cada combo.        
                cargar_datos(servicio, orden_servicio,visita);                
                mi_formulario.Visible = true;
                subir_fotos.Visible = false;                      
                set_fotos(atendido);               

            }
            catch (Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }
        }

        //btn_volver.Attributes.Add("onclick", "return confirm('Se descartará todo avance realizado,¿Está seguro de continuar?');");
       
    }

    public String get_procedencia(String servicio, String orden, String visita)
    {
        String codigo = "0";
        try
        {
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();

            objConexion.Open();
            objComando = new OracleDataAdapter("PK_FORMULARIO.GET_PROCEDENCIA", objConexion);
            objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

            PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
            PRO.agrega_parametro_sp(objComando, "i_orden_servicio", OracleType.Number, ParameterDirection.Input, orden);
            PRO.agrega_parametro_sp(objComando, "i_servicio", OracleType.Number, ParameterDirection.Input, servicio);
            PRO.agrega_parametro_sp(objComando, "i_visita", OracleType.Number, ParameterDirection.Input, visita);

            objComando.SelectCommand.ExecuteNonQuery();

            objComando.Fill(objDS, "PROCEDENCIA");
            objConexion.Close();
          
            //String SQL = "SELECT EO.ATENDIDO,O.COD_IMPROCEDENCIA FROM ORDEN O JOIN ESTATUS_ORDEN EO ON EO.COD_ESTATUS_ORDEN = O.COD_IMPROCEDENCIA WHERE O.NUMERO_ORDEN = " + orden + " AND O.ID_SERVICIO = " + servicio + " AND O.VISITA = " + visita;
            //SQL = SQL + "UNION ALL SELECT EO.ATENDIDO,O.COD_IMPROCEDENCIA FROM ORDEN_HISTORICOS O JOIN ESTATUS_ORDEN EO ON EO.COD_ESTATUS_ORDEN = O.COD_IMPROCEDENCIA WHERE O.NUMERO_ORDEN = " + orden + " AND O.ID_SERVICIO = " + servicio + " AND O.VISITA = " + visita;
            
            //objConexion.Open();
            //objComando = new OracleDataAdapter(SQL, objConexion);
            //objComando.SelectCommand.CommandType = CommandType.Text;

            //objComando.SelectCommand.ExecuteNonQuery();
            //objComando.Fill(objDS, "PROCEDENCIA");
            //objConexion.Close();

            
            foreach (DataRow row in objDS.Tables["PROCEDENCIA"].Rows)
            {
                codigo = row[0].ToString();
                cod_improcedencia = row[1].ToString(); //ASIGNA EL CODIGO DE IMPROCEDENCIA Y LO DEJAMOS EN LA VARIABLE GLOBAL STATICA.
            }
            return codigo;
        }
        catch (Exception ex)
        {
            return codigo;
        }

    }

  
    public void set_fotos(String procedencia)
    {               
      
     
        switch(procedencia){
            case "1":
                title_1.Text = "SERIE MEDIDOR RETIRADO";
                correlativo[0] = "1";
                title_2.Text = "CÚPULA MAP RETIRADO";
                correlativo[1] = "2";
                title_3.Text = "SERIE MEDIDOR INSTALADO";
                correlativo[2] = "3";
                title_4.Text = "CÚPULA MAP INSTALADO";
                correlativo[3] = "4";
                title_5.Text = "PANORÁMICA MAP O LIBRE ACCESO";
                correlativo[4] = "5";
                title_6.Text = "PAPELETA FIRMADA POR CLIENTE";
                correlativo[5] = "6";                
                break;
            case "2":            
                title_1.Text = "FACHADA INSTALACIÓN";
                correlativo[0] = "7";
                title_2.Text = "PANORÁMICA INSTALACIÓN";
                correlativo[1] = "8";
                title_3.Text = "PROBLEMA TÉCNICO";
                correlativo[2] = "9";

                slot4.Visible = false;
                title_4.Visible = false;

                slot5.Visible = false;
                title_5.Visible = false;

                slot6.Visible = false;
                title_6.Visible = false;
                break;
            default:
                break;
        }              
       
    }

    public void cargar_datos(String id_servicio,String numero_orden,String visita)
    {

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_FORMULARIO.CARGA_DATOS_ORDEN", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_servicio", OracleType.Number, ParameterDirection.Input, id_servicio);
        PRO.agrega_parametro_sp(da, "i_nro_orden", OracleType.Number, ParameterDirection.Input, numero_orden);
        PRO.agrega_parametro_sp(da, "i_visita", OracleType.Number, ParameterDirection.Input, visita);

        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        DataTable dtOrdenes = new DataTable();

        try
        {
            CnOra.Open();
            da.Fill(dtOrdenes);
            CnOra.Close();
            CnOra.Dispose();
        }
        catch (Exception ex)
        {

        }

        foreach (DataRow drOrdenItem in dtOrdenes.Rows)
        {
            //INFO BASICA.
            lb_servicio.Text = id_servicio;
            lb_nro_orden.Text = numero_orden;
            lb_nombre_cliente.Text = drOrdenItem["NOMBRE_CLIENTE"].ToString();
            lb_direccion.Text = drOrdenItem["DIRECCION_CLIENTE"].ToString();
            lb_ruta_lectura.Text = drOrdenItem["RUTA"].ToString();           
            lb_fecha.Text = drOrdenItem["FECHA_CREACION"].ToString();
            lb_localidad.Text = drOrdenItem["LOCALIDAD"].ToString();
            lb_causa_cambio.Text = drOrdenItem["CAUSA"].ToString();
            lb_visita.Text = visita;

            //ANTECEDENTES MEDIDOR RETIRADO.
            tb_serie_ret.Text = drOrdenItem["SERIE_RET"].ToString();           
            tb_año_ret.Text = drOrdenItem["AGNO_RET"].ToString();
            tb_lectura_ret.Text = drOrdenItem["LECTURA_RET"].ToString();
            //tb_orden_servicio.Text = numero_orden;

            //marca medidor retirado
            foreach (ListItem item in cb_marca_ret.Items)
            {
                if (item.Value == drOrdenItem["MARCA_RET"].ToString())
                {
                    cb_marca_ret.SelectedValue = item.Value; break;
                }
            }

            //diametro medidor retirado
            foreach (ListItem item in cb_diametro_ret.Items)
            {
                if (item.Value == drOrdenItem["DIAMETRO_RET"].ToString())
                {
                    cb_diametro_ret.SelectedValue = item.Value; break;
                }
            }


            //ANTECEDENTES MEDIDOR INSTALADO.
            tb_serie_nuevo.Text = drOrdenItem["SERIE_NU"].ToString();
            tb_año_nuevo.Text = drOrdenItem["AGNO_NU"].ToString();
            tb_numero_sello_nuevo.Text = drOrdenItem["NUM_SELLO"].ToString();
            tb_lectura_nuevo.Text = drOrdenItem["LECTURA_NU"].ToString();

            //marca nuevo medidor.
            foreach (ListItem item in cb_marca_nuevo.Items)
            {
                if (item.Value == drOrdenItem["MARCA_NU"].ToString())
                {
                    cb_marca_nuevo.SelectedValue = item.Value; break;
                }
            }

            //diametro nuevo medidor.
            foreach (ListItem item in cb_diametro_nuevo.Items)
            {
                if (item.Value == drOrdenItem["DIAMETRO_NU"].ToString())
                {
                    cb_diametro_nuevo.SelectedValue = item.Value; break;
                }
            }

            //instalacion varal nuevo medidor.
            foreach (ListItem item in cb_instalacion_varal_nuevo.Items)
            {
                if (item.Value == drOrdenItem["INSTALACION_VARAL"].ToString())
                {
                    cb_instalacion_varal_nuevo.SelectedValue = item.Value; break;
                }
            }

            //instalacion llave nuevo medidor.
            foreach (ListItem item in cb_instalacion_llave_nuevo.Items)
            {
                if (item.Value == drOrdenItem["INSTALACION_LLAVE"].ToString())
                {
                    cb_instalacion_llave_nuevo.SelectedValue = item.Value; break;
                }
            }

            //tipo llave nuevo medidor.
            foreach (ListItem item in cb_tipo_llave_nuevo.Items)
            {
                if (item.Value == drOrdenItem["TIPO_LLAVE"].ToString())
                {
                    cb_tipo_llave_nuevo.SelectedValue = item.Value; break;
                }
            }

            //tipo sello nuevo medidor.
            foreach (ListItem item in cb_tipo_sello_nuevo.Items)
            {
                if (item.Value == drOrdenItem["TIPOSELLO"].ToString())
                {
                    cb_tipo_sello_nuevo.SelectedValue = item.Value; break;
                }
            }

            //color sello nuevo medidor.
            foreach (ListItem item in cb_color_sello_nuevo.Items)
            {
                if (item.Value == drOrdenItem["COLOR_SELLO"].ToString())
                {
                    cb_color_sello_nuevo.SelectedValue = item.Value; break;
                }
            }

            //material varales nuevo medidor.
            foreach (ListItem item in cb_material_nuevo.Items)
            {
                if (item.Value == drOrdenItem["MATERIAL_VARAL"].ToString())
                {
                    cb_material_nuevo.SelectedValue = item.Value; break;
                }
            }

            //instalador.
            foreach (ListItem item in cb_instalador.Items)
            {
                if (item.Value == drOrdenItem["COD_INSTALADOR"].ToString())
                {
                    cb_instalador.SelectedValue = item.Value;
                    cod_instalador = item.Value;
                    break;
                }
            }

            //contratista.
            foreach (ListItem item in cb_contratista.Items)
            {
                if (item.Value == drOrdenItem["COD_CONTRATISTA"].ToString())
                {
                    cb_contratista.SelectedValue = item.Value; break;
                }
            }

            inicio = false;

            tb_nombre_cliente.Text = drOrdenItem["NOMBRE_CONTACTO"].ToString();
            tb_rut_cliente.Text = drOrdenItem["RUT_CONTACTO"].ToString();
            tb_fecha.Text = drOrdenItem["FECHA_EJECUCION"].ToString().Substring(0,10);
            tb_hora.Text = drOrdenItem["HORA_EJECUCION"].ToString();
            tb_observacion.Text = drOrdenItem["OBSERVACION"].ToString();
            mi_orden = dtOrdenes; //DEJAMOS LOS DATO DE CARGA GUARDADOS PARA REGISTRAR EL LOG AL MOMENTO DE CONFIRMAR EDICIÓN.

            lb_cod_inspector.Text = drOrdenItem["COD_INSTALADOR"].ToString();
            atendido = get_procedencia(servicio, orden_servicio, visita);
            aplica_map_instalados(atendido,cod_improcedencia);
            cargarFoto();
            validar_fotos(atendido);
        }


    }

    public void aplica_map_instalados(String atendido,String cod_improcedencia)
    {
        //SI ES EFECTIVA VISIBILIZA LOS CAMPOS DE MAP INSTALADOS, SINO MUESTRA MENSAJE RESPECTIVO.
        if (atendido.Equals("1"))
        {
            tr_si_aplica1.Visible = true;
            tr_si_aplica2.Visible = true;
            tr_si_aplica3.Visible = true;
            tr_si_aplica4.Visible = true;
            tr_no_aplica.Visible = false;

            //SOLO SI LA IMPROCEDENCIA ES EFECTIVA CON FIRMA, VISIBILIZA.
            if (cod_improcedencia.Equals("25"))
            {
                tr_no_aplica5.Visible = true;
                check_con_firma.Checked = true;
            }
            else
            {
                tr_no_aplica5.Visible = false;
                check_con_firma.Checked = false;
            }
        }
        else
        {
            tr_si_aplica1.Visible = false;
            tr_si_aplica2.Visible = false;
            tr_si_aplica3.Visible = false;
            tr_si_aplica4.Visible = false;
            tr_no_aplica5.Visible = false;
            tr_no_aplica.Visible = true;
            check_con_firma.Visible = false;
        }

       
    }
    
    //CARGAMOS LA INFORMACIÓN ASOCIADA A CADA COMBO BOX DEL PANEL.
    public void carga_combos()
    {
        carga_marca_medidor();
        carga_diametro_medidor();
        carga_material_varal();
        carga_instalacion_varal();
        carga_instalacion_llave();
        carga_color_sello();
        carga_tipo_llave();
        carga_tipo_sello();
        carga_instalador();
        carga_contratista();
    }
          
    //OBTENEMOS LA LISTA DE MARCAS.
    public void carga_marca_medidor()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_FORMULARIO.CARGA_MARCA_MEDIDOR", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();

        objComando.Fill(objDS, "MARCA");
        objConexion.Close();

        int i = 1;
        //med nuevo
        cb_marca_nuevo.Items.Clear();
        cb_marca_nuevo.Items.Add("SELECCIONE");
        cb_marca_nuevo.Items[0].Value = "0";

        //med retirado
        cb_marca_ret.Items.Clear();
        cb_marca_ret.Items.Add("SELECCIONE");
        cb_marca_ret.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["MARCA"].Rows)
        {
            cb_marca_nuevo.Items.Add(row[0].ToString());
            cb_marca_nuevo.Items[i].Value = row[1].ToString();

            cb_marca_ret.Items.Add(row[0].ToString());
            cb_marca_ret.Items[i].Value = row[1].ToString();
            i = i + 1;
        }
    }

    //OBTENEMOS LA LISTA DE DIAMETROS.
    public void carga_diametro_medidor()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_FORMULARIO.CARGA_DIAMETRO_MEDIDOR", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();

        objComando.Fill(objDS, "DIAMETRO");
        objConexion.Close();

        int i = 1;
        //med nuevo
        cb_diametro_nuevo.Items.Clear();
        cb_diametro_nuevo.Items.Add("SELECCIONE");
        cb_diametro_nuevo.Items[0].Value = "0";

        //med retirado
        cb_diametro_ret.Items.Clear();
        cb_diametro_ret.Items.Add("SELECCIONE");
        cb_diametro_ret.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["DIAMETRO"].Rows)
        {
            cb_diametro_nuevo.Items.Add(row[0].ToString());
            cb_diametro_nuevo.Items[i].Value = row[0].ToString();

            cb_diametro_ret.Items.Add(row[0].ToString());
            cb_diametro_ret.Items[i].Value = row[0].ToString();
            i = i + 1;
        }
    }

    //OBTENEMOS LA LISTA DE INSTALACIONES VARAL.
    public void carga_instalacion_varal()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_FORMULARIO.CARGA_INSTALACION_VARAL", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();

        objComando.Fill(objDS, "INST_VARAL");
        objConexion.Close();

        int i = 0;
        cb_instalacion_varal_nuevo.Items.Clear();

        foreach (DataRow row in objDS.Tables["INST_VARAL"].Rows)
        {
            cb_instalacion_varal_nuevo.Items.Add(row[0].ToString());
            cb_instalacion_varal_nuevo.Items[i].Value = row[1].ToString();
            i = i + 1;
        }
    }
    
    //OBTENEMOS LA LISTA DE MATERIALES VARAL.
    public void carga_material_varal()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_FORMULARIO.CARGA_MATERIAL_VARALES", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();

        objComando.Fill(objDS, "MAT_VARAL");
        objConexion.Close();

        int i = 0;
        cb_material_nuevo.Items.Clear();

        foreach (DataRow row in objDS.Tables["MAT_VARAL"].Rows)
        {
            cb_material_nuevo.Items.Add(row[0].ToString());
            cb_material_nuevo.Items[i].Value = row[1].ToString();
            i = i + 1;
        }
    }

    //OBTENEMOS LA LISTA DE TIPO SELLO.
    public void carga_tipo_sello()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_FORMULARIO.CARGA_TIPO_SELLO", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();

        objComando.Fill(objDS, "TIPO_SELLO");
        objConexion.Close();

        int i = 1;
        cb_tipo_sello_nuevo.Items.Clear();
        cb_tipo_sello_nuevo.Items.Add("NO APLICA");
        cb_tipo_sello_nuevo.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["TIPO_SELLO"].Rows)
        {
            cb_tipo_sello_nuevo.Items.Add(row[0].ToString());
            cb_tipo_sello_nuevo.Items[i].Value = row[1].ToString();
            i = i + 1;
        }
    }

    //OBTENEMOS LA LISTA DE INSTALACIÓN DE LLAVE.
    public void carga_instalacion_llave()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_FORMULARIO.CARGA_INSTALACION_LLAVE", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();

        objComando.Fill(objDS, "INST_LLAVE");
        objConexion.Close();

        int i = 0;
        cb_instalacion_llave_nuevo.Items.Clear();

        foreach (DataRow row in objDS.Tables["INST_LLAVE"].Rows)
        {
            cb_instalacion_llave_nuevo.Items.Add(row[0].ToString());
            cb_instalacion_llave_nuevo.Items[i].Value = row[1].ToString();
            i = i + 1;
        }
    }

    //OBTENEMOS LA LISTA DE TIPO LLAVE.
    public void carga_tipo_llave()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_FORMULARIO.CARGA_TIPO_LLAVE", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();

        objComando.Fill(objDS, "TIPO_LLAVE");
        objConexion.Close();

        int i = 0;
        cb_tipo_llave_nuevo.Items.Clear();

        foreach (DataRow row in objDS.Tables["TIPO_LLAVE"].Rows)
        {
            cb_tipo_llave_nuevo.Items.Add(row[0].ToString());
            cb_tipo_llave_nuevo.Items[i].Value = row[1].ToString();
            i = i + 1;
        }
    }

    //OBTENEMOS LA LISTA DE COLOR SELLO.
    public void carga_color_sello()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_FORMULARIO.CARGA_COLOR_SELLO", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();

        objComando.Fill(objDS, "COLOR_SELLO");
        objConexion.Close();

        int i = 1;
        cb_color_sello_nuevo.Items.Clear();
        cb_color_sello_nuevo.Items.Add("NO APLICA");
        cb_color_sello_nuevo.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["COLOR_SELLO"].Rows)
        {
            cb_color_sello_nuevo.Items.Add(row[0].ToString());
            cb_color_sello_nuevo.Items[i].Value = row[1].ToString();
            i = i + 1;
        }
    }

    //OBTENEMOS LA LISTA DE INSTALADORES.
    public void carga_instalador()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_FORMULARIO.CARGA_INSTALADOR", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();

        objComando.Fill(objDS, "INSTALADOR");
        objConexion.Close();

        int i = 1;
        cb_instalador.Items.Clear();
        cb_instalador.Items.Add("SELECCIONE");
        cb_instalador.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["INSTALADOR"].Rows)
        {
            cb_instalador.Items.Add(row[0].ToString());
            cb_instalador.Items[i].Value = row[1].ToString();
            i = i + 1;
        }
    }

    //OBTENEMOS LA LISTA DE CONTRATISTAS.
    public void carga_contratista()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_FORMULARIO.CARGA_CONTRATISTA", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();

        objComando.Fill(objDS, "CONTRATISTA");
        objConexion.Close();

        int i = 1;
        cb_contratista.Items.Clear();
        cb_contratista.Items.Add("SELECCIONE");
        cb_contratista.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["CONTRATISTA"].Rows)
        {
            cb_contratista.Items.Add(row[0].ToString());
            cb_contratista.Items[i].Value = row[1].ToString();
            i = i + 1;
        }
    }
       
    public Boolean validar_formulario(String atendido)
    {
        lb_avance.Text = "Debe seleccionar/completar/corregir: ";
        String respuesta = "";
        int pendientes = 0;
        long num;

        if (atendido.Equals("1")) //EFECTIVA CON/SIN FIRMA (24/25)
        {
            //SECTOR MEDIDOR INSTALADO
            if (cb_marca_nuevo.SelectedIndex == 0) //MARCA
            {
                if (pendientes > 0) respuesta = ", marca";
                else respuesta = " marca";

                lb_avance.Text = lb_avance.Text + respuesta;
                pendientes++;
            }

            if (cb_diametro_nuevo.SelectedIndex == 0) //DIAMETRO
            {
                if (pendientes > 0) respuesta = ", diametro";
                else respuesta = " diametro";

                lb_avance.Text = lb_avance.Text + respuesta;
                pendientes++;
            }

            //SE COMENTA YA QUE LOS COMBOS NO TRAE UN VALOR "SELECCIONE" (0), EXISTEN VALORES "0" VALIDOS.
            //if (cb_instalacion_varal_nuevo.SelectedIndex == 0)
            //{
            //    if (pendientes > 0) respuesta = ", instalación varal";
            //    else respuesta = " instalación varal";

            //    lb_avance.Text = lb_avance.Text + respuesta;
            //    pendientes++;
            //}

            //if (cb_instalacion_llave_nuevo.SelectedIndex == 0)
            //{
            //    if (pendientes > 0) respuesta = ", instalación llave";
            //    else respuesta = " instalación llave";

            //    lb_avance.Text = lb_avance.Text + respuesta;
            //    pendientes++;
            //}

            //if (cb_tipo_sello_nuevo.SelectedIndex == 0)
            //{
            //    if (pendientes > 0) respuesta = ", tipo sello";
            //    else respuesta = " tipo sello";

            //    lb_avance.Text = lb_avance.Text + respuesta;
            //    pendientes++;
            //}

            //if (cb_material_nuevo.SelectedIndex == 0)
            //{
            //    if (pendientes > 0) respuesta = ", material varal";
            //    else respuesta = " material varal";

            //    lb_avance.Text = lb_avance.Text + respuesta;
            //    pendientes++;
            //}

            //if (cb_tipo_llave_nuevo.SelectedIndex == 0)
            //{
            //    if (pendientes > 0) respuesta = ", tipo llave";
            //    else respuesta = " tipo llave";

            //    lb_avance.Text = lb_avance.Text + respuesta;
            //    pendientes++;
            //}

            //if (cb_color_sello_nuevo.SelectedIndex == 0)
            //{
            //    if (pendientes > 0) respuesta = ", color sello";
            //    else respuesta = " color sello";

            //    lb_avance.Text = lb_avance.Text + respuesta;
            //    pendientes++;
            //}

            //CAMPOS DIGITABLES EN SECTOR MEDIDOR INSTALADO

            if (!long.TryParse(tb_año_nuevo.Text, out num)) //
            {
                if (pendientes > 0) respuesta = ", año";
                else respuesta = " año";

                lb_avance.Text = lb_avance.Text + respuesta;
                pendientes++;
            }

            if (!long.TryParse(tb_lectura_nuevo.Text, out num)) //
            {
                if (pendientes > 0) respuesta = ", lectura";
                else respuesta = " lectura";

                lb_avance.Text = lb_avance.Text + respuesta;
                pendientes++;
            }

            if (!long.TryParse(tb_serie_nuevo.Text, out num)) //
            {
                if (pendientes > 0) respuesta = ", serie map";
                else respuesta = " serie map";

                lb_avance.Text = lb_avance.Text + respuesta;
                pendientes++;
            }

            if (!long.TryParse(tb_numero_sello_nuevo.Text, out num)) //
            {
                if (pendientes > 0) respuesta = ", número sello";
                else respuesta = " número sello";

                lb_avance.Text = lb_avance.Text + respuesta;
                pendientes++;
            }

            if (check_con_firma.Checked) //CON FIRMA REQUIERE CAMPO DE NOMBRE Y RUT CONTACTO.
            {
                if (tb_nombre_cliente.Text.Length == 0)
                {
                    if (pendientes > 0) respuesta = ", nombre contacto/cliente";
                    else respuesta = " nombre contacto/cliente";

                    lb_avance.Text = lb_avance.Text + respuesta;
                    pendientes++;
                }

                if (!validarRut(tb_rut_cliente.Text))
                {
                    if (pendientes > 0) respuesta = ", rut inválido";
                    else respuesta = " rut inválido";

                    lb_avance.Text = lb_avance.Text + respuesta;
                    pendientes++;
                }
            }

        }
        
        //DATOS MEDIDOR RETIRADO Y NRO ORDEN.
        //SERIE MAP RETIRADO
        if (!long.TryParse(tb_serie_ret.Text, out num)) //
        {
            if (pendientes > 0) respuesta = ", serie map retirado";
            else respuesta = " serie map retirado";

            lb_avance.Text = lb_avance.Text + respuesta;
            pendientes++;
        }

        //AÑO MAP RETIRADO
        if (!long.TryParse(tb_año_ret.Text, out num)) //
        {
            if (pendientes > 0) respuesta = ", año map retirado";
            else respuesta = " año map retirado";

            lb_avance.Text = lb_avance.Text + respuesta;
            pendientes++;
        }

        //LECTURA MAP RETIRADO
        if (!long.TryParse(tb_lectura_ret.Text, out num)) //
        {
            if (pendientes > 0) respuesta = ", lectura map retirado";
            else respuesta = " lectura map retirado";

            lb_avance.Text = lb_avance.Text + respuesta;
            pendientes++;
        }

        //MARCA MAP RETIRADO
        if (cb_marca_ret.SelectedIndex == 0)
        {
            if (pendientes > 0) respuesta = ", marca map retirado";
            else respuesta = " marca map retirado";

            lb_avance.Text = lb_avance.Text + respuesta;
            pendientes++;
        }

        //DIAMETRO MAP RETIRADO
        if (cb_diametro_ret.SelectedIndex == 0)
        {
            if (pendientes > 0) respuesta = ", diametro map retirado";
            else respuesta = " diametro map retirado";

            lb_avance.Text = lb_avance.Text + respuesta;
            pendientes++;
        }

        
        ////NRO ORDEN NUEVA
        //if(check_nro_orden.Checked){
        //    if (!long.TryParse(tb_orden_servicio.Text, out num)) //CHEQUEADO Y CON UN VALOR NUMÉRICO.
        //    {
        //        if (pendientes > 0) respuesta = ", número orden ";
        //        else respuesta = " número orden";

        //        lb_avance.Text = lb_avance.Text + respuesta;
        //        pendientes++;
        //    }
        //    else if (!valida_nueva_orden(tb_orden_servicio.Text))
        //    {
        //        if (pendientes > 0) respuesta = ", número orden nueva ya existe ";
        //        else respuesta = " número orden nueva ya existe";

        //        lb_avance.Text = lb_avance.Text + respuesta;
        //        pendientes++;
        //    }
        //}
       

        //DATOS CLIENTE Y OTROS (INSTALADOR, CONTRATISTA, FECHA Y HORA DEBEN VALIDARSE SIEMPRE).
        try
        {
            DateTime mi_fecha = DateTime.ParseExact(tb_fecha.Text, "dd-MM-yyyy", null);
        }
        catch (Exception ex)
        {
             if (pendientes > 0) respuesta = ", fecha ejecución";
            else respuesta = " fecha ejecución";

            lb_avance.Text = lb_avance.Text + respuesta;
            pendientes++;
        }

        try
        {
            String[] split_hora = tb_hora.Text.Split(':');
            long num2;
            if (!long.TryParse(split_hora[0], out num2) || !long.TryParse(split_hora[1], out num2) || !long.TryParse(split_hora[2], out num2)
                || split_hora[0].Length != 2 || split_hora[1].Length != 2 || split_hora[2].Length != 2) //
            {
                if (pendientes > 0) respuesta = ", hora ejecución";
                else respuesta = " hora ejecución";

                lb_avance.Text = lb_avance.Text + respuesta;
                pendientes++;
            }
        }
        catch (Exception ex)
        {
            if (pendientes > 0) respuesta = ", hora ejecución";
            else respuesta = " hora ejecución";

            lb_avance.Text = lb_avance.Text + respuesta;
            pendientes++;
        }

        if (cb_instalador.SelectedIndex == 0)
        {
            if (pendientes > 0) respuesta = ", instalador";
            else respuesta = " instalador";

            lb_avance.Text = lb_avance.Text + respuesta;
            pendientes++;
        }

        if (cb_contratista.SelectedIndex == 0)
        {
            if (pendientes > 0) respuesta = ", contratista";
            else respuesta = " contratista";

            lb_avance.Text = lb_avance.Text + respuesta;
            pendientes++;
        }
        
                   
        //hay cosas pendientes? pendientes > 0 indica que quedan pendientes
        if (pendientes > 0) return false;
        else return true;        

    }

    public Boolean existen_cambios()
    {
        

        if (!cb_marca_nuevo.SelectedValue.Equals(mi_orden.Rows[0]["MARCA_NU"].ToString())
            || !cb_diametro_nuevo.SelectedValue.Equals(mi_orden.Rows[0]["DIAMETRO_NU"].ToString())
            || !tb_serie_nuevo.Text.Equals(mi_orden.Rows[0]["SERIE_NU"].ToString())
            || !cb_instalacion_varal_nuevo.SelectedValue.Equals(mi_orden.Rows[0]["INSTALACION_VARAL"].ToString())
            || !cb_instalacion_llave_nuevo.SelectedValue.Equals(mi_orden.Rows[0]["INSTALACION_LLAVE"].ToString())
            || !cb_tipo_sello_nuevo.SelectedValue.Equals(mi_orden.Rows[0]["TIPOSELLO"].ToString())
            || !tb_numero_sello_nuevo.Text.Equals(mi_orden.Rows[0]["NUM_SELLO"].ToString())
            || !tb_año_nuevo.Text.Equals(mi_orden.Rows[0]["AGNO_NU"].ToString())
            || !tb_lectura_nuevo.Text.Equals(mi_orden.Rows[0]["LECTURA_NU"].ToString())
            || !cb_material_nuevo.SelectedValue.Equals(mi_orden.Rows[0]["MATERIAL_VARAL"].ToString())
            || !cb_tipo_llave_nuevo.SelectedValue.Equals(mi_orden.Rows[0]["TIPO_LLAVE"].ToString())
            || !cb_color_sello_nuevo.SelectedValue.Equals(mi_orden.Rows[0]["COLOR_SELLO"].ToString())
            || !tb_nombre_cliente.Text.Equals(mi_orden.Rows[0]["NOMBRE_CONTACTO"].ToString())
            || !tb_fecha.Text.Equals(mi_orden.Rows[0]["FECHA_EJECUCION"].ToString().Substring(0,10))
            || !tb_hora.Text.Equals(mi_orden.Rows[0]["HORA_EJECUCION"].ToString())
            || !tb_rut_cliente.Text.Equals(mi_orden.Rows[0]["RUT_CONTACTO"].ToString())
            || !tb_observacion.Text.Equals(mi_orden.Rows[0]["OBSERVACION"].ToString())
            || !cb_instalador.SelectedValue.Equals(mi_orden.Rows[0]["COD_INSTALADOR"].ToString())
            || !cb_contratista.SelectedValue.Equals(mi_orden.Rows[0]["COD_CONTRATISTA"].ToString()) //ABAJO COMIENZA COMPARACIÓN CON MAP RETIRADO.
            || !cb_marca_ret.SelectedValue.Equals(mi_orden.Rows[0]["MARCA_RET"].ToString())
            || !cb_diametro_ret.SelectedValue.Equals(mi_orden.Rows[0]["DIAMETRO_RET"].ToString())
            || !tb_serie_ret.Text.Equals(mi_orden.Rows[0]["SERIE_RET"].ToString())
            || !tb_año_ret.Text.Equals(mi_orden.Rows[0]["AGNO_RET"].ToString())
            || !tb_lectura_ret.Text.Equals(mi_orden.Rows[0]["LECTURA_RET"].ToString())
            //|| (!tb_orden_servicio.Text.Equals(orden_servicio) && check_nro_orden.Checked) //SÓLO SI ESTÁ CHEQUEADO Y EL NRO ORDEN ES DISTINTO AL DE ORIGEN LO PERMITE.
            || (cod_improcedencia.Equals("25") && !check_con_firma.Checked) //SI ES EFECTIVA CON FIRMA, Y EL CHECK ESTÁ OFF, EXISTIRÁ CAMBIO EN NOMBRE Y RUT.
            || (cod_improcedencia.Equals("24") && check_con_firma.Checked) //SI ES EFECTIVA SIN FIRMA, Y EL CHECK ESTÁ ON, EXISTIRÁ CAMBIO EN NOMBRE Y RUT.
            ) return true;
        else return false;

    }    

    public void guardar_completo(String opcion)
    {
        //ETAPA MEDIDOR INSTALADO
        String marca_nu, diametro_nu, serie_nu, instalacion_varal_nu, instalacion_llave_nu, tipo_sello_nu, num_sello_nu;
        String agno_nu, lectura_nu, material_varal_nu, tipo_llave_nu, color_sello_nu;
        //ETAPA ANTECEDENTES CLIENTE Y OBSERVACION
        String nombre_cliente, fecha_ejecucion, instalador, rut_cliente, hora_ejecucion, contratista, observacion;
        //ESPECIAL Y MAP RETIRADO
        //String orden_servicio_new;
        String marca_ret,diametro_ret,serie_ret,lectura_ret,agno_ret;
      

        //ASIGNACION
        //ETAPA MEDIDOR INSTALADO
        marca_nu = cb_marca_nuevo.SelectedValue;
        diametro_nu = cb_diametro_nuevo.SelectedValue;
        serie_nu = tb_serie_nuevo.Text;
        instalacion_varal_nu = cb_instalacion_varal_nuevo.SelectedValue;
        instalacion_llave_nu = cb_instalacion_llave_nuevo.SelectedValue;
        tipo_sello_nu = cb_tipo_sello_nuevo.SelectedValue;
        num_sello_nu = tb_numero_sello_nuevo.Text;
        agno_nu = tb_año_nuevo.Text;
        lectura_nu = tb_lectura_nuevo.Text;
        material_varal_nu = cb_material_nuevo.SelectedValue;
        tipo_llave_nu = cb_tipo_llave_nuevo.SelectedValue;
        color_sello_nu = cb_color_sello_nuevo.SelectedValue;

        //ETAPA 2
        if (check_con_firma.Checked)
        {
            nombre_cliente = tb_nombre_cliente.Text;
            rut_cliente = tb_rut_cliente.Text;
        }
        else
        {
            nombre_cliente = "";
            rut_cliente = "";
        }
        
        fecha_ejecucion = tb_fecha.Text;
        instalador = cb_instalador.SelectedValue;        
        hora_ejecucion = tb_hora.Text;
        contratista = cb_contratista.SelectedValue;
        observacion = tb_observacion.Text;       

        //ESPECIAL Y MAP RETIRADO
        //SI ESTÁ CHECK EL CAMBIO DE ORDEN ALMACENAMOS EL CAMPO DE LA ORDEN NUEVA, SINO MANTENEMOS EL EXISTENTE.
        //if (check_nro_orden.Checked) orden_servicio_new = tb_orden_servicio.Text;
        //else orden_servicio_new = orden_servicio;

        diametro_ret = cb_diametro_ret.SelectedValue;
        marca_ret = cb_marca_ret.SelectedValue;
        serie_ret = tb_serie_ret.Text;
        agno_ret = tb_año_ret.Text;
        lectura_ret = tb_lectura_ret.Text;

        for(int i = marca_ret.Length;i < 3;i++){
            marca_ret = "0" + marca_ret;
        }

        for(int i = agno_ret.Length;i < 4;i++){
            agno_ret = "0" + agno_ret;
        }

        for(int i = serie_ret.Length;i < 10;i++){
            serie_ret = "0" + serie_ret;
        }

        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter ComandoDA;

        objConexion.Open();
        ComandoDA = new OracleDataAdapter("PK_FORMULARIO.GUARDAR_ORDEN", objConexion);
        ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;
        PRO.agrega_parametro_sp(ComandoDA, "i_id_servicio", OracleType.Number, ParameterDirection.Input, servicio);
        PRO.agrega_parametro_sp(ComandoDA, "i_orden_servicio", OracleType.Number, ParameterDirection.Input, orden_servicio);
        PRO.agrega_parametro_sp(ComandoDA, "i_visita", OracleType.Number, ParameterDirection.Input, visita);
        PRO.agrega_parametro_sp(ComandoDA, "i_id_proceso", OracleType.Number, ParameterDirection.Input, id_proceso);
        PRO.agrega_parametro_sp(ComandoDA, "i_marca_nu", OracleType.NVarChar, ParameterDirection.Input, marca_nu);
        PRO.agrega_parametro_sp(ComandoDA, "i_diametro_nu", OracleType.NVarChar, ParameterDirection.Input,diametro_nu);
        PRO.agrega_parametro_sp(ComandoDA, "i_serie_nu", OracleType.NVarChar, ParameterDirection.Input, serie_nu);
        PRO.agrega_parametro_sp(ComandoDA, "i_instalacion_varal", OracleType.NVarChar, ParameterDirection.Input, instalacion_varal_nu);
        PRO.agrega_parametro_sp(ComandoDA, "i_instalacion_llave", OracleType.NVarChar, ParameterDirection.Input,instalacion_llave_nu);
        PRO.agrega_parametro_sp(ComandoDA, "i_tiposello", OracleType.NVarChar, ParameterDirection.Input, tipo_sello_nu);
        PRO.agrega_parametro_sp(ComandoDA, "i_num_sello", OracleType.NVarChar, ParameterDirection.Input, num_sello_nu);
        PRO.agrega_parametro_sp(ComandoDA, "i_agno_nu", OracleType.NVarChar, ParameterDirection.Input, agno_nu);
        PRO.agrega_parametro_sp(ComandoDA, "i_lectura_nu", OracleType.NVarChar, ParameterDirection.Input, lectura_nu);
        PRO.agrega_parametro_sp(ComandoDA, "i_material_varal", OracleType.NVarChar, ParameterDirection.Input, material_varal_nu);
        PRO.agrega_parametro_sp(ComandoDA, "i_tipo_llave", OracleType.NVarChar, ParameterDirection.Input, tipo_llave_nu);
        PRO.agrega_parametro_sp(ComandoDA, "i_color_sello", OracleType.NVarChar, ParameterDirection.Input, color_sello_nu);
        PRO.agrega_parametro_sp(ComandoDA, "i_fecha_ejecucion", OracleType.NVarChar, ParameterDirection.Input, fecha_ejecucion);
        PRO.agrega_parametro_sp(ComandoDA, "i_hora_ejecucion", OracleType.NVarChar, ParameterDirection.Input, hora_ejecucion);
        PRO.agrega_parametro_sp(ComandoDA, "i_cod_instalador", OracleType.Number, ParameterDirection.Input, instalador);
        PRO.agrega_parametro_sp(ComandoDA, "i_cod_contratista", OracleType.Number, ParameterDirection.Input,contratista);
        PRO.agrega_parametro_sp(ComandoDA, "i_observacion", OracleType.NVarChar, ParameterDirection.Input, observacion);
        PRO.agrega_parametro_sp(ComandoDA, "i_nombre_contacto", OracleType.NVarChar, ParameterDirection.Input, nombre_cliente);
        PRO.agrega_parametro_sp(ComandoDA, "i_rut_contacto", OracleType.NVarChar, ParameterDirection.Input, rut_cliente);
        //PRO.agrega_parametro_sp(ComandoDA, "i_nueva_orden", OracleType.NVarChar, ParameterDirection.Input, orden_servicio_new); //SI ESTÁ CHECK SE HABILITARÁ LA NUEVA ORDEN, SINO DEJAMOS LA ORIGINAL.
        PRO.agrega_parametro_sp(ComandoDA, "i_diametro_ret", OracleType.NVarChar, ParameterDirection.Input, diametro_ret);
        PRO.agrega_parametro_sp(ComandoDA, "i_serie_ret", OracleType.NVarChar, ParameterDirection.Input, (marca_ret + agno_ret + serie_ret));
        PRO.agrega_parametro_sp(ComandoDA, "i_lectura_ret", OracleType.NVarChar, ParameterDirection.Input, lectura_ret);
        PRO.agrega_parametro_sp(ComandoDA, "i_cod_improcedencia", OracleType.Number, ParameterDirection.Input, cod_improcedencia);

        try
        {
            
            if (registrar_edicion(servicio, orden_servicio,"EDICION DATOS"))
            {
                ComandoDA.SelectCommand.ExecuteNonQuery();
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_ok('EDICIÓN REALIZADA!','SE HAN GUARDADO CORRECTAMENTE LOS CAMBIOS');", true);

                //SE ACTUALIZAN FOTOS DEBIDO A CAMBIO DE COD INSTALADOR.
                if (!instalador.Equals(mi_orden.Rows[0]["COD_INSTALADOR"].ToString()))
                {
                    renombrar_fotos(id_proceso,"", servicio,"", visita,"", mi_orden.Rows[0]["COD_INSTALADOR"].ToString(), instalador);
                    cod_instalador = instalador;
                }            

                ////SE ACTUALIZA LA ORDEN DE SERVICIO EN LA FICHA DEBIDO A CAMBIO POSIBLE DEL NÚMERO DE ORDEN.
                //if (!orden_servicio.Equals(orden_servicio_new))
                //{
                //    renombrar_fotos(id_proceso, servicio, visita, "1", mi_orden.Rows[0]["COD_INSTALADOR"].ToString(), "");
                //    orden_servicio = orden_servicio_new;
                //}

                cargar_datos(servicio, orden_servicio, visita);
            }
            else
            {
                lb_avance.Text = "No se pudo registrar la edición de la orden, favor volver a intentar";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + lb_avance.Text  + "');", true);
           
            }
            
            objConexion.Close();

           
        }
        catch (Exception ex)
        {
            lb_avance.Text = "Error: " + ex.Message;
        }

    }

    public Boolean renombrar_fotos(String proceso,String new_proceso,String servicio,String new_servicio,String old_visita,String new_visita,String old_instalador,String new_instalador)
    {
        try
        {
            //ANALIZAMOS SEGÚN LÓGICA DE ENTRADA, MANTENEMOS VALORES OLD SI ESQUE EL NEW ESTÁ VACÍO.
            if (new_visita.Equals("")) new_visita = old_visita;
            if (new_instalador.Equals("")) new_instalador = old_instalador;
            if (new_proceso.Equals("")) new_proceso = proceso;
            if (new_servicio.Equals("")) new_servicio = servicio;

            String nombre_foto_sin_visita = proceso + "A" + servicio + "A" + old_instalador;
            String nombre_foto_sin_visita_new = new_proceso + "A" + new_servicio + "A" + new_instalador;
            String ruta_fotos_visita = "FOTOS/" + old_visita + "/";
            String ruta_fotos_visita_new = "FOTOS/" + new_visita + "/";
            String ruta_fotos_raiz = "FOTOS/";

            if (!Directory.Exists(Server.MapPath("./" + ruta_fotos_visita + "/"))) System.IO.Directory.CreateDirectory(Server.MapPath("./" + ruta_fotos_visita + "/"));

            MisFicherosVisita = new DirectoryInfo(Server.MapPath("./" + ruta_fotos_visita + "/")).GetFiles(nombre_foto_sin_visita + "*");
            MisFicheros = new DirectoryInfo(Server.MapPath("./" + ruta_fotos_raiz + "/")).GetFiles(nombre_foto_sin_visita + "*");

            Int32 indice = 0;
            incializaCampos();

            //OBTENEMOS LAS FOTOS QUE SE ENCUENTREN EN LA RAIZ COMO PRIMERA PASADA.
            if (MisFicheros.Length > 0)
            {

                for (int i = 0; i < MisFicheros.Length; i++)
                {
                    String nombre_foto = MisFicheros[i].Name;
                    String ruta_completa = MisFicheros[i].FullName.Replace(Server.MapPath(""), "~");
                    String[] foto_split = nombre_foto.Split('A'); //0: proceso, 1: servicio, 2: cod_instalador, 3: visita, 4: corr.jpeg   

                    try
                    {
                        String nueva_foto = nombre_foto_sin_visita_new + "A" + foto_split[3] + "A" + foto_split[4];
                        indice = Int32.Parse(foto_split[4].Replace(".jpeg", ""));
                        File.Move(Server.MapPath("./" + ruta_fotos_raiz + "/") + nombre_foto,Server.MapPath("./" + ruta_fotos_raiz + "/") + nueva_foto);
                        //File.Replace(Server.MapPath("./" + ruta_fotos_raiz + "/") + nueva_foto, Server.MapPath("./" + ruta_fotos_raiz + "/") + nombre_foto, Server.MapPath("./" + ruta_fotos_raiz + "/") + "temp" + nueva_foto);
                    }
                    catch (Exception ex)
                    {
                        String nueva_foto = nombre_foto_sin_visita_new + "A" + foto_split[3];
                        indice = Int32.Parse(foto_split[3].Replace(".jpeg", ""));
                        File.Move(Server.MapPath("./" + ruta_fotos_raiz + "/") + nombre_foto, Server.MapPath("./" + ruta_fotos_raiz + "/") + nueva_foto);
                        //File.Replace(Server.MapPath("./" + ruta_fotos_raiz + "/") + nueva_foto, Server.MapPath("./" + ruta_fotos_raiz + "/") + nombre_foto, Server.MapPath("./" + ruta_fotos_raiz + "/") + "temp" + nueva_foto);
                    }

                     
                }                   

            }

            //OBTENEMOS LAS FOTOS QUE SE ENCUENTREN EN LA CARPETA DE VISITA.
            if (MisFicherosVisita.Length > 0)
            {

                for (int i = 0; i < MisFicherosVisita.Length; i++)
                {
                    String nombre_foto = MisFicherosVisita[i].Name;
                    String ruta_completa = MisFicherosVisita[i].FullName.Replace(Server.MapPath(""), "~");
                    String[] foto_split = nombre_foto.Split('A'); //0: proceso, 1: servicio, 2: cod_instalador, 3: visita, 4: corr.jpeg   

                    try
                    {
                        String nueva_foto = nombre_foto_sin_visita_new + "A" + foto_split[3] + "A" + foto_split[4];                        
                        indice = Int32.Parse(foto_split[4].Replace(".jpeg", ""));
                        File.Move(Server.MapPath("./" + ruta_fotos_visita + "/") + nombre_foto, Server.MapPath("./" + ruta_fotos_visita_new + "/") + nueva_foto);
                        //File.Replace(Server.MapPath("./" + ruta_fotos_visita + "/") + nueva_foto, Server.MapPath("./" + ruta_fotos_visita + "/") + nombre_foto, Server.MapPath("./" + ruta_fotos_visita + "/") + "temp" + nueva_foto);
                      }
                    catch (Exception ex)
                    {
                        String nueva_foto = nombre_foto_sin_visita_new + "A" + foto_split[3];
                        
                        indice = Int32.Parse(foto_split[3].Replace(".jpeg", ""));
                        File.Move(Server.MapPath("./" + ruta_fotos_visita + "/") + nombre_foto, Server.MapPath("./" + ruta_fotos_visita_new + "/") + nueva_foto);
                       
                        //File.Replace(Server.MapPath("./" + ruta_fotos_visita + "/") + nueva_foto, Server.MapPath("./" + ruta_fotos_visita + "/") + nombre_foto, Server.MapPath("./" + ruta_fotos_visita + "/") + "temp" + nueva_foto);
                    }


                }

            }

            
            
        }
        catch (Exception ex)
        {
            return false;
        }
        return true;  
    }

      
    public Boolean validar_fotos(String procedencia)
    {
        int total_fotos = 3;
        int mis_fotos = 0;

        switch(procedencia){
            case "1":
                total_fotos = 6;
                if (!image1.ImageUrl.Contains("sin_foto")) mis_fotos++;
                if (!image2.ImageUrl.Contains("sin_foto")) mis_fotos++;
                if (!image3.ImageUrl.Contains("sin_foto")) mis_fotos++;
                if (!image4.ImageUrl.Contains("sin_foto")) mis_fotos++;
                if (!image5.ImageUrl.Contains("sin_foto")) mis_fotos++;
                if (!image6.ImageUrl.Contains("sin_foto")) mis_fotos++;
                break;
            case "2":
                total_fotos = 3;
                if (!image1.ImageUrl.Contains("sin_foto")) mis_fotos++;
                if (!image2.ImageUrl.Contains("sin_foto")) mis_fotos++;
                if (!image3.ImageUrl.Contains("sin_foto")) mis_fotos++;
                break;
            default:
                total_fotos = 3;
                if (!image1.ImageUrl.Contains("sin_foto")) mis_fotos++;
                if (!image2.ImageUrl.Contains("sin_foto")) mis_fotos++;
                if (!image3.ImageUrl.Contains("sin_foto")) mis_fotos++;
                break;
        }        

        lb_cargadas.Text = mis_fotos + " de " + total_fotos + " fotos cargadas";

        if (mis_fotos == 0) return false;
        else return true;

    }

    public void cargarFoto()
    {
        
        String sin_fotos = new Uri(Server.MapPath("~/Imagenes/sin_foto.png")).AbsoluteUri;
        //String nombre_fotografia = id_proceso + "A" + servicio + "A" + cod_instalador + "A" + visita;
        String nombre_foto_sin_visita = id_proceso + "A" + servicio + "A" + cod_instalador;
        String ruta_fotos_visita = "FOTOS/" + visita + "/";
        String ruta_fotos_raiz = "FOTOS/";

        if (!Directory.Exists(Server.MapPath("./" + ruta_fotos_visita + "/"))) System.IO.Directory.CreateDirectory(Server.MapPath("./" + ruta_fotos_visita + "/"));

        MisFicherosVisita = new DirectoryInfo(Server.MapPath("./" + ruta_fotos_visita + "/")).GetFiles(nombre_foto_sin_visita + "*");
        MisFicheros = new DirectoryInfo(Server.MapPath("./" + ruta_fotos_raiz + "/")).GetFiles(nombre_foto_sin_visita + "*");

        Int32 indice = 0;
        incializaCampos();

        //OBTENEMOS LAS FOTOS QUE SE ENCUENTREN EN LA RAIZ COMO PRIMERA PASADA.
        if (MisFicheros.Length > 0)
        {      

            for (int i = 0; i < MisFicheros.Length; i++)
            {
                String nombre_foto = MisFicheros[i].Name;
                String ruta_completa = MisFicheros[i].FullName.Replace(Server.MapPath(""), "~");
                String[] foto_split = nombre_foto.Split('A'); //0: proceso, 1: servicio, 2: cod_instalador, 3: visita, 4: corr.jpeg                
                try {
                    indice = Int32.Parse(foto_split[4].Replace(".jpeg", ""));
                }
                catch (Exception ex)
                {
                    indice = Int32.Parse(foto_split[3].Replace(".jpeg", ""));
                }           

                if (nombre_foto.Contains("A" + servicio + "A") && nombre_foto.Contains(id_proceso + "A"))
                {
                    switch (indice)
                    {
                        case 1:
                            image1.Visible = true;
                            image1.ImageUrl = ResolveUrl(ruta_completa);
                            break;
                        case 2:
                            image2.Visible = true;
                            image2.ImageUrl = ResolveUrl(ruta_completa);
                            break;
                        case 3:
                            image3.Visible = true;
                            image3.ImageUrl = ResolveUrl(ruta_completa);
                            break;
                        case 4:
                            image4.Visible = true;
                            image4.ImageUrl = ResolveUrl(ruta_completa);
                            break;
                        case 5:
                            image5.Visible = true;
                            image5.ImageUrl = ResolveUrl(ruta_completa);
                            break;
                        case 6:
                            image6.Visible = true;
                            image6.ImageUrl = ResolveUrl(ruta_completa);
                            break;
                        case 7:
                            image1.Visible = true;
                            image1.ImageUrl = ResolveUrl(ruta_completa);
                            break;
                        case 8:
                            image2.Visible = true;
                            image2.ImageUrl = ResolveUrl(ruta_completa);
                            break;
                        case 9:
                            image3.Visible = true;
                            image3.ImageUrl = ResolveUrl(ruta_completa);
                            break;
                    }
                }

            }   
            
        }

        //OBTENEMOS LAS FOTOS QUE SE ENCUENTREN DEBIDAMENTE EN SUS CARPETAS DE VISITA, ESTO ES UN REPASO DE OBTENCIÓN DE FOTOS.
        if (MisFicherosVisita.Length > 0)
        {

            for (int i = 0; i < MisFicherosVisita.Length; i++)
            {
                String nombre_foto = MisFicherosVisita[i].Name;
                String ruta_completa = MisFicherosVisita[i].FullName.Replace(Server.MapPath(""), "~");
                String[] foto_split = nombre_foto.Split('A'); //0: proceso, 1: servicio, 2: cod_instalador, 3: visita, 4: corr.jpeg                
                try
                {
                    indice = Int32.Parse(foto_split[4].Replace(".jpeg", ""));
                }
                catch (Exception ex)
                {
                    indice = Int32.Parse(foto_split[3].Replace(".jpeg", ""));
                }

                if (nombre_foto.Contains("A" + servicio + "A") && nombre_foto.Contains(id_proceso + "A"))
                {
                    switch (indice)
                    {
                        case 1:
                            image1.Visible = true;
                            image1.ImageUrl = ResolveUrl(ruta_completa);
                            break;
                        case 2:
                            image2.Visible = true;
                            image2.ImageUrl = ResolveUrl(ruta_completa);
                            break;
                        case 3:
                            image3.Visible = true;
                            image3.ImageUrl = ResolveUrl(ruta_completa);
                            break;
                        case 4:
                            image4.Visible = true;
                            image4.ImageUrl = ResolveUrl(ruta_completa);
                            break;
                        case 5:
                            image5.Visible = true;
                            image5.ImageUrl = ResolveUrl(ruta_completa);
                            break;
                        case 6:
                            image6.Visible = true;
                            image6.ImageUrl = ResolveUrl(ruta_completa);
                            break;
                        case 7:
                            image1.Visible = true;
                            image1.ImageUrl = ResolveUrl(ruta_completa);
                            break;
                        case 8:
                            image2.Visible = true;
                            image2.ImageUrl = ResolveUrl(ruta_completa);
                            break;
                        case 9:
                            image3.Visible = true;
                            image3.ImageUrl = ResolveUrl(ruta_completa);
                            break;
                    }
                }

            }

        }

    }

    public void incializaCampos()
    {
        String sin_fotos = new Uri(Server.MapPath("~/Imagenes/sin_foto.png")).AbsoluteUri;
        image1.ImageUrl = sin_fotos;
        image2.ImageUrl = sin_fotos;
        image3.ImageUrl = sin_fotos;
        image4.ImageUrl = sin_fotos;
        image5.ImageUrl = sin_fotos;
        image6.ImageUrl = sin_fotos;
        image1.Visible = false;
        image2.Visible = false;
        image3.Visible = false;
        image4.Visible = false;
        image5.Visible = false;
        image6.Visible = false;
      
    }

    //IMG1
    protected void UploadImage1(object sender, EventArgs e)
    {
        if (FUI_1.HasFile)
        {
            String fileExtension = System.IO.Path.GetExtension(FUI_1.FileName).ToLower();
            String[] allowedExtensions = { ".jpeg", ".jpg" };

            if (fileExtension == allowedExtensions[0] || fileExtension == allowedExtensions[1])
            {
                string nombreArchivo;
                Random r = new Random();
                String random = r.Next(1, 1000).ToString();
                String corr = "1";
                String dir = "~/FOTOS/" + visita + "/";

                if (!atendido.Equals("1")) corr = "7";
                nombreArchivo = id_proceso + "A" + servicio + "A" + cod_instalador + "A" + visita + "A" + corr + "A" + random + ".jpeg";

                limpiar_foto_reemplazo(id_proceso,servicio,cod_instalador,visita,corr);
                if (System.IO.File.Exists(Server.MapPath(dir) + nombreArchivo))
                {
                    System.IO.File.Delete(Server.MapPath(dir) + nombreArchivo);
                    string saveDir = Server.MapPath(dir);
                    string SavePath = saveDir + Path.GetFileName(nombreArchivo);
                    Bitmap b2 = (Bitmap)Bitmap.FromStream(FUI_1.PostedFile.InputStream);
                    Bitmap b = new Bitmap(b2, 640, 480);
                    b.Save(SavePath, ImageFormat.Jpeg);
                    //FileUploadControlImg1.SaveAs(Server.MapPath("~/FOTOS/") + nombreArchivo);
                }
                else
                {
                    string saveDir = Server.MapPath(dir);
                    string SavePath = saveDir + Path.GetFileName(nombreArchivo);
                    Bitmap b2 = (Bitmap)Bitmap.FromStream(FUI_1.PostedFile.InputStream);
                    Bitmap b = new Bitmap(b2, 640, 480);
                    b.Save(SavePath, ImageFormat.Jpeg);
                    //FileUploadControlImg1.SaveAs(Server.MapPath("~/FOTOS/") + nombreArchivo);
                    registrar_edicion(servicio, orden_servicio,"REEMPLAZO FOTO " + corr);
                }

            }                

        }

        cargarFoto();
    }
    protected void UploadImage2(object sender, EventArgs e)
    {
        if (FUI_2.HasFile)
        {
            String fileExtension = System.IO.Path.GetExtension(FUI_2.FileName).ToLower();
            String[] allowedExtensions = { ".jpeg", ".jpg" };

            if (fileExtension == allowedExtensions[0] || fileExtension == allowedExtensions[1])
            {
                string nombreArchivo;
                Random r = new Random();
                String random = r.Next(1, 1000).ToString();
                String corr = "2";
                String dir = "~/FOTOS/" + visita + "/";

                if (!atendido.Equals("1")) corr = "8";
                nombreArchivo = id_proceso + "A" + servicio + "A" + cod_instalador + "A" + visita + "A" + corr + "A" + random + ".jpeg";

                limpiar_foto_reemplazo(id_proceso, servicio, cod_instalador, visita, corr);
                if (System.IO.File.Exists(Server.MapPath(dir) + nombreArchivo))
                {
                    System.IO.File.Delete(Server.MapPath(dir) + nombreArchivo);
                    string saveDir = Server.MapPath(dir);
                    string SavePath = saveDir + Path.GetFileName(nombreArchivo);
                    Bitmap b2 = (Bitmap)Bitmap.FromStream(FUI_2.PostedFile.InputStream);
                    Bitmap b = new Bitmap(b2, 640, 480);
                    b.Save(SavePath, ImageFormat.Jpeg);
                    //FileUploadControlImg1.SaveAs(Server.MapPath("~/FOTOS/") + nombreArchivo);
                }
                else
                {
                    string saveDir = Server.MapPath(dir);
                    string SavePath = saveDir + Path.GetFileName(nombreArchivo);
                    Bitmap b2 = (Bitmap)Bitmap.FromStream(FUI_2.PostedFile.InputStream);
                    Bitmap b = new Bitmap(b2, 640, 480);
                    b.Save(SavePath, ImageFormat.Jpeg);
                    //FileUploadControlImg1.SaveAs(Server.MapPath("~/FOTOS/") + nombreArchivo);
                    registrar_edicion(servicio, orden_servicio, "REEMPLAZO FOTO " + corr);
                }

            }

        }

        cargarFoto();
    }
    protected void UploadImage3(object sender, EventArgs e)
    {
        if (FUI_3.HasFile)
        {
            String fileExtension = System.IO.Path.GetExtension(FUI_3.FileName).ToLower();
            String[] allowedExtensions = { ".jpeg", ".jpg" };

            if (fileExtension == allowedExtensions[0] || fileExtension == allowedExtensions[1])
            {
                string nombreArchivo;
                Random r = new Random();
                String random = r.Next(1, 1000).ToString();
                String corr = "3";
                String dir = "~/FOTOS/" + visita + "/";

                if (!atendido.Equals("1")) corr = "9";
                nombreArchivo = id_proceso + "A" + servicio + "A" + cod_instalador + "A" + visita + "A" + corr + "A" + random + ".jpeg";

                limpiar_foto_reemplazo(id_proceso, servicio, cod_instalador, visita, corr);
                if (System.IO.File.Exists(Server.MapPath(dir) + nombreArchivo))
                {
                    System.IO.File.Delete(Server.MapPath(dir) + nombreArchivo);
                    string saveDir = Server.MapPath(dir);
                    string SavePath = saveDir + Path.GetFileName(nombreArchivo);
                    Bitmap b2 = (Bitmap)Bitmap.FromStream(FUI_3.PostedFile.InputStream);
                    Bitmap b = new Bitmap(b2, 640, 480);
                    b.Save(SavePath, ImageFormat.Jpeg);
                    //FileUploadControlImg1.SaveAs(Server.MapPath("~/FOTOS/") + nombreArchivo);
                }
                else
                {
                    string saveDir = Server.MapPath(dir);
                    string SavePath = saveDir + Path.GetFileName(nombreArchivo);
                    Bitmap b2 = (Bitmap)Bitmap.FromStream(FUI_3.PostedFile.InputStream);
                    Bitmap b = new Bitmap(b2, 640, 480);
                    b.Save(SavePath, ImageFormat.Jpeg);
                    //FileUploadControlImg1.SaveAs(Server.MapPath("~/FOTOS/") + nombreArchivo);
                    registrar_edicion(servicio, orden_servicio, "REEMPLAZO FOTO " + corr);
                }

            }

        }

        cargarFoto();
    }

    protected void UploadImage4(object sender, EventArgs e)
    {
        if (FUI_4.HasFile)
        {
            String fileExtension = System.IO.Path.GetExtension(FUI_4.FileName).ToLower();
            String[] allowedExtensions = { ".jpeg", ".jpg" };

            if (fileExtension == allowedExtensions[0] || fileExtension == allowedExtensions[1])
            {
                string nombreArchivo;
                Random r = new Random();
                String random = r.Next(1, 1000).ToString();
                String corr = "4";
                String dir = "~/FOTOS/" + visita + "/";

                nombreArchivo = id_proceso + "A" + servicio + "A" + cod_instalador + "A" + visita + "A" + corr + "A" + random + ".jpeg";

                limpiar_foto_reemplazo(id_proceso, servicio, cod_instalador, visita, corr);
                if (System.IO.File.Exists(Server.MapPath(dir) + nombreArchivo))
                {
                    System.IO.File.Delete(Server.MapPath(dir) + nombreArchivo);
                    string saveDir = Server.MapPath(dir);
                    string SavePath = saveDir + Path.GetFileName(nombreArchivo);
                    Bitmap b2 = (Bitmap)Bitmap.FromStream(FUI_4.PostedFile.InputStream);
                    Bitmap b = new Bitmap(b2, 640, 480);
                    b.Save(SavePath, ImageFormat.Jpeg);
                    //FileUploadControlImg1.SaveAs(Server.MapPath("~/FOTOS/") + nombreArchivo);
                }
                else
                {
                    string saveDir = Server.MapPath(dir);
                    string SavePath = saveDir + Path.GetFileName(nombreArchivo);
                    Bitmap b2 = (Bitmap)Bitmap.FromStream(FUI_4.PostedFile.InputStream);
                    Bitmap b = new Bitmap(b2, 640, 480);
                    b.Save(SavePath, ImageFormat.Jpeg);
                    //FileUploadControlImg1.SaveAs(Server.MapPath("~/FOTOS/") + nombreArchivo);
                    registrar_edicion(servicio, orden_servicio, "REEMPLAZO FOTO " + corr);
                }

            }

        }

        cargarFoto();
    }
    protected void UploadImage5(object sender, EventArgs e)
    {
        if (FUI_5.HasFile)
        {
            String fileExtension = System.IO.Path.GetExtension(FUI_5.FileName).ToLower();
            String[] allowedExtensions = { ".jpeg", ".jpg" };

            if (fileExtension == allowedExtensions[0] || fileExtension == allowedExtensions[1])
            {
                string nombreArchivo;
                Random r = new Random();
                String random = r.Next(1, 1000).ToString();
                String corr = "5";
                String dir = "~/FOTOS/" + visita + "/";

                nombreArchivo = id_proceso + "A" + servicio + "A" + cod_instalador + "A" + visita + "A" + corr + "A" + random + ".jpeg";

                limpiar_foto_reemplazo(id_proceso, servicio, cod_instalador, visita, corr);
                if (System.IO.File.Exists(Server.MapPath(dir) + nombreArchivo))
                {
                    System.IO.File.Delete(Server.MapPath(dir) + nombreArchivo);
                    string saveDir = Server.MapPath(dir);
                    string SavePath = saveDir + Path.GetFileName(nombreArchivo);
                    Bitmap b2 = (Bitmap)Bitmap.FromStream(FUI_5.PostedFile.InputStream);
                    Bitmap b = new Bitmap(b2, 640, 480);
                    b.Save(SavePath, ImageFormat.Jpeg);
                    //FileUploadControlImg1.SaveAs(Server.MapPath("~/FOTOS/") + nombreArchivo);
                }
                else
                {
                    string saveDir = Server.MapPath(dir);
                    string SavePath = saveDir + Path.GetFileName(nombreArchivo);
                    Bitmap b2 = (Bitmap)Bitmap.FromStream(FUI_5.PostedFile.InputStream);
                    Bitmap b = new Bitmap(b2, 640, 480);
                    b.Save(SavePath, ImageFormat.Jpeg);
                    //FileUploadControlImg1.SaveAs(Server.MapPath("~/FOTOS/") + nombreArchivo);
                    registrar_edicion(servicio, orden_servicio, "REEMPLAZO FOTO " + corr);
                }

            }

        }

        cargarFoto();
    }
    protected void UploadImage6(object sender, EventArgs e)
    {
        if (FUI_6.HasFile)
        {
            String fileExtension = System.IO.Path.GetExtension(FUI_6.FileName).ToLower();
            String[] allowedExtensions = { ".jpeg", ".jpg" };

            if (fileExtension == allowedExtensions[0] || fileExtension == allowedExtensions[1])
            {
                string nombreArchivo;
                Random r = new Random();
                String random = r.Next(1, 1000).ToString();
                String corr = "6";
                String dir = "~/FOTOS/" + visita + "/";

                nombreArchivo = id_proceso + "A" + servicio + "A" + cod_instalador + "A" + visita + "A" + corr + "A" + random + ".jpeg";

                limpiar_foto_reemplazo(id_proceso, servicio, cod_instalador, visita, corr);
                if (System.IO.File.Exists(Server.MapPath(dir) + nombreArchivo))
                {
                    System.IO.File.Delete(Server.MapPath(dir) + nombreArchivo);
                    string saveDir = Server.MapPath(dir);
                    string SavePath = saveDir + Path.GetFileName(nombreArchivo);
                    Bitmap b2 = (Bitmap)Bitmap.FromStream(FUI_6.PostedFile.InputStream);
                    Bitmap b = new Bitmap(b2, 640, 480);
                    b.Save(SavePath, ImageFormat.Jpeg);
                    //FileUploadControlImg1.SaveAs(Server.MapPath("~/FOTOS/") + nombreArchivo);
                }
                else
                {
                    string saveDir = Server.MapPath(dir);
                    string SavePath = saveDir + Path.GetFileName(nombreArchivo);
                    Bitmap b2 = (Bitmap)Bitmap.FromStream(FUI_6.PostedFile.InputStream);
                    Bitmap b = new Bitmap(b2, 640, 480);
                    b.Save(SavePath, ImageFormat.Jpeg);
                    //FileUploadControlImg1.SaveAs(Server.MapPath("~/FOTOS/") + nombreArchivo);
                    registrar_edicion(servicio, orden_servicio, "REEMPLAZO FOTO " + corr);
                }

            }

        }

        cargarFoto();
    }
    
    protected void limpiar_foto_reemplazo(string proceso, string serv, string cod_instalador,string visita, string pos)
    {
        if (inicio || pos.Length > 0)
        {
            try
            {
                String sin_fotos = new Uri(Server.MapPath("~/Imagenes/sin_foto.png")).AbsoluteUri;
                String nombre_fotografia = proceso + "A" + serv + "A" + cod_instalador + "A" + visita + "A" + pos;
                String ruta_fotos_procesada = "FOTOS/" + visita + "/";
                String ruta_fotos_sin_proceso = "FOTOS/";
                String[] mis_fotos_procesadas;

                if (!Directory.Exists(Server.MapPath("./" + ruta_fotos_procesada + "/"))) System.IO.Directory.CreateDirectory(Server.MapPath("./" + ruta_fotos_procesada + "/"));

                //Obtenemos los nombres de las fotos que tenga el servicio en su carpeta procesada.
                mis_fotos_procesadas = Directory.GetFiles(Server.MapPath("./" + ruta_fotos_procesada), nombre_fotografia + "*");

                if (mis_fotos_procesadas.Length > 0) MisFicheros = new DirectoryInfo(Server.MapPath("./" + ruta_fotos_procesada + "/")).GetFiles(nombre_fotografia + "*");
                else MisFicheros = new DirectoryInfo(Server.MapPath("./" + ruta_fotos_sin_proceso + "/")).GetFiles(nombre_fotografia + "*");


                if (MisFicheros.Length == 0)
                {

                }
                else
                {

                    for (int i = 0; i < MisFicheros.Length; i++)
                    {

                        MisFicheros[i].Delete();

                    }
                }

                inicio = false;

            }
            catch (Exception ex)
            {
                lb_avance.Text = ex.Message;
            }

        }
    }

    public bool validarRut(string rut)
    {

        bool validacion = false;
        try
        {
            rut = rut.ToUpper();
            rut = rut.Replace(".", "");
            rut = rut.Replace("-", "");
            int rutAux = int.Parse(rut.Substring(0, rut.Length - 1));

            char dv = char.Parse(rut.Substring(rut.Length - 1, 1));

            int m = 0, s = 1;
            for (; rutAux != 0; rutAux /= 10)
            {
                s = (s + rutAux % 10 * (9 - m++ % 6)) % 11;
            }
            if (dv == (char)(s != 0 ? s + 47 : 75))
            {
                validacion = true;
            }
        }
        catch (Exception)
        {
        }
        return validacion;
    }    
   
    
    protected void btn_confirmar_Click(object sender, EventArgs e)
    {        
        formulario.Visible = true;
        subir_fotos.Visible = false;
        validar_fotos(atendido);
    }
   
    protected void btn_fotos_Click(object sender, EventArgs e)
    {
        subir_fotos.Visible = true;
        formulario.Visible = false;        
        limpiar_foto_reemplazo(id_proceso,servicio,cod_instalador,visita,"");
        cargarFoto();
    }

    protected void btn_guardar_Click(object sender, EventArgs e)
    {       
        if (!validar_fotos(atendido)) lb_avance.Text = "Debe subir al menos 1 foto";
        else if (!validar_formulario(atendido))
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + lb_avance.Text + "');", true);
           
            //ingreso mensaje desde metodo.
        }
        else
        {
            if (existen_cambios()) //HAY CAMBIOS ??? SI NO, NO GUARDA.
            {
                lb_avance.Text = "";
                guardar_completo("guardar");
            }
            else
            {
                lb_avance.Text = "No se ha detectado ningún cambio respecto a la información existente de la orden.";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + lb_avance.Text + "');", true);
           
            }
         
        }

    }
    protected void btn_volver_Click(object sender, EventArgs e)
    {        
        Response.Write("<script>window.close()</script>");
    }  
   
   
    public Boolean registrar_edicion(String servicio, String orden_servicio,String cambio)
    {
        //String orden_servicio_new;
        String marca_ret, serie_ret, agno_ret, lectura_ret;


        //ESPECIAL Y MAP RETIRADO
        //SI ESTÁ CHECK EL CAMBIO DE ORDEN ALMACENAMOS EL CAMPO DE LA ORDEN NUEVA, SINO MANTENEMOS EL EXISTENTE.
        //if (check_nro_orden.Checked) orden_servicio_new = tb_orden_servicio.Text;
        //else orden_servicio_new = orden_servicio;


        marca_ret = mi_orden.Rows[0]["MARCA_RET"].ToString();
        serie_ret = mi_orden.Rows[0]["SERIE_RET"].ToString();
        agno_ret = mi_orden.Rows[0]["AGNO_RET"].ToString();

        for (int i = marca_ret.Length; i < 3; i++)
        {
            marca_ret = "0" + marca_ret;
        }

        for (int i = agno_ret.Length; i < 4; i++)
        {
            agno_ret = "0" + agno_ret;
        }

        for (int i = serie_ret.Length; i < 10; i++)
        {
            serie_ret = "0" + serie_ret;
        }
     

        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter ComandoDA;

        objConexion.Open();
        ComandoDA = new OracleDataAdapter("PK_FORMULARIO.REGISTRAR_EDICION", objConexion);
        ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

        //DEJAMOS LOS DATOS ANTES DEL UPDATE.
        PRO.agrega_parametro_sp(ComandoDA, "i_id_servicio", OracleType.Number, ParameterDirection.Input, servicio);
        PRO.agrega_parametro_sp(ComandoDA, "i_orden_servicio", OracleType.Number, ParameterDirection.Input, orden_servicio);
        PRO.agrega_parametro_sp(ComandoDA, "i_visita", OracleType.Number, ParameterDirection.Input, visita);
        PRO.agrega_parametro_sp(ComandoDA, "i_id_proceso", OracleType.Number, ParameterDirection.Input, id_proceso);
        PRO.agrega_parametro_sp(ComandoDA, "i_marca_nu", OracleType.NVarChar, ParameterDirection.Input, mi_orden.Rows[0]["MARCA_NU"].ToString());
        PRO.agrega_parametro_sp(ComandoDA, "i_diametro_nu", OracleType.NVarChar, ParameterDirection.Input, mi_orden.Rows[0]["DIAMETRO_NU"].ToString());
        PRO.agrega_parametro_sp(ComandoDA, "i_serie_nu", OracleType.NVarChar, ParameterDirection.Input, mi_orden.Rows[0]["SERIE_NU"].ToString());
        PRO.agrega_parametro_sp(ComandoDA, "i_instalacion_varal", OracleType.NVarChar, ParameterDirection.Input, mi_orden.Rows[0]["INSTALACION_VARAL"].ToString());
        PRO.agrega_parametro_sp(ComandoDA, "i_instalacion_llave", OracleType.NVarChar, ParameterDirection.Input, mi_orden.Rows[0]["INSTALACION_LLAVE"].ToString());
        PRO.agrega_parametro_sp(ComandoDA, "i_tiposello", OracleType.NVarChar, ParameterDirection.Input, mi_orden.Rows[0]["TIPOSELLO"].ToString());
        PRO.agrega_parametro_sp(ComandoDA, "i_num_sello", OracleType.NVarChar, ParameterDirection.Input, mi_orden.Rows[0]["NUM_SELLO"].ToString());
        PRO.agrega_parametro_sp(ComandoDA, "i_agno_nu", OracleType.NVarChar, ParameterDirection.Input, mi_orden.Rows[0]["AGNO_NU"].ToString());
        PRO.agrega_parametro_sp(ComandoDA, "i_lectura_nu", OracleType.NVarChar, ParameterDirection.Input, mi_orden.Rows[0]["LECTURA_NU"].ToString());
        PRO.agrega_parametro_sp(ComandoDA, "i_material_varal", OracleType.NVarChar, ParameterDirection.Input, mi_orden.Rows[0]["MATERIAL_VARAL"].ToString());
        PRO.agrega_parametro_sp(ComandoDA, "i_tipo_llave", OracleType.NVarChar, ParameterDirection.Input, mi_orden.Rows[0]["TIPO_LLAVE"].ToString());
        PRO.agrega_parametro_sp(ComandoDA, "i_color_sello", OracleType.NVarChar, ParameterDirection.Input, mi_orden.Rows[0]["COLOR_SELLO"].ToString());
        PRO.agrega_parametro_sp(ComandoDA, "i_fecha_ejecucion", OracleType.NVarChar, ParameterDirection.Input, mi_orden.Rows[0]["FECHA_EJECUCION"].ToString().Substring(0,10));
        PRO.agrega_parametro_sp(ComandoDA, "i_hora_ejecucion", OracleType.NVarChar, ParameterDirection.Input, mi_orden.Rows[0]["HORA_EJECUCION"].ToString());
        PRO.agrega_parametro_sp(ComandoDA, "i_cod_instalador", OracleType.Number, ParameterDirection.Input, mi_orden.Rows[0]["COD_INSTALADOR"].ToString());
        PRO.agrega_parametro_sp(ComandoDA, "i_cod_contratista", OracleType.Number, ParameterDirection.Input, mi_orden.Rows[0]["COD_CONTRATISTA"].ToString());
        PRO.agrega_parametro_sp(ComandoDA, "i_observacion", OracleType.NVarChar, ParameterDirection.Input, mi_orden.Rows[0]["OBSERVACION"].ToString());
        PRO.agrega_parametro_sp(ComandoDA, "i_nombre_contacto", OracleType.NVarChar, ParameterDirection.Input, mi_orden.Rows[0]["NOMBRE_CONTACTO"].ToString());
        PRO.agrega_parametro_sp(ComandoDA, "i_rut_contacto", OracleType.NVarChar, ParameterDirection.Input, mi_orden.Rows[0]["RUT_CONTACTO"].ToString());
        PRO.agrega_parametro_sp(ComandoDA, "i_usuario_alteracion", OracleType.Number, ParameterDirection.Input, lb_id_usuario.Text);
        PRO.agrega_parametro_sp(ComandoDA, "i_cambio", OracleType.NVarChar, ParameterDirection.Input, cambio);
        //PRO.agrega_parametro_sp(ComandoDA, "i_nueva_orden", OracleType.NVarChar, ParameterDirection.Input, orden_servicio_new); //SI ESTA CHECK HABILITA NUEVA ORDEN, SINO MANTIENE LA ORIGINAL.
        PRO.agrega_parametro_sp(ComandoDA, "i_diametro_ret", OracleType.NVarChar, ParameterDirection.Input, mi_orden.Rows[0]["DIAMETRO_RET"].ToString());
        PRO.agrega_parametro_sp(ComandoDA, "i_serie_ret", OracleType.NVarChar, ParameterDirection.Input, (marca_ret + agno_ret + serie_ret));
        PRO.agrega_parametro_sp(ComandoDA, "i_lectura_ret", OracleType.NVarChar, ParameterDirection.Input, mi_orden.Rows[0]["LECTURA_RET"].ToString());
        PRO.agrega_parametro_sp(ComandoDA, "i_cod_improcedencia", OracleType.Number, ParameterDirection.Input, cod_improcedencia);

        try
        {
            ComandoDA.SelectCommand.ExecuteNonQuery();
            objConexion.Close();
            return true;
        }
        catch (Exception ex)
        {
            objConexion.Close();
            return false;
        }

    }

    public Boolean valida_nueva_orden(String orden)
    {        
        try
        {
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();

            objConexion.Open();
            objComando = new OracleDataAdapter("PK_FORMULARIO.VALIDA_NUEVA_ORDEN", objConexion);
            objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

            PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
            PRO.agrega_parametro_sp(objComando, "i_orden_servicio", OracleType.Number, ParameterDirection.Input, orden);

            objComando.SelectCommand.ExecuteNonQuery();

            objComando.Fill(objDS, "VALIDA");
            objConexion.Close();
                  

            foreach (DataRow row in objDS.Tables["VALIDA"].Rows)
            {
                if (row[0].ToString().Equals("0"))
                {
                    return true; //SE PUEDE CAMBIAR.
                }
            }
           
        }
        catch (Exception ex)
        {
            return false;
        }

        return false;
    }

    //protected void check_nro_orden_CheckedChanged1(object sender, EventArgs e)
    //{
    //    if (check_nro_orden.Checked) tb_orden_servicio.Enabled = true;
    //    else tb_orden_servicio.Enabled = false;
    //}
    protected void check_con_firma_CheckedChanged1(object sender, EventArgs e)
    {
        if (check_con_firma.Checked) tr_no_aplica5.Visible = true;
        else
        {
            tr_no_aplica5.Visible = false;
        }
    }
    protected void btn_enviar_otro_Click(object sender, EventArgs e)
    {
        mi_formulario.Visible = false;
        traspaso_info.Visible = true;                      
    }
    protected void btn_traspasar_informacion_Click(object sender, EventArgs e)
    {
        String resultado_origen = valida_traspaso(lb_nro_orden.Text, lb_servicio.Text, lb_visita.Text,"ORIGEN");

        if (resultado_origen.Equals("OK"))
        {
            String visita = get_visita(tb_nueva_orden.Text,tb_nuevo_servicio.Text);
            String resultado_destino = valida_traspaso(tb_nueva_orden.Text, tb_nuevo_servicio.Text,visita, "DESTINO");

            if (resultado_destino.Equals("OK"))
            {
                traspasar_info(lb_nro_orden.Text, lb_servicio.Text, tb_nueva_orden.Text, tb_nuevo_servicio.Text);
                
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + resultado_destino + "');", true);
           
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + resultado_origen + "');", true);
           
        }
    }

    public String valida_traspaso(String orden, String servicio,String visita,String tipo)
    {
        String mi_resultado = "";
        if (tipo.Equals("DESTINO"))
        {       
            //VALIDAMOS QUE NO VENGAN VACIOS Y SEAN NÚMEROS.
            if (orden.Length == 0 || servicio.Length == 0) return "DEBE INGRESAR UN NÚMERO DE ORDEN Y DE SERVICIO";

            //VALIDAMOS QUE SEAN NÚMEROS LOS VALORES.
            long nro;
            if (!long.TryParse(orden, out nro) || !long.TryParse(servicio, out nro)) return "DEBE INGRESAR VALORES NÚMERICOS";
        }       

        //VALIDAMOS QUE EXISTA LA ORDEN CON TAL SERVICIO EN PROCESO Y NO ESTÉ EJECUTADA.
        try
        {
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();

            objConexion.Open();
            objComando = new OracleDataAdapter("PK_FORMULARIO.VALIDA_TRASPASO_ORDEN", objConexion);
            objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

            PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
            PRO.agrega_parametro_sp(objComando, "i_orden_servicio", OracleType.Number, ParameterDirection.Input, orden);
            PRO.agrega_parametro_sp(objComando, "i_servicio", OracleType.Number, ParameterDirection.Input, servicio);
            PRO.agrega_parametro_sp(objComando, "i_visita", OracleType.NVarChar, ParameterDirection.Input, visita);
            PRO.agrega_parametro_sp(objComando, "i_tipo", OracleType.NVarChar, ParameterDirection.Input, tipo);

            objComando.SelectCommand.ExecuteNonQuery();

            objComando.Fill(objDS, "VALIDA");
            objConexion.Close();

            foreach (DataRow row in objDS.Tables["VALIDA"].Rows)
            {
               mi_resultado = row[0].ToString();
            }

        }
        catch (Exception ex)
        {
            return "ERROR: " + ex.Message;
        }

        if (tipo.Equals("DESTINO"))
        {
            if (mi_resultado.Equals("0")) return "NO EXISTE UNA ORDEN DE DESTINO EN PROCESO SIN DESCARGAR CON EL NRO: " + orden + " Y EL SERVICIO: " + servicio;
            else return "OK";
        }
        else
        {
            if (mi_resultado.Equals("0")) return "LA ORDEN DE ORIGEN NO SE ENCUENTRA EN PROCESO CON DESCARGA, SÓLO SE PERMITEN ORDENES EN ESTADO DESCARGADA Y EN PROCESO";
            else return "OK";
        }
    }

    public void traspasar_info(String old_orden, String old_servicio, String new_orden, String new_servicio)
    {
        //ETAPA MEDIDOR INSTALADO
        String marca_nu, diametro_nu, serie_nu, instalacion_varal_nu, instalacion_llave_nu, tipo_sello_nu, num_sello_nu;
        String agno_nu, lectura_nu, material_varal_nu, tipo_llave_nu, color_sello_nu;
        //ETAPA ANTECEDENTES CLIENTE Y OBSERVACION
        String nombre_cliente, fecha_ejecucion, instalador, rut_cliente, hora_ejecucion, contratista, observacion;
        //ESPECIAL Y MAP RETIRADO
        String marca_ret, diametro_ret, serie_ret, lectura_ret, agno_ret;


        //ASIGNACION
        //ETAPA MEDIDOR INSTALADO
        marca_nu = cb_marca_nuevo.SelectedValue;
        diametro_nu = cb_diametro_nuevo.SelectedValue;
        serie_nu = tb_serie_nuevo.Text;
        instalacion_varal_nu = cb_instalacion_varal_nuevo.SelectedValue;
        instalacion_llave_nu = cb_instalacion_llave_nuevo.SelectedValue;
        tipo_sello_nu = cb_tipo_sello_nuevo.SelectedValue;
        num_sello_nu = tb_numero_sello_nuevo.Text;
        agno_nu = tb_año_nuevo.Text;
        lectura_nu = tb_lectura_nuevo.Text;
        material_varal_nu = cb_material_nuevo.SelectedValue;
        tipo_llave_nu = cb_tipo_llave_nuevo.SelectedValue;
        color_sello_nu = cb_color_sello_nuevo.SelectedValue;

        //ETAPA 2
        if (check_con_firma.Checked)
        {
            nombre_cliente = tb_nombre_cliente.Text;
            rut_cliente = tb_rut_cliente.Text;
        }
        else
        {
            nombre_cliente = "";
            rut_cliente = "";
        }

        fecha_ejecucion = tb_fecha.Text;
        instalador = cb_instalador.SelectedValue;
        hora_ejecucion = tb_hora.Text;
        contratista = cb_contratista.SelectedValue;
        observacion = tb_observacion.Text;
           
        diametro_ret = cb_diametro_ret.SelectedValue;
        marca_ret = cb_marca_ret.SelectedValue;
        serie_ret = tb_serie_ret.Text;
        agno_ret = tb_año_ret.Text;
        lectura_ret = tb_lectura_ret.Text;

        for (int i = marca_ret.Length; i < 3; i++)
        {
            marca_ret = "0" + marca_ret;
        }

        for (int i = agno_ret.Length; i < 4; i++)
        {
            agno_ret = "0" + agno_ret;
        }

        for (int i = serie_ret.Length; i < 10; i++)
        {
            serie_ret = "0" + serie_ret;
        }

        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter ComandoDA;

        objConexion.Open();
        ComandoDA = new OracleDataAdapter("PK_FORMULARIO.TRASPASAR_INFO", objConexion);
        ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;
        PRO.agrega_parametro_sp(ComandoDA, "i_id_servicio", OracleType.Number, ParameterDirection.Input, servicio);
        PRO.agrega_parametro_sp(ComandoDA, "i_orden_servicio", OracleType.Number, ParameterDirection.Input, orden_servicio);
        PRO.agrega_parametro_sp(ComandoDA, "i_visita", OracleType.Number, ParameterDirection.Input, visita);
        PRO.agrega_parametro_sp(ComandoDA, "i_id_proceso", OracleType.Number, ParameterDirection.Input, id_proceso);
        PRO.agrega_parametro_sp(ComandoDA, "i_marca_nu", OracleType.NVarChar, ParameterDirection.Input, marca_nu);
        PRO.agrega_parametro_sp(ComandoDA, "i_diametro_nu", OracleType.NVarChar, ParameterDirection.Input, diametro_nu);
        PRO.agrega_parametro_sp(ComandoDA, "i_serie_nu", OracleType.NVarChar, ParameterDirection.Input, serie_nu);
        PRO.agrega_parametro_sp(ComandoDA, "i_instalacion_varal", OracleType.NVarChar, ParameterDirection.Input, instalacion_varal_nu);
        PRO.agrega_parametro_sp(ComandoDA, "i_instalacion_llave", OracleType.NVarChar, ParameterDirection.Input, instalacion_llave_nu);
        PRO.agrega_parametro_sp(ComandoDA, "i_tiposello", OracleType.NVarChar, ParameterDirection.Input, tipo_sello_nu);
        PRO.agrega_parametro_sp(ComandoDA, "i_num_sello", OracleType.NVarChar, ParameterDirection.Input, num_sello_nu);
        PRO.agrega_parametro_sp(ComandoDA, "i_agno_nu", OracleType.NVarChar, ParameterDirection.Input, agno_nu);
        PRO.agrega_parametro_sp(ComandoDA, "i_lectura_nu", OracleType.NVarChar, ParameterDirection.Input, lectura_nu);
        PRO.agrega_parametro_sp(ComandoDA, "i_material_varal", OracleType.NVarChar, ParameterDirection.Input, material_varal_nu);
        PRO.agrega_parametro_sp(ComandoDA, "i_tipo_llave", OracleType.NVarChar, ParameterDirection.Input, tipo_llave_nu);
        PRO.agrega_parametro_sp(ComandoDA, "i_color_sello", OracleType.NVarChar, ParameterDirection.Input, color_sello_nu);
        PRO.agrega_parametro_sp(ComandoDA, "i_fecha_ejecucion", OracleType.NVarChar, ParameterDirection.Input, fecha_ejecucion);
        PRO.agrega_parametro_sp(ComandoDA, "i_hora_ejecucion", OracleType.NVarChar, ParameterDirection.Input, hora_ejecucion);
        PRO.agrega_parametro_sp(ComandoDA, "i_cod_instalador", OracleType.Number, ParameterDirection.Input, instalador);
        PRO.agrega_parametro_sp(ComandoDA, "i_cod_contratista", OracleType.Number, ParameterDirection.Input, contratista);
        PRO.agrega_parametro_sp(ComandoDA, "i_observacion", OracleType.NVarChar, ParameterDirection.Input, observacion);
        PRO.agrega_parametro_sp(ComandoDA, "i_nombre_contacto", OracleType.NVarChar, ParameterDirection.Input, nombre_cliente);
        PRO.agrega_parametro_sp(ComandoDA, "i_rut_contacto", OracleType.NVarChar, ParameterDirection.Input, rut_cliente);
         PRO.agrega_parametro_sp(ComandoDA, "i_diametro_ret", OracleType.NVarChar, ParameterDirection.Input, diametro_ret);
        PRO.agrega_parametro_sp(ComandoDA, "i_serie_ret", OracleType.NVarChar, ParameterDirection.Input, (marca_ret + agno_ret + serie_ret));
        PRO.agrega_parametro_sp(ComandoDA, "i_lectura_ret", OracleType.NVarChar, ParameterDirection.Input, lectura_ret);
        PRO.agrega_parametro_sp(ComandoDA, "i_cod_improcedencia", OracleType.Number, ParameterDirection.Input, cod_improcedencia);
        PRO.agrega_parametro_sp(ComandoDA, "i_new_orden", OracleType.Number, ParameterDirection.Input, new_orden);
        PRO.agrega_parametro_sp(ComandoDA, "i_new_servicio", OracleType.Number, ParameterDirection.Input, new_servicio);

        try
        {

            if (registrar_edicion(servicio, orden_servicio, "TRASPASO DE INFO A ORDEN: " + new_orden + ", SERVICIO: " + new_servicio))
            {
                ComandoDA.SelectCommand.ExecuteNonQuery();
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_ok('TRASPASO DE INFORMACIÓN REALIZADA!','SE HAN GUARDADO CORRECTAMENTE LOS CAMBIOS');", true);
                String new_id_proceso = get_id_proceso(new_orden, new_servicio);
                String new_visita = get_visita(new_orden, new_servicio);
                //SE ACTUALIZAN FOTOS DEBIDO A CAMBIO DE COD INSTALADOR.
                if (!instalador.Equals(mi_orden.Rows[0]["COD_INSTALADOR"].ToString()))
                {
                    
                    renombrar_fotos(id_proceso, new_id_proceso, servicio, new_servicio, new_visita, "", mi_orden.Rows[0]["COD_INSTALADOR"].ToString(), instalador);
                    cod_instalador = instalador;
                    id_proceso = new_id_proceso;
                    servicio = new_servicio;
                    orden_servicio = new_orden;
                }
                else
                {
                    renombrar_fotos(id_proceso, new_id_proceso, servicio, new_servicio, new_visita, "", mi_orden.Rows[0]["COD_INSTALADOR"].ToString(), "");                    
                    id_proceso = new_id_proceso;
                    servicio = new_servicio;
                    orden_servicio = new_orden;
                }
                
                //Response.Write("<script>window.close()</script>");
                cargar_datos(servicio, orden_servicio, visita);
                mi_formulario.Visible = true;
                traspaso_info.Visible = false;
            }
            else
            {
                lb_avance.Text = "No se pudo registrar la edición de la orden, favor volver a intentar";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + lb_avance.Text + "');", true);
                
            }

            objConexion.Close();

        }
        catch (Exception ex)
        {
            lb_avance.Text = "Error: " + ex.Message;
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + lb_avance.Text + "');", true);
                
        }

    }

    public String get_id_proceso(String orden, String servicio)
    {
        String codigo = "";
        try
        {
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();

            objConexion.Open();
            objComando = new OracleDataAdapter("PK_FORMULARIO.GET_ID_PROCESO", objConexion);
            objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

            PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
            PRO.agrega_parametro_sp(objComando, "i_orden_servicio", OracleType.Number, ParameterDirection.Input, orden);
            PRO.agrega_parametro_sp(objComando, "i_servicio", OracleType.Number, ParameterDirection.Input, servicio);

            objComando.SelectCommand.ExecuteNonQuery();

            objComando.Fill(objDS, "ID_PROCESO");
            objConexion.Close();

            //String SQL = "SELECT EO.ATENDIDO,O.COD_IMPROCEDENCIA FROM ORDEN O JOIN ESTATUS_ORDEN EO ON EO.COD_ESTATUS_ORDEN = O.COD_IMPROCEDENCIA WHERE O.NUMERO_ORDEN = " + orden + " AND O.ID_SERVICIO = " + servicio + " AND O.VISITA = " + visita;
            //SQL = SQL + "UNION ALL SELECT EO.ATENDIDO,O.COD_IMPROCEDENCIA FROM ORDEN_HISTORICOS O JOIN ESTATUS_ORDEN EO ON EO.COD_ESTATUS_ORDEN = O.COD_IMPROCEDENCIA WHERE O.NUMERO_ORDEN = " + orden + " AND O.ID_SERVICIO = " + servicio + " AND O.VISITA = " + visita;

            //objConexion.Open();
            //objComando = new OracleDataAdapter(SQL, objConexion);
            //objComando.SelectCommand.CommandType = CommandType.Text;

            //objComando.SelectCommand.ExecuteNonQuery();
            //objComando.Fill(objDS, "PROCEDENCIA");
            //objConexion.Close();


            foreach (DataRow row in objDS.Tables["ID_PROCESO"].Rows)
            {
                codigo = row[0].ToString();
            }
            return codigo;
        }
        catch (Exception ex)
        {
            return codigo;
        }

    }

    public String get_visita(String orden, String servicio)
    {
        String codigo = "";
        try
        {
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();

            objConexion.Open();
            objComando = new OracleDataAdapter("PK_FORMULARIO.GET_VISITA", objConexion);
            objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

            PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
            PRO.agrega_parametro_sp(objComando, "i_orden_servicio", OracleType.Number, ParameterDirection.Input, orden);
            PRO.agrega_parametro_sp(objComando, "i_servicio", OracleType.Number, ParameterDirection.Input, servicio);

            objComando.SelectCommand.ExecuteNonQuery();

            objComando.Fill(objDS, "VISITA");
            objConexion.Close();

            //String SQL = "SELECT EO.ATENDIDO,O.COD_IMPROCEDENCIA FROM ORDEN O JOIN ESTATUS_ORDEN EO ON EO.COD_ESTATUS_ORDEN = O.COD_IMPROCEDENCIA WHERE O.NUMERO_ORDEN = " + orden + " AND O.ID_SERVICIO = " + servicio + " AND O.VISITA = " + visita;
            //SQL = SQL + "UNION ALL SELECT EO.ATENDIDO,O.COD_IMPROCEDENCIA FROM ORDEN_HISTORICOS O JOIN ESTATUS_ORDEN EO ON EO.COD_ESTATUS_ORDEN = O.COD_IMPROCEDENCIA WHERE O.NUMERO_ORDEN = " + orden + " AND O.ID_SERVICIO = " + servicio + " AND O.VISITA = " + visita;

            //objConexion.Open();
            //objComando = new OracleDataAdapter(SQL, objConexion);
            //objComando.SelectCommand.CommandType = CommandType.Text;

            //objComando.SelectCommand.ExecuteNonQuery();
            //objComando.Fill(objDS, "PROCEDENCIA");
            //objConexion.Close();


            foreach (DataRow row in objDS.Tables["VISITA"].Rows)
            {
                codigo = row[0].ToString();
            }
            return codigo;
        }
        catch (Exception ex)
        {
            return codigo;
        }

    }

    protected void btn_volver_formulario_Click(object sender, EventArgs e)
    {
        mi_formulario.Visible = true;
        traspaso_info.Visible = false;  
    }
}