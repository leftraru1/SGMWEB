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

public partial class Crear_proceso : System.Web.UI.Page
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

                cargarPeriodo();
                cargaProceso();

                grupo_proceso.Text = get_grupoproceso();
                fechaPro.Text = DateTime.Now.ToString("dd-MM-yyyy");

            }
            catch (Exception ex)
            {
                //Response.Redirect("errorSesion.aspx");
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

    // carga los periodos de un año en combo box.
    public void cargarPeriodo()
    {
        String fecha = DateTime.Now.ToString();

        int nuMes = DateTime.Now.Month;

        mePeriodo.Items.Clear();

        for (int i = 1; i <= 12; i++)
        {

            mePeriodo.Items.Add(nomMes(i));
            mePeriodo.Items[i - 1].Value = i.ToString();

        }
        mePeriodo.SelectedValue = nuMes.ToString();
        cargarAgno();
    }

    public void cargarAgno()
    {
        cb_agno.Items.Clear();
        String agno = DateTime.Today.Year.ToString();
        cb_agno.Items.Add(agno);
        cb_agno.Items[0].Value = agno;


        if (mePeriodo.SelectedValue == "12")
        {
            agno = "" + (int.Parse(agno) + 1);
            cb_agno.Items.Add(agno);
            cb_agno.Items[1].Value = agno;
        }
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

    protected void mePeriodo_SelectedIndexChanged(object sender, EventArgs e)
    {
        String periodo = "" + (mePeriodo.SelectedIndex + 1);

        if (periodo.Length == 1)
        {
            periodo = "0" + periodo;
        }
        cargarAgno();
        grupo_proceso.Text = get_grupoproceso();
    }

    protected void recepcionar_archivo(object sender, EventArgs e)
    {
        try
        {
            String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";

            String tp = ddTproceso.SelectedValue; //tipo proceso
            String ano = DateTime.Now.Year.ToString(); //año de hoy.
            String mes = DateTime.Now.Month.ToString(); //mes de hoy.
            String dia = DateTime.Now.Day.ToString(); //dia de hoy.
            String fecha = fechaPro.Text;
            String archivo = nomArch.Text;


                        if (valida_grupo(get_grupoproceso(), tp, fecha)) //no existe grupo proceso?
                        {
                            //INSERTA NUEVO PROCESO EN SISTEMA.
                            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
                            OracleDataAdapter objComando;
                            DataSet objDS = new DataSet();

                            objConexion.Open();
                            objComando = new OracleDataAdapter("PK_CAMBIO_PROCESO.NUEVO_PROCESO", objConexion);
                            objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

                            PRO.agrega_parametro_sp(objComando, "i_grupopro", OracleType.NVarChar, ParameterDirection.Input, get_grupoproceso());
                            PRO.agrega_parametro_sp(objComando, "i_idtp", OracleType.Int32, ParameterDirection.Input, tp);
                            PRO.agrega_parametro_sp(objComando, "i_rutempresa", OracleType.NVarChar, ParameterDirection.Input, PRO.recSession(rutaXml, "RUT_EMPRESA"));
                            PRO.agrega_parametro_sp(objComando, "i_anopro", OracleType.Int32, ParameterDirection.Input, ano);
                            PRO.agrega_parametro_sp(objComando, "i_mespro", OracleType.Int32, ParameterDirection.Input, mes); //nuArchivo x nuPeriodo.
                            PRO.agrega_parametro_sp(objComando, "i_diapro", OracleType.Int32, ParameterDirection.Input, dia);
                          //PRO.agrega_parametro_sp(objComando, "i_cantidadre", OracleType.Int32, ParameterDirection.Input, reg.ToString());
                            PRO.agrega_parametro_sp(objComando, "i_fechapro", OracleType.NVarChar, ParameterDirection.Input, fecha);
                            PRO.agrega_parametro_sp(objComando, "i_estado", OracleType.Int32, ParameterDirection.Input, "0");
                          PRO.agrega_parametro_sp(objComando, "i_nombrearch", OracleType.NVarChar, ParameterDirection.Input,archivo );
                            PRO.agrega_parametro_sp(objComando, "i_fechain", OracleType.NVarChar, ParameterDirection.Input, fecha);
                            PRO.agrega_parametro_sp(objComando, "i_fechaci", OracleType.NVarChar, ParameterDirection.Input, "");

                            try
                            {
                                objComando.SelectCommand.ExecuteNonQuery();
                                objConexion.Close();
                                lbmensaje.Visible = true;
                                lbmensaje.ForeColor = System.Drawing.Color.Green;
                                lbmensaje.Text = "* SE CREO PROCESO EXITOSAMENTE !";
                                form_crear.Visible = false;
                            }
                            catch (Exception ex)
                            {

                            }
                        }
        }
        catch (Exception ex)
        {
            mensaje_emergente("Error al crear proceso");
        }
    }

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
            return true;
        }
        else
        {
            return false;
        }   
    }

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

}