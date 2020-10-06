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
    public string numero_orden;
    IPAddress oAddr;
   
    

    protected void Page_Load(object sender, EventArgs e)
    {


  
        if (!Page.IsPostBack)
        {

            try
            {
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                PRO.recSession(rutaXml, "RUT_EMPRESA");



                DataTable ds = Session["griddata"] as DataTable;
                //numero_orden = Request.QueryString["gridata"];


                GridView1.DataSource = ds;
                GridView1.DataBind();

                DataSet retur = obtenerDataSet();
                ReportDataSource rds = new ReportDataSource();
                rds.Name = "DataSetSustitucion";
                rds.Value = retur.Tables["obtener_ordenes"];
                ReportViewer1.LocalReport.EnableExternalImages = true;
                ReportViewer1.LocalReport.DataSources.Clear();
                ReportViewer1.LocalReport.DataSources.Add(rds);

                ReportViewer1.LocalReport.ReportPath = "ReporteSustitucionMed.rdlc";

                //ReportViewer1.LocalReport.Refresh();
                //ReportViewer1.LocalReport.DisplayName = numero_orden.ToString(); // ?


                //ReportDataSource rds = new ReportDataSource("DataSetSustitucion", retur.Tables["Table"]);

                //rds.Name = "DataSetSustitucion";
                //rds.Value = retur.Tables["DataSetSustitucion"];
                //ReportViewer1.LocalReport.EnableExternalImages = true;
                //ReportViewer1.LocalReport.DataSources.Clear();
                //ReportViewer viewer = new ReportViewer();
                //viewer.LocalReport.ReportPath = "ReporteSustitucionMed.rdlc";
                //viewer.LocalReport.DataSources.Add(rds);

               
            }
            catch (Exception ex)
            {
                string error = e.ToString();
            }

          
        }
    }

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


        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_SUSTITUCION_MEDIDOR.OBTENER_ORDENES", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_numero_orden", OracleType.NVarChar, ParameterDirection.Input, queryFiltro);
       
        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        DataSet objDS = new DataSet();

        try
        {
            CnOra.Open();
            da.Fill(objDS, "obtener_ordenes");
            CnOra.Close();
            CnOra.Dispose();
        }
        catch (Exception ex)
        {

        }



        return objDS;
    }


    

    //public DataSet obtenerDataSet2()
    //{

    //    DataTable dt = new DataTable();

    //    string queryFiltro = "";     
    //    Boolean marca;

    //    marca = false;

    //    foreach (GridViewRow row in GridView1.Rows)
    //    {
    //        if (GridView1.Rows.Count > 1)
    //        {
    //            if (marca == false)
    //            {
    //                queryFiltro = queryFiltro + "" + row.Cells[0].Text;
    //                marca = true;
    //            }
    //            else
    //            {
    //                queryFiltro = queryFiltro + "," + row.Cells[0].Text;
    //            }
    //        }
    //        else if (GridView1.Rows.Count == 1)
    //        {
    //            queryFiltro = queryFiltro + row.Cells[0].Text;

    //        }
      
    //    }

    //    DataSet ds = new DataSet();
    //    string Sql = "";
    //    Sql = Sql + "SELECT DISTINCT O.NUMERO_ORDEN, ";
    //    Sql = Sql + "O.FECHA_CREACION,CC.DESCRIPCION AS CAUSA,  ";
    //    Sql = Sql + "O.ID_SERVICIO,O.RUTA, ";
    //    Sql = Sql + "O.LOCALIDAD,EMR.DESCRIPCION AS ESTADO, ";
    //    Sql = Sql + "O.CLIENTE,O.DIRECCION, ";
    //    Sql = Sql + "O.FECHA_UL_LECT_EF, ";
    //    Sql = Sql + "O.UL_LECTURA_EF,O.ID_PROCESO, ";
    //    Sql = Sql + "O.OBSERVACION_IN,O.UL_LECTURA_EF,O.TIPO_MARCA_DI,O.SERIE_MEDIDOR,O.DIAMETRO_MEDIDOR ";
    //    Sql = Sql + "FROM ORDEN O  ";
    //    Sql = Sql + "LEFT JOIN CAUSA_CAMBIO CC ON CC.COD_CAUSA=O.CAUSA  ";
    //    Sql = Sql + "LEFT JOIN ESTADO_MEDIDOR_RETIRADO EMR ON EMR.COD_ESTATUS_MR=O.COD_ESTADO_MR  ";
    //    Sql = Sql + "WHERE O.NUMERO_ORDEN in (" + queryFiltro + ")";
    //    Sql = Sql + "ORDER BY O.NUMERO_ORDEN DESC";

    //    DataTable dss = new DataTable();
    //    OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
    //    objConexion.Open();
    //    OracleCommand cmd = new OracleCommand();
    //    cmd.Connection = objConexion;
    //    cmd.CommandText = Sql;
    //    cmd.CommandType = CommandType.Text;
    //    //OracleDataReader dr = cmd.ExecuteReader();
    //    OracleDataAdapter adapter = new OracleDataAdapter(cmd);
    //    adapter.SelectCommand.ExecuteNonQuery();
    //    adapter.Fill(ds, "Table");

    



    //  return ds;
        
    //}



    ///////////////////////////////

  
    protected void Button1_Click(object sender, EventArgs e)
    {
        
    }
}