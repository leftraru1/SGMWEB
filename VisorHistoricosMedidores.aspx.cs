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
using System.Text;


public partial class VisorHistoricosMedidores : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"]; //nuestra conexión a bbdd, obtenida del web config.
    Procedimientos PRO = new Procedimientos(); //para agregar parametros de entrada al procedimiento almacenado solicitado.
    public static DataTable mi_orden;
    FileInfo[] MisFicheros;
    String id_contr,request_medidor;
    DataTable dt_excel = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!Page.IsPostBack)
        {

            try
            {
                request_medidor = Request.QueryString["serie"];
                serie_desde.Text = request_medidor;

                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                lb_rut_empresa.Text = PRO.recSession(rutaXml, "RUT_EMPRESA");
                lb_id_perfil.Text = PRO.recSession(rutaXml, "ID_PERFIL");
                lb_id_usuario.Text = PRO.recSession(rutaXml, "ID_USUARIO");
                id_contr = PRO.recSession(rutaXml, "ID_CONTRATISTA");
                mi_orden = new DataTable();

                //asignamos el rango de fechas (3 meses, 90 dias) desde fecha actual.
                txtDesde.Text = DateTime.Today.AddDays(-30).ToString("dd/MM/yyyy");
                txtHasta.Text = DateTime.Today.ToString("dd/MM/yyyy");

                //cargamos los filtros.
                carga_region();
                carga_contratista(id_contr);
                carga_bodegas(int.Parse(ddContratista.SelectedValue), int.Parse(ddRegion.SelectedValue));                
                carga_estado();
                carga_guia(ddContratista.SelectedValue,ddRegion.SelectedValue,ddbodegas.SelectedValue);
                carga_tipo_procesos();
                carga_operadores(ddContratista.SelectedValue);
                carga_diametro();
            
                if(serie_desde.Text != ""){
                    carga_grilla_detalle(ddRegion.SelectedValue, ddbodegas.SelectedValue, ddContratista.SelectedValue, serie_desde.Text, serie_hasta.Text,
                        ddestado.SelectedValue, ddguia.SelectedValue, ddTipoProceso.SelectedValue, ddOperador.SelectedValue, dddiametro.SelectedValue, txtOrden.Text,
                        txtServ.Text, txtDesde.Text, txtHasta.Text);
                }
                

                IMG2.Visible = false;
                IMG4.Visible = false;

                //validamos que el perfil esté autorizado para ver las exportaciones de excel.
                if (valida_salida_excel(lb_id_perfil.Text))
                {
                    btn_exportar.Visible = true;
                }
                else
                {
                    btn_exportar.Visible = false;
                }
            }
            catch (Exception ex)
            {

                Response.Redirect("errorSesion.aspx"); //expira sesión.
            }



        }

    }

    public void carga_guia(String contratista,String region,String bodega)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_VISOR_HISTORICOS.CARGA_GUIA", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "contratista", OracleType.Int32, ParameterDirection.Input, contratista);
        PRO.agrega_parametro_sp(objComando, "bodega", OracleType.NVarChar, ParameterDirection.Input, bodega);
        PRO.agrega_parametro_sp(objComando, "region", OracleType.Int32, ParameterDirection.Input, region);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "GUIA");

        objConexion.Close();

        int i = 1;
        ddguia.Items.Clear();
        ddguia.Items.Add("Todos...");
        ddguia.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["GUIA"].Rows)
        {

            ddguia.Items.Add(row[1].ToString());
            ddguia.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }

    public void carga_estado()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_VISOR_HISTORICOS.CARGA_ESTADO", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "ESTADO");

        objConexion.Close();

        int i = 1;
        ddestado.Items.Clear();
        ddestado.Items.Add("Todos...");
        ddestado.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["ESTADO"].Rows)
        {

            ddestado.Items.Add(row[1].ToString());
            ddestado.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }

    public void carga_diametro()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_CARGA_DD_GUIA.CARGA_DIAMETRO", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "DIAMETRO");
        objConexion.Close();

        int i = 1;
        dddiametro.Items.Clear();
        dddiametro.Items.Add("Todos...");
        dddiametro.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["DIAMETRO"].Rows)
        {

            dddiametro.Items.Add(row[1].ToString());
            dddiametro.Items[i].Value = row[1].ToString();
            i = i + 1;

        }
    }

    //CARGAMOS BODEGAS EN FUNCION DEL CONTRATISTA SELECCIONADO Y LA REGION
    public void carga_bodegas(int contratista, int region)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_VISOR_HISTORICOS.CARGA_BODEGAS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "contratista", OracleType.Int32, ParameterDirection.Input, contratista.ToString());
        PRO.agrega_parametro_sp(objComando, "region", OracleType.Int32, ParameterDirection.Input, region.ToString());

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "BODEGAS");
        objConexion.Close();

        int i = 1;
        ddbodegas.Items.Clear();

        ddbodegas.Items.Clear();
        ddbodegas.Items.Add("TODAS");
        ddbodegas.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["BODEGAS"].Rows)
        {
            ddbodegas.Items.Add(row[1].ToString());
            ddbodegas.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }

    //CARGAMOS LOS CONTRATISTAS.
    public void carga_contratista(String contratista)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_REPORTE_STOCK.CARGA_CONTRATISTAS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "contratista", OracleType.Number, ParameterDirection.Input, contratista);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "CONTRATISTA");
        objConexion.Close();

        int i = 1;
        if (contratista == "0")
        {
            ddContratista.Items.Clear();
            ddContratista.Items.Add("Todos...");
            ddContratista.Items[0].Value = "0";
        }
        else
        {
            i = 0;
        }

        foreach (DataRow row in objDS.Tables["CONTRATISTA"].Rows)
        {
            ddContratista.Items.Add(row[1].ToString());
            ddContratista.Items[i].Value = row[0].ToString();
            i = i + 1;
        }
    }


    //CARGAMOS LOS OPERADORES
    public void carga_operadores(String contratista)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_VISOR_HISTORICOS.CARGA_OPERADORES", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_id_contratista", OracleType.Number, ParameterDirection.Input, contratista);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "OPERADORES");
        objConexion.Close();

        int i = 1;
        ddOperador.Items.Clear();
        ddOperador.Items.Add("TODOS...");
        ddOperador.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["OPERADORES"].Rows)
        {
            String name = row[1].ToString();
           
            ddOperador.Items.Add(name);
            ddOperador.Items[i].Value = row[0].ToString();
            i = i + 1;
        }
    }

    //Cargamos los origenes posibles de orden.
    public void carga_tipo_procesos()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_VISOR_HISTORICOS.CARGA_TIPOPROCESO", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();

        objComando.Fill(objDS, "CARGA_TIPOPROCESO");
        objConexion.Close();

        int i = 1;
        ddTipoProceso.Items.Clear();
        ddTipoProceso.Items.Add("TODOS...");
        ddTipoProceso.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["CARGA_TIPOPROCESO"].Rows)
        {

            ddTipoProceso.Items.Add(row[0].ToString());
            ddTipoProceso.Items[i].Value = row[1].ToString();
            i = i + 1;

        }
    }

    //CARGAMOS LAS REGIONES
    public void carga_region()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_REPORTE_ORDENES.CARGA_REGION", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "REGION");
        objConexion.Close();

        int i = 1;
        ddRegion.Items.Clear();
        ddRegion.Items.Add("TODAS...");
        ddRegion.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["REGION"].Rows)
        {

            ddRegion.Items.Add(row[1].ToString());
            ddRegion.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }
        
    public Boolean valida_salida_excel(String id_perfil)
    {
        try
        {

            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();

            objConexion.Open();
            objComando = new OracleDataAdapter("PK_VISOR_HISTORICOS.VALIDA_SALIDA_EXCEL", objConexion);
            objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

            PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
            PRO.agrega_parametro_sp(objComando, "i_id_perfil", OracleType.Number, ParameterDirection.Input, id_perfil);
            
            objComando.SelectCommand.ExecuteNonQuery();
            objComando.Fill(objDS, "VALIDA");
            objConexion.Close();

            if (objDS.Tables["VALIDA"].Rows[0][0].ToString().Equals("0"))
            {

                return false;
            }
            else
            {
                return true;
            }
        }
        catch (Exception ex)
        {
            return false;
        }
    }
    
         
    protected void gridOrden_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //gridOrden.PageIndex = e.NewPageIndex;
        gridOrden.PageIndex = e.NewPageIndex;
        carga_grilla_detalle(ddRegion.SelectedValue, ddbodegas.SelectedValue, ddContratista.SelectedValue, serie_desde.Text, serie_hasta.Text,
                    ddestado.SelectedValue, ddguia.SelectedValue, ddTipoProceso.SelectedValue, ddOperador.SelectedValue, dddiametro.SelectedValue, txtOrden.Text,
                    txtServ.Text, txtDesde.Text, txtHasta.Text);
    }

    protected void gridOrden_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {

            int index = int.Parse(e.CommandArgument.ToString());
            var colsNoVisible = gridOrden.DataKeys[index].Values;
            String orden = (String)colsNoVisible[1];
            String serv = (String)colsNoVisible[2];

            if (gridOrden.PageIndex > 0) index = index - (gridOrden.PageIndex * int.Parse(ddPageSize.SelectedValue));

            if (e.CommandName == "get_orden")
            {
                Response.Redirect("VisorHistoricos.aspx?orden="+orden);
                //String vtn = "window.open('InformeComercial.aspx?Servicio=" + servicio + "&orden=" + orden + "&pr=" + proceso + "&visita=" + visita + "&atendido=" + atendido + "','Dates','scrollbars=yes,resizable=yes,height=500,width=840')";
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", vtn, true);
            }
            else if (e.CommandName == "get_serv")
            {
                Response.Redirect("VisorHistoricos.aspx?servicio=" + serv);
                //String vtn = "window.open('InformeComercial.aspx?Servicio=" + servicio + "&orden=" + orden + "&pr=" + proceso + "&visita=" + visita + "&atendido=" + atendido + "','Dates','scrollbars=yes,resizable=yes,height=500,width=840')";
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", vtn, true);
            }
                        
        }
        catch (Exception ex)
        {
          
            lbTxtIn.ForeColor = System.Drawing.Color.Red;

            IMG2.Visible = false;
            IMG4.Visible = true;
            lbTxtIn.Text = ex.Message;
            mi_orden = null;
        }
    }
    
   
   
    protected void ddTipoPro_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(ddRegion.SelectedValue, ddbodegas.SelectedValue, ddContratista.SelectedValue, serie_desde.Text, serie_hasta.Text,
                     ddestado.SelectedValue, ddguia.SelectedValue, ddTipoProceso.SelectedValue, ddOperador.SelectedValue, dddiametro.SelectedValue, txtOrden.Text,
                     txtServ.Text, txtDesde.Text, txtHasta.Text);

    }
  
    protected void ddEstado_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(ddRegion.SelectedValue, ddbodegas.SelectedValue, ddContratista.SelectedValue, serie_desde.Text, serie_hasta.Text,
                     ddestado.SelectedValue, ddguia.SelectedValue, ddTipoProceso.SelectedValue, ddOperador.SelectedValue, dddiametro.SelectedValue, txtOrden.Text,
                     txtServ.Text, txtDesde.Text, txtHasta.Text);
    }
    
    protected void txtServ_TextChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(ddRegion.SelectedValue, ddbodegas.SelectedValue, ddContratista.SelectedValue, serie_desde.Text, serie_hasta.Text,
                     ddestado.SelectedValue, ddguia.SelectedValue, ddTipoProceso.SelectedValue, ddOperador.SelectedValue, dddiametro.SelectedValue, txtOrden.Text,
                     txtServ.Text, txtDesde.Text, txtHasta.Text);
    }
    protected void txtDesde_TextChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(ddRegion.SelectedValue, ddbodegas.SelectedValue, ddContratista.SelectedValue, serie_desde.Text, serie_hasta.Text,
                      ddestado.SelectedValue, ddguia.SelectedValue, ddTipoProceso.SelectedValue, ddOperador.SelectedValue, dddiametro.SelectedValue, txtOrden.Text,
                      txtServ.Text, txtDesde.Text, txtHasta.Text);
    }
    protected void txtHasta_TextChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(ddRegion.SelectedValue, ddbodegas.SelectedValue, ddContratista.SelectedValue, serie_desde.Text, serie_hasta.Text,
                     ddestado.SelectedValue, ddguia.SelectedValue, ddTipoProceso.SelectedValue, ddOperador.SelectedValue, dddiametro.SelectedValue, txtOrden.Text,
                     txtServ.Text, txtDesde.Text, txtHasta.Text);
    }
   
    protected void Button1_Click1(object sender, EventArgs e)
    {
        carga_grilla_detalle(ddRegion.SelectedValue, ddbodegas.SelectedValue, ddContratista.SelectedValue, serie_desde.Text, serie_hasta.Text,
                     ddestado.SelectedValue, ddguia.SelectedValue, ddTipoProceso.SelectedValue, ddOperador.SelectedValue, dddiametro.SelectedValue, txtOrden.Text,
                     txtServ.Text, txtDesde.Text, txtHasta.Text);
    }

    protected void ddRegion_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_bodegas(int.Parse(ddContratista.SelectedValue), int.Parse(ddRegion.SelectedValue));
        carga_guia(ddContratista.SelectedValue, ddRegion.SelectedValue, ddbodegas.SelectedValue);
        carga_operadores(ddContratista.SelectedValue);
        carga_grilla_detalle(ddRegion.SelectedValue, ddbodegas.SelectedValue, ddContratista.SelectedValue, serie_desde.Text, serie_hasta.Text,
                    ddestado.SelectedValue, ddguia.SelectedValue, ddTipoProceso.SelectedValue, ddOperador.SelectedValue, dddiametro.SelectedValue, txtOrden.Text,
                    txtServ.Text, txtDesde.Text, txtHasta.Text);
    }
     
    public String format_number(String text_number, int decimales)
    {
        try
        {
            String str_decimales = "0";

            for (int i = 0; i < decimales; i++)
            {
                if (i == 0 && i < decimales) str_decimales += ".";

                str_decimales += "0";
            }

            return String.Format("{0:" + str_decimales + "}", Double.Parse(text_number));
        }
        catch (Exception ex)
        {
            return "";
        }
    }

    protected void btn_exportar_Click(object sender, EventArgs e)
    {
        if (gridOrden.Rows.Count > 0){
            carga_grilla_detalle(ddRegion.SelectedValue, ddbodegas.SelectedValue, ddContratista.SelectedValue, serie_desde.Text, serie_hasta.Text,
                      ddestado.SelectedValue, ddguia.SelectedValue, ddTipoProceso.SelectedValue, ddOperador.SelectedValue, dddiametro.SelectedValue, txtOrden.Text,
                      txtServ.Text, txtDesde.Text, txtHasta.Text);

            datatable_to_excel(dt_excel);
        }
        else ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('No hay registros para decargar');", true);

    }

    public Boolean valida_orden(String servicio,String table)
    {
        try
        {
            if (servicio.Contains("-00")) //reemplazamos los -00 que define essbio para sus servicios (en caso de existir el -00 lo eliminamos).
            {
                servicio = servicio.Replace("-00", "");
            }

            String sql;
            //definimos tabla a consultar:
            switch (table)
            {
                case "HISTORICO": table = "ORDEN"; sql = "SELECT ID_SERVICIO FROM " + table + " WHERE ID_SERVICIO = " + servicio + " AND ATENDIDO > 0"; break;
                case "VISITAS": table = "ORDEN_HISTORICOS"; sql = "SELECT ID_SERVICIO FROM " + table + " WHERE ID_SERVICIO = " + servicio + " AND ATENDIDO > 0"; break;
                case "PROCESO": table = "ORDEN"; sql = "SELECT ID_SERVICIO FROM " + table + " WHERE ID_SERVICIO = " + servicio + " AND ATENDIDO = 0"; break;
                default: table = "ORDEN"; sql = "SELECT ID_SERVICIO FROM " + table + " WHERE ID_SERVICIO = " + servicio; break;
            }

            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();

            objConexion.Open();
            objComando = new OracleDataAdapter(sql, objConexion);
            objComando.SelectCommand.CommandType = CommandType.Text;

            objComando.SelectCommand.ExecuteNonQuery();
            objComando.Fill(objDS, "VALIDA");
            objConexion.Close();

            int codigo = 0;
            foreach (DataRow row in objDS.Tables["VALIDA"].Rows)
            {
                if (servicio.Equals(row[0].ToString()))
                {
                    return true;
                }
            }

            return false;
        }
        catch (Exception ex)
        {
            return false;
        }
    }

    public Boolean valida_nro_orden(String orden,String table)
    {
        try
        {
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();

            String sql;
            //definimos tabla a consultar:
            switch (table)
            {
                case "HISTORICO": table = "ORDEN"; sql = "SELECT NUMERO_ORDEN FROM " + table + " WHERE NUMERO_ORDEN = " + orden + " AND ATENDIDO > 0"; break;
                case "VISITAS": table = "ORDEN_HISTORICOS"; sql = "SELECT NUMERO_ORDEN FROM " + table + " WHERE NUMERO_ORDEN = " + orden + " AND ATENDIDO > 0"; break;
                case "PROCESO": table = "ORDEN"; sql = "SELECT NUMERO_ORDEN FROM " + table + " WHERE NUMERO_ORDEN = " + orden + " AND ATENDIDO = 0"; break;
                default: table = "ORDEN"; sql = "SELECT NUMERO_ORDEN FROM " + table + " WHERE NUMERO_ORDEN = " + orden; break;
            }

           
            objConexion.Open();
            objComando = new OracleDataAdapter(sql, objConexion);
            objComando.SelectCommand.CommandType = CommandType.Text;


            objComando.SelectCommand.ExecuteNonQuery();
            objComando.Fill(objDS, "VALIDA");
            objConexion.Close();

            int codigo = 0;
            foreach (DataRow row in objDS.Tables["VALIDA"].Rows)
            {
                if (orden.Equals(row[0].ToString()))
                {
                    return true;
                }
            }

            return false;
        }
        catch (Exception ex)
        {
            return false;
        }
    }

    //muestra una ventana emergente con un mensaje de entrada y el tipo de ventana (alert o confirm)
    public void mensaje_emergente(String mensaje)
    {

        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append("<script type = 'text/javascript'>");
        sb.Append("window.onload=function(){");
        sb.Append("alert('");
        sb.Append(mensaje);
        sb.Append("')};");
        sb.Append("</script>");
        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());

    }

    public Boolean perfil_autorizado(String id_perfil)
    {    
        try
        {
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();

            objConexion.Open();
            objComando = new OracleDataAdapter("SELECT ID_PERFIL FROM PERFIL WHERE ID_PERFIL IN(SELECT ID_PERFIL FROM POWER_ADMIN)", objConexion);
            objComando.SelectCommand.CommandType = CommandType.Text;

            objComando.SelectCommand.ExecuteNonQuery();
            objComando.Fill(objDS, "PERFILES_AUTORIZADOS");
            objConexion.Close();

            foreach (DataRow row in objDS.Tables["PERFILES_AUTORIZADOS"].Rows)
            {

                if (id_perfil == row[0].ToString())
                {
                    return true;
                }
            }

            return false;
        }
        catch (Exception ex)
        {
            return false;
        }
    }


    protected void ddPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(ddRegion.SelectedValue, ddbodegas.SelectedValue, ddContratista.SelectedValue, serie_desde.Text, serie_hasta.Text,
                       ddestado.SelectedValue, ddguia.SelectedValue, ddTipoProceso.SelectedValue, ddOperador.SelectedValue, dddiametro.SelectedValue, txtOrden.Text,
                       txtServ.Text, txtDesde.Text, txtHasta.Text);
    }
    
      
    protected void ddContratista_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_guia(ddContratista.SelectedValue, ddRegion.SelectedValue, ddbodegas.SelectedValue);
        carga_operadores(ddContratista.SelectedValue);
        carga_grilla_detalle(ddRegion.SelectedValue, ddbodegas.SelectedValue, ddContratista.SelectedValue, serie_desde.Text, serie_hasta.Text,
                     ddestado.SelectedValue, ddguia.SelectedValue, ddTipoProceso.SelectedValue, ddOperador.SelectedValue, dddiametro.SelectedValue, txtOrden.Text,
                     txtServ.Text, txtDesde.Text, txtHasta.Text);
    }

    public void datatable_to_excel(DataTable dt)
    {
        try
        {
            String salida;
            DataRow dr;
            StreamWriter sr;
            int total = 0;

            sr = new StreamWriter(Server.MapPath("./SALIDA/" + "DETALLE_HISTORIAL_MEDIDORES" + DateTime.Now.ToString("ddMMyyyy") + ".csv"));

            salida = "CODIGO UNICO" + ";"
                        + "USUARIO" + ";"
                        + "SERIE" + ";"
                        + "DEN. TECNICA" + ";"
                        + "INSTALADOR" + ";"
                        + "ESTADO MEDIDOR" + ";"
                        + "NUMERO GUIA" + ";"
                        + "BODEGA" + ";"
                        + "CONTRATISTA" + ";"
                        + "FECHA" + ";"

                        + "DETALLE" + ";"
                        + "TIPO PROCESO" + ";"
                        + "NUMERO ORDEN" + ";"
                        + "SERVICIO"  + ";"
                        + "VISITA";
                       

            sr.WriteLine(salida);

            foreach (DataRow drOrdenItem in dt.Rows)
            {
                try
                {
                    dr = dt.NewRow();


                    dr["CODIGO_UNICO"] = drOrdenItem["CODIGO_UNICO"].ToString();
                    dr["USUARIO"] = drOrdenItem["USUARIO"].ToString();
                    dr["SERIE"] = drOrdenItem["SERIE"].ToString();
                    dr["DEN_TECNICA"] = drOrdenItem["DEN_TECNICA"].ToString();
                    dr["INSTALADOR"] = drOrdenItem["INSTALADOR"].ToString();
                    dr["ESTADO_MEDIDOR"] = drOrdenItem["ESTADO_MEDIDOR"].ToString();
                    dr["NUMERO_GUIA"] = drOrdenItem["NUMERO_GUIA"].ToString();
                    dr["NOMBRE_BODEGA"] = drOrdenItem["NOMBRE_BODEGA"].ToString();
                    dr["CONTRATISTA"] = drOrdenItem["CONTRATISTA"].ToString();
                    dr["FECHA"] = drOrdenItem["FECHA"].ToString();

                    dr["DETALLE"] = drOrdenItem["DETALLE"].ToString();
                    dr["TIPO_PROCESO"] = drOrdenItem["TIPO_PROCESO"].ToString();
                    dr["NUMERO_ORDEN"] = drOrdenItem["NUMERO_ORDEN"].ToString();
                    dr["ID_SERVICIO"] = drOrdenItem["ID_SERVICIO"].ToString();
                    dr["VISITA"] = drOrdenItem["VISITA"].ToString();



                    total = total + 1;

                    salida = dr["CODIGO_UNICO"] + ";" +
                             dr["USUARIO"] + ";" +
                             dr["SERIE"] + ";" +
                             dr["DEN_TECNICA"] + ";" +
                             dr["INSTALADOR"] + ";" +
                             dr["ESTADO_MEDIDOR"] + ";" +
                             dr["NUMERO_GUIA"] + ";" +
                             dr["NOMBRE_BODEGA"] + ";" +
                             dr["CONTRATISTA"] + ";" +
                             dr["FECHA"] + ";" +

                             dr["DETALLE"] + ";" +
                             dr["TIPO_PROCESO"] + ";" +
                             dr["NUMERO_ORDEN"] + ";" +
                             dr["ID_SERVICIO"] + ";" +
                             dr["VISITA"];
                             

                    sr.WriteLine(salida);

                }
                catch (Exception ex)
                {
                    continue;
                }
            }
            sr.Close();

            Response.Redirect("./SALIDA/" + "DETALLE_HISTORIAL_MEDIDORES" + DateTime.Now.ToString("ddMMyyyy") + ".csv", false);
        }
        catch (Exception ex)
            {
            String exp = ex.ToString();
        }
    }

    public String valida_decimal(String campo)
    {
        try
        {
            double valor = double.Parse(campo);

            return campo;
        }
        catch (Exception ex)
        {
            return "0";
        }
    }

    public void carga_grilla_detalle(String region, String bodega, String contratista, String serie_d, String serie_h, String estado_medidor,
        String guia, String tipo_proceso, String instalador, String diametro, String numero_orden, String servicio, String desde, String hasta)
    {
        ddPageSize.Visible = true;
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
        id_contr = PRO.recSession(rutaXml, "ID_CONTRATISTA");

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_VISOR_HISTORICOS.CARGA_HISTORIAL_MEDIDORES", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_region", OracleType.Number, ParameterDirection.Input, region);
        PRO.agrega_parametro_sp(da, "i_bodega", OracleType.Number, ParameterDirection.Input, bodega);

        if (contratista.Length == 0) contratista = id_contr;

        PRO.agrega_parametro_sp(da, "i_contratista", OracleType.Number, ParameterDirection.Input, contratista);

        String mi_check = "0";
        if(check_rango.Checked) mi_check = "1";

        if (serie_desde.Text == "") serie_d = "0";
        if (serie_hasta.Text == "" || !check_rango.Checked) serie_h = "0";

        PRO.agrega_parametro_sp(da, "i_serie_desde", OracleType.Number, ParameterDirection.Input, serie_d);
        PRO.agrega_parametro_sp(da, "i_serie_hasta", OracleType.Number, ParameterDirection.Input, serie_h);

        PRO.agrega_parametro_sp(da, "i_estado", OracleType.Number, ParameterDirection.Input, estado_medidor);
        PRO.agrega_parametro_sp(da, "i_guia", OracleType.NVarChar, ParameterDirection.Input, guia);
        PRO.agrega_parametro_sp(da, "i_tipoproceso", OracleType.NVarChar, ParameterDirection.Input, tipo_proceso);
        PRO.agrega_parametro_sp(da, "i_instalador", OracleType.NVarChar, ParameterDirection.Input, instalador);
        PRO.agrega_parametro_sp(da, "i_diametro", OracleType.NVarChar, ParameterDirection.Input, diametro);

        if (numero_orden.Length == 0) numero_orden = "0";

        PRO.agrega_parametro_sp(da, "i_numero_orden", OracleType.Number, ParameterDirection.Input, numero_orden);
        PRO.agrega_parametro_sp(da, "i_servicio", OracleType.NVarChar, ParameterDirection.Input, servicio);
        PRO.agrega_parametro_sp(da, "i_desde", OracleType.NVarChar, ParameterDirection.Input, desde);
        PRO.agrega_parametro_sp(da, "i_hasta", OracleType.NVarChar, ParameterDirection.Input, hasta);
        PRO.agrega_parametro_sp(da, "i_checked", OracleType.Number, ParameterDirection.Input, mi_check);

        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("CODIGO_UNICO", typeof(String)));
        dt.Columns.Add(new DataColumn("USUARIO", typeof(String)));
        dt.Columns.Add(new DataColumn("SERIE", typeof(String)));
        dt.Columns.Add(new DataColumn("DEN_TECNICA", typeof(String)));
        dt.Columns.Add(new DataColumn("INSTALADOR", typeof(String)));
        dt.Columns.Add(new DataColumn("ESTADO_MEDIDOR", typeof(String)));
        dt.Columns.Add(new DataColumn("NUMERO_GUIA", typeof(String)));
        dt.Columns.Add(new DataColumn("NOMBRE_BODEGA", typeof(String)));
        dt.Columns.Add(new DataColumn("CONTRATISTA", typeof(String)));
        dt.Columns.Add(new DataColumn("FECHA", typeof(String)));

        dt.Columns.Add(new DataColumn("DETALLE", typeof(String)));
        dt.Columns.Add(new DataColumn("TIPO_PROCESO", typeof(String)));
        dt.Columns.Add(new DataColumn("NUMERO_ORDEN", typeof(String)));
        dt.Columns.Add(new DataColumn("ID_SERVICIO", typeof(String)));
        dt.Columns.Add(new DataColumn("VISITA", typeof(String)));

        try
        {
            DataTable dtOrdenes = new DataTable();
            CnOra.Open();

            da.Fill(dtOrdenes);
            grdExcel.DataSource = dtOrdenes;
            grdExcel.DataBind();
            CnOra.Close();
            CnOra.Dispose();
                       
            DataRow dr;

            int total = 0;

            foreach (DataRow drOrdenItem in dtOrdenes.Rows)
            {

                dr = dt.NewRow();

                dr["CODIGO_UNICO"] = drOrdenItem["CODIGO_UNICO"].ToString();
                dr["USUARIO"] = drOrdenItem["USUARIO"].ToString();
                dr["SERIE"] = drOrdenItem["SERIE"].ToString();
                dr["DEN_TECNICA"] = drOrdenItem["DEN_TECNICA"].ToString();
                dr["INSTALADOR"] = drOrdenItem["INSTALADOR"].ToString();
                dr["ESTADO_MEDIDOR"] = drOrdenItem["ESTADO_MEDIDOR"].ToString();
                dr["NUMERO_GUIA"] = drOrdenItem["NUMERO_GUIA"].ToString();
                dr["NOMBRE_BODEGA"] = drOrdenItem["NOMBRE_BODEGA"].ToString();
                dr["CONTRATISTA"] = drOrdenItem["CONTRATISTA"].ToString();
                dr["FECHA"] = drOrdenItem["FECHA"].ToString();

                dr["DETALLE"] = drOrdenItem["DETALLE"].ToString();
                dr["TIPO_PROCESO"] = drOrdenItem["TIPO_PROCESO"].ToString();
                dr["NUMERO_ORDEN"] = drOrdenItem["NUMERO_ORDEN"].ToString();
                dr["ID_SERVICIO"] = drOrdenItem["ID_SERVICIO"].ToString();
                dr["VISITA"] = drOrdenItem["VISITA"].ToString();
             
                dt.Rows.Add(dr);

                total = total + 1;

            }

            DataView MydataView;
            MydataView = new DataView(dt);
            gridOrden.DataSource = MydataView;
            gridOrden.DataBind();

            dt_excel = dt;

            if (gridOrden.PageCount == 0) lbTotal.Text = total + " registro(s) encontrado(s) - Página " + (gridOrden.PageIndex) + " de " + gridOrden.PageCount;
            else lbTotal.Text = total + " registro(s) encontrado(s) - Página " + (gridOrden.PageIndex + 1) + " de " + gridOrden.PageCount;
    
            
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + ex.Message.ToString() + "');", true);

            //ERROR AL INTEGRAR ARCHIVO.
        }

    }


    protected void ddbodegas_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_guia(ddContratista.SelectedValue, ddRegion.SelectedValue, ddbodegas.SelectedValue);
        carga_grilla_detalle(ddRegion.SelectedValue, ddbodegas.SelectedValue, ddContratista.SelectedValue, serie_desde.Text, serie_hasta.Text,
                   ddestado.SelectedValue, ddguia.SelectedValue, ddTipoProceso.SelectedValue, ddOperador.SelectedValue, dddiametro.SelectedValue, txtOrden.Text,
                   txtServ.Text, txtDesde.Text, txtHasta.Text);
    }
    protected void ddestado_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(ddRegion.SelectedValue, ddbodegas.SelectedValue, ddContratista.SelectedValue, serie_desde.Text, serie_hasta.Text,
                   ddestado.SelectedValue, ddguia.SelectedValue, ddTipoProceso.SelectedValue, ddOperador.SelectedValue, dddiametro.SelectedValue, txtOrden.Text,
                   txtServ.Text, txtDesde.Text, txtHasta.Text);
    }
    protected void ddguia_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(ddRegion.SelectedValue, ddbodegas.SelectedValue, ddContratista.SelectedValue, serie_desde.Text, serie_hasta.Text,
                   ddestado.SelectedValue, ddguia.SelectedValue, ddTipoProceso.SelectedValue, ddOperador.SelectedValue, dddiametro.SelectedValue, txtOrden.Text,
                   txtServ.Text, txtDesde.Text, txtHasta.Text);
    }
    protected void ddOrigenOrden_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(ddRegion.SelectedValue, ddbodegas.SelectedValue, ddContratista.SelectedValue, serie_desde.Text, serie_hasta.Text,
                   ddestado.SelectedValue, ddguia.SelectedValue, ddTipoProceso.SelectedValue, ddOperador.SelectedValue, dddiametro.SelectedValue, txtOrden.Text,
                   txtServ.Text, txtDesde.Text, txtHasta.Text);
    }
    protected void ddSincro_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(ddRegion.SelectedValue, ddbodegas.SelectedValue, ddContratista.SelectedValue, serie_desde.Text, serie_hasta.Text,
                   ddestado.SelectedValue, ddguia.SelectedValue, ddTipoProceso.SelectedValue, ddOperador.SelectedValue, dddiametro.SelectedValue, txtOrden.Text,
                   txtServ.Text, txtDesde.Text, txtHasta.Text);
    }
    protected void dddiametro_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(ddRegion.SelectedValue, ddbodegas.SelectedValue, ddContratista.SelectedValue, serie_desde.Text, serie_hasta.Text,
                   ddestado.SelectedValue, ddguia.SelectedValue, ddTipoProceso.SelectedValue, ddOperador.SelectedValue, dddiametro.SelectedValue, txtOrden.Text,
                   txtServ.Text, txtDesde.Text, txtHasta.Text);
    }

    protected void check_rango_CheckedChanged(object sender, EventArgs e)
    {
        if (check_rango.Checked) //mostramos campo hasta y su validacion
        {
            serie_hasta.Visible = true;
            RegularExpressionValidator5.Enabled = true;
            serie_hasta_rango.Visible = true;
        }
        else
        {
            serie_hasta.Visible = false;
            RegularExpressionValidator5.Enabled = false;
            serie_hasta_rango.Visible = false;
        }

        carga_grilla_detalle(ddRegion.SelectedValue, ddbodegas.SelectedValue, ddContratista.SelectedValue, serie_desde.Text, serie_hasta.Text,
                   ddestado.SelectedValue, ddguia.SelectedValue, ddTipoProceso.SelectedValue, ddOperador.SelectedValue, dddiametro.SelectedValue, txtOrden.Text,
                   txtServ.Text, txtDesde.Text, txtHasta.Text);
    }
    protected void serie_hasta_TextChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(ddRegion.SelectedValue, ddbodegas.SelectedValue, ddContratista.SelectedValue, serie_desde.Text, serie_hasta.Text,
                   ddestado.SelectedValue, ddguia.SelectedValue, ddTipoProceso.SelectedValue, ddOperador.SelectedValue, dddiametro.SelectedValue, txtOrden.Text,
                   txtServ.Text, txtDesde.Text, txtHasta.Text);
    }
    protected void serie_desde_TextChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(ddRegion.SelectedValue, ddbodegas.SelectedValue, ddContratista.SelectedValue, serie_desde.Text, serie_hasta.Text,
                   ddestado.SelectedValue, ddguia.SelectedValue, ddTipoProceso.SelectedValue, ddOperador.SelectedValue, dddiametro.SelectedValue, txtOrden.Text,
                   txtServ.Text, txtDesde.Text, txtHasta.Text);
    }
}

