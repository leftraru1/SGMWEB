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
using System.Web.UI;

partial class MantencionOperador : System.Web.UI.Page
{
    private string id_perfil;
    private System.Net.IPAddress oAddr;
    private Procedimientos PRO = new Procedimientos();
    private string conexion_cliente_oracle = ConfigurationSettings.AppSettings["ConnectionString_ClienteOracle"];
    public DataTable dt;
    public string XMLRUTEmpresa;

    public void MaximizarVentana_TamañoPantalla(Page pagina)
    {

        string strScript = "";
        strScript += "<script language=\"JavaScript1.2\">" + Environment.NewLine;
        strScript += "window.moveTo(0,0);" + Environment.NewLine;
        strScript += "if (document.all) {" + Environment.NewLine;
        strScript += "top.window.resizeTo(screen.availWidth,screen.availHeight);" + Environment.NewLine;
        strScript += "}" + Environment.NewLine;
        strScript += "else if (document.layers||document.getElementById) {" + Environment.NewLine;
        strScript += "if (top.window.outerHeight<screen.availHeight||top.window.outerWidth<screen.availWidth){" + Environment.NewLine;
        strScript += "top.window.outerHeight = screen.availHeight;" + Environment.NewLine;
        strScript += "top.window.outerWidth = screen.availWidth;" + Environment.NewLine;
        strScript += "}" + Environment.NewLine;
        strScript += "}" + Environment.NewLine;
        strScript += "</script>" + Environment.NewLine;

        pagina.ClientScript.RegisterClientScriptBlock(pagina.GetType(), "MaximizarPantalla", strScript);

    }

    protected void Page_Load(object sender, System.EventArgs e)
    {
        if (!Page.IsPostBack)
        {

            //txt_cantidad_descarga.Visible = false;
            //RequiredFieldValidator6.Visible = false;

            MaximizarVentana_TamañoPantalla(this.Page);
            bool valida = false;
            valida = valida_link();

            try
            {
                recupera_session();
            }
            catch (Exception ex)
            {
                Response.Redirect("ErrorSession.aspx");
            }
            btn_aceptar.Visible = false;
            btn_volver2.Visible = false;
            btnExportExcel.Visible = true;
            //comboExcel.Visible = True
            //comboExcel.Enabled = True

            div_nuevo_lector.Visible = false;
            valida_borra_lector.Visible = false;
            lb_valida_claves.Visible = false;
            img_ok.Visible = false;
            XmlDataDocument xml_doc = new XmlDataDocument();
            xml_doc.Load(Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml");
            string XMLEmpresa = null;
            XMLRUTEmpresa = xml_doc.SelectSingleNode("SESSION/DATOS_USUARIO/RUT_EMPRESA").InnerText;
            lbRutEmpresa.Text = xml_doc.SelectSingleNode("SESSION/DATOS_USUARIO/RUT_EMPRESA").InnerText;
            lbRutEmpresa.Visible = false;
            ObtieneRegionLector(XMLRUTEmpresa); //Llena COMBO REGIONES
            XMLEmpresa = xml_doc.SelectSingleNode("SESSION/DATOS_USUARIO/NOMBRE_EMPRESA").InnerText;
            lbEmpresaLector.Text = XMLEmpresa.ToString();
            carga_lectores(lbRutEmpresa.Text);
            llena_combo_modelo_maquina(lbRutEmpresa.Text);
            Llena_combo_contratista(lbRutEmpresa.Text);
            Lb_user.Visible = false;
            lb_session_user.Visible = false;
            lb_empresa.Visible = false;
            lb_session_empresa.Visible = false;
        }
    }

    private void Llena_combo_contratista(string p_RutEmpresa)
    {

        string sql_zonas = null;
        DataTable dtZonas = new DataTable();
        sql_zonas = "select * from contratista where rut_empresa = " + p_RutEmpresa + "  AND estado=0  ";
        // Para rellenar combo"
        OracleDataAdapter objComando_Zonas = null;
        objComando_Zonas = new OracleDataAdapter(sql_zonas, conexion_cliente_oracle);
        objComando_Zonas.Fill(dtZonas);
        string valueCombo = null;
        string textoCombo = null;

        combo_contratista.Items.Clear();
        foreach (System.Data.DataRow drZonaItem in dtZonas.Rows)
        {
            valueCombo = drZonaItem["id_contratista"].ToString();
            textoCombo = drZonaItem["nombre"].ToString().ToUpper();
            combo_contratista.Items.Add(new ListItem(textoCombo, valueCombo));
        }

    }

    public void ObtieneRegionLector(string p_RutEmpresa)
    {
        OracleConnection oraconn = new OracleConnection(conexion_cliente_oracle);
        OracleCommand oracmd = new OracleCommand();
        oracmd.CommandText = "PK_INSTALADOR.OBTIENE_REGION_INSTALADOR";
        oracmd.Connection = oraconn;
        oracmd.CommandType = CommandType.StoredProcedure;

        OracleParameter param1 = new OracleParameter("o_cursor", OracleType.Cursor);
        param1.Direction = ParameterDirection.Output;
        OracleParameter param2 = new OracleParameter("i_rut_empresa", OracleType.Int32);
        param2.Direction = ParameterDirection.Input;
        param2.Value = p_RutEmpresa;

        oraconn.Open();

        OracleDataAdapter da = new OracleDataAdapter(oracmd);
        da.SelectCommand.Parameters.Add(param1);
        da.SelectCommand.Parameters.Add(param2);
        DataTable dtRegionesItems = new DataTable();
        da.Fill(dtRegionesItems);
        oraconn.Close();
        oraconn.Dispose();

        string valuecombo = null;
        string textocombo = null;
        string P_ID_REGION = null;
        combo_regiones.Items.Clear();
        foreach (System.Data.DataRow drRegionItem in dtRegionesItems.Rows)
        {
            //lbRegionLector.Text = drRegionItem("descripcion").ToString
            valuecombo = drRegionItem["id_region"].ToString();
            textocombo = drRegionItem["descripcion"].ToString();
            combo_regiones.Items.Add(new ListItem(textocombo, valuecombo));
            P_ID_REGION = drRegionItem["id_region"].ToString();
        }
        //Llena_combo_zonas(P_ID_REGION)
        Llena_combo_zonas(combo_regiones.Items[combo_regiones.SelectedIndex].Value);
        oraconn.Close();
    }
    public object OBTIENE_NOMBRE_EMPRESA(string rut_de_empresa)
    {

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_EMPRESA.NOMBRE_EMPRESA_X_RUT", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_rut_empresa", OracleType.Number, ParameterDirection.Input, rut_de_empresa);

        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        CnOra.Open();
        DataSet objDS = new DataSet();
        da.Fill(objDS, "EMPRESA");
        CnOra.Close();
        CnOra.Dispose();

        return objDS.Tables["EMPRESA"].Rows[0][0];

    }
    public void carga_lectores(String RutDeEmpresa)
    {

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_INSTALADOR.CARGA_INSTALADOR_X_EMPRESA", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_rut_empresa", OracleType.Number, ParameterDirection.Input, RutDeEmpresa);

        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        CnOra.Open();
        DataTable dtLectores = new DataTable();
        da.Fill(dtLectores);
        CnOra.Close();
        CnOra.Dispose();

