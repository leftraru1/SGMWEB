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

public partial class InformeDetalleGuia : System.Web.UI.Page
{
     String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
     Procedimientos PRO = new Procedimientos();
    public int id_guia;
    
    public DataTable dt;


    protected void Page_Load(object sender, EventArgs e)
    {
         if (!Page.IsPostBack)
        {
            try
            {
                id_guia = int.Parse(Request.QueryString["id_guia"]);

           


                DataSet retur_guia = obtenerDataSetGuia();
                ReportViewer1.LocalReport.ReportPath = "ReporteDetalleGuia.rdlc";
                ReportDataSource rds_guia = new ReportDataSource("DataSetGuia", retur_guia.Tables["informe_guia"]);
                ReportViewer1.LocalReport.DataSources.Clear();
                ReportViewer1.LocalReport.DataSources.Add(rds_guia);
                ReportViewer1.LocalReport.Refresh();


                DataSet retur_detalle = obtenerDataSetDetalle();
                ReportDataSource rds_detalle = new ReportDataSource("DataSetDetalle", retur_detalle.Tables["informe_detalle"]);

                ReportViewer1.LocalReport.DataSources.Add(rds_detalle);



                ReportViewer1.LocalReport.Refresh();
                //ReportViewer1.LocalReport.ReportPath = "ReporteDetalleGuia.rdlc";








                //DataSet retur = obtenerDataSetGuia();
                //ReportDataSource rds = new ReportDataSource();
                //rds.Name = "DatasetGuia";
                //rds.Value = retur.Tables["informe_guia"];
                // //ReportViewer1.LocalReport.EnableExternalImages = true;

                // DataSet returdetalle = obtenerDataSetDetalle();
                // ReportDataSource rds_otros = new ReportDataSource("DatasetGuia", returdetalle.Tables["informe_detalleguia"]);
                
                 

                //ReportViewer1.LocalReport.DataSources.Clear();
                //ReportViewer1.LocalReport.DataSources.Add(rds_otros);
                //ReportViewer1.LocalReport.DataSources.Add(rds);          
                //ReportViewer1.LocalReport.ReportPath = "ReporteDetalleGuia.rdlc";


            }
            catch(Exception ex)
            {
                String exrr = ex.ToString();

            }
         
        }
    }


    public DataSet obtenerDataSetDetalle()
    {
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_VISOR_STOCK.CARGA_DETALLEGUIA", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_idguia", OracleType.Int32, ParameterDirection.Input, id_guia.ToString());
       

        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        try
        {
            CnOra.Open();
        }
        catch (Exception ex)
        {

        }

        DataSet objDS = new DataSet();
        da.Fill(objDS, "informe_detalle");
        CnOra.Close();
        CnOra.Dispose();

        return objDS;
    }

     public DataSet obtenerDataSetGuia()
    {
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_VISOR_STOCK.CARGA_GUIA", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_idguia", OracleType.Int32, ParameterDirection.Input, id_guia.ToString());
       ;

        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        try
        {
            CnOra.Open();
        }
        catch (Exception ex)
        {

        }

        DataSet objDS = new DataSet();
        da.Fill(objDS, "informe_guia");
        CnOra.Close();
        CnOra.Dispose();

        return objDS;
    }
    
}