using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OracleClient;
using System.Data.SqlTypes;
using System.Data.SqlClient;
using System.Data.Sql;
using System.Data.OleDb;
using System.Drawing;
using ASP;
using System.Xml;
using System.Configuration;
using Microsoft.VisualBasic;

public partial class MantencionEstatusMedidorRetirado : System.Web.UI.Page
{

    string id_perfil;
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();
    public DataTable dt;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

            //lb_id_usuario.Visible = false;
            //VALIDACION_RUT_USUARIO.Visible = false;

            XmlDataDocument doc_xml = new XmlDataDocument();
            bool valida;
            valida = valida_link();
            //inicializa_pagina();


            try
            {
                doc_xml.Load(Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml");
            }
            catch (Exception ex)
            {
                Response.Redirect("ErrorSession.aspx");
            }

            string XMLperfil;
            XMLperfil = doc_xml.SelectSingleNode("SESSION/DATOS_USUARIO/ID_PERFIL").InnerText;
            lb_perfil_usuario.Text = XMLperfil.ToString();
            lb_perfil_usuario.Visible = false;
            lb_rut_empresa.Text = doc_xml.SelectSingleNode("SESSION/DATOS_USUARIO/RUT_EMPRESA").InnerText;
            lb_rut_empresa.Visible = false;
            lb_id_usuario.Text = doc_xml.SelectSingleNode("SESSION/DATOS_USUARIO/ID_USUARIO").InnerText;

            LOG_ID_USUARIO.Text = doc_xml.SelectSingleNode("SESSION/DATOS_USUARIO/ID_USUARIO").InnerText;
            LOG_ID_USUARIO.Visible = false;

            string session_user, session_empresa;
            session_user = doc_xml.SelectSingleNode("SESSION/DATOS_USUARIO/NOMBRE").InnerText;
            session_empresa = doc_xml.SelectSingleNode("SESSION/DATOS_USUARIO/NOMBRE_EMPRESA").InnerText;
            lb_session_user.Text = ": " + session_user + " / ";
            lb_session_user.Visible = false;
            lb_session_empresa.Visible = false;
            lb_session_empresa.Text = ": " + session_empresa;
            Session[Session.SessionID + "_Empresa"] = doc_xml.SelectSingleNode("SESSION/DATOS_USUARIO/NOMBRE_EMPRESA").InnerText;
            //inicializa_pagina();
            //carga_causas(lb_rut_empresa.Text, lb_perfil_usuario.Text, lb_id_usuario.Text);
            Llena_combo_empresas(XMLperfil, Session[Session.SessionID + "_Empresa"].ToString());
            //Llena_combo_perfiles(XMLperfil); //PASAR PARAMETRO SESSION TIPO DE PERFIL

            carga_estatusmr(lb_rut_empresa.Text, lb_perfil_usuario.Text, lb_id_usuario.Text);
            tablaEstatusMedidrorR.Visible = false;
            GrillaEstatusMedidorR.Visible = true;

        }


    }



    internal string validadacion_Nombre_Usuario(string P_NOMBRE_USUARIO)
    {
        string resp;
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_USUARIO.VALIDA_USUARIO_EXISTE", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_usuario", OracleType.NVarChar, ParameterDirection.Input, P_NOMBRE_USUARIO);

        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        CnOra.Open();
        DataSet dsUsuarios = new DataSet();
        da.Fill(dsUsuarios, "ASIGNACIONES");
        CnOra.Close();
        CnOra.Dispose();

        if (dsUsuarios.Tables["ASIGNACIONES"].Rows.Count != 0)
        {
            //Response.Write("<script>")
            //Response.Write("alert('Eliminación Denegada, Lector tiene asignaciones relacionadas!');")
            //Response.Write("</script>")
            //Response.Write("Nombre de Usuario Existe en la Base de Datos! Elija Otro.")
            resp = "Nombre de Usuario Existe en la Base de Datos! Elija Otro.";
            return resp;
        }
        else
        {
            //Response.Write("<script>")
            //Response.Write("if (confirm('Mensaje de confirmación !  \n \n Esta seguro que desea eliminar el registro del Lector Seleccionado ?')) { document.location.href='EliminarLector.aspx?idlector=" & GrillaLectores.Items(indice).Cells(0).Text & "'; }")
            //Response.Write("</script>")
            resp = "OK";
            return resp;
        }

    }

    #region "Validad Acceso a URL"
    public bool valida_link()
    {
        recupera_session();
        System.Net.IPAddress oAddr;
        bool respuesta;
        string perfilStr, url, sessionStr, usuario, mIP, mEquipo, winSession, descripcion;
        Int32 perfilInt;
        DateTime fecha = DateTime.Now;
        sessionStr = lb_session_user.Text;
        sessionStr = sessionStr.Replace(":", "");
        sessionStr = sessionStr.Replace("/", "");
        usuario = lb_id_usuario.Text;
        perfilStr = id_perfil;
        perfilInt = Convert.ToInt32(perfilStr);
        url = Request.RawUrl;
        url = PRO.ObtenerLink(url);
        lb_session_user.Visible = false;
        lb_session_empresa.Visible = false;
        respuesta = PRO.obtiene_perfil(perfilInt, url);
        if (respuesta == false)
        {
            try
            {
                oAddr = new System.Net.IPAddress(System.Net.Dns.GetHostByName(System.Net.Dns.GetHostName()).AddressList[0].Address);
                mIP = oAddr.ToString();
            }
            catch (Exception ex)
            {
                mIP = "0.0.0.0 " + ex.Message.ToString();
            }
            try
            {
                mEquipo = System.Net.Dns.GetHostName();
            }
            catch (Exception ex)
            {
                mEquipo = "EQUIPO DESCONOCIDO " + ex.Message.ToString();
            }
            try
            {
                winSession = System.Security.Principal.WindowsIdentity.GetCurrent().Name;
            }
            catch (Exception ex)
            {
                winSession = "SESION DESCONOCIDA " + ex.Message.ToString();
            }
            descripcion = "INTENTO INGRESAR A MODULO NO AUTORIZADO CYR_ESSBIO";
            PRO.Insertamos_log(sessionStr, perfilStr, usuario, url, fecha.ToString(), mEquipo, winSession, mIP, descripcion);
            string ser = Server.MapPath(@".\CorreoAlerta.htm");
            PRO.EnviarAlerta(ser, sessionStr, perfilStr, usuario, url, fecha.ToString(), mEquipo, winSession, mIP, descripcion);
            Session.Abandon();
            Response.Redirect("administracion.aspx");

        }
        return respuesta;
    }

    #endregion


    internal void recupera_session()
    {
        XmlDataDocument recupera_xml = new XmlDataDocument();
        recupera_xml.Load(Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml");
        string session_user, session_empresa;
        session_user = recupera_xml.SelectSingleNode("SESSION/DATOS_USUARIO/NOMBRE").InnerText;
        session_empresa = recupera_xml.SelectSingleNode("SESSION/DATOS_USUARIO/NOMBRE_EMPRESA").InnerText;
        lb_rut_empresa.Text = recupera_xml.SelectSingleNode("SESSION/DATOS_USUARIO/RUT_EMPRESA").InnerText;
        lb_id_usuario.Text = recupera_xml.SelectSingleNode("SESSION/DATOS_USUARIO/ID_USUARIO").InnerText;
        id_perfil = recupera_xml.SelectSingleNode("SESSION/DATOS_USUARIO/ID_PERFIL").InnerText;
        lb_session_user.Text = ": " + session_user + " / ";

        lb_session_empresa.Text = ": " + session_empresa;

        lb_session_user.Visible = false;
        lb_session_empresa.Visible = false;
    }

    private void Llena_combo_empresas(string IDPerfil, string EMPRESA_USER)
    {

        string sql_empresas;
        DataTable dtEmpresas = new DataTable();
        sql_empresas = "select * from EMPRESA"; // Para rellenar combo 
        OracleDataAdapter objComando_Empresa;
        objComando_Empresa = new OracleDataAdapter(sql_empresas, conexion_cliente_oracle);
        objComando_Empresa.Fill(dtEmpresas);
        string valueCombo, textoCombo;
        combo_empresas.Items.Clear();

        if (IDPerfil == "3")
        {
            foreach (DataRow drEmpresaItem in dtEmpresas.Rows)
            {
                valueCombo = drEmpresaItem["rut_empresa"].ToString();
                textoCombo = drEmpresaItem["nombre"].ToString();
                combo_empresas.Items.Add(new ListItem(textoCombo, valueCombo));
            }
        }

        if (IDPerfil == "1")
        {
            foreach (DataRow drEmpresaItem in dtEmpresas.Rows)
            {
                if (EMPRESA_USER == drEmpresaItem["nombre"].ToString())
                {
                    valueCombo = drEmpresaItem["rut_empresa"].ToString();
                    textoCombo = drEmpresaItem["nombre"].ToString();
                    combo_empresas.Items.Add(new ListItem(textoCombo, valueCombo));
                }
            }
        }

    }


    internal void carga_estatusmr(string RutDeEmpresa, string PerfilDeUsuario, string ID_DE_Usuario) 
    {

        OracleDataAdapter da;
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        if (PerfilDeUsuario == "3")
        {
            OracleCommand cmdAcceso = new OracleCommand("PK_ESTATUS_MEDIDORR.CARGAR_ESTATUS_MEDIDORR", CnOra);
            da = new OracleDataAdapter(cmdAcceso);
        }
        else
        {
            OracleCommand cmdAcceso = new OracleCommand("PK_USUARIO.CONTRATISTAS_POR_EMPRESA", CnOra);
            da = new OracleDataAdapter(cmdAcceso);
            PRO.agrega_parametro_sp(da, "i_rut_empresa", OracleType.Number, ParameterDirection.Input, RutDeEmpresa);
            //PRO.agrega_parametro_sp(da, "i_id_perfil", OracleType.Int32, ParameterDirection.Input, 2.ToString()); //PERFIL 2 CONTRATISTAS
            //PRO.agrega_parametro_sp(da, "i_id_usuario", OracleType.Int32, ParameterDirection.Input, lb_id_usuario.Text.ToString()); //PARA CARGAR UNO MISMO
        }
        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");


        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        CnOra.Open();
        DataTable dtMeididorR = new DataTable();
        da.Fill(dtMeididorR);
        CnOra.Close();
        CnOra.Dispose();

        dt = new DataTable();
        dt.Columns.Add(new DataColumn("id_estatus_mr", typeof(string)));
        dt.Columns.Add(new DataColumn("cod_estatus_mr", typeof(string)));
        dt.Columns.Add(new DataColumn("descripcion", typeof(string)));
        dt.Columns.Add(new DataColumn("rut_empresa", typeof(string)));

        DataRow dr;
        int cont_registros;
        cont_registros = 0; 
        foreach (DataRow drMedidorItem in dtMeididorR.Rows)
        {
            dr = dt.NewRow();
            dr["id_estatus_mr"] = drMedidorItem["id_estatus_mr"].ToString();
            dr["cod_estatus_mr"] = drMedidorItem["cod_estatus_mr"].ToString();
            dr["descripcion"] = drMedidorItem["descripcion"].ToString();
            dr["rut_empresa"] = drMedidorItem["rut_empresa"].ToString();



            dt.Rows.Add(dr);
            cont_registros = cont_registros + 1;

        }


        lb_cantidad_registros.Text = cont_registros.ToString() + " coincidencia(s) encontrada(s)";
        DataView MydataView;
        MydataView = new DataView(dt);
        GrillaEstatusMedidorR.DataSource = MydataView;
        GrillaEstatusMedidorR.DataBind();



    }
    public void Limpiar()
    {
        txtCodigoMedidor.Text = "";
        txtDescripcionMedidor.Text = "";
        lbInformacion0.Text = "";
        lbAsci.Text = "";
    }



    protected void btnok_agregar0_Click(object sender, EventArgs e)
    {
        GrillaEstatusMedidorR.Visible = false;
        tablaEstatusMedidrorR.Visible = true;
    }
    protected void btoVolver_Click(object sender, EventArgs e)
    {
        GrillaEstatusMedidorR.Visible = true;
        tablaEstatusMedidrorR.Visible = false;
        carga_estatusmr(lb_rut_empresa.Text, lb_perfil_usuario.Text, lb_id_usuario.Text);
        Limpiar();


    }
    protected void btn_agregaEstatusLlR_Click(object sender, EventArgs e)
    {

        if (Page.IsValid)
        { //validaciones

            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            objConexion.Open();
            //sSQL = "INSERT INTO USUARIOS(id_usuario,id_empresa,usuario,password,id_perfil,rut,nombre,id_grupoproceso,estado) VALUES (4,1,'administrador','123456',1,'13890087-8','ANDRES CARDENAS',555,0)"
            OracleDataAdapter ComandoDA = new OracleDataAdapter("PK_ESTATUS_MEDIDORR.INSERTA_ESTADO_MEDIDORR", objConexion);

            ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

            //agrega_parametro_SP(ComandoDA, "i_id_usuario", SqlDbType.Int, "5") 'SACAR POR TRIGGER...
            PRO.agrega_parametro_sp(ComandoDA, "i_cod_estatus_mr", OracleType.Int32, ParameterDirection.Input, txtCodigoMedidor.Text);
            PRO.agrega_parametro_sp(ComandoDA, "i_descripcion", OracleType.NVarChar, ParameterDirection.Input, txtDescripcionMedidor.Text);
            PRO.agrega_parametro_sp(ComandoDA, "i_rut_empresa", OracleType.Int32, ParameterDirection.Input, combo_empresas.Items[combo_empresas.SelectedIndex].Value);






            try
            {
                ComandoDA.SelectCommand.ExecuteNonQuery();
                lbInformacion0.Text = " Estatus Medidor Retirado ingresado correctamente!";
                lbAsci.Text = " ✔ ";
                //row_aceptar_ok.Visible = true;
                //lb_mensaje_ingreso.Visible = true;
                //img_ok.Visible = true;
                //tbl_NuevoUser.Visible = false;
                //btnok_agregar.Visible = true;
                //btnvolver_agregar.Visible = true;

                //lb_minihead.Text = "";

                //*********************** INSERTAMOS LOG DEL SISTEMA ***********************************
                try
                {
                    //    string str_fecha = null;
                    //    string str_hora = null;
                    //    string str_desc_evento = null;
                    //    str_fecha = DateTime.Now.ToString().Substring(0, 10).Trim(' ');
                    //    str_hora = DateTime.Now.ToString().Substring(10, 9).Trim(' ');
                    //    str_desc_evento = "SE HA INGRESADO UN NUEVO USUARIO CON CODIGO CAUSA " + txtCodigoCausa.Text + "-" + CheckEstado.Text;
                    //    PRO.Insertamos_log_del_Sistema(lb_id_usuario.Text, lb_rut_empresa.Text, str_fecha, str_hora, str_desc_evento, "0", "0", Request.ServerVariables["REMOTE_ADDR"].ToString());
                }
                catch (Exception ex)
                {
                    lbInformacion0.Text = "No se guardó " + ex.ToString();
                }
                //**************************************************************************************


            }
            catch (Exception ex)
            {
                String exp = ex.ToString();
                lbInformacion0.Text = "No se guardó " + ex.ToString();





                //Mensaje de error ....usuario nuevo
            }

            //                }
            //                else
            //                {

            //                    VALIDACION_RUT_USUARIO.Visible = true;
            //                    VALIDACION_RUT_USUARIO.Text = msg_error_rut_perfil;


            //                }



            //            }
            //            else //EXISTE NOMBRE DE USUARIO EN LA BASE DE DATOS
            //            {

            //                //Response.Write(str_nom_user)
            //                VALIDACION_RUT_USUARIO.Visible = true;
            //                VALIDACION_RUT_USUARIO.Text = str_nom_user;

            //            }


            //        }
            //        else //FORMATO_RUT ES INCORRECTO
            //        {

            //            VALIDACION_RUT_USUARIO.Visible = true;
            //            VALIDACION_RUT_USUARIO.Text = "EL FORMATO DEL RUT ES INCORRECTO!";

            //        }

        }



    }
    protected void GrillaEstatusMedidorR_EditCommand(object source, DataGridCommandEventArgs e)
    {
        string indice;
        indice = e.Item.ItemIndex.ToString();
        Response.Redirect("ModificaEstatusMedidorRetirado.aspx?idMedidor=" + (GrillaEstatusMedidorR.Items[Int32.Parse(indice)].Cells[0].Text));
        Response.End();
    }
}