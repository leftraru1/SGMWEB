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

public partial class ReporteStock : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();
    String id_contr = "0";
    DataTable dt_excel = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            try
            {
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                PRO.recSession(rutaXml, "RUT_EMPRESA");
                id_contr = PRO.recSession(rutaXml, "ID_CONTRATISTA");
                
                carga_contratista(id_contr);
                //cargamos los filtros multiples.
                carga_region();
                carga_bodegas(cb_contratista.SelectedValue, fill_checkbox_list(cb_region));
                carga_categorias();
                carga_diametro();

                //iniciamos las fechas con un rango de 3 meses hasta la fecha de hoy.
                txtDesde.Text = DateTime.Now.AddDays(-90).ToString("dd-MM-yyyy");
                txtHasta.Text = DateTime.Now.ToString("dd-MM-yyyy");

                //cargamos tabla.
                carga_grilla_detalle(txtDesde.Text, txtHasta.Text, fill_checkbox_list(cb_bodega),
                fill_checkbox_list(cb_categoria), fill_checkbox_list(cb_diametro), "");

                IMG2.Visible = false;
                
            }
            catch (Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }
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

    //CARGA DIAMETROS POSIBLES PARA EL STOCK MINIMO.
    public void carga_diametro()
    {

        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_STOCK_MINIMO.CARGA_DIAMETROS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "DIAMETRO");
        objConexion.Close();

        int i = 0;

        cb_diametro.Items.Clear();

        foreach (DataRow row in objDS.Tables["DIAMETRO"].Rows)
        {

            cb_diametro.Items.Add(row[0].ToString());
            cb_diametro.Items[i].Value = row[0].ToString();
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
        carga_grilla_detalle(txtDesde.Text, txtHasta.Text, fill_checkbox_list(cb_bodega),
                fill_checkbox_list(cb_categoria), fill_checkbox_list(cb_diametro), "");
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
            String fecha = DateTime.Now.ToString("ddMMyyyy");

            sr = new StreamWriter(Server.MapPath("./SALIDA/" + "DETALLE_STOCK" + fecha + ".csv"));

            //FILTROS REALIZADOS.
            //salida = "CONTRATISTA: " + cb_contratista.SelectedItem + " // REGIONES: " + fill_checkbox_list_names(cb_region) ;
            //sr.WriteLine(salida);
            //salida = "BODEGAS: " + fill_checkbox_list_names(cb_bodega);
            //sr.WriteLine(salida);
            //salida = "CATEGORIAS: " + fill_checkbox_list_names(cb_categoria);
            //sr.WriteLine(salida);
            //salida = "DIAMETROS: " + fill_checkbox_list_names(cb_diametro);
            //sr.WriteLine(salida);

            //sr.WriteLine("");

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

            Response.Redirect("./SALIDA/" + "DETALLE_STOCK" + fecha + ".csv", false);
        }
        catch (Exception ex)
        {
            String exp = ex.ToString();
        }
    }

    public void carga_grilla_detalle(String desde, String hasta, String bodega, String categoria,
        String diametro, String tipo_proceso)
    {

        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
        id_contr = PRO.recSession(rutaXml, "ID_CONTRATISTA");

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_REPORTE_STOCK.CARGA_STOCK", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        if (bodega.Length == 0)
        {
            if (cb_bodega.Items.Count == 0) bodega = "0";
            else bodega = get_all_checkbox_list(cb_bodega);
        }
        
        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_categoria", OracleType.NVarChar, ParameterDirection.Input, categoria);
        PRO.agrega_parametro_sp(da, "i_diametro", OracleType.NVarChar, ParameterDirection.Input, diametro);
        PRO.agrega_parametro_sp(da, "i_bodega", OracleType.NVarChar, ParameterDirection.Input, bodega);
        PRO.agrega_parametro_sp(da, "i_desde", OracleType.NVarChar, ParameterDirection.Input, desde);
        PRO.agrega_parametro_sp(da, "i_hasta", OracleType.NVarChar, ParameterDirection.Input, hasta);

        
        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("CATEGORIA", typeof(String)));
        dt.Columns.Add(new DataColumn("DIAMETRO", typeof(String)));
        dt.Columns.Add(new DataColumn("NO_DISPONIBLE", typeof(String)));
        dt.Columns.Add(new DataColumn("POR_VALIDAR", typeof(String)));
        dt.Columns.Add(new DataColumn("DISPONIBLE", typeof(String)));
        dt.Columns.Add(new DataColumn("ASIGNADO", typeof(String)));
        dt.Columns.Add(new DataColumn("EN_TERRENO", typeof(String)));
        dt.Columns.Add(new DataColumn("INSTALADO", typeof(String)));
        dt.Columns.Add(new DataColumn("DADO_BAJA", typeof(String)));
        dt.Columns.Add(new DataColumn("EXTRAVIADO", typeof(String)));
        dt.Columns.Add(new DataColumn("EN_DIFERENCIA", typeof(String)));
        dt.Columns.Add(new DataColumn("TOTAL", typeof(String)));

        try
        {
            DataTable dtOrdenes = new DataTable();
            CnOra.Open();

            da.Fill(dtOrdenes);
            grdExcel.DataSource = dtOrdenes;
            grdExcel.DataBind();
            CnOra.Close();
            CnOra.Dispose();

            dt_excel = dt;

            DataRow dr;

            int total = 0;

            foreach (DataRow drOrdenItem in dtOrdenes.Rows)
            {

                dr = dt.NewRow();

                dr["CATEGORIA"] = drOrdenItem["CATEGORIA"].ToString();
                dr["DIAMETRO"] = drOrdenItem["DIAMETRO"].ToString();
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

                dt.Rows.Add(dr);

                total = total + 1;

            }

            DataView MydataView;
            MydataView = new DataView(dt);
            gridOrden.DataSource = MydataView;
            gridOrden.DataBind();

            lbTotal.Text = total + " registro(s) encontrado(s)";

        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + ex.Message.ToString() + "');", true);

            //ERROR AL INTEGRAR ARCHIVO.
        }

    }

    public void carga_grilla_detalle_x_bodega(String desde, String hasta, String bodega, String categoria,
        String diametro, String tipo_proceso)
    {

        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
        id_contr = PRO.recSession(rutaXml, "ID_CONTRATISTA");

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_REPORTE_STOCK.CARGA_STOCK_X_BODEGA", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        if (bodega.Length == 0) bodega = get_all_checkbox_list(cb_bodega);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_categoria", OracleType.NVarChar, ParameterDirection.Input, categoria);
        PRO.agrega_parametro_sp(da, "i_diametro", OracleType.NVarChar, ParameterDirection.Input, diametro);
        PRO.agrega_parametro_sp(da, "i_bodega", OracleType.NVarChar, ParameterDirection.Input, bodega);
        PRO.agrega_parametro_sp(da, "i_desde", OracleType.NVarChar, ParameterDirection.Input, desde);
        PRO.agrega_parametro_sp(da, "i_hasta", OracleType.NVarChar, ParameterDirection.Input, hasta);


        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("CONTRATISTA", typeof(String)));
        dt.Columns.Add(new DataColumn("REGION", typeof(String)));
        dt.Columns.Add(new DataColumn("NOMBRE_BODEGA", typeof(String)));
        dt.Columns.Add(new DataColumn("CATEGORIA", typeof(String)));
        dt.Columns.Add(new DataColumn("DIAMETRO", typeof(String)));
        dt.Columns.Add(new DataColumn("STOCK_MINIMO", typeof(String)));
        dt.Columns.Add(new DataColumn("NO_DISPONIBLE", typeof(String)));
        dt.Columns.Add(new DataColumn("POR_VALIDAR", typeof(String)));
        dt.Columns.Add(new DataColumn("DISPONIBLE", typeof(String)));
        dt.Columns.Add(new DataColumn("ASIGNADO", typeof(String)));
        dt.Columns.Add(new DataColumn("EN_TERRENO", typeof(String)));
        dt.Columns.Add(new DataColumn("INSTALADO", typeof(String)));
        dt.Columns.Add(new DataColumn("DADO_BAJA", typeof(String)));
        dt.Columns.Add(new DataColumn("EXTRAVIADO", typeof(String)));
        dt.Columns.Add(new DataColumn("EN_DIFERENCIA", typeof(String)));
        dt.Columns.Add(new DataColumn("TOTAL", typeof(String)));

        try
        {
            DataTable dtOrdenes = new DataTable();
            CnOra.Open();

            da.Fill(dtOrdenes);
            grdExcel.DataSource = dtOrdenes;
            grdExcel.DataBind();
            CnOra.Close();
            CnOra.Dispose();

            dt_excel = dt;

            DataRow dr;

            int total = 0;

            foreach (DataRow drOrdenItem in dtOrdenes.Rows)
            {

                dr = dt.NewRow();

                dr["CONTRATISTA"] = drOrdenItem["CONTRATISTA"].ToString();
                dr["REGION"] = drOrdenItem["REGION"].ToString();
                dr["NOMBRE_BODEGA"] = drOrdenItem["NOMBRE_BODEGA"].ToString();
                dr["CATEGORIA"] = drOrdenItem["CATEGORIA"].ToString();
                dr["STOCK_MINIMO"] = drOrdenItem["STOCK_MINIMO"].ToString();
                dr["DIAMETRO"] = drOrdenItem["DIAMETRO"].ToString();
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

                dt.Rows.Add(dr);

                total = total + 1;

            }                       

        }
        catch (Exception ex)
            {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + ex.Message.ToString() + "');", true);

            //ERROR AL INTEGRAR ARCHIVO.
        }

    }
   

    protected void btn_genera_excel_Click(object sender, EventArgs e)
    {
        if (gridOrden.Rows.Count > 0)
        {
            carga_grilla_detalle_x_bodega(txtDesde.Text, txtHasta.Text, fill_checkbox_list(cb_bodega),
                fill_checkbox_list(cb_categoria),fill_checkbox_list(cb_diametro),"");

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

    protected void check_diametro_Click(object sender, EventArgs e)
    {
        for (int item = 0; item < cb_diametro.Items.Count; item++)
        {
            if (cb_diametro.Items[item].Selected == false)
            {
                cb_diametro.Items[item].Selected = true;

            }
            else
            {
                cb_diametro.Items[item].Selected = false;
            }
        }
    }

    protected void cb_contratista_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_bodegas(cb_contratista.SelectedValue, fill_checkbox_list(cb_region));
    }

    protected void Button1_Click1(object sender, EventArgs e)
    {
        carga_grilla_detalle(txtDesde.Text, txtHasta.Text, fill_checkbox_list(cb_bodega),
                fill_checkbox_list(cb_categoria), fill_checkbox_list(cb_diametro), "");
    }
    protected void cb_region_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_bodegas(cb_contratista.SelectedValue, fill_checkbox_list(cb_region));
    }

  
}
