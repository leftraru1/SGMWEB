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

public partial class popInstalador : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();

    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {

            try
            {
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                PRO.recSession(rutaXml, "RUT_EMPRESA");

                cargar();

            }
            catch (Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }

           
        }

        
        

    }

    public void cargar()
    {


        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_INSTALADOR.CARGA_INSTALADOR_X_EMPRESA_NEW", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
       

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_rut_empresa", OracleType.Int32, ParameterDirection.Input, PRO.recSession(rutaXml, "RUT_EMPRESA"));
        PRO.agrega_parametro_sp(da, "i_id_usuario", OracleType.Int32, ParameterDirection.Input, PRO.recSession(rutaXml, "ID_USUARIO"));
        PRO.agrega_parametro_sp(da, "i_id_contratista", OracleType.Int32, ParameterDirection.Input, PRO.recSession(rutaXml, "ID_CONTRATISTA"));

        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        DataTable dtOrdenes = new DataTable();

        try
        {
            lbError.Text = "";
            CnOra.Open();

            da.Fill(dtOrdenes);
            CnOra.Close();
            CnOra.Dispose();
        }
        catch (Exception ex)
        {
            lbError.ForeColor = System.Drawing.Color.Red;
            lbError.Text = ex.Message;
            
        }

        DataTable dt = new DataTable();
        
        dt.Columns.Add(new DataColumn("ID_INSTALADOR", typeof(int)));
        dt.Columns.Add(new DataColumn("COD_INSTALADOR", typeof(int)));
        dt.Columns.Add(new DataColumn("NOMBRE", typeof(String)));
        dt.Columns.Add(new DataColumn("APELLIDO", typeof(String)));
        dt.Columns.Add(new DataColumn("BODEGA", typeof(String)));
        dt.Columns.Add(new DataColumn("REGION", typeof(String)));
        
        DataRow dr;

        int total = 0;

        foreach (DataRow drOrdenItem in dtOrdenes.Rows)
        {

            dr = dt.NewRow();
            dr["ID_INSTALADOR"] = drOrdenItem["ID_INSTALADOR"].ToString();
            dr["COD_INSTALADOR"] = drOrdenItem["COD_INSTALADOR"].ToString();
            dr["NOMBRE"] = drOrdenItem["NOMBRE"].ToString();
            dr["BODEGA"] = drOrdenItem["BODEGA"].ToString();
            dr["REGION"] = drOrdenItem["REGION"].ToString();
            
            dt.Rows.Add(dr);

            total = total + 1;

        }

        DataView MydataView;
        MydataView = new DataView(dt);
        gvInstalador.DataSource = MydataView;
        gvInstalador.DataBind();

        lbTotal.Text = total + " registro(s) encontrado(s)";
       
    }
    protected void gvInstalador_SelectedIndexChanged(object sender, EventArgs e)
    {
         String obj = Request.QueryString["textbox"];

        if(obj!=null)
        {
            String strScript = "<script>window.opener.document.getElementById ('" + obj + "').value = '";

            strScript += gvInstalador.SelectedRow.Cells[1].Text;
            
            strScript += "';self.close()";
            strScript += "</" + "script>";

            Response.Write(strScript);
           
        }
               
        
    }
}