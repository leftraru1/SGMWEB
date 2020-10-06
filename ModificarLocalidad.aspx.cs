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

public partial class ModificarLocalidad : System.Web.UI.Page
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
            Llena_combo_zona(XMLperfil, Session[Session.SessionID + "_Empresa"].ToString());

            //Llena_combo_perfiles(XMLperfil); //PASAR PARAMETRO SESSION TIPO DE PERFIL

            carga_localidad_porID();

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

    private void Llena_combo_zona(string IDPerfil, string EMPRESA_USER)
    {

        string sql_zona;
        DataTable dtZonas = new DataTable();
        sql_zona = "select * from ZONA"; // Para rellenar combo  
        OracleDataAdapter objComando_Zona;
        objComando_Zona = new OracleDataAdapter(sql_zona, conexion_cliente_oracle);
        objComando_Zona.Fill(dtZonas);
        string valueCombo, textoCombo;
        combo_zonaE.Items.Clear();

        if (IDPerfil == "3") 
        {
            foreach (DataRow drZonas in dtZonas.Rows)
            {
                valueCombo = drZonas["id_zona"].ToString();
                textoCombo = drZonas["nombre"].ToString();
                combo_zonaE.Items.Add(new ListItem(textoCombo, valueCombo));
            }
        }

        if (IDPerfil == "1")
        {
            foreach (DataRow drZonasItem in dtZonas.Rows)
            {
                if (EMPRESA_USER == drZonasItem["nombre"].ToString())
                {
                    valueCombo = drZonasItem["id_zona"].ToString();
                    textoCombo = drZonasItem["nombre"].ToString();
                    combo_zonaE.Items.Add(new ListItem(textoCombo, valueCombo));
                }
            }
        }

    }


    public void carga_localidad_porID()   
    {
        string ID_Localidad = Request.QueryString["idLocalidad"]; 


        string sSQL = null;
        OracleDataAdapter objComando = null;
        DataTable dtLocalidad = new DataTable(); 
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        objConexion.Open();
        sSQL = " SELECT LOCALIDAD.ID_LOCALIDAD, LOCALIDAD.ID_ZONA, LOCALIDAD.RUT_EMPRESA, LOCALIDAD.COD_LOCALIDAD, LOCALIDAD.NOMBRE, EMPRESA.NOMBRE, ZONA.NOMBRE " +
       "FROM LOCALIDAD JOIN EMPRESA ON LOCALIDAD.RUT_EMPRESA= EMPRESA.RUT_EMPRESA JOIN ZONA ON LOCALIDAD.ID_ZONA= ZONA.ID_ZONA WHERE LOCALIDAD.ID_LOCALIDAD =" + ID_Localidad;
        //pasar consulta a SP

        objComando = new OracleDataAdapter(sSQL, conexion_cliente_oracle);
        objComando.Fill(dtLocalidad); 
        objConexion.Close();
        objConexion.Dispose();

        dt = new DataTable();
        dt.Columns.Add(new DataColumn("id_localidad", typeof(string)));
        dt.Columns.Add(new DataColumn("id_zona", typeof(string)));
        dt.Columns.Add(new DataColumn("rut_empresa", typeof(string)));
        dt.Columns.Add(new DataColumn("cod_localidad", typeof(string)));
        dt.Columns.Add(new DataColumn("nombre", typeof(string)));



        DataRow dr = null;
        foreach (DataRow drLocalidadItem in dtLocalidad.Rows) 
        {
            dr = dt.NewRow();
            dr["id_localidad"] = drLocalidadItem["id_localidad"].ToString();
            dr["id_zona"] = drLocalidadItem["id_zona"].ToString();
            dr["rut_empresa"] = drLocalidadItem["rut_empresa"].ToString();
            dr["cod_localidad"] = drLocalidadItem["cod_localidad"].ToString();
            dr["nombre"] = drLocalidadItem["nombre"].ToString();
            //dr["empresa"] = "empresa"; //drUsuarioItem("empresa").ToString 'Funcion que devuelva empresa

            dt.Rows.Add(dr);
        }

        txtNombreLocalidadE.Text = dt.Rows[0]["nombre"].ToString();
        txtCodigoLocalidadE.Text = dt.Rows[0]["cod_localidad"].ToString();
        combo_empresasE.SelectedValue = dt.Rows[0]["rut_empresa"].ToString();
        combo_zonaE.SelectedValue = dt.Rows[0]["id_zona"].ToString();

        

    }





    protected void btoVolver_Click(object sender, EventArgs e)
    {
        Response.Redirect("MantencionLocalidad.aspx");
    }
    protected void btoEditarLocaclidad_Click(object sender, EventArgs e)
    {
        string ID_Localidad = Request.QueryString["idLocalidad"];    

       

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
                    ComandoDA = new OracleDataAdapter("PK_LOCALIDAD.UPDATE_LOCALIDAD", objConexion); 

                    ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

                        PRO.agrega_parametro_sp(ComandoDA, "i_id_localidad", OracleType.Int32, ParameterDirection.Input, ID_Localidad.ToString());
                        PRO.agrega_parametro_sp(ComandoDA, "i_id_zona", OracleType.Int32, ParameterDirection.Input, combo_zonaE.Items[combo_zonaE.SelectedIndex].Value);
                        PRO.agrega_parametro_sp(ComandoDA, "i_rut_empresa", OracleType.Int32, ParameterDirection.Input, combo_empresasE.Items[combo_empresasE.SelectedIndex].Value);
                        PRO.agrega_parametro_sp(ComandoDA, "i_cod_localidad", OracleType.Int32, ParameterDirection.Input, txtCodigoLocalidadE.Text);
                        PRO.agrega_parametro_sp(ComandoDA, "i_nombre", OracleType.NVarChar, ParameterDirection.Input, txtNombreLocalidadE.Text);

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
                        Response.Write("Mensaje de error de Ingreso Nuevo Usuario..");
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







