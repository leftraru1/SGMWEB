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

public partial class visorordenes : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            try
            {
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                PRO.recSession(rutaXml, "RUT_EMPRESA");
                int id_cont = 0;
                id_cont = int.Parse(PRO.recSession(rutaXml, "ID_CONTRATISTA"));

                carga_Region();
                carga_zona(ddRegion.SelectedValue);              
                carga_tipoIn();
                carga_localidad(ddZona.SelectedValue); 
                carga_TipoP();
                carga_contratista(id_cont);
                carga_procedencia();

                //carga_fechain();
                
                txtDesde.Text = DateTime.Now.AddDays(-90).ToString("dd-MM-yyyy");
                txtHasta.Text =  DateTime.Now.ToString("dd-MM-yyyy");

        
                carga_ruta("0","0", 0, 0, 0, "0", 0, txtDesde.Text, txtHasta.Text, 0,0);
                //carga_grilla("0","0", 0, 0, 0, "0", 0, txtDesde.Text,txtHasta.Text,0,0,0);

                //IMG2.Visible = false;
                //IMG4.Visible = false;
                //IMG5.Visible = false;
                //IMG6.Visible = false;
            }
            catch(Exception ex)
            {
              //  Response.Redirect("errorSesion.aspx");
            }     
        }
    }
    public void carga_contratista(int contratista)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();

        if (contratista==0)
        {   // Muestra todos los contratistas
            objComando = new OracleDataAdapter("PRUEBAS.CARGAR_NOMBRE_CONTRATISTAS_M", objConexion);
        }else{
            // Muestra solo el contratista que tiene asignado
            objComando = new OracleDataAdapter("PRUEBAS.CARGAR_NOMBRE_CONTRATISTAS", objConexion);
        }
        
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;
        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_id_contratista", OracleType.Int32, ParameterDirection.Input, contratista.ToString());

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "NOMBRE_CONTRATISTA");
        objConexion.Close();

        int i = 1;
        ddContratista.Items.Clear();
        ddContratista.Items.Add("Todos...");
        ddContratista.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["NOMBRE_CONTRATISTA"].Rows)
        {

            ddContratista.Items.Add(row[0].ToString());
            ddContratista.Items[i].Value = row[1].ToString();
            i = i + 1;

        }
    }

    public void carga_procedencia()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();

        objComando = new OracleDataAdapter("PRUEBAS.CARGAR_PROCEDENCIAS", objConexion);
        

        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;
        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "PROCEDENCIA");
        objConexion.Close();

        int i = 1;
        ddProcedencia.Items.Clear();
        ddProcedencia.Items.Add("Todas...");
        ddProcedencia.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["PROCEDENCIA"].Rows)
        {

            ddProcedencia.Items.Add(row[0].ToString());
            ddProcedencia.Items[i].Value = row[1].ToString();
            i = i + 1;

        }
    }

    //CARGAMOS LAS REGIONES
    public void carga_Region()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_GENERAR_REPASO.CARGA_REGION", objConexion);
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
 
    public void carga_tipoIn()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_ORDEN.CARGAR_TIPO_IN", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        
        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "TIPO");
        objConexion.Close();

        int i = 1;
        ddTipoIn.Items.Clear();
        ddTipoIn.Items.Add("Todas...");
        ddTipoIn.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["TIPO"].Rows)
        {

            ddTipoIn.Items.Add(row[2].ToString());
            ddTipoIn.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }
    public void carga_localidad(String zona)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_LOCALIDAD.CARGA_LOCALIDAD_SALIDA", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_zona", OracleType.Int32, ParameterDirection.Input, zona);

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
    public void carga_fechain()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_PROCESO.INTERVALO_FECHAIN", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
       

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "FECHA");
        objConexion.Close();

        int i = 1;
        
        foreach (DataRow row in objDS.Tables["FECHA"].Rows)
        {
            txtDesde.Text = row[0].ToString();
            txtHasta.Text = row[1].ToString();
            
            i = i + 1;

        }
    }
    public void carga_zona(String region)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_GENERAR_REPASO.CARGA_ZONA", objConexion);
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
    public void carga_TipoP()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_PROCESO.CARGA_TP", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "TIPO");
        objConexion.Close();

        int i = 1;
        ddTipoPro.Items.Clear();
        ddTipoPro.Items.Add("Todos...");
        ddTipoPro.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["TIPO"].Rows)
        {

            ddTipoPro.Items.Add(row[1].ToString());
            ddTipoPro.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }

    public void carga_ruta(String servicio, String numero_orden, int proceso, int localidad, int instalacion, String ruta, int tipo, String desde, String hasta, int zona, int contratista)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        if (numero_orden == "")
        {
            numero_orden = "0";
        }

        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
        int id_contratis = int.Parse(PRO.recSession(rutaXml, "ID_CONTRATISTA"));

        objConexion.Open();
        objComando = new OracleDataAdapter("PRUEBAS.CARGAR_RUTA3", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_proceso", OracleType.Int32, ParameterDirection.Input, proceso.ToString());
        PRO.agrega_parametro_sp(objComando, "i_localidad", OracleType.Int32, ParameterDirection.Input, localidad.ToString());
        PRO.agrega_parametro_sp(objComando, "i_instalacion", OracleType.Int32, ParameterDirection.Input, instalacion.ToString());
        PRO.agrega_parametro_sp(objComando, "i_ruta", OracleType.NVarChar, ParameterDirection.Input, ruta);
        PRO.agrega_parametro_sp(objComando, "i_tipo", OracleType.Int32, ParameterDirection.Input, tipo.ToString());
        PRO.agrega_parametro_sp(objComando, "i_rutem", OracleType.NVarChar, ParameterDirection.Input, PRO.recSession(rutaXml, "RUT_EMPRESA"));
        PRO.agrega_parametro_sp(objComando, "i_fechaDesde", OracleType.NVarChar, ParameterDirection.Input, desde);
        PRO.agrega_parametro_sp(objComando, "i_fechaHasta", OracleType.NVarChar, ParameterDirection.Input, hasta);
        PRO.agrega_parametro_sp(objComando, "i_serv", OracleType.NVarChar, ParameterDirection.Input, servicio);
        PRO.agrega_parametro_sp(objComando, "i_idZona", OracleType.Int32, ParameterDirection.Input, zona.ToString());
        PRO.agrega_parametro_sp(objComando, "i_numero_orden", OracleType.Number, ParameterDirection.Input, numero_orden.ToString()); //

        if (id_contratis == 0)
        {   // Muestra todos los contratistas
            PRO.agrega_parametro_sp(objComando, "i_id_contratista", OracleType.Int32, ParameterDirection.Input, contratista.ToString());
        }
        else
        {   // Muestra solo el contratista que tiene asignado
            PRO.agrega_parametro_sp(objComando, "i_id_contratista", OracleType.Int32, ParameterDirection.Input, id_contratis.ToString());
        }

        try
        {
            objComando.SelectCommand.ExecuteNonQuery();
            objComando.Fill(objDS, "RUTA");
            objConexion.Close();
        }
        catch (Exception ex)
        {
        }

        int i = 1;
        ddRuta.Items.Clear();
        ddRuta.Items.Add("Todas...");
        ddRuta.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["RUTA"].Rows)
        {
            ddRuta.Items.Add(row[0].ToString());
            ddRuta.Items[i].Value = row[0].ToString();
            i = i + 1;
        }
    }

    public void carga_grilla(String servicio, String numero_orden, int proceso, int localidad, int instalacion, String ruta, int tipo, String desde, String hasta, int zona, int contratista,int procedencia)
    {

        //MOSTRAMOS SOLO PARA EL LLENADO DE GRILLA, COLUMNAS ID QUE SOLO SE OCUPAN INTERNAMENTE Y NO PARA VISUALIZAR.
        gridOrden.Columns[0].Visible = true; //id_orden
        gridOrden.Columns[13].Visible = true; //id_proceso
        gridOrden.Columns[15].Visible = true; //id_tipo_proceso

        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
        int id_contratis = 0;
        id_contratis = int.Parse(PRO.recSession(rutaXml, "ID_CONTRATISTA"));
       
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_MANTENEDOR_ORDEN.CARGAR_ORDENES2", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_proceso", OracleType.Int32, ParameterDirection.Input, proceso.ToString());
        
        if ( numero_orden.Trim()  == "" ) numero_orden = "0";

        PRO.agrega_parametro_sp(da, "i_numero_orden", OracleType.Number, ParameterDirection.Input, numero_orden.ToString()); //
        PRO.agrega_parametro_sp(da, "i_localidad", OracleType.Int32, ParameterDirection.Input, localidad.ToString());
        PRO.agrega_parametro_sp(da, "i_instalacion", OracleType.Int32, ParameterDirection.Input, instalacion.ToString());
        PRO.agrega_parametro_sp(da, "i_ruta", OracleType.NVarChar, ParameterDirection.Input, ruta);
        PRO.agrega_parametro_sp(da, "i_tipo", OracleType.Int32, ParameterDirection.Input, tipo.ToString());
        PRO.agrega_parametro_sp(da, "i_rutem", OracleType.NVarChar, ParameterDirection.Input, PRO.recSession(rutaXml, "RUT_EMPRESA"));
        PRO.agrega_parametro_sp(da, "i_fechaDesde", OracleType.NVarChar, ParameterDirection.Input, desde);
        PRO.agrega_parametro_sp(da, "i_fechaHasta", OracleType.NVarChar, ParameterDirection.Input, hasta);
        PRO.agrega_parametro_sp(da, "i_serv", OracleType.NVarChar, ParameterDirection.Input, servicio);
        PRO.agrega_parametro_sp(da, "i_idZona", OracleType.Int32, ParameterDirection.Input, zona.ToString());
        PRO.agrega_parametro_sp(da, "i_id_contratista", OracleType.Int32, ParameterDirection.Input, id_contratis.ToString());
        PRO.agrega_parametro_sp(da, "i_cod_improcedencia", OracleType.Int32, ParameterDirection.Input, procedencia.ToString());
        
        //i_id_contratista

        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        DataTable dtOrdenes = new DataTable();

        try
        {
            CnOra.Open();            
            da.Fill(dtOrdenes);
            CnOra.Close();
            CnOra.Dispose();
        
        }
        catch(Exception ex)
        {
            lbErrorGrilla.Text = ex.ToString() + servicio;
            lbErrorGrilla.ForeColor = System.Drawing.Color.Red;

            lbErrorGrilla.Text = ex.ToString() + numero_orden;
            lbErrorGrilla.ForeColor = System.Drawing.Color.Red;
            //lbErrorGrilla.Text = desde + "***" + hasta;

        }       

        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("ID_ORDEN", typeof(String)));
        dt.Columns.Add(new DataColumn("NUMERO_ORDEN", typeof(String))); //
        dt.Columns.Add(new DataColumn("FECHA_CREACION", typeof(String)));
        dt.Columns.Add(new DataColumn("ID_SERVICIO", typeof(String)));
        dt.Columns.Add(new DataColumn("RUTA", typeof(String)));
        dt.Columns.Add(new DataColumn("GESTION_CORTE", typeof(String)));
        dt.Columns.Add(new DataColumn("TIPO_MARCA_DI", typeof(String)));
        dt.Columns.Add(new DataColumn("SERIE_MEDIDOR", typeof(String)));
        dt.Columns.Add(new DataColumn("DIRECCION", typeof(String)));
        dt.Columns.Add(new DataColumn("CLIENTE", typeof(String)));
        dt.Columns.Add(new DataColumn("OBSERVACION_IN", typeof(String)));
        dt.Columns.Add(new DataColumn("LOCALIDAD", typeof(String)));
        dt.Columns.Add(new DataColumn("ID_PROCESO", typeof(Int32)));
        dt.Columns.Add(new DataColumn("GRUPO_PROCESO", typeof(String)));
        dt.Columns.Add(new DataColumn("ID_TIPO_PROCESO", typeof(Int32)));
        dt.Columns.Add(new DataColumn("DETALLE", typeof(String)));
        dt.Columns.Add(new DataColumn("ESTADO", typeof(String)));
        dt.Columns.Add(new DataColumn("DESCRIPCION", typeof(String)));
        dt.Columns.Add(new DataColumn("NOMBRE", typeof(String)));
        dt.Columns.Add(new DataColumn("APELLIDO", typeof(String)));
        dt.Columns.Add(new DataColumn("FECHA_INTEGRACION", typeof(String)));
        dt.Columns.Add(new DataColumn("dias_transcurridos", typeof(Int32)));
        dt.Columns.Add(new DataColumn("CONTRATISTA", typeof(String)));
        dt.Columns.Add(new DataColumn("VISITA", typeof(String)));
        dt.Columns.Add(new DataColumn("FECHA_INST", typeof(String)));

        DataRow dr;

        int total = 0;
        
        foreach (DataRow drOrdenItem in dtOrdenes.Rows)
        {

            dr = dt.NewRow();

            dr["ID_ORDEN"] = drOrdenItem["ID_ORDEN"].ToString();
            dr["FECHA_CREACION"] = drOrdenItem["FECHA_CREACION"].ToString().Replace(" 0:00:00", "");
            dr["NUMERO_ORDEN"] = drOrdenItem["NUMERO_ORDEN"].ToString();//
            dr["ID_SERVICIO"] = drOrdenItem["ID_SERVICIO"].ToString();
            dr["RUTA"] = drOrdenItem["RUTA"].ToString();
            dr["GESTION_CORTE"] = drOrdenItem["GESTION_CORTE"].ToString();
            dr["TIPO_MARCA_DI"] = drOrdenItem["TIPO_MARCA_DI"].ToString();
            dr["SERIE_MEDIDOR"] = drOrdenItem["SERIE_MEDIDOR"].ToString();
            dr["DIRECCION"] = drOrdenItem["DIRECCION"].ToString();
            dr["CLIENTE"] = drOrdenItem["CLIENTE"].ToString();
            dr["OBSERVACION_IN"] = drOrdenItem["OBSERVACION_IN"].ToString();
            dr["LOCALIDAD"] = drOrdenItem["LOCALIDAD"].ToString();
            dr["ID_PROCESO"] = drOrdenItem["ID_PROCESO"].ToString();
            dr["GRUPO_PROCESO"] = drOrdenItem["GRUPO_PROCESO"].ToString();
            dr["ID_TIPO_PROCESO"] = drOrdenItem["ID_TIPO_PROCESO"].ToString();
            dr["DETALLE"] = drOrdenItem["DETALLE"].ToString();
            dr["ESTADO"] = drOrdenItem["DESCRIPCION"].ToString();
            dr["FECHA_INTEGRACION"] = drOrdenItem["FECHA_INTEGRACION"].ToString().Replace(" 0:00:00","") ;
            dr["dias_transcurridos"] = drOrdenItem["DIFERENCIA"].ToString();
            dr["CONTRATISTA"] = drOrdenItem["CONTRATISTA"].ToString();
            // dr["ESTADO"] = drOrdenItem["ESTADO"].ToString();
            dr["NOMBRE"] = drOrdenItem["NOMBRE"].ToString() + " " + drOrdenItem["APELLIDO"].ToString();
            dr["VISITA"] = drOrdenItem["VISITA"].ToString();
            dr["FECHA_INST"] = drOrdenItem["FECHA_INST"].ToString();

            dt.Rows.Add(dr);

            total = total + 1;
           
        }
              
        DataView MydataView;
        MydataView = new DataView(dt);
        gridOrden.DataSource = MydataView;
        gridOrden.DataBind();

        lbTotal.Text = total + " registro(s) encontrado(s)";

        int i;
        GridViewRow gvRow;
       
        ImageButton informe = new ImageButton();
       
        for (i = 0; i < gridOrden.Rows.Count; i++)
        {

            gvRow = gridOrden.Rows[i];
          
            informe = (ImageButton)(gvRow.FindControl("btn_gestion"));
            
          

        }

        //OCULTAMOS COLUMNAS ID QUE SOLO SE OCUPAN INTERNAMENTE Y NO PARA VISUALIZAR.
        gridOrden.Columns[0].Visible = false; //id_orden
        gridOrden.Columns[13].Visible = false; //id_proceso
        gridOrden.Columns[15].Visible = false; //id_tipo_proceso

    }
   
    
  



    protected void ddZona_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_localidad(ddZona.SelectedValue); 
        carga_ruta(txtServ.Text, TextboxNumOrden.Text, int.Parse(ddRegion.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), int.Parse(ddContratista.SelectedValue));
        carga_grilla(txtServ.Text, TextboxNumOrden.Text, int.Parse(ddRegion.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), int.Parse(ddContratista.SelectedValue), int.Parse(ddProcedencia.SelectedValue));
    }
    protected void ddGrupo_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla(txtServ.Text, TextboxNumOrden.Text, int.Parse(ddRegion.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), int.Parse(ddContratista.SelectedValue), int.Parse(ddProcedencia.SelectedValue));
    }
    protected void gridOrden_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //gridOrden.PageIndex = e.NewPageIndex;
        gridOrden.PageIndex = e.NewPageIndex;
        carga_grilla(txtServ.Text, TextboxNumOrden.Text, int.Parse(ddRegion.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), int.Parse(ddContratista.SelectedValue), int.Parse(ddProcedencia.SelectedValue));
    }
    protected void ddRuta_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla(txtServ.Text, TextboxNumOrden.Text, int.Parse(ddRegion.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), int.Parse(ddContratista.SelectedValue), int.Parse(ddProcedencia.SelectedValue));
    }
    protected void ddTipoPro_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla(txtServ.Text, TextboxNumOrden.Text, int.Parse(ddRegion.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), int.Parse(ddContratista.SelectedValue), int.Parse(ddProcedencia.SelectedValue));
    }
    protected void ddLocalidad_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_ruta(txtServ.Text, TextboxNumOrden.Text, int.Parse(ddRegion.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), int.Parse(ddContratista.SelectedValue));
        carga_grilla(txtServ.Text, TextboxNumOrden.Text, int.Parse(ddRegion.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), int.Parse(ddContratista.SelectedValue), int.Parse(ddProcedencia.SelectedValue));
    }
    protected void ddEstado_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla(txtServ.Text, TextboxNumOrden.Text, int.Parse(ddRegion.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), int.Parse(ddContratista.SelectedValue), int.Parse(ddProcedencia.SelectedValue));
    }
    protected void ddTipoIn_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla(txtServ.Text, TextboxNumOrden.Text, int.Parse(ddRegion.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), int.Parse(ddContratista.SelectedValue), int.Parse(ddProcedencia.SelectedValue));
    }
    protected void txtServ_TextChanged(object sender, EventArgs e)
    {
        carga_grilla(txtServ.Text, TextboxNumOrden.Text, int.Parse(ddRegion.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), int.Parse(ddContratista.SelectedValue), int.Parse(ddProcedencia.SelectedValue));
    }
    protected void Button1_Click1(object sender, EventArgs e)
    {
        carga_grilla(txtServ.Text, TextboxNumOrden.Text, int.Parse(ddRegion.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), int.Parse(ddContratista.SelectedValue), int.Parse(ddProcedencia.SelectedValue));
    }
    protected void lkbAsignar_Click(object sender, EventArgs e)
    {

    }

    /* ------------------Evento para actualizar la tabla segun el numero de orden que se busca---------------------------------*/

    protected void txtNumOrden_TextChanged(object sender, EventArgs e)
    {
        carga_grilla(txtServ.Text, TextboxNumOrden.Text, int.Parse(ddRegion.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), int.Parse(ddContratista.SelectedValue), int.Parse(ddProcedencia.SelectedValue));
    }

    protected void ddContratista_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla(txtServ.Text, TextboxNumOrden.Text, int.Parse(ddRegion.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), int.Parse(ddContratista.SelectedValue), int.Parse(ddProcedencia.SelectedValue));
    }


    //protected void gridOrden_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    //gridOrden.PageIndex = e.NewPageIndex;
    //    gridOrden.PageIndex = e.NewPageIndex;
    //    carga_grilla(ddGrupo.SelectedItem.ToString(), ddZona.SelectedValue, ddRegion.SelectedValue, ddLocalidad.SelectedValue, ddRuta.SelectedValue,
    //                 ddFamilia.SelectedValue, ddTipo.SelectedValue, txtServ.Text, txtOrden.Text, txtDesde.Text, txtHasta.Text);

    //}

    protected void gridOrden_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {

            int index = int.Parse(e.CommandArgument.ToString());

            string  servicio, orden_servicio,  visita,id_proceso;

            //obs = gridOrden.Rows[index].Cells[14].Text;
            servicio = gridOrden.Rows[index].Cells[2].Text;
            orden_servicio = gridOrden.Rows[index].Cells[1].Text;
            id_proceso = gridOrden.Rows[index].Cells[13].Text;
            visita = gridOrden.Rows[index].Cells[19].Text;
                        
            if (e.CommandName == "gestion")
            {
                String vtn = "window.open('FormularioORDENHistorico.aspx?servicio=" + servicio + "&visita=" + visita + "&orden_servicio=" + orden_servicio + "&id_proceso=" + id_proceso + "','Dates','scrollbars=yes,resizable=yes,height=800,width=1200,top=0,left=0')";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", vtn, true);
            }
            


        }
        catch (Exception ex)
        {

            //lbTxtIn.ForeColor = System.Drawing.Color.Red;

            //IMG2.Visible = false;
            //IMG4.Visible = true;
            //lbTxtIn.Text = ex.Message;
            //mi_reclamo = null;
        }
    }
    
    /* ------------------COLORES DE LA GRILLA (SLA) -------------------------*/
    protected void gridOrden_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Int32 dias_transcurridos = Int32.Parse(DataBinder.Eval(e.Row.DataItem, "dias_transcurridos").ToString());
            Int32 ID_TIPO_PROCESO = Int32.Parse(DataBinder.Eval(e.Row.DataItem, "ID_TIPO_PROCESO").ToString());

            if(ID_TIPO_PROCESO==2){

                if (dias_transcurridos < 4){
                    e.Row.BackColor = System.Drawing.Color.White;
                }
                if (dias_transcurridos == 4){
                    e.Row.BackColor = System.Drawing.Color.LightBlue;
                }
                if (dias_transcurridos == 5){
                    e.Row.BackColor = System.Drawing.Color.Yellow;
                }
                if (dias_transcurridos >= 6){
                    e.Row.BackColor = System.Drawing.Color.Orange;
                }

             }else{
                 if ((dias_transcurridos/3) < 4)
                 {
                     e.Row.BackColor = System.Drawing.Color.White;
                 }
                 if ((dias_transcurridos/3) == 4)
                 {
                     e.Row.BackColor = System.Drawing.Color.LightBlue;
                 }
                 if ((dias_transcurridos/3) == 5)
                 {
                     e.Row.BackColor = System.Drawing.Color.Yellow;
                 }
                 if ((dias_transcurridos/3) >= 6)
                 {
                      e.Row.BackColor = System.Drawing.Color.Orange;
                  }     
                }
            }
    }

    protected void ddProcedencia_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla(txtServ.Text, TextboxNumOrden.Text, int.Parse(ddRegion.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), int.Parse(ddContratista.SelectedValue), int.Parse(ddProcedencia.SelectedValue));
    }
    protected void ddRegion_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_zona(ddRegion.SelectedValue);
        carga_localidad(ddZona.SelectedValue);
        carga_ruta(txtServ.Text, TextboxNumOrden.Text, int.Parse(ddRegion.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), int.Parse(ddContratista.SelectedValue));
        carga_grilla(txtServ.Text, TextboxNumOrden.Text, int.Parse(ddRegion.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), int.Parse(ddContratista.SelectedValue), int.Parse(ddProcedencia.SelectedValue));
    
    }
}