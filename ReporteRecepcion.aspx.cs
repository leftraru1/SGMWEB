using System;
using System.Collections.Generic;
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
using System.Drawing;

public partial class RecepcionLecturas : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();
    public String rutaGlobal;
    public DataTable dt;
    public DataTable detalle;
    public String valor_duplicados;
    public String valor_error;

    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            
            try
            {
                                      
                
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                PRO.recSession(rutaXml, "RUT_EMPRESA");

                
                txt_fecha_desde.Text = DateTime.Now.ToString("dd-MM-yyyy");
                txt_fecha_hasta.Text = DateTime.Now.ToString("dd-MM-yyyy");
                actualizar_controles("");

            }
            catch (Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }
        }
        

    }

    public void actualizar_controles(String accion)
    {
        if (accion == "ver detalle")
        {
            gvDetalle.Visible = true;
            lb_registros2.Visible = true;
            lb_detalle.Visible = true;
            lb1.Visible = true;
            lb2.Visible = true;
            lb3.Visible = true;
            lb4.Visible = true;
        }
        else if (accion == "buscar procesos")
        {
            gvProceso.SelectedIndex = -1;
            gvDetalle.Visible = false;
            lb_registros2.Visible = false;
            lb_detalle.Visible = false;
            gvProceso.Visible = true;
            lb_registros.Visible = true;
            lb_procesos.Visible = true;
            lb1.Visible = false;
            lb2.Visible = false;
            lb3.Visible = false;
            lb4.Visible = false;
            txt_fecha.Text = "";
            txt_proceso.Text = "";
            txt_grupo.Text = "";
            txt_tipo.Text = "";
            lb_error.Text = "";
        }
        else
        {
            lb1.Visible = false;
            lb2.Visible = false;
            lb3.Visible = false;
            lb4.Visible = false;
            gvDetalle.Visible = false;
            lb_registros2.Visible = false;
            lb_detalle.Visible = false;
            gvProceso.Visible = false;
            lb_registros.Visible = false;
            lb_procesos.Visible = false;
        }
    }

    public void carga_info_proceso(String P_ID_PROCESO)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_LOG.OBTIENE_INFO_PROCESO", objConexion);

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_id_proceso", OracleType.NVarChar, ParameterDirection.Input, P_ID_PROCESO);

        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;
        DataTable dtProcesos = new DataTable();

        objComando.Fill(dtProcesos);
        objConexion.Close();
        objConexion.Dispose();

        dt = new DataTable();
        dt.Columns.Add(new DataColumn("GRUPO_PROCESO", typeof(string)));
        dt.Columns.Add(new DataColumn("TIPO_PROCESO", typeof(string)));
        dt.Columns.Add(new DataColumn("FECHA", typeof(string)));

        foreach (DataRow drItem in dtProcesos.Rows)
        {

            txt_proceso.Text = P_ID_PROCESO;
            txt_grupo.Text = drItem["GRUPO_PROCESO"].ToString();
            txt_tipo.Text = drItem["TIPO"].ToString();
            txt_fecha.Text = drItem["FECHA_PROCESO"].ToString();
            
        }

        
    }

    public void cargar_detalle(String P_ID_PROCESO)
    {
        actualizar_controles("ver detalle");
        carga_info_proceso(P_ID_PROCESO);
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_LOG.OBTIENE_LOG_DETALLE", objConexion);

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_id_proceso", OracleType.NVarChar, ParameterDirection.Input, P_ID_PROCESO);

        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;
        DataTable dtProcesos = new DataTable();

        objComando.Fill(dtProcesos);
        objConexion.Close();
        objConexion.Dispose();

        DataRow dr;
        int cont = 0;
        dt = new DataTable();
        dt.Columns.Add(new DataColumn("#", typeof(string)));
        dt.Columns.Add(new DataColumn("NRO_ORDEN", typeof(string)));
        dt.Columns.Add(new DataColumn("SERVICIO", typeof(string)));
        dt.Columns.Add(new DataColumn("MENSAJE_ERROR", typeof(string)));
        

        foreach (DataRow drItem in dtProcesos.Rows)
        {

            dr = dt.NewRow();
            dr["#"] = cont + 1;
            dr["NRO_ORDEN"] = drItem["NUMERO_ORDEN"].ToString();
            dr["SERVICIO"] = drItem["ID_SERVICIO"].ToString();
            dr["MENSAJE_ERROR"] = drItem["MENSAJE_ERROR"].ToString();
            dt.Rows.Add(dr);
            cont += 1;
        }

        DataView MydataViewvsita = new DataView();
        MydataViewvsita = new DataView(dt);
        gvDetalle.DataSource = MydataViewvsita;
        gvDetalle.DataBind();
        gvDetalle.Visible = true;
        lb_registros2.Text = cont + " Coincidencia(s) encontrada(s)";
    }

    protected bool validar_fecha(String fecha)
    {

        try
        {
            DateTime dt = DateTime.Parse(fecha);
            return true;
        }
        catch
        {
            return false;
        }

    }

    protected void buscar_procesos(object sender, EventArgs e)
    {
        if (validar_fecha(txt_fecha_desde.Text) && validar_fecha(txt_fecha_hasta.Text))
        {
            if (DateTime.Parse(txt_fecha_desde.Text) <= DateTime.Parse(txt_fecha_hasta.Text))
            {
                cargar_procesos(txt_fecha_desde.Text, txt_fecha_hasta.Text);
            }
            else
            {
                actualizar_controles("");
                lb_error.Text = "La fecha inicial no puede ser menor a la final!";
            }
        }
        else
        {
            actualizar_controles("");
            lb_error.Text = "Formato de fecha no válido";
        }
        
    }

    public void cargar_procesos(String P_FECHA_DESDE, String P_FECHA_HASTA)
    {
        actualizar_controles("buscar procesos");
        
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_LOG.OBTIENE_LOG_PROCESOS", objConexion);
        
        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_fecha_desde", OracleType.NVarChar  , ParameterDirection.Input , P_FECHA_DESDE);
        PRO.agrega_parametro_sp(objComando, "i_fecha_hasta", OracleType.NVarChar  , ParameterDirection.Input , P_FECHA_HASTA);
        
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;
        DataTable dtProcesos = new DataTable();
        
        objComando.Fill(dtProcesos);
        objConexion.Close();
        objConexion.Dispose();

        DataRow dr;
        int cont = 0;
        dt = new DataTable();
        dt.Columns.Add(new DataColumn("#", typeof(string)));
        dt.Columns.Add(new DataColumn("ID_PROCESO", typeof(string)));
        dt.Columns.Add(new DataColumn("NOM_ARCHIVO", typeof(string)));
        dt.Columns.Add(new DataColumn("REGION", typeof(string)));
        dt.Columns.Add(new DataColumn("FECHA", typeof(string)));
        dt.Columns.Add(new DataColumn("DUPLICADOS", typeof(string)));
        dt.Columns.Add(new DataColumn("ERRORES", typeof(string)));
        dt.Columns.Add(new DataColumn("CARGADOS", typeof(string)));
        dt.Columns.Add(new DataColumn("ESTADO", typeof(string)));
        
        foreach (DataRow drItem in dtProcesos.Rows)
        {
            
            dr = dt.NewRow();
            dr["#"] = cont+1;
            dr["ID_PROCESO"] = drItem["ID_PROCESO"].ToString();
            dr["NOM_ARCHIVO"] = drItem["NOM_ARCHIVO"].ToString();
            dr["REGION"] = drItem["REGION"].ToString();
            dr["FECHA"] = drItem["FECHA"].ToString().Substring(0, 10); 
            dr["DUPLICADOS"] = drItem["DUPLICADOS"].ToString();
            dr["ERRORES"] = drItem["ERRORES"].ToString();
            dr["CARGADOS"] = drItem["CARGADOS"].ToString();
            dr["ESTADO"] = drItem["ESTADO"].ToString();
           
            dt.Rows.Add(dr);
            cont += 1;
        }

        DataView MydataViewvsita = new DataView();
        MydataViewvsita = new DataView(dt);
        gvProceso.DataSource = MydataViewvsita;
        gvProceso.DataBind();
        gvProceso.Visible = true;
        lb_registros.Text = cont + " Coincidencia(s) encontrada(s)";
    }
   
    protected void gvProceso_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

    }

    protected void gvProceso_RowCommand(object sender, GridViewCommandEventArgs e)
    {

    }


    protected void gvProceso_SelectedIndexChanged(object sender, EventArgs e)
    {
        cargar_detalle(gvProceso.SelectedRow.Cells[1].Text);

    }

    

}