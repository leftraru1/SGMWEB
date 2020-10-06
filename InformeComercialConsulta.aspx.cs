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


public partial class InformeComercialConsulta : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();
    public String servicio, orden, pr, tipo_proceso,empresa,visita,atendido;
    FileInfo[] MisFicheros;
    public DataTable dt;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

            try
            {
                orden = Request.QueryString["orden"];
                servicio = Request.QueryString["servicio"];
                pr = Request.QueryString["pr"];
                visita = Request.QueryString["visita"];
                atendido = Request.QueryString["atendido"];
                //orden = "1001821475";
                //servicio = "2423201";
                //pr = "1";

                DataSet retur = obtenerDataSet();
                ReportDataSource rds = new ReportDataSource();
                rds.Name = "DataSetComercial";
                rds.Value = retur.Tables[1];
                ReportViewer1.LocalReport.EnableExternalImages = true;
                ReportViewer1.LocalReport.DataSources.Clear();
                ReportViewer1.LocalReport.DataSources.Add(rds);
                //ReportViewer1.LocalReport.ReportPath = "FichaSGM.rdlc";
                if(atendido.Equals("1")) ReportViewer1.LocalReport.ReportPath = "ReportComercial.rdlc";
                else ReportViewer1.LocalReport.ReportPath = "ReporteImprocedente.rdlc";
                ReportViewer1.LocalReport.Refresh();

                carga_mis_fotos(pr, servicio, orden, visita);

                //Boolean valFoto=verificaFoto(orden, servicio,pr);

                //if (valFoto.Equals(false))
                //{
                //    verificaFotoVisita(orden, servicio, pr, visita);
                //}
     


                //if (tipo_proceso.Equals("COMERCIAL"))
                //{
                //    tipo_proceso = "IC";
                //}
                //else
                //{
                //    tipo_proceso = "PF";
                //}
                ReportViewer1.LocalReport.DisplayName = "OrdenSustitucion_" + orden + "_" + servicio + "_" + visita;
            }
            catch (Exception ex)
            {
                String error = ex.ToString();
            }

        }
    }

    public DataSet obtenerDataSet()
    {
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_ORDEN.CARGA_REPORTE_COMERCIAL", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_noOrden", OracleType.Number, ParameterDirection.Input, orden);
        PRO.agrega_parametro_sp(da, "i_rutEmpresa", OracleType.NVarChar, ParameterDirection.Input, empresa);
        PRO.agrega_parametro_sp(da, "i_servicio", OracleType.NVarChar, ParameterDirection.Input, servicio);
        
        da.SelectCommand.CommandType = CommandType.StoredProcedure;

      
                                     

        try
        {
            CnOra.Open();
            
            //da.SelectCommand.ExecuteNonQuery();

        }
        catch (Exception ex)
        {


        }

        DataSet objDS = new DataSet();
        da.Fill(objDS, "REPORTE");
        CnOra.Close();
        CnOra.Dispose();

        return objDS;
    }

    public Boolean verificaFoto(String numero_orden, String id_servicio,String pro)
    {

        String nombre_fotografia =pro +"A"+ id_servicio;
        String ruta_proceso_cerrado = "FOTOS" + "/" + pr + "/";
        String ruta_proceso_abierto = "FOTOS";
        String[] arrArchivosOrigenFotos;
        String[] arrArchivosFotosEvaluadas;

        Boolean ex = false;


        arrArchivosOrigenFotos = Directory.GetFiles(Server.MapPath("./" + ruta_proceso_abierto + "/"), nombre_fotografia + "" + "*");
        if (Directory.Exists(Server.MapPath("./" + ruta_proceso_cerrado + "/")))
        {
            arrArchivosFotosEvaluadas = Directory.GetFiles(Server.MapPath("./" + ruta_proceso_cerrado + "/"), nombre_fotografia + "" + "*");
        }
        else
        {
            arrArchivosFotosEvaluadas = Directory.GetFiles(Server.MapPath("./" + ruta_proceso_abierto + "/"), nombre_fotografia + "" + "*");
        }

        if (arrArchivosOrigenFotos.Length > 0)
        {
            //FOTO DIRECCTORIO SIN CIERRE
            MisFicheros = new DirectoryInfo(Server.MapPath("./" + ruta_proceso_abierto + "/")).GetFiles(nombre_fotografia + "" + "*");

        }
        else if (arrArchivosFotosEvaluadas.Length > 0)
        {
            //FOTO DIRECCTORIO CON CIERRE
            MisFicheros = new DirectoryInfo(Server.MapPath("./" + ruta_proceso_cerrado + "/")).GetFiles(nombre_fotografia + "" + "*");
        }
        else if (arrArchivosFotosEvaluadas.Length == 0 && arrArchivosOrigenFotos.Length == 0)
        {
            //FOTO DIRECCTORIO CON EVALUACION
            MisFicheros = new DirectoryInfo(Server.MapPath("./" + ruta_proceso_abierto + "/")).GetFiles(nombre_fotografia + "" + "*");
        }
        Int32 indice = 0;

        if (MisFicheros.Length == 0)
        {
            string sin_fotos = new Uri(Server.MapPath("~/Imagenes/sin_foto.png")).AbsoluteUri;
            //string logos = new Uri(Server.MapPath("~/Imagenes/timbre.PNG")).AbsoluteUri;

            ReportViewer1.LocalReport.ReportPath = "ReportComercial.rdlc";
            ReportViewer1.LocalReport.EnableExternalImages = true;
            ReportParameter parameter = new ReportParameter("ImagePath", sin_fotos);
            ReportViewer1.LocalReport.SetParameters(parameter);
            //ReportParameter parametro_logo = new ReportParameter("logo", logos);
            ReportParameter parametro_sin_foto_2 = new ReportParameter("ImagePath2", sin_fotos);
            ReportParameter parametro_sin_foto_3 = new ReportParameter("ImagePath3", sin_fotos);
            ReportParameter parametro_sin_foto_4 = new ReportParameter("ImagePath4", sin_fotos);
            ReportParameter parametro_sin_foto_5 = new ReportParameter("ImagePath5", sin_fotos);
            ReportParameter parametro_sin_foto_6 = new ReportParameter("ImagePath6", sin_fotos);

            //ReportViewer1.LocalReport.SetParameters(parametro_logo);
            ReportViewer1.LocalReport.SetParameters(parametro_sin_foto_2);
            ReportViewer1.LocalReport.SetParameters(parametro_sin_foto_3);
            ReportViewer1.LocalReport.SetParameters(parametro_sin_foto_4);
            ReportViewer1.LocalReport.SetParameters(parametro_sin_foto_5);
            ReportViewer1.LocalReport.SetParameters(parametro_sin_foto_6);
            ReportViewer1.LocalReport.Refresh();
        }
        else
        {
            ex = true;
            string sin_foto = new Uri(Server.MapPath("~/Imagenes/sin_foto.png")).AbsoluteUri;
            //string logo = new Uri(Server.MapPath("~/Imagenes/timbre.PNG")).AbsoluteUri;

            //ReportParameter parametro_logo = new ReportParameter("logo", logo);
            ReportParameter parametro_sin_foto_1 = new ReportParameter("ImagePath", sin_foto);
            ReportParameter parametro_sin_foto_2 = new ReportParameter("ImagePath2", sin_foto);
            ReportParameter parametro_sin_foto_3 = new ReportParameter("ImagePath3", sin_foto);
            ReportParameter parametro_sin_foto_4 = new ReportParameter("ImagePath4", sin_foto);
            ReportParameter parametro_sin_foto_5 = new ReportParameter("ImagePath5", sin_foto);
            ReportParameter parametro_sin_foto_6 = new ReportParameter("ImagePath6", sin_foto);
            ReportParameter parametro_sin_foto_7 = new ReportParameter("ImagePath7", sin_foto);
            ReportParameter parametro_sin_foto_8 = new ReportParameter("ImagePath8", sin_foto);
            ReportParameter parametro_sin_foto_9 = new ReportParameter("ImagePath9", sin_foto);
            //ReportViewer1.LocalReport.SetParameters(parametro_logo);
            ReportViewer1.LocalReport.SetParameters(parametro_sin_foto_1);
            ReportViewer1.LocalReport.SetParameters(parametro_sin_foto_2);
            ReportViewer1.LocalReport.SetParameters(parametro_sin_foto_3);
            ReportViewer1.LocalReport.SetParameters(parametro_sin_foto_4);
            ReportViewer1.LocalReport.SetParameters(parametro_sin_foto_5);
            ReportViewer1.LocalReport.SetParameters(parametro_sin_foto_6);
            ReportViewer1.LocalReport.SetParameters(parametro_sin_foto_7);
            ReportViewer1.LocalReport.SetParameters(parametro_sin_foto_8);
            ReportViewer1.LocalReport.SetParameters(parametro_sin_foto_9);
          

            ReportViewer1.LocalReport.Refresh();
            for (int i = 0; i < MisFicheros.Length; i++)
            {
                String arch = MisFicheros[i].Name;
                String nam = MisFicheros[i].FullName.Replace(Server.MapPath(""), "~");
                String fotoA = arch;
                string[] words = fotoA.Split('A');
                string corr = words[3];
                corr = corr.Replace(".jpeg", "");
                indice = Int32.Parse(corr);
                string imagePath = "";
                if (arrArchivosOrigenFotos.Length > 0)
                {
                    //FOTO DIRECCTORIO SIN CIERRE
                    imagePath = new Uri(Server.MapPath("~/FOTOS/" + fotoA)).AbsoluteUri;

                }
                else if (arrArchivosFotosEvaluadas.Length > 0)
                {
                    //FOTO DIRECCTORIO CON CIERRE
                    imagePath = new Uri(Server.MapPath("~/FOTOS/" + pr + "/" + fotoA)).AbsoluteUri;

                }



                if (indice == 1)
                {
                    ReportViewer1.LocalReport.ReportPath = "ReportComercial.rdlc";
                    ReportViewer1.LocalReport.EnableExternalImages = true;
                    ReportParameter parameter = new ReportParameter("ImagePath", imagePath);
                    ReportViewer1.LocalReport.SetParameters(parameter);
                    ReportViewer1.LocalReport.Refresh();

                }

                if (indice == 2)
                {
                    ReportViewer1.LocalReport.ReportPath = "ReportComercial.rdlc";
                    ReportViewer1.LocalReport.EnableExternalImages = true;
                    ReportParameter parameter = new ReportParameter("ImagePath2", imagePath);
                    ReportViewer1.LocalReport.SetParameters(parameter);
                    ReportViewer1.LocalReport.Refresh();
                }
                if (indice == 3)
                {
                    ReportViewer1.LocalReport.ReportPath = "ReportComercial.rdlc";
                    ReportViewer1.LocalReport.EnableExternalImages = true;
                    ReportParameter parameter = new ReportParameter("ImagePath3", imagePath);
                    ReportViewer1.LocalReport.SetParameters(parameter);
                    ReportViewer1.LocalReport.Refresh();




                }

                if (indice == 4)
                {
                    ReportViewer1.LocalReport.ReportPath = "ReportComercial.rdlc";
                    ReportViewer1.LocalReport.EnableExternalImages = true;
                    ReportParameter parameter = new ReportParameter("ImagePath4", imagePath);
                    ReportViewer1.LocalReport.SetParameters(parameter);
                    ReportViewer1.LocalReport.Refresh();
                }

                if (indice == 5)
                {
                    ReportViewer1.LocalReport.ReportPath = "ReportComercial.rdlc";
                    ReportViewer1.LocalReport.EnableExternalImages = true;
                    ReportParameter parameter = new ReportParameter("ImagePath5", imagePath);
                    ReportViewer1.LocalReport.SetParameters(parameter);
                    ReportViewer1.LocalReport.Refresh();
                }

                if (indice == 6)
                {
                    ReportViewer1.LocalReport.ReportPath = "ReportComercial.rdlc";
                    ReportViewer1.LocalReport.EnableExternalImages = true;
                    ReportParameter parameter = new ReportParameter("ImagePath6", imagePath);
                    ReportViewer1.LocalReport.SetParameters(parameter);
                    ReportViewer1.LocalReport.Refresh();
                }

                if (indice == 7)
                {
                    ReportViewer1.LocalReport.ReportPath = "ReportComercial.rdlc";
                    ReportViewer1.LocalReport.EnableExternalImages = true;
                    ReportParameter parameter = new ReportParameter("ImagePath7", imagePath);
                    ReportViewer1.LocalReport.SetParameters(parameter);
                    ReportViewer1.LocalReport.Refresh();
                }

                if (indice == 8)
                {
                    ReportViewer1.LocalReport.ReportPath = "ReportComercial.rdlc";
                    ReportViewer1.LocalReport.EnableExternalImages = true;
                    ReportParameter parameter = new ReportParameter("ImagePath8", imagePath);
                    ReportViewer1.LocalReport.SetParameters(parameter);
                    ReportViewer1.LocalReport.Refresh();
                }

                if (indice == 9)
                {
                    ReportViewer1.LocalReport.ReportPath = "ReportComercial.rdlc";
                    ReportViewer1.LocalReport.EnableExternalImages = true;
                    ReportParameter parameter = new ReportParameter("ImagePath9", imagePath);
                    ReportViewer1.LocalReport.SetParameters(parameter);
                    ReportViewer1.LocalReport.Refresh();
                }


            }
        }



        return ex;

    }

    public Boolean verificaFotoVisita(String numero_orden, String id_servicio, String pro,String visita)
    {

        String nombre_fotografia = pro + "A" + id_servicio;
        String ruta_proceso_cerrado = "FOTOS" + "/" + pr + "/";
        String ruta_proceso_abierto = "FOTOS" + "/" + visita + "/"; ;
        String[] arrArchivosOrigenFotos;
        String[] arrArchivosFotosEvaluadas;

        Boolean ex = false;


        arrArchivosOrigenFotos = Directory.GetFiles(Server.MapPath("./" + ruta_proceso_abierto), nombre_fotografia + "" + "*");
        if (Directory.Exists(Server.MapPath("./" + ruta_proceso_cerrado + "/")))
        {
            arrArchivosFotosEvaluadas = Directory.GetFiles(Server.MapPath("./" + ruta_proceso_cerrado + "/"), nombre_fotografia + "" + "*");
        }
        else
        {
            arrArchivosFotosEvaluadas = Directory.GetFiles(Server.MapPath("./" + ruta_proceso_abierto), nombre_fotografia + "" + "*");
        }

        if (arrArchivosOrigenFotos.Length > 0)
        {
            //FOTO DIRECCTORIO SIN CIERRE
            MisFicheros = new DirectoryInfo(Server.MapPath("./" + ruta_proceso_abierto)).GetFiles(nombre_fotografia + "" + "*");

        }
        else if (arrArchivosFotosEvaluadas.Length > 0)
        {
            //FOTO DIRECCTORIO CON CIERRE
            MisFicheros = new DirectoryInfo(Server.MapPath("./" + ruta_proceso_cerrado + "/")).GetFiles(nombre_fotografia + "" + "*");
        }
        else if (arrArchivosFotosEvaluadas.Length == 0 && arrArchivosOrigenFotos.Length == 0)
        {
            //FOTO DIRECCTORIO CON EVALUACION
            MisFicheros = new DirectoryInfo(Server.MapPath("./" + ruta_proceso_abierto)).GetFiles(nombre_fotografia + "" + "*");
        }
        Int32 indice = 0;

        if (MisFicheros.Length == 0)
        {
            string sin_fotos = new Uri(Server.MapPath("~/Imagenes/sin_foto.png")).AbsoluteUri;
            //string logos = new Uri(Server.MapPath("~/Imagenes/timbre.PNG")).AbsoluteUri;

            ReportViewer1.LocalReport.ReportPath = "ReportComercial.rdlc";
            ReportViewer1.LocalReport.EnableExternalImages = true;
            ReportParameter parameter = new ReportParameter("ImagePath", sin_fotos);
            ReportViewer1.LocalReport.SetParameters(parameter);
            //ReportParameter parametro_logo = new ReportParameter("logo", logos);
            ReportParameter parametro_sin_foto_2 = new ReportParameter("ImagePath2", sin_fotos);
            ReportParameter parametro_sin_foto_3 = new ReportParameter("ImagePath3", sin_fotos);
            ReportParameter parametro_sin_foto_4 = new ReportParameter("ImagePath4", sin_fotos);
            ReportParameter parametro_sin_foto_5 = new ReportParameter("ImagePath5", sin_fotos);
            ReportParameter parametro_sin_foto_6 = new ReportParameter("ImagePath6", sin_fotos);

            //ReportViewer1.LocalReport.SetParameters(parametro_logo);
            ReportViewer1.LocalReport.SetParameters(parametro_sin_foto_2);
            ReportViewer1.LocalReport.SetParameters(parametro_sin_foto_3);
            ReportViewer1.LocalReport.SetParameters(parametro_sin_foto_4);
            ReportViewer1.LocalReport.SetParameters(parametro_sin_foto_5);
            ReportViewer1.LocalReport.SetParameters(parametro_sin_foto_6);
            ReportViewer1.LocalReport.Refresh();
        }
        else
        {
            string sin_foto = new Uri(Server.MapPath("~/Imagenes/sin_foto.png")).AbsoluteUri;
            //string logo = new Uri(Server.MapPath("~/Imagenes/timbre.PNG")).AbsoluteUri;

            //ReportParameter parametro_logo = new ReportParameter("logo", logo);
            ReportParameter parametro_sin_foto_1 = new ReportParameter("ImagePath", sin_foto);
            ReportParameter parametro_sin_foto_2 = new ReportParameter("ImagePath2", sin_foto);
            ReportParameter parametro_sin_foto_3 = new ReportParameter("ImagePath3", sin_foto);
            ReportParameter parametro_sin_foto_4 = new ReportParameter("ImagePath4", sin_foto);
            ReportParameter parametro_sin_foto_5 = new ReportParameter("ImagePath5", sin_foto);
            ReportParameter parametro_sin_foto_6 = new ReportParameter("ImagePath6", sin_foto);
            ReportParameter parametro_sin_foto_7 = new ReportParameter("ImagePath7", sin_foto);
            ReportParameter parametro_sin_foto_8 = new ReportParameter("ImagePath8", sin_foto);
            ReportParameter parametro_sin_foto_9 = new ReportParameter("ImagePath9", sin_foto);
            //ReportViewer1.LocalReport.SetParameters(parametro_logo);
            ReportViewer1.LocalReport.SetParameters(parametro_sin_foto_1);
            ReportViewer1.LocalReport.SetParameters(parametro_sin_foto_2);
            ReportViewer1.LocalReport.SetParameters(parametro_sin_foto_3);
            ReportViewer1.LocalReport.SetParameters(parametro_sin_foto_4);
            ReportViewer1.LocalReport.SetParameters(parametro_sin_foto_5);
            ReportViewer1.LocalReport.SetParameters(parametro_sin_foto_6);
            ReportViewer1.LocalReport.SetParameters(parametro_sin_foto_7);
            ReportViewer1.LocalReport.SetParameters(parametro_sin_foto_8);
            ReportViewer1.LocalReport.SetParameters(parametro_sin_foto_9);

            ReportViewer1.LocalReport.Refresh();
            for (int i = 0; i < MisFicheros.Length; i++)
            {
                String arch = MisFicheros[i].Name;
                String nam = MisFicheros[i].FullName.Replace(Server.MapPath(""), "~");
                String fotoA = arch;
                string[] words = fotoA.Split('A');
                string corr = words[4];
                corr = corr.Replace(".jpeg", "");
                indice = Int32.Parse(corr);
                string imagePath = "";
                if (arrArchivosOrigenFotos.Length > 0)
                {
                    //FOTO DIRECCTORIO SIN CIERRE
                    imagePath = new Uri(Server.MapPath("~/FOTOS/" + visita + "/" + fotoA)).AbsoluteUri;

                }
                else if (arrArchivosFotosEvaluadas.Length > 0)
                {
                    //FOTO DIRECCTORIO CON CIERRE
                    imagePath = new Uri(Server.MapPath("~/FOTOS/" + pr + "/" + fotoA)).AbsoluteUri;

                }



                if (indice == 1)
                {
                    ReportViewer1.LocalReport.ReportPath = "ReportComercial.rdlc";
                    ReportViewer1.LocalReport.EnableExternalImages = true;
                    ReportParameter parameter = new ReportParameter("ImagePath", imagePath);
                    ReportViewer1.LocalReport.SetParameters(parameter);
                    ReportViewer1.LocalReport.Refresh();

                }

                if (indice == 2)
                {
                    ReportViewer1.LocalReport.ReportPath = "ReportComercial.rdlc";
                    ReportViewer1.LocalReport.EnableExternalImages = true;
                    ReportParameter parameter = new ReportParameter("ImagePath2", imagePath);
                    ReportViewer1.LocalReport.SetParameters(parameter);
                    ReportViewer1.LocalReport.Refresh();
                }
                if (indice == 3)
                {
                    ReportViewer1.LocalReport.ReportPath = "ReportComercial.rdlc";
                    ReportViewer1.LocalReport.EnableExternalImages = true;
                    ReportParameter parameter = new ReportParameter("ImagePath3", imagePath);
                    ReportViewer1.LocalReport.SetParameters(parameter);
                    ReportViewer1.LocalReport.Refresh();




                }

                if (indice == 4)
                {
                    ReportViewer1.LocalReport.ReportPath = "ReportComercial.rdlc";
                    ReportViewer1.LocalReport.EnableExternalImages = true;
                    ReportParameter parameter = new ReportParameter("ImagePath4", imagePath);
                    ReportViewer1.LocalReport.SetParameters(parameter);
                    ReportViewer1.LocalReport.Refresh();
                }

                if (indice == 5)
                {
                    ReportViewer1.LocalReport.ReportPath = "ReportComercial.rdlc";
                    ReportViewer1.LocalReport.EnableExternalImages = true;
                    ReportParameter parameter = new ReportParameter("ImagePath5", imagePath);
                    ReportViewer1.LocalReport.SetParameters(parameter);
                    ReportViewer1.LocalReport.Refresh();
                }

                if (indice == 6)
                {
                    ReportViewer1.LocalReport.ReportPath = "ReportComercial.rdlc";
                    ReportViewer1.LocalReport.EnableExternalImages = true;
                    ReportParameter parameter = new ReportParameter("ImagePath6", imagePath);
                    ReportViewer1.LocalReport.SetParameters(parameter);
                    ReportViewer1.LocalReport.Refresh();
                }

                if (indice == 7)
                {
                    ReportViewer1.LocalReport.ReportPath = "ReportComercial.rdlc";
                    ReportViewer1.LocalReport.EnableExternalImages = true;
                    ReportParameter parameter = new ReportParameter("ImagePath7", imagePath);
                    ReportViewer1.LocalReport.SetParameters(parameter);
                    ReportViewer1.LocalReport.Refresh();
                }

                if (indice == 8)
                {
                    ReportViewer1.LocalReport.ReportPath = "ReportComercial.rdlc";
                    ReportViewer1.LocalReport.EnableExternalImages = true;
                    ReportParameter parameter = new ReportParameter("ImagePath8", imagePath);
                    ReportViewer1.LocalReport.SetParameters(parameter);
                    ReportViewer1.LocalReport.Refresh();
                }

                if (indice == 9)
                {
                    ReportViewer1.LocalReport.ReportPath = "ReportComercial.rdlc";
                    ReportViewer1.LocalReport.EnableExternalImages = true;
                    ReportParameter parameter = new ReportParameter("ImagePath9", imagePath);
                    ReportViewer1.LocalReport.SetParameters(parameter);
                    ReportViewer1.LocalReport.Refresh();
                }


            }
        }



        return ex;

    }

    public void carga_mis_fotos(String id_proceso, String id_servicio, String numero_orden, String visita)
    {
        Boolean marca = false;
        String sin_fotos = new Uri(Server.MapPath("~/Imagenes/sin_foto.png")).AbsoluteUri;
        String ruta_fotos_procesada = "FOTOS/" + visita + "/";
        String ruta_fotos_sin_proceso = "FOTOS/";
        String[] mis_fotos_procesadas;

        if (!Directory.Exists(Server.MapPath("./" + ruta_fotos_procesada + "/"))) System.IO.Directory.CreateDirectory(Server.MapPath("./" + ruta_fotos_procesada + "/"));

        //Obtenemos los nombres de las fotos que tenga el servicio en su carpeta procesada.
        mis_fotos_procesadas = Directory.GetFiles(Server.MapPath("./" + ruta_fotos_procesada), id_proceso + "A" + id_servicio + "*");

        if (mis_fotos_procesadas.Length > 0) MisFicheros = new DirectoryInfo(Server.MapPath("./" + ruta_fotos_procesada + "/")).GetFiles(id_proceso + "A" + id_servicio + "*");
        else MisFicheros = new DirectoryInfo(Server.MapPath("./" + ruta_fotos_sin_proceso + "/")).GetFiles(id_proceso + "A" + id_servicio + "*");

        inicializa_campos();

        if (MisFicheros.Length > 0)
        {

            Int32 indice = 0;

            for (int i = 0; i < MisFicheros.Length; i++)
            {
                String nombre_foto = MisFicheros[i].Name;
                String ruta_completa = new Uri(Server.MapPath(MisFicheros[i].FullName.Replace(Server.MapPath(""), "~"))).AbsoluteUri;
                String[] foto_split = nombre_foto.Split('A'); //0: proceso, 1: servicio, 2: cod instalador, 3: visita, 4: corr.jpeg                
                indice = Int32.Parse(foto_split[4].Replace(".jpeg", ""));

                if (nombre_foto.Contains(id_proceso + "A") && nombre_foto.Contains("A" + servicio + "A")
                    && nombre_foto.Contains("A" + visita + "A"))
                {
                    if (indice == 10) { continue; /*marca = true; indice = 6;*/ } //PAPELETA POR FIRMA
                    
                    //if(indice == 6 && !marca) continue; //SI YA TENEMOS UNA FOTO 10 DE FIRMA DEJAMOS LA FIRMA Y NO LA PAPELETA.

                    ReportViewer1.LocalReport.EnableExternalImages = true;
                    ReportParameter param = new ReportParameter("ImagePath" + indice, ruta_completa);
                    ReportViewer1.LocalReport.SetParameters(param);
                }

            }

            ReportViewer1.LocalReport.Refresh();
        }
    }

    public void inicializa_campos()
    {
        string sin_fotos = new Uri(Server.MapPath("~/Imagenes/sin_foto.png")).AbsoluteUri;
       
        if(atendido.Equals("1")) {
            for (int i = 1; i <= 6; i++)
            {
                ReportViewer1.LocalReport.EnableExternalImages = true;
                ReportParameter param = new ReportParameter("ImagePath" + i, sin_fotos);
                ReportViewer1.LocalReport.SetParameters(param);
            }

        } else {
            for (int i = 7; i <= 9; i++)
            {
                ReportViewer1.LocalReport.EnableExternalImages = true;
                ReportParameter param = new ReportParameter("ImagePath" + i, sin_fotos);
                ReportViewer1.LocalReport.SetParameters(param);
            }
        }
        ReportViewer1.LocalReport.Refresh();

    }

}