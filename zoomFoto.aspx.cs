using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class zoomFoto : System.Web.UI.Page
{

   // public int zoom=1;
    Procedimientos PRO = new Procedimientos();

    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
            PRO.recSession(rutaXml, "RUT_EMPRESA");

            String foto = Request.QueryString["foto"];

            String ruta_directorio;
            ruta_directorio =  foto;



            image.ImageUrl = ruta_directorio;

        }
        catch (Exception ex)
        {
            Response.Redirect("errorSesion.aspx");
        }
        
        
        

        

    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {

        String nuevoAlto = image.Height.ToString();
        String nuevoAncho = image.Width.ToString();

        String[] alto = nuevoAlto.Split('p');
        String[] ancho = nuevoAncho.Split('p');

        int he = (int)Math.Round(double.Parse(alto[0]) * 1.1);
        int wi = (int)Math.Round(double.Parse(ancho[0]) * 1.1);

        image.Height = he;
        image.Width = wi;

    }
    protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
    {
        String nuevoAlto = image.Height.ToString();
        String nuevoAncho = image.Width.ToString();

        String[] alto = nuevoAlto.Split('p');
        String[] ancho = nuevoAncho.Split('p');

        int he = (int)Math.Round(double.Parse(alto[0]) * 0.9);
        int wi = (int)Math.Round(double.Parse(ancho[0]) * 0.9);

        image.Height = he;
        image.Width = wi;
    }
}