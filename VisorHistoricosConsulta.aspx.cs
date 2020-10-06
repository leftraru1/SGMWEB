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


public partial class VisorHistoricosConsulta : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"]; //nuestra conexión a bbdd, obtenida del web config.
    Procedimientos PRO = new Procedimientos(); //para agregar parametros de entrada al procedimiento almacenado solicitado.
    public static DataTable mi_orden;
    FileInfo[] MisFicheros;
    String id_contr;
    public static DataTable dt_excel = new DataTable();
    String request_orden,request_servicio;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!Page.IsPostBack)
        {

            try
            {
                request_orden = Request.QueryString["orden"];
                txtOrden.Text = request_orden;

                request_servicio = Request.QueryString["servicio"];
                txtServ.Text = request_servicio;

                //String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                lb_rut_empresa.Text = "1005401";
                lb_id_perfil.Text = "17";
                lb_id_usuario.Text = "39";
                id_contr = "0";
                mi_orden = new DataTable();

                //asignamos el rango de fechas (1 mes, 30 dias) desde fecha actual.
                txtDesde.Text = DateTime.Today.AddDays(-1).ToString("dd/MM/yyyy");
                txtHasta.Text = DateTime.Today.ToString("dd/MM/yyyy");

                //cargamos los filtros.
                carga_contratista(id_contr);
                carga_operadores(ddContratista.SelectedValue);
                carga_tipo_procesos();
                carga_region();
                carga_zona(ddRegion.SelectedValue);
                carga_improcedencia();
                carga_localidad(ddRegion.SelectedValue,ddZona.SelectedValue);
                carga_rutas(ddTipoProceso.SelectedValue, ddZona.SelectedValue, ddRegion.SelectedValue, ddLocalidad.SelectedValue);

                if (txtOrden.Text != "" || txtServ.Text != "")
                {
                    carga_grilla_detalle(ddRegion.SelectedValue, ddZona.SelectedValue, ddLocalidad.SelectedValue, ddRuta.SelectedValue, ddOperador.SelectedValue,
                    ddContratista.SelectedValue, ddTipoProceso.SelectedValue, ddProcedencia.SelectedValue, txtOrden.Text, txtServ.Text,txtDesde.Text, txtHasta.Text);
                }
                

                //carga_grilla(ddTipoProceso.SelectedValue, ddZona.SelectedValue, ddRegion.SelectedValue, ddLocalidad.SelectedValue, ddOperador.SelectedValue,
                //            ddProcedencia.SelectedValue, txtServ.Text, txtOrden.Text, txtDesde.Text, txtHasta.Text, ddRuta.SelectedValue);
                //carga_zona();
                //carga_tipoIn();
                //cargaLoteInsp();
                //carga_localidad(int.Parse(ddZona.SelectedValue));
                //carga_ruta("0");
                //carga_TipoP();               


                IMG2.Visible = false;
                IMG4.Visible = false;

                //validamos que el perfil esté autorizado para ver las exportaciones de excel.
                //if (valida_salida_excel(lb_id_perfil.Text))
                //{
                //    btn_exportar.Visible = true;
                //}
                //else
                //{
                //    btn_exportar.Visible = false;
                //}
            }
            catch (Exception ex)
            {

                lbTxtIn.Text = ex.Message;
            }



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

    //CARGAMOS LAS IMPROCEDENCIAS
    public void carga_improcedencia()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_VISOR_HISTORICOS.CARGA_IMPROCEDENCIA", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "IMPROCEDENCIA");
        objConexion.Close();

        int i = 1;
        ddProcedencia.Items.Clear();
        ddProcedencia.Items.Add("TODOS...");
        ddProcedencia.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["IMPROCEDENCIA"].Rows)
        {
            ddProcedencia.Items.Add(row[1].ToString());
            ddProcedencia.Items[i].Value = row[0].ToString();
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

    //CARGAMOS LAS ZONAS EN FUNCIÓN DE LA REGIÓN SELECCIONADA.
    public void carga_zona(String region)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_REPORTE_ORDENES.CARGA_ZONA", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_region", OracleType.Number, ParameterDirection.Input, region);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "ZONA");
        objConexion.Close();

        int i = 1;
        ddZona.Items.Clear();
        ddZona.Items.Add("TODAS...");
        ddZona.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["ZONA"].Rows)
        {
            ddZona.Items.Add(row[1].ToString());
            ddZona.Items[i].Value = row[0].ToString();
            i = i + 1;
        }
    }

    //CARGAMOS LAS LOCALIDADES EN FUNCIÓN DE LA REGIÓN Y/O ZONA SELECCIONADA.
    public void carga_localidad(String region, String zona)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_REPORTE_ORDENES.CARGA_LOCALIDAD", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_region", OracleType.Number, ParameterDirection.Input, region);
        PRO.agrega_parametro_sp(objComando, "i_zona", OracleType.Number, ParameterDirection.Input, zona);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "LOCALIDAD");
        objConexion.Close();

        int i = 1;
        ddLocalidad.Items.Clear();
        ddLocalidad.Items.Add("TODAS...");
        ddLocalidad.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["LOCALIDAD"].Rows)
        {
            ddLocalidad.Items.Add(row[1].ToString());
            ddLocalidad.Items[i].Value = row[0].ToString();
            i = i + 1;
        }
    }

    //CARGAMOS LOS LOTES EN FUNCIÓN DE LA REGIÓN, ZONA Y/O LOCALIDAD SELECCIONADA.
    public void carga_lote(String region, String zona, String localidad)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_REPORTE_ORDENES.CARGA_LOTE", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_region", OracleType.Number, ParameterDirection.Input, region);
        PRO.agrega_parametro_sp(objComando, "i_zona", OracleType.Number, ParameterDirection.Input, zona);
        PRO.agrega_parametro_sp(objComando, "i_localidad", OracleType.Number, ParameterDirection.Input, localidad);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "LOTE");
        objConexion.Close();

        int i = 1;
        ddRuta.Items.Clear();
        ddRuta.Items.Add("TODOS...");
        ddRuta.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["LOTE"].Rows)
        {
            ddRuta.Items.Add(row[0].ToString());
            ddRuta.Items[i].Value = row[0].ToString();
            i = i + 1;
        }
    }

    
    //Cargamos las rutas según filtros de zona, proceso y/o localidad.
    public void carga_rutas(String tipo_proceso, String id_zona, String id_region, String cod_localidad)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_VISOR_HISTORICOS.CARGA_LOTE", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_tipo_proceso", OracleType.NVarChar, ParameterDirection.Input, tipo_proceso);
        PRO.agrega_parametro_sp(objComando, "i_zona", OracleType.Number, ParameterDirection.Input, id_zona);
        PRO.agrega_parametro_sp(objComando, "i_region", OracleType.Number, ParameterDirection.Input, id_region);
        PRO.agrega_parametro_sp(objComando, "i_localidad", OracleType.Number, ParameterDirection.Input, cod_localidad);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "RUTAS");
        objConexion.Close();

        int i = 1;
        ddRuta.Items.Clear();
        ddRuta.Items.Add("TODOS...");
        ddRuta.Items[0].Value = "0";


        foreach (DataRow row in objDS.Tables["RUTAS"].Rows)
        {

            ddRuta.Items.Add(row[0].ToString());
            ddRuta.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }

           
    public void carga_grilla(String tipo_proceso, String id_zona, String id_region, String cod_localidad, String operador,
        String id_estado, String id_servicio, String orden_servicio, String fecha_desde, String fecha_hasta, String ruta)
    {
        gridOrden.Columns[3].Visible = true;
        id_servicio = id_servicio.Trim();
        orden_servicio = orden_servicio.Trim();

        String mi_servicio = id_servicio;
        String mi_orden = orden_servicio;
               
        if (id_servicio.Contains("-00")) //reemplazamos los -00 que define essbio para sus servicios (en caso de existir el -00 lo eliminamos).
        {
            id_servicio = id_servicio.Replace("-00", "");
        }

        if (id_servicio.Equals(""))
        {
            id_servicio = "0";
        }

        if (orden_servicio.Equals(""))
        {
            orden_servicio = "0";
        }

        if (!id_servicio.Equals("0") && !(valida_orden(id_servicio,"HISTORICO")) )
        {
            lbTxtIn.ForeColor = System.Drawing.Color.Red;
            lbTxtIn.Text = "El servicio " + mi_servicio;


            if (valida_orden(id_servicio, "PROCESO")) //esta en proceso de atención!
            {
                lbTxtIn.Text = lbTxtIn.Text + " se encuentra en proceso de atención, vuelva a consultar más tarde!";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + lbTxtIn.Text + "');", true);
           
            }
            else //no existe en sistema!
            {
                lbTxtIn.Text = lbTxtIn.Text + " no figura en el sistema!";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + lbTxtIn.Text + "');", true);
           
            }
                       
            IMG2.Visible = false;
            IMG4.Visible = true;
        }
        else if (!orden_servicio.Equals("0") && !(valida_nro_orden(orden_servicio,"HISTORICO")))
        {
            lbTxtIn.ForeColor = System.Drawing.Color.Red;
            lbTxtIn.Text = "La orden " + mi_orden;


            if (valida_nro_orden(mi_orden, "PROCESO")) //esta en proceso de atención!
            {
                lbTxtIn.Text = lbTxtIn.Text + " se encuentra en proceso de atención, vuelva a consultar más tarde!";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + lbTxtIn.Text + "');", true);
           
            }
            else //no existe en sistema!
            {
                lbTxtIn.Text = lbTxtIn.Text + " no figura en el sistema!";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + lbTxtIn.Text + "');", true);
           
            }

            IMG2.Visible = false;
            IMG4.Visible = true;
        }
        else
        {
            //lb_valida.Visible = true;
            lbTxtIn.ForeColor = System.Drawing.Color.Black;
            lbTxtIn.Text = "";

            IMG2.Visible = false;
            IMG4.Visible = false;

            fecha_desde = fecha_desde.Replace("-", "/");
            fecha_hasta = fecha_hasta.Replace("-", "/");

            OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
            OracleCommand cmdAcceso = new OracleCommand("PK_VISOR_HISTORICOS.CARGAR_ORDENES", CnOra);
            OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

            PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
            PRO.agrega_parametro_sp(da, "i_origen_orden", OracleType.NVarChar, ParameterDirection.Input, tipo_proceso);
            PRO.agrega_parametro_sp(da, "i_id_zona", OracleType.Number, ParameterDirection.Input, id_zona);
            PRO.agrega_parametro_sp(da, "i_id_region", OracleType.Number, ParameterDirection.Input, id_region);
            PRO.agrega_parametro_sp(da, "i_cod_localidad", OracleType.Number, ParameterDirection.Input, cod_localidad);
            PRO.agrega_parametro_sp(da, "i_ruta", OracleType.Number, ParameterDirection.Input, ruta);
            PRO.agrega_parametro_sp(da, "i_operador", OracleType.Number, ParameterDirection.Input, operador);
            PRO.agrega_parametro_sp(da, "i_id_estado", OracleType.Number, ParameterDirection.Input, id_estado);
            PRO.agrega_parametro_sp(da, "i_id_servicio", OracleType.Number, ParameterDirection.Input, id_servicio);
            PRO.agrega_parametro_sp(da, "i_orden_servicio", OracleType.Number, ParameterDirection.Input, orden_servicio);
            PRO.agrega_parametro_sp(da, "i_fecha_desde", OracleType.NVarChar, ParameterDirection.Input, fecha_desde);
            PRO.agrega_parametro_sp(da, "i_fecha_hasta", OracleType.NVarChar, ParameterDirection.Input, fecha_hasta);

            da.SelectCommand.CommandType = CommandType.StoredProcedure;

            DataTable dtOrdenes = new DataTable();

            try
            {
                CnOra.Open();
                Button1.Attributes.Add("onclick", "return ShowProgress();"); //mostramos progreso.
                da.Fill(dtOrdenes);
                CnOra.Close();
                CnOra.Dispose();
                lbErrorGrilla.Text = "";
            }
            catch (Exception ex)
            {
                lbErrorGrilla.ForeColor = System.Drawing.Color.Red;
                //lbErrorGrilla.Text = ex.Message.ToString();
                if (ex.Message.Contains("formato"))
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('Problemas con el formato de un filtro');", true);

                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + ex.Message + "');", true);
           
                }
                
                lbErrorGrilla.Text = "";// ex.ToString();



            }

            
            DataTable dt = new DataTable();
            dt.Columns.Add(new DataColumn("ID_ORDEN_VERIFICACION", typeof(String)));
            dt.Columns.Add(new DataColumn("ESTADO_RESULTADO", typeof(String)));
            dt.Columns.Add(new DataColumn("IMPROCEDENTE", typeof(String)));
            dt.Columns.Add(new DataColumn("ID_PROCESO", typeof(String)));
            dt.Columns.Add(new DataColumn("VISITA", typeof(String)));
            dt.Columns.Add(new DataColumn("FECHA_CREACION", typeof(String)));
            dt.Columns.Add(new DataColumn("NUMERO_ORDEN", typeof(String)));
            dt.Columns.Add(new DataColumn("ID_SERVICIO", typeof(String)));
            dt.Columns.Add(new DataColumn("RUTA", typeof(String)));
            dt.Columns.Add(new DataColumn("NOMBRE_CLIENTE", typeof(String)));
            dt.Columns.Add(new DataColumn("LOCALIDAD", typeof(String)));
            dt.Columns.Add(new DataColumn("OPERADOR", typeof(String)));
            dt.Columns.Add(new DataColumn("RESULTADO_FINAL", typeof(String)));
            dt.Columns.Add(new DataColumn("SITUACION_DETECTADA", typeof(String)));
            dt.Columns.Add(new DataColumn("FECHA_EJECUCION", typeof(String)));
            dt.Columns.Add(new DataColumn("USUARIO_VALIDA", typeof(String)));
            dt.Columns.Add(new DataColumn("FECHA_CIERRE", typeof(String)));

            DataRow dr;

            int total = 0;

            foreach (DataRow drOrdenItem in dtOrdenes.Rows)
            {

                dr = dt.NewRow();
                dr["ID_ORDEN_VERIFICACION"] = drOrdenItem["ID_ORDEN_VERIFICACION"].ToString();
                dr["ESTADO_RESULTADO"] = drOrdenItem["ESTADO_RESULTADO"].ToString();
                dr["IMPROCEDENTE"] = drOrdenItem["IMPROCEDENTE"].ToString();
                dr["ID_PROCESO"] = drOrdenItem["ID_PROCESO"].ToString();
                dr["VISITA"] = drOrdenItem["VISITA"].ToString();
                dr["FECHA_CREACION"] = drOrdenItem["FECHA_CREACION"].ToString();
                dr["NUMERO_ORDEN"] = drOrdenItem["NUMERO_ORDEN"].ToString();
                dr["ID_SERVICIO"] = drOrdenItem["ID_SERVICIO"].ToString();
                dr["RUTA"] = drOrdenItem["RUTA"].ToString();
                dr["NOMBRE_CLIENTE"] = drOrdenItem["NOMBRE_CLIENTE"].ToString();
                dr["LOCALIDAD"] = drOrdenItem["LOCALIDAD"].ToString();
                dr["OPERADOR"] = drOrdenItem["OPERADOR"].ToString();
                dr["RESULTADO_FINAL"] = format_number(drOrdenItem["RESULTADO_FINAL"].ToString(),2);
                dr["SITUACION_DETECTADA"] = drOrdenItem["SITUACION_DETECTADA"].ToString();
                dr["FECHA_EJECUCION"] = drOrdenItem["FECHA_EJECUCION"].ToString();
                dr["USUARIO_VALIDA"] = drOrdenItem["USUARIO_VALIDA"].ToString();
                dr["FECHA_CIERRE"] = drOrdenItem["FECHA_CIERRE"].ToString();
                dt.Rows.Add(dr);

                total = total + 1;

            }

            DataView MydataView;
            MydataView = new DataView(dt);
            gridOrden.PageSize = int.Parse(ddPageSize.SelectedValue);  
            gridOrden.DataSource = MydataView;
            gridOrden.DataBind();

            lbTotal.Text = total + " registro(s) encontrado(s) - Página " + (gridOrden.PageIndex + 1) + " de " + gridOrden.PageCount;

            if (total > 0)
            {
                
                btn_exportar.Enabled = true;
                btn_exportar.BackColor = System.Drawing.Color.DarkGreen;
            }
            else
            {
                btn_exportar.Enabled = false;
                btn_exportar.BackColor = System.Drawing.Color.DarkGray;
            }

            int i;
            GridViewRow gvRow;
            Image ok = new Image();
            Image nOk = new Image();
            Image neutro = new Image();
            ImageButton informe = new ImageButton();
            ImageButton ver_fotos = new ImageButton();
            String serv, fecha, numero_orden,proceso,visita;
                      

            for (i = 0; i < gridOrden.Rows.Count; i++)
            {
                
                gvRow = gridOrden.Rows[i];
                ok = (Image)(gvRow.FindControl("imgOk"));
                nOk = (Image)(gvRow.FindControl("imgCru"));
                neutro = (Image)(gvRow.FindControl("imgneutro"));
                informe = (ImageButton)(gvRow.FindControl("btn_informe"));
                ver_fotos = (ImageButton)(gvRow.FindControl("btn_ver_fotos"));
                                
                serv = gridOrden.Rows[i].Cells[7].Text;
                fecha = gridOrden.Rows[i].Cells[14].Text;
                fecha = fecha.Substring(0, 10);

                string mes_ini, ano_ini, dia_ini;
                mes_ini = fecha.Substring(3, 2);
                ano_ini = fecha.Substring(6, 4);
                dia_ini = fecha.Substring(0, 2);

                fecha = dia_ini + mes_ini + ano_ini;
                numero_orden = gridOrden.Rows[i].Cells[6].Text;
                visita = gridOrden.Rows[i].Cells[4].Text;
                proceso = gridOrden.Rows[i].Cells[3].Text;

                int foto = carga_mis_fotos(proceso, serv, numero_orden, visita);

                if (foto >= 1)
                {
                    ok.Visible = true;
                    nOk.Visible = false;
                    neutro.Visible = false;
                }
                else
                {
                    ok.Visible = false;
                    nOk.Visible = true; 
                    neutro.Visible = false;
                }

            }
        }

        gridOrden.Columns[3].Visible = false;        
        
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

    protected void ddZona_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_localidad(ddRegion.SelectedValue, ddZona.SelectedValue);
        carga_rutas(ddTipoProceso.SelectedValue, ddZona.SelectedValue, ddRegion.SelectedValue, ddLocalidad.SelectedValue);
        carga_grilla_detalle(ddRegion.SelectedValue, ddZona.SelectedValue, ddLocalidad.SelectedValue, ddRuta.SelectedValue, ddOperador.SelectedValue,
                 ddContratista.SelectedValue, ddTipoProceso.SelectedValue, ddProcedencia.SelectedValue, txtOrden.Text, txtServ.Text,
                 txtDesde.Text, txtHasta.Text);
    }
   
          
    protected void gridOrden_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //gridOrden.PageIndex = e.NewPageIndex;
        gridOrden.PageIndex = e.NewPageIndex;
        carga_grilla_detalle(ddRegion.SelectedValue, ddZona.SelectedValue, ddLocalidad.SelectedValue, ddRuta.SelectedValue, ddOperador.SelectedValue,
                 ddContratista.SelectedValue, ddTipoProceso.SelectedValue, ddProcedencia.SelectedValue, txtOrden.Text, txtServ.Text,
                 txtDesde.Text, txtHasta.Text);
    }

    protected void gridOrden_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            
            int index = int.Parse(e.CommandArgument.ToString());
            var colsNoVisible = gridOrden.DataKeys[index].Values;

            if (gridOrden.PageIndex > 0) index = index - (gridOrden.PageIndex * int.Parse(ddPageSize.SelectedValue));

            string cod_op, servicio, orden, visita,proceso,grupo,atendido,med_nuevo;

            proceso = (String)colsNoVisible[2];
            visita = gridOrden.Rows[index].Cells[5].Text.Trim();
            servicio = gridOrden.Rows[index].Cells[7].Text.Trim();
            orden = gridOrden.Rows[index].Cells[6].Text.Trim();
            cod_op = (String)colsNoVisible[3];
            grupo = (String)colsNoVisible[1];
            atendido = (String)colsNoVisible[4];
            med_nuevo = (String)colsNoVisible[5];
            

            if (e.CommandName == "informe")
            {

                String vtn = "window.open('InformeComercialConsulta.aspx?Servicio=" + servicio + "&orden=" + orden + "&pr=" + proceso + "&visita=" + visita + "&atendido=" + atendido + "','Dates','scrollbars=yes,resizable=yes,height=500,width=840')";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", vtn, true);
            }

            if (e.CommandName == "ver_fotos")
            {
               
                ImageButton ver_fotos = (ImageButton)(gridOrden.Rows[index].FindControl("btn_ver_fotos"));        

                Boolean foto = verificaFoto(proceso, servicio, cod_op, visita);

                if (foto) //posee fotos.
                {
                    String vtn = "window.open('popVisorFotosConsulta.aspx?servicio=" + servicio + "&id=" + proceso + "&operador=" + cod_op + "&grupo=" + grupo + "&visita=" + visita + "','Dates','scrollbars=yes,resizable=yes,height=675,width=1270')";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", vtn, true);  
                }                
                else
                {
                    System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, typeof(System.Web.UI.Page), "Script", "alertaNoExisteFoto();", true);
                }
               
            }

            if (e.CommandName == "get_medidor")
            {
                Response.Redirect("VisorHistoricosMedidores.aspx?serie=" + med_nuevo);
            
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
    
    public Boolean existe_en_proceso(String servicio, String orden_servicio)
    {
        try
        {

            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();

            objConexion.Open();
            objComando = new OracleDataAdapter("PK_VISOR_HISTORICOS.EXISTE_EN_PROCESO", objConexion);
            objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

            PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
            PRO.agrega_parametro_sp(objComando, "i_id_servicio", OracleType.Number, ParameterDirection.Input, servicio);
            PRO.agrega_parametro_sp(objComando, "i_orden_servicio", OracleType.Number, ParameterDirection.Input, orden_servicio);

            objComando.SelectCommand.ExecuteNonQuery();
            objComando.Fill(objDS, "VALIDA");
            objConexion.Close();

            if (objDS.Tables["VALIDA"].Rows[0][0].ToString().Equals("0"))
            {

                return true;
            }
            else
            {
                return false;
            }
        }
        catch (Exception ex)
        {
            return false;
        }
    }
      

    protected void ddRuta_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(ddRegion.SelectedValue, ddZona.SelectedValue, ddLocalidad.SelectedValue, ddRuta.SelectedValue, ddOperador.SelectedValue,
                   ddContratista.SelectedValue, ddTipoProceso.SelectedValue, ddProcedencia.SelectedValue, txtOrden.Text, txtServ.Text,
                   txtDesde.Text, txtHasta.Text);
    }
    protected void ddTipoPro_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(ddRegion.SelectedValue, ddZona.SelectedValue, ddLocalidad.SelectedValue, ddRuta.SelectedValue, ddOperador.SelectedValue,
                  ddContratista.SelectedValue, ddTipoProceso.SelectedValue, ddProcedencia.SelectedValue, txtOrden.Text, txtServ.Text,
                  txtDesde.Text, txtHasta.Text);

    }
    protected void ddLocalidad_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_rutas(ddTipoProceso.SelectedValue, ddZona.SelectedValue, ddRegion.SelectedValue, ddLocalidad.SelectedValue);
        carga_grilla_detalle(ddRegion.SelectedValue, ddZona.SelectedValue, ddLocalidad.SelectedValue, ddRuta.SelectedValue, ddOperador.SelectedValue,
                  ddContratista.SelectedValue, ddTipoProceso.SelectedValue, ddProcedencia.SelectedValue, txtOrden.Text, txtServ.Text,
                  txtDesde.Text, txtHasta.Text);
    }
    protected void ddEstado_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(ddRegion.SelectedValue, ddZona.SelectedValue, ddLocalidad.SelectedValue, ddRuta.SelectedValue, ddOperador.SelectedValue,
                  ddContratista.SelectedValue, ddTipoProceso.SelectedValue, ddProcedencia.SelectedValue, txtOrden.Text, txtServ.Text,
                  txtDesde.Text, txtHasta.Text);
    }

    protected void ddTipoIn_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(ddRegion.SelectedValue, ddZona.SelectedValue, ddLocalidad.SelectedValue, ddRuta.SelectedValue, ddOperador.SelectedValue,
                  ddContratista.SelectedValue, ddTipoProceso.SelectedValue, ddProcedencia.SelectedValue, txtOrden.Text, txtServ.Text,
                  txtDesde.Text, txtHasta.Text);
    }
    protected void ddSincro_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(ddRegion.SelectedValue, ddZona.SelectedValue, ddLocalidad.SelectedValue, ddRuta.SelectedValue, ddOperador.SelectedValue,
                  ddContratista.SelectedValue, ddTipoProceso.SelectedValue, ddProcedencia.SelectedValue, txtOrden.Text, txtServ.Text,
                  txtDesde.Text, txtHasta.Text);
    }



    protected void txtServ_TextChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(ddRegion.SelectedValue, ddZona.SelectedValue, ddLocalidad.SelectedValue, ddRuta.SelectedValue, ddOperador.SelectedValue,
                 ddContratista.SelectedValue, ddTipoProceso.SelectedValue, ddProcedencia.SelectedValue, txtOrden.Text, txtServ.Text,
                 txtDesde.Text, txtHasta.Text);
    }
    protected void txtDesde_TextChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(ddRegion.SelectedValue, ddZona.SelectedValue, ddLocalidad.SelectedValue, ddRuta.SelectedValue, ddOperador.SelectedValue,
                 ddContratista.SelectedValue, ddTipoProceso.SelectedValue, ddProcedencia.SelectedValue, txtOrden.Text, txtServ.Text,
                 txtDesde.Text, txtHasta.Text);
    }
    protected void txtHasta_TextChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(ddRegion.SelectedValue, ddZona.SelectedValue, ddLocalidad.SelectedValue, ddRuta.SelectedValue, ddOperador.SelectedValue,
                    ddContratista.SelectedValue, ddTipoProceso.SelectedValue, ddProcedencia.SelectedValue, txtOrden.Text, txtServ.Text,
                    txtDesde.Text, txtHasta.Text);
    }
    protected void Calendar1_SelectionChanged(object sender, EventArgs e)
    {

    }
    protected void Button1_Click1(object sender, EventArgs e)
    {
        carga_grilla_detalle(ddRegion.SelectedValue, ddZona.SelectedValue, ddLocalidad.SelectedValue, ddRuta.SelectedValue, ddOperador.SelectedValue,
                  ddContratista.SelectedValue, ddTipoProceso.SelectedValue, ddProcedencia.SelectedValue, txtOrden.Text, txtServ.Text,
                  txtDesde.Text, txtHasta.Text);
    }
    protected void gridOrden_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.RowState == DataControlRowState.Alternate)
            {
                //  e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#FFFFE1';");
                // e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor='#f7fff8';");
            }
            else
            {
                // e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#FFFFE1';");
                // e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor='#eefef0';");
            }
        }
    }


    protected void ddRegion_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_zona(ddRegion.SelectedValue);
        carga_localidad(ddRegion.SelectedValue, ddZona.SelectedValue);
        carga_rutas(ddTipoProceso.SelectedValue, ddZona.SelectedValue, ddRegion.SelectedValue, ddLocalidad.SelectedValue);
        carga_grilla_detalle(ddRegion.SelectedValue, ddZona.SelectedValue, ddLocalidad.SelectedValue, ddRuta.SelectedValue, ddOperador.SelectedValue,
                  ddContratista.SelectedValue, ddTipoProceso.SelectedValue, ddProcedencia.SelectedValue, txtOrden.Text, txtServ.Text,
                  txtDesde.Text, txtHasta.Text);
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
            //carga_grilla_detalle(ddRegion.SelectedValue, ddZona.SelectedValue, ddLocalidad.SelectedValue, ddRuta.SelectedValue, ddOperador.SelectedValue,
            //     ddContratista.SelectedValue, ddTipoProceso.SelectedValue, ddProcedencia.SelectedValue, txtOrden.Text, txtServ.Text,
            //     txtDesde.Text, txtHasta.Text);

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

    public int carga_mis_fotos(String id_proceso, String id_servicio, String numero_orden, String visita)
    {
        int contador = 0;
        try
        {
            String sin_fotos = new Uri(Server.MapPath("~/Imagenes/sin_foto.png")).AbsoluteUri;
            String ruta_fotos_procesada = "FOTOS/" + id_proceso + "/";
            String ruta_fotos_sin_proceso = "FOTOS/";
            String[] mis_fotos_procesadas;            

            if (!Directory.Exists(Server.MapPath("./" + ruta_fotos_procesada + "/"))) System.IO.Directory.CreateDirectory(Server.MapPath("./" + ruta_fotos_procesada + "/"));

            //Obtenemos los nombres de las fotos que tenga el servicio en su carpeta procesada.
            mis_fotos_procesadas = Directory.GetFiles(Server.MapPath("./" + ruta_fotos_procesada), id_servicio + "*");

            if (mis_fotos_procesadas.Length > 0) MisFicheros = new DirectoryInfo(Server.MapPath("./" + ruta_fotos_procesada + "/")).GetFiles(id_servicio + "*");
            else MisFicheros = new DirectoryInfo(Server.MapPath("./" + ruta_fotos_sin_proceso + "/")).GetFiles(id_servicio + "*");

            if (MisFicheros.Length > 0)
            {
                Int32 indice = 0;

                for (int i = 0; i < MisFicheros.Length; i++)
                {
                    String nombre_foto = MisFicheros[i].Name;
                    String ruta_completa = MisFicheros[i].FullName.Replace(Server.MapPath(""), "~");
                    String[] foto_split = nombre_foto.Split('A'); //0: servicio, 1: fecha, 2: nro orden, 3: visita, 4: corr.jpeg                
                    indice = Int32.Parse(foto_split[4].Replace(".jpeg", ""));


                    if (nombre_foto.Contains(id_servicio + "A") && nombre_foto.Contains("A" + numero_orden + "A")
                        && nombre_foto.Contains("A" + visita + "A"))
                    {
                        contador++;
                    }

                }
            }

            return contador;
        }
        catch (Exception ex)
        {
            return contador;
        }
        
    }

    


    protected void ddPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(ddRegion.SelectedValue, ddZona.SelectedValue, ddLocalidad.SelectedValue, ddRuta.SelectedValue, ddOperador.SelectedValue,
                 ddContratista.SelectedValue, ddTipoProceso.SelectedValue, ddProcedencia.SelectedValue, txtOrden.Text, txtServ.Text,
                 txtDesde.Text, txtHasta.Text);
    }
    
   
    protected void ddOrigenOrden_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_rutas(ddTipoProceso.SelectedValue, ddZona.SelectedValue, ddRegion.SelectedValue, ddLocalidad.SelectedValue);
        carga_grilla_detalle(ddRegion.SelectedValue, ddZona.SelectedValue, ddLocalidad.SelectedValue, ddRuta.SelectedValue, ddOperador.SelectedValue,
                 ddContratista.SelectedValue, ddTipoProceso.SelectedValue, ddProcedencia.SelectedValue, txtOrden.Text, txtServ.Text,
                 txtDesde.Text, txtHasta.Text);
    }
    protected void ddContratista_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla_detalle(ddRegion.SelectedValue, ddZona.SelectedValue, ddLocalidad.SelectedValue, ddRuta.SelectedValue, ddOperador.SelectedValue,
                 ddContratista.SelectedValue, ddTipoProceso.SelectedValue, ddProcedencia.SelectedValue, txtOrden.Text, txtServ.Text,
                 txtDesde.Text, txtHasta.Text);
    }

    public void datatable_to_excel(DataTable dt)
    {
        try
        {
            String salida;
            DataRow dr;
            StreamWriter sr;
            int total = 0;

            sr = new StreamWriter(Server.MapPath("./SALIDA/" + "DETALLE_ORDENES" + DateTime.Now.ToString("ddMMyyyy") + ".csv"));

            salida = " VISITA" + ";"
                        + "SERVICIO" + ";"
                        + "NUMERO ORDEN" + ";"
                        + "FECHA CREACION" + ";"
                        + "FECHA INTEGRACION" + ";"
                        + "ESTADO MEDIDOR RETIRADO" + ";"
                        + "DIAMETRO RETIRADO " + ";"
                        + "SERIE MEDIDOR RETIRADO" + ";"
                        + "LEECTURA RETIRADO" + ";"
                        + "DIAMETRO NUEVO" + ";"
                        + "NUMERO MEDIDOR NUEVO" + ";"
                        + "LECTURA MEDIDOR NUEVO" + ";"
                        + "RUTA" + ";"
                        + "LOCALIDAD" + ";"
                        + "TIPO PROCESO" + ";"
                        + "INSTALADOR" + ";"
                        + "CONTRATISTA" + ";"
                        + "IMPROCEDENCIA" + ";"
                        + "FECHA EJECUCION" + ";"
                        + "CAUSA CAMBIO" + ";"
                        + "CODIGO CONTRATISTA" + ";"
                        + "ULTIMA LECTURA EF" + ";"
                        + "FECHA ULTIMA LECTURA EF" + ";"
                        + "PROMEDIO" + ";"
                        + "GESTION CORTE" + ";"
                        + "DEN. TECNICA" + ";"
                        + "SERIE MEDIDOR" + ";"
                        + "TIPO INSTALACION" + ";"

                        + "CLIENTE" + ";"
                        + "DIRECCION" + ";"
                        + "FECHA MED EXISTENTE" + ";"
                        + "OBSERVACION IN" + ";"
                        + "OBSERVACION OUT" + ";"
                        + "COD LOCALIDAD" + ";"
                        + "COD IMPROCEDENCIA" + ";"
                        + "COD MARCA" + ";"
                        + "ANIO MEDIDOR NUEVO" + ";"
                        + "COD VARAL" + ";"
                        + "COD LLAVE" + ";"
                        + "RUT CLIENTE" + ";"
                        + "COOR X" + ";"
                        + "COOR Y" + ";"
                        + "SINCRONIZACION" + ";"
                        + "FIRMA" + ";"
                        + "COD TIPO SELLO" + ";"
                        + "SALIDA" + ";"
                        + "FECHA DESCARGA" + ";"
                        + "USUARIO" + ";"
                        + "FECHA CARGA APP" + ";"
                        + "CODIGO UNICO MEDIDOR" + ";"
                        + "FONO CONTACTO" + ";"
                        + "CORREO CONTACTO" + ";"
                        + "CANTIDAD AJUSTE" + ";"
                        + "CANTIDAD TUERCA NORMAL" + ";"
                        + "CANTIDAD TUERCA DIFERIDA" + ";"
                        + "CANTIDAD VAINA" + ";"
                        + "CANTIDAD MEDIDOR";

            sr.WriteLine(salida);

            foreach (DataRow drOrdenItem in dt.Rows)
            {
                try
                {
                    dr = dt.NewRow();


                    dr["VISITA"] = drOrdenItem["VISITA"].ToString();
                    dr["ID_SERVICIO"] = drOrdenItem["ID_SERVICIO"].ToString();
                    dr["NUMERO_ORDEN"] = drOrdenItem["NUMERO_ORDEN"].ToString();
                    dr["FECHA_CREACION"] = drOrdenItem["FECHA_CREACION"].ToString();
                    dr["FECHA_INTEGRACION"] = drOrdenItem["FECHA_INTEGRACION"].ToString();
                    dr["ESTADO_MR"] = drOrdenItem["ESTADO_MR"].ToString();
                    dr["DIAMETRO_RET"] = drOrdenItem["DIAMETRO_RET"].ToString();
                    dr["SERIE_MEDIDOR_RET"] = drOrdenItem["SERIE_MEDIDOR_RET"].ToString();
                    dr["LECTURA_RET"] = drOrdenItem["LECTURA_RET"].ToString();
                    dr["DIAMETRO_NU"] = drOrdenItem["DIAMETRO_NU"].ToString();

                    dr["NUMERO_MN"] = drOrdenItem["NUMERO_MN"].ToString();
                    dr["LECTURA_MN"] = drOrdenItem["LECTURA_MN"].ToString();
                    dr["RUTA"] = drOrdenItem["RUTA"].ToString();
                    dr["LOCALIDAD"] = drOrdenItem["LOCALIDAD"].ToString();
                    dr["TIPO_PROCESO"] = drOrdenItem["TIPO_PROCESO"].ToString();
                    dr["INSTALADOR"] = drOrdenItem["INSTALADOR"].ToString();
                    dr["CONTRATISTA"] = drOrdenItem["CONTRATISTA"].ToString();
                    dr["IMPROCEDENCIA"] = drOrdenItem["IMPROCEDENCIA"].ToString();
                    dr["FECHA_INST"] = drOrdenItem["FECHA_INST"].ToString();
                    dr["CAUSA"] = drOrdenItem["CAUSA"].ToString();

                    dr["COD_CONTRATISTA"] = drOrdenItem["COD_CONTRATISTA"].ToString();
                    dr["UL_LECT_EF"] = drOrdenItem["UL_LECT_EF"].ToString();     
                    dr["FECHA_UL_LECT_EF"] = drOrdenItem["FECHA_UL_LECT_EF"].ToString();
                    dr["PROMEDIO"] = drOrdenItem["PROMEDIO"].ToString();
                    dr["GESTION_CORTE"] = drOrdenItem["GESTION_CORTE"].ToString();
                    dr["TIPO_MARCA_DI"] = drOrdenItem["TIPO_MARCA_DI"].ToString();
                    dr["SERIE_MEDIDOR"] = drOrdenItem["SERIE_MEDIDOR"].ToString();
                    dr["TIPO_INSTALACION"] = drOrdenItem["TIPO_INSTALACION"].ToString();
                    dr["CLIENTE"] = drOrdenItem["CLIENTE"].ToString();
                    dr["DIRECCION"] = drOrdenItem["DIRECCION"].ToString();

                    dr["FECHA_IN_ME"] = drOrdenItem["FECHA_IN_ME"].ToString();
                    dr["OBSERVACION_IN"] = drOrdenItem["OBSERVACION_IN"].ToString();
                    dr["OBSERVACION_OUT"] = drOrdenItem["OBSERVACION_OUT"].ToString();
                    dr["COD_LOCALIDAD"] = drOrdenItem["COD_LOCALIDAD"].ToString();
                    dr["COD_IMPROCEDENCIA"] = drOrdenItem["COD_IMPROCEDENCIA"].ToString();
                    dr["COD_MARCA"] = drOrdenItem["COD_MARCA"].ToString();
                    dr["ANO_MN"] = drOrdenItem["ANO_MN"].ToString();
                    dr["COD_VARAL"] = drOrdenItem["COD_VARAL"].ToString();
                    dr["COD_LLAVE"] = drOrdenItem["COD_LLAVE"].ToString();

                    dr["RUT_CLIENTE"] = drOrdenItem["RUT_CLIENTE"].ToString();
                    dr["X"] = drOrdenItem["X"].ToString();
                    dr["Y"] = drOrdenItem["Y"].ToString();
                    dr["SINCRONIZACION"] = drOrdenItem["SINCRONIZACION"].ToString();
                    dr["FIRMA"] = drOrdenItem["FIRMA"].ToString();

                    
                    dr["COD_TIPOSELLO"] = drOrdenItem["COD_TIPOSELLO"].ToString();
                    dr["SALIDA"] = drOrdenItem["SALIDA"].ToString();
                    dr["FECHA_DESCARGA"] = drOrdenItem["FECHA_DESCARGA"].ToString();
                    dr["ID_USUARIO"] = drOrdenItem["ID_USUARIO"].ToString();
                    dr["FECHA_CARGA"] = drOrdenItem["FECHA_CARGA"].ToString();
                    dr["CODIGO_UNICO"] = drOrdenItem["CODIGO_UNICO"].ToString();
                    dr["FONO_CONTACTO"] = drOrdenItem["FONO_CONTACTO"].ToString();
                    dr["CORREO_CONTACTO"] = drOrdenItem["CORREO_CONTACTO"].ToString();
                    dr["ACCESORIO_AJUSTE"] = drOrdenItem["ACCESORIO_AJUSTE"].ToString();
                    dr["ACCESORIO_TNORMAL"] = drOrdenItem["ACCESORIO_TNORMAL"].ToString();
                    dr["ACCESORIO_TDIFERIDA"] = drOrdenItem["ACCESORIO_TDIFERIDA"].ToString();
                    dr["ACCESORIO_VAINA"] = drOrdenItem["ACCESORIO_VAINA"].ToString();
                    dr["ACCESORIO_MEDIDOR"] = drOrdenItem["ACCESORIO_MEDIDOR"].ToString();



                    total = total + 1;

                    salida = dr["VISITA"] + ";" +
                             dr["ID_SERVICIO"] + ";" +
                             dr["NUMERO_ORDEN"] + ";" +
                             dr["FECHA_CREACION"] + ";" +
                             dr["FECHA_INTEGRACION"] + ";" +
                             dr["ESTADO_MR"] + ";" +
                             dr["DIAMETRO_RET"] + ";" +
                             dr["SERIE_MEDIDOR_RET"] + ";" +
                             dr["LECTURA_RET"] + ";" +
                             dr["DIAMETRO_NU"] + ";" +

                             dr["NUMERO_MN"] + ";" +
                             dr["LECTURA_MN"] + ";" +
                             dr["RUTA"] + ";" +
                             dr["LOCALIDAD"] + ";" +
                             dr["TIPO_PROCESO"] + ";" +
                             dr["INSTALADOR"] + ";" +
                             dr["CONTRATISTA"] + ";" +
                             dr["IMPROCEDENCIA"] + ";" +
                             dr["FECHA_INST"] + ";" +
                             dr["CAUSA"] + ";" +

                             dr["COD_CONTRATISTA"] + ";" +
                             dr["UL_LECT_EF"] + ";" +
                             dr["FECHA_UL_LECT_EF"] + ";" +
                             dr["PROMEDIO"] + ";" +
                             dr["GESTION_CORTE"] + ";" +
                             dr["TIPO_MARCA_DI"] + ";" +
                             dr["SERIE_MEDIDOR"] + ";" +
                             dr["TIPO_INSTALACION"] + ";" +
                             dr["CLIENTE"] + ";" +
                             dr["DIRECCION"] + ";" +

                             dr["FECHA_IN_ME"] + ";" +
                             dr["OBSERVACION_IN"] + ";" +
                             dr["OBSERVACION_OUT"] + ";" +
                             dr["COD_LOCALIDAD"] + ";" +
                             dr["COD_IMPROCEDENCIA"] + ";" +
                             dr["COD_MARCA"] + ";" +
                             dr["ANO_MN"] + ";" +
                             dr["COD_VARAL"] + ";" +
                             dr["COD_LLAVE"] + ";" +

                             dr["RUT_CLIENTE"] + ";" +
                             dr["X"] + ";" +
                             dr["Y"] + ";" +
                             dr["SINCRONIZACION"] + ";" +
                             dr["FIRMA"] + ";" +
                             dr["COD_TIPOSELLO"] + ";" +
                             dr["SALIDA"] + ";" +
                             dr["FECHA_DESCARGA"] + ";" +
                             dr["ID_USUARIO"] + ";" +
                             dr["FECHA_CARGA"] + ";" +

                             dr["CODIGO_UNICO"] + ";" +
                             dr["FONO_CONTACTO"] + ";" +
                             dr["CORREO_CONTACTO"] + ";" +
                             dr["ACCESORIO_AJUSTE"] + ";" +
                             dr["ACCESORIO_TNORMAL"] + ";" +
                             dr["ACCESORIO_TDIFERIDA"] + ";" +
                             dr["ACCESORIO_VAINA"] + ";" +
                             dr["ACCESORIO_MEDIDOR"];


                    sr.WriteLine(salida);

                }
                catch (Exception ex)
                {
                    continue;
                }
            }
            sr.Close();

            Response.Redirect("./SALIDA/" + "DETALLE_ORDENES" + DateTime.Now.ToString("ddMMyyyy") + ".csv", false);
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

    public void carga_grilla_detalle(String region, String zona, String localidad, String lote, String operador, String contratista,
        String tipo_proceso, String improcedencia, String numero_orden, String servicio, String desde, String hasta)
    {

        if (txtServ.Text != "" || txtOrden.Text != "")
        {
            ddPageSize.Visible = true;
            //String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
            id_contr = "0";

            OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
            OracleCommand cmdAcceso = new OracleCommand("PK_VISOR_HISTORICOS.CARGA_ORDENES_RESUMEN", CnOra);
            OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

            PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
            PRO.agrega_parametro_sp(da, "i_region", OracleType.Number, ParameterDirection.Input, region);
            PRO.agrega_parametro_sp(da, "i_zona", OracleType.Number, ParameterDirection.Input, zona);
            PRO.agrega_parametro_sp(da, "i_localidad", OracleType.Number, ParameterDirection.Input, localidad);
            PRO.agrega_parametro_sp(da, "i_lote", OracleType.Number, ParameterDirection.Input, lote);
            PRO.agrega_parametro_sp(da, "i_operador", OracleType.Number, ParameterDirection.Input, operador);

            if (contratista.Length == 0) contratista = id_contr;

            PRO.agrega_parametro_sp(da, "i_contratista", OracleType.Number, ParameterDirection.Input, contratista);
            PRO.agrega_parametro_sp(da, "i_tipoproceso", OracleType.NVarChar, ParameterDirection.Input, tipo_proceso);
            PRO.agrega_parametro_sp(da, "i_improcedencia", OracleType.NVarChar, ParameterDirection.Input, improcedencia);

            if (numero_orden.Length == 0) numero_orden = "0";

            PRO.agrega_parametro_sp(da, "i_numero_orden", OracleType.Number, ParameterDirection.Input, numero_orden);
            PRO.agrega_parametro_sp(da, "i_servicio", OracleType.NVarChar, ParameterDirection.Input, servicio);
            PRO.agrega_parametro_sp(da, "i_desde", OracleType.NVarChar, ParameterDirection.Input, desde);
            PRO.agrega_parametro_sp(da, "i_hasta", OracleType.NVarChar, ParameterDirection.Input, hasta);

            da.SelectCommand.CommandType = CommandType.StoredProcedure;

            DataTable dt = new DataTable();
            dt.Columns.Add(new DataColumn("ID_ORDEN", typeof(String)));
            dt.Columns.Add(new DataColumn("ATENDIDO", typeof(String)));
            dt.Columns.Add(new DataColumn("VISITA", typeof(String)));
            dt.Columns.Add(new DataColumn("NUMERO_ORDEN", typeof(String)));
            dt.Columns.Add(new DataColumn("ID_SERVICIO", typeof(String)));
            dt.Columns.Add(new DataColumn("FECHA_CREACION", typeof(String)));
            dt.Columns.Add(new DataColumn("GRUPO_PROCESO", typeof(String)));
            dt.Columns.Add(new DataColumn("ID_PROCESO", typeof(String)));
            dt.Columns.Add(new DataColumn("COD_INSTALADOR", typeof(String)));
            dt.Columns.Add(new DataColumn("FECHA_INTEGRACION", typeof(String)));
            dt.Columns.Add(new DataColumn("ESTADO_MR", typeof(String)));
            dt.Columns.Add(new DataColumn("DIAMETRO_RET", typeof(String)));
            dt.Columns.Add(new DataColumn("SERIE_MEDIDOR_RET", typeof(String)));
            dt.Columns.Add(new DataColumn("LECTURA_RET", typeof(String)));
            dt.Columns.Add(new DataColumn("DIAMETRO_NU", typeof(String)));
            dt.Columns.Add(new DataColumn("NUMERO_MN", typeof(String)));
            dt.Columns.Add(new DataColumn("LECTURA_MN", typeof(String)));
            dt.Columns.Add(new DataColumn("RUTA", typeof(String)));
            dt.Columns.Add(new DataColumn("LOCALIDAD", typeof(String)));
            dt.Columns.Add(new DataColumn("TIPO_PROCESO", typeof(String)));
            dt.Columns.Add(new DataColumn("INSTALADOR", typeof(String)));
            dt.Columns.Add(new DataColumn("CONTRATISTA", typeof(String)));
            dt.Columns.Add(new DataColumn("IMPROCEDENCIA", typeof(String)));
            dt.Columns.Add(new DataColumn("FECHA_INST", typeof(String)));

            dt.Columns.Add(new DataColumn("CAUSA", typeof(String)));
            dt.Columns.Add(new DataColumn("COD_CONTRATISTA", typeof(String)));
            dt.Columns.Add(new DataColumn("UL_LECT_EF", typeof(String)));
            dt.Columns.Add(new DataColumn("FECHA_UL_LECT_EF", typeof(String)));
            dt.Columns.Add(new DataColumn("PROMEDIO", typeof(String)));
            dt.Columns.Add(new DataColumn("GESTION_CORTE", typeof(String)));
            dt.Columns.Add(new DataColumn("TIPO_MARCA_DI", typeof(String)));
            dt.Columns.Add(new DataColumn("SERIE_MEDIDOR", typeof(String)));
            dt.Columns.Add(new DataColumn("TIPO_INSTALACION", typeof(String)));
            dt.Columns.Add(new DataColumn("CLIENTE", typeof(String)));

            dt.Columns.Add(new DataColumn("DIRECCION", typeof(String)));
            dt.Columns.Add(new DataColumn("FECHA_IN_ME", typeof(String)));
            dt.Columns.Add(new DataColumn("OBSERVACION_IN", typeof(String)));
            dt.Columns.Add(new DataColumn("OBSERVACION_OUT", typeof(String)));
            dt.Columns.Add(new DataColumn("COD_LOCALIDAD", typeof(String)));
            dt.Columns.Add(new DataColumn("COD_IMPROCEDENCIA", typeof(String)));
            dt.Columns.Add(new DataColumn("COD_MARCA", typeof(String)));
            dt.Columns.Add(new DataColumn("ANO_MN", typeof(String)));
            dt.Columns.Add(new DataColumn("COD_VARAL", typeof(String)));

            dt.Columns.Add(new DataColumn("COD_LLAVE", typeof(String)));
            dt.Columns.Add(new DataColumn("RUT_CLIENTE", typeof(String)));
            dt.Columns.Add(new DataColumn("X", typeof(String)));
            dt.Columns.Add(new DataColumn("Y", typeof(String)));
            dt.Columns.Add(new DataColumn("SINCRONIZACION", typeof(String)));
            dt.Columns.Add(new DataColumn("FIRMA", typeof(String)));
            dt.Columns.Add(new DataColumn("COD_TIPOSELLO", typeof(String)));
            dt.Columns.Add(new DataColumn("SALIDA", typeof(String)));
            dt.Columns.Add(new DataColumn("FECHA_DESCARGA", typeof(String)));
            dt.Columns.Add(new DataColumn("ID_USUARIO", typeof(String)));

            dt.Columns.Add(new DataColumn("FECHA_CARGA", typeof(String)));
            dt.Columns.Add(new DataColumn("CODIGO_UNICO", typeof(String)));
            dt.Columns.Add(new DataColumn("FONO_CONTACTO", typeof(String)));
            dt.Columns.Add(new DataColumn("CORREO_CONTACTO", typeof(String)));
            dt.Columns.Add(new DataColumn("ACCESORIO_AJUSTE", typeof(String)));
            dt.Columns.Add(new DataColumn("ACCESORIO_TNORMAL", typeof(String)));
            dt.Columns.Add(new DataColumn("ACCESORIO_TDIFERIDA", typeof(String)));
            dt.Columns.Add(new DataColumn("ACCESORIO_VAINA", typeof(String)));
            dt.Columns.Add(new DataColumn("ACCESORIO_MEDIDOR", typeof(String)));

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

                    dr["ID_ORDEN"] = drOrdenItem["ID_ORDEN"].ToString();
                    dr["GRUPO_PROCESO"] = drOrdenItem["GRUPO_PROCESO"].ToString();
                    dr["ID_PROCESO"] = drOrdenItem["ID_PROCESO"].ToString();
                    dr["COD_INSTALADOR"] = drOrdenItem["COD_INSTALADOR"].ToString();
                    dr["ATENDIDO"] = drOrdenItem["ATENDIDO"].ToString();
                    dr["VISITA"] = drOrdenItem["VISITA"].ToString();
                    dr["NUMERO_ORDEN"] = drOrdenItem["NUMERO_ORDEN"].ToString();
                    dr["ID_SERVICIO"] = drOrdenItem["ID_SERVICIO"].ToString();
                    dr["LOCALIDAD"] = drOrdenItem["LOCALIDAD"].ToString();
                    dr["SERIE_MEDIDOR_RET"] = drOrdenItem["SERIE_MEDIDOR_RET"].ToString();
                    dr["CAUSA"] = drOrdenItem["CAUSA"].ToString();
                    dr["TIPO_PROCESO"] = drOrdenItem["TIPO_PROCESO"].ToString();
                    dr["CONTRATISTA"] = drOrdenItem["CONTRATISTA"].ToString();
                    dr["INSTALADOR"] = drOrdenItem["INSTALADOR"].ToString();
                    dr["NUMERO_MN"] = drOrdenItem["NUMERO_MN"].ToString();
                    dr["IMPROCEDENCIA"] = drOrdenItem["IMPROCEDENCIA"].ToString();
                    dr["ESTADO_MR"] = drOrdenItem["ESTADO_MR"].ToString();
                    dr["FECHA_INST"] = drOrdenItem["FECHA_INST"].ToString();


                    dr["FECHA_CREACION"] = drOrdenItem["FECHA_CREACION"].ToString();
                    dr["FECHA_INTEGRACION"] = drOrdenItem["FECHA_INTEGRACION"].ToString();
                    dr["DIAMETRO_RET"] = drOrdenItem["DIAMETRO_RET"].ToString();
                    dr["LECTURA_RET"] = drOrdenItem["LECTURA_RET"].ToString();
                    dr["DIAMETRO_NU"] = drOrdenItem["DIAMETRO_NU"].ToString();
                    dr["LECTURA_MN"] = drOrdenItem["LECTURA_MN"].ToString();
                    dr["RUTA"] = drOrdenItem["RUTA"].ToString();
                    dr["COD_CONTRATISTA"] = drOrdenItem["COD_CONTRATISTA"].ToString();
                    dr["UL_LECT_EF"] = drOrdenItem["UL_LECT_EF"].ToString();
                    dr["FECHA_UL_LECT_EF"] = drOrdenItem["FECHA_UL_LECT_EF"].ToString();
                    dr["PROMEDIO"] = "" + drOrdenItem["PROMEDIO"].ToString();
                    dr["GESTION_CORTE"] = drOrdenItem["GESTION_CORTE"].ToString();
                    dr["TIPO_MARCA_DI"] = drOrdenItem["TIPO_MARCA_DI"].ToString();
                    dr["SERIE_MEDIDOR"] = drOrdenItem["SERIE_MEDIDOR"].ToString();
                    dr["TIPO_INSTALACION"] = drOrdenItem["TIPO_INSTALACION"].ToString();
                    dr["CLIENTE"] = drOrdenItem["CLIENTE"].ToString();
                    dr["DIRECCION"] = drOrdenItem["DIRECCION"].ToString();
                    dr["FECHA_IN_ME"] = drOrdenItem["FECHA_IN_ME"].ToString();
                    dr["OBSERVACION_IN"] = drOrdenItem["OBSERVACION_IN"].ToString();
                    dr["OBSERVACION_OUT"] = drOrdenItem["OBSERVACION_OUT"].ToString();
                    dr["COD_LOCALIDAD"] = drOrdenItem["COD_LOCALIDAD"].ToString();
                    dr["COD_IMPROCEDENCIA"] = drOrdenItem["COD_IMPROCEDENCIA"].ToString();
                    dr["COD_MARCA"] = drOrdenItem["COD_MARCA"].ToString();
                    dr["ANO_MN"] = drOrdenItem["ANO_MN"].ToString();
                    dr["COD_VARAL"] = drOrdenItem["COD_VARAL"].ToString();
                    dr["COD_LLAVE"] = drOrdenItem["COD_LLAVE"].ToString();
                    dr["RUT_CLIENTE"] = drOrdenItem["RUT_CLIENTE"].ToString();
                    dr["X"] = drOrdenItem["X"].ToString();
                    dr["Y"] = drOrdenItem["Y"].ToString();
                    dr["SINCRONIZACION"] = drOrdenItem["SINCRONIZACION"].ToString();
                    dr["FIRMA"] = drOrdenItem["FIRMA"].ToString();
                    dr["COD_TIPOSELLO"] = drOrdenItem["COD_TIPOSELLO"].ToString();
                    dr["SALIDA"] = drOrdenItem["SALIDA"].ToString();
                    dr["FECHA_DESCARGA"] = drOrdenItem["FECHA_DESCARGA"].ToString();
                    dr["ID_USUARIO"] = drOrdenItem["ID_USUARIO"].ToString();
                    dr["FECHA_CARGA"] = drOrdenItem["FECHA_CARGA"].ToString();
                    dr["CODIGO_UNICO"] = drOrdenItem["CODIGO_UNICO"].ToString();
                    dr["FONO_CONTACTO"] = drOrdenItem["FONO_CONTACTO"].ToString();
                    dr["CORREO_CONTACTO"] = drOrdenItem["CORREO_CONTACTO"].ToString();
                    dr["ACCESORIO_AJUSTE"] = drOrdenItem["ACCESORIO_AJUSTE"].ToString();
                    dr["ACCESORIO_TNORMAL"] = drOrdenItem["ACCESORIO_TNORMAL"].ToString();
                    dr["ACCESORIO_TDIFERIDA"] = drOrdenItem["ACCESORIO_TDIFERIDA"].ToString();
                    dr["ACCESORIO_VAINA"] = drOrdenItem["ACCESORIO_VAINA"].ToString();
                    dr["ACCESORIO_MEDIDOR"] = drOrdenItem["ACCESORIO_MEDIDOR"].ToString();


                    dt.Rows.Add(dr);

                    total = total + 1;

                }

                DataView MydataView;
                MydataView = new DataView(dt);
                gridOrden.DataSource = MydataView;
                gridOrden.DataBind();

                dt_excel = dt;

                int c;
                GridViewRow gvRow;
                HyperLink hlMapa = new HyperLink();
                HyperLink hlDet = new HyperLink();
                Image ok = new Image();
                Image nOk = new Image();
                ImageButton det = new ImageButton();
                ImageButton mapa = new ImageButton();

                String LON;
                String LAT;

                if (gridOrden.PageCount == 0) lbTotal.Text = total + " registro(s) encontrado(s) - Página " + (gridOrden.PageIndex) + " de " + gridOrden.PageCount;
                else lbTotal.Text = total + " registro(s) encontrado(s) - Página " + (gridOrden.PageIndex + 1) + " de " + gridOrden.PageCount;


                for (c = 0; c < gridOrden.Rows.Count; c++)
                {
                    gvRow = gridOrden.Rows[c];


                    var colsNoVisible = gridOrden.DataKeys[c].Values;

                    String serv = gvRow.Cells[7].Text;
                    String id_pr = (String)colsNoVisible[2];
                    String grupo = (String)colsNoVisible[1];
                    String cod_op = (String)colsNoVisible[3];
                    String visita = gvRow.Cells[5].Text;

                    try
                    {
                        Boolean foto = true;//verificaFoto(id_pr, serv, cod_op, visita);



                        ok = (Image)(gvRow.FindControl("imgOk"));
                        nOk = (Image)(gvRow.FindControl("imgCru"));

                        if (foto == true)
                        {
                            ok.Visible = true;
                            nOk.Visible = false;
                        }
                        else
                        {
                            ok.Visible = false;
                            nOk.Visible = true;
                        }

                        ///fin verifica foto
                    }
                    catch (Exception ex)
                    {
                        continue;
                    }

                }


            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + ex.Message.ToString() + "');", true);

                //ERROR AL INTEGRAR ARCHIVO.
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('Debe ingresar un servicio o número de orden');", true);

        }
        

    }

    public Boolean verificaFoto(String di, String serv, String op, String vi)
    {

        String CARPETA_FOTOS = "FOTOS";

        String ruta_directorio;
        String ruta_directorioVisita;

        String[] arrArchivosFotos;
        String[] arrArchivosFotosVisita;

        FileInfo[] MisFicheros;
        FileInfo[] MisFicherosVisita;

        Boolean ex = false;

        String fotoA = di + "A" + serv + "A" + op + "A";
        String fotoVisita = di + "A" + serv + "A" + op + "A" + vi + "A";

        ruta_directorio = Server.MapPath("./FOTOS/");
        ruta_directorioVisita = Server.MapPath("./FOTOS/" + vi + "/");

        arrArchivosFotosVisita = Directory.GetFiles(Server.MapPath("./" + CARPETA_FOTOS + "/" + vi + "/"), "*" + fotoVisita + "*");
        MisFicherosVisita = new DirectoryInfo(ruta_directorioVisita).GetFiles("*" + fotoVisita + "*");
        
        //String fotoN = di + "A" + serv + "A" + op + "_N.jpg";
        //String fotoE = di + "A" + serv + "A" + op + "_E.jpg";

        for (int i = 0; i < MisFicherosVisita.Length; i++)
        {
            String arch = MisFicherosVisita[i].Name;
            String nam = MisFicherosVisita[i].FullName.Replace(Server.MapPath(""), "~");

            if (arch.Contains(fotoVisita))
            {
                ex = true;
                return ex;
            }

        }

        if (ex.Equals(false))
        {
            arrArchivosFotos = Directory.GetFiles(Server.MapPath("./" + CARPETA_FOTOS + "/"), "*" + fotoA + "*");
            MisFicheros = new DirectoryInfo(ruta_directorio).GetFiles("*" + fotoA + "*");
            for (int i = 0; i < MisFicheros.Length; i++)
            {
                String arch = MisFicheros[i].Name;
                String nam = MisFicheros[i].FullName.Replace(Server.MapPath(""), "~");

                if (arch.Contains(fotoA))
                {
                    ex = true;
                    return ex;
                }

            }
        }



        return ex;

    }
}

