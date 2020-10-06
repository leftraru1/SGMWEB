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

public partial class OrdenesSinNumero : System.Web.UI.Page
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

                //txtDesde.Text = DateTime.Now.AddDays(-30).ToString("dd-MM-yyyy");
                //txtHasta.Text = DateTime.Now.ToString("dd-MM-yyyy");

                carga_regiones();
                carga_zonas(ddRegion.SelectedValue);
                carga_localidades(ddZona.SelectedValue, ddRegion.SelectedValue);
                carga_grilla(ddRegion.SelectedValue,ddZona.SelectedValue,ddLocalidad.SelectedValue,txtServ.Text,txtOrden.Text, lb_id_perfil.Text);

            }
            catch (Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }
        }
    }
   
    protected void gridOrden_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            var colsNoVisible = migrilla.DataKeys[migrilla.SelectedIndex].Values;
            String id_usuario;
                       
            
        }
        catch (Exception ex)
        {

        }

    }

    protected void gridOrden_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            
            if (e.CommandName == "VALIDAR")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = (GridViewRow)migrilla.Rows[index];//migrilla.Rows[index];
                TextBox orden_sap;
               
                orden_sap = (TextBox)row.Cells[0].FindControl("DDORDEN");

                var colsNoVisible = migrilla.DataKeys[index].Values;
                string numero_orden, orden;
                orden = (string)colsNoVisible[0]; //row.Cells[0].Text;
                numero_orden = orden_sap.Text;
                lb_mensaje.Text = "";

                if (numero_orden.Length > 0) //debe tener algún número.
                {
                    if (valida_orden(numero_orden)) //debe ser único el nro orden en proceso e histórico.
                    {
                        actualizar_orden(numero_orden, orden);
                    }
                    else
                    {
                        lb_mensaje.ForeColor = System.Drawing.Color.Red;
                        lb_mensaje.Text = "El número de orden ingresado ya se encuentra en sistema";
                    }
                }
                else
                {
                    lb_mensaje.ForeColor = System.Drawing.Color.Red;
                    lb_mensaje.Text = "Debe ingresar un número válido";
                }

                
                

            }
        }
        catch (Exception ex)
            {
            lb_mensaje.ForeColor = System.Drawing.Color.Red;
            lb_mensaje.Text = "Error: " + ex.Message;
        }
        
        
    }

    public Boolean valida_orden(String orden)
    {
        try
        {
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();
            String SQL = "SELECT NUMERO_ORDEN FROM ORDEN WHERE NUMERO_ORDEN = TO_NUMBER(" + orden + ") ";
            SQL += "UNION ALL SELECT NUMERO_ORDEN FROM ORDEN_HISTORICOS WHERE NUMERO_ORDEN = TO_NUMBER(" + orden + ") ";

            objConexion.Open();
            objComando = new OracleDataAdapter(SQL, objConexion);
            objComando.SelectCommand.CommandType = CommandType.Text;

            objComando.SelectCommand.ExecuteNonQuery();
            objComando.Fill(objDS, "VALIDA");
            objConexion.Close();

            int codigo = 0;
            foreach (DataRow row in objDS.Tables["VALIDA"].Rows)
            {
               return false;
            }

            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
    }

    public Boolean valida_orden_autogenerada(String orden,String servicio)
    {
        try
        {
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();
            String SQL = "SELECT NUMERO_ORDEN FROM ORDEN_AUTOGENERADA WHERE NUEVA_ORDEN = TO_NUMBER(" + orden + ") AND ID_SERVICIO = TO_NUMBER(" + servicio +") ";

            objConexion.Open();
            objComando = new OracleDataAdapter(SQL, objConexion);
            objComando.SelectCommand.CommandType = CommandType.Text;

            objComando.SelectCommand.ExecuteNonQuery();
            objComando.Fill(objDS, "VALIDA");
            objConexion.Close();

            int codigo = 0;
            foreach (DataRow row in objDS.Tables["VALIDA"].Rows)
            {
                return false;
            }

            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
    }

    public void actualizar_orden(String numero_orden, String orden)
    {

        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_ORDEN_PENDIENTE.ACTUALIZAR_ORDEN", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "i_id_orden", OracleType.Number, ParameterDirection.Input, orden);
        PRO.agrega_parametro_sp(objComando, "i_numero_orden", OracleType.Number, ParameterDirection.Input, numero_orden);

        try
        {
            objComando.SelectCommand.ExecuteNonQuery();
            carga_grilla(ddRegion.SelectedValue, ddZona.SelectedValue, ddLocalidad.SelectedValue,
                       txtServ.Text, txtOrden.Text, lb_id_perfil.Text);

            lb_mensaje.ForeColor = System.Drawing.Color.Green;
            lb_mensaje.Text = "Orden " + numero_orden + " ingresada correctamente";
                        
        }
        catch (Exception ex)
        {
            lb_mensaje.ForeColor = System.Drawing.Color.Red;
            lb_mensaje.Text = "Error al intentar actualizar orden " + numero_orden + ": " + ex.Message;

        }
    }

      
    //Cargamos las zonas posibles.
    public void carga_zonas(String id_region)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_ORDEN_PENDIENTE.CARGA_ZONAS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_region", OracleType.Number, ParameterDirection.Input, id_region);


        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "ZONAS");
        objConexion.Close();

        int i = 1;
        ddZona.Items.Clear();
        ddZona.Items.Add("TODAS...");
        ddZona.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["ZONAS"].Rows)
        {

            ddZona.Items.Add(row[0].ToString());
            ddZona.Items[i].Value = row[1].ToString();
            i = i + 1;

        }
    }

    //Cargamos las regiones posibles.
    public void carga_regiones()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_ORDEN_PENDIENTE.CARGA_REGIONES", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "REGIONES");
        objConexion.Close();

        int i = 1;
        ddRegion.Items.Clear();
        ddRegion.Items.Add("TODAS...");
        ddRegion.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["REGIONES"].Rows)
        {

            ddRegion.Items.Add(row[0].ToString());
            ddRegion.Items[i].Value = row[1].ToString();
            i = i + 1;

        }
    }

    //Cargamos las localidades según filtros de zona.
    public void carga_localidades(String id_zona, String id_region)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_ORDEN_PENDIENTE.CARGA_LOCALIDAD", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_zona", OracleType.Number, ParameterDirection.Input, id_zona);
        PRO.agrega_parametro_sp(objComando, "i_region", OracleType.Number, ParameterDirection.Input, id_region);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "LOCALIDADES");
        objConexion.Close();

        int i = 1;
        ddLocalidad.Items.Clear();
        ddLocalidad.Items.Add("TODAS...");
        ddLocalidad.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["LOCALIDADES"].Rows)
        {

            ddLocalidad.Items.Add(row[0].ToString());
            ddLocalidad.Items[i].Value = row[1].ToString();
            i = i + 1;

        }
    }

    //Cargamos las ordenes pendientes que aún no tienen su orden regularizada.
    public void carga_grilla(String region, String zona,String localidad, String servicio,String orden, String perfil)
    {
        
        //validamos que vengan como número la orden y el servicio
        if (servicio.Length == 0) servicio = "0";
        if (orden.Length == 0) orden = "0";

        //desde = desde.Replace("-", "/");
        //hasta = hasta.Replace("-", "/");

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_ORDEN_PENDIENTE.CARGAR_ORDENES", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_region", OracleType.Number, ParameterDirection.Input, region);
        PRO.agrega_parametro_sp(da, "i_zona", OracleType.Number, ParameterDirection.Input, zona);
        PRO.agrega_parametro_sp(da, "i_localidad", OracleType.Number, ParameterDirection.Input, localidad);
        //PRO.agrega_parametro_sp(da, "i_desde", OracleType.NVarChar, ParameterDirection.Input, desde);
        //PRO.agrega_parametro_sp(da, "i_hasta", OracleType.NVarChar, ParameterDirection.Input, hasta);
        PRO.agrega_parametro_sp(da, "i_servicio", OracleType.Number, ParameterDirection.Input, servicio);
        PRO.agrega_parametro_sp(da, "i_orden", OracleType.Number, ParameterDirection.Input, orden);
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
        dt.Columns.Add(new DataColumn("ID_ORDEN", typeof(String)));
        dt.Columns.Add(new DataColumn("ID_SERVICIO", typeof(String)));
        dt.Columns.Add(new DataColumn("NUMERO_ORDEN", typeof(String)));
        dt.Columns.Add(new DataColumn("CAUSA", typeof(String)));
        dt.Columns.Add(new DataColumn("CONTRATISTA", typeof(String)));
        dt.Columns.Add(new DataColumn("LOCALIDAD", typeof(String)));
        dt.Columns.Add(new DataColumn("OPERADOR", typeof(String)));
        dt.Columns.Add(new DataColumn("FECHA_EJECUCION", typeof(String)));

        DataRow dr;

        int total = 0;

        foreach (DataRow drOrdenItem in dtOrdenes.Rows)
        {

            dr = dt.NewRow();
            dr["ID_ORDEN"] = drOrdenItem["ID_ORDEN"].ToString();
            dr["ID_SERVICIO"] = drOrdenItem["ID_SERVICIO"].ToString();
            dr["NUMERO_ORDEN"] = drOrdenItem["NUMERO_ORDEN"].ToString();
            dr["CAUSA"] = drOrdenItem["CAUSA"].ToString();
            dr["CONTRATISTA"] = drOrdenItem["CONTRATISTA"].ToString();
            dr["LOCALIDAD"] = drOrdenItem["LOCALIDAD"].ToString();
            dr["OPERADOR"] = drOrdenItem["OPERADOR"].ToString();
            dr["FECHA_EJECUCION"] = drOrdenItem["FECHA_EJECUCION"].ToString();

            dt.Rows.Add(dr);

            total = total + 1;

        }

        DataView MydataView;
        MydataView = new DataView(dt);
        migrilla.DataSource = MydataView;
        migrilla.DataBind();
        migrilla.Columns[0].Visible = false;

        lb_contador.Text = total + " orden(es) encontrada(s)";

        Button btn_validar;
        TextBox orden_sap;

        
        GridViewRow gvRow;

        //HABILITA/DESHABILITA DESCARGA EXCEL.
        if (total > 0) btn_excel.Enabled = true;
        else btn_excel.Enabled = false;

        for (int i = 0; i < migrilla.Rows.Count; i++)
        {
            gvRow = migrilla.Rows[i];
            String fecha = gvRow.Cells[7].Text;
            btn_validar = ((Button)gvRow.FindControl("AddButton"));
            orden_sap = ((TextBox)gvRow.Cells[0].FindControl("DDORDEN"));

            try
            {
                DateTime mi_fecha = DateTime.Parse(fecha);
                btn_validar.Enabled = true;
                btn_validar.BackColor = System.Drawing.Color.DarkRed;
                orden_sap.Enabled = true;
            }
            catch (Exception ex)
            {
                btn_validar.Enabled = false;
                btn_validar.BackColor = System.Drawing.Color.Gray;
                orden_sap.Enabled = false;
            }
        
        }

    }


    protected void btn_filtrar_Click(object sender, EventArgs e)
    {
        carga_grilla(ddRegion.SelectedValue, ddZona.SelectedValue, ddLocalidad.SelectedValue,
                    txtServ.Text, txtOrden.Text, lb_id_perfil.Text);
    }

    protected void btn_otro_click(object sender, EventArgs e)
    {
        resultados.Visible = false;
    }

    protected void btn_volver_click(object sender, EventArgs e)
    {
        carga_grilla(ddRegion.SelectedValue, ddZona.SelectedValue, ddLocalidad.SelectedValue,
                   txtServ.Text, txtOrden.Text, lb_id_perfil.Text);
        main.Visible = true;
        carga_archivo.Visible = false;
    }

    protected void btn_showhide_click(object sender, EventArgs e)
    {
        if (grid_detalle.Visible) grid_detalle.Visible = false;
        else grid_detalle.Visible = true;
    }

    protected void btn_cargar_click(object sender, EventArgs e)
    {
        //limpiar_pantalla();
        try
        {           
            //obtiene ruta de archivo.
            String ruta = Server.MapPath("./TXT/" + fuArchivo.PostedFile.FileName);
            String ext = Path.GetExtension(fuArchivo.PostedFile.FileName).ToString();
            String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
            String filename = fuArchivo.PostedFile.FileName;            

            if (fuArchivo.HasFile) //tiene cargado un archivo?
            {
                if (ext == ".txt") //es de tipo txt?
                {
                    if (!File.Exists(ruta)) //existe en directorio ./TXT/?
                    {
                        fuArchivo.SaveAs(ruta);
                        integra_archivo(ruta); //agrega ordenes del archivo ingresado.

                    }
                    else
                    {
                        // Archivo ya está cargado en directorio.
                        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('ERROR: El archivo ya existe');", true);
                    }
                }
                else
                {
                    //No se permiten archivos que no sean .txt
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('ERROR: Sólo archivos txt');", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('ERROR: no cargó ningún archivo');", true);
                    

            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('ERROR: Error al intentar integrar archivo, verifique que el formato del documento sea el correcto');", true);

        }
    }

    //integra ordenes al sistema.
    public void integra_archivo(String ruta)
    {
        //contabilidad de ordenes (ingresado - errado - duplicada).
        int ingresados = 0;
        int duplicados = 0;
        int errados = 0;
        String arch = fuArchivo.PostedFile.FileName;

        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("NOMBRE_ARCHIVO", typeof(string)));
        dt.Columns.Add(new DataColumn("DUPLICADOS", typeof(string)));
        dt.Columns.Add(new DataColumn("CARGADOS", typeof(string)));
        dt.Columns.Add(new DataColumn("ERRORES", typeof(string)));
        dt.Columns.Add(new DataColumn("TOTAL", typeof(string)));

        DataRow RD;

        DataTable detalle = new DataTable();
        detalle.Columns.Add(new DataColumn("NRO", typeof(string)));
        detalle.Columns.Add(new DataColumn("NUM_ORDEN", typeof(string)));
        detalle.Columns.Add(new DataColumn("SERVICIO", typeof(string)));
        detalle.Columns.Add(new DataColumn("CLIENTE", typeof(string)));
        detalle.Columns.Add(new DataColumn("MENSAJE_ERROR", typeof(string)));

        String ordenNum = "";
        String serv = "";
        StreamReader sr = new StreamReader(ruta);

        try
        {
            String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
            
            String line; //almacenará una linea del archivo.
            String[] miArray; //captura datos de una linea del archivo.

            do
            {

                line = sr.ReadLine(); //lee linea de archivo.

                if ((line == null) || (line == "")) //si el archivo está vacío corta el ciclo.
                {
                    break;
                }

                line = limpiar(line); //limpia linea de caracteres extraños.

                miArray = line.Split(';'); // almacena cada dato en el array[]

                //validación num orden, servicio y ruta.
                if (miArray[0] == "" || miArray[2] == "")
                {
                    errados += 1;
                    String msg = "Campos vacíos (ORDEN: " + miArray[0] + ", SERVICIO: " + miArray[2] + ")";
                    RD = detalle.NewRow();
                    RD["NRO"] = duplicados + errados;
                    RD["NUM_ORDEN"] = miArray[0];
                    RD["SERVICIO"] = miArray[2];
                    RD["MENSAJE_ERROR"] = "Fila " + (duplicados+errados+ingresados) + ": " +msg;
                    detalle.Rows.Add(RD);                    
                    continue;
                }

                try
                {
                    
                    ordenNum = miArray[0]; //ejemplo: 001003488459
                    serv = miArray[2]; //servicio

                    if (valida_orden(miArray[0])) //valida no existencia.
                    {
                        if(valida_orden_autogenerada(miArray[0],miArray[2])) //valida no existencia
                        {
                            //INSERTA NUEVA INTEGRACIÓN DE REGISTRO.
                            try
                            {
                                OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
                                OracleDataAdapter ComandoDA;
                                objConexion.Open();
                                ComandoDA = new OracleDataAdapter("PK_ORDEN_PENDIENTE.ACTUALIZAR_ORDEN_TXT", objConexion);
                                ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

                                PRO.agrega_parametro_sp(ComandoDA, "i_ORDEN", OracleType.Number, ParameterDirection.Input, miArray[0]);
                                PRO.agrega_parametro_sp(ComandoDA, "i_SERVICIO", OracleType.Number, ParameterDirection.Input, miArray[2]);                           

                                ComandoDA.SelectCommand.ExecuteNonQuery();
                                objConexion.Close();
                                
                                //SI NO EXISTE LA ORDEN AUTOGENERADA NO INSERTÓ NADA.
                                if (valida_orden_autogenerada(miArray[0], miArray[2]))
                                {
                                    //Excepcion de orden pendiente inexistente.
                                    String mensaje = "No se ha encontrado ninguna orden con servicio " + miArray[2] + " que provenga de otra plataforma y que esté pendiente de su nro orden.";
                                    errados += 1;
                                    RD = detalle.NewRow();
                                    RD["NRO"] = duplicados + errados;
                                    RD["NUM_ORDEN"] = miArray[0];
                                    RD["SERVICIO"] = miArray[2];
                                    RD["MENSAJE_ERROR"] = "Fila " + (duplicados + errados + ingresados) + ": " + mensaje;
                                    detalle.Rows.Add(RD);
                                }
                                else
                                {
                                    ingresados += 1;
                                }
                            }
                            catch (Exception ex)
                            {
                                //Excepcion de conexión o ingreso a bbdd del registro.
                                errados += 1;
                                RD = detalle.NewRow();
                                RD["NRO"] = duplicados + errados;
                                RD["NUM_ORDEN"] = miArray[0];
                                RD["SERVICIO"] = miArray[2];
                                RD["MENSAJE_ERROR"] = "Fila " + (duplicados + errados + ingresados) + ": " + ex.Message;
                                detalle.Rows.Add(RD);
                                                      
                            }
                        }
                        else {
                            //Para registros duplicados en sistema.
                        String mensaje = "Nro. de orden duplicada, ya se actualizó anteriormente.";
                        duplicados += 1;
                        RD = detalle.NewRow();
                        RD["NRO"] = duplicados + errados;
                        RD["NUM_ORDEN"] = miArray[0];
                        RD["SERVICIO"] = miArray[2];
                        RD["MENSAJE_ERROR"] = "Fila " + (duplicados + errados + ingresados) + ": " + mensaje;
                        detalle.Rows.Add(RD);
                        }

                    }
                    else
                    {
                        //Para registros duplicados en sistema.
                        String mensaje = "Nro. de orden duplicada, ya se encuentra en sistema.";
                        duplicados += 1;
                        RD = detalle.NewRow();
                        RD["NRO"] = duplicados + errados;
                        RD["NUM_ORDEN"] = miArray[0];
                        RD["SERVICIO"] = miArray[2];
                        RD["MENSAJE_ERROR"] = "Fila " + (duplicados + errados + ingresados) + ": " + mensaje;
                        detalle.Rows.Add(RD);
                      
                    }
                }
                catch (Exception ex)
                {
                    //Para errores de formato, largo de cadenas, otras.
                    errados += 1;
                    RD = detalle.NewRow();
                    RD["NRO"] = duplicados + errados;
                    RD["NUM_ORDEN"] = miArray[0];
                    RD["SERVICIO"] = miArray[2];
                    RD["MENSAJE_ERROR"] = "Fila " + (duplicados + errados + ingresados) + ": " + ex.Message;
                    detalle.Rows.Add(RD);
            
                }


            } while (!(line == null));
                       
            RD = dt.NewRow();
            RD["NOMBRE_ARCHIVO"] = fuArchivo.PostedFile.FileName;
            RD["DUPLICADOS"] = duplicados;//registrosIngresados;
            RD["CARGADOS"] = ingresados;//registrosIngresados;
            RD["ERRORES"] = errados;
            RD["TOTAL"] = ingresados + errados + duplicados;
            dt.Rows.Add(RD);

            //cargar datos a grilla de proceso.
            DataView MydataViewvsita = new DataView();
            MydataViewvsita = new DataView(dt);
            grid_resultado.DataSource = MydataViewvsita;
            grid_resultado.DataBind();
            grid_resultado.Visible = true;

            //cargar datos a grilla de detalle.
            MydataViewvsita = new DataView(detalle);
            grid_detalle.DataSource = MydataViewvsita;
            grid_detalle.DataBind();

            //CONDICIONA LA VISTA DEL BOTÓN QUE PERMITE VER/OCULTAR DETALLE, ESTO SI ESQUE HAY O NO DETALLE DE ERRORES.
            if (grid_detalle.Rows.Count > 0)
            {
                resultados.Visible = true;
                btn_showhide.Visible = true;
                grid_detalle.Visible = false;
            }
            else
            {
                resultados.Visible = false;
                btn_showhide.Visible = false;                
            }

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_ok('CARGA REALIZADA!','SE PROCESARON " + (ingresados + errados + duplicados) + " ORDENES.');", true);
            resultados.Visible = true;
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('ERROR CON EL ARCHIVO: " + ex.Message + "');", true);
           
            sr.Dispose();
            sr.Close(); //CERRAMOS READER.
            File.Delete(ruta); //DESPUES DE CERRAR READER SE PROCEDE A ELIMINAR ARCHIVO DEL DIRECTORIO.

        }
    }


    protected void btn_excel_Click(object sender, EventArgs e)
    {
        generarArchivo(ddRegion.SelectedValue, ddZona.SelectedValue, ddLocalidad.SelectedValue, txtServ.Text, txtOrden.Text, lb_id_perfil.Text);
    }

    public void generarArchivo(String region, String zona, String localidad, String servicio, String orden,String perfil)
    {
        String filename = "./SALIDA/" + "SALIDA_PENDIENTES_" + DateTime.Now.ToString("ddMMyyyy_HHmmss") + ".csv";
        String salida;
        DataRow dr;
        int total = 0;
        
        if (servicio.Contains("-00")) //reemplazamos los -00 que define essbio para sus servicios (en caso de existir el -00 lo eliminamos).
        {
            servicio = servicio.Replace("-00", "");
        }

        if (servicio.Equals(""))
        {
            servicio = "0";
        }

        if (orden.Equals(""))
        {
            orden = "0";
        }

        StreamWriter sr;

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_ORDEN_PENDIENTE.GENERA_SALIDA", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_region", OracleType.Number, ParameterDirection.Input, region);
        PRO.agrega_parametro_sp(da, "i_zona", OracleType.Number, ParameterDirection.Input, zona);
        PRO.agrega_parametro_sp(da, "i_localidad", OracleType.Number, ParameterDirection.Input, localidad);
        PRO.agrega_parametro_sp(da, "i_servicio", OracleType.Number, ParameterDirection.Input, servicio);
        PRO.agrega_parametro_sp(da, "i_orden", OracleType.Number, ParameterDirection.Input, orden);
        PRO.agrega_parametro_sp(da, "i_id_perfil", OracleType.Number, ParameterDirection.Input, perfil);
       
        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("ID_SERVICIO", typeof(String)));
        dt.Columns.Add(new DataColumn("CAUSA_CAMBIO", typeof(String)));
        dt.Columns.Add(new DataColumn("COD_CONTRATISTA", typeof(String)));
        
        try
        {
            CnOra.Open();

            da.Fill(dt);
            grdExcel.DataSource = dt;
            grdExcel.DataBind();
            CnOra.Close();
            CnOra.Dispose();


            sr = new StreamWriter(Server.MapPath(filename));

            salida = "ID_SERVICIO;CAUSA;COD_CONTRATISTA";              

            sr.WriteLine(salida);

            foreach (DataRow drOrdenItem in dt.Rows)
            {
                dr = dt.NewRow();

                dr["ID_SERVICIO"] = drOrdenItem["ID_SERVICIO"].ToString();
                dr["CAUSA"] = drOrdenItem["CAUSA"].ToString();
                dr["COD_CONTRATISTA"] = drOrdenItem["COD_CONTRATISTA"].ToString();
               

                total = total + 1;


                salida = dr["ID_SERVICIO"] + ";" +                       
                        dr["CAUSA"] + ";" +
                        dr["COD_CONTRATISTA"]; 
                    
                sr.WriteLine(salida);

            }

            sr.Close();
            Response.Redirect(filename);
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_ok('EXCEL DESCARGADO!','SE DESCARGARON " + total + " ORDENES.');", true);

        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('ERROR: " + ex.Message + "');", true);
            
        }

    }               


    protected void ddLocalidad_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla(ddRegion.SelectedValue, ddZona.SelectedValue, ddLocalidad.SelectedValue,
                   txtServ.Text, txtOrden.Text, lb_id_perfil.Text);
    }
    protected void ddZona_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_localidades(ddZona.SelectedValue, ddRegion.SelectedValue);
        carga_grilla(ddRegion.SelectedValue, ddZona.SelectedValue, ddLocalidad.SelectedValue,
                   txtServ.Text, txtOrden.Text, lb_id_perfil.Text);
    }
    protected void ddRegion_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_zonas(ddRegion.SelectedValue);
        carga_localidades(ddZona.SelectedValue, ddRegion.SelectedValue);
        carga_grilla(ddRegion.SelectedValue, ddZona.SelectedValue, ddLocalidad.SelectedValue,
                   txtServ.Text, txtOrden.Text, lb_id_perfil.Text);
    }
    protected void txtDesde_TextChanged(object sender, EventArgs e)
    {
        carga_grilla(ddRegion.SelectedValue, ddZona.SelectedValue, ddLocalidad.SelectedValue,
                   txtServ.Text, txtOrden.Text, lb_id_perfil.Text);
    }
    protected void txtHasta_TextChanged(object sender, EventArgs e)
    {
        carga_grilla(ddRegion.SelectedValue, ddZona.SelectedValue, ddLocalidad.SelectedValue,
                   txtServ.Text, txtOrden.Text, lb_id_perfil.Text);
    }
    protected void txtServ_TextChanged(object sender, EventArgs e)
    {
        carga_grilla(ddRegion.SelectedValue, ddZona.SelectedValue, ddLocalidad.SelectedValue,
                   txtServ.Text, txtOrden.Text, lb_id_perfil.Text);
    }
    protected void txtOrden_TextChanged(object sender, EventArgs e)
    {
        carga_grilla(ddRegion.SelectedValue, ddZona.SelectedValue, ddLocalidad.SelectedValue,
                   txtServ.Text, txtOrden.Text, lb_id_perfil.Text);
    }
    protected void btn_carga_Click(object sender, EventArgs e)
    {

        main.Visible = false;
        carga_archivo.Visible = true;
        //resultados.Visible = false;
    }

    //Todo caractér extraño lo reemplaza por uno legible.
    public String limpiar(String linea)
    {
        String sContent;

        String caracter1 = Convert.ToString((char)34);
        String caracter2 = Convert.ToString((char)42);
        String caracter3 = Convert.ToString((char)39);
        String caracter4 = Convert.ToString((char)13);
        String[] caracterRep1 = { caracter1, "" };
        String[] caracterRep2 = { ")", " " };
        String[] caracterRep3 = { "(", " " };
        String[] caracterRep4 = { "ñ", "n" };
        String[] caracterRep5 = { caracter2, "" };
        String[] caracterRep6 = { caracter3, "" };
        String[] caracterRep7 = { ".", "" };
        String[] caracterRep8 = { "¿", "" };
        String[] caracterRep9 = { "?", "" };
        String[] caracterRep10 = { caracter4, "" };
        String[] caracterRep11 = { "»¿", "" };
        String[] caracterRep12 = { "�", "" };


        sContent = linea;

        try
        {
            sContent = limpiaGenerico(sContent, caracterRep1);
            sContent = limpiaGenerico(sContent, caracterRep2);
            sContent = limpiaGenerico(sContent, caracterRep3);
            sContent = limpiaGenerico(sContent, caracterRep4);
            sContent = limpiaGenerico(sContent, caracterRep5);
            sContent = limpiaGenerico(sContent, caracterRep6);
            sContent = limpiaGenerico(sContent, caracterRep7);
            sContent = limpiaGenerico(sContent, caracterRep8);
            sContent = limpiaGenerico(sContent, caracterRep9);
            sContent = limpiaGenerico(sContent, caracterRep10);
            sContent = limpiaGenerico(sContent, caracterRep11);
            sContent = limpiaGenerico(sContent, caracterRep12);
        }
        catch (Exception ex)
        { }

        return sContent;


    }

    //limpia contenido o linea de texto según caracter de entrada a reemplazar.
    public String limpiaGenerico(String content, String[] caracter)
    {

        StreamWriter oSW;
        String Linea;
        String retorno;


        if (content.Contains(caracter[0]) == true)
        {
            content = content.Replace(caracter[0], caracter[1]);
        }

        return content;

        ///''''''''''''''''''''''''''''''''''''''''''''''''''

    }

}