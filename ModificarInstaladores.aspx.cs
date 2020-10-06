using System;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Data.OracleClient;
using System.Web.UI.WebControls;
using System.Xml;


partial class ModificarInstalador : System.Web.UI.Page
{
    private Procedimientos PRO = new Procedimientos();
    private string conexion_cliente_oracle = ConfigurationSettings.AppSettings["ConnectionString_ClienteOracle"];
    public DataTable dt;

    public void recupera_session()
    {

        XmlDataDocument recupera_xml = new XmlDataDocument();
        recupera_xml.Load(Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml");
        string session_user = null;
        string session_empresa = null;
        session_user = recupera_xml.SelectSingleNode("SESSION/DATOS_USUARIO/NOMBRE").InnerText;
        session_empresa = recupera_xml.SelectSingleNode("SESSION/DATOS_USUARIO/NOMBRE_EMPRESA").InnerText;
        //lbEmpresaLector.Text = recupera_xml.SelectSingleNode("SESSION/DATOS_USUARIO/NOMBRE_EMPRESA").InnerText;
        //lb_session_user.Text = ": " + session_user + " / ";
        //lb_session_empresa.Text = ": " + session_empresa;
        //LB_id_usuario.Text = recupera_xml.SelectSingleNode("SESSION/DATOS_USUARIO/ID_USUARIO").InnerText;
        //LB_id_usuario.Visible = false;
        lbRutEmpresa.Text = recupera_xml.SelectSingleNode("SESSION/DATOS_USUARIO/RUT_EMPRESA").InnerText;

    }

    protected void Page_Load(object sender, System.EventArgs e)
    {
        txt_cantidad_descarga.Visible = false;
        this.RequiredFieldValidator6.Visible = false;

        Response.Buffer = true;
        Response.AddHeader("Pragma", "no-cache");
        Response.CacheControl = "no-cache";
        Response.Expires = -1;
        Response.Cookies.Clear();
        Response.Clear();

        string nom_foto_cortador = null;
        nom_foto_cortador = "CORTADOR_ID_" + Convert.ToString(Request.QueryString["idlector"]).Trim(' ') + ".JPG";
        //foto_cortador.Visible = true;
        //foto_cortador.ImageUrl = ResolveUrl("~/images/operadores/" + nom_foto_cortador);

        if (!Page.IsPostBack)
        {
            recupera_session();
            lb_id_cortador.Text = Convert.ToString(Request.QueryString["idlector"]).Trim(' ');
            lb_id_cortador.Visible = false;


            PRO.Combo_Contratistas_SoloItems(combo_contratistas, "PK_CONTRATISTA.CARGA_CONTRATISTAS_X_EMPRESA", lbRutEmpresa.Text.Trim(' '));

            btnNewEdit.Enabled = false;
            lb_mensaje_edicion.Visible = false;
            img_ok.Visible = false;
            lb_error.Visible = false;

            //llenamos combos
            llena_combo_regiones(lbRutEmpresa.Text);
            llena_combo_modelo_maquina(lbRutEmpresa.Text);

            //Llena_combo_zonas_inicial()
            //llena_combo_estados_lector()


            consulta_cortador_porID();


            //Se oculta objeto "Solicitud Fotografía"
            combo_fotografia.Visible = false;


        }
    }

    public void consulta_cortador_porID()
    {
        string ID_Cortador = Request.QueryString["idlector"];
        lb_id_cortador.Text = Convert.ToString(Request.QueryString["idlector"]).Trim(' ');
        lbRutEmpresa.Visible = false; //CAMPO OCULTO --- RUT de la empresa
        lbIDRegion.Visible = false; // CAMPO OCULTO --- ID de Region del Lector

        string sSQL = null;
        OracleDataAdapter objComando = null; //OleDbDataAdapter
        DataTable dtLectores = new DataTable();
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle); //OleDbConnection(conexion)
        objConexion.Open();

        sSQL = "select * from instalador where id_instalador=" + ID_Cortador; // Para rellenar combo
        objComando = new OracleDataAdapter(sSQL, conexion_cliente_oracle);
        objComando.Fill(dtLectores);
        objConexion.Close();
        objConexion.Dispose();

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
        dt.Columns.Add(new DataColumn("cantidad", typeof(string)));
        dt.Columns.Add(new DataColumn("fotografia", typeof(string)));
        dt.Columns.Add(new DataColumn("numero_telefono", typeof(string)));
        dt.Columns.Add(new DataColumn("serie_maquina", typeof(string)));
        dt.Columns.Add(new DataColumn("id_modelo", typeof(string)));
        dt.Columns.Add(new DataColumn("id_contratista", typeof(string)));
        dt.Columns.Add(new DataColumn("email", typeof(string)));
        dt.Columns.Add(new DataColumn("forma_gestion", typeof(string)));


        DataRow dr = null;
        foreach (System.Data.DataRow drLectorItem in dtLectores.Rows)
        {
            dr = dt.NewRow();
            dr["id_instalador"] = drLectorItem["id_instalador"].ToString();
            dr["id_region"] = drLectorItem["id_region"].ToString();
            dr["id_zona"] = drLectorItem["id_zona"].ToString();
            dr["rut_empresa"] = drLectorItem["rut_empresa"].ToString();
            dr["cod_instalador"] = drLectorItem["cod_instalador"].ToString();
            dr["apellido"] = drLectorItem["apellido"].ToString();
            dr["nombre"] = drLectorItem["nombre"].ToString();
            dr["nom_empresa"] = "EMPRESA"; //OBTIENE_NOMBRE_EMPRESA(drUsuarioItem("rut_empresa").ToString) '"Empresa" 'Funcion que entrege Empresa 'drUsuarioItem("nom_empresa").ToString
            dr["clave_admin"] = drLectorItem["clave_admin"].ToString();
            dr["clave_instalador"] = drLectorItem["clave_instalador"].ToString();
            dr["estado"] = drLectorItem["estado"].ToString();

            dr["cantidad"] = drLectorItem["cantidad"].ToString();
            dr["fotografia"] = drLectorItem["fotografia"].ToString();


            dr["numero_telefono"] = drLectorItem["numero_telefono"].ToString();
            dr["serie_maquina"] = drLectorItem["serie_maquina"].ToString();
            dr["id_modelo"] = drLectorItem["id_modelo"].ToString();
            dr["id_contratista"] = drLectorItem["id_contratista"].ToString();

            dr["email"] = drLectorItem["email"].ToString();
            dr["forma_gestion"] = drLectorItem["forma_gestion"].ToString();

            dt.Rows.Add(dr);
        }

        txt_codLector.Text = dt.Rows[0]["cod_instalador"].ToString();
        txt_nomLector.Text = dt.Rows[0]["nombre"].ToString();
        txt_apeLector.Text = dt.Rows[0]["apellido"].ToString();
        txt_claveAdmin.Text = dt.Rows[0]["clave_admin"].ToString();
        txt_ClaveInstalador.Text = dt.Rows[0]["clave_instalador"].ToString();
        lbRutEmpresa.Text = dt.Rows[0]["rut_empresa"].ToString();
        lbIDRegion.Text = dt.Rows[0]["id_region"].ToString();

        txt_cantidad.Text = dt.Rows[0]["cantidad"].ToString();
        combo_fotografia.SelectedValue = dt.Rows[0]["fotografia"].ToString();

        //'''''''
        txt_num_celular.Text = dt.Rows[0]["numero_telefono"].ToString();
        txt_serie_maquina.Text = dt.Rows[0]["serie_maquina"].ToString();
        combo_modelo.Text = dt.Rows[0]["id_modelo"].ToString();
        //''''''''''''''

        combo_regiones.Text = dt.Rows[0]["id_region"].ToString();

        Llena_combo_zonas(combo_regiones.Items[combo_regiones.SelectedIndex].Value, 0.ToString());

        combo_zonaLector.Text = dt.Rows[0]["id_zona"].ToString();


        //combo_estado_lector.Items(combo_estado_lector.SelectedIndex).Value = dt.Rows(0).Item("estado").ToString();
        combo_estado_lector.SelectedValue = dt.Rows[0]["estado"].ToString();

        combo_contratistas.SelectedValue = dt.Rows[0]["id_contratista"].ToString();

        txt_email.Text = dt.Rows[0]["email"].ToString().Trim(' ');

        if (dt.Rows[0]["forma_gestion"].ToString().Trim(' ') == "PDA")
        {
            cmb_formagestion.SelectedIndex = 0; //Utiliza PDA
        }
        else
        {
            cmb_formagestion.SelectedIndex = 1; //Utiliza PAPEL
        }


        //Response.Write(dt.Rows(0).Item("id_zona").ToString)
        //Response.End()

        //Llena_combo_zonas(lbIDRegion.Text, dt.Rows(0).Item("id_zona").ToString)
        //llena_combo_regiones(lbRutEmpresa.Text)


        //Dim MydataView As DataView
        //MydataView = New DataView(dt)
        //GrillaUsuarios.DataSource = MydataView
        //GrillaUsuarios.DataBind()
    }
    private void llena_combo_regiones(string rut_de_empresa)
    {

        string sql_regiones = null;
        DataTable dtRegiones = new DataTable();
        sql_regiones = "select * from REGION where rut_empresa='" + rut_de_empresa + "'"; // Para rellenar combo

        OracleDataAdapter objComando_Regiones = null;
        objComando_Regiones = new OracleDataAdapter(sql_regiones, conexion_cliente_oracle);
        objComando_Regiones.Fill(dtRegiones);


        string valueCombo = null;
        string textoCombo = null;

        combo_regiones.Items.Clear();
        foreach (System.Data.DataRow drRegionItem in dtRegiones.Rows)
        {
            valueCombo = drRegionItem["id_region"].ToString();
            textoCombo = drRegionItem["descripcion"].ToString();
            combo_regiones.Items.Add(new ListItem(textoCombo, valueCombo));
        }

        //Llena_combo_zonas(combo_regiones.Items(combo_regiones.SelectedIndex).Value, 0)

    }
    private void Llena_combo_zonas(string id_de_region, string id_de_zona)
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

