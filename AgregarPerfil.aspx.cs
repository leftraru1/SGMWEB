using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OracleClient;
using System.Xml;
using System.Data.SqlClient;
using System.Net;
using System.Configuration;
using System.Net.Mail;
using System.IO;
using Microsoft.VisualBasic;

public partial class AgregarPerfil : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();
    public DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {

            try
            {
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                PRO.recSession(rutaXml, "RUT_EMPRESA");

                int perfiles_cont;
                perfiles_cont = int.Parse(Cantidad_de_Perfiles()) + 1;
                lbIdPerfil.Text = perfiles_cont.ToString();

            }
            catch(Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }

            
        }
        
    }
    protected void Button1_Click(object sender, EventArgs e)
    {

        String str_descripcion_perfil;
        str_descripcion_perfil = txt_descripcion_perfil.Text;
        String str_perfil;
        str_perfil = EXISTE_PERFIL_USUARIO(str_descripcion_perfil);
        
        if(str_perfil == "OK")
        {
            //lb_valida_perfiles.Visible = false;
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            objConexion.Open();
            OracleDataAdapter ComandoDA;
            ComandoDA = new OracleDataAdapter("PK_PERFIL.INSERTA_PERFIL", objConexion);
            ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

            PRO.agrega_parametro_sp(ComandoDA, "i_descripcion", OracleType.NVarChar,ParameterDirection.Input, str_descripcion_perfil);
            PRO.agrega_parametro_sp(ComandoDA, "i_estado", OracleType.Int32,ParameterDirection.Input, "0");

            try
            {
                ComandoDA.SelectCommand.ExecuteNonQuery();
                //lb_mensaje_edicion.Visible = true;
                //img_ok.Visible = true;
                msgEdit.Text = "PERFIL INGRESADO CORRECTAMENTE!";
                //inicializa_controles_ingreso(false);
                objConexion.Close();
                objConexion.Dispose();
            }
            catch(Exception ex)
            {
                msgEdit.Text = ex.ToString();
                  //lb_mensaje_edicion.Visible = false;
                  //img_ok.Visible = false;
                  //lb_valida_perfiles.Visible = true;
                  //lb_valida_perfiles.Text = "HA OCURRIDO UN ERROR AL INGRESO DE NUEVO PERFIL! INTÉNTELO NUEVAMENTE.";
            }

            
              
        }
        else
        {
            //lb_mensaje_edicion.Visible = false;
            //img_ok.Visible = false;
            //lb_valida_perfiles.Visible = true;
            //lb_valida_perfiles.Text = str_perfil;
        }
            
    }

    public String EXISTE_PERFIL_USUARIO(String P_DESCRIPCION)
    {
        String existe;
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_PERFIL.CONSULTA_EXISTE_PERFIL", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_descripcion_perfil", OracleType.NVarChar, ParameterDirection.Input, P_DESCRIPCION);
        
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        CnOra.Open();
        DataSet dsPerfiles = new DataSet();
        da.Fill(dsPerfiles, "desc_perfiles");
        CnOra.Close();
        CnOra.Dispose();

        if(dsPerfiles.Tables["desc_perfiles"].Rows.Count != 0)
        {
           existe = "PERFIL DE USUARIO YA EXISTE! ELIJA OTRO.";
        }else
        {
           existe= "OK";
        }
       
        return existe;
                
       
    }

    public String Cantidad_de_Perfiles()
    {
        String cantidad;
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_PERFIL.CANTIDAD_PERFILES", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        CnOra.Open();
        DataSet dsPerfiles = new DataSet();
        da.Fill(dsPerfiles, "total_perfiles");
        CnOra.Close();
        CnOra.Dispose();

        if(dsPerfiles.Tables["total_perfiles"].Rows.Count != 0)
        {
            cantidad = dsPerfiles.Tables["total_perfiles"].Rows[0]["CANTIDAD_PERFILES"].ToString();
        
        }
        else
        {
            cantidad = "ERROR";
        }

        return cantidad;
    }


       


        
}