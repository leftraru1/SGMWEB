using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OracleClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class InformeEfectividadMedidor : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

            try
            {
                

                    DateTime primerDiaMes= new DateTime();
                    primerDiaMes = DateTime.Now;
                    primerDiaMes = primerDiaMes.AddDays(-primerDiaMes.Day + 1);

                    DateTime ultimoDiaMes= new DateTime();
                    ultimoDiaMes = DateTime.Now;
                    ultimoDiaMes = ultimoDiaMes.AddDays(-ultimoDiaMes.Day + 1).AddMonths(1).AddDays(-1);

                ////carga_fechain();

                    txtDesde.Text = primerDiaMes.ToString("dd-MM-yyyy");
                   txtHasta.Text = ultimoDiaMes.ToString("dd-MM-yyyy");

                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                PRO.recSession(rutaXml, "RUT_EMPRESA");
                String rutRegion = PRO.recSession(rutaXml, "RUT_EMPRESA");


                carga_region();
                carga_zona(ddRegion.SelectedValue.ToString());
                carga_localidad(int.Parse(ddZona.SelectedValue));
                Llena_combo_contratista(rutRegion);
                Llena_combo_proceso();
                ddlTrabajador.Items.Add("Todas...");
                ddlTrabajador.Items[0].Value = "0";

            }
            catch (Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }

        }
    }
    private void Llena_combo_proceso()
    {

        string sql_zonas = null;
        DataTable dtZonas = new DataTable();
        sql_zonas = "SELECT * from tipo_proceso where estado <>1";
        // Para rellenar combo"
        OracleDataAdapter objComando_Zonas = null;
        objComando_Zonas = new OracleDataAdapter(sql_zonas, conexion_cliente_oracle);
        objComando_Zonas.Fill(dtZonas);
        string valueCombo = null;
        string textoCombo = null;


        ddlProceso.Items.Clear();
        ddlProceso.Items.Add("Todas...");
        ddlProceso.Items[0].Value = "0";
        foreach (System.Data.DataRow drZonaItem in dtZonas.Rows)
        {
            valueCombo = drZonaItem["ID_TIPO_PROCESO"].ToString();
            textoCombo = drZonaItem["DETALLE"].ToString().ToUpper();
            ddlProceso.Items.Add(new ListItem(textoCombo, valueCombo));
        }

    }
    protected void ddZona_SelectedIndexChanged(object sender, EventArgs e)
    {
        //  tdSalida.InnerHtml = "";
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
        PRO.recSession(rutaXml, "RUT_EMPRESA");
        String rutRegion = PRO.recSession(rutaXml, "RUT_EMPRESA");

        carga_localidad(int.Parse(ddZona.SelectedValue));
        carga_trabajador(int.Parse(ddZona.SelectedValue), rutRegion);
        // carga_Grupo(ddRegion.SelectedValue.ToString(), ddZona.SelectedValue.ToString(), ddLocalidad.SelectedValue.ToString(), PRO.recSession(rutaXml, "RUT_EMPRESA"));

    }

    protected void ddLocalidad_SelectedIndexChanged(object sender, EventArgs e)
    {
        /// tdSalida.InnerHtml = "";
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";



        // carga_Grupo(ddRegion.SelectedValue.ToString(), ddZona.SelectedValue.ToString(), ddLocalidad.SelectedValue.ToString(), PRO.recSession(rutaXml, "RUT_EMPRESA"));

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

            ddLocalidad.Items.Add(row[1].ToString());
            ddLocalidad.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }

    public void carga_trabajador(int zona, string p_RutEmpresa)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("REPORTE_EFEC_MED.CARGA_OPERADORES", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_IDZONA", OracleType.Int32, ParameterDirection.Input, zona.ToString());
        PRO.agrega_parametro_sp(objComando, "i_rutem", OracleType.Int32, ParameterDirection.Input, p_RutEmpresa);


        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "trabajador");
        objConexion.Close();

        int i = 1;
        ddlTrabajador.Items.Clear();
        ddlTrabajador.Items.Add("Todas...");
        ddlTrabajador.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["trabajador"].Rows)
        {

            ddlTrabajador.Items.Add(row[1].ToString());
            ddlTrabajador.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }

    private void Llena_combo_contratista(string p_RutEmpresa)
    {

        string sql_zonas = null;
        DataTable dtZonas = new DataTable();
        sql_zonas = "select * from contratista where rut_empresa = " + p_RutEmpresa + "  AND estado=0  ";
        // Para rellenar combo"
        OracleDataAdapter objComando_Zonas = null;
        objComando_Zonas = new OracleDataAdapter(sql_zonas, conexion_cliente_oracle);
        objComando_Zonas.Fill(dtZonas);
        string valueCombo = null;
        string textoCombo = null;

        combo_contratista.Items.Clear();
        combo_contratista.Items.Clear();
        combo_contratista.Items.Add("Todas...");
        combo_contratista.Items[0].Value = "0";
        foreach (System.Data.DataRow drZonaItem in dtZonas.Rows)
        {
            valueCombo = drZonaItem["id_contratista"].ToString();
            textoCombo = drZonaItem["nombre"].ToString().ToUpper();
            combo_contratista.Items.Add(new ListItem(textoCombo, valueCombo));
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
        String rutRegion = PRO.recSession(rutaXml, "RUT_EMPRESA");


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
    protected void ddRegion_SelectedIndexChanged(object sender, EventArgs e)
    {
        //tdSalida.InnerHtml = "";
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";

        carga_zona(ddRegion.SelectedValue.ToString());
        carga_localidad(int.Parse(ddZona.SelectedValue));
        //carga_Grupo(ddRegion.SelectedValue.ToString(), ddZona.SelectedValue.ToString(), ddLocalidad.SelectedValue.ToString(), PRO.recSession(rutaXml, "RUT_EMPRESA"));

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Carga_Efectivas();
        Carga_Improcedentes();
        Carga_Improcedentes_Repaso();
        total_seleccion();
        Estadistica();
    }


    public void Carga_Efectivas()
    {

        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
        PRO.recSession(rutaXml, "RUT_EMPRESA");
        String rutRegion = PRO.recSession(rutaXml, "RUT_EMPRESA");
        
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataTable dtOrdenes = new DataTable();

     
        objComando = new OracleDataAdapter("REPORTE_EFEC_MED.CARGA_EFECTIVAS", objConexion);
   

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_rut_empresa", OracleType.NVarChar, ParameterDirection.Input, rutRegion);
        PRO.agrega_parametro_sp(objComando, "i_id_zona", OracleType.Number, ParameterDirection.Input, ddZona.SelectedValue);
        PRO.agrega_parametro_sp(objComando, "i_id_region", OracleType.Number, ParameterDirection.Input, ddRegion.SelectedValue);
        PRO.agrega_parametro_sp(objComando, "i_id_localidad", OracleType.Number, ParameterDirection.Input, ddLocalidad.SelectedValue);
        PRO.agrega_parametro_sp(objComando, "i_cod_instalador", OracleType.Number, ParameterDirection.Input, ddlTrabajador.SelectedValue);
        PRO.agrega_parametro_sp(objComando, "i_id_contratista", OracleType.Number, ParameterDirection.Input, combo_contratista.SelectedValue);
        PRO.agrega_parametro_sp(objComando, "i_id_tipo_proceso", OracleType.Number, ParameterDirection.Input, ddlProceso.SelectedValue);
        PRO.agrega_parametro_sp(objComando, "i_FECHA_INICIO", OracleType.NVarChar, ParameterDirection.Input,txtDesde.Text );
        PRO.agrega_parametro_sp(objComando, "i_FECHA_FIN", OracleType.NVarChar, ParameterDirection.Input, txtHasta.Text);

        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;
        objConexion.Open();
        objComando.Fill(dtOrdenes);
        objConexion.Close();
        objConexion.Dispose();


        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("CLAVE", typeof(Int32)));
        dt.Columns.Add(new DataColumn("DESCRIPCION", typeof(String)));
        dt.Columns.Add(new DataColumn("CANTIDAD", typeof(String)));
        dt.Columns.Add(new DataColumn("PORCENTAJE", typeof(String)));
        //dt.Columns.Add(new DataColumn("TOTAL", typeof(String)));
        
        DataRow dr;

        int total = 0;

        foreach (DataRow drOrdenItem in dtOrdenes.Rows)
        {
           
            dr = dt.NewRow();
            dr["CLAVE"] = drOrdenItem["CLAVE"].ToString();
            dr["DESCRIPCION"] = drOrdenItem["DESCRIPCION"].ToString();
            dr["CANTIDAD"] = drOrdenItem["CANTIDAD"].ToString();
            dr["PORCENTAJE"] = drOrdenItem["PORCENTAJE"].ToString();
           // dr["TOTAL"] = drOrdenItem["TOTAL"].ToString();

            dt.Rows.Add(dr);

            total = total + 1;

        }
        if (dtOrdenes.Rows.Count > 1)
        {
            EFECTIVAS.Visible = true;
        }
        
        DataView MydataView;
        MydataView = new DataView(dt);
        GrillaEfectividadLector.DataSource = MydataView;
        GrillaEfectividadLector.DataBind();
        int c;
        for (c = 0; c < GrillaEfectividadLector.Rows.Count; c++)
        {
            GrillaEfectividadLector.Rows[c].BackColor = System.Drawing.Color.LightGreen;
        }

    }
    public void Carga_Improcedentes()
    {

        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
        PRO.recSession(rutaXml, "RUT_EMPRESA");
        String rutRegion = PRO.recSession(rutaXml, "RUT_EMPRESA");     
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataTable dtOrdenes = new DataTable();


        objComando = new OracleDataAdapter("REPORTE_EFEC_MED.CARGA_IMPROCEDENTES", objConexion);


        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_rut_empresa", OracleType.NVarChar, ParameterDirection.Input, rutRegion);
        PRO.agrega_parametro_sp(objComando, "i_id_zona", OracleType.Number, ParameterDirection.Input, ddZona.SelectedValue);
        PRO.agrega_parametro_sp(objComando, "i_id_region", OracleType.Number, ParameterDirection.Input, ddRegion.SelectedValue);
        PRO.agrega_parametro_sp(objComando, "i_id_localidad", OracleType.Number, ParameterDirection.Input, ddLocalidad.SelectedValue);
        PRO.agrega_parametro_sp(objComando, "i_cod_instalador", OracleType.Number, ParameterDirection.Input, ddlTrabajador.SelectedValue);
        PRO.agrega_parametro_sp(objComando, "i_id_contratista", OracleType.Number, ParameterDirection.Input, combo_contratista.SelectedValue);
        PRO.agrega_parametro_sp(objComando, "i_id_tipo_proceso", OracleType.Number, ParameterDirection.Input, ddlProceso.SelectedValue);
        PRO.agrega_parametro_sp(objComando, "i_FECHA_INICIO", OracleType.NVarChar, ParameterDirection.Input, txtDesde.Text);
        PRO.agrega_parametro_sp(objComando, "i_FECHA_FIN", OracleType.NVarChar, ParameterDirection.Input, txtHasta.Text);

        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;
        objConexion.Open();
        objComando.Fill(dtOrdenes);
        objConexion.Close();
        objConexion.Dispose();

        //TOTAL
        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("CLAVE", typeof(Int32)));
        dt.Columns.Add(new DataColumn("DESCRIPCION", typeof(String)));
        dt.Columns.Add(new DataColumn("CANTIDAD", typeof(String)));
        dt.Columns.Add(new DataColumn("PORCENTAJE", typeof(String)));
        //dt.Columns.Add(new DataColumn("TOTAL", typeof(String)));
        DataRow dr;

        int total1 = 0;

        foreach (DataRow drOrdenItem in dtOrdenes.Rows)
        {
           
            dr = dt.NewRow();
            dr["CLAVE"] = drOrdenItem["CLAVE"].ToString();
            dr["DESCRIPCION"] = drOrdenItem["DESCRIPCION"].ToString();
            dr["CANTIDAD"] = drOrdenItem["CANTIDAD"].ToString();
            dr["PORCENTAJE"] = drOrdenItem["PORCENTAJE"].ToString();
            //dr["TOTAL"] = drOrdenItem["TOTAL"].ToString();


            dt.Rows.Add(dr);

            total1 = total1 + 1;

        }
       
        DataView MydataView;
        MydataView = new DataView(dt);
        GrillaEfectividad_lector_impro.DataSource = MydataView;
        GrillaEfectividad_lector_impro.DataBind();


        int c;
        for (c = 0; c < GrillaEfectividad_lector_impro.Rows.Count; c++)
        {
            GrillaEfectividad_lector_impro.Rows[c].BackColor = System.Drawing.Color.Orange;
            IMPROCEDENTES.Visible = true;
        }

    }

        public void Carga_Improcedentes_Repaso()
    {

        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
        PRO.recSession(rutaXml, "RUT_EMPRESA");
        String rutRegion = PRO.recSession(rutaXml, "RUT_EMPRESA");     
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataTable dtOrdenes = new DataTable();


        objComando = new OracleDataAdapter("REPORTE_EFEC_MED.CARGA_IMPROCEDENTES_REPASO", objConexion);


        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_rut_empresa", OracleType.NVarChar, ParameterDirection.Input, rutRegion);
        PRO.agrega_parametro_sp(objComando, "i_id_zona", OracleType.Number, ParameterDirection.Input, ddZona.SelectedValue);
        PRO.agrega_parametro_sp(objComando, "i_id_region", OracleType.Number, ParameterDirection.Input, ddRegion.SelectedValue);
        PRO.agrega_parametro_sp(objComando, "i_id_localidad", OracleType.Number, ParameterDirection.Input, ddLocalidad.SelectedValue);
        PRO.agrega_parametro_sp(objComando, "i_cod_instalador", OracleType.Number, ParameterDirection.Input, ddlTrabajador.SelectedValue);
        PRO.agrega_parametro_sp(objComando, "i_id_contratista", OracleType.Number, ParameterDirection.Input, combo_contratista.SelectedValue);
        PRO.agrega_parametro_sp(objComando, "i_id_tipo_proceso", OracleType.Number, ParameterDirection.Input, ddlProceso.SelectedValue);
        PRO.agrega_parametro_sp(objComando, "i_FECHA_INICIO", OracleType.NVarChar, ParameterDirection.Input, txtDesde.Text);
        PRO.agrega_parametro_sp(objComando, "i_FECHA_FIN", OracleType.NVarChar, ParameterDirection.Input, txtHasta.Text);

        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;
        objConexion.Open();
        objComando.Fill(dtOrdenes);
        objConexion.Close();
        objConexion.Dispose();

        ////TOTAL
        //DataTable dt = new DataTable();
        //dt.Columns.Add(new DataColumn("CLAVE", typeof(Int32)));
        //dt.Columns.Add(new DataColumn("DESCRIPCION", typeof(String)));
        //dt.Columns.Add(new DataColumn("CANTIDAD", typeof(String)));
        //dt.Columns.Add(new DataColumn("PORCENTAJE", typeof(String)));
        ////dt.Columns.Add(new DataColumn("TOTAL", typeof(String)));
        //DataRow dr;

        int total_repaso = 0,repasar1=0,repasar2=0;

        foreach (DataRow drOrdenItem in dtOrdenes.Rows)
        {

            
            total_repaso= int.Parse(drOrdenItem["TOTAL_REPASO"].ToString());
            repasar1 = int.Parse(drOrdenItem["CANTIDAD"].ToString());
            repasar2 = repasar1 + repasar2;
           

        }

        TextBox3.Text = total_repaso.ToString();
        TextBox1.Text = repasar2.ToString();
     

    }


    public void Estadistica()
    {
        int c,d, totalEfec = 0, totalImp = 0;
        double totalPorEfc=0,totales=0,toti=0;
        totalPorEfc = int.Parse(lblTotales.Text);


        for (c = 0; c < GrillaEfectividadLector.Rows.Count; c++)
        {
            totalEfec = totalEfec + int.Parse(GrillaEfectividadLector.Rows[c].Cells[2].Text);
            
        }
        
        for (d = 0; d < GrillaEfectividad_lector_impro.Rows.Count; d++)
        {
            totalImp = totalImp + int.Parse(GrillaEfectividad_lector_impro.Rows[d].Cells[2].Text);
           
        }





        totales = totalEfec + totalImp;

        toti=totalPorEfc-totales;

        

        txt_cant_pendientes.Text = toti.ToString();
        txt_cant_leidas.Text = totales.ToString();
        txt_total.Text = totalPorEfc.ToString();
        txt_cant_efectivas.Text = totalEfec.ToString();
        txt_cant_improcedentes.Text = totalImp.ToString();
        ////////////////////////////
        double cambioVisPor = 0;
        double cambioPorVis = 0;
        double totalCambEf = 0;
        double totalCambImp = 0;

        if (totalEfec != 0 || totalImp != 0)
        {
            cambioVisPor = totales * 100 / totalPorEfc;
            txt_leidas.Text = Math.Round(cambioVisPor).ToString();
            cambioPorVis = toti * 100 / totalPorEfc;
            txt_pendientes.Text = Math.Round(cambioPorVis).ToString();
            totalCambEf = totalEfec * 100 / totalPorEfc;
            txt_efectivos.Text = Math.Round(totalCambEf).ToString();
            totalCambImp = (totalImp * 100) / totalPorEfc;
            txt_sin_lecturas.Text = Math.Round(totalCambImp).ToString();
           
        }
        else
        {

            txt_leidas.Text = "0";

            txt_pendientes.Text = "0";

            txt_efectivos.Text = "0";

            txt_sin_lecturas.Text = "0";
        }

     

       
    }


    private void total_seleccion()
    {

            String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
            PRO.recSession(rutaXml, "RUT_EMPRESA");
            String rutRegion = PRO.recSession(rutaXml, "RUT_EMPRESA");
           
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataTable dtOrdenes = new DataTable();


            objComando = new OracleDataAdapter("REPORTE_EFEC_MED.TOTAL_SELECCION", objConexion);


            PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
            PRO.agrega_parametro_sp(objComando, "i_rut_empresa", OracleType.NVarChar, ParameterDirection.Input, rutRegion);
            PRO.agrega_parametro_sp(objComando, "i_id_zona", OracleType.Number, ParameterDirection.Input, ddZona.SelectedValue);
            PRO.agrega_parametro_sp(objComando, "i_id_region", OracleType.Number, ParameterDirection.Input, ddRegion.SelectedValue);
            PRO.agrega_parametro_sp(objComando, "i_id_localidad", OracleType.Number, ParameterDirection.Input, ddLocalidad.SelectedValue);
            PRO.agrega_parametro_sp(objComando, "i_cod_instalador", OracleType.Number, ParameterDirection.Input, ddlTrabajador.SelectedValue);
            PRO.agrega_parametro_sp(objComando, "i_id_contratista", OracleType.Number, ParameterDirection.Input, combo_contratista.SelectedValue);
            PRO.agrega_parametro_sp(objComando, "i_id_tipo_proceso", OracleType.Number, ParameterDirection.Input, ddlProceso.SelectedValue);
            PRO.agrega_parametro_sp(objComando, "i_FECHA_INICIO", OracleType.NVarChar, ParameterDirection.Input, txtDesde.Text);
            PRO.agrega_parametro_sp(objComando, "i_FECHA_FIN", OracleType.NVarChar, ParameterDirection.Input, txtHasta.Text);

            objComando.SelectCommand.CommandType = CommandType.StoredProcedure;
            objConexion.Open();
            objComando.Fill(dtOrdenes);
            objConexion.Close();
            objConexion.Dispose();

            foreach (DataRow drOrdenItem in dtOrdenes.Rows)
            {
                lblTotales.Text = drOrdenItem["TOTAL"].ToString();
         
            }
    
    }



    protected void Button2_Click(object sender, EventArgs e)
    {
        
        string cadenaHtml  = "";
        string cadenaHtml1  = "";
        string cadenaHtml2 = "";
       

        //'-----CADENA ESPACIO
        cadenaHtml = cadenaHtml + "<br></br>";
        //'-----CADENA NRO 01 COMBOS SELECCIONADOS
        cadenaHtml1 = cadenaHtml1 + "<table border='1'><tr>";
        cadenaHtml1 = cadenaHtml1 + "<td colspan='8' align='center'>";
        cadenaHtml1 = cadenaHtml1 + "<h3>INFORME EFECTIVIDAD  OPERATIVA CAMBIO MEDIDOR</h3>";
        cadenaHtml1 = cadenaHtml1 + "</td>";
        cadenaHtml1 = cadenaHtml1 + "</tr></table>";
        cadenaHtml1 = cadenaHtml1 + "<br></br>";
        cadenaHtml1 = cadenaHtml1 + "<br></br>";
        cadenaHtml1 = cadenaHtml1 + "<table border='1'>";
        cadenaHtml1 = cadenaHtml1 + "<tr>";
        cadenaHtml1 = cadenaHtml1 + "<td>TIPO PROCESO:</td>";
        cadenaHtml1 = cadenaHtml1 + "<td align='right'>" + ddlProceso.SelectedItem.Text + "</td>";
        cadenaHtml1 = cadenaHtml1 + "</tr>";
        cadenaHtml1 = cadenaHtml1 + "<tr>";
        cadenaHtml1 = cadenaHtml1 + "<td>FECHA INICIAL:</td>";
        cadenaHtml1 = cadenaHtml1 + "<td align='right'>" + txtDesde.Text + "</td>";
        cadenaHtml1 = cadenaHtml1 + "</tr>";
        cadenaHtml1 = cadenaHtml1 + "<tr>";
        cadenaHtml1 = cadenaHtml1 + "<td>FECHA FINAL:</td>";
        cadenaHtml1 = cadenaHtml1 + "<td align='right'>"+ txtHasta.Text + "</td>";
        cadenaHtml1 = cadenaHtml1 + "</tr>";
        cadenaHtml1 = cadenaHtml1 + "<tr>";
        cadenaHtml1 = cadenaHtml1 + "<td>REGION:</td>";
        cadenaHtml1 = cadenaHtml1 + "<td align='right'>" + ddRegion.SelectedItem.Text + "</td>";
        cadenaHtml1 = cadenaHtml1 + "</tr>";
        cadenaHtml1 = cadenaHtml1 + "<tr>";
        cadenaHtml1 = cadenaHtml1 + "<td>ZONA:</td>";
        cadenaHtml1 = cadenaHtml1 + "<td align='right'>" + ddZona.SelectedItem.Text + "</td>";
        cadenaHtml1 = cadenaHtml1 + "</tr>";
        cadenaHtml1 = cadenaHtml1 + "<tr>";
        cadenaHtml1 = cadenaHtml1 + "<td>LOCALIDAD:</td>";
        cadenaHtml1 = cadenaHtml1 + "<td align='right'>" + ddLocalidad.SelectedItem.Text + "</td>";
        cadenaHtml1 = cadenaHtml1 + "</tr>";
        cadenaHtml1 = cadenaHtml1 + "<tr>";
        cadenaHtml1 = cadenaHtml1 + "<td>TRABAJADOR:</td>";
        cadenaHtml1 = cadenaHtml1 + "<td align='right'>" + ddlTrabajador.SelectedItem.Text + "</td>";
        cadenaHtml1 = cadenaHtml1 + "</tr>";
        cadenaHtml1 = cadenaHtml1 + "<tr>";
        cadenaHtml1 = cadenaHtml1 + "<td>CONTRATISTA:</td>";
        cadenaHtml1 = cadenaHtml1 + "<td align='right'>" + combo_contratista.SelectedItem.Text + "</td>";
        cadenaHtml1 = cadenaHtml1 + "</tr>";
        cadenaHtml1 = cadenaHtml1 + "</table>";
        cadenaHtml1 = cadenaHtml1 + "<br></br>";
        cadenaHtml1 = cadenaHtml1 + "<br></br>";

        cadenaHtml2 = cadenaHtml2 + "<table border='1'>";
        cadenaHtml2 = cadenaHtml2 + "<tr>";
        cadenaHtml2 = cadenaHtml2 + "<td align='center'>DETALLE</td>";
        cadenaHtml2 = cadenaHtml2 + "<td align='center'>CANTIDAD</td>";
        cadenaHtml2 = cadenaHtml2 + "<td align='center'>PORCENTAJE</td>";
        cadenaHtml2 = cadenaHtml2 + "</tr>";
        cadenaHtml2 = cadenaHtml2 + "<tr>";
        cadenaHtml2 = cadenaHtml2 + "<td>Total Ordenes de Cambio:</td>";
        cadenaHtml2 = cadenaHtml2 + "<td align='left'>" + txt_total.Text + "</td>";
        cadenaHtml2 = cadenaHtml2 + "</tr>";
        cadenaHtml2 = cadenaHtml2 + "<tr>";
        cadenaHtml2 = cadenaHtml2 + "<td>Total Ordenes de Cambio Visitadas:</td>";
        cadenaHtml2 = cadenaHtml2 + "<td align='left'>" + txt_cant_leidas.Text + "</td>";
        cadenaHtml2 = cadenaHtml2 + "<td align='left'>" + txt_leidas.Text + "&nbsp;%</td>";
        cadenaHtml2 = cadenaHtml2 + "</tr>";
        cadenaHtml2 = cadenaHtml2 + "<tr>";
        cadenaHtml2 = cadenaHtml2 + "<td>Total Ordenes de Cambio por Visitar:</td>";
        cadenaHtml2 = cadenaHtml2 + "<td align='left'>" + txt_cant_pendientes.Text + "</td>";
        cadenaHtml2 = cadenaHtml2 + "<td align='left'>" + txt_pendientes.Text + "&nbsp;%</td>";
        cadenaHtml2 = cadenaHtml2 + "</tr>";
        cadenaHtml2 = cadenaHtml2 + "<tr>";
        cadenaHtml2 = cadenaHtml2 + "<td>Total Cambios Efectivos:</td>";
        cadenaHtml2 = cadenaHtml2 + "<td align='left'>" + txt_cant_efectivas.Text + "</td>";
        cadenaHtml2 = cadenaHtml2 + "<td align='left'>" + txt_efectivos.Text + "&nbsp;%</td>";
        cadenaHtml2 = cadenaHtml2 + "</tr>";
        cadenaHtml2 = cadenaHtml2 + "<tr>";
        cadenaHtml2 = cadenaHtml2 + "<td>Total Cambios Improcedentes:</td>";
        cadenaHtml2 = cadenaHtml2 + "<td align='left'>" + txt_cant_improcedentes.Text + "</td>";
        cadenaHtml2 = cadenaHtml2 + "<td align='left'>" + txt_sin_lecturas.Text + "&nbsp;%</td>";
        cadenaHtml2 = cadenaHtml2 + "</tr>";
        cadenaHtml2 = cadenaHtml2 + "</table>";

        Response.Clear();
        Response.Buffer = true;
        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("Content-Disposition", "attachment;filename=InformeEfectividadOperativaCambioMedidor.xls");
        Response.Charset = "UTF-8";
        Response.ContentEncoding = System.Text.Encoding.Default;

        Response.Write(cadenaHtml1);

        System.IO.StringWriter tw1 = new System.IO.StringWriter();
        System.IO.StringWriter tw2 = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter hw1 = new System.Web.UI.HtmlTextWriter(tw1);
        System.Web.UI.HtmlTextWriter hw2 = new System.Web.UI.HtmlTextWriter(tw2);
        GrillaEfectividadLector.RenderControl(hw1);
        GrillaEfectividad_lector_impro.RenderControl(hw2);
        Response.Write(tw1.ToString());
        Response.Write(cadenaHtml); //'ESPACIO
        Response.Write(tw2.ToString());
        Response.Write(cadenaHtml); //'ESPACIO
        Response.Write(cadenaHtml); //'ESPACIO 
        Response.Write(cadenaHtml2); //'ESPACIO 
        Response.End();
        GrillaEfectividadLector.AllowPaging = true;
        GrillaEfectividad_lector_impro.AllowPaging = true;

    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }
}