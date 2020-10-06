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
using System.Drawing;

public partial class SustitucionMedidor : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();
    String numeroOrd;
   public static int bandera = 0;
   public string  rutempresa ;


    protected void Page_Load(object sender, EventArgs e)
    {
        


        if (!Page.IsPostBack)
        {

            try
            {
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                PRO.recSession(rutaXml, "RUT_EMPRESA");
                //int id_cont = 0;
                //id_cont = int.Parse(PRO.recSession(rutaXml, "ID_CONTRATISTA"));


                carga_region();
                carga_zona(ddregion.SelectedValue);
                carga_localidad(ddzona.SelectedValue);
                carga_contratista(); 
                
              
             //carga_instalador(0, 0, 0);
             //carga_grilla_General(0, 0, 0, 0,0);

              // cargaGrilla(0);
              // ddlEstadoOrd.Enabled = false;
               //ddlEstadoImp.Enabled = false;
            }
            catch (Exception ex)
            {
               
                //Response.Redirect("errorSesion.aspx");
            }
            
        }
    }

    public void carga_instalador(int region,int zona ,int localidad, int contratista)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_SUSTITUCION_MEDIDOR.CARGAR_INSTALADOR", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_region", OracleType.Int32, ParameterDirection.Input, region.ToString());
        PRO.agrega_parametro_sp(objComando, "i_zona", OracleType.Int32, ParameterDirection.Input, zona.ToString());
        PRO.agrega_parametro_sp(objComando, "i_localidad", OracleType.Int32, ParameterDirection.Input, localidad.ToString());
        PRO.agrega_parametro_sp(objComando, "i_contratista", OracleType.Int32, ParameterDirection.Input, contratista.ToString());

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "INSTALADOR");
        objConexion.Close();

        int i = 1;
        
        ddinstalador.Items.Clear();
        ddinstalador.Items.Add("Todas...");
        ddinstalador.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["INSTALADOR"].Rows)
        {

            ddinstalador.Items.Add(row[1].ToString() + " - " + row[2].ToString());
            ddinstalador.Items[i].Value = row[0].ToString() ;
            i = i + 1;

        }
    }
    public void carga_contratista()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
       
        objComando = new OracleDataAdapter("PK_SUSTITUCION_MEDIDOR.CARGA_CONTRATISTA", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
       
        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "CONTRATISTA");
        objConexion.Close();

        int i = 1;

        ddcontratista.Items.Clear();
        ddcontratista.Items.Add("Todas...");
        ddcontratista.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["CONTRATISTA"].Rows)
        {

            ddcontratista.Items.Add(row[1].ToString());
            ddcontratista.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }
    public void carga_region()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_SUSTITUCION_MEDIDOR.CARGA_REGION", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "REGION");
        objConexion.Close();

        int i = 1;

        ddregion.Items.Clear();
        ddregion.Items.Add("Todas...");
        ddregion.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["REGION"].Rows)
        {

            ddregion.Items.Add(row[1].ToString());
            ddregion.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }
    public void carga_localidad(String zona )
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_SUSTITUCION_MEDIDOR.CARGA_LOCALIDAD", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
      //  PRO.agrega_parametro_sp(objComando, "i_region", OracleType.Int32, ParameterDirection.Input, region);
        PRO.agrega_parametro_sp(objComando, "i_zona", OracleType.Int32, ParameterDirection.Input, zona);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "LOCALIDAD");
        objConexion.Close();

        int i = 1;

        ddlocalidad.Items.Clear();
        ddlocalidad.Items.Add("Todas...");
        ddlocalidad.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["LOCALIDAD"].Rows)
        {

            ddlocalidad.Items.Add(row[1].ToString());
            ddlocalidad.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }
    public void carga_zona(string  region )
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_SUSTITUCION_MEDIDOR.CARGA_ZONA_O", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_region", OracleType.Int32, ParameterDirection.Input, region);
        
        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "ZONA");
        objConexion.Close();

        int i = 1;

        ddzona.Items.Clear();
        ddzona.Items.Add("Todas...");
        ddzona.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["ZONA"].Rows)
        {

            ddzona.Items.Add(row[1].ToString());
            ddzona.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }

    public void carga_grilla_General(int region, int zona, int localidad, int contratista, int instalador)
    {
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter da;
        DataSet objDS = new DataSet();

        CnOra.Open();
        da = new OracleDataAdapter("PK_SUSTITUCION_MEDIDOR.CARGAR_ORDENES", CnOra);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_region", OracleType.Int32, ParameterDirection.Input, region.ToString());
        PRO.agrega_parametro_sp(da, "i_zona", OracleType.Int32, ParameterDirection.Input, zona.ToString());
        PRO.agrega_parametro_sp(da, "i_localidad", OracleType.Int32, ParameterDirection.Input, localidad.ToString());
        PRO.agrega_parametro_sp(da, "i_instalador", OracleType.Int32, ParameterDirection.Input, instalador.ToString());
        PRO.agrega_parametro_sp(da, "i_contratista", OracleType.Int32, ParameterDirection.Input, contratista.ToString());

        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        DataTable dtOrdenes = new DataTable();

        try
        {
            
            da.Fill(dtOrdenes);
            CnOra.Close();
            CnOra.Dispose();

        }
        catch (Exception ex)
        {
            //lbErrorGrilla.Text = ex.ToString() + servicio;
            //lbErrorGrilla.ForeColor = System.Drawing.Color.Red;

            //lbErrorGrilla.Text = ex.ToString() + numero_orden;
            //lbErrorGrilla.ForeColor = System.Drawing.Color.Red;
            //lbErrorGrilla.Text = desde + "***" + hasta;

        }

        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("NUMERO_ORDEN", typeof(String)));
        dt.Columns.Add(new DataColumn("FECHA_CREACION", typeof(String))); //
        dt.Columns.Add(new DataColumn("ID_SERVICIO", typeof(String)));
        dt.Columns.Add(new DataColumn("NOMBRE_CONTRATISTA", typeof(String)));
        dt.Columns.Add(new DataColumn("RUTA", typeof(String)));
        dt.Columns.Add(new DataColumn("LOCALIDAD", typeof(String)));
        dt.Columns.Add(new DataColumn("CLIENTE", typeof(String)));
        dt.Columns.Add(new DataColumn("DIRECCION", typeof(String)));
        dt.Columns.Add(new DataColumn("NOMBRE_INSTALADOR", typeof(String)));
        dt.Columns.Add(new DataColumn("CAUSA_CAMBIO", typeof(String)));
     

        DataRow dr;

        int total = 0;

        foreach (DataRow drOrdenItem in dtOrdenes.Rows)
        {

            dr = dt.NewRow();

            dr["NUMERO_ORDEN"] = drOrdenItem["NUMERO_ORDEN"].ToString();
            dr["FECHA_CREACION"] = drOrdenItem["FECHA_CREACION"].ToString().Replace("00:00:00", "");
            dr["ID_SERVICIO"] = drOrdenItem["ID_SERVICIO"].ToString();//
            dr["NOMBRE_CONTRATISTA"] = drOrdenItem["NOMBRE_CONTRATISTA"].ToString();
            dr["RUTA"] = drOrdenItem["RUTA"].ToString();
            dr["LOCALIDAD"] = drOrdenItem["LOCALIDAD"].ToString();
            dr["CLIENTE"] = drOrdenItem["CLIENTE"].ToString();
            dr["DIRECCION"] = drOrdenItem["DIRECCION"].ToString();
            dr["NOMBRE_INSTALADOR"] = drOrdenItem["NOMBRE_INSTALADOR"].ToString();
            dr["CAUSA_CAMBIO"] = drOrdenItem["CAUSA_CAMBIO"].ToString();
          

            dt.Rows.Add(dr);

            total = total + 1;

        }

        DataView MydataView;
        MydataView = new DataView(dt);
        GridOrden.DataSource = MydataView;
        GridOrden.DataBind();
       
            lb_mje.Visible = true;
            lb_mje.ForeColor = Color.Black;
            lb_mje.Text = "SE HAN ENCONTRADO: " +total+ " REGISTROS ";
  

    }
   

    public void checkTodos(String check)
    {
        int c;
        Boolean b;
    
        GridViewRow gvRow;
        CheckBox check_row = new CheckBox();
        gvRow = GridOrden.Rows[0];
        check_row = (CheckBox)(gvRow.FindControl(check));
        b = check_row.Checked;


        for (c = 0; c < GridOrden.Rows.Count; c++)
        {
            gvRow = GridOrden.Rows[c];
            check_row = (CheckBox)(gvRow.FindControl(check));

            if ((check_row.Enabled == true))
            {

                if (b == true)
                {
                    check_row.Checked = false;
                }
                else
                {
                    check_row.Checked = true;
                }




                //else if ((check_row.Checked == false))
                //{

                //    check_row.Checked = true;

                //}


                //else
                //{
                //    check_row.Checked = true;
                //}

            }
        }
    }
    //protected void chkboxSelectAll_CheckedChanged(object sender, EventArgs e)
    //{
    //    CheckBox ChkBoxHeader = (CheckBox)GridOrden.HeaderRow.FindControl("chkboxSelectAll");
    //    foreach (GridViewRow row in GridOrden.Rows)
    //    {
    //        CheckBox ChkBoxRows = (CheckBox)row.FindControl("check_impr2");
    //        if (ChkBoxHeader.Checked == true)
    //        {
    //            ChkBoxRows.Checked = true;
    //        }
    //        else
    //        {
    //            ChkBoxRows.Checked = false;
    //        }
    //    }
    //}

   // protected void ddlEstadoOrd_SelectedIndexChanged(object sender, EventArgs e)
   // {
   //     int contador = 0;

   //     foreach (GridViewRow row in GridOrden.Rows)
   //     {
   //         if (row.Cells.Count > 1)
   //         {
   //             contador++;
   //         }
   //     }

   //     if (contador > 0)
   //     {

   //     }
   //     else
   //         System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, typeof(System.Web.UI.Page), "Script", "alertaCortador();", true);

   // }
   // protected void ddlEstadoImp_SelectedIndexChanged(object sender, EventArgs e)
   // {
   //     int contador = 0;

   //     foreach (GridViewRow row in GridOrden.Rows)
   //     {
   //         if (row.Cells.Count > 1)
   //         {
   //             contador++;
   //         }
   //     }

   //     if (contador > 0)
   //     {
   ////         cargarGrilla2(int.Parse(ddlEstadoOrd.SelectedValue), int.Parse(ddlEstadoImp.SelectedValue));
   //     }
   //     else
   //         System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, typeof(System.Web.UI.Page), "Script", "alertaCortador();", true);

    //}
    protected void ddregion_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_zona(ddregion.SelectedValue);
        carga_localidad(ddzona.SelectedValue);
        carga_contratista();
        carga_instalador(int.Parse(ddregion.SelectedValue), int.Parse(ddzona.SelectedValue), int.Parse(ddlocalidad.SelectedValue), int.Parse(ddcontratista.SelectedValue));
        carga_grilla_General(int.Parse(ddregion.SelectedValue), int.Parse(ddzona.SelectedValue), int.Parse(ddlocalidad.SelectedValue), int.Parse(ddcontratista.SelectedValue), int.Parse(ddinstalador.SelectedValue));

    }
    protected void ddzona_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_localidad(ddzona.SelectedValue);
        carga_instalador(int.Parse(ddregion.SelectedValue), int.Parse(ddzona.SelectedValue), int.Parse(ddlocalidad.SelectedValue), int.Parse(ddcontratista.SelectedValue));
        carga_grilla_General(int.Parse(ddregion.SelectedValue), int.Parse(ddzona.SelectedValue), int.Parse(ddlocalidad.SelectedValue), int.Parse(ddcontratista.SelectedValue),int.Parse(ddinstalador.SelectedValue)); 
    }
    protected void ddlocalidad_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_instalador(int.Parse(ddregion.SelectedValue), int.Parse(ddzona.SelectedValue), int.Parse(ddlocalidad.SelectedValue), int.Parse(ddcontratista.SelectedValue));
        carga_grilla_General(int.Parse(ddregion.SelectedValue), int.Parse(ddzona.SelectedValue), int.Parse(ddlocalidad.SelectedValue), int.Parse(ddcontratista.SelectedValue) ,int.Parse(ddinstalador.SelectedValue)); 
    }
    protected void ddinstalador_SelectedIndexChanged(object sender, EventArgs e)
    {

        carga_grilla_General(int.Parse(ddregion.SelectedValue), int.Parse(ddzona.SelectedValue), int.Parse(ddlocalidad.SelectedValue), int.Parse(ddcontratista.SelectedValue), int.Parse(ddinstalador.SelectedValue)); 
    }
  
    protected void GridOrden_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridOrden.PageIndex = e.NewPageIndex;
        carga_grilla_General(int.Parse(ddregion.SelectedValue), int.Parse(ddzona.SelectedValue), int.Parse(ddlocalidad.SelectedValue), int.Parse(ddcontratista.SelectedValue), int.Parse(ddinstalador.SelectedValue)); 
    }
    protected void GridOrden_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.RowState == DataControlRowState.Alternate)
            {
            }
            else
            {
                
            }
        }
    }
    protected void GridOrden_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "asignar")
        {
            checkTodos("check_asigna");
        }
    }
    protected void btnimprime_Click(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        int contador = 0;
        String numero_orden = "";

        foreach (GridViewRow row in GridOrden.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chkRow = (row.Cells[0].FindControl("check_asigna") as CheckBox);
                if (chkRow.Checked)
                {
                    contador++;

                }
            }
        }


        if (contador >= 1)
        {
            dt.Columns.AddRange(new DataColumn[1] { new DataColumn("NUMERO_ORDEN") });
            //int bandera = 0;


            foreach (GridViewRow row in GridOrden.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    CheckBox chkRow = (row.Cells[0].FindControl("check_asigna") as CheckBox);
                    if (chkRow.Checked)
                    {

                        numeroOrd = row.Cells[0].Text;
                        dt.Rows.Add(numeroOrd);
                       
                        //numeroOrd = row.Cells[0].Text;
                        //if (bandera == 0)
                        //{
                        //    numero_orden = numeroOrd;
                        //    bandera = bandera + 1;
                        //}
                        //else
                        //{
                        //    numero_orden = numeroOrd + "," + numero_orden;
                        //}
                        //dt.Rows.Add(numeroOrd);

                    }
                }
            }
            Session["griddata"] = dt;

            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, typeof(System.Web.UI.Page), "Script", "abrir();", true);

            //Response.Write("<script type='text/javascript'>window.open('InformeSustitucionMedidor.aspx " + numero_orden + "','pop','scrollbars=yes,resizable=yes,height=500,width=840');</script>");




        }
        else if (contador < 1)
        {

            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, typeof(System.Web.UI.Page), "Script", "alerta();", true);
            //cargaGrilla(0, 0, 0);
        }
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        carga_grilla_General(int.Parse(ddregion.SelectedValue), int.Parse(ddzona.SelectedValue), int.Parse(ddlocalidad.SelectedValue), int.Parse(ddcontratista.SelectedValue), int.Parse(ddinstalador.SelectedValue));  
    }
    protected void ddcontratista_SelectedIndexChanged(object sender, EventArgs e)
    {
       //carga_instalador(int.Parse(ddregion.SelectedValue), int.Parse(ddzona.SelectedValue), int.Parse(ddlocalidad.SelectedValue), int.Parse(ddcontratista.SelectedValue));
       carga_grilla_General(int.Parse(ddregion.SelectedValue), int.Parse(ddzona.SelectedValue), int.Parse(ddlocalidad.SelectedValue), int.Parse(ddcontratista.SelectedValue), int.Parse(ddinstalador.SelectedValue)); 
    }
}
