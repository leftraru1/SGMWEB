using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OracleClient;
using System.Xml;
using System.Net;
using System.Configuration;
using System.Net.Mail;
using System.IO;
using Microsoft.Reporting.WebForms;
using System.Drawing.Printing;
using System.Drawing;
using System.Drawing.Imaging;
using System.Text;
using System.Reflection;


public partial class InformeSustitucionMedidor : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();
    public DataTable dt;
   
    

    protected void Page_Load(object sender, EventArgs e)
    {


  
        if (!Page.IsPostBack)
        {

            try
            {
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                PRO.recSession(rutaXml, "RUT_EMPRESA");

            }
            catch (Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }

            try
            {
                DataTable ds = Session["griddata"] as DataTable;

                GridView1.DataSource = ds;
                GridView1.DataBind();

                //obtenerDataSet();
                //PrintDocument printDocument1 = new PrintDocument();
                //DataSet retur = obtenerDataSet();
                //ReportDataSource rds = new ReportDataSource();
                //rds.Name = "DataSetSustitucion";
                //rds.Value = retur.Tables["Table"];
                //ReportViewer1.Reset();
                //ReportViewer1.LocalReport.ReportPath = "ReporteSustitucionMed.rdlc";
                //ReportViewer1.LocalReport.DataSources.Clear();
                //ReportViewer1.LocalReport.DataSources.Add(rds);
                //ReportViewer1.LocalReport.Refresh();
                //ReportViewer1.LocalReport.DisplayName = "OrdenSustitucionMedidor";
                //printDocument1.DocumentName = "ReporteSustitucionMed.rdlc";
                //printDocument1.Print();
                DataSet retur = obtenerDataSet();
                 // Create Report DataSource
                ReportDataSource rds = new ReportDataSource("DataSetSustitucion", retur.Tables["Table"]);
                // Variables
                Warning[] warnings;
                string[] streamIds;
                string mimeType = string.Empty;
                string encoding = string.Empty;
                string extension = string.Empty;
                 // Setup the report viewer object and get the array of bytes
                ReportViewer viewer = new ReportViewer();
                viewer.ProcessingMode = ProcessingMode.Local;
                viewer.LocalReport.ReportPath = "ReporteSustitucionMed.rdlc";
                viewer.LocalReport.DataSources.Add(rds); // Add datasource here
                byte[] bytes = viewer.LocalReport.Render("PDF", null, out mimeType, out encoding, out extension, out streamIds, out warnings);
                // Now that you have all the bytes representing the PDF report, buffer it and send it to the client.
                Response.Buffer = true;
                Response.Clear();
                Response.ContentType = mimeType;
                Response.AddHeader("content-disposition", "attachment; filename=" + "OrdenSustitucionMedidor" + "." + extension);
                Response.BinaryWrite(bytes); // create the file
                Response.Flush(); // send it to the client to download
                     

            }
            catch (Exception ex)
            {
                String error = ex.ToString();
            }

        }
    }


    /////////////////////////////






























    /// <summary>
    /// ////////////////////////////
    /// </summary>
    /// <returns></returns>

    public DataSet obtenerDataSet()
    {

        DataTable dt = new DataTable();

        string queryFiltro = "";     
        Boolean marca;

        marca = false;

        foreach (GridViewRow row in GridView1.Rows)
        {
            if (GridView1.Rows.Count > 1)
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
            else if (GridView1.Rows.Count == 1)
            {
                queryFiltro = queryFiltro + row.Cells[0].Text;

            }
      
        }

        DataSet ds = new DataSet();
        string Sql = "";
        Sql = Sql + "SELECT DISTINCT O.NUMERO_ORDEN, ";
        Sql = Sql + "O.FECHA_CREACION,CC.DESCRIPCION AS CAUSA,  ";
        Sql = Sql + "O.ID_SERVICIO,O.RUTA, ";
        Sql = Sql + "O.LOCALIDAD,EMR.DESCRIPCION AS ESTADO, ";
        Sql = Sql + "O.CLIENTE,O.DIRECCION, ";
        Sql = Sql + "O.FECHA_UL_LECT_EF, ";
        Sql = Sql + "O.UL_LECTURA_EF,O.ID_PROCESO, ";
        Sql = Sql + "O.OBSERVACION_IN,O.UL_LECTURA_EF,O.TIPO_MARCA_DI,O.SERIE_MEDIDOR,O.DIAMETRO_MEDIDOR ";
        Sql = Sql + "FROM ORDEN O  ";
        Sql = Sql + "LEFT JOIN CAUSA_CAMBIO CC ON CC.COD_CAUSA=O.CAUSA  ";
        Sql = Sql + "LEFT JOIN ESTADO_MEDIDOR_RETIRADO EMR ON EMR.COD_ESTATUS_MR=O.COD_ESTADO_MR  ";
        Sql = Sql + "WHERE O.NUMERO_ORDEN in (" + queryFiltro + ")";
        Sql = Sql + "ORDER BY O.NUMERO_ORDEN DESC";

        DataTable dss = new DataTable();
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        objConexion.Open();
        OracleCommand cmd = new OracleCommand();
        cmd.Connection = objConexion;
        cmd.CommandText = Sql;
        cmd.CommandType = CommandType.Text;
        //OracleDataReader dr = cmd.ExecuteReader();
        OracleDataAdapter adapter = new OracleDataAdapter(cmd);
        adapter.SelectCommand.ExecuteNonQuery();
        adapter.Fill(ds, "Table");

    



      return ds;
        
    }



    ///////////////////////////////

  
    protected void Button1_Click(object sender, EventArgs e)
    {
        
    }
}