        dt = new DataTable();
        dt.Columns.Add(new DataColumn("id_instalador", typeof(string)));
        dt.Columns.Add(new DataColumn("id_region", typeof(string)));
        dt.Columns.Add(new DataColumn("id_zona", typeof(string)));
        dt.Columns.Add(new DataColumn("rut_empresa", typeof(string)));
        dt.Columns.Add(new DataColumn("cod_instalador", typeof(string)));
        dt.Columns.Add(new DataColumn("apellido", typeof(string)));
        dt.Columns.Add(new DataColumn("nombre", typeof(string)));
        dt.Columns.Add(new DataColumn("nom_empresa", typeof(string)));
        dt.Columns.Add(new DataColumn("clave_admin", typeof(string)));
        dt.Columns.Add(new DataColumn("clave_instalador", typeof(string)));
        dt.Columns.Add(new DataColumn("estado", typeof(string)));
        dt.Columns.Add(new DataColumn("version", typeof(string)));
        dt.Columns.Add(new DataColumn("cantidad", typeof(string)));
        dt.Columns.Add(new DataColumn("fotografia", typeof(string)));
        dt.Columns.Add(new DataColumn("numero_telefono", typeof(string)));
        dt.Columns.Add(new DataColumn("serie_maquina", typeof(string)));
        dt.Columns.Add(new DataColumn("id_modelo", typeof(string)));
        dt.Columns.Add(new DataColumn("id_contratista", typeof(string)));
        dt.Columns.Add(new DataColumn("descripcion", typeof(string)));


        DataRow dr = null;
        int cont_registros = 0;
        cont_registros = 0;

