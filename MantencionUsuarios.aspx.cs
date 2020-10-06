﻿//---------------------------------------------------------
//TODO: Copiar estas asignaciones de evento en el constructor:
// después de InitializeComponents.
// Comprobar que los delegados usados son los correctos.
//---------------------------------------------------------
/*
GrillaUsuarios.DeleteCommand += new DataGridCommandEventHandler(cmEstado);
Me.Load += new System.EventHandler(Page_Load);
GrillaUsuarios.EditCommand += new DataGridCommandEventHandler(MyDataGrid_Edit);
lkb_Agregar.Click += new System.EventHandler(lkb_Agregar_Click);
Btn_Cancelar.Click += new System.EventHandler(Btn_Cancelar_Click);
btnVolver.Click += new System.EventHandler(btnVolver_Click);
btn_agregaUser.Click += new System.EventHandler(btn_agregaUser_Click);
btnVolverPrin.Click += new System.EventHandler(btnVolverPrin_Click);
btnok_agregar.Click += new System.EventHandler(btnok_agregar_Click);
btnvolver_agregar.Click += new System.EventHandler(btnvolver_agregar_Click);
*/
//---------------------------------------------------------
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

partial class MantencionUsuarios : System.Web.UI.Page
{

    string id_perfil;
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();
    public DataTable dt;

    internal void inicializa_pagina()
    {
        GrillaUsuarios.Visible = true;
        tbl_NuevoUser.Visible = false;
        img_ok.Visible = false;
        lb_mensaje_ingreso.Visible = false;
        btnok_agregar.Visible = false;
        //btnvolver_agregar.Visible = false;
    }

