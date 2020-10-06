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



 partial class ModificarUsuario : System.Web.UI.Page
{
    private Procedimientos PRO = new Procedimientos();
    private string id_perfil;
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    public DataTable dt;

    protected void Page_Load(object sender, System.EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            bool valida = false;
            valida = valida_link();

            VALIDACION_RUT_USUARIO.Visible = false;
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

            LB_RUT_EMPRESA.Text = doc_xml.SelectSingleNode("SESSION/DATOS_USUARIO/RUT_EMPRESA").InnerText;
            LB_RUT_EMPRESA.Visible = false;

            lb_session_user.Text = ": " + session_user + " / ";
            lb_session_empresa.Text = ": " + session_empresa;

            Llena_combo_empresas(XMLperfil, XMLEmpresa);
            Llena_combo_perfiles(XMLperfil); //PASAR PARAMETRO SESSION TIPO DE PERFIL

            consulta_usuario_porID();
            lb_mensaje_edicion.Visible = false;
            img_ok.Visible = false;
            Btn_newEDIT.Enabled = false;

        }
    }

    public void consulta_usuario_porID()
    {
        string ID_User = Request.QueryString["iduser"];

        string sSQL = null;
        OracleDataAdapter objComando = null;
        DataTable dtUsuarios = new DataTable();
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        objConexion.Open();
        sSQL = "SELECT USUARIO.ID_USUARIO, USUARIO.RUT_EMPRESA,USUARIO.USUARIO,USUARIO.PASSWORD, " + 
               "USUARIO.ID_PERFIL, USUARIO.RUT, USUARIO.NOMBRE, USUARIO.APELLIDO, USUARIO.ESTADO, USUARIO.MULTI_EMPRESA, " +
               "EMPRESA.NOMBRE, PERFIL.DESCRIPCION, USUARIO.CORREO, USUARIO.DIAS_VENCIMIENTO " + 
               "FROM USUARIO JOIN EMPRESA ON USUARIO.RUT_EMPRESA=EMPRESA.RUT_EMPRESA JOIN PERFIL ON PERFIL.ID_PERFIL=USUARIO.ID_PERFIL WHERE USUARIO.ID_USUARIO= " + ID_User;


        objComando = new OracleDataAdapter(sSQL, conexion_cliente_oracle);
        objComando.Fill(dtUsuarios);
        objConexion.Close();
        objConexion.Dispose();

        dt = new DataTable();
        dt.Columns.Add(new DataColumn("id_usuario", typeof(string)));
        dt.Columns.Add(new DataColumn("rut_empresa", typeof(string)));
        dt.Columns.Add(new DataColumn("usuario", typeof(string)));
        dt.Columns.Add(new DataColumn("password", typeof(string)));
        dt.Columns.Add(new DataColumn("rut", typeof(string)));
        dt.Columns.Add(new DataColumn("nombre", typeof(string)));
        dt.Columns.Add(new DataColumn("apellido",typeof(string)));
        dt.Columns.Add(new DataColumn("empresa", typeof(string)));
        dt.Columns.Add(new DataColumn("id_perfil", typeof(string)));
        dt.Columns.Add(new DataColumn("perfil", typeof(string)));
        dt.Columns.Add(new DataColumn("estado", typeof(string)));
        dt.Columns.Add(new DataColumn("correo", typeof(string)));
        dt.Columns.Add(new DataColumn("dias_vencimiento", typeof(string)));


        DataRow dr = null;
        foreach (DataRow drUsuarioItem in dtUsuarios.Rows)
        {
            dr = dt.NewRow();
            dr["id_usuario"] = drUsuarioItem["id_usuario"].ToString();
            dr["usuario"] = drUsuarioItem["usuario"].ToString();
            dr["password"] = drUsuarioItem["password"].ToString();
            dr["rut"] = drUsuarioItem["rut"].ToString();
            dr["nombre"] = drUsuarioItem["nombre"].ToString();
            dr["apellido"] = drUsuarioItem["apellido"].ToString();
            dr["rut_empresa"] = drUsuarioItem["rut_empresa"].ToString();
            dr["empresa"] = "empresa"; //drUsuarioItem("empresa").ToString 'Funcion que devuelva empresa
            dr["id_perfil"] = drUsuarioItem["id_perfil"].ToString();
            dr["perfil"] = "perfil"; //drUsuarioItem("perfil").ToString 'Funcion que devuelva perfil
            dr["estado"] = drUsuarioItem["estado"].ToString();
            dr["correo"] = drUsuarioItem["correo"].ToString();
            dr["dias_vencimiento"] = drUsuarioItem["dias_vencimiento"].ToString();
            dt.Rows.Add(dr);
        }

        txt_nombre.Value = dt.Rows[0]["nombre"].ToString();
        txt_apellido.Value = dt.Rows[0]["apellido"].ToString();
        txt_login.Text = dt.Rows[0]["usuario"].ToString();
        txt_pass.Attributes.Add("Value", dt.Rows[0]["password"].ToString());
        combo_multiempresa.SelectedValue = dtUsuarios.Rows[0]["multi_empresa"].ToString();
        combo_empresas.SelectedValue = dtUsuarios.Rows[0]["rut_empresa"].ToString();
        combo_perfiles.SelectedValue = dtUsuarios.Rows[0]["id_perfil"].ToString();
        txtCorreo.Text = dt.Rows[0]["correo"].ToString();
        txtDias.Text = dt.Rows[0]["dias_vencimiento"].ToString();


        string[] arr_RUT = null;
        arr_RUT = new string[3];
        //Obtemos el rut y el Dig. Verificador.
        arr_RUT = dt.Rows[0]["rut"].ToString().Split('-');
        txt_rut.Text = arr_RUT[0];
        txt_dv.Text = arr_RUT[1];

        if (dtUsuarios.Rows[0]["estado"].ToString() == "0")
        {

            chEstado.Checked = true;

        }
        else
        {

            chEstado.Checked = false;

        }
    }

    protected void btnVolver_Click(object sender, System.EventArgs e)
    {
        Response.Redirect("MantencionUsuarios.aspx");
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

    private void Llena_combo_perfiles(string ID_Perfil)
    {

        string sql_perfiles = null;
        DataTable dtPerfiles = new DataTable();
        sql_perfiles = "select * from PERFIL"; // Para rellenar combo
        OracleDataAdapter objComando_Perfil = null;
        objComando_Perfil = new OracleDataAdapter(sql_perfiles, conexion_cliente_oracle);
        objComando_Perfil.Fill(dtPerfiles);
        string valueCombo = null;
        string textoCombo = null;
        combo_perfiles.Items.Clear();

        foreach (DataRow drPerfilItem in dtPerfiles.Rows)
        {
            valueCombo = drPerfilItem["id_perfil"].ToString();
            textoCombo = drPerfilItem["descripcion"].ToString();
            combo_perfiles.Items.Add(new ListItem(textoCombo, valueCombo));
        }

        //if (ID_Perfil == "1")
        //{
        //    foreach (DataRow drPerfilItem in dtPerfiles.Rows)
        //    {
        //        valueCombo = drPerfilItem["id_perfil"].ToString();
        //        textoCombo = drPerfilItem["descripcion"].ToString();
        //        combo_perfiles.Items.Add(new ListItem(textoCombo, valueCombo));
        //    }

        //}
        //else
        //{

        //    foreach (DataRow drPerfilItem in dtPerfiles.Rows)
        //    {
        //        if ((drPerfilItem["id_perfil"].ToString() != "3") && (drPerfilItem["id_perfil"].ToString() != "1")) //Ingresa solo contratistas
        //        {
        //            valueCombo = drPerfilItem["id_perfil"].ToString();
        //            textoCombo = drPerfilItem["descripcion"].ToString();
        //            combo_perfiles.Items.Add(new ListItem(textoCombo, valueCombo));
        //        }
        //    }

        //}

        //If ID_Perfil = "1" Then 'Usuario Administrador Empresa
        //    For Each drPerfilItem As Data.DataRow In dtPerfiles.Rows
        //        If ((drPerfilItem("id_perfil").ToString <> "3") And (drPerfilItem("id_perfil").ToString <> "1")) Then 'Ingresa solo contratistas 
        //            valueCombo = drPerfilItem("id_perfil").ToString
        //            textoCombo = drPerfilItem("descripcion").ToString
        //            combo_perfiles.Items.Add(New ListItem(textoCombo, valueCombo))
        //        End If
        //    Next
        //End If

    }


    public string validadacion_Nombre_Usuario(string P_NOMBRE_USUARIO, string P_ID_USUARIO)
    {
        string tempvalidadacion_Nombre_Usuario = null;

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_USUARIO.VALIDA_USUARIO_EXISTE_UPDATE", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_usuario", OracleType.NVarChar, ParameterDirection.Input, P_NOMBRE_USUARIO);
        PRO.agrega_parametro_sp(da, "i_id_usuario", OracleType.Int32, ParameterDirection.Input, P_ID_USUARIO);

        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        CnOra.Open();
        DataSet dsUsuarios = new DataSet();
        da.Fill(dsUsuarios, "ASIGNACIONES");

        if (dsUsuarios.Tables["ASIGNACIONES"].Rows.Count != 0)
        {
            tempvalidadacion_Nombre_Usuario = "Nombre de Usuario Existe en la Base de Datos! Elija Otro.";
        }
        else
        {
            tempvalidadacion_Nombre_Usuario = "OK";
        }

        return tempvalidadacion_Nombre_Usuario;
    }


    protected void btn_actualiza_Click(object sender, System.EventArgs e)
    {
        string ID_User_UPDATE = Request.QueryString["iduser"];

        string estado = null;

        if (chEstado.Checked == true)
        {

            estado = "0";

        }
        else
        {

            estado = "1";

        }

        if (formato_rut() == true)
        {

            VALIDACION_RUT_USUARIO.Visible = false;
            //SE VALIDA QUE NO EXISTA NOMBRE DE USUARIO
            string str_nom_user = null;
            str_nom_user = validadacion_Nombre_Usuario(txt_login.Text, ID_User_UPDATE);

            if (str_nom_user == "OK")
            {


                VALIDACION_RUT_USUARIO.Visible = false;
                string concat_rut_user = null;
                string msg_error_rut_perfil = null;
                concat_rut_user = txt_rut.Text.Trim(' ') + "-" + txt_dv.Text.Trim(' ');
                string P_ID_User = Request.QueryString["iduser"];
                msg_error_rut_perfil = validadacion_RUT_PERFIL(P_ID_User, Convert.ToString(combo_perfiles.Items[combo_perfiles.SelectedIndex].Value).Trim(' '), concat_rut_user);


                if (msg_error_rut_perfil == "OK")
                {


                    VALIDACION_RUT_USUARIO.Visible = false;


                    OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
                    objConexion.Open();
                    OracleDataAdapter ComandoDA = null;
                    ComandoDA = new OracleDataAdapter("PK_USUARIO.UPDATE_USUARIOS", objConexion);

                    ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

                    PRO.agrega_parametro_sp(ComandoDA, "i_id_usuario", OracleType.Int32, ParameterDirection.Input, ID_User_UPDATE.ToString());
                    PRO.agrega_parametro_sp(ComandoDA, "i_rut_empresa", OracleType.Int32, ParameterDirection.Input, combo_empresas.Items[combo_empresas.SelectedIndex].Value);
                    PRO.agrega_parametro_sp(ComandoDA, "i_usuario", OracleType.NVarChar, ParameterDirection.Input, txt_login.Text);
                    PRO.agrega_parametro_sp(ComandoDA, "i_password", OracleType.NVarChar, ParameterDirection.Input, txt_pass.Text);
                    PRO.agrega_parametro_sp(ComandoDA, "i_id_perfil", OracleType.Int32, ParameterDirection.Input, combo_perfiles.Items[combo_perfiles.SelectedIndex].Value);
                    PRO.agrega_parametro_sp(ComandoDA, "i_rut", OracleType.NVarChar, ParameterDirection.Input, txt_rut.Text + "-" + txt_dv.Text);
                    PRO.agrega_parametro_sp(ComandoDA, "i_nombre", OracleType.NVarChar, ParameterDirection.Input, txt_nombre.Value);
                    PRO.agrega_parametro_sp(ComandoDA, "i_apellido", OracleType.NVarChar, ParameterDirection.Input, txt_apellido.Value);
                    PRO.agrega_parametro_sp(ComandoDA, "i_estado", OracleType.Int32, ParameterDirection.Input, estado);
                    PRO.agrega_parametro_sp(ComandoDA, "i_multiempresa", OracleType.Int32, ParameterDirection.Input, combo_multiempresa.Items[combo_multiempresa.SelectedIndex].Value);
                    PRO.agrega_parametro_sp(ComandoDA, "i_dias", OracleType.NVarChar, ParameterDirection.Input, txtDias.Text);
                    PRO.agrega_parametro_sp(ComandoDA, "i_correo", OracleType.NVarChar, ParameterDirection.Input, txtCorreo.Text);

                    try
                    {
                        ComandoDA.SelectCommand.ExecuteNonQuery();
                        lb_mensaje_edicion.Visible = true;
                        lb_mensaje_edicion.Text = "ACTUALIZACION REALIZADA SATISFACTORIAMENTE!";
                        img_ok.Visible = true;
                        desabilita_edicion(false);
                        btn_actualiza.Enabled = false;
                        

                        tbl_NuevoUser.Visible = false;
                        Btn_newEDIT.Visible = true;
                        Btn_newEDIT.Enabled = true;
                        btnVolver.Visible = true;
                        lb_minihead.Visible = false;

                        //*********************** INSERTAMOS LOG DEL SISTEMA ***********************************
                        try
                        {
                            string str_fecha = null;
                            string str_hora = null;
                            string str_desc_evento = null;
                            str_fecha = DateTime.Now.ToString().Substring(0, 10).Trim(' ');
                            str_hora = DateTime.Now.ToString().Substring(10, 9).Trim(' ');
                            str_desc_evento = "SE HA ACTUALIZADO EL USUARIO CON ID_USUARIO=" + P_ID_User;
                            PRO.Insertamos_log_del_Sistema(lb_id_usuario.Text, LB_RUT_EMPRESA.Text, str_fecha, str_hora, str_desc_evento, "0", "0", Request.ServerVariables["REMOTE_ADDR"].ToString());
                        }
                        catch (Exception ex)
                        {
                        }
                        //**************************************************************************************


                    }
                    catch (Exception ex)
                    {
                        Response.Write("Mensaje de error de Ingreso Nuevo Usuario..");
                    }


                }
                else
                {

                    VALIDACION_RUT_USUARIO.Visible = true;
                    VALIDACION_RUT_USUARIO.Text = msg_error_rut_perfil;

                }

            }
            else //ERROR - EXISTE NOMBRE DE USUARIO EN LA BASE DE DATOS
            {

                VALIDACION_RUT_USUARIO.Visible = true;
                VALIDACION_RUT_USUARIO.Text = str_nom_user;
                //Response.Write(str_nom_user)
            }

        }
        else //Si el formato del RUT es incorrecto
        {

            VALIDACION_RUT_USUARIO.Visible = true;
            VALIDACION_RUT_USUARIO.Text = "EL FORMATO DEL RUT ES INCORRECTO!";

        }
    }

    public string validadacion_RUT_PERFIL(string P_ID_USUARIO, string P_ID_PERFIL, string P_RUT_USUARIO)
    {
        string tempvalidadacion_RUT_PERFIL = null;

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_USUARIO.VALIDA_RUT_PERFIL_MOD", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_id_usuario", OracleType.Int32, ParameterDirection.Input, P_ID_USUARIO);
        PRO.agrega_parametro_sp(da, "i_id_perfil", OracleType.Int32, ParameterDirection.Input, P_ID_PERFIL);
        PRO.agrega_parametro_sp(da, "i_rut", OracleType.NVarChar, ParameterDirection.Input, P_RUT_USUARIO);

        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        CnOra.Open();
        DataSet dsUsuarios = new DataSet();
        da.Fill(dsUsuarios, "ASIGNACIONES");
        CnOra.Close();
        CnOra.Dispose();

        if (dsUsuarios.Tables["ASIGNACIONES"].Rows.Count > 0)
        {
            //Response.Write("<script>")
            //Response.Write("alert('Eliminación Denegada, Lector tiene asignaciones relacionadas!');")
            //Response.Write("</script>")
            //Response.Write("Nombre de Usuario Existe en la Base de Datos! Elija Otro.")
            tempvalidadacion_RUT_PERFIL = "EL RUT DE USUARIO YA EXISTE PARA ESTE PERFIL!";
        }
        else
        {
            //Response.Write("<script>")
            //Response.Write("if (confirm('Mensaje de confirmación !  \n \n Esta seguro que desea eliminar el registro del Lector Seleccionado ?')) { document.location.href='EliminarLector.aspx?idlector=" & GrillaLectores.Items(indice).Cells(0).Text & "'; }")
            //Response.Write("</script>")
            tempvalidadacion_RUT_PERFIL = "OK";
        }

        return tempvalidadacion_RUT_PERFIL;
    }

    public void desabilita_edicion(bool c_estado)
    {

        txt_nombre.Disabled = !(c_estado);
        txt_rut.Enabled = c_estado;
        txt_dv.Enabled = c_estado;
        txt_login.Enabled = c_estado;
        txt_pass.Enabled = c_estado;
        combo_empresas.Enabled = c_estado;
        combo_perfiles.Enabled = c_estado;

    }

    protected void Btn_newEDIT_Click(object sender, System.EventArgs e)
    {
        lb_mensaje_edicion.Visible = false;
        img_ok.Visible = false;
        desabilita_edicion(true);
        Btn_newEDIT.Enabled = false;
        btn_actualiza.Enabled = true;
        tbl_NuevoUser.Visible = true;


    }

    public bool formato_rut()
    {
        bool tempformato_rut = false;

        //VALIDAR RUT
        int i = 0;
        //Dim X As Integer
        int total = 0;
        int totaltotal = 0;
        int por = 0;
        int rut = 0;
        int guion = 0;
        //Dim nrut As Integer
        int posicion = 0;
        int valor = 0;
        bool verdad = false;

        if (txt_dv.Text == "k")
        {
            txt_dv.Text = "K";
        }

        i = 1;
        total = 0;
        totaltotal = 0;

        rut = txt_rut.Text.Length;
        posicion = rut;
        por = 2;


        //RECORRER EL R.U.T.
        for (i = 1; i <= rut; i++)
        {

            if (por == 8)
            {
                por = 2;
            }

            total = Convert.ToInt32(por * Simulate.Val(txt_rut.Text.Substring(posicion - 1, 1)));
            posicion = posicion - 1;
            totaltotal = totaltotal + total;
            por = por + 1;
        }

        valor = totaltotal % 11;
        guion = Convert.ToInt32(Math.Floor((double)(11 - valor)));
        if (guion == Simulate.Val(txt_dv.Text.Substring(0, 1)) || guion == 10 && (txt_dv.Text.Substring(0, 1)) == "K" || guion == 11 && (txt_dv.Text.Substring(0, 1)) == "0" || guion == 10 && (txt_dv.Text.Substring(0, 1)) == "K")
        {
            verdad = true;
            tempformato_rut = verdad;
            //If MsgBox("Rut valido ¿Desea Ingresar otro?", vbQuestion + vbYesNo, "Ingresar Otro") = vbYes Then
            //    txt_rut.Text = ""
            //    txt_dv.Text = ""

            //Else

            //End If
        }
        else
        {
            //MsgBox(" El R.U.T. ingresado NO es Valido", vbCritical, "Error.....")
            verdad = false;
            tempformato_rut = verdad;
            //Response.Write("<script>")
            //Response.Write("alert('El formato del RUT es incorrecto!');")
            //Response.Write("</script>")
            //txt_rut.Text = ""
            txt_rut.Focus();

        }

        return tempformato_rut;
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
        LB_RUT_EMPRESA.Text = recupera_xml.SelectSingleNode("SESSION/DATOS_USUARIO/RUT_EMPRESA").InnerText;
        lb_id_usuario.Text = recupera_xml.SelectSingleNode("SESSION/DATOS_USUARIO/ID_USUARIO").InnerText;
        id_perfil = recupera_xml.SelectSingleNode("SESSION/DATOS_USUARIO/ID_PERFIL").InnerText;
        lb_session_user.Text = ": " + session_user + " / ";

        lb_session_empresa.Text = ": " + session_empresa;


    }


    override protected void OnInit(EventArgs e)
    {
        base.OnInit(e);

        //INSTANT C# NOTE: Converted event handler wireups:
        this.Load += Page_Load;
        btnVolver.Click += btnVolver_Click;
        btn_actualiza.Click += btn_actualiza_Click;
        Btn_newEDIT.Click += Btn_newEDIT_Click;
    }
   
}

