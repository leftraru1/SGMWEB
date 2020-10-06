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

public partial class ReporteOrdenes : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();
    String id_contr = "0";
    public static DataTable dt_excel = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            try
            {
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                PRO.recSession(rutaXml, "RUT_EMPRESA");
                id_contr = PRO.recSession(rutaXml, "ID_CONTRATISTA");

                //cargamos los filtros.
                carga_region();
                carga_zona(cb_region.SelectedValue);
                carga_localidad(cb_region.SelectedValue, cb_zona.SelectedValue);
                carga_lote(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue);
                carga_libreta(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue);
                carga_estado_varal();
                carga_instalacion_llave();

                //cargamos los filtros multiples.
                carga_tipoproceso();
                carga_improcedencia();

                //cargamos contratista si lo amerita.
                if (id_contr.Equals("0"))
                {
                    label_contratista.Visible = true;
                    cb_contratista.Visible = true;
                    carga_contratista();
                }
                else
                {
                    label_contratista.Visible = false;
                    cb_contratista.Visible = false;
                }

                //iniciamos las fechas con un rango de 3 meses hasta la fecha de hoy.
                txtDesde.Text = DateTime.Now.AddDays(-90).ToString("dd-MM-yyyy");
                txtHasta.Text = DateTime.Now.ToString("dd-MM-yyyy");

                //cargamos tabla.
                //carga_grilla_detalle(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue, cb_libreta.SelectedValue,
                //cb_contratista.SelectedValue, fill_checkbox_list(cb_tipo_proceso), fill_checkbox_list(cb_improcedencia), TextboxNumOrden.Text, txtServ.Text, txtDesde.Text, txtHasta.Text);

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
                    selecciones = mi_selector.Items[i].Value;
                    bandera = bandera + 1;
                }
                else
                {
                    selecciones = mi_selector.Items[i].Value + "," + selecciones;
                }
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

        int i = 1;
        cb_region.Items.Clear();
        cb_region.Items.Add("TODAS...");
        cb_region.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["REGION"].Rows)
        {

            cb_region.Items.Add(row[1].ToString());
            cb_region.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }

    //CARGAMOS LAS ZONAS EN FUNCIÓN DE LA REGIÓN SELECCIONADA.
    public void carga_zona(String region)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_REPORTE_ORDENES.CARGA_ZONA", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_region", OracleType.Number, ParameterDirection.Input, region);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "ZONA");
        objConexion.Close();

        int i = 1;
        cb_zona.Items.Clear();
        cb_zona.Items.Add("TODAS...");
        cb_zona.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["ZONA"].Rows)
        {
            cb_zona.Items.Add(row[1].ToString());
            cb_zona.Items[i].Value = row[0].ToString();
            i = i + 1;
        }
    }

    //CARGAMOS LAS LOCALIDADES EN FUNCIÓN DE LA REGIÓN Y/O ZONA SELECCIONADA.
    public void carga_localidad(String region, String zona)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_REPORTE_ORDENES.CARGA_LOCALIDAD", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_region", OracleType.Number, ParameterDirection.Input, region);
        PRO.agrega_parametro_sp(objComando, "i_zona", OracleType.Number, ParameterDirection.Input, zona);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "LOCALIDAD");
        objConexion.Close();

        int i = 1;
        cb_localidad.Items.Clear();
        cb_localidad.Items.Add("TODAS...");
        cb_localidad.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["LOCALIDAD"].Rows)
        {
            cb_localidad.Items.Add(row[1].ToString());
            cb_localidad.Items[i].Value = row[0].ToString();
            i = i + 1;
        }
    }

    //CARGAMOS LOS LOTES EN FUNCIÓN DE LA REGIÓN, ZONA Y/O LOCALIDAD SELECCIONADA.
    public void carga_lote(String region, String zona, String localidad)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_REPORTE_ORDENES.CARGA_LOTE", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_region", OracleType.Number, ParameterDirection.Input, region);
        PRO.agrega_parametro_sp(objComando, "i_zona", OracleType.Number, ParameterDirection.Input, zona);
        PRO.agrega_parametro_sp(objComando, "i_localidad", OracleType.Number, ParameterDirection.Input, localidad);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "LOTE");
        objConexion.Close();

        int i = 1;
        cb_lote.Items.Clear();
        cb_lote.Items.Add("TODOS...");
        cb_lote.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["LOTE"].Rows)
        {
            cb_lote.Items.Add(row[0].ToString());
            cb_lote.Items[i].Value = row[0].ToString();
            i = i + 1;
        }
    }

    //CARGAMOS LAS LIBRETAS EN FUNCIÓN DE LA REGIÓN, ZONA, LOCALIDAD Y/O LOTE SELECCIONADO.
    public void carga_libreta(String region, String zona, String localidad, String lote)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_REPORTE_ORDENES.CARGA_LIBRETA", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_region", OracleType.Number, ParameterDirection.Input, region);
        PRO.agrega_parametro_sp(objComando, "i_zona", OracleType.Number, ParameterDirection.Input, zona);
        PRO.agrega_parametro_sp(objComando, "i_localidad", OracleType.Number, ParameterDirection.Input, localidad);
        PRO.agrega_parametro_sp(objComando, "i_lote", OracleType.Number, ParameterDirection.Input, lote);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "LIBRETA");
        objConexion.Close();

        int i = 1;
        cb_libreta.Items.Clear();
        cb_libreta.Items.Add("TODAS...");
        cb_libreta.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["LIBRETA"].Rows)
        {
            cb_libreta.Items.Add(row[0].ToString());
            cb_libreta.Items[i].Value = row[0].ToString();
            i = i + 1;
        }
    }

    //CARGAMOS LOS CONTRATISTAS.
    public void carga_contratista()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_REPORTE_ORDENES.CARGA_CONTRATISTA", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "CONTRATISTA");
        objConexion.Close();

        int i = 1;
        cb_contratista.Items.Clear();
        cb_contratista.Items.Add("TODOS...");
        cb_contratista.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["CONTRATISTA"].Rows)
        {
            cb_contratista.Items.Add(row[1].ToString());
            cb_contratista.Items[i].Value = row[0].ToString();
            i = i + 1;
        }
    }

    //CARGAMOS LOS TIPOS DE PROCESO.
    public void carga_tipoproceso()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_REPORTE_ORDENES.CARGA_TIPOPROCESO", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "TIPOPROCESO");
        objConexion.Close();

        int i = 0;
        cb_tipo_proceso.Items.Clear();

        foreach (DataRow row in objDS.Tables["TIPOPROCESO"].Rows)
        {
            cb_tipo_proceso.Items.Add(row[1].ToString());
            cb_tipo_proceso.Items[i].Value = row[0].ToString();
            i = i + 1;
        }
    }

    //CARGAMOS LOS ESTADOS DE LOS VARALES
    public void carga_estado_varal()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_REPORTE_ORDENES.CARGA_ESTADO_VARAL", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "ESTADO_VARAL");
        objConexion.Close();

        int i = 1;
        cb_estado_varal.Items.Clear();
        cb_estado_varal.Items.Add("TODOS...");
        cb_estado_varal.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["ESTADO_VARAL"].Rows)
        {
            cb_estado_varal.Items.Add(row[1].ToString());
            cb_estado_varal.Items[i].Value = row[0].ToString();
            i = i + 1;
        }
    }

    //CARGAMOS LOS ESTADOS INSTALACION DE LLAVE.
    public void carga_instalacion_llave()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_REPORTE_ORDENES.CARGA_INSTALACION_LLAVE", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "INSTALACION_LLAVE");
        objConexion.Close();

        int i = 1;
        cb_instalacion_llave.Items.Clear();
        cb_instalacion_llave.Items.Add("TODOS...");
        cb_instalacion_llave.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["INSTALACION_LLAVE"].Rows)
        {
            cb_instalacion_llave.Items.Add(row[1].ToString());
            cb_instalacion_llave.Items[i].Value = row[0].ToString();
            i = i + 1;
        }
    }

    //CARGAMOS LAS IMPROCEDENCIAS
    public void carga_improcedencia()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_REPORTE_ORDENES.CARGA_IMPROCEDENCIA", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "IMPROCEDENCIA");
        objConexion.Close();

        int i = 0;
        cb_improcedencia.Items.Clear();

        foreach (DataRow row in objDS.Tables["IMPROCEDENCIA"].Rows)
        {
            cb_improcedencia.Items.Add(row[1].ToString());
            cb_improcedencia.Items[i].Value = row[0].ToString();
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
        carga_grilla_detalle(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue, cb_libreta.SelectedValue,
            cb_contratista.SelectedValue, fill_checkbox_list(cb_tipo_proceso), fill_checkbox_list(cb_improcedencia), TextboxNumOrden.Text, txtServ.Text,
            txtDesde.Text, txtHasta.Text, cb_estado_varal.SelectedValue, cb_instalacion_llave.SelectedValue);
    }

    protected void txtServ_TextChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue, cb_libreta.SelectedValue,
            cb_contratista.SelectedValue, fill_checkbox_list(cb_tipo_proceso), fill_checkbox_list(cb_improcedencia), TextboxNumOrden.Text, txtServ.Text,
            txtDesde.Text, txtHasta.Text, cb_estado_varal.SelectedValue, cb_instalacion_llave.SelectedValue);
    }
    protected void Button1_Click1(object sender, EventArgs e)
    {
        carga_grilla_detalle(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue, cb_libreta.SelectedValue,
            cb_contratista.SelectedValue, fill_checkbox_list(cb_tipo_proceso), fill_checkbox_list(cb_improcedencia), TextboxNumOrden.Text, txtServ.Text,
            txtDesde.Text, txtHasta.Text, cb_estado_varal.SelectedValue, cb_instalacion_llave.SelectedValue);
    }
    protected void lkbAsignar_Click(object sender, EventArgs e)
    {

    }

    /* ------------------Evento para actualizar la tabla segun el numero de orden que se busca---------------------------------*/

    protected void txtNumOrden_TextChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue, cb_libreta.SelectedValue,
             cb_contratista.SelectedValue, fill_checkbox_list(cb_tipo_proceso), fill_checkbox_list(cb_improcedencia), TextboxNumOrden.Text, txtServ.Text,
             txtDesde.Text, txtHasta.Text, cb_estado_varal.SelectedValue, cb_instalacion_llave.SelectedValue);
    }
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

    protected void cb_region_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_zona(cb_region.SelectedValue);
        carga_localidad(cb_region.SelectedValue, cb_zona.SelectedValue);
        carga_lote(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue);
        carga_libreta(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue);

        carga_grilla_detalle(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue, cb_libreta.SelectedValue,
             cb_contratista.SelectedValue, fill_checkbox_list(cb_tipo_proceso), fill_checkbox_list(cb_improcedencia), TextboxNumOrden.Text, txtServ.Text,
             txtDesde.Text, txtHasta.Text, cb_estado_varal.SelectedValue, cb_instalacion_llave.SelectedValue);
    }
    protected void cb_zona_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_localidad(cb_region.SelectedValue, cb_zona.SelectedValue);
        carga_lote(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue);
        carga_libreta(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue);

        carga_grilla_detalle(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue, cb_libreta.SelectedValue,
             cb_contratista.SelectedValue, fill_checkbox_list(cb_tipo_proceso), fill_checkbox_list(cb_improcedencia), TextboxNumOrden.Text, txtServ.Text,
             txtDesde.Text, txtHasta.Text, cb_estado_varal.SelectedValue, cb_instalacion_llave.SelectedValue);
    }
    protected void cb_localidad_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_lote(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue);
        carga_libreta(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue);

        carga_grilla_detalle(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue, cb_libreta.SelectedValue,
              cb_contratista.SelectedValue, fill_checkbox_list(cb_tipo_proceso), fill_checkbox_list(cb_improcedencia), TextboxNumOrden.Text, txtServ.Text,
              txtDesde.Text, txtHasta.Text, cb_estado_varal.SelectedValue, cb_instalacion_llave.SelectedValue);
    }
    protected void cb_lote_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_libreta(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue);
        carga_grilla_detalle(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue, cb_libreta.SelectedValue,
               cb_contratista.SelectedValue, fill_checkbox_list(cb_tipo_proceso), fill_checkbox_list(cb_improcedencia), TextboxNumOrden.Text, txtServ.Text,
               txtDesde.Text, txtHasta.Text, cb_estado_varal.SelectedValue, cb_instalacion_llave.SelectedValue);
    }
    protected void cb_libreta_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue, cb_libreta.SelectedValue,
             cb_contratista.SelectedValue, fill_checkbox_list(cb_tipo_proceso), fill_checkbox_list(cb_improcedencia), TextboxNumOrden.Text, txtServ.Text,
             txtDesde.Text, txtHasta.Text, cb_estado_varal.SelectedValue, cb_instalacion_llave.SelectedValue);
    }
    protected void cb_contratista_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue, cb_libreta.SelectedValue,
             cb_contratista.SelectedValue, fill_checkbox_list(cb_tipo_proceso), fill_checkbox_list(cb_improcedencia), TextboxNumOrden.Text, txtServ.Text,
             txtDesde.Text, txtHasta.Text, cb_estado_varal.SelectedValue, cb_instalacion_llave.SelectedValue);
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

    protected void check_improcedencia_Click(object sender, EventArgs e)
    {
        for (int item = 0; item < cb_improcedencia.Items.Count; item++)
        {
            if (cb_improcedencia.Items[item].Selected == false)
            {
                cb_improcedencia.Items[item].Selected = true;

            }
            else
            {
                cb_improcedencia.Items[item].Selected = false;
            }
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

            sr = new StreamWriter(Server.MapPath("./SALIDA/" + "DETALLE_ORDENES" + DateTime.Now.ToString("ddMMyyyy") + ".csv"));

            salida = " VISITA" + ";"
                        + "SERVICIO" + ";"
                        + "NUMERO ORDEN" + ";"
                        + "FECHA CREACION" + ";"
                        + "FECHA INTEGRACION" + ";"
                        + "ESTADO MEDIDOR RETIRADO" + ";"
                        + "DIAMETRO RETIRADO " + ";"
                        + "SERIE MEDIDOR RETIRADO" + ";"
                        + "LEECTURA RETIRADO" + ";"
                        + "DIAMETRO NUEVO" + ";"
                        + "NUMERO MEDIDOR NUEVO" + ";"
                        + "LECTURA MEDIDOR NUEVO" + ";"
                        + "RUTA" + ";"
                        + "LOCALIDAD" + ";"
                        + "TIPO PROCESO" + ";"
                        + "INSTALADOR" + ";"
                        + "CONTRATISTA" + ";"
                        + "IMPROCEDENCIA" + ";"
                        + "FECHA EJECUCION" + ";"
                        + "CAUSA CAMBIO" + ";"
                        + "CODIGO CONTRATISTA" + ";"
                        + "ULTIMA LECTURA EF" + ";"
                        + "FECHA ULTIMA LECTURA EF" + ";"
                        + "PROMEDIO" + ";"
                        + "GESTION CORTE" + ";"
                        + "DEN. TECNICA" + ";"
                        + "SERIE MEDIDOR" + ";"
                        + "TIPO INSTALACION" + ";"

                        + "CLIENTE" + ";"
                        + "DIRECCION" + ";"
                        + "FECHA MED EXISTENTE" + ";"
                        + "OBSERVACION IN" + ";"
                        + "OBSERVACION OUT" + ";"
                        + "COD LOCALIDAD" + ";"
                        + "COD IMPROCEDENCIA" + ";"
                        + "COD MARCA" + ";"
                        + "ANIO MEDIDOR NUEVO" + ";"
                        + "COD VARAL" + ";"
                        + "COD LLAVE" + ";"
                        + "RUT CLIENTE" + ";"
                        + "COOR X" + ";"
                        + "COOR Y" + ";"
                        + "SINCRONIZACION" + ";"
                        + "FIRMA" + ";"
                        + "COD TIPO SELLO" + ";"
                        + "SALIDA" + ";"
                        + "FECHA DESCARGA" + ";"
                        + "USUARIO" + ";"
                        + "FECHA CARGA APP" + ";"
                        + "CODIGO UNICO MEDIDOR" + ";"
                        + "FONO CONTACTO" + ";"
                        + "CORREO CONTACTO" + ";"
                        + "CANTIDAD AJUSTE" + ";"
                        + "CANTIDAD TUERCA NORMAL" + ";"
                        + "CANTIDAD TUERCA DIFERIDA" + ";"
                        + "CANTIDAD VAINA" + ";"
                        + "CANTIDAD MEDIDOR";

            sr.WriteLine(salida);

            foreach (DataRow drOrdenItem in dt.Rows)
            {
                dr = dt.NewRow();

                dr["VISITA"] = drOrdenItem["VISITA"].ToString();
                dr["ID_SERVICIO"] = drOrdenItem["ID_SERVICIO"].ToString();
                dr["NUMERO_ORDEN"] = drOrdenItem["NUMERO_ORDEN"].ToString();
                dr["FECHA_CREACION"] = drOrdenItem["FECHA_CREACION"].ToString();
                dr["FECHA_INTEGRACION"] = drOrdenItem["FECHA_INTEGRACION"].ToString();
                dr["ESTADO_MR"] = drOrdenItem["ESTADO_MR"].ToString();
                dr["DIAMETRO_RET"] = drOrdenItem["DIAMETRO_RET"].ToString();
                dr["SERIE_MEDIDOR_RET"] = drOrdenItem["SERIE_MEDIDOR_RET"].ToString();
                dr["LECTURA_RET"] = drOrdenItem["LECTURA_RET"].ToString();
                dr["DIAMETRO_NU"] = drOrdenItem["DIAMETRO_NU"].ToString();

                dr["NUMERO_MN"] = drOrdenItem["NUMERO_MN"].ToString();
                dr["LECTURA_MN"] = drOrdenItem["LECTURA_MN"].ToString();
                dr["RUTA"] = drOrdenItem["RUTA"].ToString();
                dr["LOCALIDAD"] = drOrdenItem["LOCALIDAD"].ToString();
                dr["TIPO_PROCESO"] = drOrdenItem["TIPO_PROCESO"].ToString();
                dr["INSTALADOR"] = drOrdenItem["INSTALADOR"].ToString();
                dr["CONTRATISTA"] = drOrdenItem["CONTRATISTA"].ToString();
                dr["IMPROCEDENCIA"] = drOrdenItem["IMPROCEDENCIA"].ToString();
                dr["FECHA_INST"] = drOrdenItem["FECHA_INST"].ToString();
                dr["CAUSA"] = drOrdenItem["CAUSA"].ToString();

                dr["COD_CONTRATISTA"] = drOrdenItem["COD_CONTRATISTA"].ToString();
                dr["UL_LECT_EF"] = drOrdenItem["UL_LECT_EF"].ToString();
                dr["FECHA_UL_LECT_EF"] = drOrdenItem["FECHA_UL_LECT_EF"].ToString();
                dr["PROMEDIO"] = drOrdenItem["PROMEDIO"].ToString();
                dr["GESTION_CORTE"] = drOrdenItem["GESTION_CORTE"].ToString();
                dr["TIPO_MARCA_DI"] = drOrdenItem["TIPO_MARCA_DI"].ToString();
                dr["SERIE_MEDIDOR"] = drOrdenItem["SERIE_MEDIDOR"].ToString();
                dr["TIPO_INSTALACION"] = drOrdenItem["TIPO_INSTALACION"].ToString();
                dr["CLIENTE"] = drOrdenItem["CLIENTE"].ToString();
                dr["DIRECCION"] = drOrdenItem["DIRECCION"].ToString();

                dr["FECHA_IN_ME"] = drOrdenItem["FECHA_IN_ME"].ToString();
                dr["OBSERVACION_IN"] = drOrdenItem["OBSERVACION_IN"].ToString();
                dr["OBSERVACION_OUT"] = drOrdenItem["OBSERVACION_OUT"].ToString();
                dr["COD_LOCALIDAD"] = drOrdenItem["COD_LOCALIDAD"].ToString();
                dr["COD_IMPROCEDENCIA"] = drOrdenItem["COD_IMPROCEDENCIA"].ToString();
                dr["COD_MARCA"] = drOrdenItem["COD_MARCA"].ToString();
                dr["ANO_MN"] = drOrdenItem["ANO_MN"].ToString();
                dr["COD_VARAL"] = drOrdenItem["COD_VARAL"].ToString();
                dr["COD_LLAVE"] = drOrdenItem["COD_LLAVE"].ToString();

                dr["RUT_CLIENTE"] = drOrdenItem["RUT_CLIENTE"].ToString();
                dr["X"] = drOrdenItem["X"].ToString();
                dr["Y"] = drOrdenItem["Y"].ToString();
                dr["SINCRONIZACION"] = drOrdenItem["SINCRONIZACION"].ToString();
                dr["FIRMA"] = drOrdenItem["FIRMA"].ToString();
                dr["COD_TIPOSELLO"] = drOrdenItem["COD_TIPOSELLO"].ToString();
                dr["SALIDA"] = drOrdenItem["SALIDA"].ToString();
                dr["FECHA_DESCARGA"] = drOrdenItem["FECHA_DESCARGA"].ToString();
                dr["ID_USUARIO"] = drOrdenItem["ID_USUARIO"].ToString();
                dr["FECHA_CARGA"] = drOrdenItem["FECHA_CARGA"].ToString();
                dr["CODIGO_UNICO"] = drOrdenItem["CODIGO_UNICO"].ToString();
                dr["FONO_CONTACTO"] = drOrdenItem["FONO_CONTACTO"].ToString();
                dr["CORREO_CONTACTO"] = drOrdenItem["CORREO_CONTACTO"].ToString();
                dr["ACCESORIO_AJUSTE"] = drOrdenItem["ACCESORIO_AJUSTE"].ToString();
                dr["ACCESORIO_TNORMAL"] = drOrdenItem["ACCESORIO_TNORMAL"].ToString();
                dr["ACCESORIO_TDIFERIDA"] = drOrdenItem["ACCESORIO_TDIFERIDA"].ToString();
                dr["ACCESORIO_VAINA"] = drOrdenItem["ACCESORIO_VAINA"].ToString();
                dr["ACCESORIO_MEDIDOR"] = drOrdenItem["ACCESORIO_MEDIDOR"].ToString();



                total = total + 1;

                salida = dr["VISITA"] + ";" +
                         dr["ID_SERVICIO"] + ";" +
                         dr["NUMERO_ORDEN"] + ";" +
                         dr["FECHA_CREACION"] + ";" +
                         dr["FECHA_INTEGRACION"] + ";" +
                         dr["ESTADO_MR"] + ";" +
                         dr["DIAMETRO_RET"] + ";" +
                         dr["SERIE_MEDIDOR_RET"] + ";" +
                         dr["LECTURA_RET"] + ";" +
                         dr["DIAMETRO_NU"] + ";" +

                         dr["NUMERO_MN"] + ";" +
                         dr["LECTURA_MN"] + ";" +
                         dr["RUTA"] + ";" +
                         dr["LOCALIDAD"] + ";" +
                         dr["TIPO_PROCESO"] + ";" +
                         dr["INSTALADOR"] + ";" +
                         dr["CONTRATISTA"] + ";" +
                         dr["IMPROCEDENCIA"] + ";" +
                         dr["FECHA_INST"] + ";" +
                         dr["CAUSA"] + ";" +

                         dr["COD_CONTRATISTA"] + ";" +
                         dr["UL_LECT_EF"] + ";" +
                         dr["FECHA_UL_LECT_EF"] + ";" +
                         dr["PROMEDIO"] + ";" +
                         dr["GESTION_CORTE"] + ";" +
                         dr["TIPO_MARCA_DI"] + ";" +
                         dr["SERIE_MEDIDOR"] + ";" +
                         dr["TIPO_INSTALACION"] + ";" +
                         dr["CLIENTE"] + ";" +
                         dr["DIRECCION"] + ";" +

                         dr["FECHA_IN_ME"] + ";" +
                         dr["OBSERVACION_IN"] + ";" +
                         dr["OBSERVACION_OUT"] + ";" +
                         dr["COD_LOCALIDAD"] + ";" +
                         dr["COD_IMPROCEDENCIA"] + ";" +
                         dr["COD_MARCA"] + ";" +
                         dr["ANO_MN"] + ";" +
                         dr["COD_VARAL"] + ";" +
                         dr["COD_LLAVE"] + ";" +

                         dr["RUT_CLIENTE"] + ";" +
                         dr["X"] + ";" +
                         dr["Y"] + ";" +
                         dr["SINCRONIZACION"] + ";" +
                         dr["FIRMA"] + ";" +
                         dr["COD_TIPOSELLO"] + ";" +
                         dr["SALIDA"] + ";" +
                         dr["FECHA_DESCARGA"] + ";" +
                         dr["ID_USUARIO"] + ";" +
                         dr["FECHA_CARGA"] + ";" +

                         dr["CODIGO_UNICO"] + ";" +
                         dr["FONO_CONTACTO"] + ";" +
                         dr["CORREO_CONTACTO"] + ";" +
                         dr["ACCESORIO_AJUSTE"] + ";" +
                         dr["ACCESORIO_TNORMAL"] + ";" +
                         dr["ACCESORIO_TDIFERIDA"] + ";" +
                         dr["ACCESORIO_VAINA"] + ";" +
                         dr["ACCESORIO_MEDIDOR"];


                sr.WriteLine(salida);

            }
            sr.Close();

            Response.Redirect("./SALIDA/" + "DETALLE_ORDENES" + DateTime.Now.ToString("ddMMyyyy") + ".csv", false);
        }
        catch (Exception ex)
        {
            String exp = ex.ToString();
        }
    }

    public void carga_grilla_detalle(String region, String zona, String localidad, String lote, String libreta, String contratista,
        String tipo_proceso, String improcedencia, String numero_orden, String servicio, String desde, String hasta, String cod_varal, String inst_llave)
    {
                        
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
        id_contr = PRO.recSession(rutaXml, "ID_CONTRATISTA");

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_REPORTE_ORDENES.CARGA_ORDENES_DETALLE", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_region", OracleType.Number, ParameterDirection.Input, region);
        PRO.agrega_parametro_sp(da, "i_zona", OracleType.Number, ParameterDirection.Input, zona);
        PRO.agrega_parametro_sp(da, "i_localidad", OracleType.Number, ParameterDirection.Input, localidad);
        PRO.agrega_parametro_sp(da, "i_lote", OracleType.Number, ParameterDirection.Input, lote);
        PRO.agrega_parametro_sp(da, "i_libreta", OracleType.Number, ParameterDirection.Input, libreta);

        if (contratista.Length == 0) contratista = id_contr;

        PRO.agrega_parametro_sp(da, "i_contratista", OracleType.Number, ParameterDirection.Input, contratista);
        PRO.agrega_parametro_sp(da, "i_tipoproceso", OracleType.NVarChar, ParameterDirection.Input, tipo_proceso);
        PRO.agrega_parametro_sp(da, "i_improcedencia", OracleType.NVarChar, ParameterDirection.Input, improcedencia);

        if (numero_orden.Length == 0) numero_orden = "0";

        PRO.agrega_parametro_sp(da, "i_numero_orden", OracleType.Number, ParameterDirection.Input, numero_orden);
        PRO.agrega_parametro_sp(da, "i_servicio", OracleType.NVarChar, ParameterDirection.Input, servicio);
        PRO.agrega_parametro_sp(da, "i_desde", OracleType.NVarChar, ParameterDirection.Input, desde);
        PRO.agrega_parametro_sp(da, "i_hasta", OracleType.NVarChar, ParameterDirection.Input, hasta);
        PRO.agrega_parametro_sp(da, "i_cod_varal", OracleType.Number, ParameterDirection.Input, cod_varal);
        PRO.agrega_parametro_sp(da, "i_inst_llave", OracleType.Number, ParameterDirection.Input, inst_llave);
        PRO.agrega_parametro_sp(da, "i_tipo_fecha", OracleType.Number, ParameterDirection.Input, rb_fechas.SelectedValue);

        da.SelectCommand.CommandType = CommandType.StoredProcedure;
                
        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("ID_ORDEN", typeof(String)));
        dt.Columns.Add(new DataColumn("VISITA", typeof(String)));
        dt.Columns.Add(new DataColumn("NUMERO_ORDEN", typeof(String)));
        dt.Columns.Add(new DataColumn("ID_SERVICIO", typeof(String)));
        dt.Columns.Add(new DataColumn("FECHA_CREACION", typeof(String)));
        dt.Columns.Add(new DataColumn("FECHA_INTEGRACION", typeof(String)));
        dt.Columns.Add(new DataColumn("ESTADO_MR", typeof(String)));
        dt.Columns.Add(new DataColumn("DIAMETRO_RET", typeof(String)));
        dt.Columns.Add(new DataColumn("SERIE_MEDIDOR_RET", typeof(String)));
        dt.Columns.Add(new DataColumn("LECTURA_RET", typeof(String)));
        dt.Columns.Add(new DataColumn("DIAMETRO_NU", typeof(String)));
        dt.Columns.Add(new DataColumn("NUMERO_MN", typeof(String)));
        dt.Columns.Add(new DataColumn("LECTURA_MN", typeof(String)));
        dt.Columns.Add(new DataColumn("RUTA", typeof(String)));
        dt.Columns.Add(new DataColumn("LOCALIDAD", typeof(String)));
        dt.Columns.Add(new DataColumn("TIPO_PROCESO", typeof(String)));
        dt.Columns.Add(new DataColumn("INSTALADOR", typeof(String)));
        dt.Columns.Add(new DataColumn("CONTRATISTA", typeof(String)));
        dt.Columns.Add(new DataColumn("IMPROCEDENCIA", typeof(String)));
        dt.Columns.Add(new DataColumn("FECHA_INST", typeof(String)));

        dt.Columns.Add(new DataColumn("CAUSA", typeof(String)));
        dt.Columns.Add(new DataColumn("COD_CONTRATISTA", typeof(String)));
        dt.Columns.Add(new DataColumn("UL_LECT_EF", typeof(String)));
        dt.Columns.Add(new DataColumn("FECHA_UL_LECT_EF", typeof(String)));
        dt.Columns.Add(new DataColumn("PROMEDIO", typeof(String)));
        dt.Columns.Add(new DataColumn("GESTION_CORTE", typeof(String)));
        dt.Columns.Add(new DataColumn("TIPO_MARCA_DI", typeof(String)));
        dt.Columns.Add(new DataColumn("SERIE_MEDIDOR", typeof(String)));
        dt.Columns.Add(new DataColumn("TIPO_INSTALACION", typeof(String)));
        dt.Columns.Add(new DataColumn("CLIENTE", typeof(String)));

        dt.Columns.Add(new DataColumn("DIRECCION", typeof(String)));
        dt.Columns.Add(new DataColumn("FECHA_IN_ME", typeof(String)));
        dt.Columns.Add(new DataColumn("OBSERVACION_IN", typeof(String)));
        dt.Columns.Add(new DataColumn("OBSERVACION_OUT", typeof(String)));
        dt.Columns.Add(new DataColumn("COD_LOCALIDAD", typeof(String)));
        dt.Columns.Add(new DataColumn("COD_IMPROCEDENCIA", typeof(String)));
        dt.Columns.Add(new DataColumn("COD_MARCA", typeof(String)));
        dt.Columns.Add(new DataColumn("ANO_MN", typeof(String)));
        dt.Columns.Add(new DataColumn("COD_VARAL", typeof(String)));

        dt.Columns.Add(new DataColumn("COD_LLAVE", typeof(String)));
        dt.Columns.Add(new DataColumn("RUT_CLIENTE", typeof(String)));
        dt.Columns.Add(new DataColumn("X", typeof(String)));
        dt.Columns.Add(new DataColumn("Y", typeof(String)));
        dt.Columns.Add(new DataColumn("SINCRONIZACION", typeof(String)));
        dt.Columns.Add(new DataColumn("FIRMA", typeof(String)));
        dt.Columns.Add(new DataColumn("COD_TIPOSELLO", typeof(String)));
        dt.Columns.Add(new DataColumn("SALIDA", typeof(String)));
        dt.Columns.Add(new DataColumn("FECHA_DESCARGA", typeof(String)));
        dt.Columns.Add(new DataColumn("ID_USUARIO", typeof(String)));

        dt.Columns.Add(new DataColumn("FECHA_CARGA", typeof(String)));
        dt.Columns.Add(new DataColumn("CODIGO_UNICO", typeof(String)));
        dt.Columns.Add(new DataColumn("FONO_CONTACTO", typeof(String)));
        dt.Columns.Add(new DataColumn("CORREO_CONTACTO", typeof(String)));
        dt.Columns.Add(new DataColumn("ACCESORIO_AJUSTE", typeof(String)));
        dt.Columns.Add(new DataColumn("ACCESORIO_TNORMAL", typeof(String)));
        dt.Columns.Add(new DataColumn("ACCESORIO_TDIFERIDA", typeof(String)));
        dt.Columns.Add(new DataColumn("ACCESORIO_VAINA", typeof(String)));
        dt.Columns.Add(new DataColumn("ACCESORIO_MEDIDOR", typeof(String)));
                
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

                dr["ID_ORDEN"] = drOrdenItem["ID_ORDEN"].ToString();
                dr["VISITA"] = drOrdenItem["VISITA"].ToString();
                dr["ID_SERVICIO"] = drOrdenItem["ID_SERVICIO"].ToString();
                dr["NUMERO_ORDEN"] = drOrdenItem["NUMERO_ORDEN"].ToString();
                dr["FECHA_CREACION"] = drOrdenItem["FECHA_CREACION"].ToString();
                dr["FECHA_INTEGRACION"] = drOrdenItem["FECHA_INTEGRACION"].ToString();
                dr["ESTADO_MR"] = drOrdenItem["ESTADO_MR"].ToString();
                dr["DIAMETRO_RET"] = drOrdenItem["DIAMETRO_RET"].ToString();
                dr["SERIE_MEDIDOR_RET"] = drOrdenItem["SERIE_MEDIDOR_RET"].ToString();
                dr["LECTURA_RET"] = drOrdenItem["LECTURA_RET"].ToString();

                dr["DIAMETRO_NU"] = drOrdenItem["DIAMETRO_NU"].ToString();
                dr["NUMERO_MN"] = drOrdenItem["NUMERO_MN"].ToString();
                dr["LECTURA_MN"] = drOrdenItem["LECTURA_MN"].ToString();
                dr["RUTA"] = drOrdenItem["RUTA"].ToString();
                dr["LOCALIDAD"] = drOrdenItem["LOCALIDAD"].ToString();
                dr["TIPO_PROCESO"] = drOrdenItem["TIPO_PROCESO"].ToString();
                dr["INSTALADOR"] = drOrdenItem["INSTALADOR"].ToString();
                dr["CONTRATISTA"] = drOrdenItem["CONTRATISTA"].ToString();
                dr["IMPROCEDENCIA"] = drOrdenItem["IMPROCEDENCIA"].ToString();
                dr["FECHA_INST"] = drOrdenItem["FECHA_INST"].ToString();

                dr["CAUSA"] = drOrdenItem["CAUSA"].ToString();
                dr["COD_CONTRATISTA"] = drOrdenItem["COD_CONTRATISTA"].ToString();
                dr["UL_LECT_EF"] = drOrdenItem["UL_LECT_EF"].ToString();
                dr["FECHA_UL_LECT_EF"] = drOrdenItem["FECHA_UL_LECT_EF"].ToString();
                dr["PROMEDIO"] = drOrdenItem["PROMEDIO"].ToString();
                dr["GESTION_CORTE"] = drOrdenItem["GESTION_CORTE"].ToString();
                dr["TIPO_MARCA_DI"] = drOrdenItem["TIPO_MARCA_DI"].ToString();
                dr["SERIE_MEDIDOR"] = drOrdenItem["SERIE_MEDIDOR"].ToString();
                dr["TIPO_INSTALACION"] = drOrdenItem["TIPO_INSTALACION"].ToString();
                dr["CLIENTE"] = drOrdenItem["CLIENTE"].ToString();

                dr["DIRECCION"] = drOrdenItem["DIRECCION"].ToString();
                dr["FECHA_IN_ME"] = drOrdenItem["FECHA_IN_ME"].ToString();
                dr["OBSERVACION_IN"] = drOrdenItem["OBSERVACION_IN"].ToString();
                dr["OBSERVACION_OUT"] = drOrdenItem["OBSERVACION_OUT"].ToString();
                dr["COD_LOCALIDAD"] = drOrdenItem["COD_LOCALIDAD"].ToString();
                dr["COD_IMPROCEDENCIA"] = drOrdenItem["COD_IMPROCEDENCIA"].ToString();
                dr["COD_MARCA"] = drOrdenItem["COD_MARCA"].ToString();
                dr["ANO_MN"] = drOrdenItem["ANO_MN"].ToString();
                dr["COD_VARAL"] = drOrdenItem["COD_VARAL"].ToString();
                dr["COD_LLAVE"] = drOrdenItem["COD_LLAVE"].ToString();

                dr["RUT_CLIENTE"] = drOrdenItem["RUT_CLIENTE"].ToString();
                dr["X"] = drOrdenItem["X"].ToString();
                dr["Y"] = drOrdenItem["Y"].ToString();
                dr["SINCRONIZACION"] = drOrdenItem["SINCRONIZACION"].ToString();
                dr["FIRMA"] = drOrdenItem["FIRMA"].ToString();
                dr["COD_TIPOSELLO"] = drOrdenItem["COD_TIPOSELLO"].ToString();
                dr["SALIDA"] = drOrdenItem["SALIDA"].ToString();
                dr["FECHA_DESCARGA"] = drOrdenItem["FECHA_DESCARGA"].ToString();
                dr["ID_USUARIO"] = drOrdenItem["ID_USUARIO"].ToString();
                dr["FECHA_CARGA"] = drOrdenItem["FECHA_CARGA"].ToString();

                dr["CODIGO_UNICO"] = drOrdenItem["CODIGO_UNICO"].ToString();
                dr["FONO_CONTACTO"] = drOrdenItem["FONO_CONTACTO"].ToString();
                dr["CORREO_CONTACTO"] = drOrdenItem["CORREO_CONTACTO"].ToString();
                dr["ACCESORIO_AJUSTE"] = drOrdenItem["ACCESORIO_AJUSTE"].ToString();
                dr["ACCESORIO_TNORMAL"] = drOrdenItem["ACCESORIO_TNORMAL"].ToString();
                dr["ACCESORIO_TDIFERIDA"] = drOrdenItem["ACCESORIO_TDIFERIDA"].ToString();
                dr["ACCESORIO_VAINA"] = drOrdenItem["ACCESORIO_VAINA"].ToString();
                dr["ACCESORIO_MEDIDOR"] = drOrdenItem["ACCESORIO_MEDIDOR"].ToString();

                dt.Rows.Add(dr);

                total = total + 1;

            }

            DataView MydataView;
            MydataView = new DataView(dt);
            gridOrden.DataSource = MydataView;
            gridOrden.DataBind();

            lbTotal.Text = total + " registro(s) encontrado(s)";

            gridOrden.Columns[0].Visible = false;
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + ex.Message.ToString() + "');", true);

           //ERROR AL INTEGRAR ARCHIVO.
        }
        
    }

    protected void cb_estado_varal_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue, cb_libreta.SelectedValue,
             cb_contratista.SelectedValue, fill_checkbox_list(cb_tipo_proceso), fill_checkbox_list(cb_improcedencia), TextboxNumOrden.Text, txtServ.Text,
             txtDesde.Text, txtHasta.Text, cb_estado_varal.SelectedValue, cb_instalacion_llave.SelectedValue);
    }
    protected void cb_instalacion_llave_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue, cb_libreta.SelectedValue,
               cb_contratista.SelectedValue, fill_checkbox_list(cb_tipo_proceso), fill_checkbox_list(cb_improcedencia), TextboxNumOrden.Text, txtServ.Text,
               txtDesde.Text, txtHasta.Text, cb_estado_varal.SelectedValue, cb_instalacion_llave.SelectedValue);
    }
    protected void btn_genera_excel_Click(object sender, EventArgs e)
    {
        if (gridOrden.Rows.Count > 0){
            //carga_grilla_detalle(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue, cb_libreta.SelectedValue,
            //cb_contratista.SelectedValue, fill_checkbox_list(cb_tipo_proceso), fill_checkbox_list(cb_improcedencia), TextboxNumOrden.Text, txtServ.Text,
            //txtDesde.Text, txtHasta.Text, cb_estado_varal.SelectedValue, cb_instalacion_llave.SelectedValue);

            datatable_to_excel(dt_excel);
        }
        else ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('No hay registros para decargar');", true);

    }
}