    internal void carga_usuarios(string RutDeEmpresa, string PerfilDeUsuario, string ID_DE_Usuario)
    {

        OracleDataAdapter da;
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
    //    if (PerfilDeUsuario == "3")
          if (PerfilDeUsuario == "3" || PerfilDeUsuario == "15")
        {
            OracleCommand cmdAcceso = new OracleCommand("PK_USUARIO.LISTAR_USUARIOS", CnOra);
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
        DataTable dtUsuarios = new DataTable();
        da.Fill(dtUsuarios);
        CnOra.Close();
        CnOra.Dispose();

        dt = new DataTable();
        dt.Columns.Add(new DataColumn("id_usuario", typeof(string)));
        dt.Columns.Add(new DataColumn("usuario", typeof(string)));
        dt.Columns.Add(new DataColumn("nombre", typeof(string)));
        dt.Columns.Add(new DataColumn("rut_empresa", typeof(string)));
        dt.Columns.Add(new DataColumn("empresa", typeof(string)));
        dt.Columns.Add(new DataColumn("id_perfil", typeof(string)));
        dt.Columns.Add(new DataColumn("perfil", typeof(string)));
        dt.Columns.Add(new DataColumn("estado", typeof(string)));

        DataRow dr;
        int cont_registros;
        cont_registros = 0;
        foreach (DataRow drUsuarioItem in dtUsuarios.Rows)
        {
            dr = dt.NewRow();
            dr["id_usuario"] = drUsuarioItem["id_usuario"].ToString();
            dr["usuario"] = drUsuarioItem["usuario"].ToString();
            dr["nombre"] = drUsuarioItem["nombre"].ToString();
            dr["rut_empresa"] = drUsuarioItem["rut_empresa"].ToString();
            dr["empresa"] = PRO.OBTIENE_NOMBRE_EMPRESA(drUsuarioItem["rut_empresa"].ToString()); //[ª0002ª] 'TOMAR RUT de Empresa y funcion devuelva nombre 'nombre_empresa '[ª0003ª] 'drUsuarioItem([ª0004ª]).ToString 'Funcion que devuelva empresa
            dr["id_perfil"] = drUsuarioItem["id_perfil"].ToString();
            dr["perfil"] = PRO.OBTIENE_NOMBRE_PERFIL(drUsuarioItem["id_perfil"].ToString()); //[ª0002ª] 'drUsuarioItem([ª0003ª]).ToString 'Funcion que devuelva perfil

            if (drUsuarioItem["estado"].ToString() == "0")
            {

                dr["estado"] = "HABILITADO";


            }
            else
            {

                dr["estado"] = "DESHABILITADO";

            }

            dt.Rows.Add(dr);
            cont_registros = cont_registros + 1;

        }




        lb_cantidad_registros.Text = cont_registros.ToString() + " coincidencia(s) encontrada(s)";
        DataView MydataView;
        MydataView = new DataView(dt);
        GrillaUsuarios.DataSource = MydataView;
        GrillaUsuarios.DataBind();

        int er;
        for (er = 0; er < GrillaUsuarios.Items.Count; er++)
        {

            if (GrillaUsuarios.Items[er].Cells[7].Text == "HABILITADO")
            {

                GrillaUsuarios.Items[er].Cells[7].BackColor = Color.LightGreen;

            }
            else
            {

                GrillaUsuarios.Items[er].Cells[7].BackColor = Color.Red;

            }



        }

    }

    internal void cmEstado(object Sender, DataGridCommandEventArgs e)
    {
        string indice;
        indice = e.Item.ItemIndex.ToString();

        Response.Write("<script>");
        Response.Write(@"if (confirm('Mensaje de confirmación !  \n \n Esta seguro que desea Deshabilitar el registro del Usuario Seleccionado ?')) { document.location.href='EliminarUsuario.aspx?iduser=" + GrillaUsuarios.Items[Int32.Parse(indice)].Cells[0].Text + "&estado=" + GrillaUsuarios.Items[Int32.Parse(indice)].Cells[7].Text + "'; }");
        Response.Write("</script>");

    }

    protected void Page_Load(object sender, System.EventArgs e)
    {

        if (!Page.IsPostBack)
        {

            lb_id_usuario.Visible = false;
            VALIDACION_RUT_USUARIO.Visible = false;

            XmlDataDocument doc_xml = new XmlDataDocument();
            bool valida;
            valida = valida_link();

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
            inicializa_pagina();
            carga_usuarios(lb_rut_empresa.Text, lb_perfil_usuario.Text, lb_id_usuario.Text);
            Llena_combo_empresas(XMLperfil, Session[Session.SessionID + "_Empresa"].ToString());
            Llena_combo_perfiles(XMLperfil); //PASAR PARAMETRO SESSION TIPO DE PERFIL
        }

    }

    internal void MyDataGrid_Edit(object sender, DataGridCommandEventArgs e)
    {
        string indice;
        indice = e.Item.ItemIndex.ToString();
        Response.Redirect("ModificarUsuario.aspx?iduser=" + (GrillaUsuarios.Items[Int32.Parse(indice)].Cells[0].Text));
        Response.End();
        
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


    internal void cmDelete(object Sender, DataGridCommandEventArgs e)
    {

        string indice;
        indice = e.Item.ItemIndex.ToString();
        Response.Write("<script>");
        Response.Write(@"if (confirm('Mensaje de confirmación !  \n \n Esta seguro que desea eliminar el registro de Usuario ?')) { document.location.href='EliminarUsuario.aspx?iduser=" + GrillaUsuarios.Items[Int32.Parse(indice)].Cells[0].Text + "'; }");
        Response.Write("</script>");

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

    private void Llena_combo_perfiles(string ID_Perfil)
    {

        string sql_perfiles;
        DataTable dtPerfiles = new DataTable();
        sql_perfiles = "select * from PERFIL"; // Para rellenar combo
        OracleDataAdapter objComando_Perfil;
        objComando_Perfil = new OracleDataAdapter(sql_perfiles, conexion_cliente_oracle);
        objComando_Perfil.Fill(dtPerfiles);
        string valueCombo, textoCombo;
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
        //        if ((drPerfilItem["id_perfil"].ToString() != "3") & (drPerfilItem["id_perfil"].ToString() != "1"))
        //        {
        //            valueCombo = drPerfilItem["id_perfil"].ToString();
        //            textoCombo = drPerfilItem["descripcion"].ToString();
        //            combo_perfiles.Items.Add(new ListItem(textoCombo, valueCombo));
        //        }
        //    }

        //}

        //If ID_Perfil <> "3" Then

        //    For Each drPerfilItem As Data.DataRow In dtPerfiles.Rows
        //        If (drPerfilItem("id_perfil").ToString <> "3") And (drPerfilItem("id_perfil").ToString <> "1") Then
        //            valueCombo = drPerfilItem("id_perfil").ToString
        //            textoCombo = drPerfilItem("descripcion").ToString
        //            combo_perfiles.Items.Add(New ListItem(textoCombo, valueCombo))
        //        End If
        //    Next

        //End If

    }
    internal void LIMPIA_DATOS_USUARIO()
    {
        txt_nombre.Value = "";
        txt_login.Text = "";
        txt_pass.Text = "";
        txt_rut.Text = "";
        txt_dv.Text = "";
    }
    protected void lkb_Agregar_Click(object sender, System.EventArgs e)
    {
        //COLOCAR ESTOS VALORES EN PROCEDIMIENTO
        LIMPIA_DATOS_USUARIO();
        //GrillaUsuarios.Visible = false;
        //tbl_NuevoUser.Visible = true;
        //titulo_mod.InnerText = "Ingreso de Usuario Nuevo";
        //lb_minihead.Text = "Por favor, ingrese datos del usuario:";
        //lkb_Agregar.Visible = false;
        //lb_cantidad_registros.Visible = false;


        GrillaUsuarios.Visible = false;
        tbl_NuevoUser.Visible = true;
        img_ok.Visible = false;
        lb_mensaje_ingreso.Visible = false;
        btnok_agregar.Visible = false;
        //btnvolver_agregar.Visible = true;
        lkb_Agregar.Visible = false;
        lb_cantidad_registros.Visible = false;
        lb_minihead.Text = "Por favor, ingrese datos del usuario:";
        titulo_mod.InnerText = "Ingreso de Usuario Nuevo";
        





        //Btnbusqueda.Visible = False
    }

    protected void Btn_Cancelar_Click(object sender, System.EventArgs e)
    {
        LIMPIA_DATOS_USUARIO();
        GrillaUsuarios.Visible = true;
        tbl_NuevoUser.Visible = false;
        lb_mensaje_ingreso.Visible = false;
        img_ok.Visible = false;
        titulo_mod.InnerText = "Mantenimiento de Usuarios";
        lb_minihead.Text = "Por favor, seleccione la acción a realizar:";
        lkb_Agregar.Visible = true;
        lb_cantidad_registros.Visible = true;
        Response.Redirect("MantencionUsuarios.aspx");
        //Btnbusqueda.Visible = True
    }

    protected void btnVolver_Click(object sender, System.EventArgs e)
    {
        Response.Write("<script>");
        Response.Write("window.close();");
        Response.Write("</script>");
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


    internal string validadacion_RUT_PERFIL(string P_ID_PERFIL, string P_RUT_USUARIO)
    {
        string resp;
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_USUARIO.VALIDA_RUT_PERFIL_AGREGA", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_id_perfil", OracleType.Int32, ParameterDirection.Input, P_ID_PERFIL);
        PRO.agrega_parametro_sp(da, "i_rut", OracleType.NVarChar, ParameterDirection.Input, P_RUT_USUARIO);

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
            resp = "EL RUT DE USUARIO YA EXISTE PARA ESTE PERFIL!";
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

 protected void btn_agregaUser_Click(object sender, System.EventArgs e)
{

		if (Page.IsValid)
		{

			if (formato_rut() == true)
			{

				VALIDACION_RUT_USUARIO.Visible = false;
				//Validad que no se repita el Nombre de Usuario.
				string str_nom_user = validadacion_Nombre_Usuario(txt_login.Text);

				if (str_nom_user == "OK")
				{

					VALIDACION_RUT_USUARIO.Visible = false;
					string concat_rut_user = null;
					string msg_error_rut_perfil = null;
					concat_rut_user = txt_rut.Text.Trim(' ') + "-" + txt_dv.Text.Trim(' ');
					msg_error_rut_perfil = validadacion_RUT_PERFIL(Convert.ToString(combo_perfiles.Items[combo_perfiles.SelectedIndex].Value).Trim(' '), concat_rut_user);

					if (msg_error_rut_perfil == "OK")
					{


						VALIDACION_RUT_USUARIO.Visible = false;
						OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
						objConexion.Open();
						//sSQL = "INSERT INTO USUARIOS(id_usuario,id_empresa,usuario,password,id_perfil,rut,nombre,id_grupoproceso,estado) VALUES (4,1,'administrador','123456',1,'13890087-8','ANDRES CARDENAS',555,0)"
						OracleDataAdapter ComandoDA = new OracleDataAdapter("PK_USUARIO.USUARIO_INSERTA", objConexion);

						ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

						//agrega_parametro_SP(ComandoDA, "i_id_usuario", SqlDbType.Int, "5") 'SACAR POR TRIGGER...
                        PRO.agrega_parametro_sp(ComandoDA, "i_rut_empresa", OracleType.Int32, ParameterDirection.Input, combo_empresas.Items[combo_empresas.SelectedIndex].Value);
						PRO.agrega_parametro_sp(ComandoDA, "i_usuario", OracleType.NVarChar, ParameterDirection.Input, txt_login.Text);
						PRO.agrega_parametro_sp(ComandoDA, "i_password", OracleType.NVarChar, ParameterDirection.Input, txt_pass.Text);
						PRO.agrega_parametro_sp(ComandoDA, "i_id_perfil", OracleType.Int32, ParameterDirection.Input, combo_perfiles.Items[combo_perfiles.SelectedIndex].Value);
						PRO.agrega_parametro_sp(ComandoDA, "i_rut", OracleType.NVarChar, ParameterDirection.Input, txt_rut.Text + "-" + txt_dv.Text);
						PRO.agrega_parametro_sp(ComandoDA, "i_nombre", OracleType.NVarChar, ParameterDirection.Input, txt_nombre.Value);
						PRO.agrega_parametro_sp(ComandoDA, "i_estado", OracleType.Int32, ParameterDirection.Input, "0");
                        PRO.agrega_parametro_sp(ComandoDA, "i_multiempresa", OracleType.Int32, ParameterDirection.Input, rd_multiempresa.Items[rd_multiempresa.SelectedIndex].Value);
                        PRO.agrega_parametro_sp(ComandoDA, "i_dias", OracleType.Int32, ParameterDirection.Input, txtDias.Text);
                        PRO.agrega_parametro_sp(ComandoDA, "i_correo", OracleType.NVarChar, ParameterDirection.Input, txtCorreo.Text);
                        PRO.agrega_parametro_sp(ComandoDA, "i_apellido", OracleType.NVarChar, ParameterDirection.Input, txt_apellido.Text);


						try
						{
							ComandoDA.SelectCommand.ExecuteNonQuery();
                            row_aceptar_ok.Visible = true;
							lb_mensaje_ingreso.Visible = true;
							img_ok.Visible = true;
							tbl_NuevoUser.Visible = false;
							btnok_agregar.Visible = true;
                            //btnvolver_agregar.Visible = true;
							lb_mensaje_ingreso.Text = "USUARIO INGRESADO CORRECTAMENTE!";
							lb_minihead.Text = "";

							//*********************** INSERTAMOS LOG DEL SISTEMA ***********************************
							try
							{
								string str_fecha = null;
								string str_hora = null;
								string str_desc_evento = null;
								str_fecha = DateTime.Now.ToString().Substring(0, 10).Trim(' ');
								str_hora = DateTime.Now.ToString().Substring(10, 9).Trim(' ');
								str_desc_evento = "SE HA INGRESADO UN NUEVO USUARIO CON RUT " + txt_rut.Text + "-" + txt_dv.Text;
								PRO.Insertamos_log_del_Sistema(lb_id_usuario.Text, lb_rut_empresa.Text, str_fecha, str_hora, str_desc_evento, "0", "0", Request.ServerVariables["REMOTE_ADDR"].ToString());
							}
							catch (Exception ex)
							{
							}
							//**************************************************************************************


						}
						catch (Exception ex)
						{
                            String exp = ex.ToString();


                          

							//Mensaje de error ....usuario nuevo
						}

					}
					else
					{

						VALIDACION_RUT_USUARIO.Visible = true;
						VALIDACION_RUT_USUARIO.Text = msg_error_rut_perfil;


					}



				}
				else //EXISTE NOMBRE DE USUARIO EN LA BASE DE DATOS
				{

					//Response.Write(str_nom_user)
					VALIDACION_RUT_USUARIO.Visible = true;
					VALIDACION_RUT_USUARIO.Text = str_nom_user;

				}


			}
			else //FORMATO_RUT ES INCORRECTO
			{

				VALIDACION_RUT_USUARIO.Visible = true;
				VALIDACION_RUT_USUARIO.Text = "EL FORMATO DEL RUT ES INCORRECTO!";

			}

		}

	}
//INSTANT C# TODO TASK: This method is a constructor, but no class name was found:
    //public <class name>()
    //{
    //    SubscribeToEvents();
    //}

//INSTANT C# NOTE: Converted event handler wireups:
		private bool EventsSubscribed = false;
		private void SubscribeToEvents()
		{
			if (EventsSubscribed)
				return;
			else
				EventsSubscribed = true;

			btn_agregaUser.Click += btn_agregaUser_Click;
		}


        //public short SoloNumeros(short Keyascii)
        //{
        //    short tempSoloNumeros = 0;
        //    if ("1234567890".IndexOf(Microsoft.VisualBasic.Strings.Chr(Keyascii)) + 1 == 0)
        //    {
        //        tempSoloNumeros = 0;
        //    }
        //    else
        //    {
        //        tempSoloNumeros = Keyascii;
        //    }
        //    switch (Keyascii)
        //    {
        //        case 8:
        //            tempSoloNumeros = Keyascii;
        //            break;
        //        case 13:
        //            tempSoloNumeros = Keyascii;
        //            break;
        //    }
        //    return tempSoloNumeros;
        //}

    protected void btnVolverPrin_Click(object sender, System.EventArgs e)
    {
        Response.Write("<script>");
        Response.Write("window.close();");
        Response.Write("</script>");
    }

    protected void btnok_agregar_Click(object sender, System.EventArgs e)
    {


        Response.Redirect("MantencionUsuarios.aspx");


        //consulta_usuarios(Session(Session.SessionID & "_Empresa").ToString)
        
        //GrillaUsuarios.Visible = true;
        //tbl_NuevoUser.Visible = false;
        //lb_mensaje_ingreso.Visible = false;
        //img_ok.Visible = false;
        //titulo_mod.InnerText = "Mantenimiento de Usuarios";
        ////lb_minihead.Text = "Por favor, seleccione la acción a realizar:";
        //lkb_Agregar.Visible = true;
        //row_aceptar_ok.Visible = false;
        //lb_cantidad_registros.Visible = true;

        //carga_usuarios(lb_rut_empresa.Text, lb_perfil_usuario.Text, lb_id_usuario.Text);
    }

    protected void btnvolver_agregar_Click(object sender, System.EventArgs e)
    {
        Response.Write("<script>");
        Response.Write("window.close();");
        Response.Write("</script>");
    }
    protected void lkb_Agregar_Click1(object sender, EventArgs e)
    {

    }
    protected void GrillaUsuarios_PageIndexChanged(object source, DataGridPageChangedEventArgs e)
    {
        GrillaUsuarios.CurrentPageIndex = e.NewPageIndex;
        carga_usuarios(lb_rut_empresa.Text, lb_perfil_usuario.Text, lb_id_usuario.Text);

    }
    protected void combo_empresas_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
