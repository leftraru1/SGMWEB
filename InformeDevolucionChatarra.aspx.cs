using System;
using System.Collections.Generic;
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

public partial class InformeDevolucionChatarra : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();
    String id_contr = "0";
    public DataTable dt_excel = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            try
            {
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                PRO.recSession(rutaXml, "RUT_EMPRESA");
                id_contr = PRO.recSession(rutaXml, "ID_CONTRATISTA");
                lb_id_usuario.Text = PRO.recSession(rutaXml, "ID_USUARIO");
                lb_id_perfil.Text = PRO.recSession(rutaXml, "ID_PERFIL");

                carga_contratista(id_contr);
                carga_operadores(cb_contratista.SelectedValue);
                //cargamos los filtros multiples.
                carga_region();
                carga_bodegas(cb_contratista.SelectedValue, fill_checkbox_list(cb_region));
                carga_categorias();
                carga_tipo_proceso();

                //iniciamos las fechas con un rango de 3 meses hasta la fecha de hoy.
                txtDesde.Text = DateTime.Now.AddDays(-90).ToString("dd-MM-yyyy");
                txtHasta.Text = DateTime.Now.ToString("dd-MM-yyyy");

                //cargamos tabla.
                carga_grilla_detalle(fill_checkbox_list(cb_bodega),
                fill_checkbox_list(cb_categoria), fill_checkbox_list(cb_tipo_proceso), cb_operador.SelectedValue, "RESUMEN",txtDesde.Text,txtHasta.Text);

                //según perfil permitimos ver las solicitudes por confirmar.
                valida_permisos_perfil(lb_id_perfil.Text);
                IMG2.Visible = false;

            }
            catch (Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }
        }
    }

    
         public void valida_permisos_perfil(String id_perfil)
    {

        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_STOCK_MINIMO.VALIDA_ADMIN", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_id_perfil", OracleType.NVarChar, ParameterDirection.Input,id_perfil);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "PERFIL");
        objConexion.Close();
        

        if (objDS.Tables["PERFIL"].Rows[0][0].ToString().Equals("0")) //adm gral, adm desarrollo, adm gral essbio.
        {
           gridOrden.Columns[9].Visible = false;
        }
    }
           
     
    ///////////////////////////////////////////////////////////////////////
    //CONCATENAMOS LOS TIPOS DE PROCESO O IMPROCEDENCIAS (SEGÚN ENTRADA) QUE SE HAYAN SELECCIONADO.
    public string fill_checkbox_list(CheckBoxList mi_selector)
    {
        string selecciones = "";
        int bandera = 0;
        for (int i = 0; i < mi_selector.Items.Count; i++)
        {
            if (mi_selector.Items[i].Selected)
            {
                if (bandera == 0)
                {
                    selecciones = "'" + mi_selector.Items[i].Value + "'";
                    bandera = bandera + 1;
                }
                else
                {
                    selecciones = "'" + mi_selector.Items[i].Value + "'," + selecciones;
                }
            }
        }
        return selecciones;
    }

    public string fill_checkbox_list_names(CheckBoxList mi_selector)
    {
        string selecciones = "";
        int bandera = 0;
        for (int i = 0; i < mi_selector.Items.Count; i++)
        {
            if (mi_selector.Items[i].Selected)
            {
                if (bandera == 0)
                {
                    selecciones = "'" + mi_selector.Items[i].Text + "'";
                    bandera = bandera + 1;
                }
                else
                {
                    selecciones = "'" + mi_selector.Items[i].Text + "'," + selecciones;
                }
            }
        }
        return selecciones;
    }

    public string get_all_checkbox_list(CheckBoxList mi_selector)
    {
        string selecciones = "";
        int bandera = 0;
        for (int i = 0; i < mi_selector.Items.Count; i++)
        {

            if (bandera == 0)
            {
                selecciones = mi_selector.Items[i].Value;
                bandera = bandera + 1;
            }
            else
            {
                selecciones = mi_selector.Items[i].Value + "," + selecciones;
            }

        }
        return selecciones;
    }

    //CARGAMOS LAS REGIONES
    public void carga_region()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_REPORTE_ORDENES.CARGA_REGION", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "REGION");
        objConexion.Close();

        int i = 0;
        cb_region.Items.Clear();

        foreach (DataRow row in objDS.Tables["REGION"].Rows)
        {

            cb_region.Items.Add(row[1].ToString());
            cb_region.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }


    //CARGAMOS LOS CONTRATISTAS.
    public void carga_contratista(String contratista)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_REPORTE_STOCK.CARGA_CONTRATISTAS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "contratista", OracleType.Number, ParameterDirection.Input, contratista);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "CONTRATISTA");
        objConexion.Close();

        int i = 1;
        if (contratista == "0")
        {
            cb_contratista.Items.Clear();
            cb_contratista.Items.Add("Todos...");
            cb_contratista.Items[0].Value = "0";
        }
        else
        {
            i = 0;
        }

        foreach (DataRow row in objDS.Tables["CONTRATISTA"].Rows)
        {
            cb_contratista.Items.Add(row[1].ToString());
            cb_contratista.Items[i].Value = row[0].ToString();
            i = i + 1;
        }
    }


    //CARGAMOS LOS OPERADORES
    public void carga_operadores(String contratista)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_STOCK_MINIMO.CARGA_OPERADORES", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_id_contratista", OracleType.Number, ParameterDirection.Input, contratista);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "OPERADORES");
        objConexion.Close();

        int i = 1;
        cb_operador.Items.Clear();
        cb_operador.Items.Add("TODOS...");
        cb_operador.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["OPERADORES"].Rows)
        {
            String name = row[1].ToString();
            if (row[2].ToString().Length == 0) name += " (N/A)";
            else name += " (" + row[3].ToString() + "/" + row[2].ToString() + ")";

            cb_operador.Items.Add(name);
            cb_operador.Items[i].Value = row[0].ToString();
            i = i + 1;
        }
    }

    ////CARGAMOS LOS TIPOS DE PROCESO.
    //public void carga_tipoproceso()
    //{
    //    OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
    //    OracleDataAdapter objComando;
    //    DataSet objDS = new DataSet();

    //    objConexion.Open();
    //    objComando = new OracleDataAdapter("PK_REPORTE_ORDENES.CARGA_TIPOPROCESO", objConexion);
    //    objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

    //    PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

    //    objComando.SelectCommand.ExecuteNonQuery();
    //    objComando.Fill(objDS, "TIPOPROCESO");
    //    objConexion.Close();

    //    int i = 0;
    //    cb_tipo_proceso.Items.Clear();

    //    foreach (DataRow row in objDS.Tables["TIPOPROCESO"].Rows)
    //    {
    //        cb_tipo_proceso.Items.Add(row[1].ToString());
    //        cb_tipo_proceso.Items[i].Value = row[0].ToString();
    //        i = i + 1;
    //    }
    //}

    //Cargamos las BODEGAS posibles.

    public void carga_bodegas(String id_contratista, String id_region)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_REPORTE_STOCK.CARGA_BODEGAS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_id_contratista", OracleType.Number, ParameterDirection.Input, id_contratista);
        PRO.agrega_parametro_sp(objComando, "i_id_region", OracleType.NVarChar, ParameterDirection.Input, id_region);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "BODEGA");
        objConexion.Close();

        int i = 0;
        cb_bodega.Items.Clear();

        foreach (DataRow row in objDS.Tables["BODEGA"].Rows)
        {

            cb_bodega.Items.Add(row[0].ToString());
            cb_bodega.Items[i].Value = row[1].ToString();


            i = i + 1;

        }
    }

    //CARGA CATEGORIAS DISPONIBLES PARA EL STOCK MINIMO
    public void carga_categorias()
    {

        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_STOCK_MINIMO.CARGA_CATEGORIAS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "CATEGORIAS");
        objConexion.Close();

        int i = 0;

        //nuevo stock minimo
        cb_categoria.Items.Clear();

        foreach (DataRow row in objDS.Tables["CATEGORIAS"].Rows)
        {

            cb_categoria.Items.Add(row[0].ToString());
            cb_categoria.Items[i].Value = row[0].ToString();

            i = i + 1;

        }


    }

    //CARGA tipo_procesoS POSIBLES PARA EL STOCK MINIMO.
    public void carga_tipo_proceso()
    {

        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_STOCK_MINIMO.CARGA_TIPO_PROCESOS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "tipo_proceso");
        objConexion.Close();

        int i = 0;

        cb_tipo_proceso.Items.Clear();

        foreach (DataRow row in objDS.Tables["tipo_proceso"].Rows)
        {

            cb_tipo_proceso.Items.Add(row[0].ToString());
            cb_tipo_proceso.Items[i].Value = row[1].ToString();
            i = i + 1;

        }


    }


    //////////////////////////////////////////////////////////////////////////////////////

    //public void carga_grilla(String region, String zona, String localidad, String lote, String libreta, String contratista,
    //    String tipo_proceso, String improcedencia, String numero_orden, String servicio, String desde, String hasta, String cod_varal,String inst_llave)
    //{
    //    String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
    //    id_contr = PRO.recSession(rutaXml, "ID_CONTRATISTA");

    //    OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
    //    OracleCommand cmdAcceso = new OracleCommand("PK_REPORTE_ORDENES.CARGA_ORDENES", CnOra);
    //    OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

    //    // PONE VISIBLE LA COLUMNA ID_SINCRONIZACION Y ID_ORDEN PARA LLENARLA 
    //    //(SI NO SE PONE VISIBLE NO SE LLENA)
    //    gridOrden.Columns[0].Visible = true;

    //    PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
    //    PRO.agrega_parametro_sp(da, "i_region", OracleType.Number, ParameterDirection.Input, region);
    //    PRO.agrega_parametro_sp(da, "i_zona", OracleType.Number, ParameterDirection.Input, zona);
    //    PRO.agrega_parametro_sp(da, "i_localidad", OracleType.Number, ParameterDirection.Input, localidad);
    //    PRO.agrega_parametro_sp(da, "i_lote", OracleType.Number, ParameterDirection.Input, lote);
    //    PRO.agrega_parametro_sp(da, "i_libreta", OracleType.Number, ParameterDirection.Input, libreta);

    //    if (contratista.Length == 0) contratista = id_contr;

    //    PRO.agrega_parametro_sp(da, "i_contratista", OracleType.Number, ParameterDirection.Input, contratista);
    //    PRO.agrega_parametro_sp(da, "i_tipoproceso", OracleType.NVarChar, ParameterDirection.Input, tipo_proceso);
    //    PRO.agrega_parametro_sp(da, "i_improcedencia", OracleType.NVarChar, ParameterDirection.Input, improcedencia);

    //    if (numero_orden.Length == 0) numero_orden = "0";

    //    PRO.agrega_parametro_sp(da, "i_numero_orden", OracleType.Number, ParameterDirection.Input, numero_orden);
    //    PRO.agrega_parametro_sp(da, "i_servicio", OracleType.NVarChar, ParameterDirection.Input, servicio);
    //    PRO.agrega_parametro_sp(da, "i_desde", OracleType.NVarChar, ParameterDirection.Input, desde);
    //    PRO.agrega_parametro_sp(da, "i_hasta", OracleType.NVarChar, ParameterDirection.Input, hasta);
    //    PRO.agrega_parametro_sp(da, "i_cod_varal", OracleType.Number, ParameterDirection.Input, cod_varal);
    //    PRO.agrega_parametro_sp(da, "i_inst_llave", OracleType.Number, ParameterDirection.Input, inst_llave);

    //    da.SelectCommand.CommandType = CommandType.StoredProcedure;

    //    DataTable dtOrdenes = new DataTable();

    //    try
    //    {
    //        CnOra.Open();

    //        da.Fill(dtOrdenes);
    //        CnOra.Close();
    //        CnOra.Dispose();

    //    }
    //    catch (Exception ex)
    //    {
    //        lbErrorGrilla.Text = ex.Message.ToString();
    //        lbErrorGrilla.ForeColor = System.Drawing.Color.Red;

    //        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + ex.Message.ToString() + "');", true);

    //    }

    //    DataTable dt = new DataTable();
    //    dt.Columns.Add(new DataColumn("ID_ORDEN", typeof(String)));
    //    dt.Columns.Add(new DataColumn("VISITA", typeof(String)));
    //    dt.Columns.Add(new DataColumn("NUMERO_ORDEN", typeof(String)));
    //    dt.Columns.Add(new DataColumn("ID_SERVICIO", typeof(String)));
    //    dt.Columns.Add(new DataColumn("FECHA_CREACION", typeof(String)));
    //    dt.Columns.Add(new DataColumn("FECHA_INTEGRACION", typeof(String)));
    //    dt.Columns.Add(new DataColumn("ESTADO_MR", typeof(String)));
    //    dt.Columns.Add(new DataColumn("DIAMETRO_RET", typeof(String)));
    //    dt.Columns.Add(new DataColumn("SERIE_MEDIDOR_RET", typeof(String)));
    //    dt.Columns.Add(new DataColumn("LECTURA_RET", typeof(String)));
    //    dt.Columns.Add(new DataColumn("DIAMETRO_NU", typeof(String)));
    //    dt.Columns.Add(new DataColumn("NUMERO_MN", typeof(String)));
    //    dt.Columns.Add(new DataColumn("LECTURA_MN", typeof(String)));
    //    dt.Columns.Add(new DataColumn("RUTA", typeof(String)));
    //    dt.Columns.Add(new DataColumn("LOCALIDAD", typeof(String)));
    //    dt.Columns.Add(new DataColumn("TIPO_PROCESO", typeof(String)));
    //    dt.Columns.Add(new DataColumn("INSTALADOR", typeof(String)));
    //    dt.Columns.Add(new DataColumn("CONTRATISTA", typeof(String)));
    //    dt.Columns.Add(new DataColumn("IMPROCEDENCIA", typeof(String)));
    //    dt.Columns.Add(new DataColumn("FECHA_INST", typeof(String)));

    //    DataRow dr;

    //    int total = 0;

    //    foreach (DataRow drOrdenItem in dtOrdenes.Rows)
    //    {

    //        dr = dt.NewRow();

    //        dr["ID_ORDEN"] = drOrdenItem["ID_ORDEN"].ToString();
    //        dr["VISITA"] = drOrdenItem["VISITA"].ToString();
    //        dr["NUMERO_ORDEN"] = drOrdenItem["NUMERO_ORDEN"].ToString();
    //        dr["ID_SERVICIO"] = drOrdenItem["ID_SERVICIO"].ToString();
    //        dr["FECHA_CREACION"] = drOrdenItem["FECHA_CREACION"].ToString().Replace(" 0:00:00", "");
    //        dr["FECHA_INTEGRACION"] = drOrdenItem["FECHA_INTEGRACION"].ToString().Replace(" 0:00:00", "");

    //        dr["ESTADO_MR"] = drOrdenItem["ESTADO_MR"].ToString();
    //        dr["DIAMETRO_RET"] = drOrdenItem["DIAMETRO_RET"].ToString();
    //        dr["SERIE_MEDIDOR_RET"] = drOrdenItem["SERIE_MEDIDOR_RET"].ToString();
    //        dr["LECTURA_RET"] = drOrdenItem["LECTURA_RET"].ToString();
    //        dr["DIAMETRO_NU"] = drOrdenItem["DIAMETRO_NU"].ToString();
    //        dr["NUMERO_MN"] = drOrdenItem["NUMERO_MN"].ToString();
    //        dr["LECTURA_MN"] = drOrdenItem["LECTURA_MN"].ToString();
    //        dr["RUTA"] = drOrdenItem["RUTA"].ToString();
    //        dr["LOCALIDAD"] = drOrdenItem["LOCALIDAD"].ToString();
    //        dr["TIPO_PROCESO"] = drOrdenItem["TIPO_PROCESO"].ToString();
    //        dr["INSTALADOR"] = drOrdenItem["INSTALADOR"].ToString();
    //        dr["CONTRATISTA"] = drOrdenItem["CONTRATISTA"].ToString();
    //        dr["IMPROCEDENCIA"] = drOrdenItem["IMPROCEDENCIA"].ToString();
    //        dr["FECHA_INST"] = drOrdenItem["FECHA_INST"].ToString().Replace(" 0:00:00", "");

    //        dt.Rows.Add(dr);

    //        total = total + 1;

    //    }

    //    DataView MydataView;
    //    MydataView = new DataView(dt);
    //    gridOrden.DataSource = MydataView;
    //    gridOrden.DataBind();

    //    lbTotal.Text = total + " registro(s) encontrado(s)";

    //    gridOrden.Columns[0].Visible = false;
    //}


    protected void gridOrden_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //gridOrden.PageIndex = e.NewPageIndex;
        gridOrden.PageIndex = e.NewPageIndex;
        carga_grilla_detalle(fill_checkbox_list(cb_bodega),
               fill_checkbox_list(cb_categoria), fill_checkbox_list(cb_tipo_proceso), cb_operador.SelectedValue, "RESUMEN", txtDesde.Text, txtHasta.Text);

    }




    /* ------------------Evento para actualizar la tabla segun el numero de orden que se busca---------------------------------*/


    /* ------------------COLORES DE LA GRILLA (SLA) -------------------------*/
    protected void gridOrden_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    public String get_region(String localidad)
    {
        String region = "0";
        try
        {
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();

            objConexion.Open();
            objComando = new OracleDataAdapter("SELECT Z.ID_REGION FROM LOCALIDAD L JOIN ZONA Z ON Z.ID_ZONA = L.ID_ZONA WHERE L.NOMBRE = '" + localidad + "'", objConexion);
            objComando.SelectCommand.CommandType = CommandType.Text;

            objComando.SelectCommand.ExecuteNonQuery();
            objComando.Fill(objDS, "REGION");
            objConexion.Close();

            int codigo = 0;
            foreach (DataRow row in objDS.Tables["REGION"].Rows)
            {
                region = row[0].ToString();

            }
            return region;
        }
        catch (Exception ex)
        {
            return region;
        }

    }


    public void datatable_to_excel(DataTable dt)
    {
        try
        {
            String salida;
            DataRow dr;
            StreamWriter sr;
            int total = 0;

            sr = new StreamWriter(Server.MapPath("./SALIDA/" + "DETALLE_STOCK" + DateTime.Now.ToString("ddMMyyyyHHmmss") + ".csv"));

            //FILTROS REALIZADOS.
            salida = "CONTRATISTA: " + cb_contratista.SelectedItem + " // REGIONES: " + fill_checkbox_list_names(cb_region);
            sr.WriteLine(salida);
            salida = "BODEGAS: " + fill_checkbox_list_names(cb_bodega);
            sr.WriteLine(salida);
            salida = "CATEGORIAS: " + fill_checkbox_list_names(cb_categoria);
            sr.WriteLine(salida);
            salida = "TIPO PROCESOS: " + fill_checkbox_list_names(cb_tipo_proceso);
            sr.WriteLine(salida);

            sr.WriteLine("");

            salida = "CONTRATISTA" + ";"
                        + "REGION" + ";"
                        + "BODEGA" + ";"
                        + "CATEGORIA" + ";"
                        + "DIAMETRO" + ";"
                        + "STOCK MINIMO" + ";"
                        + "NO DISPONIBLE" + ";"
                        + "POR VALIDAR" + ";"
                        + "DISPONIBLE" + ";"
                        + "ASIGNADO" + ";"
                        + "EN TERRENO" + ";"
                        + "INSTALADO" + ";"
                        + "DADO DE BAJA" + ";"
                        + "EXTRAVIADO" + ";"
                        + "EN DIFERENCIA" + ";"
                        + "TOTAL";

            sr.WriteLine(salida);

            foreach (DataRow drOrdenItem in dt.Rows)
            {
                dr = dt.NewRow();

                dr["CONTRATISTA"] = drOrdenItem["CONTRATISTA"].ToString();
                dr["REGION"] = drOrdenItem["REGION"].ToString();
                dr["NOMBRE_BODEGA"] = drOrdenItem["NOMBRE_BODEGA"].ToString();
                dr["CATEGORIA"] = drOrdenItem["CATEGORIA"].ToString();
                dr["DIAMETRO"] = drOrdenItem["DIAMETRO"].ToString();
                dr["STOCK_MINIMO"] = drOrdenItem["STOCK_MINIMO"].ToString();
                dr["NO_DISPONIBLE"] = drOrdenItem["NO_DISPONIBLE"].ToString();
                dr["POR_VALIDAR"] = drOrdenItem["POR_VALIDAR"].ToString();
                dr["DISPONIBLE"] = drOrdenItem["DISPONIBLE"].ToString();
                dr["ASIGNADO"] = drOrdenItem["ASIGNADO"].ToString();
                dr["EN_TERRENO"] = drOrdenItem["EN_TERRENO"].ToString();
                dr["INSTALADO"] = drOrdenItem["INSTALADO"].ToString();
                dr["DADO_BAJA"] = drOrdenItem["DADO_BAJA"].ToString();
                dr["EXTRAVIADO"] = drOrdenItem["EXTRAVIADO"].ToString();
                dr["EN_DIFERENCIA"] = drOrdenItem["EN_DIFERENCIA"].ToString();
                dr["TOTAL"] = drOrdenItem["TOTAL"].ToString();



                total = total + 1;

                salida = dr["CONTRATISTA"] + ";" +
                         dr["REGION"] + ";" +
                         dr["NOMBRE_BODEGA"] + ";" +
                         dr["CATEGORIA"] + ";" +
                         dr["DIAMETRO"] + ";" +
                         dr["STOCK_MINIMO"] + ";" +
                         dr["NO_DISPONIBLE"] + ";" +
                         dr["POR_VALIDAR"] + ";" +
                         dr["DISPONIBLE"] + ";" +
                         dr["ASIGNADO"] + ";" +
                         dr["EN_TERRENO"] + ";" +
                         dr["INSTALADO"] + ";" +
                         dr["DADO_BAJA"] + ";" +
                         dr["EXTRAVIADO"] + ";" +
                         dr["EN_DIFERENCIA"] + ";" +
                         dr["TOTAL"];


                sr.WriteLine(salida);

            }
            sr.Close();

            Response.Redirect("./SALIDA/" + "DETALLE_STOCK" + DateTime.Now.ToString("ddMMyyyyHHmmss") + ".csv", false);
        }
        catch (Exception ex)
        {
            String exp = ex.ToString();
        }
    }

    public void carga_grilla_detalle(String bodega, String categoria, String tipo_proceso,String cod_instalador,String tipo,String desde,String hasta)
    {
        lb_mensaje.Text = "";

        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
        id_contr = PRO.recSession(rutaXml, "ID_CONTRATISTA");

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_INFORME_CHATARRA.CARGA_CHATARRA", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        if (bodega.Length == 0)
        {
            if (cb_bodega.Items.Count == 0) bodega = "0";
            else bodega = get_all_checkbox_list(cb_bodega);
        }

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_categoria", OracleType.NVarChar, ParameterDirection.Input, categoria);
        tipo_proceso = tipo_proceso.Replace("'", "");
        PRO.agrega_parametro_sp(da, "i_tipo_proceso", OracleType.NVarChar, ParameterDirection.Input, tipo_proceso);
        PRO.agrega_parametro_sp(da, "i_bodega", OracleType.NVarChar, ParameterDirection.Input, bodega);
        PRO.agrega_parametro_sp(da, "i_desde", OracleType.NVarChar, ParameterDirection.Input, desde);
        PRO.agrega_parametro_sp(da, "i_hasta", OracleType.NVarChar, ParameterDirection.Input, hasta);
        PRO.agrega_parametro_sp(da, "i_cod_instalador", OracleType.NVarChar, ParameterDirection.Input, cod_instalador);
        PRO.agrega_parametro_sp(da, "i_tipo", OracleType.NVarChar, ParameterDirection.Input, tipo);

        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("CONTRATISTA", typeof(String)));
        dt.Columns.Add(new DataColumn("REGION", typeof(String)));
        dt.Columns.Add(new DataColumn("BODEGA", typeof(String)));
        dt.Columns.Add(new DataColumn("ID_BODEGA", typeof(String)));
        dt.Columns.Add(new DataColumn("CATEGORIA", typeof(String)));
        dt.Columns.Add(new DataColumn("DIAMETRO", typeof(String)));
        dt.Columns.Add(new DataColumn("CANTIDAD_RETIRADO", typeof(String)));
        dt.Columns.Add(new DataColumn("CANTIDAD_DEVOLUCION", typeof(String)));
        dt.Columns.Add(new DataColumn("CANTIDAD_CORRECCION", typeof(String)));

        if (tipo.Equals("DETALLE"))
        {
            dt.Columns.Add(new DataColumn("ID_SERVICIO", typeof(String)));
            dt.Columns.Add(new DataColumn("CAUSA", typeof(String)));
            dt.Columns.Add(new DataColumn("SERIE_MEDIDOR_RET", typeof(String)));
            dt.Columns.Add(new DataColumn("FECHA_INST", typeof(String)));
            dt.Columns.Add(new DataColumn("INSTALADOR", typeof(String)));
            dt.Columns.Add(new DataColumn("FECHA_DEVOLUCION", typeof(String)));
        }
        try
        {
            DataTable dtOrdenes = new DataTable();
            CnOra.Open();

            da.Fill(dtOrdenes);
            grdExcel.DataSource = dtOrdenes;
            grdExcel.DataBind();
            CnOra.Close();
            CnOra.Dispose();

            dt_excel = dtOrdenes;

            DataRow dr;

            int total = 0,total_dev = 0,total_ret = 0;

            foreach (DataRow drOrdenItem in dtOrdenes.Rows)
            {

                dr = dt.NewRow();

                dr["CONTRATISTA"] = drOrdenItem["CONTRATISTA"].ToString();
                dr["REGION"] = drOrdenItem["REGION"].ToString();
                dr["BODEGA"] = drOrdenItem["BODEGA"].ToString();
                dr["ID_BODEGA"] = drOrdenItem["ID_BODEGA"].ToString();
                dr["CATEGORIA"] = drOrdenItem["CATEGORIA"].ToString();
                dr["DIAMETRO"] = drOrdenItem["DIAMETRO"].ToString();
                dr["CANTIDAD_RETIRADO"] = drOrdenItem["CANTIDAD_RETIRADO"].ToString();
                dr["CANTIDAD_DEVOLUCION"] = drOrdenItem["CANTIDAD_DEVOLUCION"].ToString();
                dr["CANTIDAD_CORRECCION"] = drOrdenItem["CANTIDAD_CORRECCION"].ToString();

               
                try
                {
                    int cant_corr = int.Parse(drOrdenItem["CORRECCION_DEVOLUCION"].ToString());
                    if (cant_corr >= 0) dr["CANTIDAD_DEVOLUCION"] = drOrdenItem["CORRECCION_DEVOLUCION"].ToString();
                                   
                    //si la cantidad de corrección resulta ser la misma de devolución, dejamos como ok "-".
                    int cant_solicitud = int.Parse(drOrdenItem["CANTIDAD_CORRECCION"].ToString());
                    if(cant_corr == cant_solicitud) dr["CANTIDAD_CORRECCION"] = "-";
                    
                }catch(Exception ex){
                }

                try{
                    //sumamos devolucion y retirado
                    total_ret += int.Parse(dr["CANTIDAD_RETIRADO"].ToString());
                    total_dev += int.Parse(dr["CANTIDAD_DEVOLUCION"].ToString());
                } catch(Exception ex){
                }
                              

                if (tipo.Equals("DETALLE"))
                {

                    dr["ID_SERVICIO"] = drOrdenItem["ID_SERVICIO"].ToString();
                    dr["CAUSA"] = drOrdenItem["CAUSA"].ToString();
                    dr["SERIE_MEDIDOR_RET"] = drOrdenItem["SERIE_MEDIDOR_RET"].ToString();
                    dr["FECHA_INST"] = drOrdenItem["FECHA_INST"].ToString();
                    dr["INSTALADOR"] = drOrdenItem["INSTALADOR"].ToString();
                    dr["FECHA_DEVOLUCION"] = drOrdenItem["FECHA_DEVOLUCION"].ToString();
                }

                
                dt.Rows.Add(dr);

                total = total + 1;

            }

            DataView MydataView;
            MydataView = new DataView(dt);
            gridOrden.DataSource = MydataView;
            gridOrden.DataBind();

            lbTotal.Text = total + " registro(s) encontrado(s)";
            lbResultado.Text = "Total devolución/retirado: " + total_dev + "/" + total_ret;
            GridViewRow gvRow;
            Image correcto = new Image();
            Image actualizar = new Image();

            for (int i = 0; i < gridOrden.Rows.Count; i++)
            {

                gvRow = gridOrden.Rows[i];
                correcto = (Image)(gvRow.FindControl("btn_correcto"));
                actualizar = (Image)(gvRow.FindControl("btn_confirmar"));
                int ret = 0, dev = 0;

                try
                {
                    ret = int.Parse(gvRow.Cells[6].Text);
                    dev = int.Parse(gvRow.Cells[5].Text);


                    if (dev > 0 && dev < ret)
                    {
                        gvRow.Cells[5].ForeColor = System.Drawing.Color.White;
                        gvRow.Cells[5].BackColor = System.Drawing.Color.Orange;
                    }
                    else if (dev == 0)
                    {
                        gvRow.Cells[5].ForeColor = System.Drawing.Color.White;
                        gvRow.Cells[5].BackColor = System.Drawing.Color.IndianRed;

                    }
                }
                catch (Exception ex)
                {
                    gvRow.Cells[5].ForeColor = System.Drawing.Color.Black;
                    gvRow.Cells[5].BackColor = System.Drawing.Color.Yellow;
                    continue;
                }

                String solicitud = gvRow.Cells[8].Text;

                if (solicitud.Equals(gvRow.Cells[5].Text) || solicitud.Equals("-"))
                {
                    correcto.Visible = true;
                    actualizar.Visible = false;
                }
                else
                {
                    correcto.Visible = false;
                    actualizar.Visible = true;
                }
               

            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + ex.Message.ToString() + "');", true);

            //ERROR AL INTEGRAR ARCHIVO.
        }

    }

    protected void gridOrden_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = (GridViewRow)gridOrden.Rows[index];//migrilla.Rows[index];
            TextBox tb_correccion;

            tb_correccion = (TextBox)row.Cells[0].FindControl("CORRECCION_DEVOLUCION");

            var colsNoVisible = gridOrden.DataKeys[index].Values;
            string valor_correccion, categoria, diametro, bodega, valor_anterior, valor_retirado, operador,valor_solicitud;
            bodega = (string)colsNoVisible[0]; //row.Cells[1].Text;
            valor_correccion = tb_correccion.Text;
            categoria = row.Cells[3].Text;
            diametro = row.Cells[4].Text;
            valor_anterior = row.Cells[5].Text;
            valor_retirado = row.Cells[6].Text;
            valor_solicitud = row.Cells[8].Text;
            operador = cb_operador.SelectedValue;
            lb_mensaje.Text = "";

            if (e.CommandName == "VALIDAR")
            {
                if (validar_correccion(valor_correccion, valor_retirado, valor_anterior))
                {
                    guardar_correccion_devolucion(bodega, categoria, diametro, valor_anterior, valor_correccion, operador, "", lb_id_usuario.Text,
                        fill_checkbox_list(cb_tipo_proceso));

                    carga_operadores(cb_contratista.SelectedValue);
                    cb_operador.SelectedValue = operador;

                    carga_grilla_detalle(fill_checkbox_list(cb_bodega),
                    fill_checkbox_list(cb_categoria), fill_checkbox_list(cb_tipo_proceso), cb_operador.SelectedValue, "RESUMEN", txtDesde.Text, txtHasta.Text);

                }
            }
            else if (e.CommandName == "CONFIRMAR")
            {
                if (validar_correccion(valor_solicitud, valor_retirado, valor_anterior))
                {
                    guardar_correccion_devolucion(bodega, categoria, diametro, valor_anterior, valor_solicitud, operador, "", lb_id_usuario.Text,
                        fill_checkbox_list(cb_tipo_proceso));

                    carga_operadores(cb_contratista.SelectedValue);
                    cb_operador.SelectedValue = operador;

                    carga_grilla_detalle(fill_checkbox_list(cb_bodega),
                    fill_checkbox_list(cb_categoria), fill_checkbox_list(cb_tipo_proceso), cb_operador.SelectedValue, "RESUMEN", txtDesde.Text, txtHasta.Text);


                    
                }
                
            }        
        }
        catch (Exception ex)
        {
            lb_mensaje.ForeColor = System.Drawing.Color.Red;
            lb_mensaje.Text = "Error: " + ex.Message;
        }


    }

    public Boolean validar_correccion(String valor_correccion, String valor_retirado, String valor_anterior)
    {
        if (valor_correccion.Length > 0) //debe tener algún número.
        {
            int n;
            if (int.TryParse(valor_correccion, out n))
            {
                if (int.Parse(valor_correccion) <= int.Parse(valor_retirado) && int.Parse(valor_correccion) >= 0)
                {
                    if (valor_correccion != valor_anterior)
                    {
                        return true;
                    }
                    else
                    {
                        lb_mensaje.ForeColor = System.Drawing.Color.Red;
                        lb_mensaje.Text = "Mismo valor al de devolución";
                    }

                }
                else
                {
                    lb_mensaje.ForeColor = System.Drawing.Color.Red;
                    lb_mensaje.Text = "Debe ingresar número entre 0 y " + valor_retirado;
                }

            }
            else
            {
                lb_mensaje.ForeColor = System.Drawing.Color.Red;
                lb_mensaje.Text = "Se permiten sólo números enteros";
            }
        }
        else
        {
            lb_mensaje.ForeColor = System.Drawing.Color.Red;
            lb_mensaje.Text = "Debe ingresar un número válido";
        }

        return false;

    }

    public void guardar_correccion_devolucion(String bodega, String categoria, String diametro,String anterior, String correccion,
        String cod_instalador, String observacion,String usuario,String tipo_proceso)
    {
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_INFORME_CHATARRA.GUARDAR_CORRECCION_CHATARRA", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "i_bodega", OracleType.Number, ParameterDirection.Input, bodega);
        PRO.agrega_parametro_sp(da, "i_categoria", OracleType.NVarChar, ParameterDirection.Input, categoria);
        PRO.agrega_parametro_sp(da, "i_diametro", OracleType.Number, ParameterDirection.Input, diametro);
        PRO.agrega_parametro_sp(da, "i_cantidad_anterior", OracleType.Number, ParameterDirection.Input, anterior);
        PRO.agrega_parametro_sp(da, "i_cantidad", OracleType.Number, ParameterDirection.Input, correccion);
        PRO.agrega_parametro_sp(da, "i_cod_instalador", OracleType.Number, ParameterDirection.Input, cod_instalador);
        PRO.agrega_parametro_sp(da, "i_observacion", OracleType.NVarChar, ParameterDirection.Input, observacion);
        PRO.agrega_parametro_sp(da, "i_id_usuario", OracleType.Number, ParameterDirection.Input, usuario);
        PRO.agrega_parametro_sp(da, "i_tipo_proceso", OracleType.NVarChar, ParameterDirection.Input, tipo_proceso);
        
        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        try
        {
            CnOra.Open();

            da.SelectCommand.ExecuteNonQuery();
            CnOra.Close();
            CnOra.Dispose();
            lb_mensaje.ForeColor = System.Drawing.Color.DarkGreen;
            lb_mensaje.Text = "CORRECCIÓN DE DEVOLUCIÓN REALIZADA!";


        }
        catch (Exception ex)
        {
            lb_mensaje.ForeColor = System.Drawing.Color.Red;
            lb_mensaje.Text = ex.Message;
            CnOra.Close();
            CnOra.Dispose();

        }
    }

    

    protected void btn_genera_excel_Click(object sender, EventArgs e)
    {
        if (gridOrden.Rows.Count > 0)
        {
           
            datatable_to_excel(dt_excel);
        }
        else ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('No hay registros para decargar');", true);

    }
    protected void check_region_Click(object sender, EventArgs e)
    {
        for (int item = 0; item < cb_region.Items.Count; item++)
        {
            if (cb_region.Items[item].Selected == false)
            {
                cb_region.Items[item].Selected = true;

            }
            else
            {
                cb_region.Items[item].Selected = false;
            }
        }

        carga_bodegas(cb_contratista.SelectedValue, fill_checkbox_list(cb_region));
    }

    protected void check_bodega_Click(object sender, EventArgs e)
    {
        for (int item = 0; item < cb_bodega.Items.Count; item++)
        {
            if (cb_bodega.Items[item].Selected == false)
            {
                cb_bodega.Items[item].Selected = true;

            }
            else
            {
                cb_bodega.Items[item].Selected = false;
            }
        }
    }

    protected void check_categoria_Click(object sender, EventArgs e)
    {
        for (int item = 0; item < cb_categoria.Items.Count; item++)
        {
            if (cb_categoria.Items[item].Selected == false)
            {
                cb_categoria.Items[item].Selected = true;

            }
            else
            {
                cb_categoria.Items[item].Selected = false;
            }
        }
    }

    protected void check_tipo_proceso_Click(object sender, EventArgs e)
    {
        for (int item = 0; item < cb_tipo_proceso.Items.Count; item++)
        {
            if (cb_tipo_proceso.Items[item].Selected == false)
            {
                cb_tipo_proceso.Items[item].Selected = true;

            }
            else
            {
                cb_tipo_proceso.Items[item].Selected = false;
            }
        }
    }

    protected void cb_contratista_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_bodegas(cb_contratista.SelectedValue, fill_checkbox_list(cb_region));
        carga_operadores(cb_contratista.SelectedValue);
    }

    protected void Button1_Click1(object sender, EventArgs e)
    {
        carga_grilla_detalle(fill_checkbox_list(cb_bodega),
        fill_checkbox_list(cb_categoria), fill_checkbox_list(cb_tipo_proceso), cb_operador.SelectedValue, "RESUMEN", txtDesde.Text, txtHasta.Text);


        if (cb_operador.SelectedIndex > 0)
        {
            gridOrden.Columns[9].Visible = true;
            gridOrden.Columns[10].Visible = true;
            gridOrden.Columns[11].Visible = true;
        }
        else
        {
            gridOrden.Columns[9].Visible = false;
            gridOrden.Columns[10].Visible = false;
            gridOrden.Columns[11].Visible = false;
        }

        //según perfil permitimos ver las solicitudes por confirmar.
        valida_permisos_perfil(lb_id_perfil.Text);
    }
    protected void cb_region_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_bodegas(cb_contratista.SelectedValue, fill_checkbox_list(cb_region));
    }


    protected void cb_operador_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(fill_checkbox_list(cb_bodega),
        fill_checkbox_list(cb_categoria), fill_checkbox_list(cb_tipo_proceso), cb_operador.SelectedValue, "RESUMEN", txtDesde.Text, txtHasta.Text);

        if (cb_operador.SelectedIndex > 0)
        {
            gridOrden.Columns[9].Visible = true;
            gridOrden.Columns[10].Visible = true;
            gridOrden.Columns[11].Visible = true;
        }
        else
        {
            gridOrden.Columns[9].Visible = false;
            gridOrden.Columns[10].Visible = false;
            gridOrden.Columns[11].Visible = false;
        }

        //según perfil permitimos ver las solicitudes por confirmar.
        valida_permisos_perfil(lb_id_perfil.Text);
    }


    protected void cb_tipo_proceso_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(fill_checkbox_list(cb_bodega),
       fill_checkbox_list(cb_categoria), fill_checkbox_list(cb_tipo_proceso), cb_operador.SelectedValue, "RESUMEN", txtDesde.Text, txtHasta.Text);

      
    }
}
