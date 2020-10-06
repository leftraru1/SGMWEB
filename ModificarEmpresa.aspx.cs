using System;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Data.OracleClient;
using System.Xml;
using System.Data;
using System.Data.OracleClient;
using System.Data.SqlTypes;
using System.Data.SqlClient;
using System.Data.Sql;
using System.Data.OleDb;
using System.Web.UI.WebControls;

public partial class ModificarEmpresa : System.Web.UI.Page
{
    private Procedimientos PRO = new Procedimientos();
    private string id_perfil;
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    public DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {
           if (!Page.IsPostBack)
        {
            bool valida = false;
            valida = valida_link();
            LB_RUT_EMPRESA0.Visible = false;
            lb_session_user.Visible = false;
            lb_perfil_usuario.Visible = false;
            lb_session_empresa.Visible = false;
            lb_rut_empresa.Visible = false;

            //VALIDACION_RUT_USUARIO.Visible = false;
            XmlDataDocument doc_xml = new XmlDataDocument();

            try
            {
                doc_xml.Load(Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml");
            }
            catch (Exception ex)
            {
                Response.Redirect("ErrorSession.aspx");
            }


            string XMLperfil = null;
            string XMLEmpresa = null;
            XMLperfil = doc_xml.SelectSingleNode("SESSION/DATOS_USUARIO/ID_PERFIL").InnerText;
            XMLEmpresa = doc_xml.SelectSingleNode("SESSION/DATOS_USUARIO/NOMBRE_EMPRESA").InnerText;

            string session_user = null;
            string session_empresa = null;
            session_user = doc_xml.SelectSingleNode("SESSION/DATOS_USUARIO/NOMBRE").InnerText;
            session_empresa = doc_xml.SelectSingleNode("SESSION/DATOS_USUARIO/NOMBRE_EMPRESA").InnerText;

            lb_id_usuario.Text = doc_xml.SelectSingleNode("SESSION/DATOS_USUARIO/ID_USUARIO").InnerText;
            lb_id_usuario.Visible = false;

            LB_RUT_EMPRESA0.Text = doc_xml.SelectSingleNode("SESSION/DATOS_USUARIO/RUT_EMPRESA").InnerText;
            LB_RUT_EMPRESA0.Visible = false;

            lb_session_user.Text = ": " + session_user + " / ";
            lb_session_empresa.Text = ": " + session_empresa;


            Llena_combo_codContratista(XMLperfil, Session[Session.SessionID + "_Empresa"].ToString());

            carga_empresa_porID();


            //Llena_combo_empresas(XMLperfil, XMLEmpresa);
            //Llena_combo_perfiles(XMLperfil); //PASAR PARAMETRO SESSION TIPO DE PERFIL

            
            //lb_mensaje_edicion.Visible = false;
            //img_ok.Visible = false;
            //Btn_newEDIT.Enabled = false;

        }

    }

    #region Validad Acceso a URL
    public bool valida_link()
    {
        recupera_session();
        System.Net.IPAddress oAddr = null;
        bool respuesta = false;
        string perfilStr = null;
        string url = null;
        string sessionStr = null;
        string usuario = null;
        string fecha = null;
        //DateTime fecha;
        //DateTime fecha = null;
        string mIP = null;
        string mEquipo = null;
        string winSession = null;
        string descripcion = null;
        Int32 perfilInt = 0;
        fecha = DateTime.Now.ToString();
        sessionStr = lb_session_user.Text;
        sessionStr = sessionStr.Replace(":", "");
        sessionStr = sessionStr.Replace("/", "");
        usuario = lb_id_usuario.Text;
        perfilStr = id_perfil;
        perfilInt = Convert.ToInt32(perfilStr);

        url = "a/MantencionUsuarios.aspx";
        //url = Request.RawUrl
        url = PRO.ObtenerLink(url);
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
            PRO.Insertamos_log(sessionStr, perfilStr, usuario, url, fecha, mEquipo, winSession, mIP, descripcion);
            string ser = Server.MapPath(".\\CorreoAlerta.htm");
            PRO.EnviarAlerta(ser, sessionStr, perfilStr, usuario, url, fecha, mEquipo, winSession, mIP, descripcion);
            Session.Abandon();
            Response.Redirect("administracion.aspx");

        }
        return false;
    }
    #endregion
    public void recupera_session()
    {
        XmlDataDocument recupera_xml = new XmlDataDocument();
        recupera_xml.Load(Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml");
        string session_user = null;
        string session_empresa = null;
        session_user = recupera_xml.SelectSingleNode("SESSION/DATOS_USUARIO/NOMBRE").InnerText;
        session_empresa = recupera_xml.SelectSingleNode("SESSION/DATOS_USUARIO/NOMBRE_EMPRESA").InnerText;
        LB_RUT_EMPRESA0.Text = recupera_xml.SelectSingleNode("SESSION/DATOS_USUARIO/RUT_EMPRESA").InnerText;
        lb_id_usuario.Text = recupera_xml.SelectSingleNode("SESSION/DATOS_USUARIO/ID_USUARIO").InnerText;
        id_perfil = recupera_xml.SelectSingleNode("SESSION/DATOS_USUARIO/ID_PERFIL").InnerText;
        lb_session_user.Text = ": " + session_user + " / ";

        lb_session_empresa.Text = ": " + session_empresa;


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
        comboCodContratistaE.Items.Clear();

        if (IDPerfil == "3")
        {
            foreach (DataRow drEmpresaItem in dtEmpresas.Rows)
            {
                valueCombo = drEmpresaItem["cod_contratista"].ToString();
                textoCombo = drEmpresaItem["nombre"].ToString();
                comboCodContratistaE.Items.Add(new ListItem(textoCombo, valueCombo));
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
                    comboCodContratistaE.Items.Add(new ListItem(textoCombo, valueCombo));
                }
            }
        }

    }


