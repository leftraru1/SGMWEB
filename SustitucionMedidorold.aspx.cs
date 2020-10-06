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

public partial class SustitucionMedidor : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();
    String numeroOrd;

    protected void Page_Load(object sender, EventArgs e)
    {
        


        if (!Page.IsPostBack)
        {

            try
            {
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                PRO.recSession(rutaXml, "RUT_EMPRESA");

                carga_zona();             
               cargaGrilla(0);
              // ddlEstadoOrd.Enabled = false;
               //ddlEstadoImp.Enabled = false;
            }
            catch (Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }
            
        }
    }

    public void carga_zona()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_ZONA.CARGAR_ZONA", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "ZONA");
        objConexion.Close();

        int i = 1;
        ddZona.Items.Clear();
        ddZona.Items.Add("Todas...");
        ddZona.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["ZONA"].Rows)
        {

            ddZona.Items.Add(row[1].ToString());
            ddZona.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }

    protected void Button1_Click1(object sender, EventArgs e)
    {

        DataTable dt = new DataTable();
        int contador = 0;

        foreach (GridViewRow row in GridOrden.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chkRow = (row.Cells[0].FindControl("check_impr2") as CheckBox);
                if (chkRow.Checked)
                {
                    contador++;

                }
            }
        }


        if (contador >= 1)
        {
            dt.Columns.AddRange(new DataColumn[1] { new DataColumn("NUMERO_ORDEN") });
            foreach (GridViewRow row in GridOrden.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    CheckBox chkRow = (row.Cells[0].FindControl("check_impr2") as CheckBox);
                    if (chkRow.Checked)
                    {
                        numeroOrd = row.Cells[0].Text;
                        dt.Rows.Add(numeroOrd);

                    }
                }
            }


            Session["griddata"] = dt;
           // cargaGrilla(0, 0, 0);
            //GridView1.DataSource = dt;
            //GridView1.DataBind();

            Response.Write("<script type='text/javascript'>window.open('InformeSustitucionMedidor.aspx','pop','scrollbars=yes,resizable=yes,height=500,width=840');</script>");
            

        }
        else if (contador < 1)
        {
            
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, typeof(System.Web.UI.Page), "Script", "alerta();", true);
            //cargaGrilla(0, 0, 0);
        }
        
    }
  
    protected void ddZona_SelectedIndexChanged(object sender, EventArgs e)
    {
        
        cargaGrilla( int.Parse(ddZona.SelectedValue));
        //if (GridOrden.Columns.Count == 0)
        //{

        //    ddlEstadoOrd.Enabled = false;
        //    ddlEstadoImp.Enabled = false;
        
        //}


    }
  

    public void cargaGrilla(int zona)
    {
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_SUSTITUCION_MEDIDOR.CARGA_OPERADORES_ZONA", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_rutem", OracleType.NVarChar, ParameterDirection.Input, PRO.recSession(rutaXml, "RUT_EMPRESA"));        
        PRO.agrega_parametro_sp(da, "i_IDZONA", OracleType.Int32, ParameterDirection.Input, zona.ToString());
       

        da.SelectCommand.CommandType = CommandType.StoredProcedure;
    
        DataTable dtOrdenes = new DataTable();    
        CnOra.Open();            
        da.Fill(dtOrdenes);
        GrdInstalador.DataSource = dtOrdenes;
        GrdInstalador.DataBind();
        CnOra.Close();
        CnOra.Dispose();
      
    }

    public void cargarGrilla2(int numOrden, int EstadoImpresa) 
    {
        DataTable dt = new DataTable();
        string queryFiltro = "";
        Boolean marca;
        marca = false;
        OracleCommand cmd = new OracleCommand();
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter adapter = new OracleDataAdapter(cmd);
        DataSet ds = new DataSet();

        if (numOrden == 0 && EstadoImpresa == 0)
        {

            ddlEstadoOrd.SelectedIndex = 0;
            ddlEstadoImp.SelectedIndex = 0;
        
        }




        dt.Columns.AddRange(new DataColumn[1] { new DataColumn("NUMERO_ORDEN") });
        foreach (GridViewRow row in GrdInstalador.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chkRow = (row.Cells[0].FindControl("check_impr1") as CheckBox);
                if (chkRow.Checked)
                {
                    numeroOrd = row.Cells[0].Text;
                    dt.Rows.Add(numeroOrd);

                }
            }
        }

        GridSeloper.DataSource = dt;
        GridSeloper.DataBind();



        foreach (GridViewRow row in GridSeloper.Rows)
        {
            if (GridSeloper.Rows.Count > 1)
            {
                if (marca == false)
                {
                    queryFiltro = queryFiltro + "" + row.Cells[0].Text;
                    marca = true;
                }
                else
                {
                    queryFiltro = queryFiltro + "," + row.Cells[0].Text;
                }
            }
            else if (GridSeloper.Rows.Count == 1)
            {
                queryFiltro = queryFiltro + row.Cells[0].Text;

            }

        }

        if (numOrden >= 1)
        {
            if (numOrden == 1)
            {
                string Sql1 = "";
                Sql1 = Sql1 + "select O.NUMERO_ORDEN,O.FECHA_CREACION,O.ID_SERVICIO, ";
                Sql1 = Sql1 + "O.RUTA,O.LOCALIDAD,O.CLIENTE,O.DIRECCION,O.COD_INSTALADOR,EO.DESCRIPCION  ";
                Sql1 = Sql1 + "from ORDEN O ";
                Sql1 = Sql1 + "LEFT JOIN ESTATUS_ORDEN EO ON EO.COD_ESTATUS_ORDEN=O.COD_IMPROCEDENCIA ";
                Sql1 = Sql1 + "WHERE O.COD_INSTALADOR in (" + queryFiltro + ") and O.ID_SINCRONIZACION in(4) ORDER BY O.RUTA";


                objConexion.Open();

                cmd.Connection = objConexion;
                cmd.CommandText = Sql1;
                cmd.CommandType = CommandType.Text;
                //OracleDataReader dr = cmd.ExecuteReader();

                adapter.SelectCommand.ExecuteNonQuery();
                adapter.Fill(ds, "Table");

                GridOrden.DataSource = ds.Tables["Table"];
                GridOrden.DataBind();
                objConexion.Close();
            }
            if (numOrden == 2)
            {
                string Sql2 = "";
                Sql2 = Sql2 + "select O.NUMERO_ORDEN,O.FECHA_CREACION,O.ID_SERVICIO, ";
                Sql2 = Sql2 + "O.RUTA,O.LOCALIDAD,O.CLIENTE,O.DIRECCION,O.COD_INSTALADOR,EO.DESCRIPCION  ";
                Sql2 = Sql2 + "from ORDEN O ";
                Sql2 = Sql2 + "LEFT JOIN ESTATUS_ORDEN EO ON EO.COD_ESTATUS_ORDEN=O.COD_IMPROCEDENCIA ";
                Sql2 = Sql2 + "WHERE O.COD_INSTALADOR in (" + queryFiltro + ") and O.ID_SINCRONIZACION in(1)  ORDER BY O.RUTA";


                objConexion.Open();

                cmd.Connection = objConexion;
                cmd.CommandText = Sql2;
                cmd.CommandType = CommandType.Text;
                //OracleDataReader dr = cmd.ExecuteReader();

                adapter.SelectCommand.ExecuteNonQuery();
                adapter.Fill(ds, "Table");

                GridOrden.DataSource = ds.Tables["Table"];
                GridOrden.DataBind();
                objConexion.Close();
            }
            if (numOrden == 3)
            {
                string Sql3 = "";
                Sql3 = Sql3 + "select O.NUMERO_ORDEN,O.FECHA_CREACION,O.ID_SERVICIO, ";
                Sql3 = Sql3 + "O.RUTA,O.LOCALIDAD,O.CLIENTE,O.DIRECCION,O.COD_INSTALADOR,EO.DESCRIPCION  ";
                Sql3 = Sql3 + "from ORDEN O ";
                Sql3 = Sql3 + "LEFT JOIN ESTATUS_ORDEN EO ON EO.COD_ESTATUS_ORDEN=O.COD_IMPROCEDENCIA ";
                Sql3 = Sql3 + "WHERE O.COD_INSTALADOR in (" + queryFiltro + ") and O.ID_SINCRONIZACION in(3) ORDER BY O.RUTA";


                objConexion.Open();

                cmd.Connection = objConexion;
                cmd.CommandText = Sql3;
                cmd.CommandType = CommandType.Text;
                //OracleDataReader dr = cmd.ExecuteReader();

                adapter.SelectCommand.ExecuteNonQuery();
                adapter.Fill(ds, "Table");

                GridOrden.DataSource = ds.Tables["Table"];
                GridOrden.DataBind();
                objConexion.Close();
            }
            
        }
        if (EstadoImpresa >= 1)
        {
            if (EstadoImpresa == 1)
            {
                string Sql4 = "";
                Sql4 = Sql4 + "select O.NUMERO_ORDEN,O.FECHA_CREACION,O.ID_SERVICIO, ";
                Sql4 = Sql4 + "O.RUTA,O.LOCALIDAD,O.CLIENTE,O.DIRECCION,O.COD_INSTALADOR,EO.DESCRIPCION  ";
                Sql4 = Sql4 + "from ORDEN O ";
                Sql4 = Sql4 + "LEFT JOIN ESTATUS_ORDEN EO ON EO.COD_ESTATUS_ORDEN=O.COD_IMPROCEDENCIA ";
                Sql4 = Sql4 + "WHERE O.COD_INSTALADOR in (" + queryFiltro + ") and O.ID_SINCRONIZACION in(3,4) ORDER BY O.RUTA";

                objConexion.Open();

                cmd.Connection = objConexion;
                cmd.CommandText = Sql4;
                cmd.CommandType = CommandType.Text;
                //OracleDataReader dr = cmd.ExecuteReader();       
                adapter.SelectCommand.ExecuteNonQuery();
                objConexion.Close();
                adapter.Fill(ds, "Table");
                GridOrden.DataSource = ds.Tables["Table"];
                GridOrden.DataBind();
                objConexion.Close();
            }
            if (EstadoImpresa == 2)
            {
                string Sql5 = "";
                Sql5 = Sql5 + "select O.NUMERO_ORDEN,O.FECHA_CREACION,O.ID_SERVICIO, ";
                Sql5 = Sql5 + "O.RUTA,O.LOCALIDAD,O.CLIENTE,O.DIRECCION,O.COD_INSTALADOR,EO.DESCRIPCION  ";
                Sql5 = Sql5 + "from ORDEN O ";
                Sql5 = Sql5 + "LEFT JOIN ESTATUS_ORDEN EO ON EO.COD_ESTATUS_ORDEN=O.COD_IMPROCEDENCIA ";
                Sql5 = Sql5 + "WHERE O.COD_INSTALADOR in (" + queryFiltro + ") and O.visita>1 ORDER BY O.RUTA";

                objConexion.Open();

                cmd.Connection = objConexion;
                cmd.CommandText = Sql5;
                cmd.CommandType = CommandType.Text;
                //OracleDataReader dr = cmd.ExecuteReader();       
                adapter.SelectCommand.ExecuteNonQuery();
                adapter.Fill(ds, "Table");
                GridOrden.DataSource = ds.Tables["Table"];
                GridOrden.DataBind();
                objConexion.Close();
            }

        }
        else if (numOrden == 0 && EstadoImpresa == 0)
        {
            string Sql6 = "";
            Sql6 = Sql6 + "select O.NUMERO_ORDEN,O.FECHA_CREACION,O.ID_SERVICIO, ";
            Sql6 = Sql6 + "O.RUTA,O.LOCALIDAD,O.CLIENTE,O.DIRECCION,O.COD_INSTALADOR,EO.DESCRIPCION  ";
            Sql6 = Sql6 + "from ORDEN O ";
            Sql6 = Sql6 + "LEFT JOIN ESTATUS_ORDEN EO ON EO.COD_ESTATUS_ORDEN=O.COD_IMPROCEDENCIA ";
            Sql6 = Sql6 + "WHERE O.COD_INSTALADOR in (" + queryFiltro + ") and O.ID_SINCRONIZACION in(3,4) ORDER BY O.RUTA";

            objConexion.Open();

            cmd.Connection = objConexion;
            cmd.CommandText = Sql6;
            cmd.CommandType = CommandType.Text;
            //OracleDataReader dr = cmd.ExecuteReader();       
            adapter.SelectCommand.ExecuteNonQuery();
            adapter.Fill(ds, "Table");
            GridOrden.DataSource = ds.Tables["Table"];
            GridOrden.DataBind();
            objConexion.Close();
        
        }
    }


    protected void Button1_Click(object sender, EventArgs e)
    {
        int contador = 0;

        foreach (GridViewRow row in GrdInstalador.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chkRow = (row.Cells[0].FindControl("check_impr1") as CheckBox);
                if (chkRow.Checked)
                {
                    contador++;

                }
            }
        }


        if (contador > 0)
        {
            cargarGrilla2(0, 0);
          
        }
        else
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, typeof(System.Web.UI.Page), "Script", "validaFiltro();", true);

    }
    protected void chkboxSelectAll_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox ChkBoxHeader = (CheckBox)GridOrden.HeaderRow.FindControl("chkboxSelectAll");
        foreach (GridViewRow row in GridOrden.Rows)
        {
            CheckBox ChkBoxRows = (CheckBox)row.FindControl("check_impr2");
            if (ChkBoxHeader.Checked == true)
            {
                ChkBoxRows.Checked = true;
            }
            else
            {
                ChkBoxRows.Checked = false;
            }
        }
    }

    protected void ddlEstadoOrd_SelectedIndexChanged(object sender, EventArgs e)
    {
        int contador = 0;

        foreach (GridViewRow row in GridOrden.Rows)
        {
            if (row.Cells.Count > 1)
            {
                contador++;
            }
        }

        if (contador > 0)
        {

        cargarGrilla2(int.Parse(ddlEstadoOrd.SelectedValue), int.Parse(ddlEstadoImp.SelectedValue));
        }
        else
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, typeof(System.Web.UI.Page), "Script", "alertaCortador();", true);

    }
    protected void ddlEstadoImp_SelectedIndexChanged(object sender, EventArgs e)
    {
        int contador = 0;

        foreach (GridViewRow row in GridOrden.Rows)
        {
            if (row.Cells.Count > 1)
            {
                contador++;
            }
        }

        if (contador > 0)
        {
            cargarGrilla2(int.Parse(ddlEstadoOrd.SelectedValue), int.Parse(ddlEstadoImp.SelectedValue));
        }
        else
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, typeof(System.Web.UI.Page), "Script", "alertaCortador();", true);

    }
}
