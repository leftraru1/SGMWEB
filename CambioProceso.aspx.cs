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

public partial class CambioProceso : System.Web.UI.Page
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
                int id_cont = 0;
                id_cont = int.Parse(PRO.recSession(rutaXml, "ID_CONTRATISTA"));

                carga_zona();
                carga_tipoIn();
                carga_Grupo();
                carga_localidad(int.Parse(ddZona.SelectedValue));
                carga_TipoP();
                carga_contratista(id_cont);
                
                carga_proceso(); // carga procesos de cambio

                txtDesde.Text = DateTime.Now.AddDays(-30).ToString("dd-MM-yyyy");
                txtHasta.Text = DateTime.Now.ToString("dd-MM-yyyy");

                carga_Sincro();

                carga_ruta( 0, 0, 0, 0, "0", 0, txtDesde.Text, txtHasta.Text, 0, "0");
                carga_grilla( 0, 0, 0, 0, "0", 0, txtDesde.Text, txtHasta.Text, 0, "0");

                IMG2.Visible = false;
               // IMG4.Visible = false;
                IMG5.Visible = false;
                IMG6.Visible = false;
            }
            catch (Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }
        }
    }

    public void carga_contratista(int contratista)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();

        if (contratista == 0)
        {   // Muestra todos los contratistas
            objComando = new OracleDataAdapter("PK_CAMBIO_PROCESO.CARGAR_NOMBRE_CONTRATISTAS_M", objConexion);
        }
        else
        {
            // Muestra solo el contratista que tiene asignado
            objComando = new OracleDataAdapter("PK_CAMBIO_PROCESO.CARGAR_NOMBRE_CONTRATISTAS", objConexion);
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

    public void carga_proceso()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_CAMBIO_PROCESO.CARGAR_PROCESOS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "PROCESO");
        objConexion.Close();

        int i = 1;
        ddProcesoCambio.Items.Clear();
        ddProcesoCambio.Items.Add("NO CAMBIAR");
        ddProcesoCambio.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["PROCESO"].Rows)
        {
            ddProcesoCambio.Items.Add(row[1].ToString());
            ddProcesoCambio.Items[i].Value = row[0].ToString();
            i = i + 1;
        }
    }
    public void carga_Grupo()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_PROCESO.CARGAR_GRUPO", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "GRUPO");
        objConexion.Close();

        int i = 1;
        ddGrupo.Items.Clear();
        ddGrupo.Items.Add("Todos...");
        ddGrupo.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["GRUPO"].Rows)
        {

            ddGrupo.Items.Add(row[1].ToString() + " - " + row[14].ToString() + " - " + row[7].ToString());
            ddGrupo.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }
    public void carga_Sincro()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_ORDEN.CARGAR_SINCRO", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "SINCRONIZACION");

        objConexion.Close();

        int i = 1;
        ddSincro.Items.Clear();
        ddSincro.Items.Add("Todos...");
        ddSincro.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["SINCRONIZACION"].Rows)
        {

            ddSincro.Items.Add(row[1].ToString());
            ddSincro.Items[i].Value = row[0].ToString();
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
    public void carga_localidad(int zona)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_LOCALIDAD.CARGA_LOCALIDAD", objConexion);
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
    public void carga_zona()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_ZONA.CARGAR_ZONA", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

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

    public void carga_ruta( int proceso, int localidad, int instalacion, int sincro, String ruta, int tipo, String desde, String hasta, int zona, string contratista)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        int id_servicio;
        int numero_orden ;

        if (TextboxNumOrden.Text == "")
        {
            numero_orden = 0;
        }
        else
        {
            numero_orden = int.Parse(TextboxNumOrden.Text);
        }


        if (txtServ.Text == "")
        {
            id_servicio = 0;
        }
        else {
            id_servicio = int.Parse(txtServ.Text);
        }

        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
        int id_contratis = int.Parse(PRO.recSession(rutaXml, "ID_CONTRATISTA"));

        objConexion.Open();
        objComando = new OracleDataAdapter("PRUEBAS.CARGAR_RUTA2", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_proceso", OracleType.Int32, ParameterDirection.Input, proceso.ToString());
        PRO.agrega_parametro_sp(objComando, "i_localidad", OracleType.Int32, ParameterDirection.Input, localidad.ToString());
        PRO.agrega_parametro_sp(objComando, "i_instalacion", OracleType.Int32, ParameterDirection.Input, instalacion.ToString());
        PRO.agrega_parametro_sp(objComando, "i_idSincro", OracleType.Int32, ParameterDirection.Input, sincro.ToString());
        PRO.agrega_parametro_sp(objComando, "i_ruta", OracleType.NVarChar, ParameterDirection.Input, ruta);
        PRO.agrega_parametro_sp(objComando, "i_tipo", OracleType.Int32, ParameterDirection.Input, tipo.ToString());
        PRO.agrega_parametro_sp(objComando, "i_rutem", OracleType.NVarChar, ParameterDirection.Input, PRO.recSession(rutaXml, "RUT_EMPRESA"));
        PRO.agrega_parametro_sp(objComando, "i_fechaDesde", OracleType.NVarChar, ParameterDirection.Input, desde);
        PRO.agrega_parametro_sp(objComando, "i_fechaHasta", OracleType.NVarChar, ParameterDirection.Input, hasta);
        PRO.agrega_parametro_sp(objComando, "i_serv", OracleType.Int32, ParameterDirection.Input, id_servicio.ToString());
        PRO.agrega_parametro_sp(objComando, "i_idZona", OracleType.Int32, ParameterDirection.Input, zona.ToString());
        PRO.agrega_parametro_sp(objComando, "i_numero_orden", OracleType.Int32, ParameterDirection.Input,numero_orden.ToString()); //

        if (id_contratis == 0)
        {   // Muestra todos los contratistas
            PRO.agrega_parametro_sp(objComando, "i_id_contratista", OracleType.NVarChar, ParameterDirection.Input, contratista.ToString());
        }
        else
        {   // Muestra solo el contratista que tiene asignado
            PRO.agrega_parametro_sp(objComando, "i_id_contratista", OracleType.NVarChar, ParameterDirection.Input, id_contratis.ToString());
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

    public void carga_grilla(int proceso, int localidad, int instalacion, int sincro, String ruta, int tipo, String desde, String hasta, int zona, string contratista)
    {
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
        int id_contratis = 0;
        id_contratis = int.Parse(PRO.recSession(rutaXml, "ID_CONTRATISTA"));

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_CAMBIO_PROCESO.CARGAR_ORDENES", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        // PONE VISIBLE LA COLUMNA ID_SINCRONIZACION Y ID_ORDEN PARA LLENARLA 
        //(SI NO SE PONE VISIBLE NO SE LLENA)
        gridOrden.Columns[17].Visible = true;
        gridOrden.Columns[0].Visible = true;

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_proceso", OracleType.Int32, ParameterDirection.Input, proceso.ToString());

        if (TextboxNumOrden.Text == "")
        {
            TextboxNumOrden.Text = "0";
        }

        if (txtServ.Text == "")
        {
            txtServ.Text = "0";
        }

        PRO.agrega_parametro_sp(da, "i_numero_orden", OracleType.Number, ParameterDirection.Input, TextboxNumOrden.Text);
        PRO.agrega_parametro_sp(da, "i_localidad", OracleType.Int32, ParameterDirection.Input, localidad.ToString());
        PRO.agrega_parametro_sp(da, "i_instalacion", OracleType.Int32, ParameterDirection.Input, instalacion.ToString());
        PRO.agrega_parametro_sp(da, "i_idSincro", OracleType.Int32, ParameterDirection.Input, sincro.ToString());
        PRO.agrega_parametro_sp(da, "i_ruta", OracleType.NVarChar, ParameterDirection.Input, ruta);
        PRO.agrega_parametro_sp(da, "i_tipo", OracleType.Int32, ParameterDirection.Input, tipo.ToString());
        PRO.agrega_parametro_sp(da, "i_rutem", OracleType.NVarChar, ParameterDirection.Input, PRO.recSession(rutaXml, "RUT_EMPRESA"));
        PRO.agrega_parametro_sp(da, "i_fechaDesde", OracleType.NVarChar, ParameterDirection.Input, desde);
        PRO.agrega_parametro_sp(da, "i_fechaHasta", OracleType.NVarChar, ParameterDirection.Input, hasta);
        PRO.agrega_parametro_sp(da, "i_serv", OracleType.Int32, ParameterDirection.Input, txtServ.Text);
        PRO.agrega_parametro_sp(da, "i_idZona", OracleType.Int32, ParameterDirection.Input, zona.ToString());
        PRO.agrega_parametro_sp(da, "i_id_contratista", OracleType.NVarChar, ParameterDirection.Input, contratista);

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
        catch (Exception ex)
        {
            lbErrorGrilla.Text = ex.ToString() + txtServ.Text;
            lbErrorGrilla.ForeColor = System.Drawing.Color.Red;

            lbErrorGrilla.Text = ex.ToString() + TextboxNumOrden.Text;
            lbErrorGrilla.ForeColor = System.Drawing.Color.Red;

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
        dt.Columns.Add(new DataColumn("ID_SINCRONIZACION", typeof(Int32)));
        dt.Columns.Add(new DataColumn("DESCRIPCION", typeof(String)));
        dt.Columns.Add(new DataColumn("NOMBRE", typeof(String)));
        dt.Columns.Add(new DataColumn("APELLIDO", typeof(String)));
        dt.Columns.Add(new DataColumn("FECHA_INTEGRACION", typeof(String)));
        dt.Columns.Add(new DataColumn("dias_transcurridos", typeof(Int32)));
        dt.Columns.Add(new DataColumn("CONTRATISTA", typeof(String)));

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
            dr["ID_SINCRONIZACION"] = drOrdenItem["ID_SINCRONIZACION"].ToString();
            dr["FECHA_INTEGRACION"] = drOrdenItem["FECHA_INTEGRACION"].ToString().Replace(" 0:00:00", "");
            dr["dias_transcurridos"] = drOrdenItem["DIFERENCIA"].ToString();
            dr["CONTRATISTA"] = drOrdenItem["CONTRATISTA"].ToString();

            dr["NOMBRE"] = drOrdenItem["NOMBRE"].ToString() + " " + drOrdenItem["APELLIDO"].ToString();

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
        CheckBox chk_as;

        for (i = 0; i < gridOrden.Rows.Count; i++)
        {

            gvRow = gridOrden.Rows[i];
            chk_as = ((CheckBox)gvRow.FindControl("check_cambio"));

            if (gridOrden.Rows[i].Cells[17].Text == "4")
            {
                chk_as.Enabled = false;
            }
        }

        // PONE INVISIBLES LAS COLUMNAS CON LOS ID
        gridOrden.Columns[0].Visible = false;
        gridOrden.Columns[17].Visible = false;
        //gridOrden.Columns[10].Visible = false;
        gridOrden.Columns[12].Visible = false;
        gridOrden.Columns[14].Visible = false;

        //carga_ruta(txtServ.Text, int.Parse(ddGrupo.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), int.Parse(ddSincro.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue));

    }

    public Boolean valida_check()
    {
        int c;
        Boolean check = false;

        GridViewRow gvRow;
        CheckBox check_row = new CheckBox();
        for (c = 0; c < gridOrden.Rows.Count; c++)
        {
            gvRow = gridOrden.Rows[c];
            check_row = (CheckBox)(gvRow.FindControl("check_cambio"));
            if (check_row.Checked == true && gridOrden.Rows[c].Cells[17].Text != "4")
            {
                check = true;
            }
        }
        return check;
    }

    /* -------------------BOTON PARA CAMBIAR PROCESO Y CONTRATISTA A ORDEN ----------- */

    protected void btnCambio_Proceso_Click(object sender, EventArgs e)
    {
        gridOrden.Columns[17].Visible = true;
        gridOrden.Columns[0].Visible = true;

        int pro = int.Parse(ddProcesoCambio.SelectedValue);

        if (pro==0)
        {
            lbResultado.ForeColor = System.Drawing.Color.Red;
            lbResultado.Text = "Ingrese proceso al que desea cambiar las ordenes";

            IMG2.Visible = false;
            IMG5.Visible = true;
            IMG6.Visible = false;
            gridOrden.Columns[17].Visible = false;
            gridOrden.Columns[0].Visible = false;
        }
        else
        {
            String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";

            IMG2.Visible = false;
            IMG5.Visible = false;
            IMG6.Visible = false;

            lbResultado.Text = "";
            IMG2.Visible = false;
            IMG5.Visible = false;
            IMG6.Visible = false;
            
            lbResultado.Text = "";

                if (valida_check() == true)
                {

                    IMG2.Visible = false;
                    IMG5.Visible = false;
                    IMG6.Visible = false;

                    lbResultado.Text = "";
                    int i;
                    GridViewRow gvRow;

                    CheckBox check_permiso = new CheckBox();

                    OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
                    OracleDataAdapter ComandoDA;

                    for (i = 0; i < gridOrden.Rows.Count; i++)
                    {
                        gvRow = gridOrden.Rows[i];

                        check_permiso = (CheckBox)(gvRow.FindControl("check_cambio"));

                        if (check_permiso.Checked == true && gridOrden.Rows[i].Cells[17].Text != "4")
                        {
                            objConexion.Open();

                                // cambia proceso de una orden
                                ComandoDA = new OracleDataAdapter("PK_CAMBIO_PROCESO.CAMBIAR_PROCESO", objConexion);
                                ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;
                                PRO.agrega_parametro_sp(ComandoDA, "i_orden", OracleType.Int32, ParameterDirection.Input, gridOrden.Rows[i].Cells[0].Text);
                                PRO.agrega_parametro_sp(ComandoDA, "i_proceso", OracleType.Int32, ParameterDirection.Input, ddProcesoCambio.SelectedValue);
                                
                            try
                            {
                                ComandoDA.SelectCommand.ExecuteNonQuery();
                                objConexion.Close();

                                lbResultado.ForeColor = System.Drawing.Color.Blue;
                                lbResultado.Text = "Se cambio de proceso exitosamente.";

                                IMG2.Visible = true;
                                IMG5.Visible = false;
                                IMG6.Visible = false;

                                gridOrden.Columns[10].Visible = false;
                                gridOrden.Columns[0].Visible = false;
                            }
                            catch (Exception ex)
                            {
                                lbResultado.ForeColor = System.Drawing.Color.Red;
                                lbResultado.Text = "Error al cambiar de proceso la orden " + gridOrden.Rows[i].Cells[0].Text + ". Descripción: " + ex.Message.ToString();
                                IMG2.Visible = false;
                                //IMG4.Visible = false;
                                IMG5.Visible = true;
                                IMG6.Visible = false;

                                break;
                            }
                        }
                    }
                    gridOrden.Columns[17].Visible = false;
                    gridOrden.Columns[0].Visible = false;
                    objConexion.Dispose();
                    carga_grilla(int.Parse(ddGrupo.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), int.Parse(ddSincro.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), ddContratista.SelectedValue);

                }
                else
                {
                    lbResultado.ForeColor = System.Drawing.Color.Red;
                    lbResultado.Text = "Seleccione al menos una orden para cambiar de proceso.";
                    IMG2.Visible = false;
                    IMG5.Visible = false;
                    IMG6.Visible = true;
                    gridOrden.Columns[17].Visible = false;
                    gridOrden.Columns[0].Visible = false;

                } //Valida_seleccion_Checkbox()
        }
    }

    protected void btnCrearProceso(object sender, EventArgs e) {

     
    }

    protected void gridOrden_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "check_cambio")
        {
            checkTodos("check_cambio");
        }

     
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        carga_grilla(int.Parse(ddGrupo.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), int.Parse(ddSincro.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), ddContratista.SelectedValue);
    }

    public void checkTodos(String check)
    {
        int c;

        GridViewRow gvRow;
        CheckBox check_row = new CheckBox();
        for (c = 0; c < gridOrden.Rows.Count; c++)
        {

            gvRow = gridOrden.Rows[c];
            check_row = (CheckBox)(gvRow.FindControl(check));

            if ((check_row.Enabled == true))
            {
                if ((check_row.Checked == true))
                {
                    check_row.Checked = false;
                }
                else
                {
                    check_row.Checked = true;
                }
            }
        }
    }

    protected void ddZona_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_localidad(int.Parse(ddZona.SelectedValue));
        carga_grilla( int.Parse(ddGrupo.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), int.Parse(ddSincro.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue),ddContratista.SelectedValue);
    }
    protected void ddGrupo_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla( int.Parse(ddGrupo.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), int.Parse(ddSincro.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), ddContratista.SelectedValue);
    }
    protected void gridOrden_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //gridOrden.PageIndex = e.NewPageIndex;
        gridOrden.PageIndex = e.NewPageIndex;
        carga_grilla(int.Parse(ddGrupo.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), int.Parse(ddSincro.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), ddContratista.SelectedValue);
    }
    protected void ddRuta_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla( int.Parse(ddGrupo.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), int.Parse(ddSincro.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), ddContratista.SelectedValue);
    }
    protected void ddTipoPro_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla( int.Parse(ddGrupo.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), int.Parse(ddSincro.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), ddContratista.SelectedValue);
    }
    protected void ddLocalidad_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_ruta(int.Parse(ddGrupo.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), int.Parse(ddSincro.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), ddContratista.SelectedValue);
        carga_grilla( int.Parse(ddGrupo.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), int.Parse(ddSincro.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), ddContratista.SelectedValue);
    }
    protected void ddEstado_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla( int.Parse(ddGrupo.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), int.Parse(ddSincro.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), ddContratista.SelectedValue);
    }
    protected void ddTipoIn_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla( int.Parse(ddGrupo.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), int.Parse(ddSincro.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), ddContratista.SelectedValue);
    }
    protected void ddSincro_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla( int.Parse(ddGrupo.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), int.Parse(ddSincro.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), ddContratista.SelectedValue);
    }
    protected void txtServ_TextChanged(object sender, EventArgs e)
    {
        carga_grilla( int.Parse(ddGrupo.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), int.Parse(ddSincro.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), ddContratista.SelectedValue);
    }
    protected void Button1_Click1(object sender, EventArgs e)
    {
        carga_grilla( int.Parse(ddGrupo.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), int.Parse(ddSincro.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), ddContratista.SelectedValue);
    }
    protected void lkbAsignar_Click(object sender, EventArgs e)
    {

    }

    /* ------------------Evento para actualizar la tabla segun el numero de orden que se busca---------------------------------*/

    protected void txtNumOrden_TextChanged(object sender, EventArgs e)
    {
        carga_grilla( int.Parse(ddGrupo.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), int.Parse(ddSincro.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue), ddContratista.SelectedValue);
    }

    protected void ddContratista_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla( int.Parse(ddGrupo.SelectedValue), int.Parse(ddLocalidad.SelectedValue), int.Parse(ddTipoIn.SelectedValue), int.Parse(ddSincro.SelectedValue), ddRuta.SelectedValue.ToString(), int.Parse(ddTipoPro.SelectedValue.ToString()), txtDesde.Text, txtHasta.Text, int.Parse(ddZona.SelectedValue),ddContratista.SelectedValue);
    }

    /* ------------------COLORES DE LA GRILLA (SLA) -------------------------*/
    protected void gridOrden_RowDataBound(object sender, GridViewRowEventArgs e)
    {
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        Int32 dias_transcurridos = Int32.Parse(DataBinder.Eval(e.Row.DataItem, "dias_transcurridos").ToString());
    //        Int32 ID_TIPO_PROCESO = Int32.Parse(DataBinder.Eval(e.Row.DataItem, "ID_TIPO_PROCESO").ToString());

    //        if (ID_TIPO_PROCESO == 2)
    //        {

    //            if (dias_transcurridos < 4)
    //            {
    //                e.Row.BackColor = System.Drawing.Color.White;
    //            }
    //            if (dias_transcurridos == 4)
    //            {
    //                e.Row.BackColor = System.Drawing.Color.LightBlue;
    //            }
    //            if (dias_transcurridos == 5)
    //            {
    //                e.Row.BackColor = System.Drawing.Color.Yellow;
    //            }
    //            if (dias_transcurridos >= 6)
    //            {
    //                e.Row.BackColor = System.Drawing.Color.Orange;
    //            }

    //        }
    //        else
    //        {
    //            if ((dias_transcurridos / 3) < 4)
    //            {
    //                e.Row.BackColor = System.Drawing.Color.White;
    //            }
    //            if ((dias_transcurridos / 3) == 4)
    //            {
    //                e.Row.BackColor = System.Drawing.Color.LightBlue;
    //            }
    //            if ((dias_transcurridos / 3) == 5)
    //            {
    //                e.Row.BackColor = System.Drawing.Color.Yellow;
    //            }
    //            if ((dias_transcurridos / 3) >= 6)
    //            {
    //                e.Row.BackColor = System.Drawing.Color.Orange;
    //            }
    //        }
    //    }
    }

    protected void gridOrden_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}