        foreach (System.Data.DataRow drLectorItem in dtLectores.Rows)
        {

            dr = dt.NewRow();
            dr["id_instalador"] = drLectorItem["id_instalador"].ToString();
            dr["id_region"] = drLectorItem["id_region"].ToString();
            dr["id_zona"] = drLectorItem["id_zona"].ToString();
            dr["rut_empresa"] = drLectorItem["rut_empresa"].ToString();
            dr["cod_instalador"] = drLectorItem["cod_instalador"].ToString();
            dr["apellido"] = drLectorItem["apellido"].ToString().ToUpper();
            dr["nombre"] = drLectorItem["nombre"].ToString().ToUpper();
            dr["nom_empresa"] = Convert.ToString(OBTIENE_NOMBRE_EMPRESA(drLectorItem["rut_empresa"].ToString())).ToUpper(); //"Empresa" 'Funcion que entrege Empresa 'drUsuarioItem("nom_empresa").ToString
            dr["clave_admin"] = drLectorItem["clave_admin"].ToString();
            dr["clave_instalador"] = drLectorItem["clave_instalador"].ToString();

            //dr("estado") = drLectorItem("estado").ToString

            if (drLectorItem["estado"].ToString() == "0")
            {
                dr["estado"] = "ACTIVO";
            }
            else
            {
                dr["estado"] = "INACTIVO";
            }

            dr["version"] = drLectorItem["version"].ToString().ToUpper();

            dr["cantidad"] = drLectorItem["cantidad"].ToString();

            if (drLectorItem["fotografia"].ToString() == 0.ToString())
            {
                dr["fotografia"] = "SIN FOTOGRAFIA";
            }
            else
            {
                dr["fotografia"] = "CON FOTOGRAFIA";
            }


            if (string.IsNullOrEmpty(drLectorItem["numero_telefono"].ToString()))
            {
                dr["numero_telefono"] = "Sin Datos";
            }
            else
            {
                dr["numero_telefono"] = drLectorItem["numero_telefono"].ToString();
            }

            if (string.IsNullOrEmpty(drLectorItem["serie_maquina"].ToString()))
            {
                dr["serie_maquina"] = "Sin Datos";
            }
            else
            {
                dr["serie_maquina"] = drLectorItem["serie_maquina"].ToString();
            }

            //dr("id_modelo") = drLectorItem("id_modelo").ToString
            object VARIABLE_TEMPORAL_MODELO = null;
            VARIABLE_TEMPORAL_MODELO = obtener_nombre_modelo(drLectorItem["id_modelo"].ToString());

            if (VARIABLE_TEMPORAL_MODELO.ToString() == "ERROR")
            {
                dr["id_modelo"] = "Sin Datos";
            }
            else
            {
                dr["id_modelo"] = VARIABLE_TEMPORAL_MODELO;
            }

            dr["id_contratista"] = drLectorItem["id_contratista"].ToString();
            dr["descripcion"] = drLectorItem["descripcion"].ToString();



            dt.Rows.Add(dr);
            cont_registros = cont_registros + 1;
        }

        lb_cantidad_registros.Text = cont_registros.ToString() + " coincidencia(s) encontrada(s)";
        DataView MydataView = null;
        MydataView = new DataView(dt);
        GrillaCortadores.DataSource = MydataView;
        GrillaCortadores.DataBind();

        GrillaCortadores_temp.DataSource = MydataView;
        GrillaCortadores_temp.DataBind();



