using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Data.OracleClient;
using System.Data.SqlClient;
using System.Configuration;
using System.Globalization;
using System.Security.Permissions;
using System.Data.OleDb;
using System.Net.Mail;
using System.Collections;

public partial class Usuarios : System.Web.UI.Page
{

    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            try
            {

                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                PRO.recSession(rutaXml, "RUT_EMPRESA");
               
                lb_id_usuario.Text = PRO.recSession(rutaXml, "ID_USUARIO");
                lb_id_perfil.Text = PRO.recSession(rutaXml, "ID_PERFIL");
                lb_id_contratista.Text = PRO.recSession(rutaXml, "ID_CONTRATISTA");

                carga_grilla(tb_busqueda.Text, cb_filtro_busqueda.SelectedValue, lb_id_perfil.Text,lb_id_contratista.Text);

            }
            catch (Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }
        }
    }
    protected void cb_filtro_busqueda_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla(tb_busqueda.Text, cb_filtro_busqueda.SelectedValue, lb_id_perfil.Text,lb_id_contratista.Text);
    }
    protected void tb_busqueda_TextChanged(object sender, EventArgs e)
    {
        carga_grilla(tb_busqueda.Text, cb_filtro_busqueda.SelectedValue, lb_id_perfil.Text,lb_id_contratista.Text);
    }
   
    protected void gridOrden_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            var colsNoVisible = migrilla.DataKeys[migrilla.SelectedIndex].Values;
            String id_usuario;

            id_usuario = (string)colsNoVisible[0];
            rescate_id_usuario.Text = id_usuario;
            main.Visible = false;
            agregar.Visible = true;
            inicializar_campos();
            cargar_usuario(id_usuario);
            btn_guardar.Text = "MODIFICAR USUARIO";
            
        }
        catch (Exception ex)
        {

        }

    }

    protected void btn_buscar_Click(object sender, EventArgs e)
    {
        carga_grilla(tb_busqueda.Text, cb_filtro_busqueda.SelectedValue, lb_id_perfil.Text,lb_id_contratista.Text);

    }

    protected void btn_nuevo_Click(object sender, EventArgs e)
    {
        main.Visible = false;
        agregar.Visible = true;
        inicializar_campos();
        btn_guardar.Text = "GUARDAR NUEVO USUARIO";
    }

    public void inicializar_campos()
    {
        lb_error.Text = "";
        tb_nombres.Text = "";
        tb_apellidos.Text = "";
        tb_rut.Text = "";
        tb_username.Text = "";
        tb_contrasena.Text = "";
        cb_estados.SelectedIndex = 0;
        carga_regiones();
        carga_perfiles(lb_id_perfil.Text);
        carga_contratistas(lb_id_contratista.Text);
    }

    //Cargamos las regiones posibles.
    public void carga_regiones()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_USUARIO_NEW.CARGA_REGIONES", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "REGIONES");
        objConexion.Close();

        int i = 1;
        cb_region_bodegas.Items.Clear();
        cb_region_bodegas.Items.Add("Todas...");
        cb_region_bodegas.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["REGIONES"].Rows)
        {

            cb_region_bodegas.Items.Add(row[0].ToString());
            cb_region_bodegas.Items[i].Value = row[1].ToString();
            i = i + 1;

        }
    }

    //Cargamos las perfiles posibles.
    public void carga_perfiles(String id_perfil)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_USUARIO_NEW.CARGA_PERFILES", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_id_perfil", OracleType.Number, ParameterDirection.Input, id_perfil);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "PERFILES");
        objConexion.Close();

        int i = 1;
        cb_perfiles.Items.Clear();
        cb_perfiles.Items.Add("SELECCIONE...");
        cb_perfiles.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["PERFILES"].Rows)
        {

            cb_perfiles.Items.Add(row[0].ToString());
            cb_perfiles.Items[i].Value = row[1].ToString();
            i = i + 1;

        }
    }

    //Cargamos los contratistas posibles.
    public void carga_contratistas(String contratista)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_USUARIO_NEW.CARGA_CONTRATISTAS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_id_contratista", OracleType.Number, ParameterDirection.Input, contratista);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "CONTRATISTAS");
        objConexion.Close();

        int i = 1;
        if (contratista.Equals("0"))
        {
            cb_contratistas.Items.Clear();
            cb_contratistas.Items.Add("MULTI CONTRATISTA...");
            cb_contratistas.Items[0].Value = "0";

            cb_contratista_bodegas.Items.Clear();
            cb_contratista_bodegas.Items.Add("TODOS...");
            cb_contratista_bodegas.Items[0].Value = "0";
        }
        else
        {
            i = 0;
        }
        

        foreach (DataRow row in objDS.Tables["CONTRATISTAS"].Rows)
        {

            cb_contratistas.Items.Add(row[0].ToString());
            cb_contratistas.Items[i].Value = row[1].ToString();

            cb_contratista_bodegas.Items.Add(row[0].ToString());
            cb_contratista_bodegas.Items[i].Value = row[1].ToString();

            i = i + 1;

        }
    }


    //Cargamos los usuarios del sistema según su filtro de búsqueda, el campo para buscar un usuario en específico y de acuerdo al perfil del usuario logeado.
    public void carga_grilla(String busqueda, String filtro, String perfil,String contratista)
    {
        busqueda = busqueda.Trim(); //quitamos los espacios laterales en blanco.

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_USUARIO_NEW.CARGAR_USUARIOS", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_busqueda", OracleType.NVarChar, ParameterDirection.Input, busqueda);
        PRO.agrega_parametro_sp(da, "i_filtro", OracleType.Number, ParameterDirection.Input, filtro);
        PRO.agrega_parametro_sp(da, "i_id_perfil", OracleType.Number, ParameterDirection.Input, perfil);
        PRO.agrega_parametro_sp(da, "i_id_contratista", OracleType.Number, ParameterDirection.Input, contratista);

        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        DataTable dtOrdenes = new DataTable();

        try
        {
            CnOra.Open();

            da.Fill(dtOrdenes);
            CnOra.Close();
            CnOra.Dispose();
            lb_mensaje.Text = "";
        }
        catch (Exception ex)
        {
            lb_mensaje.ForeColor = System.Drawing.Color.Red;
            lb_mensaje.Text = ex.Message;
        }


        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("ID_USUARIO", typeof(String)));
        dt.Columns.Add(new DataColumn("NOMBRE_COMPLETO", typeof(String)));
        dt.Columns.Add(new DataColumn("RUT", typeof(String)));
        dt.Columns.Add(new DataColumn("USUARIO", typeof(String)));
        dt.Columns.Add(new DataColumn("ESTADO", typeof(String)));
        dt.Columns.Add(new DataColumn("PERFIL", typeof(String)));
        dt.Columns.Add(new DataColumn("CONTRATISTA", typeof(String)));

        DataRow dr;

        int total = 0;

        foreach (DataRow drOrdenItem in dtOrdenes.Rows)
        {

            dr = dt.NewRow();
            dr["ID_USUARIO"] = drOrdenItem["ID_USUARIO"].ToString();
            dr["NOMBRE_COMPLETO"] = drOrdenItem["NOMBRE_COMPLETO"].ToString();
            dr["RUT"] = drOrdenItem["RUT"].ToString();
            dr["USUARIO"] = drOrdenItem["USUARIO"].ToString();
            dr["ESTADO"] = drOrdenItem["ESTADO"].ToString();
            dr["PERFIL"] = drOrdenItem["PERFIL"].ToString();
            dr["CONTRATISTA"] = drOrdenItem["CONTRATISTA"].ToString();

            //if (drOrdenItem["ESTADO"].ToString().Equals("HABILITADO"))
            //{
            //    try
            //    {
            //        Double dias = Double.Parse(drOrdenItem["DIAS_VENCIMIENTO"].ToString());
            //        DateTime fecha_modificada = DateTime.Parse(drOrdenItem["FECHA_CLAVE_MODIFICADA"].ToString());
            //        DateTime hoy = DateTime.Today;

            //        fecha_modificada.AddDays(dias);

            //        if (fecha_modificada < hoy)
            //        {
            //            dr["ESTADO"] = "VENCIDO";
            //        }
            //    }
            //    catch (Exception ex)
            //    {
            //        dr["ESTADO"] = "VENCIDO";
            //        String msg = ex.Message;
            //    }
               

            //}

            dt.Rows.Add(dr);

            total = total + 1;

        }

        DataView MydataView;
        MydataView = new DataView(dt);
        migrilla.DataSource = MydataView;
        migrilla.DataBind();
        migrilla.Columns[0].Visible = false;

        lb_contador.Text = total + " usuario(s) encontrado(s)";

        GridViewRow gvRow;

        for (int i = 0; i < migrilla.Rows.Count; i++)
        {

            gvRow = migrilla.Rows[i];

            if (gvRow.Cells[4].Text.Equals("HABILITADO"))
            {
                gvRow.Cells[4].BackColor = System.Drawing.Color.LightGreen;


            }
            else
            {
                gvRow.Cells[4].BackColor = System.Drawing.Color.IndianRed;

            }

        }

    }

    public Boolean cargar_usuario(String id_usuario)
    {
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_USUARIO_NEW.CARGAR_DATOS_USUARIO", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_id_usuario", OracleType.Number, ParameterDirection.Input, id_usuario);

        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        DataTable dtOrdenes = new DataTable();

        try
        {
            CnOra.Open();

            da.Fill(dtOrdenes);
            CnOra.Close();
            CnOra.Dispose();
            lb_mensaje.Text = "";
        }
        catch (Exception ex)
        {
            lb_mensaje.ForeColor = System.Drawing.Color.Red;
            lb_mensaje.Text = ex.Message;
            return false;
        }


        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("NOMBRE", typeof(String)));
        dt.Columns.Add(new DataColumn("APELLIDO", typeof(String)));
        dt.Columns.Add(new DataColumn("RUT", typeof(String)));
        dt.Columns.Add(new DataColumn("USUARIO", typeof(String)));
        dt.Columns.Add(new DataColumn("ESTADO", typeof(String)));
        dt.Columns.Add(new DataColumn("PERFIL", typeof(String)));
        dt.Columns.Add(new DataColumn("CONTRATISTA", typeof(String)));

        DataRow dr;

        int total = 0;

        foreach (DataRow drOrdenItem in dtOrdenes.Rows)
        {

            dr = dt.NewRow();
            tb_nombres.Text = drOrdenItem["NOMBRE"].ToString();
            tb_apellidos.Text = drOrdenItem["APELLIDO"].ToString();
            tb_rut.Text = drOrdenItem["RUT"].ToString();
            tb_username.Text = drOrdenItem["USUARIO"].ToString();
            tb_contrasena.Text = drOrdenItem["CONTRASENA"].ToString();
            cb_estados.SelectedValue = drOrdenItem["ESTADO"].ToString();
            cb_perfiles.SelectedValue = drOrdenItem["PERFIL"].ToString();
            cb_contratistas.SelectedValue = drOrdenItem["CONTRATISTA"].ToString();

            dt.Rows.Add(dr);

            total = total + 1;

        }

        return true;
    }

    public void guardar_usuario(String id_usuario, String nombres, String apellidos, String rut, String username, String contrasena,
        String estado, String perfil,String contratista, String accion)
    {
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_USUARIO_NEW.GUARDAR_USUARIO", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "i_id_usuario", OracleType.Number, ParameterDirection.Input, id_usuario);
        PRO.agrega_parametro_sp(da, "i_nombre", OracleType.NVarChar, ParameterDirection.Input, nombres);
        PRO.agrega_parametro_sp(da, "i_apellido", OracleType.NVarChar, ParameterDirection.Input, apellidos);
        PRO.agrega_parametro_sp(da, "i_rut", OracleType.NVarChar, ParameterDirection.Input, rut);
        PRO.agrega_parametro_sp(da, "i_username", OracleType.NVarChar, ParameterDirection.Input, username);
        PRO.agrega_parametro_sp(da, "i_contrasena", OracleType.NVarChar, ParameterDirection.Input, contrasena);
        PRO.agrega_parametro_sp(da, "i_estado", OracleType.Number, ParameterDirection.Input, estado);
        PRO.agrega_parametro_sp(da, "i_perfil", OracleType.Number, ParameterDirection.Input, perfil);
        PRO.agrega_parametro_sp(da, "i_contratista", OracleType.Number, ParameterDirection.Input, contratista);
        PRO.agrega_parametro_sp(da, "i_accion", OracleType.Number, ParameterDirection.Input, accion);

        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        try
        {
            CnOra.Open();

            da.SelectCommand.ExecuteNonQuery();           
            CnOra.Close();
            CnOra.Dispose();
            lb_mensaje.ForeColor = System.Drawing.Color.DarkGreen;
            if (accion.Equals("1")) lb_mensaje.Text = "USUARIO CREADO EXITOSAMENTE!";
            else lb_mensaje.Text = "USUARIO MODIFICADO EXITOSAMENTE!";
        }
        catch (Exception ex)
        {
            lb_mensaje.ForeColor = System.Drawing.Color.Red;
            lb_mensaje.Text = ex.Message;
            CnOra.Close();
            CnOra.Dispose();
            
        }
    }

    //panel de agregar, validar campos y guardar o volver, campo de familias para relacionar a los usuarios con ellas.
    protected void btn_guardar_Click(object sender, EventArgs e)
    {
        
        if (validar_formulario())
        {

            main.Visible = true;
            agregar.Visible = false;

            if (btn_guardar.Text.Contains("NUEVO"))
            {
                lb_accion.Text = "1";
                rescate_id_usuario.Text = "0";
            }
            else lb_accion.Text = "0";

            guardar_usuario(rescate_id_usuario.Text, tb_nombres.Text, tb_apellidos.Text, tb_rut.Text, tb_username.Text, tb_contrasena.Text,
                cb_estados.SelectedValue, cb_perfiles.SelectedValue,cb_contratistas.SelectedValue, lb_accion.Text);

            String mi_mensaje = lb_mensaje.Text;
            carga_grilla(tb_busqueda.Text, cb_filtro_busqueda.SelectedValue, lb_id_perfil.Text,lb_id_contratista.Text);

            lb_mensaje.Text = mi_mensaje;
        }
       
       
    }

    public Boolean validar_formulario()
    {
        lb_error.Text = "";
        String respuesta = "";
        int pendientes = 0;

        if (tb_nombres.Text.Length == 0)
        {
            if (pendientes > 0) respuesta = ", Falta ingresar el nombre";
            else respuesta = " Falta ingresar el nombre";

            lb_error.Text = lb_error.Text + respuesta;
            pendientes++;
        }

        if (tb_apellidos.Text.Length == 0)
        {
            if (pendientes > 0) respuesta = ", Falta ingresar el apellido";
            else respuesta = " Falta ingresar el apellido";

            lb_error.Text = lb_error.Text + respuesta;
            pendientes++;
        }

        if (!validarRut(tb_rut.Text))
        {
            if (pendientes > 0) respuesta = ", Rut inválido";
            else respuesta = " Rut inválido";

            lb_error.Text = lb_error.Text + respuesta;
            pendientes++;
        }

        if (btn_guardar.Text.Contains("NUEVO")) lb_accion.Text = "1";
        else lb_accion.Text = "0";


        if (!valida_username(tb_username.Text,lb_accion.Text))
        {
            if (pendientes > 0) respuesta = ", Ya existe usuario";
            else respuesta = " Ya existe usuario";

            lb_error.Text = lb_error.Text + respuesta;
            pendientes++;
        }

        if (tb_contrasena.Text.Length == 0)
        {
            if (pendientes > 0) respuesta = ", Falta ingresar la contraseña";
            else respuesta = " Falta ingresar la contraseña";

            lb_error.Text = lb_error.Text + respuesta;
            pendientes++;
        }

        if (cb_perfiles.SelectedIndex == 0)
        {
            if (pendientes > 0) respuesta = ", Debe seleccionar un perfil";
            else respuesta = " Debe seleccionar un perfil";

            lb_error.Text = lb_error.Text + respuesta;
            pendientes++;
        }

        //hay cosas pendientes? pendientes > 0 indica que quedan pendientes
        if (pendientes > 0) return false;
        else return true;

    }


    public Boolean valida_username(String username,String accion)
    {
        try
        {
            String filtro = "USUARIO = '" + username + "' "; 
            if(accion.Equals("0")) filtro = filtro + "AND ID_USUARIO <> " + rescate_id_usuario.Text; 

            username = username.Trim();
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();
           
            objConexion.Open();
            objComando = new OracleDataAdapter("SELECT USUARIO FROM USUARIO WHERE " + filtro, objConexion);
            objComando.SelectCommand.CommandType = CommandType.Text;

            objComando.SelectCommand.ExecuteNonQuery();
            objComando.Fill(objDS, "VALIDA");
            objConexion.Close();

            int codigo = 0;
            foreach (DataRow row in objDS.Tables["VALIDA"].Rows)
            {
                if (username.Equals(row[0].ToString()))
                {
                    return false;
                }
            }

            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
    }

    protected void btn_volver_Click(object sender, EventArgs e)
    {
        main.Visible = true;
        agregar.Visible = false;
    }


    public bool validarRut(string rut)
    {

        bool validacion = false;
        try
        {
            rut = rut.ToUpper();
            rut = rut.Replace(".", "");
            rut = rut.Replace("-", "");
            int rutAux = int.Parse(rut.Substring(0, rut.Length - 1));

            char dv = char.Parse(rut.Substring(rut.Length - 1, 1));

            int m = 0, s = 1;
            for (; rutAux != 0; rutAux /= 10)
            {
                s = (s + rutAux % 10 * (9 - m++ % 6)) % 11;
            }
            if (dv == (char)(s != 0 ? s + 47 : 75))
            {
                validacion = true;
            }
        }
        catch (Exception)
        {
        }
        return validacion;
    }

    public void checkTodos(String check)
    {
        int c;

        GridViewRow gvRow;
        CheckBox check_row = new CheckBox();
        for (c = 0; c < migrilla_bodega.Rows.Count; c++)
        {

            gvRow = migrilla_bodega.Rows[c];
            check_row = (CheckBox)(gvRow.FindControl(check));

            if ((check_row.Enabled == true))
            {
                if ((check_row.Checked == true))
                {
                    check_row.Checked = false;
                }
                else
                {
                    check_row.Checked = true;
                }
            }
        }
    }

    protected void migrilla_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
           
            if (e.CommandName == "asignar")
            {
                checkTodos("check_asigna");
            }


        }
        catch (Exception ex)
        {

        }
    }


    protected void gridOrden_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            int index = int.Parse(e.CommandArgument.ToString());
            var colsNoVisible = migrilla.DataKeys[index].Values;
            String id_usuario;

            id_usuario = (string)colsNoVisible[0];
            rescate_id_usuario.Text = id_usuario;
           
            if (e.CommandName == "ver_bodegas")
            {
                carga_regiones();
                carga_contratistas(lb_id_contratista.Text);
                carga_permisos_bodega(cb_region_bodegas.SelectedValue,cb_contratista_bodegas.SelectedValue,id_usuario);
                main.Visible = false;
                bodegas.Visible = true;

                lb_mensaje_bodega.Text = migrilla.Rows[index].Cells[1].Text + " [" + migrilla.Rows[index].Cells[5].Text + " - " +  migrilla.Rows[index].Cells[6].Text + "] ";
            }        
            
        }
        catch (Exception ex)
        {
                       
        }
    }

    protected void btn_volver_bodegas_Click(object sender, EventArgs e)
    {
        main.Visible = true;
        bodegas.Visible = false;
    }

    public void carga_permisos_bodega(String region,String contratista,String usuario)
    {

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_USUARIO_NEW.CARGA_PERMISOS_BODEGA", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_id_region", OracleType.NVarChar, ParameterDirection.Input, region);
        PRO.agrega_parametro_sp(da, "i_id_usuario", OracleType.Number, ParameterDirection.Input, usuario);
        PRO.agrega_parametro_sp(da, "i_id_contratista", OracleType.Number, ParameterDirection.Input, contratista);

        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        DataTable dtOrdenes = new DataTable();

        try
        {
            CnOra.Open();

            da.Fill(dtOrdenes);
            CnOra.Close();
            CnOra.Dispose();
            lb_mensaje.Text = "";
        }
        catch (Exception ex)
        {
            lb_mensaje.ForeColor = System.Drawing.Color.Red;
            lb_mensaje.Text = ex.Message;
        }


        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("ID_BODEGA", typeof(String)));
        dt.Columns.Add(new DataColumn("NOMBRE_BODEGA", typeof(String)));
        dt.Columns.Add(new DataColumn("ENCARGADO", typeof(String)));
        dt.Columns.Add(new DataColumn("REGION", typeof(String)));
        dt.Columns.Add(new DataColumn("CONTRATISTA", typeof(String)));
        dt.Columns.Add(new DataColumn("PERMISO", typeof(String)));

        DataRow dr;

        int total = 0;

        foreach (DataRow drOrdenItem in dtOrdenes.Rows)
        {

            dr = dt.NewRow();
            dr["ID_BODEGA"] = drOrdenItem["ID_BODEGA"].ToString();
            dr["NOMBRE_BODEGA"] = drOrdenItem["NOMBRE_BODEGA"].ToString();
            dr["ENCARGADO"] = drOrdenItem["ENCARGADO"].ToString();
            dr["REGION"] = drOrdenItem["REGION"].ToString();
            dr["CONTRATISTA"] = drOrdenItem["CONTRATISTA"].ToString();
            dr["PERMISO"] = drOrdenItem["PERMISO"].ToString();
                       
            dt.Rows.Add(dr);

            total = total + 1;

        }

        DataView MydataView;
        MydataView = new DataView(dt);
        migrilla_bodega.DataSource = MydataView;
        migrilla_bodega.DataBind();

        lb_contador_bodega.Text = total + " bodega(s) encontrada(s)";

        foreach (GridViewRow row in migrilla_bodega.Rows)
        {
            var colsNoVisible = migrilla_bodega.DataKeys[row.RowIndex].Values;
            String permiso = colsNoVisible[1].ToString();
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chkRow = (row.Cells[6].FindControl("check_asigna") as CheckBox);
                if (permiso.Equals("1"))
                {
                    chkRow.Checked = true;
                }
                else
                {
                    chkRow.Checked = false;
                }
            }
        }

      
    }
    protected void btn_guardar_bodegas_Click(object sender, EventArgs e)
    {
        confirmar_permisos(rescate_id_usuario.Text);
    }

    public void confirmar_permisos(String usuario)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter ComandoDA;

        objConexion.Open();
        ComandoDA = new OracleDataAdapter("PK_USUARIO_NEW.ELIMINA_PERMISOS", objConexion);
        ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(ComandoDA, "i_id_usuario", OracleType.Int32, ParameterDirection.Input, usuario);
        ComandoDA.SelectCommand.ExecuteNonQuery();
        objConexion.Close();

        foreach (GridViewRow row in migrilla_bodega.Rows)
        {
            var colsNoVisible = migrilla_bodega.DataKeys[row.RowIndex].Values;
            String bodega = colsNoVisible[0].ToString();

            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chkRow = (row.Cells[6].FindControl("check_asigna") as CheckBox);
                if (chkRow.Checked)
                {
                    agrega_permiso(bodega, usuario);
                }
            }
        }

        lb_mensaje.Text = "PERMISOS DE BODEGA GUARDADOS!";
        bodegas.Visible = false;
        main.Visible = true;
    }

    private void agrega_permiso(String id_bodega,String id_usuario)
    {
        OracleConnection objConn = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter ComandoAGREGAR;

        objConn.Open();
        ComandoAGREGAR = new OracleDataAdapter("PK_USUARIO_NEW.AGREGA_PERMISOS", objConn);
        ComandoAGREGAR.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(ComandoAGREGAR, "i_id_usuario", OracleType.Int32, ParameterDirection.Input, id_usuario);
        PRO.agrega_parametro_sp(ComandoAGREGAR, "i_id_bodega", OracleType.Int32, ParameterDirection.Input, id_bodega);
        ComandoAGREGAR.SelectCommand.ExecuteNonQuery();
        objConn.Close();
    }
    protected void cb_region_bodegas_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_permisos_bodega(cb_region_bodegas.SelectedValue,cb_contratista_bodegas.SelectedValue,rescate_id_usuario.Text);
               
    }
    protected void cb_contratista_bodegas_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_permisos_bodega(cb_region_bodegas.SelectedValue, cb_contratista_bodegas.SelectedValue, rescate_id_usuario.Text);
               
    }
}