//----------------------------------------------------------------------------------------
//	Copyright © 2003 - 2014 Tangible Software Solutions Inc.
//	This class can be used by anyone provided that the copyright notice remains intact.
//
//	This class simulates the behavior of the classic VB 'Val' function.
//----------------------------------------------------------------------------------------
public static partial class Simulate
{
    public static double Val(string expression)
    {
        if (expression == null)
            return 0;

        //try the entire string, then progressively smaller
        //substrings to simulate the behavior of VB's 'Val',
        //which ignores trailing characters after a recognizable value:
        for (int size = expression.Length; size > 0; size--)
        {
            double testDouble;
            if (double.TryParse(expression.Substring(0, size), out testDouble))
                return testDouble;
        }

        //no value is recognized, so return 0:
        return 0;
    }
    public static double Val(object expression)
    {
        if (expression == null)
            return 0;

        double testDouble;
        if (double.TryParse(expression.ToString(), out testDouble))
            return testDouble;

        //VB's 'Val' function returns -1 for 'true':
        bool testBool;
        if (bool.TryParse(expression.ToString(), out testBool))
            return testBool ? -1 : 0;

        //VB's 'Val' function returns the day of the month for dates:
        System.DateTime testDate;
        if (System.DateTime.TryParse(expression.ToString(), out testDate))
            return testDate.Day;

        //no value is recognized, so return 0:
        return 0;
    }
    public static int Val(char expression)
    {
        int testInt;
        if (int.TryParse(expression.ToString(), out testInt))
            return testInt;
        else
            return 0;
    }
}