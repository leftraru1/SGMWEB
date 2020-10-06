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
using Microsoft.VisualBasic;

public partial class login : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();
    public DataTable dt;
    public String estado, id_perfil, nombre, id_usuario, mIP, mEquipo, winSession, descripcion, url, fecha, ser,id_contratista;
    IPAddress oAddr;

    protected void Page_Load(object sender, EventArgs e)
    {
        lb_id_usuario.Visible = false;
        lb_rut_empresa.Visible = false;

    }
    protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
    {
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_USUARIO.LOGIN_ACCESO", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_nombre_usuario", OracleType.NVarChar, ParameterDirection.Input, logSistema.UserName);
        PRO.agrega_parametro_sp(da, "i_password_usuario", OracleType.NVarChar, ParameterDirection.Input,logSistema.Password);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        try
        {
            CnOra.Open();
        }
        catch(Exception ex)
        {

          logSistema.FailureText="HA OCURRIDO UN ERROR CON LA CONEXION A LA BASES DE DATOS ORACLE = " + ex.Message;
          
        }

           DataSet objDS = new DataSet();
            da.Fill(objDS, "USUARIO");
            CnOra.Close();
            CnOra.Dispose();




        try
        {
            estado = objDS.Tables["USUARIO"].Rows[0][6].ToString();
            id_perfil = objDS.Tables["USUARIO"].Rows[0][1].ToString();
            nombre = objDS.Tables["USUARIO"].Rows[0][3].ToString();
            id_usuario = objDS.Tables["USUARIO"].Rows[0][0].ToString();
            id_contratista=objDS.Tables["USUARIO"].Rows[0][7].ToString();
            

            try
            {
                 oAddr = new IPAddress(Dns.GetHostByName(Dns.GetHostName()).AddressList[0].Address);
                 mIP = oAddr.ToString();
                 mIP = Request.ServerVariables["REMOTE_ADDR"].ToString();
            }
            catch(Exception ex)
            {
                  mIP = "0.0.0.0 " + ex.Message.ToString();
            }
    
            try
            {
                mEquipo = Dns.GetHostName();
                mEquipo = Request.ServerVariables["REMOTE_ADDR"].ToString();
            }
            catch(Exception ex)
            {
                mEquipo = "EQUIPO DESCONOCIDO " + ex.Message.ToString();
            }
 
            try
            {
                 winSession = System.Security.Principal.WindowsIdentity.GetCurrent().Name;
            }
            catch(Exception ex)
            {
                winSession = "SESION DESCONOCIDA " + ex.Message.ToString();
            }
           
              descripcion = "INTENTO INGRESAR CON USUARIO DESHABILITADO";
        }
        catch(Exception ex)
        {
        }

        ser = Server.MapPath("./CorreoAlerta.htm");
        fecha = DateTime.Now.ToString();
        url = "administracion.aspx";

           
             if ((objDS.Tables["USUARIO"].Rows.Count == 0)){

                 logSistema.UserNameRequiredErrorMessage="Usuario Incorrecto";
                 logSistema.PasswordRequiredErrorMessage="Password Incorrecto";


                 logSistema.FailureText = "USUARIO O CONTRASEÑA INCORRECTA";
             }
             else if (estado == "1")
             {

                 logSistema.FailureText = "USUARIO DESHABILITADO";
             }
             else
             {

                 XmlDataDocument xml_session = new XmlDataDocument();
                 XmlNode NODO_RAIZ, NODO_USUARIO, Nodo_iduser, Nodo_idperfil, Nodo_username, Nodo_contratista, Nodo_nombre, Nodo_idempresa, nodo_nomEmpresa;
                 xml_session.LoadXml("<SESSION></SESSION>");
                 NODO_RAIZ = xml_session.SelectSingleNode("SESSION");
                 NODO_USUARIO = xml_session.CreateElement("DATOS_USUARIO");
                 NODO_RAIZ.AppendChild(NODO_USUARIO);
                 Nodo_iduser = xml_session.CreateElement("ID_USUARIO");
                 Nodo_iduser.InnerText = objDS.Tables["USUARIO"].Rows[0][0].ToString(); //ID_usuario               
                 Nodo_idperfil = xml_session.CreateElement("ID_PERFIL");
                 lb_id_usuario.Text = objDS.Tables["USUARIO"].Rows[0][0].ToString();
                 Nodo_idperfil.InnerText = objDS.Tables["USUARIO"].Rows[0][1].ToString(); //'ID_PERFIL
                 Nodo_username = xml_session.CreateElement("USERNAME");
                 Nodo_username.InnerText = objDS.Tables["USUARIO"].Rows[0][2].ToString();
                 Nodo_nombre = xml_session.CreateElement("NOMBRE");
                 Nodo_nombre.InnerText = objDS.Tables["USUARIO"].Rows[0][3].ToString();
                 Nodo_idempresa = xml_session.CreateElement("RUT_EMPRESA");
                 Nodo_idempresa.InnerText = objDS.Tables["USUARIO"].Rows[0][4].ToString(); //'RUT_EMPRESA
                 lb_rut_empresa.Text = objDS.Tables["USUARIO"].Rows[0][4].ToString();
                 nodo_nomEmpresa = xml_session.CreateElement("NOMBRE_EMPRESA");
                 nodo_nomEmpresa.InnerText = objDS.Tables["USUARIO"].Rows[0][5].ToString();

                 Nodo_contratista = xml_session.CreateElement("ID_CONTRATISTA");
                 Nodo_contratista.InnerText = objDS.Tables["USUARIO"].Rows[0][7].ToString(); //ID_CONTRATISTA
                 NODO_USUARIO.AppendChild(Nodo_iduser);
                 NODO_USUARIO.AppendChild(Nodo_idperfil);
                 NODO_USUARIO.AppendChild(Nodo_username);
                 NODO_USUARIO.AppendChild(Nodo_nombre);
                 NODO_USUARIO.AppendChild(Nodo_idempresa);
                 NODO_USUARIO.AppendChild(nodo_nomEmpresa);
                 NODO_USUARIO.AppendChild(Nodo_contratista);

                 try
                 {
                     xml_session.Save(Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml");

                     descripcion = "INGRESO CON USUARIO HABILITADO";
                     PRO.Insertamos_log(nombre, id_perfil, id_usuario, url, fecha, mEquipo, winSession, mIP, descripcion);
                     //'*********************** INSERTAMOS LOG DEL SISTEMA ***********************************

                     try
                     {

                         String str_fecha, str_hora, str_min, str_desc_evento;

                         str_fecha = DateTime.Now.Date.ToString();
                         str_hora = DateTime.Now.Hour.ToString();
                         str_min = DateTime.Now.Minute.ToString();
                         str_hora = str_hora + ":" + str_min;
                         str_desc_evento = "INICIO DE SESION DE USUARIO DESDE LA IP CLIENTE: " + Request.ServerVariables["REMOTE_ADDR"].ToString();

                         PRO.inserta_log_sistema(lb_id_usuario.Text, lb_rut_empresa.Text, str_fecha, str_hora, str_desc_evento, "0", "0", Request.ServerVariables["REMOTE_ADDR"].ToString());


                     }
                     catch (Exception ex)
                     {

                         Response.Write("Error al grabar XML de session" + ex.Message);
                         Response.End();

                     }

                     //'**************************************************************************************
                 }
                 catch (Exception ex)
                 {

                     Response.Write("Error al grabar XML de session" + ex.Message);
                     Response.End();

                 }


                 String plataformaSTR;
                 plataformaSTR = Request.Browser.Type;


                 if (plataformaSTR != "IE7")
                 {


                     Response.Redirect("inicio.aspx");

                 }
                 else
                 {


                     Response.Redirect("inicio.aspx");
                 }

             }

    }
    protected void LoginButton_Click(object sender, EventArgs e)
    {

    }
}