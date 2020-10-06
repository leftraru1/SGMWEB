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
using System.Security.Permissions;

public partial class popVisorFotos : System.Web.UI.Page
{
    public String id, grupo, servicio,operador,visita;
    Procedimientos PRO = new Procedimientos();

    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
            PRO.recSession(rutaXml, "RUT_EMPRESA");

            id = Request.QueryString["id"];
            grupo = Request.QueryString["grupo"];
            servicio = Request.QueryString["servicio"];
            operador = Request.QueryString["operador"];
            visita = Request.QueryString["visita"];
            incializaCampos();


            Boolean valFoto=cargarFoto();

            if (valFoto.Equals(false))
            {
                cargarFotoVisita();
            }
            
            lbServ.Text = servicio;
            lbGrupo.Text = grupo;
            lbVisita.Text = visita;

          

        }
        catch (Exception ex)
        {
            Response.Redirect("errorSesion.aspx");
        }

        
    }

    public void incializaCampos()
    {
        String sin_fotos = new Uri(Server.MapPath("~/Imagenes/sin_foto.png")).AbsoluteUri;
        btFoto1.ImageUrl = sin_fotos;
        btFoto2.ImageUrl = sin_fotos;
        btFoto3.ImageUrl = sin_fotos;
        btFoto4.ImageUrl = sin_fotos;
        btFoto5.ImageUrl = sin_fotos;
        btFoto6.ImageUrl = sin_fotos;
        btFoto7.ImageUrl = sin_fotos;
        btFoto8.ImageUrl = sin_fotos;
        btFoto9.ImageUrl = sin_fotos;

        //btFoto1.Visible = false;
        //btFoto2.Visible = false;
        //btFoto3.Visible = false;
        //btFoto4.Visible = false;
        //btFoto5.Visible = false;
        //btFoto6.Visible = false;
        //btFoto7.Visible = false;
        //btFoto8.Visible = false;
        //btFoto9.Visible = false;

        lbImagen1.Text = "FOTO SERIE MED. RETIRADO";
        lbImagen2.Text = "FOTO LECTURA MED. RETIRADO";
        lbImagen3.Text = "FOTO SERIE MED. NUEVO";
        lbImagen4.Text = "FOTO LECTURA MED. NUEVO";
        lbImagen5.Text = "PANORAMICA MED. INSTALADO";
        lbImagen6.Text = "PAPELETA";
        lbImagen7.Text = "PANORAMICA VIVIENDA";
        lbImagen8.Text = "PANORAMICA INSTALACION";
        lbImagen9.Text = "PROBLEMA TECNICO";
    }

    public Boolean cargarFoto()
    {
        FileInfo[] MisFicheros;
        Boolean ex = false;
        String nombre_fotografia = id + "A" + servicio + "A" + operador + "A";

        String[] arrArchivosOrigenFotos;
        String[] arrArchivosFotosEvaluadas;

        arrArchivosOrigenFotos = Directory.GetFiles(Server.MapPath("./FOTOS/"), nombre_fotografia + "" + "*");

        MisFicheros = new DirectoryInfo(Server.MapPath("./FOTOS/")).GetFiles(nombre_fotografia + "" + "*");


        arrArchivosOrigenFotos = Directory.GetFiles(Server.MapPath("./FOTOS/"), nombre_fotografia + "" + "*");
        if (Directory.Exists(Server.MapPath("./FOTOS/")))
        {
            arrArchivosFotosEvaluadas = Directory.GetFiles(Server.MapPath("./FOTOS/"), nombre_fotografia + "" + "*");
        }
        else
        {
            arrArchivosFotosEvaluadas = Directory.GetFiles(Server.MapPath("./FOTOS/"), nombre_fotografia + "" + "*");
        }
        if (arrArchivosOrigenFotos.Length > 0)
        {
            //FOTO DIRECCTORIO SIN CIERRE
            MisFicheros = new DirectoryInfo(Server.MapPath("./FOTOS/")).GetFiles(nombre_fotografia + "" + "*");

        }
        else if (arrArchivosFotosEvaluadas.Length > 0)
        {
            //FOTO DIRECCTORIO CON CIERRE
            MisFicheros = new DirectoryInfo(Server.MapPath("./FOTOS/")).GetFiles(nombre_fotografia + "" + "*");
        }
        else if (arrArchivosFotosEvaluadas.Length == 0 && arrArchivosOrigenFotos.Length == 0)
        {
            //FOTO DIRECCTORIO CON EVALUACION
            MisFicheros = new DirectoryInfo(Server.MapPath("./FOTOS/")).GetFiles(nombre_fotografia + "" + "*");
        }
        Int32 indice = 0;


        if (MisFicheros.Length == 0)
        {
            incializaCampos();

            
        }
        else
        {

            ex = true;

           incializaCampos();
                      

            for (int i = 0; i < MisFicheros.Length; i++)
            {
                String arch = MisFicheros[i].Name;
                String nam = MisFicheros[i].FullName.Replace(Server.MapPath(""), "~");
                String fotoA = arch;
                string[] words = fotoA.Split('A');
                string corr = words[3];
                corr = corr.Replace(".jpeg", "");
                indice = Int32.Parse(corr);
                //string imagePath = "";

                //if (arrArchivosOrigenFotos.Length > 0)
                //{
                //    //FOTO DIRECCTORIO SIN CIERRE
                //    imagePath = new Uri(Server.MapPath("~/FOTOS/" + fotoA)).AbsoluteUri;
                //}
                //else if (arrArchivosFotosEvaluadas.Length > 0)
                //{
                //    //FOTO DIRECCTORIO CON CIERRE
                //    imagePath = new Uri(Server.MapPath("~/FOTOS/" + pr + "/" + fotoA)).AbsoluteUri;
                //}

                if (indice == 1)
                {
                    btFoto1.Visible = true;
                    btFoto1.ImageUrl = ResolveUrl(nam);
                    lbImagen1.Visible = true;
                    lbImagen1.Text = "FOTO SERIE MED. RETIRADO";

                }

                if (indice == 2)
                {
                    btFoto2.Visible = true;
                    btFoto2.ImageUrl = ResolveUrl(nam);
                    lbImagen2.Visible = true;
                    lbImagen2.Text = "FOTO LECTURA MED. RETIRADO";

                }
                if (indice == 3)
                {
                    btFoto3.Visible = true;
                    btFoto3.ImageUrl = ResolveUrl(nam);
                    lbImagen3.Visible = true;
                    lbImagen3.Text = "FOTO SERIE MED. NUEVO";

                }

                if (indice == 4)
                {
                    btFoto4.Visible = true;
                    btFoto4.ImageUrl = ResolveUrl(nam);
                    lbImagen4.Visible = true;
                    lbImagen4.Text = "FOTO LECTURA MED. NUEVO";

                }

                if (indice == 5)
                {
                    btFoto5.Visible = true;
                    btFoto5.ImageUrl = ResolveUrl(nam);
                    lbImagen5.Visible = true;
                    lbImagen5.Text = "PANORAMICA MED. INSTALADO";

                }

                if (indice == 6)
                {
                    btFoto6.Visible = true;
                    btFoto6.ImageUrl = ResolveUrl(nam);
                    lbImagen6.Visible = true;
                    lbImagen6.Text = "PAPELETA";
                }

                /*
                if (indice == 10)
                {
                    btFoto6.Visible = true;
                    btFoto6.ImageUrl = ResolveUrl(nam);
                    lbImagen6.Visible = true;
                    lbImagen6.Text = "FIRMA CLIENTE";

                }
                */

                if (indice == 7)
                {
                    btFoto7.Visible = true;
                    btFoto7.ImageUrl = ResolveUrl(nam);
                    lbImagen7.Visible = true;
                    lbImagen7.Text = "PANORAMICA VIVIENDA";

                }

                if (indice == 8)
                {
                    btFoto8.Visible = true;
                    btFoto8.ImageUrl = ResolveUrl(nam);
                    lbImagen8.Visible = true;
                    lbImagen8.Text = "PANORAMICA INSTALACION";

                }

                if (indice == 9)
                {
                    btFoto9.Visible = true;
                    btFoto9.ImageUrl = ResolveUrl(nam);
                    lbImagen9.Visible = true;
                    lbImagen9.Text = "PROBLEMA TECNICO";
                }
            }
        }

        return ex;
        
    }

    public void cargarFotoVisita()
    {
        FileInfo[] MisFicheros;

        String nombre_fotografia = id + "A" + servicio + "A" + operador + "A" + visita + "A";

        String[] arrArchivosOrigenFotos;
        String[] arrArchivosFotosEvaluadas;

        arrArchivosOrigenFotos = Directory.GetFiles(Server.MapPath("./FOTOS/" + visita + "/"), nombre_fotografia + "" + "*");

        MisFicheros = new DirectoryInfo(Server.MapPath("./FOTOS/" + visita + "/")).GetFiles(nombre_fotografia + "" + "*");


        arrArchivosOrigenFotos = Directory.GetFiles(Server.MapPath("./FOTOS/" + visita + "/"), nombre_fotografia + "" + "*");
        if (Directory.Exists(Server.MapPath("./FOTOS/" + visita + "/")))
        {
            arrArchivosFotosEvaluadas = Directory.GetFiles(Server.MapPath("./FOTOS/" + visita + "/"), nombre_fotografia + "" + "*");
        }
        else
        {
            arrArchivosFotosEvaluadas = Directory.GetFiles(Server.MapPath("./FOTOS/" + visita + "/"), nombre_fotografia + "" + "*");
        }
        if (arrArchivosOrigenFotos.Length > 0)
        {
            //FOTO DIRECCTORIO SIN CIERRE
            MisFicheros = new DirectoryInfo(Server.MapPath("./FOTOS/" + visita + "/")).GetFiles(nombre_fotografia + "" + "*");

        }
        else if (arrArchivosFotosEvaluadas.Length > 0)
        {
            //FOTO DIRECCTORIO CON CIERRE
            MisFicheros = new DirectoryInfo(Server.MapPath("./FOTOS/" + visita + "/")).GetFiles(nombre_fotografia + "" + "*");
        }
        else if (arrArchivosFotosEvaluadas.Length == 0 && arrArchivosOrigenFotos.Length == 0)
        {
            //FOTO DIRECCTORIO CON EVALUACION
            MisFicheros = new DirectoryInfo(Server.MapPath("./FOTOS/" + visita + "/")).GetFiles(nombre_fotografia + "" + "*");
        }
        Int32 indice = 0;


        if (MisFicheros.Length == 0)
        {
            incializaCampos();
        }
        else
        {
            incializaCampos();
            for (int i = 0; i < MisFicheros.Length; i++)
            {
                String arch = MisFicheros[i].Name;
                String nam = MisFicheros[i].FullName.Replace(Server.MapPath(""), "~");
                String fotoA = arch;
                string[] words = fotoA.Split('A');
                string corr = words[4];
                corr = corr.Replace(".jpeg", "");
                indice = Int32.Parse(corr);
                //string imagePath = "";

                //if (arrArchivosOrigenFotos.Length > 0)
                //{
                //    //FOTO DIRECCTORIO SIN CIERRE
                //    imagePath = new Uri(Server.MapPath("~/FOTOS/" + fotoA)).AbsoluteUri;
                //}
                //else if (arrArchivosFotosEvaluadas.Length > 0)
                //{
                //    //FOTO DIRECCTORIO CON CIERRE
                //    imagePath = new Uri(Server.MapPath("~/FOTOS/" + pr + "/" + fotoA)).AbsoluteUri;
                //}

                if (indice == 1)
                {
                    btFoto1.Visible = true;
                    btFoto1.ImageUrl = ResolveUrl(nam);
                    lbImagen1.Visible = true;
                    lbImagen1.Text = "FOTO SERIE MED. RETIRADO";

                }

                if (indice == 2)
                {
                    btFoto2.Visible = true;
                    btFoto2.ImageUrl = ResolveUrl(nam);
                    lbImagen2.Visible = true;
                    lbImagen2.Text = "FOTO LECTURA MED. RETIRADO";

                }
                if (indice == 3)
                {
                    btFoto3.Visible = true;
                    btFoto3.ImageUrl = ResolveUrl(nam);
                    lbImagen3.Visible = true;
                    lbImagen3.Text = "FOTO SERIE MED. NUEVO";

                }

                if (indice == 4)
                {
                    btFoto4.Visible = true;
                    btFoto4.ImageUrl = ResolveUrl(nam);
                    lbImagen4.Visible = true;
                    lbImagen4.Text = "FOTO LECTURA MED. NUEVO";

                }

                if (indice == 5)
                {
                    btFoto5.Visible = true;
                    btFoto5.ImageUrl = ResolveUrl(nam);
                    lbImagen5.Visible = true;
                    lbImagen5.Text = "PANORAMICA MED. INSTALADO";

                }

                if (indice == 6)
                {
                    btFoto6.Visible = true;
                    btFoto6.ImageUrl = ResolveUrl(nam);
                    lbImagen6.Visible = true;
                    lbImagen6.Text = "PAPELETA";

                }

                //if (indice == 10)
                //{
                //    btFoto6.Visible = true;
                //    btFoto6.ImageUrl = ResolveUrl(nam);
                //    lbImagen6.Visible = true;
                //    lbImagen6.Text = "FIRMA CLIENTE";

                //}

                if (indice == 7)
                {
                    btFoto7.Visible = true;
                    btFoto7.ImageUrl = ResolveUrl(nam);
                    lbImagen7.Visible = true;
                    lbImagen7.Text = "PANORAMICA VIVIENDA";

                }

                if (indice == 8)
                {
                    btFoto8.Visible = true;
                    btFoto8.ImageUrl = ResolveUrl(nam);
                    lbImagen8.Visible = true;
                    lbImagen8.Text = "PANORAMICA INSTALACION";

                }

                if (indice == 9)
                {
                    btFoto9.Visible = true;
                    btFoto9.ImageUrl = ResolveUrl(nam);
                    lbImagen9.Visible = true;
                    lbImagen9.Text = "PROBLEMA TECNICO";
                }
            }
        }



    }


  




    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        String vtn = "window.open('zoomFoto.aspx?foto=" + btFoto1.ImageUrl + "','Dates','scrollbars=no,resizable=yes,height=300,width=300')";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", vtn, true);
    }
    protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
    {
        String vtn = "window.open('zoomFoto.aspx?foto=" + btFoto2.ImageUrl + "','Dates','scrollbars=no,resizable=yes,height=300,width=300')";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", vtn, true);
    }
    protected void ImageButton3_Click(object sender, ImageClickEventArgs e)
    {
        String vtn = "window.open('zoomFoto.aspx?foto=" + btFoto3.ImageUrl + "','Dates','scrollbars=no,resizable=yes,height=300,width=300')";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", vtn, true);
    }
    protected void btFoto4_Click(object sender, ImageClickEventArgs e)
    {
        String vtn = "window.open('zoomFoto.aspx?foto=" + btFoto4.ImageUrl + "','Dates','scrollbars=no,resizable=yes,height=300,width=300')";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", vtn, true);
    }
    protected void btFoto5_Click(object sender, ImageClickEventArgs e)
    {
        String vtn = "window.open('zoomFoto.aspx?foto=" + btFoto5.ImageUrl + "','Dates','scrollbars=no,resizable=yes,height=300,width=300')";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", vtn, true);
    }
    protected void btFoto6_Click(object sender, ImageClickEventArgs e)
    {
        String vtn = "window.open('zoomFoto.aspx?foto=" + btFoto6.ImageUrl + "','Dates','scrollbars=no,resizable=yes,height=300,width=300')";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", vtn, true);
    }
    protected void btFoto7_Click(object sender, ImageClickEventArgs e)
    {
        String vtn = "window.open('zoomFoto.aspx?foto=" + btFoto7.ImageUrl + "','Dates','scrollbars=no,resizable=yes,height=300,width=300')";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", vtn, true);
    }
    protected void btFoto8_Click(object sender, ImageClickEventArgs e)
    {
        String vtn = "window.open('zoomFoto.aspx?foto=" + btFoto8.ImageUrl + "','Dates','scrollbars=no,resizable=yes,height=300,width=300')";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", vtn, true);
    }
    protected void btFoto9_Click(object sender, ImageClickEventArgs e)
    {
        String vtn = "window.open('zoomFoto.aspx?foto=" + btFoto9.ImageUrl + "','Dates','scrollbars=no,resizable=yes,height=300,width=300')";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", vtn, true);
    }
}