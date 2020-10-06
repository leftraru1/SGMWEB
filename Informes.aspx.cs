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


public partial class Informes : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();
    public String id_manifiesto,id_bodega,tipo_manifiesto,cod_instalador;
    FileInfo[] MisFicheros;
    public DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

            try
            {
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";

            }
            catch (Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }

            try
            {
                id_manifiesto = Request.QueryString["manifiesto"];
                id_bodega = Request.QueryString["bodega"];
                tipo_manifiesto = Request.QueryString["tipo_manifiesto"];
                cod_instalador = Request.QueryString["instalador"];
                
                //INFO GENERAL MANIFIESTO.
                DataSet retur = obtenerDataSet("RESUMEN");
                ReportDataSource rds = new ReportDataSource();
                rds.Name = "Manifiesto";
                rds.Value = retur.Tables[1];
                ReportViewer1.LocalReport.EnableExternalImages = true;
                ReportViewer1.LocalReport.DataSources.Clear();
                ReportViewer1.LocalReport.DataSources.Add(rds);

                //AGREGAMOS DETALLE.
                DataSet detalle = obtenerDataSet("DETALLE");
                ReportDataSource rds_detalle = new ReportDataSource("DetalleManifiesto", detalle.Tables[1]);
                ReportViewer1.LocalReport.DataSources.Add(rds_detalle);

                ReportViewer1.LocalReport.ReportPath = "InformeManifiesto.rdlc";
                ReportViewer1.LocalReport.Refresh();
                                
                ReportViewer1.LocalReport.DisplayName = "MANIFIESTO_" + tipo_manifiesto + "_" + id_manifiesto;

                carga_mis_fotos(tipo_manifiesto, cod_instalador, id_manifiesto);
            }
            catch (Exception ex)
            {
                String error = ex.ToString();
            }

        }
    }

    public DataSet obtenerDataSet(String accion)
    {
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_VISOR_MANIFIESTOS.CARGA_INFO_MANIFIESTO", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_id_manifiesto", OracleType.Number, ParameterDirection.Input, id_manifiesto);
        PRO.agrega_parametro_sp(da, "i_id_bodega", OracleType.Number, ParameterDirection.Input, id_bodega);
        PRO.agrega_parametro_sp(da, "i_accion", OracleType.NVarChar, ParameterDirection.Input, accion);

        da.SelectCommand.CommandType = CommandType.StoredProcedure;          

        try{
            CnOra.Open();
            //da.SelectCommand.ExecuteNonQuery();
        }
        catch (Exception ex)
        {}

        DataSet objDS = new DataSet();
        da.Fill(objDS, "REPORTE");
        CnOra.Close();
        CnOra.Dispose();

        return objDS;
    }

    public void carga_mis_fotos(String tipo,String instalador,String manifiesto)
    {
        try
        {
            String ruta_fotos_procesada = "FOTOS/MANIFIESTO/";
            String ruta_fotos_sin_proceso = "FOTOS/";

            if (!Directory.Exists(Server.MapPath("./" + ruta_fotos_procesada + "/"))) System.IO.Directory.CreateDirectory(Server.MapPath("./" + ruta_fotos_procesada + "/"));

            String[] allfiles = Directory.GetFiles(Server.MapPath("./" + ruta_fotos_sin_proceso + "/"), "*" + tipo + "_" + instalador + "*", SearchOption.AllDirectories);

            inicializa_campos();

            foreach (var mi_archivo in allfiles)
            {
                FileInfo archivo = new FileInfo(mi_archivo);

                String nombre_foto = archivo.Name;

                if (nombre_foto.Contains("_" + manifiesto + "."))
                {
                    //String ruta_completa = archivo.FullName;
                    String ruta_completa = new Uri(Server.MapPath(archivo.FullName.Replace(Server.MapPath(""), "~"))).AbsoluteUri;
                    ReportViewer1.LocalReport.EnableExternalImages = true;
                    ReportParameter param = new ReportParameter("ImagePath1", ruta_completa);
                    ReportViewer1.LocalReport.SetParameters(param);

                }

            }

        }
        catch (Exception ex)
        {
            String msg = ex.Message;
        }

        ReportViewer1.LocalReport.Refresh();
    }

    public void inicializa_campos()
    {
        string sin_fotos = new Uri(Server.MapPath("~/Imagenes/sin_foto.png")).AbsoluteUri;

        ReportViewer1.LocalReport.EnableExternalImages = true;
        ReportParameter param = new ReportParameter("ImagePath1", sin_fotos);
        ReportViewer1.LocalReport.SetParameters(param);          
       
        ReportViewer1.LocalReport.Refresh();

    }

   
}