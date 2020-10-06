using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Data.OleDb;
using System.Xml;
using ASP;
using System.Text;
using System.Configuration;
using System.Web.SessionState;
using System.Data.OracleClient;

public partial class menu : System.Web.UI.MasterPage
{

    String conexion = ConfigurationManager.AppSettings["ConnectionString"];
    String conexion_cliente_oracle = ConfigurationSettings.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();

 

    protected void Page_Load(object sender, EventArgs e)
    {
        

        if (!Page.IsPostBack)
        {


            try
            {
                String ruta = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";

                lbIdUs.Text = PRO.recSession(ruta, "ID_USUARIO");
                lbIdPerfil.Text = PRO.recSession(ruta, "ID_PERFIL");
                lbUserName.Text = PRO.recSession(ruta, "USERNAME");
                lbNomUs.Text = PRO.recSession(ruta, "NOMBRE");
                lbRutEm.Text = PRO.recSession(ruta, "RUT_EMPRESA");
                lbNomEmpresa.Text = PRO.recSession(ruta, "NOMBRE_EMPRESA");


                cargaMenu();
            }
            catch(Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
                lbErrorLog.Text = ex.ToString();
            }

            lbIdUs.Visible = false;
            lbUserName.Visible = false;
            lbRutEm.Visible = false;
            lbIdPerfil.Visible = false;
                 
           
        
        }

               
     
    }

    public void cargaMenu()
    {

        DataTable dtMenuItems = new DataTable();
        DataTable dtSubMenuItems = new DataTable();
        DataSet objDS = new DataSet();

        StringBuilder strMenuTitulo = new StringBuilder();
        StringBuilder strMenu = new StringBuilder();



        OracleDataAdapter daMenu = new OracleDataAdapter("select * from menu where estado = 0 order by nombre", conexion_cliente_oracle);
        daMenu.Fill(dtMenuItems);
        daMenu.Dispose();

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_MENU.MENU_X_PERFIL", CnOra);
        OracleDataAdapter daSubmenu = new OracleDataAdapter(cmdAcceso);


        PRO.agrega_parametro_sp(daSubmenu, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(daSubmenu, "i_idperfil", OracleType.NVarChar, ParameterDirection.Input, lbIdPerfil.Text);
        daSubmenu.SelectCommand.CommandType = CommandType.StoredProcedure;

        daSubmenu.Fill(dtSubMenuItems);
        daSubmenu.Dispose();

        strMenu = new StringBuilder();

        //strMenu.Append("<div>");

        strMenu.Append("<ul>");
        //strMenu.Append("<li>");
        foreach (DataRow drMenuItem in dtMenuItems.Rows)
        {

            strMenu.Append("<li><a href='#'>" + drMenuItem["menu"].ToString() + "</a>");
            strMenu.Append("<ul>");

            foreach (DataRow drSubMenuItem in dtSubMenuItems.Rows)
            {

                if (drSubMenuItem["id_menu"].ToString() == drMenuItem["id_menu"].ToString())
                {

                    strMenu.Append("<li><a href=" + drSubMenuItem["link"].ToString() + " target='_blank'>" + drSubMenuItem["menu"].ToString() + "</a></li>");

                }
            }

            strMenu.Append("</ul>");
            strMenu.Append("</li>");
        }


        strMenu.Append("</ul>");
        //strMenu.Append("</div>");
        divMenu.InnerHtml = strMenu.ToString();
    }
  
    protected void Button1_Click1(object sender, EventArgs e)
    {
        ContentPlaceHolder mpContentPlaceHolder;
        Panel gridPanel;
        GridView gridOrden;
        GridView gridSalida;
        Table tabla;
        

        mpContentPlaceHolder = ContentPlaceHolder1;
            
        if (tdMenu.Visible == true)
        { 
            tdMenu.Visible = false;
            btnOcultar.Text = ">>";
                       
            if(mpContentPlaceHolder != null)
            {
                gridPanel = (Panel) mpContentPlaceHolder.FindControl("panGrid");
                gridOrden = (GridView)mpContentPlaceHolder.FindControl("gridOrden");
                gridSalida = (GridView)mpContentPlaceHolder.FindControl("gridSalida");
                tabla = (Table)mpContentPlaceHolder.FindControl("tablaAsig");

                if(gridPanel != null)
                {
                    gridPanel.Width = 1300;
                                     
                }

                if (gridOrden != null)
                {
                    gridOrden.Width = 1280;

                }

                if (gridSalida != null)
                {
                    gridSalida.Width = 1280;

                }
               
            }
    
            
        }
        else
        { 
            tdMenu.Visible = true;
            btnOcultar.Text = "<<";
            if (mpContentPlaceHolder != null)
            {
                gridPanel = (Panel)mpContentPlaceHolder.FindControl("panGrid");
                gridOrden = (GridView)mpContentPlaceHolder.FindControl("gridOrden");
                gridSalida = (GridView)mpContentPlaceHolder.FindControl("gridSalida");

                if (gridPanel != null)
                {
                    gridPanel.Width = 1100;

                }

                if (gridOrden != null)
                {
                    gridOrden.Width = 1158;

                }

                if (gridSalida != null)
                {
                    gridSalida.Width = 950;

                }

            }
            
        }
        
    }
    protected void lbCerrarSess_Click(object sender, EventArgs e)
    {
        Session.Abandon();

        Response.Redirect("login.aspx");
    }
    protected void btn_ir_historial_Click(object sender, EventArgs e)
    {
        Response.Redirect("GestionHistorico.aspx");
    }
    protected void btn_ir_efectividad_Click(object sender, EventArgs e)
    {
        Response.Redirect("Informe_efectividad.aspx");
    }
}
