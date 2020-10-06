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
public partial class ArchivoSalida : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();

    String servicio, id, grupo, operador;
   

    protected void Page_Load(object sender, EventArgs e)
    {
        IMG2.Visible = false;
        IMG5.Visible = false;
        IMG6.Visible = false;
        lbResultado.Text = "";
        if (!Page.IsPostBack)
        {

         
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                PRO.recSession(rutaXml, "RUT_EMPRESA");

                txt_fecha_desde.Text = DateTime.Now.AddDays(-30).ToString("dd-MM-yyyy");                
                txt_fecha_hasta.Text = DateTime.Now.ToString("dd-MM-yyyy");
                carga_region();

                carga_zona(ddRegion.SelectedValue.ToString());
                carga_localidad(int.Parse(ddZona.SelectedValue));
                carga_Grupo(ddRegion.SelectedValue.ToString(), ddZona.SelectedValue.ToString(), ddLocalidad.SelectedValue.ToString(), PRO.recSession(rutaXml, "RUT_EMPRESA"));
                carga_salida(ddRegion.SelectedValue.ToString(), ddZona.SelectedValue.ToString(), ddLocalidad.SelectedValue.ToString(), ddGrupo.SelectedValue.ToString());
 
        }
       
    }

    public void carga_localidad(int zona)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_LOCALIDAD.CARGA_LOCALIDAD_SALIDA", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_zona", OracleType.Int32, ParameterDirection.Input, zona.ToString());
       

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "LOCALIDAD");
        objConexion.Close();

        int i = 1;
        ddLocalidad.Items.Clear();
        ddLocalidad.Items.Add("Todas...");
        ddLocalidad.Items[0].Value = "0";
        
        foreach (DataRow row in objDS.Tables["LOCALIDAD"].Rows)
        {
            if (row[1].ToString() == "TextBox") continue;
            ddLocalidad.Items.Add(row[1].ToString());
            ddLocalidad.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }


    public void carga_zona(String region)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_ZONA.CARGAR_ZONA_SALIDA", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
       
        PRO.agrega_parametro_sp(objComando, "i_idRegion", OracleType.Int32, ParameterDirection.Input, region);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "ZONA");
        objConexion.Close();

        int i = 1;
        ddZona.Items.Clear();
        ddZona.Items.Add("Todas...");
        ddZona.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["ZONA"].Rows)
        {

            ddZona.Items.Add(row[1].ToString());
            ddZona.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }

    public void carga_region()
    {
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
        String rutRegion=PRO.recSession(rutaXml, "RUT_EMPRESA");


        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_ZONA.CARGAR_REGION_SALIDA", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_rutEmpresa", OracleType.Number, ParameterDirection.Input, rutRegion);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "REGION");
        objConexion.Close();

        int i = 1;
        ddRegion.Items.Clear();
        ddRegion.Items.Add("Todas...");
        ddRegion.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["REGION"].Rows)
        {

            ddRegion.Items.Add(row[1].ToString());
            ddRegion.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }

    protected void ddGrupo_SelectedIndexChanged(object sender, EventArgs e)
    {

        tdSalida.InnerHtml = "";
        carga_salida(ddRegion.SelectedValue.ToString(), ddZona.SelectedValue.ToString(), ddLocalidad.SelectedValue.ToString(), ddGrupo.SelectedValue.ToString());


    }
    
    public void carga_Grupo(String region,String zona,String localidad,String empresa)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_PROCESO.CARGAR_GRUPO2", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_rutEmpresa", OracleType.Number, ParameterDirection.Input,empresa);
        PRO.agrega_parametro_sp(objComando, "i_idRegion", OracleType.Int32, ParameterDirection.Input, region);
        PRO.agrega_parametro_sp(objComando, "i_idZona", OracleType.Int32, ParameterDirection.Input, zona);
        PRO.agrega_parametro_sp(objComando, "i_idLocalidad", OracleType.Int32, ParameterDirection.Input, localidad);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "GRUPO");
        objConexion.Close();

        int i = 1;
        ddGrupo.Items.Clear();
        ddGrupo.Items.Add("Todos...");
        ddGrupo.Items[0].Value = "0";
        
        foreach (DataRow row in objDS.Tables["GRUPO"].Rows)
        {

            ddGrupo.Items.Add(row[1].ToString() + " - " + row[2].ToString() + " - " + row[3].ToString());
            ddGrupo.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }

    public void carga_salida_por_orden(String orden)
    {
        try
        {
            if (int.Parse(txt_nro_orden.Text) > 0)
            {
                 OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
                OracleCommand cmdAcceso = new OracleCommand("PK_SALIDA.CARGA_SALIDA_ORDEN", CnOra);
                OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                String generado = "0";

                if (rb_generadas.Checked == true)
                {
                    generado = "1";
                }
                else
                {
                    generado = "0";
                }

                PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
                PRO.agrega_parametro_sp(da, "i_empresa", OracleType.NVarChar, ParameterDirection.Input, PRO.recSession(rutaXml, "RUT_EMPRESA"));
                PRO.agrega_parametro_sp(da, "i_orden", OracleType.Int32, ParameterDirection.Input, orden);
                PRO.agrega_parametro_sp(da, "i_generado", OracleType.Int32, ParameterDirection.Input, generado);

                da.SelectCommand.CommandType = CommandType.StoredProcedure;

                DataTable dtOrdenes = new DataTable();

                try
                {
                    CnOra.Open();

                    da.Fill(dtOrdenes);
                    CnOra.Close();
                    CnOra.Dispose();
                }
                catch (Exception ex)
                {
                    IMG2.Visible = false;
                    IMG5.Visible = true;
                    IMG6.Visible = false;
                    lbResultado.Text = "Error al intentar generar archivo: " + ex.Message;
                }

                DataTable dt = new DataTable();
                dt.Columns.Add(new DataColumn("ID_LOCALIDAD", typeof(Int32)));
                dt.Columns.Add(new DataColumn("COD_LOCALIDAD", typeof(Int32)));
                dt.Columns.Add(new DataColumn("NOMBRE", typeof(String)));
                dt.Columns.Add(new DataColumn("SIN_ASIGNAR", typeof(Int32)));
                dt.Columns.Add(new DataColumn("ASIGNADAS_EN_PDA", typeof(Int32)));
                dt.Columns.Add(new DataColumn("ATENDIDAS", typeof(Int32)));
                dt.Columns.Add(new DataColumn("GENERADAS_EN_TXT", typeof(Int32)));
                dt.Columns.Add(new DataColumn("TOTAL", typeof(Int32)));



                DataRow dr;
                int cont = 0;

                int Otros = 0;
                int Sin_asignar = 0;

                int Asignadas = 0;
                int Atendidas = 0;
                int Generadas = 0;
                int total = 0;

                foreach (DataRow drOrdenItem in dtOrdenes.Rows)
                {

                    dr = dt.NewRow();
                    dr["ID_LOCALIDAD"] = drOrdenItem["ID_LOCALIDAD"].ToString();
                    dr["COD_LOCALIDAD"] = drOrdenItem["COD_LOCALIDAD"].ToString();
                    dr["NOMBRE"] = drOrdenItem["NOMBRE"].ToString();
                    dr["SIN_ASIGNAR"] = drOrdenItem["SIN_ASIGNAR"].ToString();
                    dr["ASIGNADAS_EN_PDA"] = drOrdenItem["ASIGNADAS_EN_PDA"].ToString();
                    dr["ATENDIDAS"] = drOrdenItem["ATENDIDAS"].ToString();
                    dr["GENERADAS_EN_TXT"] = drOrdenItem["GENERADAS_EN_TXT"].ToString();
                    dr["TOTAL"] = drOrdenItem["TOTAL"].ToString();


                    dt.Rows.Add(dr);

                    cont = cont + 1;

                    Otros = Otros + int.Parse(drOrdenItem["FALLOS"].ToString());
                    Sin_asignar = Sin_asignar + int.Parse(dr["SIN_ASIGNAR"].ToString());
                    Asignadas = Asignadas + int.Parse(dr["ASIGNADAS_EN_PDA"].ToString());
                    Atendidas = Atendidas + int.Parse(dr["ATENDIDAS"].ToString());
                    Generadas = Generadas + int.Parse(dr["GENERADAS_EN_TXT"].ToString());
                    total = total + int.Parse(dr["TOTAL"].ToString());

                }

                DataView MydataView;
                MydataView = new DataView(dt);
                gridSalida.DataSource = MydataView;
                gridSalida.DataBind();

                lbTotal.Text = cont + " registro(s) encontrado(s)";

                if (Otros > 0)
                {
                    lb_nota.Text = "Hay " + Otros + " órdenes con fallos, favor informar a informática para solucionar este problema.";
                    lb_nota.Visible = true;
                }
                else
                {
                    lb_nota.Text = "";
                    lb_nota.Visible = false;
                }


                txt_no_asignadas.Text = Sin_asignar.ToString();
                txt_asignadas.Text = Asignadas.ToString();
                txt_atendidas.Text = Atendidas.ToString();
                txt_generadas.Text = Generadas.ToString();

                txt_total.Text = total.ToString();

                gridSalida.Columns[0].Visible = false;
                lb_error_numero.Text = "";

            } else {
                
                lb_error_numero.Text = "Ingrese número mayor a 0";
            }
        }
        catch (Exception ex) 
        {
            lb_error_numero.Text = "Debe ingresar un número";
        }
        
       
    }

    public void carga_salida(String region,String zona,String localidad, String proceso)
    {
        
         DateTime dt1,dt2; //validar que sean fechas dd/MM/yyyy.
        if (DateTime.TryParse(txt_fecha_desde.Text, new System.Globalization.CultureInfo("en-GB"), System.Globalization.DateTimeStyles.None, out dt1) &&
            DateTime.TryParse(txt_fecha_hasta.Text, new System.Globalization.CultureInfo("en-GB"), System.Globalization.DateTimeStyles.None, out dt2))
        {
            if (dt1 <= dt2)
            {
                OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
                OracleCommand cmdAcceso = new OracleCommand("PK_SALIDA.CARGA_SALIDA", CnOra);
                OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                String generado = "0";
                String atendido = "0";

                if (rb_generadas.Checked == true)
                {
                    generado = "1";
                }
                else
                {
                    generado = "0";
                }

                if (rb_atendidas.Checked == true)
                {
                    atendido = "1";
                }
                else
                {
                    atendido = "0";
                }

                PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
                PRO.agrega_parametro_sp(da, "i_empresa", OracleType.NVarChar, ParameterDirection.Input, PRO.recSession(rutaXml, "RUT_EMPRESA"));
                PRO.agrega_parametro_sp(da, "i_idRegion", OracleType.Int32, ParameterDirection.Input, region);
                PRO.agrega_parametro_sp(da, "i_idZona", OracleType.Int32, ParameterDirection.Input, zona);
                PRO.agrega_parametro_sp(da, "i_idLocalidad", OracleType.Int32, ParameterDirection.Input, localidad);
                PRO.agrega_parametro_sp(da, "i_idProceso", OracleType.Int32, ParameterDirection.Input, proceso);
                PRO.agrega_parametro_sp(da, "i_generado", OracleType.Int32, ParameterDirection.Input, generado);
                PRO.agrega_parametro_sp(da, "i_atendido", OracleType.Int32, ParameterDirection.Input, atendido);
                PRO.agrega_parametro_sp(da, "i_fecha_desde", OracleType.NVarChar, ParameterDirection.Input, "05-AUG-2019");// txt_fecha_desde.Text);
                PRO.agrega_parametro_sp(da, "i_fecha_hasta", OracleType.NVarChar, ParameterDirection.Input, "06-AUG-2019");// txt_fecha_desde.Text);

                da.SelectCommand.CommandType = CommandType.StoredProcedure;

                DataTable dtOrdenes = new DataTable();

                try
                {
                    CnOra.Open();

                    da.Fill(dtOrdenes);
                    CnOra.Close();
                    CnOra.Dispose();
                }
                catch (Exception ex)
                {
                    IMG2.Visible = false;
                    IMG5.Visible = true;
                    IMG6.Visible = false;
                    lbResultado.Text = "Error al intentar generar archivo: " + ex.Message;
                }

                DataTable dt = new DataTable();
                dt.Columns.Add(new DataColumn("ID_LOCALIDAD", typeof(Int32)));
                dt.Columns.Add(new DataColumn("COD_LOCALIDAD", typeof(Int32)));
                dt.Columns.Add(new DataColumn("NOMBRE", typeof(String)));
                dt.Columns.Add(new DataColumn("SIN_ASIGNAR", typeof(Int32)));
                dt.Columns.Add(new DataColumn("ASIGNADAS_EN_PDA", typeof(Int32)));
                dt.Columns.Add(new DataColumn("ATENDIDAS", typeof(Int32)));
                dt.Columns.Add(new DataColumn("GENERADAS_EN_TXT", typeof(Int32)));
                dt.Columns.Add(new DataColumn("TOTAL", typeof(Int32)));



                DataRow dr;
                int cont = 0;

                int Otros = 0;
                int Sin_asignar = 0;

                int Asignadas = 0;
                int Atendidas = 0;
                int Generadas = 0;
                int total = 0;

                foreach (DataRow drOrdenItem in dtOrdenes.Rows)
                {

                    dr = dt.NewRow();
                    dr["ID_LOCALIDAD"] = drOrdenItem["ID_LOCALIDAD"].ToString();
                    dr["COD_LOCALIDAD"] = drOrdenItem["COD_LOCALIDAD"].ToString();
                    dr["NOMBRE"] = drOrdenItem["NOMBRE"].ToString();
                    dr["SIN_ASIGNAR"] = drOrdenItem["SIN_ASIGNAR"].ToString();
                    dr["ASIGNADAS_EN_PDA"] = drOrdenItem["ASIGNADAS_EN_PDA"].ToString();
                    dr["ATENDIDAS"] = drOrdenItem["ATENDIDAS"].ToString();
                    dr["GENERADAS_EN_TXT"] = drOrdenItem["GENERADAS_EN_TXT"].ToString();
                    dr["TOTAL"] = drOrdenItem["TOTAL"].ToString();


                    dt.Rows.Add(dr);

                    cont = cont + 1;

                    Otros = Otros + int.Parse(drOrdenItem["FALLOS"].ToString());
                    Sin_asignar = Sin_asignar + int.Parse(dr["SIN_ASIGNAR"].ToString());
                    Asignadas = Asignadas + int.Parse(dr["ASIGNADAS_EN_PDA"].ToString());
                    Atendidas = Atendidas + int.Parse(dr["ATENDIDAS"].ToString());
                    Generadas = Generadas + int.Parse(dr["GENERADAS_EN_TXT"].ToString());
                    total = total + int.Parse(dr["TOTAL"].ToString());

                }

                DataView MydataView;
                MydataView = new DataView(dt);
                gridSalida.DataSource = MydataView;
                gridSalida.DataBind();

                lbTotal.Text = cont + " registro(s) encontrado(s)";

                if (Otros > 0)
                {
                    lb_nota.Text = "Hay " + Otros + " órdenes con fallos, favor informar a informática para solucionar este problema.";
                    lb_nota.Visible = true;
                }
                else
                {
                    lb_nota.Text = "";
                    lb_nota.Visible = false;
                }


                txt_no_asignadas.Text = Sin_asignar.ToString();
                txt_asignadas.Text = Asignadas.ToString();
                txt_atendidas.Text = Atendidas.ToString();
                txt_generadas.Text = Generadas.ToString();

                txt_total.Text = total.ToString();

                gridSalida.Columns[0].Visible = false;
                lb_error_fechas.Text = "";
            }
            else
            {
                
                lb_error_fechas.Text = "Fecha inicial debe ser menor o igual a la final";
            }

        }
        else
        {
            lb_error_fechas.Text = "Ingreso de fechas inválido";
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        
        
        try
        {
            int atendidas = 0;
            int generadas = 0;

            for (int i = 0; i < gridSalida.Rows.Count; i++)
            {

                atendidas = atendidas + int.Parse(gridSalida.Rows[i].Cells[5].Text);
                generadas = generadas + int.Parse(gridSalida.Rows[i].Cells[6].Text);
            }


            IMG2.Visible = false;
            IMG5.Visible = false;
            IMG6.Visible = false;
            if (rb_generadas.Checked && generadas < 1)
            {
                IMG6.Visible = true;
                lbResultado.Text = "No existen ordenes generadas para volver a generar archivo.";
            }
            else if (!rb_generadas.Checked && atendidas < 1)
            {
                IMG6.Visible = true;
                lbResultado.Text = "No existen ordenes atendidas para generar archivo.";
            }  else
            {
                lbResultado.Text = "";

                if (rb_nro_orden.Checked)
                {
                    generarArchivo_por_orden(txt_nro_orden.Text);
                }
                else
                {
                    generarArchivo(ddRegion.SelectedValue.ToString(), ddZona.SelectedValue.ToString(), ddLocalidad.SelectedValue.ToString(), ddGrupo.SelectedValue);
                }


            }
        }
        catch (Exception ex)
        {
            IMG2.Visible = false;
            IMG5.Visible = true;
            IMG6.Visible = false;
            lbResultado.Text = "Error al intentar generar archivo: " + ex.Message;
        }

    }

    public void generarArchivo_por_orden(String orden)
    {

        if(validar_orden(txt_nro_orden.Text))
        {
             grupo = ddGrupo.SelectedItem.ToString();
                String[] arGrupo = grupo.Split('-');
                grupo = arGrupo[0];
                String salida;
                DataRow dr;
                int total = 0;
                String generado = "";
                String tipo_archivo = "";

                if (rb_generadas.Checked == true)
                {
                    generado = "1";
                    tipo_archivo = "G";

                }
                else
                {
                    tipo_archivo = "A";
                    generado = "0";
                }
                StreamWriter sr;

                OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
                OracleCommand cmdAcceso = new OracleCommand("PK_SALIDA.GENERA_TXT_ORDEN", CnOra);
                OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";



                PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
                PRO.agrega_parametro_sp(da, "i_empresa", OracleType.NVarChar, ParameterDirection.Input, PRO.recSession(rutaXml, "RUT_EMPRESA"));
                PRO.agrega_parametro_sp(da, "i_orden", OracleType.Int32, ParameterDirection.Input, orden);
                PRO.agrega_parametro_sp(da, "i_salida", OracleType.Int32, ParameterDirection.Input, generado);
                PRO.agrega_parametro_sp(da, "i_idUsuario", OracleType.NVarChar, ParameterDirection.Input, PRO.recSession(rutaXml, "ID_USUARIO"));


                da.SelectCommand.CommandType = CommandType.StoredProcedure;

                DataTable dtOrdenes = new DataTable();

                try
                {
                    CnOra.Open();

                    da.Fill(dtOrdenes);
                    CnOra.Close();
                    CnOra.Dispose();
                    
                    DataTable dt = new DataTable();
                    dt.Columns.Add(new DataColumn("NUMERO_ORDEN", typeof(String)));
                    dt.Columns.Add(new DataColumn("ID_SERVICIO", typeof(String)));
                    dt.Columns.Add(new DataColumn("RUTA", typeof(String)));
                    dt.Columns.Add(new DataColumn("COD_IMPROCEDENCIA", typeof(String)));
                    dt.Columns.Add(new DataColumn("LECTURA_RET", typeof(String)));
                    dt.Columns.Add(new DataColumn("FABRICANTE", typeof(String)));
                    dt.Columns.Add(new DataColumn("ANO_MN", typeof(String)));
                    dt.Columns.Add(new DataColumn("NUMERO_MN", typeof(String)));
                    dt.Columns.Add(new DataColumn("DIAMETRO_RET", typeof(String)));
                    dt.Columns.Add(new DataColumn("DIAMETRO_NU", typeof(String)));
                    dt.Columns.Add(new DataColumn("LECTURA_MN", typeof(String)));
                    dt.Columns.Add(new DataColumn("FECHA_INST", typeof(String)));
                    dt.Columns.Add(new DataColumn("COD_CONTRATISTA", typeof(String)));
                    dt.Columns.Add(new DataColumn("DESCRIPCION", typeof(String)));
                    dt.Columns.Add(new DataColumn("RESULTADO", typeof(String)));
                    dt.Columns.Add(new DataColumn("COD_VARAL", typeof(String)));
                    dt.Columns.Add(new DataColumn("MATERIAL_VARAL", typeof(String)));
                    dt.Columns.Add(new DataColumn("COD_LLAVE", typeof(String)));
                    dt.Columns.Add(new DataColumn("TIPO_LLAVE_PASO", typeof(String)));
                    dt.Columns.Add(new DataColumn("NUM_SELLO", typeof(String)));
                    dt.Columns.Add(new DataColumn("COLOR_SELLO", typeof(String)));
                    dt.Columns.Add(new DataColumn("RUT_CLIENTE", typeof(String)));
                    dt.Columns.Add(new DataColumn("OBSERVACION_OUT", typeof(String)));
                    dt.Columns.Add(new DataColumn("COD_INSTALADOR", typeof(String)));
                    dt.Columns.Add(new DataColumn("COD_MARCA", typeof(String)));

                    DateTime fecha = DateTime.Now;
                    String año = fecha.Year.ToString();
                    String mes = fecha.Month.ToString();
                    String dia = fecha.Day.ToString();
                    String hora = fecha.Hour.ToString();
                    String min = fecha.Minute.ToString();

                    if (fecha.Month <= 9)
                    {
                        mes = "0" + mes;
                    }

                    if (fecha.Day <= 9)
                    {
                        dia = "0" + dia;
                    }

                    Int32 i = 0;

                    String nombreSalida = "SM_" + PRO.recSession(rutaXml, "USERNAME").ToUpper() + "_" + dia + mes + año + "_" + i + ".txt";

                    do
                    {

                        i = i + 1;

                        nombreSalida = "SM_" + PRO.recSession(rutaXml, "USERNAME").ToUpper() + "_" + dia + mes + año + "_" + tipo_archivo + "_" + i + ".txt";
                    }
                    while (verificaArchivo(nombreSalida) == true);

                    sr = new StreamWriter(Server.MapPath("./TXT_SALIDA/" + nombreSalida));


                    foreach (DataRow drOrdenItem in dtOrdenes.Rows)
                    {

                        dr = dt.NewRow();
                        dr["NUMERO_ORDEN"] = drOrdenItem["NUMERO_ORDEN"].ToString();
                        dr["ID_SERVICIO"] = drOrdenItem["ID_SERVICIO"].ToString();
                        dr["RUTA"] = drOrdenItem["RUTA"].ToString();
                        dr["COD_IMPROCEDENCIA"] = drOrdenItem["COD_IMPROCEDENCIA"].ToString();


                        if (dr["COD_IMPROCEDENCIA"].Equals("24") || dr["COD_IMPROCEDENCIA"].Equals("25"))
                        {
                            dr["LECTURA_RET"] = drOrdenItem["LECTURA_RET"].ToString();
                            dr["FABRICANTE"] = drOrdenItem["FABRICANTE"].ToString();
                            dr["ANO_MN"] = drOrdenItem["ANO_MN"].ToString();

                            dr["NUMERO_MN"] = drOrdenItem["NUMERO_MN"].ToString();


                            do
                            {
                                dr["NUMERO_MN"] = "0" + dr["NUMERO_MN"];
                            }
                            while (dr["NUMERO_MN"].ToString().Length < 11);

                            dr["NUMERO_MN"] = drOrdenItem["COD_MARCA"].ToString() + dr["ANO_MN"] + dr["NUMERO_MN"];

                            dr["DIAMETRO_RET"] = drOrdenItem["DIAMETRO_RET"].ToString();
                            dr["DIAMETRO_NU"] = drOrdenItem["DIAMETRO_NU"].ToString();
                            dr["LECTURA_MN"] = drOrdenItem["LECTURA_MN"].ToString();

                            dr["FECHA_INST"] = Convert.ToDateTime(drOrdenItem["FECHA_INST"].ToString()).ToString("dd/MM/yy").Replace("-", "/");

                            //  txtFecha.Text = Convert.ToDateTime(drOrdenItem["FECHA_INST"].ToString()).ToString("dd/MM/yy");

                            dr["COD_CONTRATISTA"] = drOrdenItem["COD_CONTRATISTA"].ToString();
                            dr["DESCRIPCION"] = drOrdenItem["DESCRIPCION"].ToString();
                            dr["RESULTADO"] = drOrdenItem["RESULTADO"].ToString();
                            dr["COD_VARAL"] = drOrdenItem["COD_VARAL"].ToString();
                            dr["MATERIAL_VARAL"] = drOrdenItem["MATERIAL_VARAL"].ToString();
                            dr["COD_LLAVE"] = drOrdenItem["COD_LLAVE"].ToString();
                            dr["TIPO_LLAVE_PASO"] = drOrdenItem["TIPO_LLAVE_PASO"].ToString();
                            dr["NUM_SELLO"] = drOrdenItem["NUM_SELLO"].ToString();
                            dr["COLOR_SELLO"] = drOrdenItem["COLOR_SELLO"].ToString();
                            dr["RUT_CLIENTE"] = drOrdenItem["RUT_CLIENTE"].ToString();
                            dr["OBSERVACION_OUT"] = drOrdenItem["OBSERVACION_OUT"].ToString();
                            dr["COD_INSTALADOR"] = drOrdenItem["COD_INSTALADOR"].ToString();
                            //dr["GRUPO_PROCESO"] = drOrdenItem["GRUPO_PROCESO"].ToString();

                        }
                        else
                        {
                            dr["LECTURA_RET"] = "";
                            dr["FABRICANTE"] = "";
                            dr["ANO_MN"] = "";
                            dr["NUMERO_MN"] = "";
                            dr["DIAMETRO_RET"] = drOrdenItem["DIAMETRO_RET"].ToString();
                            dr["DIAMETRO_NU"] = "";
                            dr["LECTURA_MN"] = "";
                            dr["FECHA_INST"] = Convert.ToDateTime(drOrdenItem["FECHA_INST"].ToString()).ToString("dd/MM/yy").Replace("-", "/");
                            dr["COD_CONTRATISTA"] = drOrdenItem["COD_CONTRATISTA"].ToString();
                            dr["DESCRIPCION"] = "";
                            dr["RESULTADO"] = drOrdenItem["RESULTADO"].ToString();
                            dr["COD_VARAL"] = "";
                            dr["MATERIAL_VARAL"] = "";
                            dr["COD_LLAVE"] = "";
                            dr["TIPO_LLAVE_PASO"] = "";
                            dr["NUM_SELLO"] = "";
                            dr["COLOR_SELLO"] = "";
                            dr["RUT_CLIENTE"] = "";
                            dr["OBSERVACION_OUT"] = drOrdenItem["OBSERVACION_OUT"].ToString();
                            dr["COD_INSTALADOR"] = drOrdenItem["COD_INSTALADOR"].ToString();
                            //dr["GRUPO_PROCESO"] = drOrdenItem["GRUPO_PROCESO"].ToString();

                        }



                        total = total + 1;

                        salida = dr["NUMERO_ORDEN"] + ";"
                               + dr["ID_SERVICIO"] + ";"
                               + dr["RUTA"] + ";"
                               + dr["COD_IMPROCEDENCIA"] + ";"
                               + dr["LECTURA_RET"] + ";"
                               + dr["FABRICANTE"] + ";"
                               + dr["ANO_MN"] + ";"
                               + dr["NUMERO_MN"] + ";"
                               + dr["DIAMETRO_RET"] + ";"
                               + dr["DIAMETRO_NU"] + ";"
                               + dr["LECTURA_MN"] + ";"
                               + dr["FECHA_INST"] + ";"
                               + dr["COD_CONTRATISTA"] + ";"
                               + dr["DESCRIPCION"] + ";"
                               + dr["RESULTADO"] + ";"
                               + dr["COD_VARAL"] + ";"
                               + dr["MATERIAL_VARAL"] + ";"
                               + dr["COD_LLAVE"] + ";"
                               + dr["TIPO_LLAVE_PASO"] + ";"
                               + dr["NUM_SELLO"] + ";"
                               + dr["COLOR_SELLO"] + ";"
                               + dr["RUT_CLIENTE"] + ";"
                               + dr["OBSERVACION_OUT"] + ";"
                               + dr["COD_INSTALADOR"];

                        sr.WriteLine(salida);


                    }

                    sr.Close();

                    IMG2.Visible = true;
                    IMG5.Visible = false;
                    IMG6.Visible = false;

                    lbResultado.Text = "Archivo generado exitosamente.";

                    //HyperLink url_xml = new HyperLink();







                    ////SM_FCAMPOSM_17012017_1
                    //url_xml.NavigateUrl = "TXT_SALIDA/" + nombreSalida;
                    ////url_xml.Text = "DESCARGAR ORDENES" & VAR_SALIDA + FECHA_LECTURA + GRUPO & ""
                    //url_xml.Text = "DESCARGAR ORDENES";
                    //TableRow rowNew = new TableRow();
                    //TableCell cellNew = new TableCell();
                    //cellNew.Controls.Add(url_xml);
                    //rowNew.Controls.Add(cellNew);
                    //tbl_link.Controls.Add(rowNew);



                    String archivoSal = "TXT_SALIDA/" + nombreSalida;



                    tdSalida.InnerHtml = "<a href=\"" + archivoSal + "\" download=\"" + nombreSalida + "\">DESCARGAR ORDENES</a>";
                    lb_error_numero.Text = "";
                    //Download("TXT_SALIDA/" + nombreSalida);

                }
                catch (Exception ex)
                {
                    IMG2.Visible = false;
                    IMG5.Visible = true;
                    IMG6.Visible = false;

                    lbResultado.Text = "Error al intentar generar archivo: " + ex.Message;
                }
            
        } else {
            lb_error_numero.Text = "Ingrese un número";
        }
       
    }


        

    public void generarArchivo(String region, String zona, String localidad, String proceso)
    {

        DateTime dt1,dt2; //validar que sean fechas dd/MM/yyyy.
        if (DateTime.TryParse(txt_fecha_desde.Text, new System.Globalization.CultureInfo("en-GB"), System.Globalization.DateTimeStyles.None, out dt1) &&
            DateTime.TryParse(txt_fecha_hasta.Text, new System.Globalization.CultureInfo("en-GB"), System.Globalization.DateTimeStyles.None, out dt2))
        {
            if (dt1 <= dt2)
            {
                grupo = ddGrupo.SelectedItem.ToString();
                String[] arGrupo = grupo.Split('-');
                grupo = arGrupo[0];
                String salida;
                DataRow dr;
                int total = 0;
                String salidaGenerada = "";
                String tipo_archivo = "";
                String atendido = "0";

                if (rb_generadas.Checked == true)
                {
                    salidaGenerada = "1";
                    tipo_archivo = "G";

                }
                else
                {
                    tipo_archivo = "A";
                    salidaGenerada = "0";
                }

                if (rb_atendidas.Checked == true)
                {
                    atendido = "1";
                }
                else
                {
                    atendido = "0";
                }
                
                StreamWriter sr;

                OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
                OracleCommand cmdAcceso = new OracleCommand("PK_SALIDA.GENERA_TXT", CnOra);
                OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";



                PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
                PRO.agrega_parametro_sp(da, "i_empresa", OracleType.NVarChar, ParameterDirection.Input, PRO.recSession(rutaXml, "RUT_EMPRESA"));
                PRO.agrega_parametro_sp(da, "i_idRegion", OracleType.Int32, ParameterDirection.Input, region);
                PRO.agrega_parametro_sp(da, "i_idZona", OracleType.Int32, ParameterDirection.Input, zona);
                PRO.agrega_parametro_sp(da, "i_idLocalidad", OracleType.Int32, ParameterDirection.Input, localidad);
                PRO.agrega_parametro_sp(da, "i_proceso", OracleType.Int32, ParameterDirection.Input, proceso);
                PRO.agrega_parametro_sp(da, "i_salida", OracleType.Int32, ParameterDirection.Input, salidaGenerada);
                PRO.agrega_parametro_sp(da, "i_atendido", OracleType.Int32, ParameterDirection.Input, atendido);
                PRO.agrega_parametro_sp(da, "i_fecha_desde", OracleType.NVarChar, ParameterDirection.Input, txt_fecha_desde.Text);
                PRO.agrega_parametro_sp(da, "i_fecha_hasta", OracleType.NVarChar, ParameterDirection.Input, txt_fecha_hasta.Text);
                PRO.agrega_parametro_sp(da, "i_idUsuario", OracleType.NVarChar, ParameterDirection.Input, PRO.recSession(rutaXml, "ID_USUARIO"));

                da.SelectCommand.CommandType = CommandType.StoredProcedure;

                DataTable dtOrdenes = new DataTable();

                try
                {
                    CnOra.Open();

                    da.Fill(dtOrdenes);                   
                    CnOra.Close();
                    CnOra.Dispose();


                    DataTable dt = new DataTable();
                    dt.Columns.Add(new DataColumn("NUMERO_ORDEN", typeof(String)));
                    dt.Columns.Add(new DataColumn("ID_SERVICIO", typeof(String)));
                    dt.Columns.Add(new DataColumn("RUTA", typeof(String)));
                    dt.Columns.Add(new DataColumn("COD_IMPROCEDENCIA", typeof(String)));
                    dt.Columns.Add(new DataColumn("LECTURA_RET", typeof(String)));
                    dt.Columns.Add(new DataColumn("FABRICANTE", typeof(String)));
                    dt.Columns.Add(new DataColumn("ANO_MN", typeof(String)));
                    dt.Columns.Add(new DataColumn("NUMERO_MN", typeof(String)));
                    dt.Columns.Add(new DataColumn("DIAMETRO_RET", typeof(String)));
                    dt.Columns.Add(new DataColumn("DIAMETRO_NU", typeof(String)));
                    dt.Columns.Add(new DataColumn("LECTURA_MN", typeof(String)));
                    dt.Columns.Add(new DataColumn("FECHA_INST", typeof(String)));
                    dt.Columns.Add(new DataColumn("COD_CONTRATISTA", typeof(String)));
                    dt.Columns.Add(new DataColumn("DESCRIPCION", typeof(String)));
                    dt.Columns.Add(new DataColumn("RESULTADO", typeof(String)));
                    dt.Columns.Add(new DataColumn("COD_VARAL", typeof(String)));
                    dt.Columns.Add(new DataColumn("MATERIAL_VARAL", typeof(String)));
                    dt.Columns.Add(new DataColumn("COD_LLAVE", typeof(String)));
                    dt.Columns.Add(new DataColumn("TIPO_LLAVE_PASO", typeof(String)));
                    dt.Columns.Add(new DataColumn("NUM_SELLO", typeof(String)));
                    dt.Columns.Add(new DataColumn("COLOR_SELLO", typeof(String)));
                    dt.Columns.Add(new DataColumn("RUT_CLIENTE", typeof(String)));
                    dt.Columns.Add(new DataColumn("OBSERVACION_OUT", typeof(String)));
                    dt.Columns.Add(new DataColumn("COD_INSTALADOR", typeof(String)));
                    dt.Columns.Add(new DataColumn("COD_MARCA", typeof(String)));

                    DateTime fecha = DateTime.Now;
                    String año = fecha.Year.ToString();
                    String mes = fecha.Month.ToString();
                    String dia = fecha.Day.ToString();
                    String hora = fecha.Hour.ToString();
                    String min = fecha.Minute.ToString();

                    if (fecha.Month <= 9)
                    {
                        mes = "0" + mes;
                    }

                    if (fecha.Day <= 9)
                    {
                        dia = "0" + dia;
                    }

                    Int32 i = 0;

                    String nombreSalida = "SM_" + PRO.recSession(rutaXml, "USERNAME").ToUpper() + "_" + dia + mes + año + "_" + i + ".txt";

                    do
                    {

                        i = i + 1;

                        nombreSalida = "SM_" + PRO.recSession(rutaXml, "USERNAME").ToUpper() + "_" + dia + mes + año + "_" + tipo_archivo + "_" + i + ".txt";
                    }
                    while (verificaArchivo(nombreSalida) == true);

                    sr = new StreamWriter(Server.MapPath("./TXT_SALIDA/" + nombreSalida));


                    foreach (DataRow drOrdenItem in dtOrdenes.Rows)
                    {

                        dr = dt.NewRow();
                        dr["NUMERO_ORDEN"] = drOrdenItem["NUMERO_ORDEN"].ToString();
                        dr["ID_SERVICIO"] = drOrdenItem["ID_SERVICIO"].ToString();
                        dr["RUTA"] = drOrdenItem["RUTA"].ToString();
                        dr["COD_IMPROCEDENCIA"] = drOrdenItem["COD_IMPROCEDENCIA"].ToString();


                        if (dr["COD_IMPROCEDENCIA"].Equals("24") || dr["COD_IMPROCEDENCIA"].Equals("25"))
                        {
                            dr["LECTURA_RET"] = drOrdenItem["LECTURA_RET"].ToString();
                            dr["FABRICANTE"] = drOrdenItem["FABRICANTE"].ToString().Trim();
                            dr["ANO_MN"] = drOrdenItem["ANO_MN"].ToString();

                            dr["NUMERO_MN"] = drOrdenItem["NUMERO_MN"].ToString();


                            do
                            {
                                dr["NUMERO_MN"] = "0" + dr["NUMERO_MN"];
                            }
                            while (dr["NUMERO_MN"].ToString().Length < 11);

                            dr["NUMERO_MN"] = drOrdenItem["COD_MARCA"].ToString() + dr["ANO_MN"] + dr["NUMERO_MN"];

                            dr["DIAMETRO_RET"] = drOrdenItem["DIAMETRO_RET"].ToString();
                            dr["DIAMETRO_NU"] = drOrdenItem["DIAMETRO_NU"].ToString();
                            dr["LECTURA_MN"] = drOrdenItem["LECTURA_MN"].ToString();

                            dr["FECHA_INST"] = Convert.ToDateTime(drOrdenItem["FECHA_INST"].ToString()).ToString("dd/MM/yy").Replace("-", "/");

                            //  txtFecha.Text = Convert.ToDateTime(drOrdenItem["FECHA_INST"].ToString()).ToString("dd/MM/yy");

                            dr["COD_CONTRATISTA"] = drOrdenItem["COD_CONTRATISTA"].ToString();
                            dr["DESCRIPCION"] = drOrdenItem["DESCRIPCION"].ToString();
                            dr["RESULTADO"] = drOrdenItem["RESULTADO"].ToString();
                            dr["COD_VARAL"] = drOrdenItem["COD_VARAL"].ToString();
                            dr["MATERIAL_VARAL"] = drOrdenItem["MATERIAL_VARAL"].ToString();
                            dr["COD_LLAVE"] = drOrdenItem["COD_LLAVE"].ToString();
                            dr["TIPO_LLAVE_PASO"] = drOrdenItem["TIPO_LLAVE_PASO"].ToString();
                            dr["NUM_SELLO"] = drOrdenItem["NUM_SELLO"].ToString();
                            dr["COLOR_SELLO"] = drOrdenItem["COLOR_SELLO"].ToString();
                            dr["RUT_CLIENTE"] = drOrdenItem["RUT_CLIENTE"].ToString();
                            dr["OBSERVACION_OUT"] = drOrdenItem["OBSERVACION_OUT"].ToString();
                            dr["COD_INSTALADOR"] = drOrdenItem["COD_INSTALADOR"].ToString();
                            //dr["GRUPO_PROCESO"] = drOrdenItem["GRUPO_PROCESO"].ToString();

                        }
                        else
                        {
                            dr["LECTURA_RET"] = "";
                            dr["FABRICANTE"] = "";
                            dr["ANO_MN"] = "";
                            dr["NUMERO_MN"] = "";
                            dr["DIAMETRO_RET"] = drOrdenItem["DIAMETRO_RET"].ToString();
                            dr["DIAMETRO_NU"] = "";
                            dr["LECTURA_MN"] = "";
                            dr["FECHA_INST"] = Convert.ToDateTime(drOrdenItem["FECHA_INST"].ToString()).ToString("dd/MM/yy").Replace("-", "/");
                            dr["COD_CONTRATISTA"] = drOrdenItem["COD_CONTRATISTA"].ToString();
                            dr["DESCRIPCION"] = "";
                            dr["RESULTADO"] = drOrdenItem["RESULTADO"].ToString();
                            dr["COD_VARAL"] = "";
                            dr["MATERIAL_VARAL"] = "";
                            dr["COD_LLAVE"] = "";
                            dr["TIPO_LLAVE_PASO"] = "";
                            dr["NUM_SELLO"] = "";
                            dr["COLOR_SELLO"] = "";
                            dr["RUT_CLIENTE"] = "";
                            dr["OBSERVACION_OUT"] = drOrdenItem["OBSERVACION_OUT"].ToString();
                            dr["COD_INSTALADOR"] = drOrdenItem["COD_INSTALADOR"].ToString();
                            //dr["GRUPO_PROCESO"] = drOrdenItem["GRUPO_PROCESO"].ToString();

                        }



                        total = total + 1;

                        salida = dr["NUMERO_ORDEN"] + ";"
                               + dr["ID_SERVICIO"] + ";"
                               + dr["RUTA"] + ";"
                               + dr["COD_IMPROCEDENCIA"] + ";"
                               + dr["LECTURA_RET"] + ";"
                               + dr["FABRICANTE"] +";"
                               + dr["ANO_MN"] + ";"
                               + dr["NUMERO_MN"] + ";"
                               + dr["DIAMETRO_RET"] + ";"
                               + dr["DIAMETRO_NU"] + ";"
                               + dr["LECTURA_MN"] + ";"
                               + dr["FECHA_INST"] + ";"
                               + dr["COD_CONTRATISTA"] + ";"
                               + dr["DESCRIPCION"] + ";"
                               + dr["RESULTADO"] + ";"
                               + dr["COD_VARAL"] + ";"
                               + dr["MATERIAL_VARAL"] + ";"
                               + dr["COD_LLAVE"] + ";"
                               + dr["TIPO_LLAVE_PASO"] + ";"
                               + dr["NUM_SELLO"] + ";"
                               + dr["COLOR_SELLO"] + ";"
                               + dr["RUT_CLIENTE"] + ";"
                               + dr["OBSERVACION_OUT"] + ";"
                               + dr["COD_INSTALADOR"];

                        sr.WriteLine(salida);


                    }

                    sr.Close();

                    IMG2.Visible = true;
                    IMG5.Visible = false;
                    IMG6.Visible = false;

                    lbResultado.Text = "Archivo generado exitosamente.";

                    //HyperLink url_xml = new HyperLink();







                    ////SM_FCAMPOSM_17012017_1
                    //url_xml.NavigateUrl = "TXT_SALIDA/" + nombreSalida;
                    ////url_xml.Text = "DESCARGAR ORDENES" & VAR_SALIDA + FECHA_LECTURA + GRUPO & ""
                    //url_xml.Text = "DESCARGAR ORDENES";
                    //TableRow rowNew = new TableRow();
                    //TableCell cellNew = new TableCell();
                    //cellNew.Controls.Add(url_xml);
                    //rowNew.Controls.Add(cellNew);
                    //tbl_link.Controls.Add(rowNew);



                    String archivoSal = "TXT_SALIDA/" + nombreSalida;



                    tdSalida.InnerHtml = "<a href=\"" + archivoSal + "\" download=\"" + nombreSalida + "\">DESCARGAR ORDENES</a>";
                    lb_error_fechas.Text = "";
                    //Download("TXT_SALIDA/" + nombreSalida);

                }
                catch (Exception ex)
                {
                    IMG2.Visible = false;
                    IMG5.Visible = true;
                    IMG6.Visible = false;

                    lbResultado.Text = "Error al intentar generar archivo: " + ex.Message;
                }
            }            
            else
            {
                
                lb_error_fechas.Text = "Fecha inicial debe ser menor o igual a la final";
            }

        }
        else
        {
            lb_error_fechas.Text = "Ingreso de fechas inválido";
        }
     
    }


    public void generarArchivoFull()
    {
       
        String salida;
        DataRow dr;
        int total = 0;

        StreamWriter sr;

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_ORDEN.TXT_SALIDA_FULL", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_empresa", OracleType.NVarChar, ParameterDirection.Input, PRO.recSession(rutaXml, "RUT_EMPRESA"));



        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        DataTable dtOrdenes = new DataTable();

        try
        {
            CnOra.Open();

            da.Fill(dtOrdenes);
            CnOra.Close();
            CnOra.Dispose();


            DataTable dt = new DataTable();
            dt.Columns.Add(new DataColumn("NUMERO_ORDEN", typeof(String)));
            dt.Columns.Add(new DataColumn("ID_SERVICIO", typeof(String)));
            dt.Columns.Add(new DataColumn("RUTA", typeof(String)));
            dt.Columns.Add(new DataColumn("COD_IMPROCEDENCIA", typeof(String)));
            dt.Columns.Add(new DataColumn("LECTURA_RET", typeof(String)));
            dt.Columns.Add(new DataColumn("FABRICANTE", typeof(String)));
            dt.Columns.Add(new DataColumn("ANO_MN", typeof(String)));
            dt.Columns.Add(new DataColumn("NUMERO_MN", typeof(String)));
            dt.Columns.Add(new DataColumn("DIAMETRO_RET", typeof(String)));
            dt.Columns.Add(new DataColumn("DIAMETRO_NU", typeof(String)));
            dt.Columns.Add(new DataColumn("LECTURA_MN", typeof(String)));
            dt.Columns.Add(new DataColumn("FECHA_INST", typeof(String)));
            dt.Columns.Add(new DataColumn("COD_CONTRATISTA", typeof(String)));
            dt.Columns.Add(new DataColumn("DESCRIPCION", typeof(String)));
            dt.Columns.Add(new DataColumn("RESULTADO", typeof(String)));
            dt.Columns.Add(new DataColumn("COD_VARAL", typeof(String)));
            dt.Columns.Add(new DataColumn("MATERIAL_VARAL", typeof(String)));
            dt.Columns.Add(new DataColumn("COD_LLAVE", typeof(String)));
            dt.Columns.Add(new DataColumn("TIPO_LLAVE_PASO", typeof(String)));
            dt.Columns.Add(new DataColumn("NUM_SELLO", typeof(String)));
            dt.Columns.Add(new DataColumn("COLOR_SELLO", typeof(String)));
            dt.Columns.Add(new DataColumn("RUT_CLIENTE", typeof(String)));
            dt.Columns.Add(new DataColumn("OBSERVACION_OUT", typeof(String)));
            dt.Columns.Add(new DataColumn("COD_INSTALADOR", typeof(String)));
            dt.Columns.Add(new DataColumn("COD_MARCA", typeof(String)));

            DateTime fecha = DateTime.Now;
            String año = fecha.Year.ToString();
            String mes = fecha.Month.ToString();
            String dia = fecha.Day.ToString();
            String hora = fecha.Hour.ToString();
            String min = fecha.Minute.ToString();

            if (fecha.Month <= 9)
            {
                mes = "0" + mes;
            }

            if (fecha.Day <= 9)
            {
                dia = "0" + dia;
            }

            Int32 i = 0;

            String nombreSalida = "SM_" + PRO.recSession(rutaXml, "USERNAME").ToUpper() + "_" + dia + mes + año + "_" + i + ".txt";

            do
            {

                i = i + 1;

                nombreSalida = "SM_" + PRO.recSession(rutaXml, "USERNAME").ToUpper() + "_" + dia + mes + año + "_" + i + ".txt";
            }
            while (verificaArchivo(nombreSalida) == true);

            sr = new StreamWriter(Server.MapPath("./TXT_SALIDA/" + nombreSalida));


            foreach (DataRow drOrdenItem in dtOrdenes.Rows)
            {

                dr = dt.NewRow();
                dr["NUMERO_ORDEN"] = drOrdenItem["NUMERO_ORDEN"].ToString();
                dr["ID_SERVICIO"] = drOrdenItem["ID_SERVICIO"].ToString();
                dr["RUTA"] = drOrdenItem["RUTA"].ToString();
                dr["COD_IMPROCEDENCIA"] = drOrdenItem["COD_IMPROCEDENCIA"].ToString();


                if (dr["COD_IMPROCEDENCIA"].Equals("24") || dr["COD_IMPROCEDENCIA"].Equals("25"))
                {
                    dr["LECTURA_RET"] = drOrdenItem["LECTURA_RET"].ToString();
                    dr["FABRICANTE"] = drOrdenItem["FABRICANTE"].ToString();
                    dr["ANO_MN"] = drOrdenItem["ANO_MN"].ToString();

                    dr["NUMERO_MN"] = drOrdenItem["NUMERO_MN"].ToString();


                    do
                    {
                        dr["NUMERO_MN"] = "0" + dr["NUMERO_MN"];
                    }
                    while (dr["NUMERO_MN"].ToString().Length < 11);

                    dr["NUMERO_MN"] = drOrdenItem["COD_MARCA"].ToString() + dr["ANO_MN"] + dr["NUMERO_MN"];

                    dr["DIAMETRO_RET"] = drOrdenItem["DIAMETRO_RET"].ToString();
                    dr["DIAMETRO_NU"] = drOrdenItem["DIAMETRO_NU"].ToString();
                    dr["LECTURA_MN"] = drOrdenItem["LECTURA_MN"].ToString();

                    dr["FECHA_INST"] = Convert.ToDateTime(drOrdenItem["FECHA_INST"].ToString()).ToString("dd/MM/yy").Replace("-", "/");

                    //  txtFecha.Text = Convert.ToDateTime(drOrdenItem["FECHA_INST"].ToString()).ToString("dd/MM/yy");

                    dr["COD_CONTRATISTA"] = drOrdenItem["COD_CONTRATISTA"].ToString();
                    dr["DESCRIPCION"] = drOrdenItem["DESCRIPCION"].ToString();
                    dr["RESULTADO"] = drOrdenItem["RESULTADO"].ToString();
                    dr["COD_VARAL"] = drOrdenItem["COD_VARAL"].ToString();
                    dr["MATERIAL_VARAL"] = drOrdenItem["MATERIAL_VARAL"].ToString();
                    dr["COD_LLAVE"] = drOrdenItem["COD_LLAVE"].ToString();
                    dr["TIPO_LLAVE_PASO"] = drOrdenItem["TIPO_LLAVE_PASO"].ToString();
                    dr["NUM_SELLO"] = drOrdenItem["NUM_SELLO"].ToString();
                    dr["COLOR_SELLO"] = drOrdenItem["COLOR_SELLO"].ToString();
                    dr["RUT_CLIENTE"] = drOrdenItem["RUT_CLIENTE"].ToString();
                    dr["OBSERVACION_OUT"] = drOrdenItem["OBSERVACION_OUT"].ToString();
                    dr["COD_INSTALADOR"] = drOrdenItem["COD_INSTALADOR"].ToString();
                    //dr["GRUPO_PROCESO"] = drOrdenItem["GRUPO_PROCESO"].ToString();

                }
                else
                {
                    dr["LECTURA_RET"] = "";
                    dr["FABRICANTE"] = "";
                    dr["ANO_MN"] = "";
                    dr["NUMERO_MN"] = "";
                    dr["DIAMETRO_RET"] = drOrdenItem["DIAMETRO_RET"].ToString();
                    dr["DIAMETRO_NU"] = "";
                    dr["LECTURA_MN"] = "";
                    dr["FECHA_INST"] = Convert.ToDateTime(drOrdenItem["FECHA_INST"].ToString()).ToString("dd/MM/yy").Replace("-", "/");
                    dr["COD_CONTRATISTA"] = drOrdenItem["COD_CONTRATISTA"].ToString();
                    dr["DESCRIPCION"] = "";
                    dr["RESULTADO"] = drOrdenItem["RESULTADO"].ToString();
                    dr["COD_VARAL"] = "";
                    dr["MATERIAL_VARAL"] = "";
                    dr["COD_LLAVE"] = "";
                    dr["TIPO_LLAVE_PASO"] = "";
                    dr["NUM_SELLO"] = "";
                    dr["COLOR_SELLO"] = "";
                    dr["RUT_CLIENTE"] = "";
                    dr["OBSERVACION_OUT"] = drOrdenItem["OBSERVACION_OUT"].ToString();
                    dr["COD_INSTALADOR"] = drOrdenItem["COD_INSTALADOR"].ToString();
                    //dr["GRUPO_PROCESO"] = drOrdenItem["GRUPO_PROCESO"].ToString();

                }



                total = total + 1;

                salida = dr["NUMERO_ORDEN"] + ";"
                       + dr["ID_SERVICIO"] + ";"
                       + dr["RUTA"] + ";"
                       + dr["COD_IMPROCEDENCIA"] + ";"
                       + dr["LECTURA_RET"] + ";"
                       + dr["FABRICANTE"] + ";"
                       + dr["ANO_MN"] + ";"
                       + dr["NUMERO_MN"] + ";"
                       + dr["DIAMETRO_RET"] + ";"
                       + dr["DIAMETRO_NU"] + ";"
                       + dr["LECTURA_MN"] + ";"
                       + dr["FECHA_INST"] + ";"
                       + dr["COD_CONTRATISTA"] + ";"
                       + dr["DESCRIPCION"] + ";"
                       + dr["RESULTADO"] + ";"
                       + dr["COD_VARAL"] + ";"
                       + dr["MATERIAL_VARAL"] + ";"
                       + dr["COD_LLAVE"] + ";"
                       + dr["TIPO_LLAVE_PASO"] + ";"
                       + dr["NUM_SELLO"] + ";"
                       + dr["COLOR_SELLO"] + ";"
                       + dr["RUT_CLIENTE"] + ";"
                       + dr["OBSERVACION_OUT"] + ";"
                       + dr["COD_INSTALADOR"];

                sr.WriteLine(salida);


            }

            sr.Close();

            IMG2.Visible = true;
            IMG5.Visible = false;
            IMG6.Visible = false;

            lbResultado.Text = "Archivo generado exitosamente.";

            //HyperLink url_xml = new HyperLink();

            ////SM_FCAMPOSM_17012017_1
            //url_xml.NavigateUrl = "TXT_SALIDA/" + nombreSalida;
            ////url_xml.Text = "DESCARGAR ORDENES" & VAR_SALIDA + FECHA_LECTURA + GRUPO & ""
            //url_xml.Text = "DESCARGAR ORDENES";
            //TableRow rowNew = new TableRow();
            //TableCell cellNew = new TableCell();
            //cellNew.Controls.Add(url_xml);
            //rowNew.Controls.Add(cellNew);
            //tbl_link.Controls.Add(rowNew);



            String archivoSal = "TXT_SALIDA/" + nombreSalida;



            tdSalida.InnerHtml = "<a href=\"" + archivoSal + "\" download=\"" + nombreSalida + "\">DESCARGAR ORDENES</a>";

            //Download("TXT_SALIDA/" + nombreSalida);

        }
        catch (Exception ex)
        {
            IMG2.Visible = false;
            IMG5.Visible = true;
            IMG6.Visible = false;

            lbResultado.Text = "Error al intentar generar archivo: " + ex.Message;
        }




    }
    //static public void Download(String patch)
    static public void Download()
    {


        String patch = "SM_rsalgado_20012017_13.txt";


        System.IO.FileInfo toDownload =
                   new System.IO.FileInfo(HttpContext.Current.Server.MapPath(patch));

        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.AddHeader("Content-Disposition",
                   "attachment; filename=" + toDownload.Name);
        HttpContext.Current.Response.AddHeader("Content-Length",
                   toDownload.Length.ToString());
        HttpContext.Current.Response.ContentType = "application/octet-stream";
        HttpContext.Current.Response.WriteFile(patch);
        HttpContext.Current.Response.End();
    }


    public Boolean verificaArchivo(String nombre)
    {
       Boolean existe=false;

        


        if (File.Exists(Server.MapPath("./TXT_SALIDA/"+nombre)))
        {
            existe=true;
       
        }

        return existe;

      

    }
    protected void ddZona_SelectedIndexChanged(object sender, EventArgs e)
    {
        tdSalida.InnerHtml = "";
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";

      
        carga_localidad(int.Parse(ddZona.SelectedValue));
        carga_Grupo(ddRegion.SelectedValue.ToString(), ddZona.SelectedValue.ToString(), ddLocalidad.SelectedValue.ToString(), PRO.recSession(rutaXml, "RUT_EMPRESA"));
        carga_salida(ddRegion.SelectedValue.ToString(), ddZona.SelectedValue.ToString(), ddLocalidad.SelectedValue.ToString(), ddGrupo.SelectedValue.ToString());
    }
    protected void ddLocalidad_SelectedIndexChanged(object sender, EventArgs e)
    {
        tdSalida.InnerHtml = "";
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
        carga_Grupo(ddRegion.SelectedValue.ToString(), ddZona.SelectedValue.ToString(), ddLocalidad.SelectedValue.ToString(), PRO.recSession(rutaXml, "RUT_EMPRESA"));
        carga_salida(ddRegion.SelectedValue.ToString(), ddZona.SelectedValue.ToString(), ddLocalidad.SelectedValue.ToString(), ddGrupo.SelectedValue.ToString());
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        String filename = "SM_rsalgado_20012017_13.txt";

   if ( !String.IsNullOrEmpty(filename) )
   { 
      String dlDir = @"TXT_SALIDA/";
      String path = Server.MapPath(dlDir + filename);

      System.IO.FileInfo toDownload =
                   new System.IO.FileInfo(path);

      if (toDownload.Exists)
      {
         Response.Clear(); 
         Response.AddHeader("Content-Disposition",
                    "attachment; filename=" + toDownload.Name);
         Response.AddHeader("Content-Length", 
                    toDownload.Length.ToString());
         Response.ContentType = "application/octet-stream";
         Response.WriteFile(dlDir + filename);
         Response.End();
      } 
   } 
    }
    protected void ddRegion_SelectedIndexChanged(object sender, EventArgs e)
    {
        tdSalida.InnerHtml = "";
        
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";

        carga_zona(ddRegion.SelectedValue.ToString());
        carga_localidad(int.Parse(ddZona.SelectedValue));
        carga_Grupo(ddRegion.SelectedValue.ToString(), ddZona.SelectedValue.ToString(),ddLocalidad.SelectedValue.ToString(), PRO.recSession(rutaXml, "RUT_EMPRESA"));
        carga_salida(ddRegion.SelectedValue.ToString(), ddZona.SelectedValue.ToString(), ddLocalidad.SelectedValue.ToString(), ddGrupo.SelectedValue.ToString());

    }
    

        //HABILITA O DESHABILITA CONTROLES PARA GENERAR SALIDA POR NRO ORDEN ESPECIFICA.
       protected void control_x_orden(Boolean estado)
       {
           if (estado)
           {
               ddGrupo.Enabled = false;
               ddZona.Enabled = false;
               ddLocalidad.Enabled = false;
               ddRegion.Enabled = false;
               txt_fecha_desde.Enabled = false;
               txt_fecha_hasta.Enabled = false;
               rb_atendidas.Enabled = false;

               txt_nro_orden.Enabled = true;
           }
           else 
           {
               ddGrupo.Enabled = true;
               ddZona.Enabled = true;
               ddLocalidad.Enabled = true;
               ddRegion.Enabled = true;
               txt_fecha_desde.Enabled = true;
               txt_fecha_hasta.Enabled = true;
               rb_atendidas.Enabled = true;

               txt_nro_orden.Enabled = false;
           }

           
       }

       //public String validar_fechas(String desde, String hasta) 
       //{
       //     DateTime dt1,dt2; //validar que sean fechas dd/MM/yyyy.
       //     if (DateTime.TryParse(desde, new System.Globalization.CultureInfo("en-GB"), System.Globalization.DateTimeStyles.None, out dt1) &&
       //         DateTime.TryParse(hasta, new System.Globalization.CultureInfo("en-GB"), System.Globalization.DateTimeStyles.None, out dt2))
       //     {
       //         if (dt1 <= dt2)
       //         {
       //             return "ok";
       //         }
       //         else
       //         {
       //             return "inical mayor que final";
       //         }
       //     }
       //     else
       //     {
       //         return "inválida";
       //     }
       //}

       public Boolean validar_orden(String orden)
       {
           int num;
           try
           {
               num = int.Parse(orden);
               if (num > 0) return true;
               return false;
           }
           catch {
               return false;
           }

       }
           
       protected void rb_nro_orden_CheckedChanged(object sender, EventArgs e)
       {
           control_x_orden(rb_nro_orden.Checked);
           tdSalida.InnerHtml = "";
           carga_salida(ddRegion.SelectedValue.ToString(), ddZona.SelectedValue.ToString(), ddLocalidad.SelectedValue.ToString(), ddGrupo.SelectedValue.ToString());
   
       }
       protected void rb_generadas_CheckedChanged(object sender, EventArgs e)
       {
           tdSalida.InnerHtml = "";
           carga_salida(ddRegion.SelectedValue.ToString(), ddZona.SelectedValue.ToString(), ddLocalidad.SelectedValue.ToString(), ddGrupo.SelectedValue.ToString());
   
       }
       protected void txt_fecha_desde_TextChanged(object sender, EventArgs e)
       {
           tdSalida.InnerHtml = "";
           carga_salida(ddRegion.SelectedValue.ToString(), ddZona.SelectedValue.ToString(), ddLocalidad.SelectedValue.ToString(), ddGrupo.SelectedValue.ToString());
   
       }
       protected void txt_nro_orden_TextChanged(object sender, EventArgs e)
       {
           tdSalida.InnerHtml = "";
           carga_salida_por_orden(txt_nro_orden.Text);
       }
       protected void txt_fecha_hasta_TextChanged(object sender, EventArgs e)
       {
           tdSalida.InnerHtml = "";
           carga_salida(ddRegion.SelectedValue.ToString(), ddZona.SelectedValue.ToString(), ddLocalidad.SelectedValue.ToString(), ddGrupo.SelectedValue.ToString());
   
       }
       protected void Button1_Click1(object sender, EventArgs e)
       {
           if (rb_generadas.Checked)
           {
               generarArchivoCSV(ddRegion.SelectedValue.ToString(), ddZona.SelectedValue.ToString(), ddLocalidad.SelectedValue.ToString(), ddGrupo.SelectedValue);

           }
           else
           {

               System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, typeof(System.Web.UI.Page), "Script", "alerta();", true);

           }
       }
       public void generarArchivoCSV(String region, String zona, String localidad, String proceso)
       {

           DateTime dt1, dt2; //validar que sean fechas dd/MM/yyyy.
           if (DateTime.TryParse(txt_fecha_desde.Text, new System.Globalization.CultureInfo("en-GB"), System.Globalization.DateTimeStyles.None, out dt1) &&
               DateTime.TryParse(txt_fecha_hasta.Text, new System.Globalization.CultureInfo("en-GB"), System.Globalization.DateTimeStyles.None, out dt2))
           {
               if (dt1 <= dt2)
               {
                   grupo = ddGrupo.SelectedItem.ToString();
                   String[] arGrupo = grupo.Split('-');
                   grupo = arGrupo[0];
                   String salida;
                   DataRow dr;
                   int total = 0;
                   String salidaGenerada = "";
                   String tipo_archivo = "";
                   String atendido = "0";

                   if (rb_generadas.Checked == true)
                   {
                       salidaGenerada = "1";
                       tipo_archivo = "G";

                   }
                   else
                   {
                       tipo_archivo = "A";
                       salidaGenerada = "0";
                   }

                   if (rb_atendidas.Checked == true)
                   {
                       atendido = "1";
                   }
                   else
                   {
                       atendido = "0";
                   }

                   StreamWriter sr;

                   OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
                   OracleCommand cmdAcceso = new OracleCommand("PK_SALIDA.GENERA_CSV", CnOra);
                   OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
                   String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";

             



                   PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
                   PRO.agrega_parametro_sp(da, "i_empresa", OracleType.NVarChar, ParameterDirection.Input, PRO.recSession(rutaXml, "RUT_EMPRESA"));
                   PRO.agrega_parametro_sp(da, "i_idRegion", OracleType.Int32, ParameterDirection.Input, region);
                   PRO.agrega_parametro_sp(da, "i_idZona", OracleType.Int32, ParameterDirection.Input, zona);
                   PRO.agrega_parametro_sp(da, "i_idLocalidad", OracleType.Int32, ParameterDirection.Input, localidad);
                   PRO.agrega_parametro_sp(da, "i_proceso", OracleType.Int32, ParameterDirection.Input, proceso);
                   PRO.agrega_parametro_sp(da, "i_salida", OracleType.Int32, ParameterDirection.Input, salidaGenerada);
                   PRO.agrega_parametro_sp(da, "i_atendido", OracleType.Int32, ParameterDirection.Input, atendido);
                   PRO.agrega_parametro_sp(da, "i_fecha_desde", OracleType.NVarChar, ParameterDirection.Input, txt_fecha_desde.Text);
                   PRO.agrega_parametro_sp(da, "i_fecha_hasta", OracleType.NVarChar, ParameterDirection.Input, txt_fecha_hasta.Text);

                   da.SelectCommand.CommandType = CommandType.StoredProcedure;

                   DataTable dtOrdenes = new DataTable();

                   try
                   {
                       CnOra.Open();

                       da.Fill(dtOrdenes);
                       CnOra.Close();
                       CnOra.Dispose();
                     

                       DateTime fecha = DateTime.Now;
                       String año = fecha.Year.ToString();
                       String mes = fecha.Month.ToString();
                       String dia = fecha.Day.ToString();
                       String hora = fecha.Hour.ToString();
                       String min = fecha.Minute.ToString();

                       if (fecha.Month <= 9)
                       {
                           mes = "0" + mes;
                       }

                       if (fecha.Day <= 9)
                       {
                           dia = "0" + dia;
                       }

                       Int32 i = 0;

                       String nombreSalida = "SM_" + PRO.recSession(rutaXml, "USERNAME").ToUpper() + "_" + dia + mes + año + "_" + i + ".csv";

                       do
                       {

                           i = i + 1;

                           nombreSalida = "SM_" + PRO.recSession(rutaXml, "USERNAME").ToUpper() + "_" + dia + mes + año + "_" + i + ".csv";
                       }
                       while (verificaArchivo(nombreSalida) == true);

                       sr = new StreamWriter(Server.MapPath("./TXT_SALIDA/" + nombreSalida));


                       StringBuilder sb = new StringBuilder();
                       for (int k = 0; k < dtOrdenes.Columns.Count; k++)
                       {
                           //add separator
                           sb.Append(dtOrdenes.Columns[k].ColumnName + ';');
                       }
                       //append new line
                       sb.Append("\r\n");
                       for (int j = 0; j < dtOrdenes.Rows.Count; j++)
                       {
                           for (int k = 0; k < dtOrdenes.Columns.Count; k++)
                           {
                               //add separator
                               sb.Append(dtOrdenes.Rows[j][k].ToString().Replace(";", ";") + ';');
                           }
                           //append new line
                           sb.Append("\r\n");
                       }
                       sr.Write(sb.ToString());
                       sr.Close();
                      

                       IMG2.Visible = true;
                       IMG5.Visible = false;
                       IMG6.Visible = false;

                       lbResultado.Text = "Archivo generado exitosamente.";

                       //HyperLink url_xml = new HyperLink();

                       ////SM_FCAMPOSM_17012017_1
                       //url_xml.NavigateUrl = "TXT_SALIDA/" + nombreSalida;
                       ////url_xml.Text = "DESCARGAR ORDENES" & VAR_SALIDA + FECHA_LECTURA + GRUPO & ""
                       //url_xml.Text = "DESCARGAR ORDENES";
                       //TableRow rowNew = new TableRow();
                       //TableCell cellNew = new TableCell();
                       //cellNew.Controls.Add(url_xml);
                       //rowNew.Controls.Add(cellNew);
                       //tbl_link.Controls.Add(rowNew);



                       String archivoSal = "TXT_SALIDA/" + nombreSalida;



                       tdSalida.InnerHtml = "<a href=\"" + archivoSal + "\" download=\"" + nombreSalida + "\">DESCARGAR ARCHIVO CSV</a>";

                       //Download("TXT_SALIDA/" + nombreSalida);


                   }
                   catch (Exception ex)
                   {
                       IMG2.Visible = false;
                       IMG5.Visible = true;
                       IMG6.Visible = false;

                       lbResultado.Text = "Error al intentar generar archivo: " + ex.Message;
                   }
               }
               else
               {

                   lb_error_fechas.Text = "Fecha inicial debe ser menor o igual a la final";
               }

           }
           else
           {
               lb_error_fechas.Text = "Ingreso de fechas inválido";
           }

       }
       

       }
