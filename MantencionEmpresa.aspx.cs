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

public partial class MantencionEmpresa : System.Web.UI.Page
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
           
            //Llena_combo_perfiles(XMLperfil); //PASAR PARAMETRO SESSION TIPO DE PERFIL
            carga_empresas(lb_rut_empresa.Text, lb_perfil_usuario.Text, lb_id_usuario.Text);
            Llena_combo_codContratista(XMLperfil, Session[Session.SessionID + "_Empresa"].ToString());
            tablaEmpresas.Visible = false;
            GrillaEmpresas.Visible = true;
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


    internal void carga_empresas(string RutDeEmpresa, string PerfilDeUsuario, string ID_DE_Usuario) 
    {

        OracleDataAdapter da;
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        if (PerfilDeUsuario == "3")
        {
            OracleCommand cmdAcceso = new OracleCommand("PK_EMPRESA.CARGAR_EMPRESAS", CnOra); 
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
        DataTable dtEmpresa = new DataTable();
        da.Fill(dtEmpresa);
        CnOra.Close();
        CnOra.Dispose();

        dt = new DataTable();
        dt.Columns.Add(new DataColumn("id_empresa", typeof(string)));

        dt.Columns.Add(new DataColumn("rut_empresa", typeof(string)));
        dt.Columns.Add(new DataColumn("nombre", typeof(string)));
        dt.Columns.Add(new DataColumn("mail", typeof(string)));
        dt.Columns.Add(new DataColumn("cod_contratista", typeof(string)));

        DataRow dr;
        int cont_registros;
        cont_registros = 0;
        foreach (DataRow drEmpresaItem in dtEmpresa.Rows) 
        {
            dr = dt.NewRow();
            dr["id_empresa"] = drEmpresaItem["id_empresa"].ToString();

            dr["rut_empresa"] = drEmpresaItem["rut_empresa"].ToString();
            dr["nombre"] = drEmpresaItem["nombre"].ToString();
            dr["mail"] = drEmpresaItem["mail"].ToString();
            dr["cod_contratista"] = drEmpresaItem["cod_contratista"].ToString();

           

            dt.Rows.Add(dr);
            cont_registros = cont_registros + 1;

        }


        lb_cantidad_registros.Text = cont_registros.ToString() + " coincidencia(s) encontrada(s)";
        DataView MydataView;
        MydataView = new DataView(dt);
        GrillaEmpresas.DataSource = MydataView;
        GrillaEmpresas.DataBind();

        //int er;
        //for (er = 0; er < GrillaEmpresas.Items.Count; er++)
        //{

        //    if (GrillaEmpresas.Items[er].Cells[4].Text == "HABILITADO")
        //    {

        //        GrillaEmpresas.Items[er].Cells[4].BackColor = Color.LightGreen;

        //    }
        //    else
        //    {

        //        GrillaEmpresas.Items[er].Cells[4].BackColor = Color.Red;

        //    }



        //}

    }


    private void Llena_combo_codContratista(string IDPerfil, string EMPRESA_USER) 
    {

        string sql_empresas;
        DataTable dtEmpresas = new DataTable();
        sql_empresas = "select * from CONTRATISTA"; // Para rellenar combo 
        OracleDataAdapter objComando_Empresa;
        objComando_Empresa = new OracleDataAdapter(sql_empresas, conexion_cliente_oracle);
        objComando_Empresa.Fill(dtEmpresas);
        string valueCombo, textoCombo;
        comboCodContratista.Items.Clear();

        if (IDPerfil == "3")
        {
            foreach (DataRow drEmpresaItem in dtEmpresas.Rows)
            {
                valueCombo = drEmpresaItem["cod_contratista"].ToString();
                textoCombo = drEmpresaItem["nombre"].ToString();
                comboCodContratista.Items.Add(new ListItem(textoCombo, valueCombo));
            }
        }

        if (IDPerfil == "1")
        {
            foreach (DataRow drEmpresaItem in dtEmpresas.Rows)
            {
                if (EMPRESA_USER == drEmpresaItem["nombre"].ToString())
                {
                    valueCombo = drEmpresaItem["cod_contratista"].ToString();
                    textoCombo = drEmpresaItem["nombre"].ToString();
                    comboCodContratista.Items.Add(new ListItem(textoCombo, valueCombo));
                }
            }
        }

    }





    protected void GrillaCausaCambio_EditCommand(object source, DataGridCommandEventArgs e)
    {
        string indice;

        indice = e.Item.ItemIndex.ToString();
        Response.Redirect("ModificarEmpresa.aspx?idEmpresa=" + (GrillaEmpresas.Items[Int32.Parse(indice)].Cells[0].Text.Trim()));
        Response.End();
    }
    protected void GrillaCausaCambio_PageIndexChanged(object source, DataGridPageChangedEventArgs e)
    {
        GrillaEmpresas.CurrentPageIndex = e.NewPageIndex;
        carga_empresas(lb_rut_empresa.Text, lb_perfil_usuario.Text, lb_id_usuario.Text);
    }
    protected void btoAgregaEmpresa_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        { //validaciones

            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            objConexion.Open();
            //sSQL = "INSERT INTO USUARIOS(id_usuario,id_empresa,usuario,password,id_perfil,rut,nombre,id_grupoproceso,estado) VALUES (4,1,'administrador','123456',1,'13890087-8','ANDRES CARDENAS',555,0)"
            OracleDataAdapter ComandoDA = new OracleDataAdapter("PK_EMPRESA.EMPRESAS_INSERTA", objConexion);

            ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

            //agrega_parametro_SP(ComandoDA, "i_id_usuario", SqlDbType.Int, "5") 'SACAR POR TRIGGER...

            PRO.agrega_parametro_sp(ComandoDA, "i_rut_empresa", OracleType.Int32, ParameterDirection.Input, txtRutEmpresa.Text);
            PRO.agrega_parametro_sp(ComandoDA, "i_nombre", OracleType.NVarChar, ParameterDirection.Input, txtNombreEmpresa.Text);
            PRO.agrega_parametro_sp(ComandoDA, "i_mail", OracleType.NVarChar, ParameterDirection.Input, txtEmailEmpresa.Text);
            PRO.agrega_parametro_sp(ComandoDA, "i_cod_contratista", OracleType.Int32, ParameterDirection.Input, comboCodContratista.Items[comboCodContratista.SelectedIndex].Value);
            
            
            try
            {
                ComandoDA.SelectCommand.ExecuteNonQuery();
                lbInformacion0.Text = " Empresa ingresada correctamente!";
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

                lbInformacion0.Text ="Error"+ex.ToString();


                //Mensaje de error ....usuario nuevo
            }
        }
    }
    protected void btoVolver_Click(object sender, EventArgs e)
    {
        tablaEmpresas.Visible = false;
        GrillaEmpresas.Visible = true;
        btnok_agregar0.Visible = true;

    }
    protected void btnok_agregar0_Click(object sender, EventArgs e)
    {
        tablaEmpresas.Visible = true;
        GrillaEmpresas.Visible = false;
        btnok_agregar0.Visible = false;
    }
}