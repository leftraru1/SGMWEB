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

public partial class EvaluarHitos : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();

    int actividades_as = 0;
    int actividades_des = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            try
            {

                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                lb_rut_empresa.Text = PRO.recSession(rutaXml, "RUT_EMPRESA");
                
                carga_campana();
               
                carga_grilla(0);

                IMG2.Visible = false;
                IMG5.Visible = false;
                IMG6.Visible = false;

            }
            catch (Exception ex)
            {
                //Response.Redirect("errorSesion.aspx");
            }
        }
    }

    public void carga_campana()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_ASIGNACION.CARGA_CAMPANA_SOCIAL", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "CAMPANA");
        objConexion.Close();

        int i = 1;
        ddCampaña.Items.Clear();
        ddCampaña.Items.Add("Seleccione campaña");
        ddCampaña.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["CAMPANA"].Rows)
        {
            ddCampaña.Items.Add(row[1].ToString());
            ddCampaña.Items[i].Value = row[0].ToString(); 
            i = i + 1;
        }
    }

    public void carga_grilla(int camp)
    {
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        // carga campañas sociales
        OracleCommand cmdAcceso = new OracleCommand("PK_EVALUAR_HITOS.CARGA_HITOS_X_CAMPANA", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";

        gridOrden.Columns[0].Visible = true;
        gridOrden.Columns[1].Visible = true;
        gridOrden.Columns[2].Visible = true;

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_campana", OracleType.Int32, ParameterDirection.Input, camp);

        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        DataTable dtOrdenes = new DataTable();

        try
        {
            if (camp != 0) {
                CnOra.Open();
                da.Fill(dtOrdenes);
                CnOra.Close();
                CnOra.Dispose();
            }
            
        }
        catch (Exception ex)
        {
            lbErrorGrilla.ForeColor = System.Drawing.Color.Red;
            lbErrorGrilla.Text = ex.ToString();
        }

        DataTable dt = new DataTable();

        
        dt.Columns.Add(new DataColumn("ID_HITO", typeof(String)));
        dt.Columns.Add(new DataColumn("ID_ACTIVIDAD", typeof(String)));
        dt.Columns.Add(new DataColumn("NOMBRE_HITO", typeof(String)));
        dt.Columns.Add(new DataColumn("NOMBRE_ACTIVIDAD", typeof(String)));
        dt.Columns.Add(new DataColumn("ESTADO_EVALUACION", typeof(String)));
        dt.Columns.Add(new DataColumn("FECHA_EVALUACION", typeof(String)));
        dt.Columns.Add(new DataColumn("FECHA_CAMBIO", typeof(String)));
        dt.Columns.Add(new DataColumn("OBSERVACION", typeof(String)));
        dt.Columns.Add(new DataColumn("ESTADO", typeof(String)));
        //dt.Columns.Add(new DataColumn("NOMBRE_CAM", typeof(String)));
        //dt.Columns.Add(new DataColumn("NOM_TIPO_CAM", typeof(String)));

        int hito = 1, actividad = 1,ant_hito=0;
        DataRow dr;

        int total = 0;

        foreach (DataRow drOrdenItem in dtOrdenes.Rows)
        {
            dr = dt.NewRow();

            ant_hito = hito;

            if (int.Parse(drOrdenItem["ID_HITO"].ToString()) != ant_hito)
            {
                hito = hito + 1;
                actividad = 1;
            }

            dr["ID_HITO"] = drOrdenItem["ID_HITO"].ToString();
            dr["ID_ACTIVIDAD"] = drOrdenItem["ID_ACTIVIDAD_DE_HITO"].ToString();
            dr["NOMBRE_HITO"] = hito+".- "+ drOrdenItem["NOMBRE_HITO"].ToString();
            dr["NOMBRE_ACTIVIDAD"] = actividad+".- "+ drOrdenItem["NOMBRE_ACTIVIDAD"].ToString();
            dr["ESTADO"] = drOrdenItem["ESTADO_EVALUACION"].ToString();

            dr["FECHA_EVALUACION"] = drOrdenItem["FECHA_EVALUACION"].ToString();
            dr["ESTADO_EVALUACION"] = drOrdenItem["ESTADO_EVALUACION"].ToString();
            dr["FECHA_CAMBIO"] = drOrdenItem["FECHA_CAMBIO"].ToString();

            if (dr["ESTADO_EVALUACION"].Equals("1"))
            {
                dr["ESTADO_EVALUACION"] = "REALIZADO";
            }
            else {
                dr["ESTADO_EVALUACION"] = "NO REALIZADO";
            }

            dr["OBSERVACION"] = drOrdenItem["OBSERVACION"].ToString();
            //dr["NOMBRE_CAM"] = drOrdenItem["NOMBRE_CAM"].ToString();
           // dr["NOM_TIPO_CAM"] = drOrdenItem["NOM_TIPO_CAM"].ToString();
            
            dt.Rows.Add(dr);
            total = total + 1;
            actividad = actividad + 1;
        }

        DataView MydataView;
        MydataView = new DataView(dt);
        gridOrden.DataSource = MydataView;
        gridOrden.DataBind();

        // AQUI PONER INVISIBLE LOS CAMPOS 
        gridOrden.Columns[0].Visible = false;
        gridOrden.Columns[1].Visible = false;
        gridOrden.Columns[2].Visible = false;
        lbTotal.Text = total + " registro(s) encontrado(s)";

        int i;
        GridViewRow gvRow;
        CheckBox chk_as;
        CheckBox chk_des;

        for (i = 0; i < gridOrden.Rows.Count; i++)
        {

            gvRow = gridOrden.Rows[i];
            chk_as = ((CheckBox)gvRow.FindControl("check_asigna"));
            chk_des = ((CheckBox)gvRow.FindControl("chk_des"));

            if (gridOrden.Rows[i].Cells[2].Text == "1" || gridOrden.Rows[i].Cells[2].Text == "")
            {
                chk_as.Enabled = false;
                chk_des.Enabled = true;
            }
            else {
                if (gridOrden.Rows[i].Cells[2].Text == "0")
                {
                    chk_as.Enabled = true;
                    chk_des.Enabled = false;
                }
            }

        }
    }


    public Boolean valida_check()
    {
        int c;
        Boolean check = false;
        GridViewRow gvRow;
        CheckBox check_row = new CheckBox();

        for (c = 0; c < gridOrden.Rows.Count; c++)
        {
            gvRow = gridOrden.Rows[c];
            check_row = (CheckBox)(gvRow.FindControl("check_asigna"));
            if (check_row.Checked == true)
            {
                check = true;
            }
        }

        return check;
    }

    protected void ACEPTAR(object sender, EventArgs e)
    {
        ASIGNAR();
        DESASIGNAR();

        if (actividades_as != 0 || actividades_des != 0)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " cambio_actividades('" + actividades_as + "','" + actividades_des + "');", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " Selecione('');", true);
        }

        carga_grilla(int.Parse(ddCampaña.SelectedValue));
    }


    public void ASIGNAR()
    {
        if (valida_check() == true)
        {
            IMG2.Visible = false;
            IMG5.Visible = false;
            IMG6.Visible = false;

            lbResultado.Text = "";
            int i;
            GridViewRow gvRow;
            CheckBox check_permiso = new CheckBox();

            for (i = 0; i < gridOrden.Rows.Count; i++)
            {
                gvRow = gridOrden.Rows[i];
                check_permiso = (CheckBox)(gvRow.FindControl("check_asigna"));

                if (check_permiso.Checked == true)
                {
                    OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
                    OracleDataAdapter ComandoDA;

                    objConexion.Open();

                    // CHECKEAR ACTIVIDAD
                    ComandoDA = new OracleDataAdapter("PK_EVALUAR_HITOS.CHECK_HITO", objConexion);
                    ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

                    Int32 i_hito = Int32.Parse(gridOrden.Rows[i].Cells[0].Text);
                    Int32 i_actividad = Int32.Parse(gridOrden.Rows[i].Cells[1].Text);

                    PRO.agrega_parametro_sp(ComandoDA, "i_campana", OracleType.Int32, ParameterDirection.Input, int.Parse(ddCampaña.SelectedValue));
                    PRO.agrega_parametro_sp(ComandoDA, "i_hito", OracleType.Int32, ParameterDirection.Input, i_hito);
                    PRO.agrega_parametro_sp(ComandoDA, "i_actividad", OracleType.Int32, ParameterDirection.Input, i_actividad);

                    try
                    {
                        ComandoDA.SelectCommand.ExecuteNonQuery();
                        objConexion.Close();
                        actividades_as = actividades_as + 1;

                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " Error('');", true);
                        break;
                    }
                    objConexion.Dispose();
                }
                
            }

        }
    }

    public void DESASIGNAR()
    {
        
        int i;
        GridViewRow gvRow;

        CheckBox chk_des = new CheckBox();

        for (i = 0; i < gridOrden.Rows.Count; i++)
        {

            gvRow = gridOrden.Rows[i];
            chk_des = (CheckBox)(gvRow.FindControl("chk_des"));

            if (chk_des.Checked == true )
            {
                OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
                OracleDataAdapter ComandoDA;

                objConexion.Open();
                // Cambiar el hito a no realizado
                ComandoDA = new OracleDataAdapter("PK_EVALUAR_HITOS.DES_CHECK_HITO", objConexion);
                ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

                Int32 i_hito = Int32.Parse(gridOrden.Rows[i].Cells[0].Text);
                Int32 i_actividad = Int32.Parse(gridOrden.Rows[i].Cells[1].Text);

                PRO.agrega_parametro_sp(ComandoDA, "i_campana", OracleType.Int32, ParameterDirection.Input, int.Parse(ddCampaña.SelectedValue));
                PRO.agrega_parametro_sp(ComandoDA, "i_hito", OracleType.Int32, ParameterDirection.Input, i_hito);
                PRO.agrega_parametro_sp(ComandoDA, "i_actividad", OracleType.Int32, ParameterDirection.Input, i_actividad);

                try
                {
                    ComandoDA.SelectCommand.ExecuteNonQuery();
                    objConexion.Close();
                    actividades_des = actividades_des + 1;
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " Error('');", true);
                    break;
                }
                objConexion.Dispose();
            }
            
        }
    }

    protected void gridOrden_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridOrden.PageIndex = e.NewPageIndex;
        carga_grilla(int.Parse(ddCampaña.SelectedValue));    
    }

    protected void gridOrden_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int index = 0, id_hito = 0, id_actividad = 0;
        String estado = null;

        if(e.CommandArgument.ToString()!="") { 
            index = int.Parse(e.CommandArgument.ToString());
            index = index % gridOrden.PageSize;
            id_hito = int.Parse(gridOrden.Rows[index].Cells[0].Text);
            id_actividad = int.Parse(gridOrden.Rows[index].Cells[1].Text);
            estado = gridOrden.Rows[index].Cells[7].Text;
        }

        if (e.CommandName == "asignar")
        {
            checkTodos("check_asigna");
        }

        if (e.CommandName == "desasignar")
        {
            checkTodos("chk_des");
        }

        if (e.CommandName == "text_obs") {
            String vtn = "window.open('Subir_observacion.aspx?id_hito=" + id_hito + "&id_actividad=" + id_actividad + "&id_campaña=" + int.Parse(ddCampaña.SelectedValue) + "','Dates','scrollbars=yes,resizable=yes,height=500,width=840')";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", vtn, true);
        }

        if(e.CommandName=="subir"){
            String vtn = "window.open('Subir_respaldo_actividad.aspx?id_hito=" + id_hito + "&id_actividad=" + id_actividad + "&id_campaña=" + int.Parse(ddCampaña.SelectedValue) + "','Dates','scrollbars=yes,resizable=yes,height=500,width=840')";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", vtn, true);
        }

        if (e.CommandName == "informe")
        {
            String vtn = "window.open('Informe_hitos.aspx?id_hito=" + id_hito + "&id_actividad=" + id_actividad + "&id_campaña=" + int.Parse(ddCampaña.SelectedValue) + "&estado="+estado+"','Dates','scrollbars=yes,resizable=yes,height=500,width=840')";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", vtn, true);
        }

        if (e.CommandName == "DOC1")
        {
            string pa1 = "~/RESPALDO_HITOS/" + int.Parse(ddCampaña.SelectedValue) + "/DOCUMENTO1" + int.Parse(ddCampaña.SelectedValue) + id_hito + id_actividad + ".pdf";

            try
            {
                if (System.IO.File.Exists(pa1))
                {
                   Response.Redirect("~/RESPALDO_HITOS/" + int.Parse(ddCampaña.SelectedValue) + "/DOCUMENTO1" + int.Parse(ddCampaña.SelectedValue) + id_hito + id_actividad + ".pdf");

                }else{

                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " archivo('');", true);
                
                }
               
            }
            catch (Exception ex)
            {

            }
        }

        if (e.CommandName == "DOC2")
        {
            string pa2 = "~/RESPALDO_HITOS/" + int.Parse(ddCampaña.SelectedValue) + "/DOCUMENTO2" + int.Parse(ddCampaña.SelectedValue) + id_hito + id_actividad + ".pdf";

            try
            {
                if (System.IO.File.Exists(Server.MapPath(pa2)))
                {
                Response.Redirect("~/RESPALDO_HITOS/" + int.Parse(ddCampaña.SelectedValue) + "/DOCUMENTO2" + int.Parse(ddCampaña.SelectedValue) + id_hito + id_actividad + ".pdf");
                
                }else{
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " archivo('');", true);
                }   
            
            }
            catch (Exception ex)
            {

            }

        }
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

            if ((check_row.Enabled == true))
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

    // FUNCION DROP CAMPAÑA
    protected void ddCampaña_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla(int.Parse(ddCampaña.SelectedValue));
    }

    protected void Calendar1_SelectionChanged(object sender, EventArgs e)
    {

    }

    protected void Button1_Click1(object sender, EventArgs e)
    {
        carga_grilla(int.Parse(ddCampaña.SelectedValue));
    }

    protected void gridOrden_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.RowState == DataControlRowState.Alternate)
            {
              //  e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#FFFFE1';");
               // e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor='#f7fff8';");
            }
            else
            {
               // e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#FFFFE1';");
               // e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor='#eefef0';");
            }
            
        }
    }

    protected void gridOrden_SelectedIndexChanged(object sender, EventArgs e)
    {
        
        String servicio = gridOrden.SelectedRow.Cells[4].Text;
        String numero_orden = gridOrden.SelectedRow.Cells[2].Text;
        String id = gridOrden.SelectedRow.Cells[0].Text;
        String obs = gridOrden.SelectedRow.Cells[15].Text;
        String libreta = gridOrden.SelectedRow.Cells[9].Text;
        String tipo = gridOrden.SelectedRow.Cells[16].Text;
        String vtn = "window.open('DetalleOrden.aspx?servicio=" + servicio + "&numero_orden=" + numero_orden + "&id=" + id + "&lib=" + libreta + "&obs=" + obs + "&tipo=" + tipo + "','Dates','scrollbars=yes,resizable=yes,height=600,width=1000')";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", vtn, true);
    }
}

