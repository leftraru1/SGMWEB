﻿using System;
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

public partial class RecepcionLecturas_new : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();
    public String rutaGlobal;
    public DataTable dt;
    public DataTable detalle;
    public String valor_duplicados;
    public String valor_error;
    public StreamReader sr;

    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            
            try
            {
                
                txt_resultados.Text = "";
                btn_mostrar_detalle.Visible = false;
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                PRO.recSession(rutaXml, "RUT_EMPRESA");

                cargarPeriodo();
                cargaProceso();
                carga_contratista("0");

                
               
                grupo_proceso.Text = get_grupoproceso();
 
                String[] filePaths = Directory.GetFiles(Server.MapPath("./TXT/"), "*.txt");
                int cantidad = filePaths.Length;

                if (cantidad < 10)
                {
                    nuArchivo.Text = "0" + (cantidad + 1).ToString();
                }
                else
                {
                    nuArchivo.Text = (cantidad + 1).ToString();
                }

                fechaPro.Text = DateTime.Now.ToString("dd-MM-yyyy");

                //nuArchivo.Visible = false;

            }
            catch (Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }
        }
        

    }

    public String get_grupoproceso()
    {
        // String tp = ddTproceso.SelectedValue; //tipo proceso
        String ano = DateTime.Now.Year.ToString(); //año de hoy.
        String mes = DateTime.Now.Month.ToString(); //mes de hoy.
        String dia = DateTime.Now.Day.ToString(); //dia de hoy.
        String fecha = fechaPro.Text;
        String archivo = nomArch.Text;
        String periodo = "" + (mePeriodo.SelectedIndex + 1);
        
        if (periodo.Length == 1)
        {
            periodo = "0" + periodo;
        }

        if (mes.Length == 1)
        {
            mes = "0" + mes;
        }
        if (dia.Length == 1)
        {
            dia = "0" + dia;
        }

        String num = num_archivo(ano, mes, dia);
        if (num.Length == 1)
        {
            num = "0" + num;
        }
        

        String grupo = dia + num + periodo + cb_agno.SelectedValue; //grupo proceso
        return grupo;
    }



    public void limpiar_pantalla()
    {

        btn_mostrar_detalle.Visible = false;
        txt_resultados.Text = "";
        gvProceso.Visible = false;
        gvDetalle.Visible = false;
        lb_proceso.Visible = false;
        lb_proceso0.Visible = false;
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

    public void cargarAgno()
    {
        cb_agno.Items.Clear();
        String agno = DateTime.Today.Year.ToString();
        cb_agno.Items.Add(agno);
        cb_agno.Items[0].Value = agno;


        if (mePeriodo.SelectedValue == "12")
        {         
            agno = ""+(int.Parse(agno) + 1);
            cb_agno.Items.Add(agno);
            cb_agno.Items[1].Value = agno;
        }
    }

    // carga los periodos de un año en combo box.
    public void cargarPeriodo()
    {
        String fecha = DateTime.Now.ToString();

        int nuMes = DateTime.Now.Month;
        
        mePeriodo.Items.Clear();

        for (int i = 1; i <= 12; i++)
        {
            
            mePeriodo.Items.Add(nomMes(i));
            mePeriodo.Items[i-1].Value = i.ToString();
           
        }

        mePeriodo.SelectedValue = nuMes.ToString();
        cargarAgno();
       

    }

    //retorna nombre del mes según numero - ej 8: agosto.
    public String nomMes(int mes)
    {
        try
        {
            DateTimeFormatInfo formatoFecha = CultureInfo.CurrentCulture.DateTimeFormat;
            string nombreMes = formatoFecha.GetMonthName(mes);
            return nombreMes;
        }
        catch
        {
            return "Desconocido";
        } 
    
    }

    //si existe o no en la bd el grupo proceso ingresado
    public Boolean valida_grupo(String grupo,String tp,String fechaProceso)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_PROCESO.VALIDA_PROCESO", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_grupopro", OracleType.NVarChar, ParameterDirection.Input, grupo);
        PRO.agrega_parametro_sp(objComando, "i_tp", OracleType.Int32, ParameterDirection.Input, tp);
        PRO.agrega_parametro_sp(objComando, "i_fechaProceso", OracleType.NVarChar, ParameterDirection.Input, fechaProceso);
        //PRO.agrega_parametro_sp(objComando, "i_archivoProceso", OracleType.NVarChar, ParameterDirection.Input, fechaProceso);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "VALIDA");
        objConexion.Close();

        if (objDS.Tables["VALIDA"].Rows.Count == 0)
        {
           // nomArch.Text = objDS.Tables["VALIDA"].Rows.Count.ToString();
            return true;
        }
        else
        {
            return false;
        }
              
    }

    

    protected void recepcionar_archivo(object sender, EventArgs e)
    {
        limpiar_pantalla();
        try
        {
            error.Visible = true;
            //obtiene ruta de archivo.
            String ruta = Server.MapPath("./TXT/" + fuArchivo.PostedFile.FileName);
            String ext = Path.GetExtension(fuArchivo.PostedFile.FileName).ToString();

            String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";


            nomArch.Text = fuArchivo.PostedFile.FileName;

            

            
            String tp = ddTproceso.SelectedValue; //tipo proceso
            String ano = DateTime.Now.Year.ToString(); //año de hoy.
            String mes = DateTime.Now.Month.ToString(); //mes de hoy.
            String dia = DateTime.Now.Day.ToString(); //dia de hoy.
            String fecha = fechaPro.Text;
            String archivo = nomArch.Text;
            String num = num_archivo(ano,mes,dia);

           
            
            if (fuArchivo.HasFile) //tiene cargado un archivo?
            {
                if (ext == ".csv") //es de tipo csv?
                    {
                        if (!File.Exists(ruta)) //existe en directorio ./TXT/?
                        {

                            // String ruta2 = "C:/Users/Ramiro/Desktop/ESSBIO_MEDIDORES/arch/" + fuArchivo.PostedFile.FileName;
                            //  limpiar(ruta2);


                            if (valida_grupo(get_grupoproceso(),tp ,fecha)) //no existe grupo proceso?
                            {

                                fuArchivo.SaveAs(ruta);


                                int reg = totalReg(ruta); //retorna el número de filas del archivo cargado.

                                //INSERTA NUEVO PROCESO EN SISTEMA.
                                OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
                                OracleDataAdapter objComando;
                                DataSet objDS = new DataSet();

                                objConexion.Open();
                                objComando = new OracleDataAdapter("PK_PROCESO.NUEVO_PROCESO", objConexion);
                                objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

                                PRO.agrega_parametro_sp(objComando, "i_grupopro", OracleType.NVarChar, ParameterDirection.Input, get_grupoproceso());
                                PRO.agrega_parametro_sp(objComando, "i_idtp", OracleType.Int32, ParameterDirection.Input, tp);
                                PRO.agrega_parametro_sp(objComando, "i_rutempresa", OracleType.NVarChar, ParameterDirection.Input, PRO.recSession(rutaXml, "RUT_EMPRESA"));
                                PRO.agrega_parametro_sp(objComando, "i_anopro", OracleType.Int32, ParameterDirection.Input, ano);
                                PRO.agrega_parametro_sp(objComando, "i_mespro", OracleType.Int32, ParameterDirection.Input, mes); //nuArchivo x nuPeriodo.
                                PRO.agrega_parametro_sp(objComando, "i_diapro", OracleType.Int32, ParameterDirection.Input, dia);
                                PRO.agrega_parametro_sp(objComando, "i_cantidadre", OracleType.Int32, ParameterDirection.Input, reg.ToString());
                                PRO.agrega_parametro_sp(objComando, "i_fechapro", OracleType.NVarChar, ParameterDirection.Input, fecha);
                                PRO.agrega_parametro_sp(objComando, "i_estado", OracleType.Int32, ParameterDirection.Input, "0");
                                PRO.agrega_parametro_sp(objComando, "i_nombrearch", OracleType.NVarChar, ParameterDirection.Input, fuArchivo.PostedFile.FileName);
                                PRO.agrega_parametro_sp(objComando, "i_fechain", OracleType.NVarChar, ParameterDirection.Input, fecha);
                                PRO.agrega_parametro_sp(objComando, "i_fechaci", OracleType.NVarChar, ParameterDirection.Input, "");

                                try
                                {



                                    objComando.SelectCommand.ExecuteNonQuery();
                                    objConexion.Close();

                                    //limpia_archivo(ruta);
                                    //limpiar(ruta);
                                    error.Text = "";
                                    integra_archivo(ruta); //agrega ordenes del archivo ingresado.



                                }
                                catch (Exception ex)
                                {

                                    rollback_integracion(fuArchivo.PostedFile.FileName); //ELIMINA PROCESO INTEGRADO CON ARCHIVO IMPOSIBLE DE LEER ORDENES.                                                            
                                    mensaje_emergente("El archivo no se pudo integrar, revise el cuerpo/formato del documento: " + ex.Message);
                                }



                            }
                            else
                            {
                                //como ya existe grupo proceso para el mes indicado, se desecha archivo.
                                error.Text = "Ya existe un grupo proceso " + get_grupoproceso() + " " + ddTproceso.SelectedItem.ToString() + " para el mes de " + mePeriodo.SelectedItem.ToString();

                            }


                        }
                        else
                        {
                            // Archivo ya está cargado en directorio.
                            error.Text = "El archivo ya existe.";


                        }


                    }
                    else
                    {
                        //No se permiten archivos que no sean .txt
                        error.Text = "Solo archivos csv.";

                    }
                
            }
            else
            {
                error.Text = "No ha cargado ningún archivo!";
                
            }
        }
        catch (Exception ex)
        {
            mensaje_emergente("Error al intentar integrar archivo, verifique que el formato del documento sea el correcto");            
        }
    }

    public void rollback_integracion(String arch)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        
        try
        {
            objConexion.Open();
            OracleCommand cmd = new OracleCommand("DELETE FROM PROCESO WHERE NOMBRE_ARCHIVO = '" + arch + "'", objConexion);
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            error.Text = "Error al intentar reversar integración de proceso: " + ex.Message;
        }
        finally
        {
            objConexion.Close();
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
                break;
            }
            else
            {
                total = total + 1;
            }


        } while (!(line == null));

        return total; 
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
        
    //Todo caractér extraño lo reemplaza por uno legible.
    public String limpiar(String linea)
    {
        String sContent;
        
        String caracter1 = Convert.ToString((char)34);
        String caracter2 = Convert.ToString((char)42);
        String caracter3 = Convert.ToString((char)39);
        String caracter4 = Convert.ToString((char)13);
        String[] caracterRep1= {caracter1,""};
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

    //valida si la orden ya existe en el sistema.
    public String valida_localidad(String loc)
    {
        try
        {
             OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();

            objConexion.Open();
            objComando = new OracleDataAdapter("SELECT COD_LOCALIDAD FROM LOCALIDAD WHERE UPPER(LOCALIDAD) = UPPER('" + loc +"')", objConexion);
            objComando.SelectCommand.CommandType = CommandType.Text;

            objComando.SelectCommand.ExecuteNonQuery();
            objComando.Fill(objDS, "VALIDA");
            objConexion.Close();

            foreach (DataRow row in objDS.Tables["VALIDA"].Rows)
            {
                return row[0].ToString();
            }
        }
        catch (Exception ex)
        {
            return "0";
        }

        return "0";
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

    //obtiene numero de archivo.
    public String num_archivo(String ano, String mes, String dia)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_PROCESO.NUM_ARCHIVO", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_ano", OracleType.NVarChar, ParameterDirection.Input, ano);
        PRO.agrega_parametro_sp(objComando, "i_mes", OracleType.NVarChar, ParameterDirection.Input, mes);
        PRO.agrega_parametro_sp(objComando, "i_dia", OracleType.NVarChar, ParameterDirection.Input, dia);


        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "NUM");
        objConexion.Close();

        String num = objDS.Tables["NUM"].Rows[0][0].ToString();
        

        return num;
                    
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

 
    //integra ordenes al sistema.
    public void integra_archivo(String ruta)
    {
        //contabilidad de ordenes (ingresado - errado - duplicada).
        int ingresados = 0;
        int errados = 0;
        int duplicados = 0;
        String arch = fuArchivo.PostedFile.FileName;
        int cont = 0;

        dt = new DataTable();
        dt.Columns.Add(new DataColumn("NOMBRE_ARCHIVO", typeof(string)));
        dt.Columns.Add(new DataColumn("DESCRIPCION", typeof(string)));
        dt.Columns.Add(new DataColumn("DUPLICADOS", typeof(string)));
        dt.Columns.Add(new DataColumn("CARGADOS", typeof(string)));
        dt.Columns.Add(new DataColumn("ERRORES", typeof(string)));
        dt.Columns.Add(new DataColumn("ESTADO", typeof(string)));

        DataRow RD;

        detalle = new DataTable();
        detalle.Columns.Add(new DataColumn("NRO", typeof(string)));
        detalle.Columns.Add(new DataColumn("NUM_ORDEN", typeof(string)));
        detalle.Columns.Add(new DataColumn("SERVICIO", typeof(string)));
        detalle.Columns.Add(new DataColumn("CLIENTE", typeof(string)));
        detalle.Columns.Add(new DataColumn("MENSAJE_ERROR", typeof(string)));

        String ordenNum = "";
        
        try
        {
            String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
            sr = new StreamReader(ruta);
            String line; //almacenará una linea del archivo.
            String[] miArray; //captura datos de una linea del archivo.
            
            do
            {
                cont++;
                line = sr.ReadLine(); //lee linea de archivo.

                if (cont == 1) continue;

                if ((line == null) || (line == "")) //si el archivo está vacío corta el ciclo.
                {
                    break;
                }

                line = limpiar(line); //limpia linea de caracteres extraños.

                miArray = line.Split(';'); // almacena cada dato en el array[]
                
                String orden,id_servicio,nombre,sector,zona,correlativo,direccion,direccion_ad,localidad,serie_med,agno_med,diametro,modelo;
                String fecha_ul_lec, ul_lec, clave_lec, causa, tarifa, observacion_in, ruta_lectura,cod_localidad,fecha_orden;

                orden = miArray[0]; id_servicio = miArray[1]; nombre = miArray[2]; sector = miArray[3]; zona = miArray[4]; correlativo = miArray[5];
                direccion = miArray[6]; direccion_ad = (miArray[7] + ", " + miArray[9] + ", " + miArray[10] + ", " + miArray[11] + ", " + miArray[12]);
                localidad = miArray[8]; serie_med = miArray[13]; agno_med = miArray[14]; diametro = miArray[15]; modelo = miArray[16];
                fecha_ul_lec = miArray[17]; ul_lec = miArray[18]; clave_lec = miArray[19]; causa = miArray[20]; tarifa = miArray[24];
                observacion_in = miArray[26]; ruta_lectura = (sector + zona + correlativo); fecha_orden = miArray[22];
                                
                //validación servicio y ruta(sector+zona+correlativo).
                if (id_servicio == "" || ruta_lectura == "")
                {
                    errados += 1;
                    String msg = "Campos vacíos (ORDEN: " + orden + ", SERVICIO: " + id_servicio + ", RUTA: " + ruta_lectura + ")";
                    RD = detalle.NewRow();
                    RD["NRO"] = duplicados + errados;
                    RD["NUM_ORDEN"] = orden;
                    RD["SERVICIO"] = id_servicio;
                    RD["MENSAJE_ERROR"] = msg;
                    detalle.Rows.Add(RD);
                    PRO.Insertamos_log_detalle(orden, id_servicio, "" + PRO.OBTIENE_ID_PROCESO(arch), msg);
                    continue;
                }


                try
                {
                    

                    char[] servicio = { };
                    servicio = id_servicio.ToCharArray(); //obtiene el servicio separado por caracteres - ej: 0001006187 -> 0,0,0,1,0,0,6,1,8,7.

                    //elimina los 0 que existen antes del primer digito distinto a 0 - ej: 00010 -> 10.
                    for (int i = 0; i < servicio.Length; i++)
                    {
                        if (servicio[i] != '0')
                        {
                            id_servicio = "";

                            for (int o = i; o < servicio.Length; o++)
                            {
                                id_servicio = id_servicio + servicio[o].ToString();
                            }

                            break;
                        }

                    }

                    //si viene vacía le damos una orden ficticia.
                    if (orden == "") orden = "999" + id_servicio;

                    cod_localidad = valida_localidad(localidad);

                    if (cod_localidad == "0") //no existe en plataforma
                    {
                        errados += 1;
                        String msg = "Localidad " + localidad + " no existe en sistema";
                        RD = detalle.NewRow();
                        RD["NRO"] = duplicados + errados;
                        RD["NUM_ORDEN"] = orden;
                        RD["SERVICIO"] = id_servicio;
                        RD["MENSAJE_ERROR"] = msg;
                        detalle.Rows.Add(RD);
                        PRO.Insertamos_log_detalle(orden, id_servicio, "" + PRO.OBTIENE_ID_PROCESO(arch), msg);
                        continue;
                    }


                    if (valida_orden(orden) == false) //no existe integración con orden dada?
                    {

                        //INSERTA NUEVA INTEGRACIÓN DE REGISTRO.
                        try
                        {
                            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
                            OracleDataAdapter ComandoDA;
                            objConexion.Open();
                            ComandoDA = new OracleDataAdapter("PK_INTEGRACION.INTEGRA_ARCHIVO", objConexion);
                            ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

                            PRO.agrega_parametro_sp(ComandoDA, "i_ORDEN", OracleType.NVarChar, ParameterDirection.Input, orden);
                            PRO.agrega_parametro_sp(ComandoDA, "i_FECHA_ORDEN", OracleType.NVarChar, ParameterDirection.Input,fecha_orden);
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
                            PRO.agrega_parametro_sp(ComandoDA, "i_RUTEMPRESA", OracleType.NVarChar, ParameterDirection.Input, PRO.recSession(rutaXml, "RUT_EMPRESA"));

                            ComandoDA.SelectCommand.ExecuteNonQuery();
                            objConexion.Close();
                            ingresados += 1;
                        }
                        catch (Exception ex)
                        {
                            //Excepcion de conexión o ingreso a bbdd del registro.
                            errados += 1;
                            RD = detalle.NewRow();
                            RD["NRO"] = duplicados + errados;
                            RD["NUM_ORDEN"] = orden;
                            RD["SERVICIO"] = id_servicio;
                            RD["MENSAJE_ERROR"] = ex.Message;
                            detalle.Rows.Add(RD);

                            PRO.Insertamos_log_detalle(orden,id_servicio, "" + PRO.OBTIENE_ID_PROCESO(arch), ex.Message);
                            //NO INGRESA A CATCH
                        }

                    }
                    else
                    {
                        //Para registros duplicados en sistema.
                        String mensaje = "Nro. de orden duplicada, ya se encuentra en sistema.";
                        duplicados += 1; //INTENTO DE INTEGRACIÓN ~ DUPLICADOS?.
                        RD = detalle.NewRow();
                        RD["NRO"] = duplicados + errados;
                        RD["NUM_ORDEN"] =orden;
                        RD["SERVICIO"] = id_servicio;
                        RD["MENSAJE_ERROR"] = mensaje;
                        detalle.Rows.Add(RD);
                        PRO.Insertamos_log_detalle(orden, id_servicio, "" + PRO.OBTIENE_ID_PROCESO(arch), mensaje);
                        
                    }
                }
                catch (Exception ex)
                {
                    //Para errores de formato, largo de cadenas, otras.
                    errados += 1;
                    RD = detalle.NewRow();
                    RD["NRO"] = duplicados + errados;
                    RD["NUM_ORDEN"] = orden;
                    RD["SERVICIO"] = id_servicio;
                    RD["MENSAJE_ERROR"] = ex.Message;
                    detalle.Rows.Add(RD);
                    
                    PRO.Insertamos_log_detalle(orden,id_servicio, "" + PRO.OBTIENE_ID_PROCESO(arch), ex.Message);
                    
                }


            } while (!(line == null));

            int estado = 1; //1: procesado, 2: parcial y 3: fallido.
            String est = "PROCESADO";
            if (ingresados == 0)
            {
                estado = 3;
                est = "FALLIDO";
                
            }
            else if (ingresados < totalReg(ruta))
            {
                estado = 2;
                est = "PARCIAL";
            }

            txt_resultados.Text = totalReg(ruta) + " registro(s) analizado(s)";
            RD = dt.NewRow();
            RD["NOMBRE_ARCHIVO"] = fuArchivo.PostedFile.FileName;
            RD["DESCRIPCION"] = "ARCHIVO PROCESADO";
            RD["DUPLICADOS"] = duplicados;//cantidadDuplicados;
            RD["CARGADOS"] = ingresados;//registrosIngresados;
            RD["ERRORES"] = errados;
            RD["ESTADO"] = est;
            dt.Rows.Add(RD);

            //cargar datos a grilla de proceso.
            DataView MydataViewvsita = new DataView();
            MydataViewvsita = new DataView(dt);
            gvProceso.DataSource = MydataViewvsita;
            gvProceso.DataBind();
            gvProceso.Visible = true;
            lb_proceso.Visible = true;

            //cargar datos a grilla de detalle.
            MydataViewvsita = new DataView(detalle);
            gvDetalle.DataSource = MydataViewvsita;
            gvDetalle.DataBind();
            btn_mostrar_detalle.Visible = true;

           
            String[] info = carga_info_proceso(""+PRO.OBTIENE_ID_PROCESO(fuArchivo.PostedFile.FileName));

            //log de proceso realizado.
            PRO.Insertamos_log_proceso(fuArchivo.PostedFile.FileName, "ARCHIVO PROCESADO", "" + duplicados, "" + errados, "" + ingresados, "" + estado, info[0], PRO.recSession(rutaXml, "RUT_EMPRESA"), info[1], PRO.recSession(rutaXml, "USERNAME").ToUpper());
           
        }
        catch (Exception ex)
        {
            mensaje_emergente("Error con el cuerpo/formato del archivo (" + fuArchivo.PostedFile.FileName + ") : " + ex.Message);
            rollback_integracion(fuArchivo.PostedFile.FileName); //ELIMINA PROCESO INTEGRADO CON ARCHIVO IMPOSIBLE DE LEER ORDENES.           
            sr.Dispose();
            sr.Close(); //CERRAMOS READER.
            File.Delete(ruta); //DESPUES DE CERRAR READER SE PROCEDE A ELIMINAR ARCHIVO DEL DIRECTORIO.
            
        }
                
    }


    public String[] carga_info_proceso(String P_ID_PROCESO)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        String[] info = new String[4];

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

            info[0] = P_ID_PROCESO;
            info[1] = drItem["GRUPO_PROCESO"].ToString();
            info[2] = drItem["TIPO"].ToString();
            info[3] = drItem["FECHA_PROCESO"].ToString();

        }

        return info;
    }
    

    //despliega y oculta detalle de errores (si es que los hay).
    protected void mostrar_detalle(object sender, EventArgs e)
    {
       
        if (gvDetalle.Visible == false)
        {

            //se procede a mostrar detalle de error si es que los hay..
            if (gvDetalle.Rows.Count == 0)
            {
                error.Text = "Proceso ingresado sin errores!";
                error.Visible = true;
                
            }
            gvDetalle.Visible = true;
            lb_proceso0.Visible = true;
            
        }
        else
        {
            //se procede a ocultar detalle de error.
            gvDetalle.Visible = false;
            lb_proceso0.Visible = false;
            error.Visible = false;
            
        }

                    
    }


    protected void mePeriodo_SelectedIndexChanged(object sender, EventArgs e)
    {
        String periodo = ""+(mePeriodo.SelectedIndex + 1);

        if (periodo.Length == 1)
        {
            periodo = "0" + periodo;
        }
        cargarAgno();
        grupo_proceso.Text = get_grupoproceso();
        

    }

    protected void gvProceso_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

    }

    protected void gvProceso_RowCommand(object sender, GridViewCommandEventArgs e)
    {

    }

    protected void gvProceso_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void nuArchivo_TextChanged(object sender, EventArgs e)
    {
        //limpiar_pantalla();
    }

    //muestra una ventana emergente con un mensaje de entrada y el tipo de ventana (alert o confirm)
    public void mensaje_emergente(String mensaje){

        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append("<script type = 'text/javascript'>");
        sb.Append("window.onload=function(){");
        sb.Append("alert('");
        sb.Append(mensaje);
        sb.Append("')};");
        sb.Append("</script>");
        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());

    }



    protected void aPeriodo_TextChanged(object sender, EventArgs e)
    {

    }
}