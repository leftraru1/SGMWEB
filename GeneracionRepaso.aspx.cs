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

public partial class GeneracionRepaso : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();
    String id_contr = "0";
    
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
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
                carga_libreta(cb_region.SelectedValue, cb_zona.SelectedValue,cb_localidad.SelectedValue,cb_lote.SelectedValue);

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
                txtHasta.Text =  DateTime.Now.ToString("dd-MM-yyyy");
                
                //cargamos tabla.
                //carga_grilla(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue, cb_libreta.SelectedValue,
                //cb_contratista.SelectedValue, fill_checkbox_list(cb_tipo_proceso), fill_checkbox_list(cb_improcedencia), TextboxNumOrden.Text, txtServ.Text, txtDesde.Text, txtHasta.Text);
    
                IMG2.Visible = false;
               
            }
            catch(Exception ex)
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
        objComando = new OracleDataAdapter("PK_GENERAR_REPASO.CARGA_REGION", objConexion);
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
        objComando = new OracleDataAdapter("PK_GENERAR_REPASO.CARGA_ZONA", objConexion);
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
    public void carga_localidad(String region,String zona)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_GENERAR_REPASO.CARGA_LOCALIDAD", objConexion);
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
    public void carga_lote(String region, String zona,String localidad)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_GENERAR_REPASO.CARGA_LOTE", objConexion);
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
    public void carga_libreta(String region, String zona, String localidad,String lote)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_GENERAR_REPASO.CARGA_LIBRETA", objConexion);
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
        objComando = new OracleDataAdapter("PK_GENERAR_REPASO.CARGA_CONTRATISTA", objConexion);
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
        objComando = new OracleDataAdapter("PK_GENERAR_REPASO.CARGA_TIPOPROCESO", objConexion);
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

    //CARGAMOS LAS IMPROCEDENCIAS
    public void carga_improcedencia()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_GENERAR_REPASO.CARGA_IMPROCEDENCIA", objConexion);
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
   
    public void carga_grilla(String region, String zona, String localidad, String lote, String libreta, String contratista,
        String tipo_proceso, String improcedencia, String numero_orden, String servicio, String desde, String hasta,String visita)
    {
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
        id_contr = PRO.recSession(rutaXml, "ID_CONTRATISTA");
        
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_GENERAR_REPASO.CARGA_ORDENES", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        // PONE VISIBLE LA COLUMNA ID_SINCRONIZACION Y ID_ORDEN PARA LLENARLA 
        //(SI NO SE PONE VISIBLE NO SE LLENA)
        gridOrden.Columns[0].Visible = true;
        gridOrden.Columns[11].Visible = true;
        
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
        catch(Exception ex)
        {
            lbErrorGrilla.Text = ex.Message.ToString();
            lbErrorGrilla.ForeColor = System.Drawing.Color.Red;

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + ex.Message.ToString() + "');", true);
           
        }       

        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("ID_ORDEN", typeof(String)));
        dt.Columns.Add(new DataColumn("VISITA", typeof(String)));
        dt.Columns.Add(new DataColumn("NUMERO_ORDEN", typeof(String)));
        dt.Columns.Add(new DataColumn("ID_SERVICIO", typeof(String)));
        dt.Columns.Add(new DataColumn("FECHA_CREACION", typeof(String)));
        dt.Columns.Add(new DataColumn("FECHA_INTEGRACION", typeof(String)));
        dt.Columns.Add(new DataColumn("DIAS_TRANSCURRIDOS", typeof(Int32)));
        dt.Columns.Add(new DataColumn("RUTA", typeof(String)));
        dt.Columns.Add(new DataColumn("DIRECCION", typeof(String)));
        dt.Columns.Add(new DataColumn("LOCALIDAD", typeof(String)));
        dt.Columns.Add(new DataColumn("ID_PROCESO", typeof(Int32)));
        dt.Columns.Add(new DataColumn("ID_TIPO_PROCESO", typeof(Int32)));
        dt.Columns.Add(new DataColumn("TIPO_PROCESO", typeof(String)));
        dt.Columns.Add(new DataColumn("GRUPO_PROCESO", typeof(String)));
        dt.Columns.Add(new DataColumn("ID_SINCRONIZACION", typeof(Int32)));
        dt.Columns.Add(new DataColumn("INSTALADOR", typeof(String)));
        dt.Columns.Add(new DataColumn("SINCRONIZACION", typeof(String)));
        dt.Columns.Add(new DataColumn("DIAS_SLA", typeof(String)));

        DataRow dr;

        int total = 0;
        
        foreach (DataRow drOrdenItem in dtOrdenes.Rows)
        {

            dr = dt.NewRow();

            dr["ID_ORDEN"] = drOrdenItem["ID_ORDEN"].ToString();
            dr["VISITA"] = drOrdenItem["VISITA"].ToString();
            dr["NUMERO_ORDEN"] = drOrdenItem["NUMERO_ORDEN"].ToString();
            dr["ID_SERVICIO"] = drOrdenItem["ID_SERVICIO"].ToString();
            dr["FECHA_CREACION"] = drOrdenItem["FECHA_CREACION"].ToString().Replace(" 0:00:00", "");
            dr["FECHA_INTEGRACION"] = drOrdenItem["FECHA_INTEGRACION"].ToString().Replace(" 0:00:00", "");
            dr["DIAS_TRANSCURRIDOS"] = drOrdenItem["DIAS_TRANSCURRIDOS"].ToString();
            dr["RUTA"] = drOrdenItem["RUTA"].ToString();
            dr["DIRECCION"] = drOrdenItem["DIRECCION"].ToString();
            dr["LOCALIDAD"] = drOrdenItem["LOCALIDAD"].ToString();
            dr["ID_PROCESO"] = drOrdenItem["ID_PROCESO"].ToString();
            dr["ID_TIPO_PROCESO"] = drOrdenItem["ID_TIPO_PROCESO"].ToString();
            dr["TIPO_PROCESO"] = drOrdenItem["TIPO_PROCESO"].ToString();
            dr["GRUPO_PROCESO"] = drOrdenItem["GRUPO_PROCESO"].ToString();
            dr["ID_SINCRONIZACION"] = drOrdenItem["ID_SINCRONIZACION"].ToString();
            dr["INSTALADOR"] = drOrdenItem["INSTALADOR"].ToString();
            dr["SINCRONIZACION"] = drOrdenItem["SINCRONIZACION"].ToString();
            dr["DIAS_SLA"] = drOrdenItem["DIAS_SLA"].ToString();
           
            dt.Rows.Add(dr);

            total = total + 1;
           
        }
              
        DataView MydataView;
        MydataView = new DataView(dt);
        gridOrden.DataSource = MydataView;
        gridOrden.DataBind();

        lbTotal.Text = total + " registro(s) encontrado(s)";
       

        int i;
        GridViewRow gvRow;
        CheckBox chk_marca;
        //string id_sincronizacion;

        for (i = 0; i < gridOrden.Rows.Count; i++)
        {
            gvRow = gridOrden.Rows[i];
            chk_marca = ((CheckBox)gvRow.FindControl("check_marca"));

            chk_marca.Enabled = true;                    

        }

        // PONE INVISIBLES LAS COLUMNAS CON LOS ID
        gridOrden.Columns[0].Visible = false;
        gridOrden.Columns[11].Visible = false;
        gridOrden.Columns[12].Visible = false;
        gridOrden.Columns[13].Visible = false;
        gridOrden.Columns[15].Visible = false;
        gridOrden.Columns[17].Visible = false;
    }
   
    public Boolean valida_check()
    {
        int c;
        Boolean check=false;
        //DataGridItem item_grilla;
        GridViewRow gvRow;
        CheckBox check_row = new CheckBox();
        for (c = 0; c < gridOrden.Rows.Count; c++)
        {
            String bandera = gridOrden.Rows[c].Cells[16].Text;
            bandera = gridOrden.Rows[c].Cells[15].Text;
            //item_grilla = gridOrden.Items[c];
            gvRow = gridOrden.Rows[c];
            check_row = (CheckBox)(gvRow.FindControl("check_marca"));
            if (check_row.Checked == true)
            {
                check = true;
            }
        }
        return check;
    }

    
    /*
    protected void btnFiltrar_Click(object sender, EventArgs e)
    {
        carga_grilla(int.Parse(ddGrupo.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), int.Parse(ddEstado.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()),txtDesde.Text,txtHasta.Text);

        
    }*/

   
    
    protected void gridOrden_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if(e.CommandName=="marcar")
        {
            checkTodos("check_marca");
        }
     
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        txtInstalador.Text = gridOrden.Rows[0].Cells[0].Text;
    }

    public void checkTodos(String check)
    {
        int c;
        
        GridViewRow gvRow;
        CheckBox check_row = new CheckBox();
        for (c = 0; c < gridOrden.Rows.Count; c++)
        {
           
            gvRow = gridOrden.Rows[c];
            check_row = (CheckBox)(gvRow.FindControl(check));

                    if ((check_row.Enabled == true ))
                    {
                        if ((check_row.Checked == true))
                        {
                            check_row.Checked = false;
                        }
                        else
                        {
                            check_row.Checked = true;
                        }
                    }
        }
    }

   
    protected void gridOrden_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //gridOrden.PageIndex = e.NewPageIndex;
        gridOrden.PageIndex = e.NewPageIndex;
        carga_grilla(cb_region.SelectedValue,cb_zona.SelectedValue,cb_localidad.SelectedValue,cb_lote.SelectedValue,cb_libreta.SelectedValue,
            cb_contratista.SelectedValue,fill_checkbox_list(cb_tipo_proceso),fill_checkbox_list(cb_improcedencia),TextboxNumOrden.Text,txtServ.Text,txtDesde.Text,txtHasta.Text,cb_visita.SelectedValue);
    }
  
    protected void txtServ_TextChanged(object sender, EventArgs e)
    {
        carga_grilla(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue, cb_libreta.SelectedValue,
           cb_contratista.SelectedValue, fill_checkbox_list(cb_tipo_proceso), fill_checkbox_list(cb_improcedencia), TextboxNumOrden.Text, txtServ.Text, txtDesde.Text, txtHasta.Text,cb_visita.SelectedValue);
    }
    protected void Button1_Click1(object sender, EventArgs e)
    {
        carga_grilla(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue, cb_libreta.SelectedValue,
            cb_contratista.SelectedValue, fill_checkbox_list(cb_tipo_proceso), fill_checkbox_list(cb_improcedencia), TextboxNumOrden.Text, txtServ.Text, txtDesde.Text, txtHasta.Text,cb_visita.SelectedValue);
    }
    protected void lkbAsignar_Click(object sender, EventArgs e)
    {

    }

    /* ------------------Evento para actualizar la tabla segun el numero de orden que se busca---------------------------------*/

    protected void txtNumOrden_TextChanged(object sender, EventArgs e)
    {
        carga_grilla(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue, cb_libreta.SelectedValue,
            cb_contratista.SelectedValue, fill_checkbox_list(cb_tipo_proceso), fill_checkbox_list(cb_improcedencia), TextboxNumOrden.Text, txtServ.Text, txtDesde.Text, txtHasta.Text,cb_visita.SelectedValue);
    }
   
    /* ------------------COLORES DE LA GRILLA (SLA) -------------------------*/
    protected void gridOrden_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //if (e.Row.RowType == DataControlRowType.DataRow) //deshabilitamos coloreo temporalmente.
        //{

        //    Int32 dias_transcurridos = Int32.Parse(DataBinder.Eval(e.Row.DataItem, "DIAS_TRANSCURRIDOS").ToString());
        //    Int32 ID_TIPO_PROCESO = Int32.Parse(DataBinder.Eval(e.Row.DataItem, "ID_TIPO_PROCESO").ToString());
        //    Int32 DIAS_SLA = Int32.Parse(DataBinder.Eval(e.Row.DataItem, "DIAS_SLA").ToString());

        //    // SI ES SOLICITUD
        //    if(ID_TIPO_PROCESO==2){
        //        int Contador = 0;
        //        int DiasHabiles = 0;
        //        int DiaSemana = 0;
        //        string Aux_FechaInicio;
        //        string Aux_FechaFin;
        //        DateTime Aux_Fecha;
        //        DateTime FECHA_INTEGRACION = DateTime.Parse(DataBinder.Eval(e.Row.DataItem, "FECHA_INTEGRACION").ToString());
        //        DateTime hoy = System.DateTime.Today.Date;
        //        int DiasNormales = Convert.ToInt32((hoy - FECHA_INTEGRACION).TotalDays);
        //        String dia_semana = FECHA_INTEGRACION.Date.DayOfWeek.ToString();
        //        String region = get_region(DataBinder.Eval(e.Row.DataItem, "LOCALIDAD").ToString());

        //        Aux_FechaInicio = FECHA_INTEGRACION.ToString("dd-MM-yyyy");
        //        Aux_FechaFin = hoy.ToString("dd-MM-yyyy");

        //        if (FECHA_INTEGRACION != hoy)
        //        {
        //            if (DiasNormales == 2)
        //            {
        //                DiasHabiles = 1;
        //            }
        //            else
        //            {
        //                while (Contador <= DiasNormales)
        //                {
        //                    Aux_Fecha = FECHA_INTEGRACION.AddDays(Contador);
        //                    DiaSemana = GetDayWeek(Aux_Fecha);
        //                    if ((DiaSemana != 5) && (DiaSemana != 6) && !es_feriado(Aux_Fecha.ToString(),region))
        //                    {
        //                        DiasHabiles = DiasHabiles + 1;
        //                    }
        //                    Contador = Contador + 1;
        //                }
        //            }
        //        }
        //        else
        //        {
        //            DiasHabiles = 0;
        //        }

        //        // GENERA SLA
        //        if (DiasHabiles < 4){
        //            e.Row.BackColor = System.Drawing.Color.White;
        //        }
        //        if (DiasHabiles == 4 || DiasHabiles == 5)
        //        {
        //            e.Row.BackColor = System.Drawing.Color.Orange;
        //        }
        //        if (DiasHabiles > DIAS_SLA)
        //        {
        //            e.Row.BackColor = System.Drawing.Color.Red;
        //        }

        //     }else{
        //         if ((dias_transcurridos/3) < 7)
        //         {
        //             e.Row.BackColor = System.Drawing.Color.White;
        //         }
        //         if ((dias_transcurridos / 3) >= 8 && (dias_transcurridos / 3)<14)
        //         {
        //             e.Row.BackColor = System.Drawing.Color.Yellow;
        //         }
        //         if ((dias_transcurridos / 3) >= 14 && (dias_transcurridos / 3)< DIAS_SLA)
        //         {
        //             e.Row.BackColor = System.Drawing.Color.Orange;
        //         }
        //         if ((dias_transcurridos/3) >= DIAS_SLA)
        //         {
        //              e.Row.BackColor = System.Drawing.Color.Red;
        //          }     
        //        }
        //    }
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
            objComando = new OracleDataAdapter("SELECT Z.ID_REGION FROM LOCALIDAD L JOIN ZONA Z ON Z.ID_ZONA = L.ID_ZONA WHERE L.NOMBRE = '" +localidad + "'", objConexion);
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

    public Boolean es_feriado(String fecha, String region)
    {
        try
        {
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();

            objConexion.Open();
            fecha = fecha.Substring(0, 10);
            //AND (REGION = 0 OR REGION = " + region + " OR " + region + " = 0)
            objComando = new OracleDataAdapter("SELECT COUNT(ID_FERIADO) FROM FERIADOS WHERE (FECHA = TO_DATE('" + fecha + "','DD/MM/RRRR') AND (REGION = 0 OR REGION = " + region + " OR " + region + " = 0) )", objConexion);
            objComando.SelectCommand.CommandType = CommandType.Text;

            objComando.SelectCommand.ExecuteNonQuery();
            objComando.Fill(objDS, "VALIDA");
            objConexion.Close();

            int codigo = 0;
            foreach (DataRow row in objDS.Tables["VALIDA"].Rows)
            {
                if (row[0].ToString().Equals("0"))
                {
                    return false;
                }
                else return true;
            }

            return false;
        }
        catch (Exception ex)
        {
            return false;
        }
    }


    private int GetDayWeek(DateTime Fecha)
    {
        int Dia = 0;
        switch (Fecha.Date.DayOfWeek.ToString())
        {
            case "Monday":
                Dia = 0;
                break;
            case "Tuesday":
                Dia = 1;
                break;
            case "Wednesday":
                Dia = 2;
                break;
            case "Thursday":
                Dia = 3;
                break;
            case "Friday":
                Dia = 4;
                break;
            case "Saturday":
                Dia = 5;
                break;
            case "Sunday":
                Dia = 6;
                break;
        }
        return Dia;
    }

    protected void cb_region_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_zona(cb_region.SelectedValue);
        carga_localidad(cb_region.SelectedValue, cb_zona.SelectedValue);
        carga_lote(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue);
        carga_libreta(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue);

        carga_grilla(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue, cb_libreta.SelectedValue,
          cb_contratista.SelectedValue, fill_checkbox_list(cb_tipo_proceso), fill_checkbox_list(cb_improcedencia), TextboxNumOrden.Text, txtServ.Text, txtDesde.Text, txtHasta.Text, cb_visita.SelectedValue);
    }
    protected void cb_zona_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_localidad(cb_region.SelectedValue, cb_zona.SelectedValue);
        carga_lote(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue);
        carga_libreta(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue);

        carga_grilla(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue, cb_libreta.SelectedValue,
          cb_contratista.SelectedValue, fill_checkbox_list(cb_tipo_proceso), fill_checkbox_list(cb_improcedencia), TextboxNumOrden.Text, txtServ.Text, txtDesde.Text, txtHasta.Text, cb_visita.SelectedValue);
    }
    protected void cb_localidad_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_lote(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue);
        carga_libreta(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue);

        carga_grilla(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue, cb_libreta.SelectedValue,
          cb_contratista.SelectedValue, fill_checkbox_list(cb_tipo_proceso), fill_checkbox_list(cb_improcedencia), TextboxNumOrden.Text, txtServ.Text, txtDesde.Text, txtHasta.Text, cb_visita.SelectedValue);
    }
    protected void cb_lote_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_libreta(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue,cb_lote.SelectedValue);
        carga_grilla(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue, cb_libreta.SelectedValue,
          cb_contratista.SelectedValue, fill_checkbox_list(cb_tipo_proceso), fill_checkbox_list(cb_improcedencia), TextboxNumOrden.Text, txtServ.Text, txtDesde.Text, txtHasta.Text, cb_visita.SelectedValue);
    }
    protected void cb_libreta_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue, cb_libreta.SelectedValue,
          cb_contratista.SelectedValue, fill_checkbox_list(cb_tipo_proceso), fill_checkbox_list(cb_improcedencia), TextboxNumOrden.Text, txtServ.Text, txtDesde.Text, txtHasta.Text, cb_visita.SelectedValue);
    }
    protected void cb_contratista_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue, cb_libreta.SelectedValue,
          cb_contratista.SelectedValue, fill_checkbox_list(cb_tipo_proceso), fill_checkbox_list(cb_improcedencia), TextboxNumOrden.Text, txtServ.Text, txtDesde.Text, txtHasta.Text, cb_visita.SelectedValue);
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
    protected void check_mismo_operador_CheckedChanged(object sender, EventArgs e)
    {
        //SI SE DESHABILITA PERMITIRÁ QUE SE GENERE EL REPASO PARA EL CÓDIGO DE INSTALADOR DIGITADO EN EL TEXTBOX DE INSTALADOR.
        //CASO CONTRARIO, GENERARÁ REPASO CON LOS MISMOS CÓDIGOS DE CADA ORDEN MARCADA.

        //SI ESTÁ CHEQUEADO, LO DESHABILITA.
        if (check_mismo_operador.Checked)
        {
            txtInstalador.Enabled = false;
            IMG1.Visible = false;
        }
        else
        {
            txtInstalador.Enabled = true;
            IMG1.Visible = true;
        }
    }
    protected void btn_generar_repaso_Click(object sender, EventArgs e)
    {
        generaRepaso();
        carga_grilla(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue, cb_libreta.SelectedValue,
          cb_contratista.SelectedValue, fill_checkbox_list(cb_tipo_proceso), fill_checkbox_list(cb_improcedencia), TextboxNumOrden.Text, txtServ.Text, txtDesde.Text, txtHasta.Text, cb_visita.SelectedValue);
    }

    public void generaRepaso()
    {
        gridOrden.Columns[0].Visible = true;
        gridOrden.Columns[11].Visible = true;

        if (txtInstalador.Text == "" && !check_mismo_operador.Checked)
        {
            lbResultado.ForeColor = System.Drawing.Color.Red;
            lbResultado.Text = "Ingrese código de Instalador";

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + lbResultado.Text + "');", true);
           
            IMG2.Visible = false;           
            txtInstalador.Focus();

        }
        else
        {

            String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";

            IMG2.Visible = false;

            lbResultado.ForeColor = System.Drawing.Color.Green;
            lbResultado.Text = "";
            String codLector;
            codLector = PRO.existeInstalador(txtInstalador.Text, PRO.recSession(rutaXml, "RUT_EMPRESA"));

            if (codLector == "OK" || check_mismo_operador.Checked)
            {
                //SI ESTÁ MARCADA LA CASILLA DEL MISMO OPERADOR, ENTONCES GENERARÁ REPASO CON LOS MISMOS CÓDIGOS DE LAS ORDENES EN CUESTIÓN.
                if (check_mismo_operador.Checked) codLector = "MISMO";
                else codLector = txtInstalador.Text;

                IMG2.Visible = false;
                lbResultado.ForeColor = System.Drawing.Color.Green;
                lbResultado.Text = "";               

                if (valida_check() == true)
                {

                    IMG2.Visible = false;
                    lbResultado.Text = "";

                    Int32 c;
                    GridViewRow gvRow;
                    CheckBox check_marca = new CheckBox();

                    for (c = 0; c < gridOrden.Rows.Count; c++)
                    {
                        gvRow = gridOrden.Rows[c];
                        check_marca = (CheckBox)(gvRow.FindControl("check_marca"));

                        if ((check_marca.Checked == true))
                        {
                            OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
                            OracleCommand cmdAcceso = new OracleCommand("PK_ORDEN.GENERA_REPASO_NEW", CnOra);
                            OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
                            rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";

                            PRO.agrega_parametro_sp(da, "i_rutEmpresa", OracleType.Number, ParameterDirection.Input, PRO.recSession(rutaXml, "RUT_EMPRESA"));
                            PRO.agrega_parametro_sp(da, "i_idProceso", OracleType.Number, ParameterDirection.Input, gridOrden.Rows[c].Cells[11].Text);
                            PRO.agrega_parametro_sp(da, "i_servicio", OracleType.Number, ParameterDirection.Input, gridOrden.Rows[c].Cells[4].Text);
                            PRO.agrega_parametro_sp(da, "i_id_orden", OracleType.Number, ParameterDirection.Input, gridOrden.Rows[c].Cells[0].Text);
                            PRO.agrega_parametro_sp(da, "i_cod_instalador", OracleType.NVarChar, ParameterDirection.Input, codLector);

                            da.SelectCommand.CommandType = CommandType.StoredProcedure;

                            try
                            {
                                CnOra.Open();
                                da.SelectCommand.ExecuteNonQuery();
                                CnOra.Close();
                                CnOra.Dispose();
                                
                                IMG2.Visible = false;
                                gridOrden.Columns[0].Visible = false;
                                gridOrden.Columns[11].Visible = false;
                                lbResultado.ForeColor = System.Drawing.Color.Blue;
                                lbResultado.Text = "";
                                
                            }
                            catch (Exception ex)
                            {
                                CnOra.Close();
                                CnOra.Dispose();

                                lbResultado.ForeColor = System.Drawing.Color.Red;
                                lbResultado.Text = ex.Message.ToString();
                                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + lbResultado.Text + "');", true);
           

                            }

                            
                        }
                       
                    }
                    lbResultado.ForeColor = System.Drawing.Color.Blue;
                    lbResultado.Text = "REPASOS GENERADOS EXITOSAMENTE";
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_ok2('" + lbResultado.Text + "');", true);
           
                }
                else //NO HAY NADA SELECCIONADO!
                {
                    lbResultado.ForeColor = System.Drawing.Color.Red;
                    lbResultado.Text = "Seleccione al menos una orden para enviar a repaso.";
                    IMG2.Visible = false;
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + lbResultado.Text + "');", true);
           
                }
            } 
            else //COD INSTALADOR INCORRECTO!
            {
                lbResultado.ForeColor = System.Drawing.Color.Red;
                lbResultado.Text = "Código instalador incorrecto.";
                IMG2.Visible = false;
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + lbResultado.Text + "');", true);
           
            }
        }
    }

    protected void cb_visita_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla(cb_region.SelectedValue, cb_zona.SelectedValue, cb_localidad.SelectedValue, cb_lote.SelectedValue, cb_libreta.SelectedValue,
          cb_contratista.SelectedValue, fill_checkbox_list(cb_tipo_proceso), fill_checkbox_list(cb_improcedencia), TextboxNumOrden.Text, txtServ.Text, txtDesde.Text, txtHasta.Text,cb_visita.SelectedValue);
  
    }
}