        //INICIO: Control de Estado de Cortadores
        DataGridItem GridItem = null;
        int c = 0;
        for (c = 0; c < GrillaCortadores.Items.Count; c++)
        {
            GridItem = GrillaCortadores.Items[c];

            if (GridItem.Cells[10].Text == "ACTIVO")
            {
                GridItem.Cells[10].ForeColor = System.Drawing.Color.DarkGreen;
                GridItem.Cells[10].BorderColor = System.Drawing.Color.Black;
            }

            if (GridItem.Cells[10].Text == "INACTIVO")
            {
                GridItem.Cells[20].Text = "";
                GridItem.Cells[10].ForeColor = System.Drawing.Color.Red;
                GridItem.Cells[10].BorderColor = System.Drawing.Color.Black;
            }
        }
        //FIN: Control de Estado de Cortadores

    }
    public void MyDataGrid_Edit(object sender, DataGridCommandEventArgs e)
    {
        string indice = null;
        indice = e.Item.ItemIndex.ToString();
        //PASAR COMO PARAMETRO TAMBIEN EL ID_ZONA
        Response.Redirect("ModificarInstaladores.aspx?idlector=" + GrillaCortadores.Items[Int32.Parse(indice)].Cells[0].Text);
        //Response.Write("Modificacion...." & e.Item.ItemIndex.ToString)
        Response.End();
    }

    public void cmDelete(object Sender, DataGridCommandEventArgs e)
    {

        string indice = null;
        indice = e.Item.ItemIndex.ToString();

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("AN_Listas.VALIDA_LECTOR_ASIGNACIONES", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_id_lector", OracleType.Number, ParameterDirection.Input, GrillaCortadores.Items[Int32.Parse(indice)].Cells[0].Text);

        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        CnOra.Open();
        DataSet dsLectores = new DataSet();
        da.Fill(dsLectores, "ASIGNACIONES");
        CnOra.Close();
        CnOra.Dispose();

        if (dsLectores.Tables["ASIGNACIONES"].Rows.Count != 0)
        {
            //Response.Write("<script>")
            //Response.Write("alert('Eliminación Denegada, Lector tiene asignaciones relacionadas!');")
            //Response.Write("</script>")
            valida_borra_lector.Visible = true;
            valida_borra_lector.Text = "Anulacion Denegada, Operador tiene asignaciones relacionadas!";
        }
        else
        {
            //SE PUEDE ELIMINAR LECTOR
            Response.Write("<script>");
            Response.Write("if (confirm('Mensaje de confirmación !  \\n \\n Esta seguro que desea Anular el registro del Operador Seleccionado ?')) { document.location.href='EliminarCortador.aspx?idlector=" + GrillaCortadores.Items[Int32.Parse(indice)].Cells[0].Text + "'; }");
            Response.Write("</script>");
        }
    }


    private void Llena_combo_zonas(string id_de_region)
    {

        string sql_zonas = null;
        DataTable dtZonas = new DataTable();
        sql_zonas = "select * from ZONA where id_region='" + id_de_region + "'"; // Para rellenar combo

        OracleDataAdapter objComando_Zonas = null; //OleDbDataAdapter
        objComando_Zonas = new OracleDataAdapter(sql_zonas, conexion_cliente_oracle);
        objComando_Zonas.Fill(dtZonas);
        string valueCombo = null;
        string textoCombo = null;


        combo_zonaLector.Items.Clear();
        combo_zonaLector.Items.Add("Todas...");
        combo_zonaLector.Items[0].Value = "0";
        foreach (System.Data.DataRow drZonaItem in dtZonas.Rows)
        {
            valueCombo = drZonaItem["id_zona"].ToString();
            textoCombo = drZonaItem["nombre"].ToString();
            combo_zonaLector.Items.Add(new ListItem(textoCombo, valueCombo));
        }

    }

    public void limpia_controles()
    {

        txt_codLector.Text = "";
        txt_nomLector.Text = "";
        txt_apeLector.Text = "";
        txt_claveAdmin.Text = "";
        txt_ClaveLector.Text = "";


    }


    public void Cambio_Modo_Mantencion(string P_TITULO, bool ESTADO)
    {

        titulo_mod.InnerText = P_TITULO;
        div_grilla.Visible = ESTADO;
        //criterio_busqueda.Visible = False

        tr_btn_agrega.Visible = ESTADO;
        //btn_volver2.Visible = ESTADO;
        btnExportExcel.Visible = ESTADO;
        comboExcel.Visible = ESTADO;
        btn_aceptar.Visible = ESTADO;
        btnAgregaLector.Visible = ESTADO;


        limpia_controles();
        lb_valida_claves.Visible = ESTADO;
        valida_borra_lector.Visible = ESTADO;

        div_nuevo_lector.Visible = !(ESTADO);
        tbl_ingreso_lector.Visible = !(ESTADO);

        lb_mensaje_ingreso.Visible = false;
        lb_error.Visible = false;
        img_ok.Visible = false;

    }

    protected void btnAgregaLector_Click(object sender, System.EventArgs e)
    {

        Cambio_Modo_Mantencion("Ingreso de Nuevo Operador", false);
        btnAgregaLector.Visible = false;

    }

    protected void btnCancelar_Click(object sender, System.EventArgs e)
    {
        div_nuevo_lector.Visible = false;
        //criterio_busqueda.Visible = True
        div_grilla.Visible = true;
        //opcBusqueda.SelectedIndex = 0 'Deja item <buscar por...>
        tr_btn_agrega.Visible = true;
        btn_volver2.Visible = false;

        btnExportExcel.Visible = true;
        comboExcel.Visible = true;
        comboExcel.Enabled = true;

        valida_borra_lector.Visible = false;

        lb_mensaje_ingreso.Visible = false;
        lb_error.Visible = false;
        img_ok.Visible = false;

    }


    public void recupera_session()
    {
        XmlDataDocument recupera_xml = new XmlDataDocument();
        recupera_xml.Load(Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml");
        string session_user = null;
        string session_empresa = null;
        session_user = recupera_xml.SelectSingleNode("SESSION/DATOS_USUARIO/NOMBRE").InnerText;
        session_empresa = recupera_xml.SelectSingleNode("SESSION/DATOS_USUARIO/NOMBRE_EMPRESA").InnerText;
        lb_session_user.Text = ": " + session_user + " / ";
        lb_session_empresa.Text = ": " + session_empresa;
        lb_id_usuario.Text = recupera_xml.SelectSingleNode("SESSION/DATOS_USUARIO/ID_USUARIO").InnerText;
        id_perfil = recupera_xml.SelectSingleNode("SESSION/DATOS_USUARIO/ID_PERFIL").InnerText;
        lb_id_usuario.Visible = false;
    }

    protected void btnVolver_Click(object sender, System.EventArgs e)
    {

        Cambio_Modo_Mantencion("Mantenedor de Operadores", true);


    }

    public string validadacion_Codigo_Operador(string P_CODIGO_OPERADOR)
    {
        string tempvalidadacion_Codigo_Operador = null;



        if (ER_codLector.IsValid)
        {
            P_CODIGO_OPERADOR = PRO.CadenaSinCeros(P_CODIGO_OPERADOR.Trim(' '));
        }
        else
        {
            return "CÓDIGO OPERADOR DEBE SER NUMÉRICO!";
        }

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_INSTALADOR.VALIDA_INSTALADOR_EXISTE", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_cod_instalador", OracleType.NVarChar, ParameterDirection.Input, P_CODIGO_OPERADOR);
        PRO.agrega_parametro_sp(da, "i_rut_empresa", OracleType.Number, ParameterDirection.Input, lbRutEmpresa.Text);

        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        CnOra.Open();
        DataSet dsLectores = new DataSet();
        da.Fill(dsLectores, "OPERADORES");
        CnOra.Close();
        CnOra.Dispose();

        if (dsLectores.Tables["OPERADORES"].Rows.Count != 0)
        {

            tempvalidadacion_Codigo_Operador = "CÓDIGO OPERADOR EXISTE EN LE BASE DE DATOS! ELIJA OTRO.";
        }
        else
        {

            tempvalidadacion_Codigo_Operador = "OK";
        }

        return tempvalidadacion_Codigo_Operador;
    }

    protected void btnInsertaLector_Click(object sender, System.EventArgs e)
    {
        //Validad que no este REPETIDO LECTOR
        if (Page.IsValid)
        {
            if (formato_rut() == true)
            {
                if (txt_ClaveLector.Text != txt_claveAdmin.Text)
                {
                    string str_valida_codigo = null;
                    str_valida_codigo = validadacion_Codigo_Operador(txt_codLector.Text.Trim(' '));
                    if (str_valida_codigo == "OK")
                    {

                        VALIDACION_RUT_USUARIO.Visible = false;
                        string concatenado_rut = null;
                        string msg_error_rut = null;
                        concatenado_rut = txt_rut.Text.Trim(' ') + "-" + txt_dv.Text.Trim(' ');
                        msg_error_rut = validacion_RUT(concatenado_rut);




                        lb_valida_claves.Visible = false;
                        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle); //OleDbConnection(conexion)
                        objConexion.Open();
                        OracleDataAdapter ComandoDA = null;
                        ComandoDA = new OracleDataAdapter("PK_INSTALADOR.INSTALADOR_INSERTA", objConexion);
                        ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;
                        PRO.agrega_parametro_sp(ComandoDA, "i_id_region", OracleType.Int32, ParameterDirection.Input, combo_regiones.Items[combo_regiones.SelectedIndex].Value);
                        //PRO.agrega_parametro_sp(ComandoDA, "i_rut",)

                        PRO.agrega_parametro_sp(ComandoDA, "i_id_zona", OracleType.Int32, ParameterDirection.Input, combo_zonaLector.Items[combo_zonaLector.SelectedIndex].Value);
                        PRO.agrega_parametro_sp(ComandoDA, "i_rut_empresa", OracleType.Number, ParameterDirection.Input, lbRutEmpresa.Text.Trim(' '));
                        PRO.agrega_parametro_sp(ComandoDA, "i_cod_instalador", OracleType.NVarChar, ParameterDirection.Input, PRO.CadenaSinCeros(txt_codLector.Text.Trim(' ')));
                        PRO.agrega_parametro_sp(ComandoDA, "i_clave_admin", OracleType.NVarChar, ParameterDirection.Input, txt_claveAdmin.Text.Trim(' '));
                        PRO.agrega_parametro_sp(ComandoDA, "i_clave_instalador", OracleType.NVarChar, ParameterDirection.Input, txt_ClaveLector.Text.Trim(' '));
                        PRO.agrega_parametro_sp(ComandoDA, "i_estado", OracleType.Int32, ParameterDirection.Input, "0");
                        PRO.agrega_parametro_sp(ComandoDA, "i_apellido_instalador", OracleType.NVarChar, ParameterDirection.Input, txt_apeLector.Text.Trim(' '));
                        PRO.agrega_parametro_sp(ComandoDA, "i_nombre_instalador", OracleType.NVarChar, ParameterDirection.Input, txt_nomLector.Text.Trim(' '));
                        PRO.agrega_parametro_sp(ComandoDA, "i_cantidad", OracleType.Int32, ParameterDirection.Input, "0");
                        PRO.agrega_parametro_sp(ComandoDA, "i_fotografia", OracleType.Int32, ParameterDirection.Input, "1"); //combo_fotografia.SelectedIndex (Cambiar despues)
                        PRO.agrega_parametro_sp(ComandoDA, "i_numero_telefono", OracleType.NVarChar, ParameterDirection.Input, txt_num_celular.Text.Trim(' '));
                        PRO.agrega_parametro_sp(ComandoDA, "i_serie_maquina", OracleType.NVarChar, ParameterDirection.Input, txt_serie_maquina.Text.Trim(' '));
                        PRO.agrega_parametro_sp(ComandoDA, "i_id_modelo", OracleType.Int32, ParameterDirection.Input, combo_modelo.Text.Trim(' '));
                        PRO.agrega_parametro_sp(ComandoDA, "i_id_contratista", OracleType.Int32, ParameterDirection.Input, combo_contratista.Items[combo_contratista.SelectedIndex].Value);
                        PRO.agrega_parametro_sp(ComandoDA, "i_email", OracleType.NVarChar, ParameterDirection.Input, txt_email.Text.Trim(' '));
                        PRO.agrega_parametro_sp(ComandoDA, "i_forma_gestion", OracleType.NVarChar, ParameterDirection.Input, cmb_formagestion.Items[cmb_formagestion.SelectedIndex].Text.Trim(' '));
                        try
                        {
                            ComandoDA.SelectCommand.ExecuteNonQuery();
                            tr_btn_agrega.Visible = true;
                            tbl_ingreso_lector.Visible = false;
                            btn_aceptar.Visible = true;
                            btn_volver2.Visible = false;
                            btnAgregaLector.Visible = false;
                            lb_mensaje_ingreso.Visible = true;
                            lb_error.Visible = false;
                            img_ok.Visible = true;
                            lb_mensaje_ingreso.Text = "El Instalador ha sido ingresado exitosamente.";

                            //**************************************************************************************








                            //*********************** INSERTAMOS LOG DEL SISTEMA ***********************************
                            try
                            {
                                string str_fecha = null;
                                string str_hora = null;
                                string str_desc_evento = null;
                                str_fecha = DateTime.Now.ToString().Substring(0, 10).Trim(' ');
                                str_hora = DateTime.Now.ToString().Substring(10, 9).Trim(' ');
                                str_desc_evento = "SE CREO EL INSTALADOR CON CODIGO " + txt_codLector.Text;
                                PRO.Insertamos_log_del_Sistema(lb_id_usuario.Text, lbRutEmpresa.Text, str_fecha, str_hora, str_desc_evento, "0", "0", Request.ServerVariables["REMOTE_ADDR"].ToString());
                            }
                            catch (Exception ex)
                            {
                            }
                            //**************************************************************************************

                        }
                        catch (Exception ex)
                        {
                            lb_error.Visible = true;
                            lb_error.Text = "Se ha producido un error en el ingreso del Operador debido a: " + ex.Message;
                            lb_mensaje_ingreso.Visible = false;
                            img_ok.Visible = false;
                        }


                    }
                    else
                    {

                        lb_valida_claves.Visible = true;
                        lb_valida_claves.Text = str_valida_codigo;

                    }


                }
                else //SI CLAVE ADMINISTRADOR = CLAVE DEL LECTOR.
                {
                    lb_valida_claves.Visible = true;
                    lb_valida_claves.Text = "NO SE PERMITE CLAVE ADMINISTRADOR = CLAVE LECTOR!";

                }
            }
            else //FORMATO_RUT ES INCORRECTO
            {

                VALIDACION_RUT_USUARIO.Visible = true;
                VALIDACION_RUT_USUARIO.Text = "EL FORMATO DEL RUT ES INCORRECTO!";

            }
        }
    }

    protected void btn_volver2_Click(object sender, System.EventArgs e)
    {
        //Response.Write("<script>")
        //Response.Write("window.close();")
        //Response.Write("</script>")
        string popupScript = "<script language='JavaScript'>window.open('','_self','');window.close();<" + "/script>";
        Response.Write(popupScript);
    }

    protected void btn_aceptar_Click(object sender, System.EventArgs e)
    {

        btnAgregaLector.Visible = true;
        comboExcel.Visible = true;
        btnExportExcel.Visible = true;

        valida_borra_lector.Visible = false;
        carga_lectores(lbRutEmpresa.Text);
        div_nuevo_lector.Visible = false;
        div_grilla.Visible = true;
        //opcBusqueda.SelectedIndex = 0
        tr_btn_agrega.Visible = true;
        btn_volver2.Visible = false;

        btnExportExcel.Visible = true;
        comboExcel.Visible = true;

        btn_aceptar.Visible = false;

        lb_mensaje_ingreso.Visible = false;
        lb_error.Visible = false;
        img_ok.Visible = false;

    }

    protected void combo_regiones_SelectedIndexChanged(object sender, System.EventArgs e)
    {
        //Llena_combo_zonas(P_ID_REGION)
        // Llena_combo_zonas(P_ID_REGION)
        Llena_combo_zonas(combo_regiones.Items[combo_regiones.SelectedIndex].Value);
    }


    protected void GrillaCortadores_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.SelectedItem)
        {
            string mouseOverColor = "#AFEEEE";
            string mouseOutColorItem = "#FFFFFF";
            e.Item.Attributes.Add("onmouseover", "this.style.backgroundColor='" + mouseOverColor + "'");
            e.Item.Attributes.Add("onmouseout", "this.style.backgroundColor='" + mouseOutColorItem + "'");
        }
    }


    public object llena_combo_modelo_maquina(object p_RutEmpresa)
    {

        OracleConnection oraconn = new OracleConnection(conexion_cliente_oracle);
        OracleCommand oracmd = new OracleCommand();
        oracmd.CommandText = "PK_MODELO.OBTIENE_MODELO";
        oracmd.Connection = oraconn;
        oracmd.CommandType = CommandType.StoredProcedure;

        OracleParameter param1 = new OracleParameter("o_cursor", OracleType.Cursor);
        param1.Direction = ParameterDirection.Output;
        OracleParameter param2 = new OracleParameter("i_rut_empresa", OracleType.Int32);
        param2.Direction = ParameterDirection.Input;
        param2.Value = p_RutEmpresa;

        oraconn.Open();

        OracleDataAdapter da = new OracleDataAdapter(oracmd);
        da.SelectCommand.Parameters.Add(param1);
        da.SelectCommand.Parameters.Add(param2);
        DataTable dtRegionesItems = new DataTable();
        da.Fill(dtRegionesItems);
        oraconn.Close();
        oraconn.Dispose();

        combo_modelo.Items.Clear();

        string valuecombo = null;
        string textocombo = null;
        string P_ID_REGION = null;
        foreach (System.Data.DataRow drRegionItem in dtRegionesItems.Rows)
        {
            //lbRegionLector.Text = drRegionItem("descripcion").ToString
            valuecombo = drRegionItem["id_modelo"].ToString();
            textocombo = drRegionItem["nombre_modelo"].ToString();
            combo_modelo.Items.Add(new ListItem(textocombo, valuecombo));
            P_ID_REGION = drRegionItem["id_modelo"].ToString();

        }
        //INSTANT C# NOTE: Inserted the following 'return' since all code paths must return a value in C#:
        return null;
    }



    public string obtener_nombre_modelo(string P_i_id_modelo)
    {
        string tempobtener_nombre_modelo = null;

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_MODELO.valida_modelo", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_id_modelo", OracleType.NVarChar, ParameterDirection.Input, P_i_id_modelo);
        PRO.agrega_parametro_sp(da, "i_rut_empresa", OracleType.Number, ParameterDirection.Input, lbRutEmpresa.Text);

        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        CnOra.Open();
        DataSet dsLectores = new DataSet();
        da.Fill(dsLectores, "LECTORES");
        CnOra.Close();
        CnOra.Dispose();

        if (dsLectores.Tables["LECTORES"].Rows.Count != 0)
        {

            tempobtener_nombre_modelo = dsLectores.Tables["LECTORES"].Rows[0]["NOMBRE_MODELO"].ToString();



        }
        else
        {

            tempobtener_nombre_modelo = "ERROR";
        }

        return tempobtener_nombre_modelo;
    }


    protected void btnExportExcel_Click(object sender, System.EventArgs e)
    {

        //Dim cadenaHtml1 As String = ""
        //Dim tw As New System.IO.StringWriter
        //Dim hw As New System.Web.UI.HtmlTextWriter(tw)

        //Dim cadena As String
        //cadena = txtDate1.Text & "a" & txtDate2.Text
        //'FILTRO_EXCEL()
        //Response.Clear()
        //Response.Charset = ""
        //Response.Buffer = True
        //Response.ContentType = "application/vnd.ms-excel"
        //cadena = ""
        //Response.AddHeader("content-disposition", "attachment;filename=INF_RESUMEN_DEVOLUCION_" & cadena & ".xls")

        //Response.ContentEncoding = System.Text.Encoding.Default
        //'Grilla_Excel_Factura.RenderControl(hw)
        //'GrillaBoleta.RenderControl(hw)
        //cadenaHtml1 = HTML_Excel()

        //'Response.Write(tw.ToString())
        //Response.Write(cadenaHtml1)
        //Response.End()




        string cadenaHtml = "";

        cadenaHtml = cadenaHtml + "<table border='1'><tr>";
        cadenaHtml = cadenaHtml + "<td colspan='8' align='center'>";
        cadenaHtml = cadenaHtml + "<h3>MANTENEDOR OPERADORES</h3>";
        cadenaHtml = cadenaHtml + "</td>";


        cadenaHtml = cadenaHtml + "</tr></table>";


        cadenaHtml = cadenaHtml + "</table>";
        cadenaHtml = cadenaHtml + "<br></br>";
        cadenaHtml = cadenaHtml + "<br></br>";


        //Call componeHTMLFrac(cadenaHtml)
        Response.Clear();
        Response.Charset = "";
        Response.Buffer = true;
        Response.ContentType = "application/vnd.ms-excel";

        Response.AddHeader("content-disposition", "attachment;filename=AsignacionOT.xls");

        Response.ContentEncoding = System.Text.Encoding.Default;
        //If comboExcel.SelectedIndex = 0 Then 'Excel 97-2000
        //    'Response.ContentEncoding = System.Text.Encoding.UTF7
        //ElseIf comboExcel.SelectedIndex = 1 Then ' Excel 2003 - 2007
        //    Response.ContentEncoding = System.Text.Encoding.UTF8
        //Else
        //    Response.ContentEncoding = System.Text.Encoding.UTF7
        //End If


        //Response.ContentEncoding = System.Text.Encoding.UTF7
        Response.Write(cadenaHtml);
        System.IO.StringWriter tw = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);
        GrillaCortadores_temp.Visible = true;
        GrillaCortadores_temp.RenderControl(hw);
        Response.Write(tw.ToString());
        Response.End();

        // GrillaAnalisisLect_TEMP.Visible = False
        GrillaCortadores_temp.Visible = false;




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
        url = Request.RawUrl;
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

    override protected void OnInit(EventArgs e)
    {
        base.OnInit(e);

        //INSTANT C# NOTE: Converted event handler wireups:
        this.Load += Page_Load;
        GrillaCortadores.EditCommand += MyDataGrid_Edit;
        GrillaCortadores.DeleteCommand += cmDelete;
        btnAgregaLector.Click += btnAgregaLector_Click;
        btnCancelar.Click += btnCancelar_Click;
        btnVolver.Click += btnVolver_Click;
        btnInsertaLector.Click += btnInsertaLector_Click;
        btn_volver2.Click += btn_volver2_Click;
        btn_aceptar.Click += btn_aceptar_Click;
        combo_regiones.SelectedIndexChanged += combo_regiones_SelectedIndexChanged;
        GrillaCortadores.ItemDataBound += GrillaCortadores_ItemDataBound;
        btnExportExcel.Click += btnExportExcel_Click;
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


    internal string validacion_RUT(string P_rut_instalador)
    {
        string resp;
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_INSTALADOR.VALIDA_RUT_AGREGA", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_rut", OracleType.NVarChar, ParameterDirection.Input, P_rut_instalador);

        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        CnOra.Open();
        DataSet dsUsuarios = new DataSet();
        da.Fill(dsUsuarios, "ASIGNACIONES");
        CnOra.Close();
        CnOra.Dispose();


        if (dsUsuarios.Tables["ASIGNACIONES"].Rows.Count != 0)
        {
            resp = "Error: El rut de instalador ya existe para este perfil";
            return resp;
        }
        else
        {
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
    protected void GrillaCortadores_PageIndexChanged(object source, DataGridPageChangedEventArgs e)
    {
        GrillaCortadores.CurrentPageIndex = e.NewPageIndex;
        carga_lectores(lbRutEmpresa.Text);  //string RutEmpresa

    }

   
}