        //combo_zonaLector.SelectedValue = id_de_zona

    }

    private void Llena_combo_zonas_inicial()
    {

        string sql_zonas = null;
        DataTable dtZonas = new DataTable();
        sql_zonas = "select * from ZONA "; // Para rellenar combo"

        OracleDataAdapter objComando_Zonas = null;
        objComando_Zonas = new OracleDataAdapter(sql_zonas, conexion_cliente_oracle);
        objComando_Zonas.Fill(dtZonas);
        string valueCombo = null;
        string textoCombo = null;

        combo_zonaLector.Items.Clear();
        foreach (System.Data.DataRow drZonaItem in dtZonas.Rows)
        {
            valueCombo = drZonaItem["id_zona"].ToString();
            textoCombo = drZonaItem["nombre"].ToString();
            combo_zonaLector.Items.Add(new ListItem(textoCombo, valueCombo));
        }

        //combo_zonaLector.SelectedValue = id_de_zona
    }

    public string UPLOAD_FOTO_CORTADOR(FileUpload P_OBJ_FILE_UPLOAD, string P_ID_CORTADOR)
    {
        string tempUPLOAD_FOTO_CORTADOR = null;

        if (string.IsNullOrEmpty(P_OBJ_FILE_UPLOAD.FileName.ToString().Trim(' ')))
        {

            tempUPLOAD_FOTO_CORTADOR = "OK";

        }
        else
        {
            string nombre_fotografia = null;
            string fileExtension1 = System.IO.Path.GetExtension(P_OBJ_FILE_UPLOAD.PostedFile.FileName);
            if (!string.IsNullOrEmpty(fileExtension1))
            {
                if (fileExtension1 != ".jpg" && fileExtension1 != ".JPG" && fileExtension1 != ".JPEG" && fileExtension1 != ".jpeg")
                {
                    return "FORMATO IMAGEN INCORRECTO";
                }
            }

            try
            {
                nombre_fotografia = "INSTALADOR_ID_" + P_ID_CORTADOR + ".JPG"; //fileExtension1
                P_OBJ_FILE_UPLOAD.SaveAs(Server.MapPath("./images/instaladores/" + nombre_fotografia));
                //imagen_cortador.ImageUrl = Server.MapPath("./images/operadores/" & nombre_fotografia)

            }
            catch (Exception ex)
            {
                return "ERROR AL SUBIR IMAGEN";
            }

            tempUPLOAD_FOTO_CORTADOR = "OK";

        }

        return tempUPLOAD_FOTO_CORTADOR;
    }


    public string validadacion_Codigo_Lector(string P_CODIGO_LECTOR)
    {
        string tempvalidadacion_Codigo_Lector = null;


        if (ER_codLector.IsValid)
        {
            P_CODIGO_LECTOR = PRO.CadenaSinCeros(P_CODIGO_LECTOR.Trim(' '));
        }
        else
        {
            return "CÓDIGO OPERADOR DEBE SER NUMÉRICO!";
        }

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_INSTALADOR.VALIDA_INSTALADOR_EXISTE_UPD", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_cod_instalador", OracleType.NVarChar, ParameterDirection.Input, P_CODIGO_LECTOR);
        PRO.agrega_parametro_sp(da, "i_rut_empresa", OracleType.Number, ParameterDirection.Input, lbRutEmpresa.Text);

        string ID_Lector_temp = Request.QueryString["idlector"];
        PRO.agrega_parametro_sp(da, "i_id_instalador", OracleType.Int32, ParameterDirection.Input, ID_Lector_temp);

        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        CnOra.Open();
        DataSet dsLectores = new DataSet();
        da.Fill(dsLectores, "INSTALADORES");
        CnOra.Close();
        CnOra.Dispose();

        if (dsLectores.Tables["INSTALADORES"].Rows.Count != 0)
        {
            //Response.Write("<script>")
            //Response.Write("alert('Eliminación Denegada, Lector tiene asignaciones relacionadas!');")
            //Response.Write("</script>")
            //Response.Write("Nombre de Usuario Existe en la Base de Datos! Elija Otro.")
            tempvalidadacion_Codigo_Lector = "CÓDIGO DE INSTALADOR EXISTE EN LE BASE DE DATOS! ELIJA OTRO.";
        }
        else
        {
            //Response.Write("<script>")
            //Response.Write("if (confirm('Mensaje de confirmación !  \n \n Esta seguro que desea eliminar el registro del Lector Seleccionado ?')) { document.location.href='EliminarLector.aspx?idlector=" & GrillaLectores.Items(indice).Cells(0).Text & "'; }")
            //Response.Write("</script>")
            tempvalidadacion_Codigo_Lector = "OK";
        }

        return tempvalidadacion_Codigo_Lector;
    }

    public void desabilita_edicion(bool c_estado)
    {
        txt_codLector.Enabled = c_estado;
        txt_nomLector.Enabled = c_estado;
        txt_apeLector.Enabled = c_estado;
        txt_claveAdmin.Enabled = c_estado;
        txt_ClaveInstalador.Enabled = c_estado;
        combo_regiones.Enabled = c_estado;
        combo_zonaLector.Enabled = c_estado;
        btn_Actualiza.Enabled = c_estado;
        btnNewEdit.Enabled = !(c_estado);
        lb_mensaje_edicion.Visible = !(c_estado);
        img_ok.Visible = !(c_estado);
        //txt_cantidad_descarga.Enabled = c_estado
        combo_fotografia.Enabled = c_estado;
        combo_estado_lector.Enabled = c_estado;

        txt_num_celular.Enabled = c_estado;
        txt_serie_maquina.Enabled = c_estado;
        combo_modelo.Enabled = c_estado;
        txt_email.Enabled = c_estado;

        this.cmb_formagestion.Enabled = c_estado;
        this.combo_contratistas.Enabled = c_estado;


    }

    public object llena_combo_modelo_maquina(object p_RutEmpresa)
    {

        OracleConnection oraconn = new OracleConnection(conexion_cliente_oracle);
        OracleCommand oracmd = new OracleCommand();
        oracmd.CommandText = "PK_MODELO.obtiene_modelo";
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
        combo_modelo.Items.Clear();
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

    protected void btn_Actualiza_Click(object sender, System.EventArgs e)
    {
        Response.Buffer = true;
        Response.AddHeader("Pragma", "no-cache");
        Response.CacheControl = "no-cache";
        Response.Expires = -1;
        //int aux;
        //if (dr_foto.Text == "Sin Fotografía")
        //    aux = 0;
        //else
        //    aux = 1;


        if (txt_ClaveInstalador.Text != txt_claveAdmin.Text)
        {


            lb_valida_claves.Visible = false;
            string str_valida_codigo = null;
            string str_carga_imagen = null;
            str_valida_codigo = validadacion_Codigo_Lector(txt_codLector.Text.Trim(' '));
            //str_carga_imagen = UPLOAD_FOTO_CORTADOR(FileUpload_Cortador, lb_id_cortador.Text.Trim(' '));

            if (str_valida_codigo == "OK")
            {


                lb_valida_claves.Visible = false;
                string ID_Lector_UPDATE = Request.QueryString["idlector"];

                OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle); //OleDbConnection(conexion)
                objConexion.Open();
                OracleDataAdapter ComandoDA = null;
                ComandoDA = new OracleDataAdapter("PK_INSTALADOR.UPDATE_INSTALADORES", objConexion);

                ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

                PRO.agrega_parametro_sp(ComandoDA, "i_id_instalador", OracleType.Int32, ParameterDirection.Input, ID_Lector_UPDATE.ToString());
                PRO.agrega_parametro_sp(ComandoDA, "i_id_region", OracleType.Int32, ParameterDirection.Input, combo_regiones.Items[combo_regiones.SelectedIndex].Value);
                PRO.agrega_parametro_sp(ComandoDA, "i_id_zona", OracleType.Int32, ParameterDirection.Input, combo_zonaLector.Items[combo_zonaLector.SelectedIndex].Value);
                PRO.agrega_parametro_sp(ComandoDA, "i_rut_empresa", OracleType.Number, ParameterDirection.Input, lbRutEmpresa.Text);
                PRO.agrega_parametro_sp(ComandoDA, "i_cod_instalador", OracleType.NVarChar, ParameterDirection.Input, PRO.CadenaSinCeros(txt_codLector.Text.Trim(' ')));
                PRO.agrega_parametro_sp(ComandoDA, "i_clave_admin", OracleType.NVarChar, ParameterDirection.Input, txt_claveAdmin.Text);
                PRO.agrega_parametro_sp(ComandoDA, "i_clave_instalador", OracleType.NVarChar, ParameterDirection.Input, txt_ClaveInstalador.Text);
                PRO.agrega_parametro_sp(ComandoDA, "i_estado", OracleType.Int32, ParameterDirection.Input, combo_estado_lector.Items[combo_estado_lector.SelectedIndex].Value);
                PRO.agrega_parametro_sp(ComandoDA, "i_apellido_instalador", OracleType.NVarChar, ParameterDirection.Input, txt_apeLector.Text);
                PRO.agrega_parametro_sp(ComandoDA, "i_nombre_instalador", OracleType.NVarChar, ParameterDirection.Input, txt_nomLector.Text);
                PRO.agrega_parametro_sp(ComandoDA, "i_cantidad", OracleType.Int32, ParameterDirection.Input, txt_cantidad.Text);
                PRO.agrega_parametro_sp(ComandoDA, "i_fotografia", OracleType.Int32, ParameterDirection.Input, dr_foto.Items[dr_foto.SelectedIndex].Value);
                PRO.agrega_parametro_sp(ComandoDA, "i_numero_telefono", OracleType.NVarChar, ParameterDirection.Input, txt_num_celular.Text);
                PRO.agrega_parametro_sp(ComandoDA, "i_serie_maquina", OracleType.NVarChar, ParameterDirection.Input, txt_serie_maquina.Text);
                PRO.agrega_parametro_sp(ComandoDA, "i_id_modelo", OracleType.Int32, ParameterDirection.Input, combo_modelo.Text);
                PRO.agrega_parametro_sp(ComandoDA, "i_id_contratista", OracleType.Int32, ParameterDirection.Input, combo_contratistas.Items[combo_contratistas.SelectedIndex].Value);
                PRO.agrega_parametro_sp(ComandoDA, "i_email", OracleType.NVarChar, ParameterDirection.Input, txt_email.Text.Trim(' '));
                PRO.agrega_parametro_sp(ComandoDA, "i_forma_gestion", OracleType.NVarChar, ParameterDirection.Input, cmb_formagestion.Items[cmb_formagestion.SelectedIndex].Text.Trim(' '));


                try
                {
                    ComandoDA.SelectCommand.ExecuteNonQuery();
                    lb_mensaje_edicion.Visible = true;
                    img_ok.Visible = true;
                    lb_mensaje_edicion.Text = "Información del Instalador actualizada exitosamente!";
                    desabilita_edicion(false);
                    lb_error.Visible = false;

                    string nom_foto_cortador = null;
                    nom_foto_cortador = "INSTALADOR_ID_" + Convert.ToString(Request.QueryString["idlector"]).Trim(' ') + ".JPG";
                    //foto_cortador.Visible = true;
                    //foto_cortador.ImageUrl = ResolveUrl("~/images/instaladores/" + nom_foto_cortador);


                    //*********************** INSERTAMOS LOG DEL SISTEMA ***********************************
                    try
                    {
                        string str_fecha = null;
                        string str_hora = null;
                        string str_desc_evento = null;
                        str_fecha = DateTime.Now.ToString().Substring(0, 10).Trim(' ');
                        str_hora = DateTime.Now.ToString().Substring(10, 9).Trim(' ');
                        str_desc_evento = "SE ACTUALIZO EL INSTALADOR CON CODIGO " + txt_codLector.Text;
                        PRO.Insertamos_log_del_Sistema(LB_id_usuario.Text, lbRutEmpresa.Text, str_fecha, str_hora, str_desc_evento, "0", "0", Request.ServerVariables["REMOTE_ADDR"].ToString());
                    }
                    catch (Exception ex)
                    {
                    }
                    //**************************************************************************************

                }
                catch (Exception ex)
                {
                    lb_mensaje_edicion.Visible = false;
                    lb_error.Visible = true;
                    img_ok.Visible = false;
                    lb_error.Text = "Se ha producido un error en la actualización! Inténtelo nuevamente.";

                }


            }
            else
            {

                lb_valida_claves.Visible = true;
                lb_valida_claves.Text = str_valida_codigo;


            }

        }
        else
        {

            lb_valida_claves.Visible = true;
            lb_valida_claves.Text = "NO SE PERMITE CLAVE ADMINISTRADOR = CLAVE INSTALADOR!";

        }
    }

    protected void btnNewEdit_Click(object sender, System.EventArgs e)
    {
        desabilita_edicion(true);
    }

    protected void btn_volver_Click(object sender, System.EventArgs e)
    {
        Response.Redirect("MantencionInstaladores.aspx");
    }

    protected void combo_regiones_SelectedIndexChanged(object sender, System.EventArgs e)
    {
        Llena_combo_zonas(combo_regiones.Items[combo_regiones.SelectedIndex].Value, 0.ToString());
    }

    override protected void OnInit(EventArgs e)
    {
        base.OnInit(e);

        //INSTANT C# NOTE: Converted event handler wireups:
        this.Load += Page_Load;
        btn_Actualiza.Click += btn_Actualiza_Click;
        btnNewEdit.Click += btnNewEdit_Click;
        btn_volver.Click += btn_volver_Click;
        combo_regiones.SelectedIndexChanged += combo_regiones_SelectedIndexChanged;
    }
}