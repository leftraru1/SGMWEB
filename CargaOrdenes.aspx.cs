using System;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Data.OracleClient;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Security.Permissions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CargaOrdenes : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
        Procedimientos PRO = new Procedimientos();
    public DataTable dt;
    public DataTable detalle;
    public int cargados;
    public int errores;
    public int duplicados;
    public int reg;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            
            try
            {
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                lb_rut_empresa.Text = PRO.recSession(rutaXml, "RUT_EMPRESA");
                lb_id_usuario.Text = PRO.recSession(rutaXml, "ID_USUARIO");
                lb_id_perfil.Text = PRO.recSession(rutaXml, "ID_PERFIL");
                
                actualizar_pantalla("inicializar");
                fechaPro.Text = DateTime.Now.ToString("dd-MM-yyyy");
                carga_contratista("0");
                cargaProceso();
                
            }
            catch (Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }

        }
        
    }

    //carga combo box de tipo proceso.
    public void cargaProceso()
    {

        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_PROCESO.CARGA_TP", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "PROCESO");
        objConexion.Close();

        int i = 1;
        ddTproceso.Items.Clear();

        foreach (DataRow row in objDS.Tables["PROCESO"].Rows)
        {

            ddTproceso.Items.Add(row[1].ToString());
            ddTproceso.Items[i - 1].Value = row[0].ToString();
            i = i + 1;

        }

    }

    //valida si la orden ya existe en el sistema.
    public Boolean valida_orden(String id)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_INTEGRACION.VALIDA_ORDEN", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_ORDEN", OracleType.NVarChar, ParameterDirection.Input, id);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "VALIDA");
        objConexion.Close();

        if (objDS.Tables["VALIDA"].Rows.Count == 0)
        {
            // nomArch.Text = objDS.Tables["VALIDA"].Rows.Count.ToString();
            return false;
        }
        else
        {
            return true;
        }
    }


    //Verifica a nivel de bbdd si existen registros con el nombre de archivo a cargar.
    public Boolean existe_archivo(String filename)
    {
        try
        {
            return false;
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();

            objConexion.Open();
            objComando = new OracleDataAdapter("PK_PROCESO.EXISTE_ARCHIVO", objConexion);
            objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

            PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
            PRO.agrega_parametro_sp(objComando, "i_archivo", OracleType.NVarChar, ParameterDirection.Input, filename);

            objComando.SelectCommand.ExecuteNonQuery();
            objComando.Fill(objDS, "EXISTE");
            objConexion.Close();

            if (objDS.Tables["EXISTE"].Rows[0][0].ToString().Equals("0"))
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
            lb_mensaje_error.Text = "Se ha producido el siguiente error: " + ex.Message.ToString();
            return true;
        }
    }

    //Capturamos los datos de un excel.
    public DataTable import_excel(String path)
    {
         using (OleDbConnection conn = new OleDbConnection())
        {
            DataTable import_table = new DataTable();
            conn.ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path + ";" + "Extended Properties='Excel 12.0 Macro;HDR=YES;IMEX=1;MAXSCANROWS=0'";
            conn.Open();
            DataTable dtSheets = conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables,null);
            String sheet = dtSheets.Rows[0]["TABLE_NAME"].ToString();
            sheet = sheet.Replace("'", "");

            using (OleDbCommand comm = new OleDbCommand())
            {
                comm.CommandText = "Select * from [" + sheet + "]";
                comm.Connection = conn;
                using (OleDbDataAdapter da = new OleDbDataAdapter())
                {
                    da.SelectCommand = comm;
                    da.Fill(import_table);
                    return import_table;
                }
            }
        }
    }


    public Boolean validar_registro(String id_servicio, String numero_orden,String nombre_cliente,String direccion_cliente,
        String localidad, String ruta, String numero_med,String diametro_med)
    {
        lb_causa_error.Text = "No se pudo cargar orden debido a:";
        String respuesta = "";
        int pendientes = 0;

        //valida instalacion o id_servicio (lo mismo).
        if (!valida_num(id_servicio))
        {
            if(pendientes > 0) respuesta = ", la instalación no es válida";
            else respuesta = " la instalación no es válida";

            lb_causa_error.Text = lb_causa_error.Text + respuesta;
            pendientes++;
        }

        //valida numero de orden.
        if (!valida_num(numero_orden))
        {
            if (pendientes > 0) respuesta = ", el número de orden no es válido";
            else respuesta = " el número de orden no es válido";

            lb_causa_error.Text = lb_causa_error.Text + respuesta;
            pendientes++;
        }
             
        //valida nombre cliente.
        if (nombre_cliente.Length == 0)
        {
            if (pendientes > 0) respuesta = ", Falta el nombre del cliente";
            else respuesta = " Falta el nombre del cliente";

            lb_causa_error.Text = lb_causa_error.Text + respuesta;
            pendientes++;
        }

        //valida direccion cliente.
        if (direccion_cliente.Length == 0)
        {
            if (pendientes > 0) respuesta = ", Falta la direccion del cliente";
            else respuesta = " Falta la direccion del cliente";

            lb_causa_error.Text = lb_causa_error.Text + respuesta;
            pendientes++;
        }
                

        //valida ruta.
        if (!valida_num(ruta))
        {
            if (pendientes > 0) respuesta = ", la ruta no es válida";
            else respuesta = " la ruta no es válida";
            lb_causa_error.Text = lb_causa_error.Text + respuesta;
            pendientes++;
        }

        //número medidor.
        if (!valida_num(numero_med))
        {
            if (pendientes > 0) respuesta = ", el número de medidor no es válido";
            else respuesta = " el número de medidor no es válido";
            lb_causa_error.Text = lb_causa_error.Text + respuesta;
            pendientes++;
        }

       
        //diámetro medidor.
        if (!valida_diametro(diametro_med))
        {
            if (pendientes > 0) respuesta = ", el diámetro de medidor no es válido";
            else respuesta = " el diámetro de medidor no es válido";
            lb_causa_error.Text = lb_causa_error.Text + respuesta;
            pendientes++;
        }
             
        //hay cosas pendientes? pendientes > 0 indica que quedan pendientes
        if (pendientes > 0) return false;
        else return true;
    }

    //valida que la fecha y hora sean correctas.
    public Boolean valida_fecha_inicio(string fecha, string hora)
    {
        try
        {
            DateTime dt1; //validar que sean fechas dd/MM/yyyy.
            if (!DateTime.TryParse(fecha, new System.Globalization.CultureInfo("en-GB"), System.Globalization.DateTimeStyles.None, out dt1)) return false;

            return true;
            //String[] mi_hora = hora.Split(':');

            //if (int.Parse(mi_hora[0]) >= 0 && int.Parse(mi_hora[1]) >= 0 && int.Parse(mi_hora[2]) >= 0)
            //{
            //    return true;
            //}
            //else return false;

        }
        catch (Exception ex)
        {
            return false;
        }
    }

    //valida que la ruta sea numero.
    public Boolean valida_num(string valor)
    {
        try
        {
            if (!valor.Equals("") && long.Parse(valor) > 0) return true;
            else return false;
        }
        catch (Exception ex)
        {
            return false;
        }
    }

   
    //valida si la localidad existe.
    public String get_cod_localidad(string localidad)
    {
        try
        {
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();

            objConexion.Open();
            objComando = new OracleDataAdapter("SELECT COD_LOCALIDAD FROM LOCALIDAD WHERE UPPER(NOMBRE) = UPPER('" + localidad + "')", objConexion);
            objComando.SelectCommand.CommandType = CommandType.Text;

            objComando.SelectCommand.ExecuteNonQuery();
            objComando.Fill(objDS, "LOCALIDAD");
            objConexion.Close();

            foreach (DataRow row in objDS.Tables["LOCALIDAD"].Rows)
            {
                return row[0].ToString();
            }

            return "0";
        }
        catch (Exception ex)
        {
            return "0";
        }
    }


    
    //valida si el diametro existe
    public Boolean valida_diametro(string diametro)
    {
        try
        {
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();

            objConexion.Open();
            objComando = new OracleDataAdapter("SELECT D.DIAMETRO FROM DIAMETRO_MEDIDOR D WHERE D.DIAMETRO = TO_NUMBER(" + diametro + ")", objConexion);
            objComando.SelectCommand.CommandType = CommandType.Text;

            objComando.SelectCommand.ExecuteNonQuery();
            objComando.Fill(objDS, "DIAMETRO");
            objConexion.Close();

            foreach (DataRow row in objDS.Tables["DIAMETRO"].Rows)
            {
                
                    return true;
               
            }

            return false;
        }
        catch (Exception ex)
        {
            return false;
        }
    }

       
    //CARGAMOS ARCHIVO DE TIPO EXCEL EN SERVIDOR DE SISTEMA.
    public void  cargar_excel(String filename)
    {
                
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter ComandoDA;

        dt = new DataTable();
        dt.Columns.Add(new DataColumn("NOMBRE_ARCHIVO", typeof(string)));
        dt.Columns.Add(new DataColumn("DUPLICADOS", typeof(string)));
        dt.Columns.Add(new DataColumn("ERRORES", typeof(string)));
        dt.Columns.Add(new DataColumn("CARGADOS", typeof(string)));
        dt.Columns.Add(new DataColumn("TOTAL", typeof(string)));
        DataRow RD;

        detalle = new DataTable();
        detalle.Columns.Add(new DataColumn("#", typeof(string)));
        detalle.Columns.Add(new DataColumn("NUMERO_CLIENTE", typeof(string)));
        detalle.Columns.Add(new DataColumn("MENSAJE_ERROR", typeof(string)));
        DataRow det;
               
        String path = Server.MapPath("./EXCEL/" + filename);
        
        DataTable datos = import_excel(path);

        if (datos.Rows.Count == 0)
        {
            String mensaje = "El formato del archivo excel no se puede leer!, abra, guarde el archivo e intente nuevamente.";
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + mensaje + "');", true);
           
            //Response.Write("<script>");
            //Response.Write("alert('El formato del archivo excel no se puede leer!, abra, guarde el archivo e intente nuevamente.');");
            //Response.Write("</script>");
            lb_mensaje_error.Text = "El formato del archivo excel no se puede leer!";            
        }

        int contador, duplicados, errores, cargados;
        int vacios;

        vacios = 0;
        contador = 0;
        errores = 0;
        duplicados = 0;
        cargados = 0;

        //campos a validar. 
        String orden, id_servicio, nombre, sector, zona, correlativo, direccion, direccion_ad, localidad, serie_med, agno_med, diametro, modelo;
        String fecha_ul_lec, ul_lec, clave_lec, causa, tarifa, observacion_in, ruta_lectura, cod_localidad, fecha_orden;
              

        foreach(DataRow row in datos.Rows)
        {
            contador++;
            orden = row[0].ToString();
            id_servicio = row[1].ToString();

            //orden ficticia...
            if (orden == "") orden = "999" + id_servicio;

            nombre = row[2].ToString();
            sector = row[3].ToString();
            zona = row[4].ToString();
            correlativo = row[5].ToString();
            direccion = row[6].ToString();
            direccion_ad = (row[7].ToString() + " " + row[9].ToString() + " " + row[10].ToString() + " " + row[11].ToString() + " " + row[12].ToString());
            localidad = row[8].ToString();
            serie_med = row[13].ToString();
            agno_med = row[14].ToString();
            diametro = row[15].ToString();
            modelo = row[16].ToString();
            fecha_ul_lec = row[17].ToString();
            ul_lec = row[18].ToString();
            clave_lec = row[19].ToString();
            causa = row[20].ToString();
            tarifa = row[24].ToString();
            observacion_in = row[26].ToString();
            ruta_lectura = sector + zona + correlativo;
            fecha_orden = row[22].ToString();
            cod_localidad = get_cod_localidad(localidad);

            if (cod_localidad == "0")
            {
                //error de registro según campos de entrada.
                errores++;
                det = detalle.NewRow();
                det["#"] = errores;
                det["NUMERO_CLIENTE"] = id_servicio;
                det["MENSAJE_ERROR"] = "(fila " + (contador + 1) + ") LOCALIDAD " + localidad + " NO EXISTE EN SISTEMA";
                detalle.Rows.Add(det);
                continue;
            }
           
            if(!validar_registro(id_servicio,orden,nombre,direccion,localidad,ruta_lectura,serie_med,diametro))
            {
                //error de registro según campos de entrada.
                errores++;
                det = detalle.NewRow();
                det["#"] = errores;
                det["NUMERO_CLIENTE"] = id_servicio;
                det["MENSAJE_ERROR"] = "(fila " + (contador + 1) + ") " + lb_causa_error.Text;
                detalle.Rows.Add(det);
                continue;
            }

            //validamos que no esté en proceso el id_Servicio (duplicidad).
            if (valida_orden(orden))
            {
                duplicados++;
                //duplicado...
                det = detalle.NewRow();
                det["#"] = duplicados;
                det["NUMERO_CLIENTE"] = id_servicio;
                det["MENSAJE_ERROR"] = "ORDEN SE ENCUENTRA EN PROCESO O YA HA SIDO CERRADA DENTRO DEL ÚLTIMO MES, FAVOR VERIFICAR! " + "(fila " + (contador + 1) + ")";
                detalle.Rows.Add(det);
                continue;
            }

            

            try
            {
            
                
                objConexion = new OracleConnection(conexion_cliente_oracle);                
                objConexion.Open();
                ComandoDA = new OracleDataAdapter("PK_INTEGRACION.INTEGRA_ARCHIVO_NEW", objConexion);
                ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

                PRO.agrega_parametro_sp(ComandoDA, "i_ORDEN", OracleType.NVarChar, ParameterDirection.Input, orden);
                PRO.agrega_parametro_sp(ComandoDA, "i_FECHA_ORDEN", OracleType.NVarChar, ParameterDirection.Input, fecha_orden);
                PRO.agrega_parametro_sp(ComandoDA, "i_SERVICIO", OracleType.NVarChar, ParameterDirection.Input, id_servicio);
                PRO.agrega_parametro_sp(ComandoDA, "i_RUTA", OracleType.NVarChar, ParameterDirection.Input, ruta_lectura);
                PRO.agrega_parametro_sp(ComandoDA, "i_CAUSA", OracleType.NVarChar, ParameterDirection.Input, causa);
                PRO.agrega_parametro_sp(ComandoDA, "i_DIAMETRO_EF", OracleType.NVarChar, ParameterDirection.Input, "0");
                PRO.agrega_parametro_sp(ComandoDA, "i_SUSTITUCION", OracleType.NVarChar, ParameterDirection.Input, "CONTR");
                PRO.agrega_parametro_sp(ComandoDA, "i_COD_CONTRATISTA", OracleType.NVarChar, ParameterDirection.Input, ddContratista.SelectedValue);
                PRO.agrega_parametro_sp(ComandoDA, "i_ULTIMA_LE", OracleType.NVarChar, ParameterDirection.Input, ul_lec);
                PRO.agrega_parametro_sp(ComandoDA, "i_FECHA_ULF", OracleType.NVarChar, ParameterDirection.Input, fecha_ul_lec);
                PRO.agrega_parametro_sp(ComandoDA, "i_PROMEDIO", OracleType.NVarChar, ParameterDirection.Input, "0");
                PRO.agrega_parametro_sp(ComandoDA, "i_CLAVE_LECTURA", OracleType.NVarChar, ParameterDirection.Input, clave_lec);
                PRO.agrega_parametro_sp(ComandoDA, "i_GESTION_CORTE", OracleType.NVarChar, ParameterDirection.Input, "");
                PRO.agrega_parametro_sp(ComandoDA, "i_CONSUMO_DES", OracleType.NVarChar, ParameterDirection.Input, "");
                PRO.agrega_parametro_sp(ComandoDA, "i_MARCA_DIAMETRO", OracleType.NVarChar, ParameterDirection.Input, "D" + diametro + "/" + modelo + "/" + agno_med);
                PRO.agrega_parametro_sp(ComandoDA, "i_SERIE", OracleType.NVarChar, ParameterDirection.Input, serie_med);
                PRO.agrega_parametro_sp(ComandoDA, "i_DIAMETRO", OracleType.NVarChar, ParameterDirection.Input, diametro);
                PRO.agrega_parametro_sp(ComandoDA, "i_TIPO_SERVICIO", OracleType.NVarChar, ParameterDirection.Input, "0002");
                PRO.agrega_parametro_sp(ComandoDA, "i_TIPO_INSTALACION", OracleType.NVarChar, ParameterDirection.Input, "4");
                PRO.agrega_parametro_sp(ComandoDA, "i_CLIENTE", OracleType.NVarChar, ParameterDirection.Input, nombre);
                PRO.agrega_parametro_sp(ComandoDA, "i_DIRECCION", OracleType.NVarChar, ParameterDirection.Input, direccion + direccion_ad);
                PRO.agrega_parametro_sp(ComandoDA, "i_VALOR_MP", OracleType.NVarChar, ParameterDirection.Input, "0");
                PRO.agrega_parametro_sp(ComandoDA, "i_FECHA_INSTALACION", OracleType.NVarChar, ParameterDirection.Input, fecha_orden);
                PRO.agrega_parametro_sp(ComandoDA, "i_OBSERVACION", OracleType.NVarChar, ParameterDirection.Input, observacion_in);
                PRO.agrega_parametro_sp(ComandoDA, "i_LOCALIDAD", OracleType.NVarChar, ParameterDirection.Input, localidad);
                //SE INSERTAN DOS CAMPOS MÁS: COD LOCALIDAD Y RUT EMPRESA, EL CUAL NO ESTÁ EN ARCHIVO PROPIAMENTE TAL.
                PRO.agrega_parametro_sp(ComandoDA, "i_CODLOCALIDAD", OracleType.NVarChar, ParameterDirection.Input, cod_localidad);
                PRO.agrega_parametro_sp(ComandoDA, "i_RUTEMPRESA", OracleType.NVarChar, ParameterDirection.Input, lb_rut_empresa.Text);

                ComandoDA.SelectCommand.ExecuteNonQuery();
                objConexion.Close();
                objConexion.Dispose();
                cargados++;

                } catch (Exception ex)
                {
                   objConexion.Close();
                   objConexion.Dispose();
                   //error al intentar cargar cliente.                    
                   errores++;
                   det = detalle.NewRow();
                   det["#"] = errores;
                   det["NUMERO_CLIENTE"] = id_servicio;
                   det["MENSAJE_ERROR"] = "ERROR:" + ex.Message + " (fila " + (contador+1) + ")";
                   detalle.Rows.Add(det);
                   continue;    
                }

            
          } //fin recorrido.

        //registro de resultados.
        RD = dt.NewRow();
        RD["NOMBRE_ARCHIVO"] = fuArchivo.PostedFile.FileName;
        RD["DUPLICADOS"] = duplicados;
        RD["ERRORES"] = errores;
        RD["CARGADOS"] = cargados;
        RD["TOTAL"] = contador;
        dt.Rows.Add(RD);

        //llenado de grilla de resultados.
        DataView MydataViewvsita = new DataView();
        MydataViewvsita = new DataView(dt);
        GrillaResultados.DataSource = MydataViewvsita;
        GrillaResultados.DataBind();

        //llenado de grilla de detalle.
        MydataViewvsita = new DataView();
        MydataViewvsita = new DataView(detalle);
        GrillaDetalle.DataSource = MydataViewvsita;
        GrillaDetalle.DataBind();

        //lógica para mostrar icono de éxito-warning-error.
        if (cargados > 0 && cargados == contador)
        {
            img_ok.Visible = true;
            img_parcial.Visible = false;
            img_error.Visible = false;
        } else if(cargados > 0 && cargados < contador)
        {
            img_ok.Visible = false;
            img_parcial.Visible = true;
            img_error.Visible = false;
        } else
        {
            img_ok.Visible = false;
            img_parcial.Visible = false;
            img_error.Visible = true;
            descarta_proceso(filename);
        }

        set_total_proceso(filename,cargados.ToString());
        lb_resumen.Text = "RESUMEN DUPLICADOS/ERRORES (" + (duplicados + errores) + ")";
     
    }

    //CARGAMOS LOS CONTRATISTAS.
    public void carga_contratista(String contratista)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_VISOR_HISTORICOS.CARGA_CONTRATISTA", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_id_contratista", OracleType.Number, ParameterDirection.Input, contratista);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "CONTRATISTA");
        objConexion.Close();

        int i = 0;
        ddContratista.Items.Clear();

        foreach (DataRow row in objDS.Tables["CONTRATISTA"].Rows)
        {
            ddContratista.Items.Add(row[1].ToString());
            ddContratista.Items[i].Value = row[0].ToString();
            i = i + 1;
        }
    }

     //Maneja el comportamiento de la interfaz según acción ejecutada.
    public void actualizar_pantalla(String opcion)
    {
        switch (opcion)
        {
            case "inicializar":
                btn_cargar.Visible = true;
                btn_otro.Visible = false;
                btn_descartar.Visible = false;
                rbCargados.Visible = false;
                lb_mensaje.Text = "";
                lb_mensaje_error.Text = "";
                img_ok.Visible = false;
                img_error.Visible = false;
                img_parcial.Visible = false;
                panel.Visible = false;

                break;
            case "cargar":
                btn_cargar.Visible = false;
                btn_otro.Visible = true;
                btn_descartar.Visible = true;
                rbCargados.SelectedIndex = 0;
                rbCargados.Visible = true;
                lb_mensaje.Text = "";
                lb_mensaje_error.Text = "";
                panel.Visible = true;
                lb_resultados.Visible = true;
                lb_resumen.Visible = false;
                GrillaResultados.Visible = true;
                GrillaDetalle.Visible = false;

                break;            
            case "ver_detalle":
                lb_resultados.Visible = false;
                lb_resumen.Visible = true;
                GrillaResultados.Visible = false;
                GrillaDetalle.Visible = true;
                break;
            case "ver_resumen":
                lb_resultados.Visible = true;
                lb_resumen.Visible = false;
                GrillaResultados.Visible = true;
                GrillaDetalle.Visible = false;
                break;
            default:
                break;
        }
    }
   
    //cargamos el archivo de cartera de clientes al servidor (debe cumplir con todas las condiciones).
    protected void Button2_Click(object sender, EventArgs e)
    {
        //si hay archivo seleccionado
        String ruta = "";
        String ext = "";
        try
        {
        if(fuArchivo.HasFile) //hay un archivo seleccionado?
        {
            ruta = Server.MapPath("./EXCEL/" + fuArchivo.PostedFile.FileName);
            ext = Path.GetExtension(fuArchivo.PostedFile.FileName).ToString();
            if(ext.ToUpper() == ".XLSX" || ext.ToUpper() == ".XLS") //viene con formato correcto? (excel).
            {
                
                if(!File.Exists(ruta)) //No existe documento con mismo nombre?
                {
                    
                    if(!existe_archivo(fuArchivo.FileName)) //No existe registro asociado al nombre del archivo en bbdd?
                    {
                        //levanta archivo al servidor
                        fuArchivo.SaveAs(ruta);

                        Stopwatch temporizador = Stopwatch.StartNew();

                        reg = totalReg(ruta);

                        if (genera_proceso(fuArchivo.FileName,fechaPro.Text,reg.ToString())) //valida que se cree el archivo correctamente.
                        {
                            //carga de acuerdo al tipo de archivo (extensión).
                            cargar_excel(fuArchivo.FileName);
                        }
                        else
                        {
                            lb_mensaje.Text = "";
                            lb_mensaje_error.Text = "No se ha podido generar el proceso de carga, volver a intentar o notificarselo a informática";

                            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + lb_mensaje_error.Text + "');", true);
           
                        }
                        

                        temporizador.Stop();
                        actualizar_pantalla("cargar");
                        String horas = "00", minutos = "00", segundos = "00";

                        horas = temporizador.Elapsed.Hours.ToString();
                        minutos = temporizador.Elapsed.Minutes.ToString();
                        segundos = temporizador.Elapsed.Seconds.ToString();

                        if (horas.Length == 1) horas = "0" + horas;
                        if (minutos.Length == 1) minutos = "0" + minutos;
                        if (segundos.Length == 1) segundos = "0" + segundos;

                        if (!lb_mensaje_error.Text.Contains("No"))
                        {
                            lb_mensaje_error.Text = "";
                            lb_mensaje.Text = "Carga de archivo finalizada!, tiempo transcurrido: " + horas + ":" + minutos + ":" + segundos;
                            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_ok('" + lb_mensaje.Text + "');", true);
           
                        }
                                           
                    } else //Si existe en bbdd.
                    {
                        lb_mensaje.Text = "";
                             lb_mensaje_error.Text = "Ya existen registros asociados al mismo nombre de archivo!";
                             ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + lb_mensaje_error.Text + "');", true);
           
                    }
                   
                } else  //Si existe ya documento en servidor.
                {
                    lb_mensaje.Text = "";
                    lb_mensaje_error.Text = "Ya existe un archivo con el mismo nombre!";
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + lb_mensaje_error.Text + "');", true);
           
                }

            } else //no viene con formato correcto.
            {
                lb_mensaje.Text = "";
                lb_mensaje_error.Text = "No se permite el formato del archivo (sólo .xlsx/.xls)";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + lb_mensaje_error.Text + "');", true);
           
            }
        } else //No hay ningún archivo seleccionado
        {
            lb_mensaje.Text = "";
            lb_mensaje_error.Text = "No ha seleccionado ningún archivo, favor seleccione!";
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + lb_mensaje_error.Text + "');", true);
           
        }

        } catch (Exception ex)
        {
            lb_mensaje.Text = "";
            lb_mensaje_error.Text = "Se ha producido el siguiente error: " + ex.Message.ToString();
            //elimina archivo del servidor
            delete_proceso();
            //File.Delete(ruta);
        }
    }

    public Boolean delete_proceso()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();
        try
        {           

            objConexion.Open();
            objComando = new OracleDataAdapter("DELETE PROCESO WHERE ID_PROCESO = SELECT MAX(ID_PROCESO) FROM PROCESO", objConexion);
            objComando.SelectCommand.CommandType = CommandType.TableDirect;

            objComando.SelectCommand.ExecuteNonQuery();           
            objConexion.Close();
            return true;
        }
        catch (Exception ex)
        {
            objConexion.Close();
            return false;
        }
    }

    //retorna número de filas de un archivo.
    public int totalReg(String ruta)
    {
        StreamReader sr = new StreamReader(ruta);
        String line;
        int total = 0;

        do
        {
            line = sr.ReadLine();

            if ((line == null) || (line == ""))
            {
                continue;
            }
            else
            {
                total = total + 1;
            }


        } while (!(line == null));

        return total; 
    }
       

    public Boolean genera_proceso(String archivo,String fecha,String registros)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter ComandoDA;

        String ano = DateTime.Now.Year.ToString(); //año de hoy.
        String mes = DateTime.Now.Month.ToString(); //mes de hoy.
        String dia = DateTime.Now.Day.ToString(); //dia de hoy.

        try
        {            

            objConexion = new OracleConnection(conexion_cliente_oracle);
            objConexion.Open();
            ComandoDA = new OracleDataAdapter("PK_PROCESO.NUEVO_PROCESO", objConexion);
            ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;
            
            PRO.agrega_parametro_sp(ComandoDA, "i_grupopro", OracleType.NVarChar, ParameterDirection.Input, get_grupo());
            PRO.agrega_parametro_sp(ComandoDA, "i_idtp", OracleType.Int32, ParameterDirection.Input, ddTproceso.SelectedValue);
            PRO.agrega_parametro_sp(ComandoDA, "i_rutempresa", OracleType.NVarChar, ParameterDirection.Input, lb_rut_empresa.Text);
            PRO.agrega_parametro_sp(ComandoDA, "i_anopro", OracleType.Int32, ParameterDirection.Input, ano);
            PRO.agrega_parametro_sp(ComandoDA, "i_mespro", OracleType.Int32, ParameterDirection.Input, mes); //nuArchivo x nuPeriodo.
            PRO.agrega_parametro_sp(ComandoDA, "i_diapro", OracleType.Int32, ParameterDirection.Input, dia);
            PRO.agrega_parametro_sp(ComandoDA, "i_cantidadre", OracleType.Int32, ParameterDirection.Input, registros);
            PRO.agrega_parametro_sp(ComandoDA, "i_fechapro", OracleType.NVarChar, ParameterDirection.Input, fecha);
            PRO.agrega_parametro_sp(ComandoDA, "i_estado", OracleType.Int32, ParameterDirection.Input, "0");
            PRO.agrega_parametro_sp(ComandoDA, "i_nombrearch", OracleType.NVarChar, ParameterDirection.Input, archivo);
            PRO.agrega_parametro_sp(ComandoDA, "i_fechain", OracleType.NVarChar, ParameterDirection.Input, fecha);
            PRO.agrega_parametro_sp(ComandoDA, "i_fechaci", OracleType.NVarChar, ParameterDirection.Input, "");


            ComandoDA.SelectCommand.ExecuteNonQuery();
            objConexion.Close();
            objConexion.Dispose();
            return true;

        }
        catch (Exception ex)
        {
            objConexion.Close();
            objConexion.Dispose();
            return false;
        }

    }

    public string get_grupo()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        try
        {            
            objConexion.Open();
            objComando = new OracleDataAdapter("PK_PROCESO.GET_GRUPO", objConexion);
            objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

            PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
            objComando.SelectCommand.ExecuteNonQuery();
            objComando.Fill(objDS, "GRUPO");
            objConexion.Close();

            string fecha, num;

            fecha = objDS.Tables["GRUPO"].Rows[0][0].ToString();
            num = objDS.Tables["GRUPO"].Rows[0][1].ToString();

            if (num.Length == 1) num = "0" + num;

            return (fecha + num);
           
        }
        catch (Exception ex)
        {
            objConexion.Close();
            lb_mensaje.Text = "";
            lb_mensaje_error.Text = "Error al obtener el grupo de proceso: " + ex.Message.ToString();
            return "0";
        }
    }

    public Boolean descarta_proceso(String filename)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter ComandoDA;

        try
        {
            objConexion = new OracleConnection(conexion_cliente_oracle);
            objConexion.Open();
            ComandoDA = new OracleDataAdapter("PK_PROCESO.DESCARTA_PROCESO", objConexion);
            ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

            PRO.agrega_parametro_sp(ComandoDA, "i_archivo", OracleType.NVarChar, ParameterDirection.Input, filename);
            
            ComandoDA.SelectCommand.ExecuteNonQuery();
            objConexion.Close();
            objConexion.Dispose();
            File.Delete(Server.MapPath("~/EXCEL/") + filename);
            return true;

        }
        catch (Exception ex)
        {
            objConexion.Close();
            objConexion.Dispose();
            return false;
        }
    }

    public Boolean set_total_proceso(String filename,string cargados)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter ComandoDA;

        try
        {
            objConexion = new OracleConnection(conexion_cliente_oracle);
            objConexion.Open();
            ComandoDA = new OracleDataAdapter("PK_CARGA.UPDATE_PROCESO", objConexion);
            ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

            PRO.agrega_parametro_sp(ComandoDA, "i_archivo", OracleType.NVarChar, ParameterDirection.Input, filename);
            PRO.agrega_parametro_sp(ComandoDA, "i_total", OracleType.Number, ParameterDirection.Input, cargados);


            ComandoDA.SelectCommand.ExecuteNonQuery();
            objConexion.Close();
            objConexion.Dispose();
            return true;

        }
        catch (Exception ex)
        {
            objConexion.Close();
            objConexion.Dispose();
            return false;
        }
    }

    protected void gvRecepcion_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

    }
    protected void gvRecepcion_RowCommand(object sender, GridViewCommandEventArgs e)
    {

    }


    protected void btn_otro_Click(object sender, EventArgs e)
    {
        actualizar_pantalla("inicializar");
    }
    protected void cb_region_SelectedIndexChanged(object sender, EventArgs e)
    {
        //Response.Write("<script>");
        //Response.Write("alert('" + cb_region.SelectedItem.Value.ToString() + " ');");
        //Response.Write("</script>");
    }
    protected void rbCargados_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rbCargados.SelectedIndex == 0)
        {
            actualizar_pantalla("ver_resumen");
        }
        else if (rbCargados.SelectedIndex == 1)
        {
            actualizar_pantalla("ver_detalle");
        }
      
    }

    public String limpiar_cadena(String cadena)
    {
        //eliminamos comilla simple.
        cadena = cadena.Replace("'", "");
        //eliminamos tilde hacia derecha.
        cadena = cadena.Replace("´", "");
        //eliminamos tilde hacia izquierda.
        cadena = cadena.Replace("`", "");
        //eliminamos parentesis izquierdo.
        cadena = cadena.Replace("(", "");
        //eliminamos parentesis derecho.
        cadena = cadena.Replace(")", "");
        //eliminamos comilla doble.
        cadena = cadena.Replace('"',' ');
        //eliminamos caracter especial pregunta.
        cadena = cadena.Replace("�", "");
        //eliminamos punto arriba.
        cadena = cadena.Replace("°", "");
        return cadena;
    }
    protected void btn_descartar_Click(object sender, EventArgs e)
    {
        String mi_archivo = GrillaResultados.Rows[0].Cells[0].Text;
        if (descarta_proceso(mi_archivo))
        {
            actualizar_pantalla("inicializar");
            lb_mensaje_error.Text = "";
            lb_mensaje.Text = "Se ha descartado el proceso asociado al archivo " + mi_archivo;
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_ok2('" + lb_mensaje.Text + "');", true);
           
        }
        else
        {

            lb_mensaje.Text = "";
            lb_mensaje_error.Text = "No se pudo eliminar proceso recién cargado con nombre " + mi_archivo;
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " mensaje_error('" + lb_mensaje_error.Text + "');", true);
           
        }
        

    }
}