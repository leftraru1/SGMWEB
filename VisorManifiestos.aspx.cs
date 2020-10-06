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

public partial class VisorManifiestos : System.Web.UI.Page
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
                lb_id_usuario.Text = PRO.recSession(rutaXml, "ID_USUARIO");
                lb_id_perfil.Text = PRO.recSession(rutaXml, "ID_PERFIL");

                carga_contratista(id_contr);
                carga_operadores(cb_contratista.SelectedValue);
                //cargamos los filtros multiples.
                carga_region();
                carga_bodegas(cb_contratista.SelectedValue, fill_checkbox_list(cb_region));
                carga_tipo_manifiesto();

                //iniciamos las fechas con un rango de 3 meses hasta la fecha de hoy.
                txtDesde.Text = DateTime.Now.AddDays(-90).ToString("dd-MM-yyyy");
                txtHasta.Text = DateTime.Now.ToString("dd-MM-yyyy");

                //cargamos tabla.
                carga_grilla_detalle(fill_checkbox_list(cb_bodega), fill_checkbox_list(cb_operadores), fill_checkbox_list(cb_tipo_manifiesto),txtDesde.Text,txtHasta.Text);
             
               
            }
            catch (Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }
        }
    }

    public void valida_permisos_perfil(String id_perfil)
    {
        if (!id_perfil.Equals("3") && !id_perfil.Equals("10") && !id_perfil.Equals("15")) //adm gral, adm desarrollo, adm gral essbio.
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

        int i = 0;
        cb_operadores.Items.Clear();

        foreach (DataRow row in objDS.Tables["OPERADORES"].Rows)
        {
            String name = row[1].ToString();
           
            cb_operadores.Items.Add(name);
            cb_operadores.Items[i].Value = row[0].ToString();
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
        objComando = new OracleDataAdapter("PK_VISOR_MANIFIESTOS.CARGA_BODEGAS", objConexion);
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

   
    //CARGA tipos de manifiestos POSIBLES PARA EL STOCK MINIMO.
    public void carga_tipo_manifiesto()
    {

        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_VISOR_MANIFIESTOS.CARGA_TIPO_MANIFIESTOS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "tipo_manifiesto");
        objConexion.Close();

        int i = 0;

        cb_tipo_manifiesto.Items.Clear();

        foreach (DataRow row in objDS.Tables["tipo_manifiesto"].Rows)
        {

            cb_tipo_manifiesto.Items.Add(row[0].ToString());
            cb_tipo_manifiesto.Items[i].Value = row[0].ToString();
            i = i + 1;

        }


    }


   
    protected void gridOrden_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //gridOrden.PageIndex = e.NewPageIndex;
        gridOrden.PageIndex = e.NewPageIndex;
        carga_grilla_detalle(fill_checkbox_list(cb_bodega), fill_checkbox_list(cb_operadores), fill_checkbox_list(cb_tipo_manifiesto), txtDesde.Text, txtHasta.Text);

    }




    /* ------------------Evento para actualizar la tabla segun el numero de orden que se busca---------------------------------*/


    /* ------------------COLORES DE LA GRILLA (SLA) -------------------------*/
    protected void gridOrden_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
    
    public void carga_grilla_detalle(String bodega,String operador,String tipo_manifiesto, String desde,String hasta)
    {
        lb_mensaje.Text = "";

        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
        id_contr = PRO.recSession(rutaXml, "ID_CONTRATISTA");

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_VISOR_MANIFIESTOS.CARGA_MANIFIESTOS", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        if (bodega.Length == 0)
        {
            if (cb_bodega.Items.Count == 0) bodega = "0";
            else bodega = get_all_checkbox_list(cb_bodega);
        }

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_bodega", OracleType.NVarChar, ParameterDirection.Input, bodega);
        PRO.agrega_parametro_sp(da, "i_cod_instalador", OracleType.NVarChar, ParameterDirection.Input, operador);
        PRO.agrega_parametro_sp(da, "i_tipo_manifiesto", OracleType.NVarChar, ParameterDirection.Input, tipo_manifiesto);
        PRO.agrega_parametro_sp(da, "i_desde", OracleType.NVarChar, ParameterDirection.Input,desde);
        PRO.agrega_parametro_sp(da, "i_hasta", OracleType.NVarChar, ParameterDirection.Input, hasta);

        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("ID_MANIFIESTO", typeof(String)));
        dt.Columns.Add(new DataColumn("ID_BODEGA", typeof(String)));
        dt.Columns.Add(new DataColumn("COD_INSTALADOR", typeof(String)));
        dt.Columns.Add(new DataColumn("CONTRATISTA", typeof(String)));
        dt.Columns.Add(new DataColumn("REGION", typeof(String)));
        dt.Columns.Add(new DataColumn("BODEGA", typeof(String)));
        dt.Columns.Add(new DataColumn("OPERADOR", typeof(String)));
        dt.Columns.Add(new DataColumn("TIPO_MANIFIESTO", typeof(String)));
        dt.Columns.Add(new DataColumn("RESPONSABLE", typeof(String)));
        dt.Columns.Add(new DataColumn("FECHA_GENERACION", typeof(String)));
        
        try
        {
            DataTable dtOrdenes = new DataTable();
            CnOra.Open();

            da.Fill(dtOrdenes);
            grdExcel.DataSource = dtOrdenes;
            grdExcel.DataBind();
            CnOra.Close();

            dt_excel = dt;

            DataRow dr;

            int total = 0, total_dev = 0, total_ret = 0;

            foreach (DataRow drOrdenItem in dtOrdenes.Rows)
            {

                dr = dt.NewRow();

                dr["ID_MANIFIESTO"] = drOrdenItem["ID_MANIFIESTO"].ToString();
                dr["ID_BODEGA"] = drOrdenItem["ID_BODEGA"].ToString();
                dr["COD_INSTALADOR"] = drOrdenItem["COD_INSTALADOR"].ToString();
                dr["CONTRATISTA"] = drOrdenItem["CONTRATISTA"].ToString();
                dr["REGION"] = drOrdenItem["REGION"].ToString();
                dr["BODEGA"] = drOrdenItem["BODEGA"].ToString();                
                dr["OPERADOR"] = drOrdenItem["OPERADOR"].ToString();
                dr["TIPO_MANIFIESTO"] = drOrdenItem["TIPO_MANIFIESTO"].ToString();
                dr["RESPONSABLE"] = drOrdenItem["RESPONSABLE"].ToString();
                dr["FECHA_GENERACION"] = drOrdenItem["FECHA_GENERACION"].ToString();

                dt.Rows.Add(dr);

                total = total + 1;

            }

            DataView MydataView;
            MydataView = new DataView(dt);
            gridOrden.DataSource = MydataView;
            gridOrden.DataBind();

            lbTotal.Text = total + " registro(s) encontrado(s)";
            GridViewRow gvRow;
           
            for (int i = 0; i < gridOrden.Rows.Count; i++)
            {

                gvRow = gridOrden.Rows[i];
               
                try
                {
                   
                }
                catch (Exception ex)
                {
                    continue;
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

            if (gridOrden.PageIndex > 0) index = index - (gridOrden.PageIndex * int.Parse(gridOrden.PageSize.ToString()));
            GridViewRow row = (GridViewRow)gridOrden.Rows[index];//migrilla.Rows[index];

            var colsNoVisible = gridOrden.DataKeys[index].Values;
            string bodega, manifiesto,tipo_manifiesto,instalador;
            manifiesto = (string)colsNoVisible[0]; 
            bodega = (string)colsNoVisible[1]; //row.Cells[1].Text;
            tipo_manifiesto = (string)row.Cells[4].Text;
            instalador = (string)colsNoVisible[2];
                      
            lb_mensaje.Text = "";

            if (e.CommandName == "informe")
            {
                String vtn = "window.open('Informes.aspx?bodega=" + bodega + "&instalador=" + instalador + "&tipo_manifiesto=" + tipo_manifiesto + "&manifiesto=" + manifiesto + "','Dates','scrollbars=yes,resizable=yes,height=500,width=840')";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", vtn, true);
            }
        }
        catch (Exception ex)
        {
            lb_mensaje.ForeColor = System.Drawing.Color.Red;
            lb_mensaje.Text = "Error: " + ex.Message;
        }


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

    protected void check_tipo_manifiesto_Click(object sender, EventArgs e)
    {
        for (int item = 0; item < cb_tipo_manifiesto.Items.Count; item++)
        {
            if (cb_tipo_manifiesto.Items[item].Selected == false)
            {
                cb_tipo_manifiesto.Items[item].Selected = true;

            }
            else
            {
                cb_tipo_manifiesto.Items[item].Selected = false;
            }
        }
    }

    protected void check_operadores_Click(object sender, EventArgs e)
    {
        for (int item = 0; item < cb_operadores.Items.Count; item++)
        {
            if (cb_operadores.Items[item].Selected == false)
            {
                cb_operadores.Items[item].Selected = true;

            }
            else
            {
                cb_operadores.Items[item].Selected = false;
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
        carga_grilla_detalle(fill_checkbox_list(cb_bodega), fill_checkbox_list(cb_operadores), fill_checkbox_list(cb_tipo_manifiesto),txtDesde.Text,txtHasta.Text);

    }
    protected void cb_region_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_bodegas(cb_contratista.SelectedValue, fill_checkbox_list(cb_region));
    }


    protected void cb_operador_SelectedIndexChanged(object sender, EventArgs e)
    {

    }


}