    public void carga_empresa_porID()  
    {
        string ID_EMPR = Request.QueryString["idEmpresa"];  


        string sSQL = null;
        OracleDataAdapter objComando = null;
        DataTable dtEmpresa = new DataTable(); 
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        objConexion.Open();
        sSQL = "SELECT EMPRESA.ID_EMPRESA, EMPRESA.NOMBRE, EMPRESA.RUT_EMPRESA, EMPRESA.MAIL, EMPRESA.COD_CONTRATISTA, CONTRATISTA.COD_CONTRATISTA FROM EMPRESA JOIN CONTRATISTA ON EMPRESA.COD_CONTRATISTA=CONTRATISTA.COD_CONTRATISTA WHERE EMPRESA.ID_EMPRESA =" + ID_EMPR; 
 //pasar consulta a SP

        objComando = new OracleDataAdapter(sSQL, conexion_cliente_oracle);
        objComando.Fill(dtEmpresa);
        objConexion.Close();
        objConexion.Dispose();

        dt = new DataTable();
        dt.Columns.Add(new DataColumn("id_empresa", typeof(string)));
        dt.Columns.Add(new DataColumn("nombre", typeof(string)));
        dt.Columns.Add(new DataColumn("mail", typeof(string)));
        dt.Columns.Add(new DataColumn("cod_contratista", typeof(string)));
        dt.Columns.Add(new DataColumn("rut_empresa", typeof(string)));



        DataRow dr = null;
        foreach (DataRow drCausasItem in dtEmpresa.Rows)
        {
            dr = dt.NewRow();
            dr["id_empresa"] = drCausasItem["id_empresa"].ToString();
            dr["nombre"] = drCausasItem["nombre"].ToString();
            dr["mail"] = drCausasItem["mail"].ToString();
            dr["cod_contratista"] = drCausasItem["cod_contratista"].ToString();
            dr["rut_empresa"] = drCausasItem["rut_empresa"].ToString();
            //dr["empresa"] = "empresa"; //drUsuarioItem("empresa").ToString 'Funcion que devuelva empresa

            dt.Rows.Add(dr);
        }

        txtNombreEmpresaE.Text = dt.Rows[0]["nombre"].ToString();
        txtEmailEmpresaE.Text = dt.Rows[0]["mail"].ToString();
        comboCodContratistaE.SelectedValue = dt.Rows[0][4].ToString();
        txtRutEmpresaE.Text = dt.Rows[0]["mail"].ToString();



       



    }
    //pasando consulta a SP
    public void carga_empresas()
    {
        string ID_EMPR = Request.QueryString["idEmpresa"];
        DataSet objDS = new DataSet();


        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        objConexion.Open();
        OracleDataAdapter ComandoDA = null;
        ComandoDA = new OracleDataAdapter("PK_EMPRESA.UPDATE_EMPRESA", objConexion);

        ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(ComandoDA, "i_id_empresa", OracleType.Int32, ParameterDirection.Input, ID_EMPR.ToString());

        ComandoDA.SelectCommand.ExecuteNonQuery();
        ComandoDA.Fill(objDS, "USUARIOS");
        objConexion.Close();

        foreach (DataRow row in objDS.Tables["EMPRESAS"].Rows)
        {

            txtNombreEmpresaE.Text = Convert.ToString(row[2]);
            txtRutEmpresaE.Text = Convert.ToString(row[3]);


        }
    }




    
    protected void btoVolver_Click(object sender, EventArgs e)
    {
        Response.Redirect("MantencionEmpresa.aspx");
    }
    protected void btoEditaEmpresa_Click(object sender, EventArgs e)
    {

        string R_EMP = Request.QueryString["idEmpresa"]; 

       

        //if (formato_rut() == true)
        //{

        //    VALIDACION_RUT_USUARIO.Visible = false;
        //    //SE VALIDA QUE NO EXISTA NOMBRE DE USUARIO
        //string str_nom_user = null;
        //str_nom_user = validadacion_Nombre_Usuario(txt_login.Text, ID_User_UPDATE);

        //    if (str_nom_user == "OK")
        //    {


        //        VALIDACION_RUT_USUARIO.Visible = false;
        //        string concat_rut_user = null;
        //        string msg_error_rut_perfil = null;
        //        concat_rut_user = txt_rut.Text.Trim(' ') + "-" + txt_dv.Text.Trim(' ');
        //        string P_ID_User = Request.QueryString["iduser"];
        //        msg_error_rut_perfil = validadacion_RUT_PERFIL(P_ID_User, Convert.ToString(combo_perfiles.Items[combo_perfiles.SelectedIndex].Value).Trim(' '), concat_rut_user);


        //        if (msg_error_rut_perfil == "OK")
        //        {


        //            VALIDACION_RUT_USUARIO.Visible = false;


                    OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
                    objConexion.Open();
                    OracleDataAdapter ComandoDA = null;
                    ComandoDA = new OracleDataAdapter("PK_EMPRESA.UPDATE_EMPRESA", objConexion);

                    ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

                    PRO.agrega_parametro_sp(ComandoDA, "id_empresa", OracleType.Int32, ParameterDirection.Input, R_EMP.ToString());

                    PRO.agrega_parametro_sp(ComandoDA, "rut_empresa", OracleType.Int32, ParameterDirection.Input, txtRutEmpresaE.Text);
                    PRO.agrega_parametro_sp(ComandoDA, "nombre", OracleType.NVarChar, ParameterDirection.Input, txtNombreEmpresaE.Text);
                    PRO.agrega_parametro_sp(ComandoDA, "mail", OracleType.NVarChar, ParameterDirection.Input, txtEmailEmpresaE.Text);
                    PRO.agrega_parametro_sp(ComandoDA, "cod_contratista", OracleType.Int32, ParameterDirection.Input, comboCodContratistaE.Items[comboCodContratistaE.SelectedIndex].Value);
            
                    try
                    {
                        

                        ComandoDA.SelectCommand.ExecuteNonQuery();
                        //lb_mensaje_edicion.Visible = true;
                        lbInformacion0.Text = "ACTUALIZACION REALIZADA SATISFACTORIAMENTE!";
                        lbAsci.Text = "♻  ";
                        //img_ok.Visible = true;
                        //desabilita_edicion(false);
                        //btn_actualiza.Enabled = false;
                        

                        //tbl_NuevoUser.Visible = false;
                        //Btn_newEDIT.Visible = true;
                        //Btn_newEDIT.Enabled = true;
                        //btnVolver.Visible = true;
                        //lb_minihead.Visible = false;

                        //*********************** INSERTAMOS LOG DEL SISTEMA ***********************************
                        try
                        {
                            string str_fecha = null;
                            string str_hora = null;
                            string str_desc_evento = null;
                            str_fecha = DateTime.Now.ToString().Substring(0, 10).Trim(' ');
                            //str_hora = DateTime.Now.ToString().Substring(10, 9).Trim(' ');
                        //    str_desc_evento = "SE HA ACTUALIZADO EL USUARIO CON ID_USUARIO=" + P_ID_User;
                        //    PRO.Insertamos_log_del_Sistema(lb_id_usuario.Text, LB_RUT_EMPRESA.Text, str_fecha, str_hora, str_desc_evento, "0", "0", Request.ServerVariables["REMOTE_ADDR"].ToString());
                        }
                        catch (Exception ex)
                        {
                            lbInformacion0.Text = "Error"+ex.ToString();

                        }
                        //**************************************************************************************


                    }
                    catch (Exception ex)
                    {
                        Response.Write("Mensaje de error .." +ex.ToString());
                    }


                }


    }
