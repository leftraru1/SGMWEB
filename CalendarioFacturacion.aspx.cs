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
using System.Collections.Generic;

public partial class CalendarioFacturacion : System.Web.UI.Page
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

                carga_agnos();
                carga_calendarios(cb_agno.SelectedValue,cb_periodo.SelectedValue);
                

            }
            catch (Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }
        }
    }

    public void carga_calendarios(String agno, String mes)
    {
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_CALENDARIO.CARGA_CALENDARIOS", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_agno", OracleType.Number, ParameterDirection.Input, agno);
        PRO.agrega_parametro_sp(da, "i_mes", OracleType.Number, ParameterDirection.Input, mes);

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
        dt.Columns.Add(new DataColumn("ID_CALENDARIO", typeof(String)));
        dt.Columns.Add(new DataColumn("PERIODO", typeof(String)));
        dt.Columns.Add(new DataColumn("AGNO", typeof(String)));
        dt.Columns.Add(new DataColumn("MES", typeof(String)));
        dt.Columns.Add(new DataColumn("FECHA_CREACION", typeof(String)));
        dt.Columns.Add(new DataColumn("USUARIO", typeof(String)));
        dt.Columns.Add(new DataColumn("ESTADO", typeof(String)));

        DataRow dr;

        int total = 0;

        foreach (DataRow drOrdenItem in dtOrdenes.Rows)
        {

            dr = dt.NewRow();
            dr["ID_CALENDARIO"] = drOrdenItem["ID_CALENDARIO"].ToString();
            dr["PERIODO"] = drOrdenItem["PERIODO"].ToString();
            dr["AGNO"] = drOrdenItem["AGNO"].ToString();
            dr["MES"] = drOrdenItem["MES"].ToString();
            dr["FECHA_CREACION"] = drOrdenItem["FECHA_CREACION"].ToString();
            dr["USUARIO"] = drOrdenItem["USUARIO"].ToString();
            dr["ESTADO"] = drOrdenItem["ESTADO"].ToString();

            dt.Rows.Add(dr);

            total = total + 1;

        }

        DataView MydataView;
        MydataView = new DataView(dt);
        migrilla.DataSource = MydataView;
        migrilla.DataBind();
        migrilla.Columns[0].Visible = false;

        lb_contador.Text = total + " calendario(s) encontrado(s)";

        GridViewRow gvRow;

        for (int i = 0; i < migrilla.Rows.Count; i++)
        {

            gvRow = migrilla.Rows[i];

            if (gvRow.Cells[6].Text.Equals("HABILITADO"))
            {
                gvRow.Cells[6].BackColor = System.Drawing.Color.LightGreen;


            }
            else
            {
                gvRow.Cells[6].BackColor = System.Drawing.Color.IndianRed;

            }

        }

    }

    public void carga_fechas_calendario(String id_calendario)
    {
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_CALENDARIO.CARGA_FECHAS_CALENDARIO", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_id_calendario", OracleType.Number, ParameterDirection.Input, id_calendario);

        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        DataTable dtOrdenes = new DataTable();

        try
        {
            CnOra.Open();

            da.Fill(dtOrdenes);
            CnOra.Close();
            CnOra.Dispose();
            lb_mensaje_fechas.Text = "";
        }
        catch (Exception ex)
        {
            lb_mensaje_fechas.ForeColor = System.Drawing.Color.Red;
            lb_mensaje_fechas.Text = ex.Message;
        }


        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("ID_FECHAS_CALENDARIO", typeof(String)));
        dt.Columns.Add(new DataColumn("PERIODO", typeof(String)));
        dt.Columns.Add(new DataColumn("FECHA_LECTURA", typeof(String)));
        dt.Columns.Add(new DataColumn("LOTE", typeof(String)));
        dt.Columns.Add(new DataColumn("FECHA_INICIO", typeof(String)));
        dt.Columns.Add(new DataColumn("FECHA_FIN", typeof(String)));
        dt.Columns.Add(new DataColumn("ESTADO", typeof(String)));

        DataRow dr;

        int total = 0;

        foreach (DataRow drOrdenItem in dtOrdenes.Rows)
        {

            dr = dt.NewRow();
            dr["ID_FECHAS_CALENDARIO"] = drOrdenItem["ID_FECHAS_CALENDARIO"].ToString();
            dr["PERIODO"] = drOrdenItem["PERIODO"].ToString();
            dr["FECHA_LECTURA"] = drOrdenItem["FECHA_LECTURA"].ToString();
            dr["LOTE"] = drOrdenItem["LOTE"].ToString();
            dr["FECHA_INICIO"] = drOrdenItem["FECHA_INICIO"].ToString();
            dr["FECHA_FIN"] = drOrdenItem["FECHA_FIN"].ToString();
            dr["ESTADO"] = drOrdenItem["ESTADO"].ToString();

            dt.Rows.Add(dr);

            total = total + 1;

        }

        DataView MydataView;
        MydataView = new DataView(dt);
        migrilla_fechas.DataSource = MydataView;
        migrilla_fechas.DataBind();
        migrilla_fechas.Columns[0].Visible = false;


        lb_contador_fechas.Text = total + " fecha(s) encontrada(s)";

        GridViewRow gvRow;

        for (int i = 0; i < migrilla.Rows.Count; i++)
        {

            gvRow = migrilla.Rows[i];

            if (gvRow.Cells[5].Text.Equals("HABILITADO"))
            {
                gvRow.Cells[5].BackColor = System.Drawing.Color.LightGreen;


            }
            else
            {
                gvRow.Cells[5].BackColor = System.Drawing.Color.IndianRed;

            }

        }

    }
   
    public void carga_agnos_nuevo()
    {
        try
        {
            int j = 0;
            int today_year = DateTime.Now.Year;
            int today_month = DateTime.Now.Month;
            String string_month = ""+today_month;
            if (today_month < 10) string_month = "0" + string_month;

            for (int year = today_year - 10; year <= today_year + 1; year++)
            {
                cb_agno_nuevo.Items.Add("" + year);
                cb_agno_nuevo.Items[j].Value = "" + year;
                j = j + 1;
            }

            cb_agno_nuevo.SelectedValue = "" + today_year;
            cb_periodo_nuevo.SelectedValue = string_month;

        }
        catch (Exception ex)
        {
        }
    }

    public void carga_agnos()
    {
        try
        {
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();

            objConexion.Open();
            objComando = new OracleDataAdapter("SELECT DISTINCT AGNO FROM CALENDARIO ORDER BY AGNO", objConexion);
            objComando.SelectCommand.CommandType = CommandType.Text;

            objComando.SelectCommand.ExecuteNonQuery();
            objComando.Fill(objDS, "AGNO");
            objConexion.Close();

            int i = 1;
            cb_agno.Items.Clear();
            cb_agno.Items.Add("TODOS...");
            cb_agno.Items[0].Value = "0";

            foreach (DataRow row in objDS.Tables["AGNO"].Rows)
            {
                cb_agno.Items.Add(row[0].ToString());
                cb_agno.Items[i].Value = row[0].ToString();
                i = i + 1;
            }

        }
        catch (Exception ex)
        {
        }
    }
   
    protected void gridOrden_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            var colsNoVisible = migrilla.DataKeys[migrilla.SelectedIndex].Values;           
            
        }
        catch (Exception ex)
        {

        }

    }

    protected void btn_buscar_Click(object sender, EventArgs e)
    {
        

    }

    protected void btn_nuevo_Click(object sender, EventArgs e)
    {
        main.Visible = false;
        calendario.Visible = true;
        botones_carga.Visible = true;
        titulo_edit.InnerText = "Nuevo Calendario";

        carga_agnos_nuevo();
        carga_fechas_calendario("0");
    }

   

       
   
    protected void btn_volver_Click(object sender, EventArgs e)
    {
        main.Visible = true;
        calendario.Visible = false;
        carga_calendarios(cb_agno.SelectedValue, cb_periodo.SelectedValue);
    }


    
    protected void gridOrden_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            int index = int.Parse(e.CommandArgument.ToString());
            var colsNoVisible = migrilla.DataKeys[index].Values;
            String id_calendario;

            id_calendario = (string)colsNoVisible[0];

            if (e.CommandName == "eliminar_calendario")
            {
                if (crud_calendario(id_calendario, "0", "0", "1", "3"))//delete crud-.
                {
                    carga_calendarios(cb_agno.SelectedValue, cb_periodo.SelectedValue);
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " correcto('Calendario eliminado!');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error('No se pudo eliminar el calendario!');", true);
                }


            }
            if (e.CommandName == "ver_calendario")
            {
                main.Visible = false;
                calendario.Visible = true;
                titulo_edit.InnerText = "Visor de calendario";
                botones_carga.Visible = false;
                carga_fechas_calendario(id_calendario);

            }     
            
        }
        catch (Exception ex)
        {
                       
        }
    }

    protected void btn_volver_bodegas_Click(object sender, EventArgs e)
    {
        main.Visible = true;
        calendario.Visible = false;
        carga_calendarios(cb_agno.SelectedValue, cb_periodo.SelectedValue);
    }

    
    
    protected void cb_region_bodegas_SelectedIndexChanged(object sender, EventArgs e)
    {
        
               
    }
    protected void cb_contratista_bodegas_SelectedIndexChanged(object sender, EventArgs e)
    {
               
    }
    protected void btn_cargar_click(object sender, EventArgs e)
    {
        String ruta = Server.MapPath("./TXT/" + fuArchivo.PostedFile.FileName);
        String ext = Path.GetExtension(fuArchivo.PostedFile.FileName).ToString();
        String result = carga_archivo(ruta, ext);
               

    }

    public String carga_archivo(String ruta,String extension)
    {              
        string result = "";
        if (!fuArchivo.HasFile) //no se ha seleccionado archivo?
        {
            result = "No ha seleccionado ningún archivo!";
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error('" + result + "');", true);
        } else {
            if (!extension.ToUpper().Contains(".CSV")) //solo csv.
            {
                result = "Se permiten solo archivos CSV!";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error('" + result + "');", true);
            }
            else
            {
                String agno = cb_agno_nuevo.SelectedValue.ToString();
                String mes = cb_periodo_nuevo.SelectedValue.ToString();
                String nuevo_calendario = get_calendario(agno + mes);

                if (nuevo_calendario.Equals(""))
                {
                    //NO SE PUDO CREAR EL CALENDARIO!
                    result = "Calendario no se pudo crear correctamente!";
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error('" + result + "');", true);
                }
                else if (!nuevo_calendario.Equals("0"))
                {
                    //YA EXISTE PERIODO
                    result = "Ya existe calendario para el periodo que intenta crear!";
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error('" + result + "');", true);
                }
                else //CORRECTO.
                {
                    
                    fuArchivo.SaveAs(ruta);
                    StreamReader sr = new StreamReader(ruta);
                    String data;
                    String[] array;
                    char[] separadores = { ';' };
                    int count = 0, countnull = 0, ok = 0;
                                     

                    crear_calendario(agno, mes);
                    nuevo_calendario = get_calendario(agno + mes);

                    //LEEMOS EL ARCHIVO.
                    while ((data = sr.ReadLine()) != null || countnull >= 10)
                    {
                        try
                        {
                            count++;
                            array = data.Split(separadores, StringSplitOptions.None);

                            DateTime temp;
                            int tempint;
                            if (DateTime.TryParse(array[4], out temp) && int.TryParse(array[0],out tempint))
                            {
                                DateTime desde = DateTime.Parse(array[4]).AddDays(-2);
                                DateTime hasta = DateTime.Parse(array[4]).AddDays(2);
                                String fecha_lectura = array[4], lote = array[0];
                                                                
                                if (lote.Length > 2) insertar_fecha(nuevo_calendario, lote, desde.ToString("dd-MM-yyyy"), hasta.ToString("dd-MM-yyyy"),fecha_lectura);
                                else
                                {
                                    if (lote.Length == 1) lote = "0" + lote;

                                    insertar_fecha(nuevo_calendario, "6"+lote, desde.ToString("dd-MM-yyyy"), hasta.ToString("dd-MM-yyyy"),fecha_lectura);
                                    insertar_fecha(nuevo_calendario, "7"+lote, desde.ToString("dd-MM-yyyy"), hasta.ToString("dd-MM-yyyy"),fecha_lectura);
                                    insertar_fecha(nuevo_calendario, "8"+lote, desde.ToString("dd-MM-yyyy"), hasta.ToString("dd-MM-yyyy"),fecha_lectura);
                                }
                                
                                ok++;
                            }
                            else
                            {
                                countnull++;
                                continue;
                            }


                        }
                        catch (Exception ex)
                        {
                            countnull++;
                            continue;
                        }
                    }

                    
                    try
                    {
                        

                        //CARGA LISTA..
                        sr.Close();
                        carga_fechas_calendario(nuevo_calendario);
                        if (migrilla_fechas.Rows.Count > 0)
                        {
                            result = "Calendario ingresado correctamente!";
                            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " correcto('" + result + "');", true);
                        }
                        else
                        {
                            result = "No se ha cargado ningún registro al calendario.!";
                            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error('" + result + "');", true);
                        }
                    }
                    catch (Exception ex)
                    {
                        result = "Calendario no se pudo crear correctamente!";
                        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error('" + result + "');", true);
                        crud_calendario(nuevo_calendario, "0", "0", "1", "3");
                        return result;
                    }
                    
                }
            }
        }
               
        
        return result;
    }

    //INSERTAMOS RANGO DE FECHAS DEL LOTE CON BLOQUEO.
    public Boolean insertar_fecha(String id_calendario,String lote, String menor, String mayor,String fecha_lectura)
    {
        OracleDataAdapter ComandoDA;
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        DataSet objDS = new DataSet();
        try
        {
            objConexion.Open();
            ComandoDA = new OracleDataAdapter("PK_CALENDARIO.INSERTA_FECHA", objConexion);

            PRO.agrega_parametro_sp(ComandoDA, "i_id_calendario", OracleType.Number, ParameterDirection.Input, id_calendario);
            PRO.agrega_parametro_sp(ComandoDA, "i_fecha_lectura", OracleType.NVarChar, ParameterDirection.Input, fecha_lectura);
            PRO.agrega_parametro_sp(ComandoDA, "i_desde", OracleType.NVarChar, ParameterDirection.Input, menor);
            PRO.agrega_parametro_sp(ComandoDA, "i_hasta", OracleType.NVarChar, ParameterDirection.Input, mayor);
            PRO.agrega_parametro_sp(ComandoDA, "i_lote", OracleType.Number, ParameterDirection.Input, lote);
            PRO.agrega_parametro_sp(ComandoDA, "i_id_usuario", OracleType.Number, ParameterDirection.Input, lb_id_usuario.Text);
            
            ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;
            ComandoDA.SelectCommand.ExecuteNonQuery();
            objConexion.Close();
            objConexion.Dispose();

            return true;
        }
        catch (Exception ex)
        {
            objConexion.Close();
            objConexion.Dispose();
        }
        
        return false;
    }

    public Boolean crear_calendario(String agno, String mes)
    {
        OracleDataAdapter ComandoDA;
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        DataSet objDS = new DataSet();
        try
        {
            objConexion.Open();
            ComandoDA = new OracleDataAdapter("PK_CALENDARIO.INSERTA_CALENDARIO", objConexion);

            PRO.agrega_parametro_sp(ComandoDA, "i_periodo", OracleType.NVarChar, ParameterDirection.Input, agno + mes);
            PRO.agrega_parametro_sp(ComandoDA, "i_agno", OracleType.NVarChar, ParameterDirection.Input, agno);
            PRO.agrega_parametro_sp(ComandoDA, "i_mes", OracleType.NVarChar, ParameterDirection.Input, mes);
            PRO.agrega_parametro_sp(ComandoDA, "i_id_usuario", OracleType.NVarChar, ParameterDirection.Input, lb_id_usuario.Text);

            ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;
            ComandoDA.SelectCommand.ExecuteNonQuery();
            objConexion.Close();
            objConexion.Dispose();

            return true;
        }
        catch (Exception ex)
        {
            objConexion.Close();
            objConexion.Dispose();            
        }        

        return false; 
    }

    //valida si el diametro existe
    public String get_calendario(string periodo)
    {
        String id_calendario = "";

        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();
        try
        {

            objConexion.Open();
            objComando = new OracleDataAdapter("SELECT ID_CALENDARIO FROM CALENDARIO WHERE PERIODO = '" + periodo + "'", objConexion);
            objComando.SelectCommand.CommandType = CommandType.Text;

            objComando.SelectCommand.ExecuteNonQuery();
            objComando.Fill(objDS, "CALENDARIO");
            objConexion.Close();
            objConexion.Dispose();


            id_calendario = "0";

            foreach (DataRow row in objDS.Tables["CALENDARIO"].Rows)
            {

                id_calendario = row[0].ToString();

            }

        }
        catch (Exception ex)
        {
            objConexion.Close();
            objConexion.Dispose();
        }


        return id_calendario; //vacio si da error, 0 si ya existe o el número del id si no existe periodo.
    }

    public Boolean crud_calendario(String id_calendario,String agno, String mes,String estado,String crud)
    {
        OracleDataAdapter ComandoDA;
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        DataSet objDS = new DataSet();
        try
        {
            objConexion.Open();
            ComandoDA = new OracleDataAdapter("PK_CALENDARIO.CRUD_CALENDARIO", objConexion);

            PRO.agrega_parametro_sp(ComandoDA, "i_id_calendario", OracleType.NVarChar, ParameterDirection.Input, id_calendario);
            PRO.agrega_parametro_sp(ComandoDA, "agno", OracleType.NVarChar, ParameterDirection.Input, agno);
            PRO.agrega_parametro_sp(ComandoDA, "mes", OracleType.NVarChar, ParameterDirection.Input, mes);
            PRO.agrega_parametro_sp(ComandoDA, "estado", OracleType.NVarChar, ParameterDirection.Input, estado);
            PRO.agrega_parametro_sp(ComandoDA, "usuario", OracleType.NVarChar, ParameterDirection.Input, lb_id_usuario.Text);
            PRO.agrega_parametro_sp(ComandoDA, "crud", OracleType.NVarChar, ParameterDirection.Input, crud);

            ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;
            ComandoDA.SelectCommand.ExecuteNonQuery();
            objConexion.Close();
            objConexion.Dispose();

            return true;
        }
        catch (Exception ex)
        {
            objConexion.Close();
            objConexion.Dispose();
        }

        return false;
    }

    protected void cb_agno_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_calendarios(cb_agno.SelectedValue, cb_periodo.SelectedValue);
    }
    protected void cb_periodo_SelectedIndexChanged(object sender, EventArgs e)
    {

        carga_calendarios(cb_agno.SelectedValue, cb_periodo.SelectedValue);
    }
}




class GFG : IComparer<int>
{
    public int Compare(int x, int y)
    {

        if (x == null || y == null)
        {
            return 0;
        }

        // "CompareTo()" method 
        return x.CompareTo(y);

    }
}