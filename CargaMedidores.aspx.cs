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
using System.Data.OleDb;
using System.Text.RegularExpressions;

public partial class CargaMedidores : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    bool existe_proceso;
    Procedimientos PRO = new Procedimientos();
    public String rutaGlobal;
    public DataTable dt;
    public DataTable detalle;
    public String valor_duplicados;
    public String valor_error;
    public String archivo;
    public int registrosIngresados,registros_no_ingresados,cantidad;
    public int cantidadErrores;
    public int cantidadDuplicados;
    public String strA = null;
    public String strB = null;
    public String strC = null;
    public String Str_Grupo_Proceso = null;
    public String contratista, region;
    public int error_cod = 0, error_serie = 0, error_agno = 0, error_diam = 0, error_contr = 0, error_reg = 0;
    public int error_otro = 0,error_cod_unico = 0,error_no_coincide = 0,error_no_existe_marca = 0,error_no_existe_diametro = 0;

    //Carga fecha , llama la fecha actual por defecto 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {


            try
            {
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                carga_guias();
                carga_tipo_proceso();

            }
            catch (Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }

        }

    }


    // toma 2 parametros string y ve si uno está contenido en el otro 
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
    //remplaza caracteres invalidos o en su defecto los elimina
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
        String[] caracterRep13 = { "&", "" };


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
            sContent = limpiaGenerico(sContent, caracterRep13);
        }
        catch (Exception ex)
        { }

        return sContent;


    }


    // indica cuantos procesos posee con cierto mes y cierto año, la consulta tambien inica el tipo de proceso
    public int num_archivo(String ano, String mes)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_PROCESO.NUM_ARCHIVO", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_mes", OracleType.NVarChar, ParameterDirection.Input, mes);
        PRO.agrega_parametro_sp(objComando, "i_ano", OracleType.NVarChar, ParameterDirection.Input, ano);


        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "NUM");
        objConexion.Close();

        int num = int.Parse(objDS.Tables["NUM"].Rows[0][0].ToString());

        return num;

    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        // Inicia el contador:
        DateTime tiempo1 = DateTime.Now;
        try
        {
            //inicializamos contadores.
            error_serie = error_agno = error_diam = error_contr = error_reg = error_cod_unico = 0;
            error_cod = error_no_coincide = error_no_existe_diametro = error_no_existe_marca = error_otro = 0;

            String ruta = Server.MapPath("./TXT/" + fuArchivo.PostedFile.FileName);
            String ext = Path.GetExtension(fuArchivo.PostedFile.FileName).ToString();
            registros_no_ingresados = 0;
            registrosIngresados = 0;
            cantidadErrores = 0;
            cantidadDuplicados = 0;
            cantidad = 0;
            int cont = 0;
            if (System.IO.File.Exists(ruta) == false)
            {
                if (ddguia.SelectedValue != "")
                {

                    if (true)
                    {

                        fuArchivo.SaveAs(ruta);

                        StreamReader sr = new StreamReader(ruta);
                        String x = "";
                        String line;
                        String[] miArray;

                        int noIn = 0;
                        do
                        {
                            line = sr.ReadLine();

                            line = limpiar(line);
                            try
                            {                        
                                if (line != null)
                                {
                                    miArray = line.Split(';');
                                    //validamos que la región, contratista coincida y que el código del medidor sea único.
                                    //(region == miArray[6] && contratista == miArray[5]) && valida_cod_medidor(ddguia.SelectedValue, miArray[1], miArray[2], miArray[3], miArray[4]) == false
                                    if (valida_registro(miArray))
                                    {
                                        OracleDataAdapter ComandoDA;
                                        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
                                        objConexion.Open();
                                        ComandoDA = new OracleDataAdapter("PK_INSERTA_MEDIDORES.CARGA", objConexion);

                                        PRO.agrega_parametro_sp(ComandoDA, "i_nombre", OracleType.NVarChar, ParameterDirection.Input, miArray[0]);
                                        PRO.agrega_parametro_sp(ComandoDA, "i_codigo", OracleType.Number, ParameterDirection.Input, miArray[1]);
                                        PRO.agrega_parametro_sp(ComandoDA, "i_serie", OracleType.Number, ParameterDirection.Input, miArray[2]);
                                        PRO.agrega_parametro_sp(ComandoDA, "i_ano", OracleType.Number, ParameterDirection.Input, miArray[3]);
                                        PRO.agrega_parametro_sp(ComandoDA, "i_diametro", OracleType.Number, ParameterDirection.Input, miArray[4]);
                                        PRO.agrega_parametro_sp(ComandoDA, "i_contratista", OracleType.Number, ParameterDirection.Input, miArray[5]);
                                        PRO.agrega_parametro_sp(ComandoDA, "i_region", OracleType.Number, ParameterDirection.Input, miArray[6]);
                                        PRO.agrega_parametro_sp(ComandoDA, "i_guia", OracleType.Number, ParameterDirection.Input, ddguia.SelectedValue);
                                        PRO.agrega_parametro_sp(ComandoDA, "tipo_proceso", OracleType.Number, ParameterDirection.Input, ddtipoproceso.SelectedValue);

                                        ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

                                        ComandoDA.SelectCommand.ExecuteNonQuery();
                                        objConexion.Close();
                                        cont = cont + 1;
                                        objConexion.Dispose();

                                    }
                                    else
                                    {
                                        registros_no_ingresados = registros_no_ingresados + 1;
                                    }
                                }
                            }
                            catch (Exception ex)
                            {
                                registros_no_ingresados = registros_no_ingresados + 1;
                                error_otro++;
                            }
                        } while (line != null);
                        DateTime tiempo2 = DateTime.Now;
                        TimeSpan total = new TimeSpan(tiempo2.Ticks - tiempo1.Ticks);
                        lbcont.Visible = true;
                        lbcont.ForeColor = System.Drawing.Color.Green;

                        lb_mensaje_error.ForeColor = System.Drawing.Color.Green;

                        if (registros_no_ingresados > 0)
                        {
                            String detalle = log_error();
                            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " carga_con_error('" + detalle + "','" + registros_no_ingresados + "');", true);
                       
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " carga_realizada('" + cont + "','" + registros_no_ingresados + "');", true);
                        }
                        carga_medidores_ingresados();
                        carga_detalle_ingreso();
                        carga_detalle();
                        //lb_mensaje_error.Text = "CARGA REALIZADA EXITOSAMENTE:";
                        //lbcont.Text = " " + cont + " REGISTROS CARGADOS - TIEMPO DE CARGA: " + total.Hours.ToString() + ":" + total.Minutes.ToString() + ":" + total.Seconds.ToString() + "";

                    }
                    else
                    {

                        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " repiteCarga();", true);

                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error('No existe numero de guía o ocurrio un error en la carga');", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error('El archivo ya existe!');", true);
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " errorCarga();", true);
        }
    }

    public String log_error()
    {
        String mi_detalle = "";
        List<String> errores = new List<String>();

        if (error_cod > 0)
        {
            mi_detalle += "(" + error_cod + ") formato erroneo código marca (campo 2).";
            errores.Add(error_cod +" Error(es) con formato de código marca (campo 2).");
        }
        if (error_no_existe_marca > 0)
        {
            mi_detalle += "(" + error_no_existe_marca + ") no existe código marca en sistema.";
            errores.Add(error_no_existe_marca + " Error(es) no existe cód. marca en sistema.");
        }

        if (error_serie > 0)
        {
            mi_detalle += "(" + error_serie + ") formato erroneo serie medidor (campo 3).";
            errores.Add(error_serie + " Error(es) con formato de serie medidor (campo 3).");
        }

        if (error_agno > 0)
        {
            mi_detalle += "(" + error_agno + ") formato erroneo año (campo 4).";
            errores.Add(error_agno + " Error(es) con formato año (campo 4).");
        }

        if (error_diam > 0)
        {
            mi_detalle += "(" + error_diam + ") formato erroneo diametro (campo 5).";
            errores.Add(error_diam + " Error(es) con formato diametro (campo 5).");
        }

        if (error_no_existe_diametro > 0)
        {
            mi_detalle += "(" + error_no_existe_diametro + ") no existe diametro en sistema.";
            errores.Add(error_no_existe_diametro + " no existe diametro en sistema.");
        }

        if (error_contr > 0)
        {
            mi_detalle += "(" + error_contr + ") formato erroneo contratista (campo 6).";
            errores.Add(error_contr + " Error(es) con formato contratista (campo 6).");
        }

        if (error_reg > 0)
        {
            mi_detalle += "(" + error_reg + ") formato erroneo región (campo 7).";
            errores.Add(error_reg + " Error(es) con formato región (campo 7).");
        }

        if (error_no_coincide > 0)
        {
            mi_detalle += "(" + error_no_coincide + ") no coincide contratista o región con guía elegida.";
            errores.Add(error_no_coincide + " Error(es) no coincide contratista o región con guía elegida.");
        }

        if (error_cod_unico > 0)
        {
            mi_detalle += "(" +error_cod_unico + ") ya existe medidor en sistema.";
            errores.Add(error_cod_unico + " Error(es) Ya existe medidor en sistema.");
        }       

        if (error_otro > 0)
        {
            mi_detalle +=  "(" + error_otro + ") ERROR DESCONOCIDO, revisar archivo.";
            errores.Add(error_otro + " Error(es) revisar archivo.");
        }
        

        return mi_detalle;
    }


    public Boolean valida_numero_guia(String numero_guia)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_INSERTA_MEDIDORES.VALIDA_NUMERO_GUIA", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "numero_guia", OracleType.Number, ParameterDirection.Input, numero_guia);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "NUMERO_GUIA");
        objConexion.Close();

        foreach (DataRow row in objDS.Tables["NUMERO_GUIA"].Rows)
        {

            return true;
        }

        return false;
    }

    public void carga_guias()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_CARGA_DD_GUIA.CARGA_GUIA", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "GUIAS");
        objConexion.Close();

        int i = 0;
        ddguia.Items.Clear();

        foreach (DataRow row in objDS.Tables["GUIAS"].Rows)
        {

            ddguia.Items.Add(row[1].ToString());
            ddguia.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }

    public void carga_tipo_proceso()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_CARGA_DD_GUIA.CARGA_TIPO_PROCESO", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "TIPOS");
        objConexion.Close();

        int i = 0;
        ddtipoproceso.Items.Clear();

        foreach (DataRow row in objDS.Tables["TIPOS"].Rows)
        {

            ddtipoproceso.Items.Add(row[1].ToString());
            ddtipoproceso.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }

    public Boolean valida_registro(String[] arreglo)
    {
        
        String val_cod_marca = arreglo[1],val_serie = arreglo[2],val_agno = arreglo[3], val_diametro = arreglo[4];
        String val_contratista = arreglo[5], val_region = arreglo[6], val_codigo_unico = val_cod_marca + val_agno + val_serie + val_diametro;

        int cont;
        //validamos formatos
        if(!int.TryParse(val_cod_marca,out cont)){
            error_cod++;
            return false;
        }
        else if (!int.TryParse(val_serie, out cont))
        {
            error_serie++;
            return false;
        }
        else if (!int.TryParse(val_agno, out cont))
        {
            error_agno++;
            return false;
        }
        else if (!int.TryParse(val_diametro, out cont))
        {
            error_diam++;
            return false;
        }
        else if (!int.TryParse(val_contratista, out cont))
        {
            error_contr++;
            return false;
        } else if (!int.TryParse(val_region, out cont))
        {
            error_reg++;
            return false;
        } 
        
        //validamos coincidencia con region y contratista de la guia.
        if (!contratista.Equals(val_contratista))
        {
            error_no_coincide++;
            return false;
        }
        else if (!region.Equals(val_region))
        {
            error_no_coincide++;
            return false;
        }


        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_INSERTA_MEDIDORES.VALIDA_DATOS_MEDIDOR", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_cod_marca", OracleType.NVarChar, ParameterDirection.Input, val_cod_marca);
        PRO.agrega_parametro_sp(objComando, "i_diametro", OracleType.NVarChar, ParameterDirection.Input, val_diametro);
        PRO.agrega_parametro_sp(objComando, "i_codigo_unico", OracleType.NVarChar, ParameterDirection.Input, val_codigo_unico);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "VALIDA");
        objConexion.Close();
        
        foreach (DataRow row in objDS.Tables["VALIDA"].Rows)
        {
            if (row[0].ToString().Equals("0")) //si marca no existe, error.
            {
                error_no_existe_marca++;
                return false;
            }
            if (row[1].ToString().Equals("0")) //si diametro no existe, error.
            {
                error_no_existe_diametro++;
                return false;
            }
            if (row[2].ToString().Equals("1")) //si encuentra codigo unico, error.
            {
                error_cod_unico++;
                return false;
            }
                        
        }

        return true;
    }

    public Boolean valida_cod_medidor(String numero_guia, String codigo, String serie, String ano, String diametro)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_INSERTA_MEDIDORES.VALIDA_MEDIDOR", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "numero_guia", OracleType.Number, ParameterDirection.Input, numero_guia);
        PRO.agrega_parametro_sp(objComando, "i_codigo", OracleType.Number, ParameterDirection.Input, codigo);
        PRO.agrega_parametro_sp(objComando, "i_serie", OracleType.Number, ParameterDirection.Input, serie);
        PRO.agrega_parametro_sp(objComando, "i_ano", OracleType.Number, ParameterDirection.Input, ano);
        PRO.agrega_parametro_sp(objComando, "i_diametro", OracleType.Number, ParameterDirection.Input, diametro);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "MEDIDOR");
        objConexion.Close();

        int i = 0;

        foreach (DataRow row in objDS.Tables["MEDIDOR"].Rows)
        {

            return true;
        }

        return false;
    }

    protected void articulos_RowCommand(object sender, GridViewCommandEventArgs e)
    {

    }


    public void carga_medidores_ingresados()
    {
        medidores.Columns[0].Visible = true;
        medidores.Columns[1].Visible = true;

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_INSERTA_MEDIDORES.CARGA_GRILLA_MEDIDORES", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        if (ddguia.SelectedValue != "")
        {
            PRO.agrega_parametro_sp(da, "i_guia", OracleType.Number, ParameterDirection.Input, ddguia.SelectedValue);
        }
        else
        {

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error('No existe numero de guía o ocurrio un error en la carga');", true);
            return;
        }

        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        DataTable dtMedidores = new DataTable();

        try
        {
            CnOra.Open();
            da.Fill(dtMedidores);
            CnOra.Close();
            CnOra.Dispose();
        }
        catch (Exception ex)
        {

        }


        DataTable dt = new DataTable();

        dt.Columns.Add(new DataColumn("ID_GUIA", typeof(int)));
        dt.Columns.Add(new DataColumn("ID_MEDIDOR", typeof(String)));
        dt.Columns.Add(new DataColumn("NOMBRE_MODELO", typeof(String)));
        dt.Columns.Add(new DataColumn("SERIE", typeof(String)));
        dt.Columns.Add(new DataColumn("ANO", typeof(int)));
        dt.Columns.Add(new DataColumn("DIAMETRO", typeof(String)));
        dt.Columns.Add(new DataColumn("CONTRATISTA", typeof(String)));
        dt.Columns.Add(new DataColumn("REGION", typeof(String)));
        dt.Columns.Add(new DataColumn("CODIGO_UNICO", typeof(String)));

        DataRow dr;

        int total = 0;

        foreach (DataRow drOrdenItem in dtMedidores.Rows)
        {
            dr = dt.NewRow();
            dr["ID_GUIA"] = drOrdenItem["ID_GUIA"].ToString();
            dr["ID_MEDIDOR"] = drOrdenItem["ID_MEDIDOR"].ToString();
            dr["NOMBRE_MODELO"] = drOrdenItem["NOMBRE_MODELO"].ToString();
            dr["SERIE"] = drOrdenItem["SERIE"].ToString();
            dr["ANO"] = drOrdenItem["ANO"].ToString();
            dr["DIAMETRO"] = drOrdenItem["DIAMETRO"].ToString();
            dr["CONTRATISTA"] = drOrdenItem["CONTRATISTA"].ToString();
            dr["REGION"] = drOrdenItem["REGION"].ToString();
            dr["CODIGO_UNICO"] = drOrdenItem["CODIGO_UNICO"].ToString();

            dt.Rows.Add(dr);

            total = total + 1;

        }


        DataView MydataView;
        MydataView = new DataView(dt);
        medidores.DataSource = MydataView;
        medidores.DataBind();

        medidores.Columns[0].Visible = false;
        medidores.Columns[1].Visible = false;
    }

    protected void medidores_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        medidores.PageIndex = e.NewPageIndex;
        carga_medidores_ingresados();
    }

    protected void medidores_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void ddguia_SelectedIndexChanged(object sender, EventArgs e)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_CARGA_DD_GUIA.CARGA_REGION_CONTRATISTA", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        if (ddguia.SelectedValue != "")
        {
            PRO.agrega_parametro_sp(objComando, "i_guia", OracleType.Number, ParameterDirection.Input, ddguia.SelectedValue);
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error('No existe numero de guía o ocurrio un error en la carga');", true);
            return;
        }

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "DATOS");
        objConexion.Close();

        int i = 0;

        foreach (DataRow row in objDS.Tables["DATOS"].Rows)
        {
            contratista = (int.Parse(row[1].ToString())).ToString();
            region = row[0].ToString();
            i = i + 1;

        }

        carga_medidores_ingresados();
        carga_detalle_ingreso();
        carga_detalle();
    }

    protected void medidores_RowCreated(object sender, GridViewRowEventArgs e)
    {

    }

    protected void finalizar_carga_Click(object sender, EventArgs e)
    {
        Boolean band = true;
        detalle_guia.Columns[0].Visible = true;
        cant_medidores.Columns[0].Visible = true;

        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_INSERTA_MEDIDORES.MARCA_GUIA", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        if (ddguia.SelectedValue != "")
        {
            PRO.agrega_parametro_sp(objComando, "guia", OracleType.Number, ParameterDirection.Input, ddguia.SelectedValue);
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error('No existe numero de guía o ocurrio un error en la carga');", true);
            return;
        }

        int limite;

        if (detalle_guia.Rows.Count > cant_medidores.Rows.Count)
        {
            limite = detalle_guia.Rows.Count;
        }
        else
        {
            limite = cant_medidores.Rows.Count;
        }

        for (int i = 0; i < limite; i++)
        {
            try
            {
                if (detalle_guia.Rows[i].Cells[3].Text != cant_medidores.Rows[i].Cells[3].Text || detalle_guia.Rows[i].Cells[0].Text != cant_medidores.Rows[i].Cells[0].Text)
                {
                    detalle_guia.Rows[i].BackColor = System.Drawing.Color.Red;
                    cant_medidores.Rows[i].BackColor = System.Drawing.Color.Red;
                    band = false;
                }
            }
            catch (Exception ex)
            {
                band = false;
            }
        }

        try
        {

            if (band == true)
            {

                objComando.SelectCommand.ExecuteNonQuery();
                objConexion.Close();

                panel3.Visible = false;
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " cerro('');", true);

            }
            else
            {

                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " Error('Las cantidades no coinciden');", true);

            }
        }
        catch (Exception ex)
        {

        }


        detalle_guia.Columns[0].Visible = false;
        cant_medidores.Columns[0].Visible = false;
        // MARCAR GUIA PARA QUE NO VUELVAN A CARGARSE MEDIDORES

    }

    protected void eliminar_Click(object sender, EventArgs e)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_INSERTA_MEDIDORES.ELIMINA_MEDIDORES", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        if (ddguia.SelectedValue != "")
        {
            PRO.agrega_parametro_sp(objComando, "guia", OracleType.Number, ParameterDirection.Input, ddguia.SelectedValue);
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error('No es posible eliminar los medidores');", true);
            return;
        }

        objComando.SelectCommand.ExecuteNonQuery();
        objConexion.Close();
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " se_elimino('');", true);

        carga_medidores_ingresados();
        carga_detalle_ingreso();
        carga_detalle();

    }

    public void carga_detalle()
    {
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_INSERTA_MEDIDORES.CARGA_GRILLA_DETALLE", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        if (ddguia.SelectedValue != "")
        {
            PRO.agrega_parametro_sp(da, "i_guia", OracleType.Number, ParameterDirection.Input, ddguia.SelectedValue);
        }
        else
        {

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error('No existe numero de guía o ocurrio un error en la carga');", true);
            return;
        }

        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        DataTable dtDetalle = new DataTable();

        try
        {
            CnOra.Open();
            da.Fill(dtDetalle);
            CnOra.Close();
            CnOra.Dispose();
        }
        catch (Exception ex)
        {
            String msg = ex.Message;
        }


        DataTable dt = new DataTable();

        dt.Columns.Add(new DataColumn("CODIGO_ARTICULO", typeof(int)));
        dt.Columns.Add(new DataColumn("NOMBRE_ARTICULO", typeof(String)));
        //dt.Columns.Add(new DataColumn("DIAMETRO", typeof(String)));
        dt.Columns.Add(new DataColumn("CANTIDAD", typeof(String)));
        //dt.Columns.Add(new DataColumn("CANTIDAD_CARGADA", typeof(String)));
        dt.Columns.Add(new DataColumn("COD_MARCA_MAP", typeof(String)));

        DataRow dr;

        int total = 0;

        foreach (DataRow drDetalleItem in dtDetalle.Rows)
        {
            dr = dt.NewRow();
            dr["CODIGO_ARTICULO"] = drDetalleItem["CODIGO_ARTICULO"].ToString();
            dr["NOMBRE_ARTICULO"] = drDetalleItem["NOMBRE_ARTICULO"].ToString();
            dr["CANTIDAD"] = drDetalleItem["CANTIDAD"].ToString();
            //dr["CANTIDAD_CARGADA"] = drDetalleItem["CANTIDAD_CARGADA"].ToString();
            //dr["DIAMETRO"] = drDetalleItem["DIAMETRO"].ToString();
            dr["COD_MARCA_MAP"] = drDetalleItem["COD_MARCA_MAP"].ToString();

            dt.Rows.Add(dr);

            total = total + 1;

        }

        DataView MydataView;
        MydataView = new DataView(dt);
        detalle_guia.DataSource = MydataView;
        detalle_guia.DataBind();

    }

    protected void detalle_guia_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void detalle_guia_RowCreated(object sender, GridViewRowEventArgs e)
    {

    }

    protected void detalle_guia_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        detalle_guia.PageIndex = e.NewPageIndex;
        carga_detalle();
    }

    protected void detalle_guia_RowCommand(object sender, GridViewCommandEventArgs e)
    {

    }

    public void carga_detalle_ingreso()
    {
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_INSERTA_MEDIDORES.MEDIDORES_CARGADOS", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        if (ddguia.SelectedValue != "")
        {
            PRO.agrega_parametro_sp(da, "i_guia", OracleType.Number, ParameterDirection.Input, ddguia.SelectedValue);
        }
        else
        {

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error('No existe numero de guía o ocurrio un error en la carga');", true);
            return;
        }

        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        DataTable dtDetalle = new DataTable();

        try
        {
            CnOra.Open();
            da.Fill(dtDetalle);
            CnOra.Close();
            CnOra.Dispose();
        }
        catch (Exception ex)
        {

        }


        DataTable dt = new DataTable();

        dt.Columns.Add(new DataColumn("ID_TIPO_MEDIDOR", typeof(string)));
        dt.Columns.Add(new DataColumn("NOMBRE_MODELO", typeof(String)));
        dt.Columns.Add(new DataColumn("CANTIDAD", typeof(String)));
        dt.Columns.Add(new DataColumn("COD_MARCA_MAP", typeof(String)));

        DataRow dr;

        int total = 0;

        foreach (DataRow drDetalleItem in dtDetalle.Rows)
        {
            dr = dt.NewRow();
            dr["ID_TIPO_MEDIDOR"] = drDetalleItem["ID_TIPO_MEDIDOR"].ToString();
            dr["NOMBRE_MODELO"] = drDetalleItem["NOMBRE_MODELO"].ToString();
            dr["CANTIDAD"] = drDetalleItem["CANTIDAD"].ToString();
            dr["COD_MARCA_MAP"] = drDetalleItem["COD_MARCA_MAP"].ToString();
            dt.Rows.Add(dr);

            total = total + 1;

        }

        DataView MydataView;
        MydataView = new DataView(dt);
        cant_medidores.DataSource = MydataView;
        cant_medidores.DataBind();

    }

    protected void inserta_accesorios()
    {

        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_INSERTA_MEDIDORES.INSERTA_ACCESORIOS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        if (ddguia.SelectedValue != "")
        {
            PRO.agrega_parametro_sp(objComando, "i_guia", OracleType.Number, ParameterDirection.Input, ddguia.SelectedValue);
        }
        else
        {
            //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error('No es posible insertar accesorios');", true);
            return;
        }

        try{

            objComando.SelectCommand.ExecuteNonQuery();
            objConexion.Close();

        }catch(Exception e){
        
        }

        
        //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " correcto('');", true);

    }
}





