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

public partial class Operadores : System.Web.UI.Page
{

    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();
    FileInfo[] MisFicheros, MisFicherosVisita;

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
                lb_id_contratista.Text = PRO.recSession(rutaXml, "ID_CONTRATISTA");

                carga_grilla(tb_busqueda.Text, cb_filtro_busqueda.SelectedValue, lb_id_usuario.Text,lb_id_contratista.Text);

            }
            catch (Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }
        }
       
    }
    protected void cb_filtro_busqueda_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla(tb_busqueda.Text, cb_filtro_busqueda.SelectedValue, lb_id_usuario.Text, lb_id_contratista.Text);

    }
    protected void tb_busqueda_TextChanged(object sender, EventArgs e)
    {
        carga_grilla(tb_busqueda.Text, cb_filtro_busqueda.SelectedValue, lb_id_usuario.Text, lb_id_contratista.Text);

    }
   
    protected void gridOrden_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            var colsNoVisible = gridOrden.DataKeys[gridOrden.SelectedIndex].Values;
            String id_operador;

            id_operador = (string)colsNoVisible[0];
            rescate_id_operador.Text = id_operador;
            main.Visible = false;
            agregar.Visible = true;
            inicializar_campos();
            cargar_operador(id_operador);
            btn_guardar.Text = "MODIFICAR OPERADOR";
            
        }
        catch (Exception ex)
        {

        }

    }

    protected void btn_buscar_Click(object sender, EventArgs e)
    {
        carga_grilla(tb_busqueda.Text, cb_filtro_busqueda.SelectedValue, lb_id_usuario.Text, lb_id_contratista.Text);

    }

    protected void btn_nuevo_Click(object sender, EventArgs e)
    {
        main.Visible = false;
        agregar.Visible = true;
        inicializar_campos();
        btn_guardar.Text = "GUARDAR NUEVO OPERADOR";
    }

    public void inicializar_campos()
    {
        lb_error.Text = "";
        tb_nombres.Text = "";
        tb_apellidos.Text = "";
        tb_codigo.Text = "";
        tb_clave_operador.Text = "";
        tb_clave_admin.Text = "";
        cb_estados.SelectedIndex = 0;
        carga_regiones();
        carga_contratistas(lb_id_perfil.Text,lb_id_contratista.Text);
        carga_bodegas(lb_id_contratista.Text);
    }

    //Cargamos las regiones posibles.
    public void carga_regiones()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_OPERADOR.CARGA_REGIONES", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "REGIONES");
        objConexion.Close();

        int i = 1;
        cb_regiones.Items.Clear();
        cb_regiones.Items.Add("SELECCIONE...");
        cb_regiones.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["REGIONES"].Rows)
        {

            cb_regiones.Items.Add(row[0].ToString());
            cb_regiones.Items[i].Value = row[1].ToString();
            i = i + 1;

        }
    }

    //Cargamos las perfiles posibles.
    public void carga_contratistas(String id_perfil,String id_contratista)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_OPERADOR.CARGA_CONTRATISTAS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_id_perfil", OracleType.Number, ParameterDirection.Input, id_perfil);
        PRO.agrega_parametro_sp(objComando, "i_id_contratista", OracleType.Number, ParameterDirection.Input, id_contratista);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "CONTRATISTA");
        objConexion.Close();

        int i = 1;
        cb_contratistas.Items.Clear();
        cb_contratistas.Items.Add("SELECCIONE...");
        cb_contratistas.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["CONTRATISTA"].Rows)
        {

            cb_contratistas.Items.Add(row[0].ToString());
            cb_contratistas.Items[i].Value = row[1].ToString();
            i = i + 1;

        }
    }

    //Cargamos las BODEGAS posibles.
    public void carga_bodegas(String id_contratista)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_OPERADOR.CARGA_BODEGAS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_id_contratista", OracleType.Number, ParameterDirection.Input, id_contratista);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "BODEGA");
        objConexion.Close();

        int i = 1;
        cb_bodegas.Items.Clear();
        cb_bodegas.Items.Add("SIN ASIGNAR");
        cb_bodegas.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["BODEGA"].Rows)
        {

            cb_bodegas.Items.Add(row[0].ToString());
            cb_bodegas.Items[i].Value = row[1].ToString();
            i = i + 1;

        }
    }

    //Cargamos los usuarios del sistema según su filtro de búsqueda, el campo para buscar un usuario en específico y de acuerdo al perfil del usuario logeado.
    public void carga_grilla(String busqueda, String filtro, String usuario,String contratista)
    {
        busqueda = busqueda.Trim(); //quitamos los espacios laterales en blanco.

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_OPERADOR.CARGAR_OPERADORES", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_busqueda", OracleType.NVarChar, ParameterDirection.Input, busqueda);
        PRO.agrega_parametro_sp(da, "i_filtro", OracleType.Number, ParameterDirection.Input, filtro);
        PRO.agrega_parametro_sp(da, "i_id_usuario", OracleType.Number, ParameterDirection.Input, usuario);
        PRO.agrega_parametro_sp(da, "i_id_contratista", OracleType.Number, ParameterDirection.Input, contratista);

        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        DataTable dtOrdenes = new DataTable();

        try
        {
            CnOra.Open();

            da.Fill(dtOrdenes);
            CnOra.Close();
            CnOra.Dispose();
            lb_mensaje.Text = "";
        }
        catch (Exception ex)
        {
            lb_mensaje.ForeColor = System.Drawing.Color.Red;
            lb_mensaje.Text = ex.Message;
        }


        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("ID_OPERADOR", typeof(String)));
        dt.Columns.Add(new DataColumn("NOMBRE_COMPLETO", typeof(String)));
        dt.Columns.Add(new DataColumn("COD_OPERADOR", typeof(String)));
        dt.Columns.Add(new DataColumn("CLAVE_OPERADOR", typeof(String)));
        dt.Columns.Add(new DataColumn("CLAVE_ADMIN", typeof(String)));
        dt.Columns.Add(new DataColumn("ESTADO", typeof(String)));
        dt.Columns.Add(new DataColumn("REGION", typeof(String)));
        dt.Columns.Add(new DataColumn("CONTRATISTA", typeof(String)));
        dt.Columns.Add(new DataColumn("BODEGA", typeof(String)));

        DataRow dr;

        int total = 0;

        foreach (DataRow drOrdenItem in dtOrdenes.Rows)
        {

            dr = dt.NewRow();
            dr["ID_OPERADOR"] = drOrdenItem["ID_OPERADOR"].ToString();
            dr["NOMBRE_COMPLETO"] = drOrdenItem["NOMBRE_COMPLETO"].ToString();
            dr["COD_OPERADOR"] = drOrdenItem["COD_OPERADOR"].ToString();
            dr["CLAVE_OPERADOR"] = drOrdenItem["CLAVE_OPERADOR"].ToString();
            dr["CLAVE_ADMIN"] = drOrdenItem["CLAVE_ADMIN"].ToString();
            dr["ESTADO"] = drOrdenItem["ESTADO"].ToString();
            dr["REGION"] = drOrdenItem["REGION"].ToString();
            dr["CONTRATISTA"] = drOrdenItem["CONTRATISTA"].ToString();
            dr["BODEGA"] = drOrdenItem["BODEGA"].ToString();

            dt.Rows.Add(dr);

            total = total + 1;

        }

        DataView MydataView;
        MydataView = new DataView(dt);
        gridOrden.DataSource = MydataView;
        gridOrden.DataBind();
        gridOrden.Columns[0].Visible = false;

        lb_contador.Text = total + " operador(es) encontrado(s)";

        GridViewRow gvRow;

        for (int i = 0; i < gridOrden.Rows.Count; i++)
        {

            gvRow = gridOrden.Rows[i];

            if (gvRow.Cells[5].Text.Equals("HABILITADO"))
            {
                gvRow.Cells[5].BackColor = System.Drawing.Color.LightGreen;


            }
            else
            {
                gvRow.Cells[5].BackColor = System.Drawing.Color.IndianRed;

            }

        }

    }

    public Boolean cargar_operador(String id_operador)
    {
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_OPERADOR.CARGAR_DATOS_OPERADOR", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_id_operador", OracleType.Number, ParameterDirection.Input, id_operador);

        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        DataTable dtOrdenes = new DataTable();

        try
        {
            CnOra.Open();

            da.Fill(dtOrdenes);
            CnOra.Close();
            CnOra.Dispose();
            lb_mensaje.Text = "";
        }
        catch (Exception ex)
        {
            lb_mensaje.ForeColor = System.Drawing.Color.Red;
            lb_mensaje.Text = ex.Message;
            return false;
        }


        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("NOMBRE", typeof(String)));
        dt.Columns.Add(new DataColumn("APELLIDO", typeof(String)));
        dt.Columns.Add(new DataColumn("COD_OPERADOR", typeof(String)));
        dt.Columns.Add(new DataColumn("CLAVE_OPERADOR", typeof(String)));
        dt.Columns.Add(new DataColumn("CLAVE_ADMIN", typeof(String)));
        dt.Columns.Add(new DataColumn("ESTADO", typeof(String)));
        dt.Columns.Add(new DataColumn("REGION", typeof(String)));
        dt.Columns.Add(new DataColumn("CONTRATISTA", typeof(String)));
        dt.Columns.Add(new DataColumn("BODEGA", typeof(String)));
        dt.Columns.Add(new DataColumn("DEVOLUCION_ORDENES", typeof(String)));

        DataRow dr;

        int total = 0;

        foreach (DataRow drOrdenItem in dtOrdenes.Rows)
        {

            dr = dt.NewRow();
            tb_nombres.Text = drOrdenItem["NOMBRE"].ToString();
            tb_apellidos.Text = drOrdenItem["APELLIDO"].ToString();
            tb_codigo.Text = drOrdenItem["COD_OPERADOR"].ToString();
            rescate_old_codigo.Text = tb_codigo.Text; //RESCATAMOS CODIGO OPERADOR.
            tb_clave_operador.Text = drOrdenItem["CLAVE_OPERADOR"].ToString();
            tb_clave_admin.Text = drOrdenItem["CLAVE_ADMIN"].ToString();

            if (drOrdenItem["ESTADO"].ToString() == "") drOrdenItem["ESTADO"] = "0";
            cb_estados.SelectedValue = drOrdenItem["ESTADO"].ToString();

            if (drOrdenItem["CONTRATISTA"].ToString() == "") drOrdenItem["CONTRATISTA"] = "0";
            cb_contratistas.SelectedValue = drOrdenItem["CONTRATISTA"].ToString();

            if (drOrdenItem["REGION"].ToString() == "") drOrdenItem["REGION"] = "0";
            cb_regiones.SelectedValue = drOrdenItem["REGION"].ToString();

            if (drOrdenItem["BODEGA"].ToString() == "") drOrdenItem["BODEGA"] = "0";
            cb_bodegas.SelectedValue = drOrdenItem["BODEGA"].ToString();
            rescate_old_bodega.Text = cb_bodegas.SelectedValue;

            try
            {

                if (drOrdenItem["DEVOLUCION_ORDENES"].ToString().Equals("0"))
                {
                    rb_autoriza.Checked = false;
                }
                else
                {
                    rb_autoriza.Checked = true;
                }
            }
            catch (Exception ex)
            {
                rb_autoriza.Checked = false;
            }

            dt.Rows.Add(dr);

            total = total + 1;

        }

        return true;
    }

    public void guardar_operador(String id_operador, String nombres, String apellidos, String codigo, String clave_operador, String clave_admin,
        String estado, String contratista, String region,String accion,String bodega,Boolean autorizado)
    {
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_OPERADOR.GUARDAR_OPERADOR", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "i_id_operador", OracleType.Number, ParameterDirection.Input, id_operador);
        PRO.agrega_parametro_sp(da, "i_nombre", OracleType.NVarChar, ParameterDirection.Input, nombres);
        PRO.agrega_parametro_sp(da, "i_apellido", OracleType.NVarChar, ParameterDirection.Input, apellidos);
        PRO.agrega_parametro_sp(da, "i_codigo", OracleType.NVarChar, ParameterDirection.Input, codigo);
        PRO.agrega_parametro_sp(da, "i_clave_operador", OracleType.NVarChar, ParameterDirection.Input, clave_operador);
        PRO.agrega_parametro_sp(da, "i_clave_admin", OracleType.NVarChar, ParameterDirection.Input, clave_admin);
        PRO.agrega_parametro_sp(da, "i_estado", OracleType.Number, ParameterDirection.Input, estado);
        PRO.agrega_parametro_sp(da, "i_contratista", OracleType.Number, ParameterDirection.Input, contratista);
        PRO.agrega_parametro_sp(da, "i_region", OracleType.Number, ParameterDirection.Input, region);
        PRO.agrega_parametro_sp(da, "i_accion", OracleType.Number, ParameterDirection.Input, accion);
        PRO.agrega_parametro_sp(da, "i_bodega", OracleType.Number, ParameterDirection.Input, bodega);

        String autoriza = "0";
        if (autorizado) autoriza = "1";

        PRO.agrega_parametro_sp(da, "i_autorizado", OracleType.Number, ParameterDirection.Input, autoriza);


        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        try
        {
            CnOra.Open();

            da.SelectCommand.ExecuteNonQuery();           
            CnOra.Close();
            CnOra.Dispose();
            lb_mensaje.ForeColor = System.Drawing.Color.DarkGreen;
            renombrar_fotos(rescate_old_codigo.Text,codigo);
            if (accion.Equals("1")) lb_mensaje.Text = "OPERADOR CREADO EXITOSAMENTE!";
            else lb_mensaje.Text = "OPERADOR MODIFICADO EXITOSAMENTE!";
        }
        catch (Exception ex)
        {
            lb_mensaje.ForeColor = System.Drawing.Color.Red;
            lb_mensaje.Text = ex.Message;
            CnOra.Close();
            CnOra.Dispose();
            
        }
    }

    public Boolean renombrar_fotos(String old_instalador, String new_instalador)
    {
        try
        {
            if (old_instalador.Equals(new_instalador))
            {
                return true;
            }
            else
            {
                //ANALIZAMOS SEGÚN LÓGICA DE ENTRADA, MANTENEMOS VALORES OLD SI ESQUE EL NEW ESTÁ VACÍO.            
                if (new_instalador.Equals("")) new_instalador = old_instalador;

                String ruta_fotos_raiz = "FOTOS/";

                if (!Directory.Exists(Server.MapPath("./" + ruta_fotos_raiz + "/"))) System.IO.Directory.CreateDirectory(Server.MapPath("./" + ruta_fotos_raiz + "/"));

                //MisFicheros = new DirectoryInfo(Server.MapPath("./" + ruta_fotos_raiz + "/")).GetFiles("*", SearchOption.AllDirectories);
                String[] allfiles = Directory.GetFiles(Server.MapPath("./" + ruta_fotos_raiz + "/"), "*" + old_instalador +"*", SearchOption.AllDirectories);

                foreach (var mi_archivo in allfiles)
                {
                    FileInfo archivo = new FileInfo(mi_archivo);

                    String nombre_foto = archivo.Name;

                    if (nombre_foto.Contains("A" + old_instalador + "A"))
                    {
                        String ruta_completa = archivo.FullName;
                        String ruta_completa_new = "";
                        String[] foto_split = nombre_foto.Split('A'); //0: proceso, 1: servicio, 2: cod_instalador, 3: visita, 4: corr.jpeg   

                        try
                        {
                            String nueva_foto = foto_split[0] + "A" + foto_split[1] + "A" + new_instalador + "A" + foto_split[3] + "A" + foto_split[4];
                            ruta_completa_new = ruta_completa.Replace(nombre_foto, nueva_foto);
                            File.Move(ruta_completa, ruta_completa_new);
                            //File.Replace(Server.MapPath("./" + ruta_fotos_raiz + "/") + nueva_foto, Server.MapPath("./" + ruta_fotos_raiz + "/") + nombre_foto, Server.MapPath("./" + ruta_fotos_raiz + "/") + "temp" + nueva_foto);
                        }
                        catch (Exception ex)
                        {
                            String nueva_foto = foto_split[0] + "A" + foto_split[1] + "A" + new_instalador + "A" + foto_split[3];
                            ruta_completa_new = ruta_completa.Replace(nombre_foto, nueva_foto);
                            File.Move(ruta_completa, ruta_completa_new);
                        }
                    }
                    
                }
                //OBTENEMOS LAS FOTOS QUE SE ENCUENTREN EN LA RAIZ COMO PRIMERA PASADA.
                //if (MisFicheros.Length > 0)
                //{

                //    for (int i = 0; i < MisFicheros.Length; i++)
                //    {
                //        String nombre_foto = MisFicheros[i].Name;

                //        if(nombre_foto.Contains("A" + old_instalador + "A")){
                //            String ruta_completa = MisFicheros[i].FullName.Replace(Server.MapPath(""), "~");
                //            String ruta_completa_new = "";
                //            String[] foto_split = nombre_foto.Split('A'); //0: proceso, 1: servicio, 2: cod_instalador, 3: visita, 4: corr.jpeg   

                //            try
                //            {
                //                String nueva_foto = foto_split[0] + "A" + foto_split[1] + "A" + new_instalador + "A" + foto_split[3] + "A" + foto_split[4];
                //                ruta_completa_new = ruta_completa.Replace(nombre_foto, nueva_foto);
                //                File.Move(ruta_completa, ruta_completa_new);
                //                //File.Replace(Server.MapPath("./" + ruta_fotos_raiz + "/") + nueva_foto, Server.MapPath("./" + ruta_fotos_raiz + "/") + nombre_foto, Server.MapPath("./" + ruta_fotos_raiz + "/") + "temp" + nueva_foto);
                //            }
                //            catch (Exception ex)
                //            {
                //                String nueva_foto = foto_split[0] + "A" + foto_split[1] + "A" + new_instalador + "A" + foto_split[3];
                //                ruta_completa_new = ruta_completa.Replace(nombre_foto, nueva_foto);
                //                File.Move(ruta_completa, ruta_completa_new);
                //            }
                //        }
                        


                //    }

                //}

            }
            
         
        }
        catch (Exception ex)
        {
            return false;
        }
        return true;
    }

    //panel de agregar, validar campos y guardar o volver, campo de familias para relacionar a los usuarios con ellas.
    protected void btn_guardar_Click(object sender, EventArgs e)
    {
        
        if (validar_formulario())
        {

            main.Visible = true;
            agregar.Visible = false;

            if (btn_guardar.Text.Contains("NUEVO"))
            {
                lb_accion.Text = "1";
                rescate_id_operador.Text = "0";
            }
            else lb_accion.Text = "0";

            guardar_operador(rescate_id_operador.Text, tb_nombres.Text, tb_apellidos.Text, tb_codigo.Text, tb_clave_operador.Text, tb_clave_admin.Text,
                cb_estados.SelectedValue, cb_contratistas.SelectedValue, cb_regiones.SelectedValue, lb_accion.Text,cb_bodegas.SelectedValue,rb_autoriza.Checked);

            String mi_mensaje = lb_mensaje.Text;
            carga_grilla(tb_busqueda.Text, cb_filtro_busqueda.SelectedValue, lb_id_usuario.Text, lb_id_contratista.Text);

            lb_mensaje.Text = mi_mensaje;
        }
       
       
    }

    public Boolean validar_formulario()
    {
        lb_error.Text = "";
        String respuesta = "";
        int pendientes = 0;

        if (tb_nombres.Text.Length == 0)
        {
            if (pendientes > 0) respuesta = ", Falta ingresar el nombre";
            else respuesta = " Falta ingresar el nombre";

            lb_error.Text = lb_error.Text + respuesta;
            pendientes++;
        }

        if (tb_apellidos.Text.Length == 0)
        {
            if (pendientes > 0) respuesta = ", Falta ingresar el apellido";
            else respuesta = " Falta ingresar el apellido";

            lb_error.Text = lb_error.Text + respuesta;
            pendientes++;
        }

        if (btn_guardar.Text.Contains("NUEVO")) lb_accion.Text = "1";
        else lb_accion.Text = "0";

        if (!validarCodigo(tb_codigo.Text,lb_accion.Text))
        {
            if (pendientes > 0) respuesta = ", Código inválido o ya existe";
            else respuesta = " Código inválido o ya existe";

            lb_error.Text = lb_error.Text + respuesta;
            pendientes++;
        }

      

        double isItNumeric;
        if (!Double.TryParse(tb_clave_operador.Text, System.Globalization.NumberStyles.Any, System.Globalization.NumberFormatInfo.InvariantInfo, out isItNumeric))
        {
            if (pendientes > 0) respuesta = ", Debe ingresar una clave de operador númerica";
            else respuesta = " Debe ingresar una clave de operador númerica";

            lb_error.Text = lb_error.Text + respuesta;
            pendientes++;
        }

        if (!Double.TryParse(tb_clave_admin.Text, System.Globalization.NumberStyles.Any, System.Globalization.NumberFormatInfo.InvariantInfo, out isItNumeric))
        {
            if (pendientes > 0) respuesta = ", Debe ingresar una clave de admin númerica";
            else respuesta = " Debe ingresar una clave de admin númerica";

            lb_error.Text = lb_error.Text + respuesta;
            pendientes++;
        }

        if (cb_contratistas.SelectedIndex == 0)
        {
            if (pendientes > 0) respuesta = ", Debe seleccionar un contratista";
            else respuesta = " Debe seleccionar un contratista";

            lb_error.Text = lb_error.Text + respuesta;
            pendientes++;
        }

        if (cb_regiones.SelectedIndex == 0)
        {
            if (pendientes > 0) respuesta = ", Debe seleccionar una región";
            else respuesta = " Debe seleccionar una región";

            lb_error.Text = lb_error.Text + respuesta;
            pendientes++;
        }

        if (!valida_stock_operador(rescate_id_operador.Text) && lb_accion.Text.Equals("0") && !rescate_old_bodega.Text.Equals(cb_bodegas.SelectedValue))
        {
            if (pendientes > 0) respuesta = ", No se puede cambiar de bodega, el operador tiene stock asignado/cargado ";
            else respuesta = " No se puede cambiar de bodega, el operador tiene stock asignado/cargado";

            lb_error.Text = lb_error.Text + respuesta;
            pendientes++;
        }

        //hay cosas pendientes? pendientes > 0 indica que quedan pendientes
        if (pendientes > 0) return false;
        else return true;

    }

    public Boolean valida_stock_operador(String id_operador)
    {
        try
        {
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();

            objConexion.Open();
            objComando = new OracleDataAdapter("PK_OPERADOR.VALIDA_STOCK_OPERADOR", objConexion);
            objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

            PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
            PRO.agrega_parametro_sp(objComando, "i_id_instalador", OracleType.Int32, ParameterDirection.Input, id_operador);

            objComando.SelectCommand.ExecuteNonQuery();
            objComando.Fill(objDS, "VALIDA");
            objConexion.Close();


            foreach (DataRow row in objDS.Tables["VALIDA"].Rows)
            {
                if (row[0].ToString().Equals("0")) return true;
            }

            return false;
        }
        catch (Exception ex)
        {
            return false;
        }
    }


    public Boolean validarCodigo(String codigo_operador,String accion)
    {
        try
        {
            String filtro = "COD_INSTALADOR = '" + codigo_operador + "' "; 
            if(accion.Equals("0")) filtro = filtro + "AND ID_INSTALADOR <> " + rescate_id_operador.Text;

            codigo_operador = codigo_operador.Trim();
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();
           
            objConexion.Open();
            objComando = new OracleDataAdapter("SELECT COD_INSTALADOR FROM INSTALADOR WHERE " + filtro, objConexion);
            objComando.SelectCommand.CommandType = CommandType.Text;

            objComando.SelectCommand.ExecuteNonQuery();
            objComando.Fill(objDS, "VALIDA");
            objConexion.Close();
                       
            foreach (DataRow row in objDS.Tables["VALIDA"].Rows)
            {
                if (codigo_operador.Equals(row[0].ToString()))
                {
                    return false;
                }
            }

            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
    }

    protected void btn_volver_Click(object sender, EventArgs e)
    {
        main.Visible = true;
        agregar.Visible = false;
    }
       
    protected void ver_contrasena_Click(object sender, ImageClickEventArgs e)
    {
        String mi_pass = tb_clave_admin.Text.ToString();
        if (tb_clave_admin.TextMode == TextBoxMode.Password) tb_clave_admin.TextMode = TextBoxMode.SingleLine;
        else tb_clave_admin.TextMode = TextBoxMode.Password;
                
    }

  
}