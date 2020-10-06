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
using Microsoft.Reporting.WebForms;

public partial class InformeGestionOperativa : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();

    protected void Page_Load(object sender, EventArgs e)
    {

        grillaOp();

    }


    public void grillaOp()
    {
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_ORDEN.INFORME", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
               
        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_empresa", OracleType.NVarChar, ParameterDirection.Input, PRO.recSession(rutaXml, "RUT_EMPRESA"));
       
        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        DataTable dtOrdenes = new DataTable();

        try
        {
            CnOra.Open();

            da.Fill(dtOrdenes);
            CnOra.Close();
            CnOra.Dispose();
        }
        catch (Exception ex)
        {
           
        }

        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("NOMBRE", typeof(String)));
        dt.Columns.Add(new DataColumn("PROCEDENTE", typeof(Int32)));
        dt.Columns.Add(new DataColumn("IMPROCEDENTE", typeof(Int32)));
        dt.Columns.Add(new DataColumn("TOTAL", typeof(Int32)));
        dt.Columns.Add(new DataColumn("PORCENTAJE", typeof(String)));
        DataRow dr;

        int total = 0;

        foreach (DataRow drOrdenItem in dtOrdenes.Rows)
        {

            dr = dt.NewRow();
            dr["NOMBRE"] = drOrdenItem["NOMBRE"].ToString();
            dr["PROCEDENTE"] = drOrdenItem["PROCEDENTE"].ToString();
            dr["IMPROCEDENTE"] = drOrdenItem["IMPROCEDENTE"].ToString();
            dr["TOTAL"] = drOrdenItem["TOTAL"].ToString();

            dr["PORCENTAJE"] = (int.Parse(dr["IMPROCEDENTE"].ToString()) * 100) / int.Parse(dr["TOTAL"].ToString())+"%";
            

            dt.Rows.Add(dr);

            total = total + 1;

        }

        DataView MydataView;
        MydataView = new DataView(dt);
        gvOperativo.DataSource = MydataView;
        gvOperativo.DataBind();

       // lbTotal.Text = total + " registro(s) encontrado(s)";


    }


    protected void gridOrden_RowCommand(object sender, GridViewCommandEventArgs e)
    {

    }
    protected void gridOrden_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

    }
}