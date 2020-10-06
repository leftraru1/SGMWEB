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

public partial class Feriados : System.Web.UI.Page
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

                txtDesde.Text = DateTime.Now.ToString("dd-MM-yyyy");
                lb_id_usuario.Text = PRO.recSession(rutaXml, "ID_USUARIO");
                lb_id_perfil.Text = PRO.recSession(rutaXml, "ID_PERFIL");

                carga_agnos();
                carga_grilla(cb_agno.SelectedValue, lb_id_perfil.Text);

            }
            catch (Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }
        }
    }
    protected void cb_filtro_busqueda_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla(cb_agno.SelectedValue, lb_id_perfil.Text);
    }
    protected void tb_busqueda_TextChanged(object sender, EventArgs e)
    {
        carga_grilla(cb_agno.SelectedValue, lb_id_perfil.Text);
    }
   
    protected void gridOrden_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            var colsNoVisible = migrilla.DataKeys[migrilla.SelectedIndex].Values;
            String id_usuario;

            id_usuario = (string)colsNoVisible[0];
            rescate_id_feriado.Text = id_usuario;
            main.Visible = false;
            agregar.Visible = true;
            inicializar_campos();
            cargar_feriado(id_usuario);
            btn_guardar.Text = "MODIFICAR FERIADO";
            
        }
        catch (Exception ex)
        {

        }

    }

    protected void btn_buscar_Click(object sender, EventArgs e)
    {
        carga_grilla(cb_agno.SelectedValue, lb_id_perfil.Text);
    }

    protected void btn_nuevo_Click(object sender, EventArgs e)
    {
        main.Visible = false;
        agregar.Visible = true;
        inicializar_campos();
        btn_guardar.Text = "GUARDAR NUEVO FERIADO";
    }

    public void inicializar_campos()
    {
        lb_error.Text = "";
        txtDesde.Text = DateTime.Now.ToString("dd-MM-yyyy");
        tb_descripcion.Text = "";  
        carga_regiones();        
        cb_regiones.SelectedIndex = 0;    
    }

    //Cargamos las regiones posibles.
    public void carga_regiones()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_FERIADOS.CARGA_REGIONES", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "REGIONES");
        objConexion.Close();

        int i = 1;
        cb_regiones.Items.Clear();
        cb_regiones.Items.Add("FERIADO NACIONAL");
        cb_regiones.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["REGIONES"].Rows)
        {

            cb_regiones.Items.Add(row[0].ToString());
            cb_regiones.Items[i].Value = row[1].ToString();
            i = i + 1;

        }
    }

    //Cargamos los años posibles
    public void carga_agnos()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_FERIADOS.CARGAR_AGNOS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "AGNOS");
        objConexion.Close();

        int i = 1;
        cb_agno.Items.Clear();
        cb_agno.Items.Add("TODOS...");
        cb_agno.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["AGNOS"].Rows)
        {

            cb_agno.Items.Add(row[0].ToString());
            cb_agno.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }


    
    //Cargamos los feriados según año seleccionado.
    public void carga_grilla(String agno,String perfil)
    {
        
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_FERIADOS.CARGAR_FERIADOS", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_agno", OracleType.Number, ParameterDirection.Input, agno);
        PRO.agrega_parametro_sp(da, "i_id_perfil", OracleType.Number, ParameterDirection.Input, perfil);

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
        dt.Columns.Add(new DataColumn("ID_FERIADO", typeof(String)));
        dt.Columns.Add(new DataColumn("FECHA", typeof(String)));
        dt.Columns.Add(new DataColumn("DESCRIPCION", typeof(String)));
        dt.Columns.Add(new DataColumn("REGION", typeof(String)));

        DataRow dr;

        int total = 0;

        foreach (DataRow drOrdenItem in dtOrdenes.Rows)
        {

            dr = dt.NewRow();
            dr["ID_FERIADO"] = drOrdenItem["ID_FERIADO"].ToString();
            dr["FECHA"] = drOrdenItem["FECHA"].ToString();
            dr["DESCRIPCION"] = drOrdenItem["DESCRIPCION"].ToString();
            dr["REGION"] = drOrdenItem["REGION"].ToString();

            dt.Rows.Add(dr);

            total = total + 1;

        }

        DataView MydataView;
        MydataView = new DataView(dt);
        migrilla.DataSource = MydataView;
        migrilla.DataBind();
        migrilla.Columns[0].Visible = false;

        lb_contador.Text = total + " feriado(s) encontrado(s)";
        
    }

    protected void gridOrden_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        
        try
        {
            int index = int.Parse(e.CommandArgument.ToString());
            string id_feriado;
            
            id_feriado = migrilla.DataKeys[index].Value.ToString();
            if (e.CommandName == "eliminar")
            {
                                
                OracleDataAdapter objComando;
                objConexion.Open();
                
                objComando = new OracleDataAdapter("PK_FERIADOS.ELIMINAR_FERIADO", objConexion);
                objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

                PRO.agrega_parametro_sp(objComando, "i_id_feriado", OracleType.Number, ParameterDirection.Input, id_feriado);



                objComando.SelectCommand.ExecuteNonQuery();

                objConexion.Close();
                objConexion.Dispose();
                carga_grilla(cb_agno.SelectedValue, lb_id_perfil.Text);
                lb_mensaje.ForeColor = System.Drawing.Color.DarkGreen;
                lb_mensaje.Text = "FERIADO ELIMINADO EXITOSAMENTE!";
            }
        }
        catch (Exception ex)
        {
            lb_mensaje.ForeColor = System.Drawing.Color.Red;
            lb_mensaje.Text = ex.Message;
            objConexion.Close();
            objConexion.Dispose();
           
        }
             
    }

    public Boolean cargar_feriado(String id_feriado)
    {
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_FERIADOS.CARGAR_DATOS_FERIADO", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_id_feriado", OracleType.Number, ParameterDirection.Input, id_feriado);

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
        dt.Columns.Add(new DataColumn("FECHA", typeof(String)));
        dt.Columns.Add(new DataColumn("DESCRIPCION", typeof(String)));
        dt.Columns.Add(new DataColumn("REGION", typeof(String)));

        DataRow dr;

        int total = 0;

        foreach (DataRow drOrdenItem in dtOrdenes.Rows)
        {

            dr = dt.NewRow();
            txtDesde.Text = drOrdenItem["FECHA"].ToString();
            tb_descripcion.Text = drOrdenItem["DESCRIPCION"].ToString();
                      
            cb_regiones.SelectedValue = drOrdenItem["REGION"].ToString();

            dt.Rows.Add(dr);

            total = total + 1;

        }

        return true;
    }

    public void guardar_feriado(String id_feriado, String fecha, String descripcion,  String region,String accion)
    {
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_FERIADOS.GUARDAR_FERIADO", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "i_id_feriado", OracleType.Number, ParameterDirection.Input, id_feriado);
        PRO.agrega_parametro_sp(da, "i_fecha", OracleType.NVarChar, ParameterDirection.Input, fecha);
        PRO.agrega_parametro_sp(da, "i_descripcion", OracleType.NVarChar, ParameterDirection.Input, descripcion);
        PRO.agrega_parametro_sp(da, "i_region", OracleType.Number, ParameterDirection.Input, region);
        PRO.agrega_parametro_sp(da, "i_accion", OracleType.Number, ParameterDirection.Input, accion);

        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        try
        {
            CnOra.Open();

            da.SelectCommand.ExecuteNonQuery();           
            CnOra.Close();
            CnOra.Dispose();
            lb_mensaje.ForeColor = System.Drawing.Color.DarkGreen;
            if (accion.Equals("1")) lb_mensaje.Text = "FERIADO CREADO EXITOSAMENTE!";
            else lb_mensaje.Text = "FERIADO MODIFICADO EXITOSAMENTE!";
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
                rescate_id_feriado.Text = "0";
            }
            else lb_accion.Text = "0";

            if (valida_feriado(txtDesde.Text, cb_regiones.SelectedValue,rescate_id_feriado.Text))
            {
                guardar_feriado(rescate_id_feriado.Text, txtDesde.Text, tb_descripcion.Text, cb_regiones.SelectedValue, lb_accion.Text);
            }
            else
            {
                lb_mensaje.ForeColor = System.Drawing.Color.Red;
                lb_mensaje.Text = "YA SE ENCUENTRA REGISTRADO UN FERIADO EN LA FECHA INDICADA (PUEDEN HABER 1 O MÁS FERIADOS PERO NO DE LA MISMA REGIÓN).";
            }
            String mi_mensaje = lb_mensaje.Text;
            carga_grilla(cb_agno.SelectedValue, lb_id_perfil.Text);

            lb_mensaje.Text = mi_mensaje;
        }
       
       
    }

    public Boolean valida_feriado(String fecha, String region,String id_feriado)
    {
        try
        {
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();

            String filtro_mod;

            if (!id_feriado.Equals("0")) filtro_mod = " AND ID_FERIADO <> " + id_feriado;
            else filtro_mod = "";
            
            objConexion.Open();
            objComando = new OracleDataAdapter("SELECT COUNT(ID_FERIADO) FROM FERIADOS WHERE (FECHA = TO_DATE('" + txtDesde.Text + "','DD/MM/RRRR') AND (REGION = 0 OR REGION = " + region + " OR " + region + " = 0)) " + filtro_mod, objConexion);
            objComando.SelectCommand.CommandType = CommandType.Text;

            objComando.SelectCommand.ExecuteNonQuery();
            objComando.Fill(objDS, "VALIDA");
            objConexion.Close();

            int codigo = 0;
            foreach (DataRow row in objDS.Tables["VALIDA"].Rows)
            {
                if (row[0].ToString().Equals("0"))
                {
                    return true;
                }
                else return false;
            }

            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
    }

    public Boolean validar_formulario()
    {
        lb_error.Text = "";
        String respuesta = "";
        int pendientes = 0;
        
        if (tb_descripcion.Text.Length == 0)
        {
            if (pendientes > 0) respuesta = ", Falta ingresar una descripción";
            else respuesta = " Falta ingresar una descripción";

            lb_error.Text = lb_error.Text + respuesta;
            pendientes++;
        }

       
        if (btn_guardar.Text.Contains("NUEVO")) lb_accion.Text = "1";
        else lb_accion.Text = "0";
              

        //hay cosas pendientes? pendientes > 0 indica que quedan pendientes
        if (pendientes > 0) return false;
        else return true;

    }
      
    protected void btn_volver_Click(object sender, EventArgs e)
    {
        main.Visible = true;
        agregar.Visible = false;
    }



    protected void cb_regiones_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla(cb_agno.SelectedValue, lb_id_perfil.Text);
    }
    protected void ddTipoPro_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla(cb_agno.SelectedValue, lb_id_perfil.Text);
    }
}