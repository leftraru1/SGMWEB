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

public partial class ModificarEstatusLlaveRetirada : System.Web.UI.Page
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

            Llena_combo_empresas(XMLperfil, XMLEmpresa);
            //Llena_combo_perfiles(XMLperfil); //PASAR PARAMETRO SESSION TIPO DE PERFIL

            carga_llaver_porID();

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

    private void Llena_combo_empresas(string IDPerfil, string EMPRESA_USER)
    {

        string sql_empresas = null;
        DataTable dtEmpresas = new DataTable();
        sql_empresas = "select * from EMPRESA"; // Para rellenar combo
        OracleDataAdapter objComando_Empresa = null;
        objComando_Empresa = new OracleDataAdapter(sql_empresas, conexion_cliente_oracle);
        objComando_Empresa.Fill(dtEmpresas);
        string valueCombo = null;
        string textoCombo = null;
        combo_empresasE.Items.Clear();

        if (IDPerfil == "3")
        {
            foreach (DataRow drEmpresaItem in dtEmpresas.Rows)
            {
                valueCombo = drEmpresaItem["rut_empresa"].ToString();
                textoCombo = drEmpresaItem["nombre"].ToString();
                combo_empresasE.Items.Add(new ListItem(textoCombo, valueCombo));
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
                    combo_empresasE.Items.Add(new ListItem(textoCombo, valueCombo));
                }
            }
        }

    }


    public void carga_llaver_porID() 
    {
        string ID_LlaveR = Request.QueryString["idLlaveR"]; 


        string sSQL = null;
        OracleDataAdapter objComando = null;
        DataTable dtLlaver = new DataTable(); 
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        objConexion.Open();
        sSQL = "SELECT ESTATUS_LLAVE_RETIRADA.ID_LLR, ESTATUS_LLAVE_RETIRADA.COD_LLR, ESTATUS_LLAVE_RETIRADA.DESCRIPCION, ESTATUS_LLAVE_RETIRADA.RUT_EMPRESA, EMPRESA.NOMBRE FROM ESTATUS_LLAVE_RETIRADA " +
        "JOIN EMPRESA ON ESTATUS_LLAVE_RETIRADA.RUT_EMPRESA =EMPRESA.RUT_EMPRESA WHERE ESTATUS_LLAVE_RETIRADA.ID_LLR =" + ID_LlaveR; 
        //pasar consulta a SP

        objComando = new OracleDataAdapter(sSQL, conexion_cliente_oracle);
        objComando.Fill(dtLlaver);
        objConexion.Close();
        objConexion.Dispose();

        dt = new DataTable();
        dt.Columns.Add(new DataColumn("id_llr", typeof(string)));
        dt.Columns.Add(new DataColumn("cod_llr", typeof(string)));
        dt.Columns.Add(new DataColumn("descripcion", typeof(string)));
        dt.Columns.Add(new DataColumn("nombre", typeof(string)));



        DataRow dr = null;
        foreach (DataRow drLlaverItem in dtLlaver.Rows) 
        {
            dr = dt.NewRow();
            dr["id_llr"] = drLlaverItem["id_llr"].ToString();
            dr["cod_llr"] = drLlaverItem["cod_llr"].ToString();
            dr["descripcion"] = drLlaverItem["descripcion"].ToString();
            dr["nombre"] = drLlaverItem["nombre"].ToString();
            //dr["empresa"] = "empresa"; //drUsuarioItem("empresa").ToString 'Funcion que devuelva empresa

            dt.Rows.Add(dr);
        }

        txtCodigoLlaveE.Text = dt.Rows[0]["cod_llr"].ToString();
        txtDescripcionLlaveE.Text = dt.Rows[0]["descripcion"].ToString();
        combo_empresasE.SelectedValue = dt.Rows[0]["nombre"].ToString();




    }





    
    protected void btoVolver_Click(object sender, EventArgs e)
    {
        //carga_estatusllr(lb_rut_empresa.Text, lb_perfil_usuario.Text, lb_id_usuario.Text);

        //GrillaEstatusllaveRetirada.Visible = true;
        //tablaEstatusLlaveRetirada.Visible = false;
        //btnok_agregar0.Visible = true;
        LipmiarItems();

        Response.Redirect("MantencionEstatusLlaveRetirada.aspx");

    }

    public void LipmiarItems()
    {
        txtCodigoLlaveE.Text = " ";
        txtDescripcionLlaveE.Text = " ";
        lbInformacion0.Text = " ";
        lbAsci.Text = " ";
    }
    protected void btn_EditarEstatusLlR_Click(object sender, EventArgs e)
    {
        string ID_LLAVER = Request.QueryString["idLlaveR"]; 

        

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
                    ComandoDA = new OracleDataAdapter("PK_ESTATUS_LLAVER.UPDATE_ESTATUS_LLAVER", objConexion); 

                    ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

                        PRO.agrega_parametro_sp(ComandoDA, "i_id_llr", OracleType.Int32, ParameterDirection.Input, ID_LLAVER.ToString());
                        PRO.agrega_parametro_sp(ComandoDA, "i_cod_llr", OracleType.Int32, ParameterDirection.Input, txtCodigoLlaveE.Text);
                        PRO.agrega_parametro_sp(ComandoDA, "i_rut_empresa", OracleType.Int32, ParameterDirection.Input, combo_empresasE.Items[combo_empresasE.SelectedIndex].Value);
                        PRO.agrega_parametro_sp(ComandoDA, "i_descripcion", OracleType.NVarChar, ParameterDirection.Input, txtDescripcionLlaveE.Text);

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
                        Response.Write("Mensaje de error ..");
                    }


                }
                //else
                //{

                //    VALIDACION_RUT_USUARIO.Visible = true;
                //    VALIDACION_RUT_USUARIO.Text = msg_error_rut_perfil;

                //}

            //}
        //    else //ERROR - EXISTE NOMBRE DE USUARIO EN LA BASE DE DATOS
        //    {

        //        VALIDACION_RUT_USUARIO.Visible = true;
        //        VALIDACION_RUT_USUARIO.Text = str_nom_user;
        //        //Response.Write(str_nom_user)
        //    }

        //}
        //else //Si el formato del RUT es incorrecto
        //{

        //    VALIDACION_RUT_USUARIO.Visible = true;
        //    VALIDACION_RUT_USUARIO.Text = "EL FORMATO DEL RUT ES INCORRECTO!";

        //}
    //}

    //}
    }
