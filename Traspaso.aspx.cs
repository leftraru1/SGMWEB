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

public partial class Traspaso : System.Web.UI.Page
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
    public String strA = null;
    public String strB = null;
    public String strC = null;
    public String Str_Grupo_Proceso = null;
    public static String id_usuario;
    public static string id_contratista;
    
    //Carga fecha , llama la fecha actual por defecto 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {


            try
            {
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                lb_rut_empresa.Text = PRO.recSession(rutaXml, "RUT_EMPRESA");
                id_usuario= PRO.recSession(rutaXml, "ID_USUARIO");
                id_contratista = PRO.recSession(rutaXml, "ID_CONTRATISTA");

                fecha_despacho.Text = DateTime.Today.ToString("dd/MM/yyyy");
                carga_bodegas_origen(id_contratista,id_usuario);
                carga_contratistas();
                carga_regiones(ddbodegas_origen.SelectedValue);
                carga_bodegas_destino(int.Parse(ddcontratista.SelectedValue),int.Parse(ddregion.SelectedValue),int.Parse(ddbodegas_origen.SelectedValue));
                carga_filtros_traspaso(ddbodegas_origen.SelectedValue);
                carga_accesorios();
                carga_medidores_ingresados();

            }
            catch (Exception ex)
            {
                //Response.Redirect("errorSesion.aspx");
            }
        }
    }

    public void carga_medidores_ingresados()
    {
        medidores.Columns[0].Visible = true;
        medidores.Columns[1].Visible = true;
        medidores.Columns[4].Visible = true;
        medidores.Columns[7].Visible = true;
        medidores.Columns[9].Visible = true;

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_TRASPASO.CARGA_GRILLA_MEDIDORES", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
        id_contratista = PRO.recSession(rutaXml, "ID_CONTRATISTA");

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_bodega", OracleType.Number, ParameterDirection.Input, ddbodegas.SelectedValue);
        PRO.agrega_parametro_sp(da, "i_bodega_origen", OracleType.Number, ParameterDirection.Input, ddbodegas_origen.SelectedValue);
        PRO.agrega_parametro_sp(da, "i_contratista", OracleType.Number, ParameterDirection.Input, id_contratista);

        PRO.agrega_parametro_sp(da, "i_diametro", OracleType.Number, ParameterDirection.Input, ddDiametroMed.SelectedValue);
        long n;
        bool isNumeric = long.TryParse(ddSerieDesde.Text.ToString(), out n);
        String serie_desde = "0";
        if (isNumeric) serie_desde = ddSerieDesde.Text.ToString();

        PRO.agrega_parametro_sp(da, "i_serie_desde", OracleType.Number, ParameterDirection.Input, serie_desde);

        isNumeric = long.TryParse(ddSerieHasta.Text.ToString(), out n);
        String serie_hasta = "0";
        if (isNumeric) serie_hasta = ddSerieHasta.Text.ToString();

        PRO.agrega_parametro_sp(da, "i_serie_hasta", OracleType.Number, ParameterDirection.Input,serie_hasta);
        PRO.agrega_parametro_sp(da, "i_marca", OracleType.Number, ParameterDirection.Input, ddMarcaMed.SelectedValue);

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
        dt.Columns.Add(new DataColumn("CODIGO", typeof(String)));
        dt.Columns.Add(new DataColumn("DESCRIPCION", typeof(String)));
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
            dr["CODIGO"] = drOrdenItem["CODIGO"].ToString();
            dr["DESCRIPCION"] = drOrdenItem["FABRICANTE"].ToString() + " " + drOrdenItem["MODELO"].ToString() + " D" + drOrdenItem["DIAMETRO"].ToString();
            
            dt.Rows.Add(dr);

            total = total + 1;

        }


        DataView MydataView;
        MydataView = new DataView(dt);
        medidores.DataSource = MydataView;
        medidores.DataBind();

        medidores.Columns[0].Visible = false;
        medidores.Columns[1].Visible = false;
        medidores.Columns[4].Visible = false;
        medidores.Columns[7].Visible = false;
        medidores.Columns[9].Visible = false;
    }

    public void carga_contratistas()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_CARGA_DD_GUIA.CARGA_CONTRATISTAS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "CONTRATISTAS");
        objConexion.Close();

        int i = 0;
        ddcontratista.Items.Clear();

        foreach (DataRow row in objDS.Tables["CONTRATISTAS"].Rows)
        {

            ddcontratista.Items.Add(row[1].ToString());
            ddcontratista.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }

    public void carga_regiones(String id_bodega)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_TRASPASO.CARGA_REGION", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_bodega", OracleType.Number, ParameterDirection.Input, id_bodega);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "REGIONES");
        objConexion.Close();

        int i = 0;
        ddregion.Items.Clear();

        foreach (DataRow row in objDS.Tables["REGIONES"].Rows)
        {

            ddregion.Items.Add(row[1].ToString());
            ddregion.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }


    public void carga_articulos()
    {

        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_CARGA_DD_GUIA.CARGA_ARTICULOS", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        articulos.Columns[0].Visible = true;

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "numero_guia", OracleType.Number, ParameterDirection.Input, numero_guia.Text);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        DataTable dtArticulos = new DataTable();

        try
        {
            CnOra.Open();
            da.Fill(dtArticulos);
            CnOra.Close();
            CnOra.Dispose();


        }
        catch (Exception ex){

        }

        DataTable dt = new DataTable();

        dt.Columns.Add(new DataColumn("ID_DETALLE_GUIA", typeof(String)));
        dt.Columns.Add(new DataColumn("ID_GUIA", typeof(String)));
        dt.Columns.Add(new DataColumn("CODIGO_ARTICULO", typeof(String)));
        dt.Columns.Add(new DataColumn("NOMBRE_ARTICULO", typeof(String)));
        dt.Columns.Add(new DataColumn("CANTIDAD", typeof(String)));
        dt.Columns.Add(new DataColumn("DIAMETRO", typeof(String)));
        dt.Columns.Add(new DataColumn("NUMERO_GUIA", typeof(String)));

        DataRow dr;

        int total = 0;

        foreach (DataRow drArticulo in dtArticulos.Rows)
        {

            dr = dt.NewRow();

            dr["ID_DETALLE_GUIA"] = drArticulo["ID_DETALLE_GUIA"].ToString();
            dr["ID_GUIA"] = drArticulo["ID_GUIA"].ToString();
            dr["NUMERO_GUIA"] = numero_guia.Text;
            dr["CODIGO_ARTICULO"] = drArticulo["CODIGO_ARTICULO"].ToString();
            dr["NOMBRE_ARTICULO"] = drArticulo["NOMBRE_ARTICULO"].ToString();
            dr["CANTIDAD"] = drArticulo["CANTIDAD"].ToString();
            dr["DIAMETRO"] = drArticulo["DIAMETRO"].ToString();

            dt.Rows.Add(dr);

            total = total + 1;

        }

        DataView MydataView;
        MydataView = new DataView(dt);
        articulos.DataSource = MydataView;
        articulos.DataBind();

        articulos.Columns[0].Visible = false;
        articulos.Columns[1].Visible = false;

    }

    public void carga_bodegas_destino(int contratista,int region,int bodega)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_TRASPASO.CARGA_BODEGAS_DESTINO", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "contratista", OracleType.Number, ParameterDirection.Input, contratista.ToString());
        PRO.agrega_parametro_sp(objComando, "region", OracleType.Number, ParameterDirection.Input, region.ToString());
        PRO.agrega_parametro_sp(objComando, "bodega", OracleType.Number, ParameterDirection.Input, bodega.ToString());

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "BODEGAS");
        objConexion.Close();

        int i = 0;
        ddbodegas.Items.Clear();

        foreach (DataRow row in objDS.Tables["BODEGAS"].Rows)
        {

            ddbodegas.Items.Add(row[1].ToString());
            ddbodegas.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }

    public void carga_bodegas_origen(String contratista,String usuario)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_TRASPASO.CARGA_BODEGAS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "contratista", OracleType.Number, ParameterDirection.Input, contratista);
        PRO.agrega_parametro_sp(objComando, "usuario", OracleType.Number, ParameterDirection.Input, usuario);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "BODEGAS");
        objConexion.Close();

        int i = 0;
        ddbodegas_origen.Items.Clear();

        if (objDS.Tables["BODEGAS"].Rows.Count == 0)
        {
            i = 1;
            ddbodegas_origen.Items.Clear();
            ddbodegas_origen.Items.Add("SIN BODEGAS ASIGNADAS");
            ddbodegas_origen.Items[i].Value = "0";
        }

        foreach (DataRow row in objDS.Tables["BODEGAS"].Rows)
        {

            ddbodegas_origen.Items.Add(row[1].ToString());
            ddbodegas_origen.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }

    public Boolean valida_numero_guia(String numero_guia)
    {
        try
        {
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();

            objConexion.Open();
            objComando = new OracleDataAdapter("PK_INSERTA_MEDIDORES.VALIDA_NUMERO_GUIA", objConexion);
            objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

            try
            {

                PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
                PRO.agrega_parametro_sp(objComando, "numero_guia", OracleType.Number, ParameterDirection.Input, numero_guia);

            }
            catch (Exception ex)
            {
                return false;
            }

            objComando.SelectCommand.ExecuteNonQuery();
            objComando.Fill(objDS, "NUMERO_GUIA");
            objConexion.Close();

            int i = 0;

            foreach (DataRow row in objDS.Tables["NUMERO_GUIA"].Rows)
            {

                return false;
            }
        }
        catch (Exception ex)
        {
            return false;
        }

        return true;
    }

    public void init_diseno_campos()
    {
        //numero_guia
        numero_guia.ForeColor = System.Drawing.Color.Black;
        numero_guia.BorderColor = System.Drawing.ColorTranslator.FromHtml("#94B1E5");

        //reserva
        reserva.ForeColor = System.Drawing.Color.Black;
        reserva.BorderColor = System.Drawing.ColorTranslator.FromHtml("#94B1E5");

        //fecha despacho
        fecha_despacho.ForeColor = System.Drawing.Color.Black;
        fecha_despacho.BorderColor = System.Drawing.ColorTranslator.FromHtml("#94B1E5");

        //despachado_por
        despachado_por.ForeColor = System.Drawing.Color.Black;
        despachado_por.BorderColor = System.Drawing.ColorTranslator.FromHtml("#94B1E5");

        //rut_despacho
        rut_despacho.ForeColor = System.Drawing.Color.Black;
        rut_despacho.BorderColor = System.Drawing.ColorTranslator.FromHtml("#94B1E5");

        //rut_entidad
        rut_entidad.ForeColor = System.Drawing.Color.Black;
        rut_entidad.BorderColor = System.Drawing.ColorTranslator.FromHtml("#94B1E5");

        //rut_retiro
        rut_retiro.ForeColor = System.Drawing.Color.Black;
        rut_retiro.BorderColor = System.Drawing.ColorTranslator.FromHtml("#94B1E5");

        //retirado_por
        retirado_por.ForeColor = System.Drawing.Color.Black;
        retirado_por.BorderColor = System.Drawing.ColorTranslator.FromHtml("#94B1E5");

        //vehiculo
        vehiculo.ForeColor = System.Drawing.Color.Black;
        vehiculo.BorderColor = System.Drawing.ColorTranslator.FromHtml("#94B1E5");

        //patente
        patente.ForeColor = System.Drawing.Color.Black;
        patente.BorderColor = System.Drawing.ColorTranslator.FromHtml("#94B1E5");

        //fono
        fono.ForeColor = System.Drawing.Color.Black;
        fono.BorderColor = System.Drawing.ColorTranslator.FromHtml("#94B1E5");
    }

    public Boolean valida_campos_guia()
    {
        //VALIDAMOS LOS CAMPOS.
        //Número de guia -> numérico y único.
        init_diseno_campos();
        long n;
        if (!long.TryParse(numero_guia.Text, out n))
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('Número de guía debe ser numérico');", true);
            numero_guia.Focus();
            numero_guia.BorderColor = System.Drawing.Color.Red;
            return false;
        }
        else if (!valida_numero_guia(numero_guia.Text))
        {            
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('Número de guía ya existe en plataforma');", true);

            numero_guia.Focus();
            numero_guia.BorderColor = System.Drawing.Color.Red;
            return false;
        }

        //Fecha se valida con el objeto regular expression.
        if (fecha_despacho.Text.Length == 0)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('Ingrese fecha de despacho');", true);
            fecha_despacho.Focus();
            fecha_despacho.BorderColor = System.Drawing.Color.Red;
            return false;
        }

        //Se debe ingresar un nro reserva
        if (reserva.Text.Length == 0)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('Ingrese nro reserva');", true);
            reserva.Focus();
            reserva.BorderColor = System.Drawing.Color.Red;
            return false;
        }
        //Número de reserva ->  numérico.
        //if (!long.TryParse(reserva.Text, out n))
        //{
        //    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('Número de reserva debe ser numérico');", true);
        //    reserva.Focus();
        //    reserva.BorderColor = System.Drawing.Color.Red;
        //    return false;
        //}

        //Despachado por
        if (despachado_por.Text.Length == 0)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('Ingrese el nombre del despachador');", true);
            despachado_por.Focus();
            despachado_por.BorderColor = System.Drawing.Color.Red;
            return false;
        }

        //Rut despachador
        if (!ValidaRut(rut_despacho.Text))
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('Rut del despachado inválido');", true);
            rut_despacho.Focus();
            rut_despacho.BorderColor = System.Drawing.Color.Red;
            return false;
        }

        //Rut entidad despachador
        if (!ValidaRut(rut_entidad.Text))
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('Rut de la entidad que despacha inválido');", true);
            rut_entidad.Focus();
            rut_entidad.BorderColor = System.Drawing.Color.Red;
            return false;
        }

        //Retirado por
        if (retirado_por.Text.Length == 0)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('Ingrese el nombre de la persona que retira');", true);
            retirado_por.Focus();
            retirado_por.BorderColor = System.Drawing.Color.Red;
            return false;
        }

        //Rut persona que retira
        if (!ValidaRut(rut_retiro.Text))
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('Rut de la persona qe retira inválido');", true);
            rut_retiro.Focus();
            rut_retiro.BorderColor = System.Drawing.Color.Red;
            return false;
        }

        //Vehiculo
        if (vehiculo.Text.Length == 0)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('Ingrese vehiculo');", true);
            vehiculo.Focus();
            vehiculo.BorderColor = System.Drawing.Color.Red;
            return false;
        }

        //patente
        if (patente.Text.Length == 0)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('Ingrese patente');", true);
            patente.Focus();
            patente.BorderColor = System.Drawing.Color.Red;
            return false;
        }

        //fono
        if (fono.Text.Length == 0)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('Ingrese fono');", true);
            fono.Focus();
            fono.BorderColor = System.Drawing.Color.Red;
            return false;
        }
        else if (!long.TryParse(fono.Text, out n))
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('fono debe ser sólo numérico');", true);
            fono.Focus();
            fono.BorderColor = System.Drawing.Color.Red;
            return false;
        }

        if (subir_respaldo(numero_guia.Text) == false)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('Debe subir una foto de respaldo');", true);
            file.Focus();
            return false;
        }

        return true;
    }

    protected void genera_guia_Click(object sender, EventArgs e)
    {
        
         
        if(!bodega_origen_con_stock(ddbodegas_origen.SelectedValue)){
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('Bodega no tiene stock disponible para traspasar');", true);
        } else if(valida_campos_guia()){


            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            objConexion.Open();
            OracleDataAdapter ComandoDA = new OracleDataAdapter("PK_INSERTA_MEDIDORES.INSERTA_GUIA", objConexion);

            ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

            PRO.agrega_parametro_sp(ComandoDA, "numero_guia", OracleType.Number, ParameterDirection.Input, numero_guia.Text);
            PRO.agrega_parametro_sp(ComandoDA, "fecha_despacho", OracleType.NVarChar, ParameterDirection.Input, fecha_despacho.Text);
            PRO.agrega_parametro_sp(ComandoDA, "retira", OracleType.NVarChar, ParameterDirection.Input, retirado_por.Text);
            PRO.agrega_parametro_sp(ComandoDA, "rut_retira", OracleType.NVarChar, ParameterDirection.Input, rut_retiro.Text);
            PRO.agrega_parametro_sp(ComandoDA, "despacho", OracleType.NVarChar, ParameterDirection.Input, despachado_por.Text);
            PRO.agrega_parametro_sp(ComandoDA, "rut_despacho", OracleType.NVarChar, ParameterDirection.Input, rut_despacho.Text);
            PRO.agrega_parametro_sp(ComandoDA, "region", OracleType.NVarChar, ParameterDirection.Input, ddregion.SelectedValue);
            PRO.agrega_parametro_sp(ComandoDA, "contratista", OracleType.NVarChar, ParameterDirection.Input, ddcontratista.SelectedValue);
            PRO.agrega_parametro_sp(ComandoDA, "vehiculo", OracleType.NVarChar, ParameterDirection.Input, vehiculo.Text);
            PRO.agrega_parametro_sp(ComandoDA, "bodega", OracleType.Number, ParameterDirection.Input, ddbodegas.SelectedValue);
            PRO.agrega_parametro_sp(ComandoDA, "patente", OracleType.NVarChar, ParameterDirection.Input, patente.Text);
            PRO.agrega_parametro_sp(ComandoDA, "reserva", OracleType.NVarChar, ParameterDirection.Input, reserva.Text);
            PRO.agrega_parametro_sp(ComandoDA, "usuario", OracleType.Number, ParameterDirection.Input, id_usuario);
            PRO.agrega_parametro_sp(ComandoDA, "i_bodega_origen", OracleType.Number, ParameterDirection.Input, ddbodegas_origen.SelectedValue);

            try
            {
                ComandoDA.SelectCommand.ExecuteNonQuery();
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "creo_guia();", true);
                    carga_articulos();
                    panel1.Visible = false;
                    Div1.Visible = false;
                    Div2.Visible = false;
                    panel2.Visible = true;
                    carga_filtros_traspaso(ddbodegas_origen.SelectedValue);

            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('No se pudo subir la guía');", true);
            }
            objConexion.Close();
            objConexion.Dispose();
            objConexion = null;
            
        }
    }

    public Boolean bodega_origen_con_stock(String bodega)
    {
        try
        {
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();

            objConexion.Open();
            objComando = new OracleDataAdapter("PK_TRASPASO.VALIDA_BODEGA_CON_STOCK", objConexion);
            objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

            PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
            PRO.agrega_parametro_sp(objComando, "i_id_bodega", OracleType.Number, ParameterDirection.Input, bodega);

            objComando.SelectCommand.ExecuteNonQuery();
            objComando.Fill(objDS, "VALIDA");
            objConexion.Close();


            foreach (DataRow row in objDS.Tables["VALIDA"].Rows)
            {
                if (int.Parse(row[0].ToString()) > 0) return true;
            }

            return false;
        }
        catch (Exception ex)
        {
            return false;
        }

    }

    public Boolean subir_respaldo(string numero_guia) {
        
        //string path = @"C:\Users\PABLO-CRUZ\Documents\Visual Studio 2012\Projects\SGM";
        string path = "/FOTOS_GUIA/" + numero_guia + "/";
        Directory.CreateDirectory(path);

        if (!Directory.Exists(Server.MapPath("./" + path + "/"))) System.IO.Directory.CreateDirectory(Server.MapPath("./" + path + "/"));

        path = Server.MapPath("./" + path + "/");


        Boolean boo=false;

        try
        {

            String fileExtension_1 = file.PostedFile.ContentType.Replace("application/", ".").Replace("image/", ".");
            //fileExtension_1.Replace("application/","." );

            if (valida_extension_imagen(fileExtension_1) == true)
            {
                int contentLength = file.PostedFile.ContentLength;
                string fileName = file.PostedFile.FileName;
                file.PostedFile.SaveAs(path + " RESPALDO_" + numero_guia + extension_imagen(fileExtension_1));
                boo = true;
            }
            else {
                
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " Error('');", true);
                return false;
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " Error('');", true);
            boo = false;
        }

        return boo;
    }

    public Boolean valida_extension_imagen(String extension)
    {

        String[] allowedExtensions = { ".jpg", ".pdf", ".png", ".jpeg" };

        for (int i = 0; i < allowedExtensions.Length; i++)
        {
            if (extension == allowedExtensions[i])
            {
                return true;
            }
        }

        return false;
    }

    public String extension_imagen(String extension)
    {

        String[] allowedExtensions = { ".jpg", ".pdf", ".png", ".jpeg" };

        for (int i = 0; i < allowedExtensions.Length; i++)
        {
            if (extension == allowedExtensions[i])
            {
                return allowedExtensions[i];
            }
        }

        return "0";
    }

    
    protected void articulos_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "eliminar")
        {
            int index = int.Parse(e.CommandArgument.ToString());
            index = index % articulos.PageSize;

            int id_detalle = int.Parse(articulos.Rows[index].Cells[0].Text);

            elimina_detalle(id_detalle);

        }
    }

    public void elimina_detalle(int id){
    
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_TRASPASO.ELIMINA_DETALLE", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
        
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        //PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_detalle", OracleType.Number, ParameterDirection.Input, id.ToString());

        DataTable dtAccesorios = new DataTable();

        try
        {
            CnOra.Open();
            da.SelectCommand.ExecuteNonQuery();
            CnOra.Close();
            CnOra.Dispose();

            
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " se_elimino('');", true);
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error('Error al eliminar detalle');", true);

        }
        carga_articulos();
        carga_accesorios();
        carga_medidores_ingresados();
    }

    public void elimina_detalle_masivo(int id)
    {

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_TRASPASO.ELIMINA_DETALLE", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";

        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        //PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_detalle", OracleType.Number, ParameterDirection.Input, id.ToString());

        DataTable dtAccesorios = new DataTable();

        try
        {
            CnOra.Open();
            da.SelectCommand.ExecuteNonQuery();
            CnOra.Close();
            CnOra.Dispose();

                       
        }
        catch (Exception ex)
        {

        }
        
    }

    protected void articulos_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        articulos.PageIndex = e.NewPageIndex;
        carga_articulos();
    }
    protected void articulos_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void medidores_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void medidores_SelectedIndexChanged1(object sender, EventArgs e)
    {

    }
    protected void medidores_RowCreated(object sender, GridViewRowEventArgs e)
    {

    }
    protected void articulos_RowCreated(object sender, GridViewRowEventArgs e)
    {

    }

    public void finalizar(object sender, EventArgs e)
    {
        if (articulos.Rows.Count > 0)
        {
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter ComandoDA;

            objConexion.Open();
            ComandoDA = new OracleDataAdapter("PK_TRASPASO.CIERRA_GUIA", objConexion);
            ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;
            PRO.agrega_parametro_sp(ComandoDA, "i_guia", OracleType.Number, ParameterDirection.Input, numero_guia.Text);

            try
            {
                ComandoDA.SelectCommand.ExecuteNonQuery();
                objConexion.Close();

            }
            catch (Exception ex)
            {

            }


            objConexion.Dispose();

            panel2.Visible = false;
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "correcto('');", true);

        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('Debe traspasar al menos 1 articulo para finalizar!');", true);

        }
       
    }

    
    protected void traspaso_accesorios(){

        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter ComandoDA;
        
        String cantidad;
        TextBox x = new TextBox();
        int ok = 0, nok = 0;

        for (int i = 0; i < Accesorios.Rows.Count; i++)
        {
            x = (TextBox)(Accesorios.Rows[i].Cells[7].Controls[1]);
            cantidad = x.Text;

            if (cantidad != "")
            {
                try
                {
                    int y = int.Parse(cantidad);
                }
                catch (Exception ex)
                {
                    nok++;
                    continue;
                }

                if (int.Parse(Accesorios.Rows[i].Cells[6].Text) >= int.Parse(cantidad) && int.Parse(cantidad) > 0)
                {
                    objConexion.Open();
                    ComandoDA = new OracleDataAdapter("PK_TRASPASO.CAMBIAR_ACCESORIO", objConexion);
                    ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

                    //PRO.agrega_parametro_sp(ComandoDA, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
                    PRO.agrega_parametro_sp(ComandoDA, "i_accesorio", OracleType.Number, ParameterDirection.Input, Accesorios.Rows[i].Cells[0].Text);
                    PRO.agrega_parametro_sp(ComandoDA, "i_bodega_destino", OracleType.Number, ParameterDirection.Input, ddbodegas.SelectedValue);
                    PRO.agrega_parametro_sp(ComandoDA, "i_cantidad", OracleType.Number, ParameterDirection.Input, cantidad);
                    PRO.agrega_parametro_sp(ComandoDA, "i_guia_destino", OracleType.Number, ParameterDirection.Input, numero_guia.Text);

                    try
                    {
                        String codigo_accesorio = Accesorios.Rows[i].Cells[3].Text.Split('-')[0].Trim();
                        inserta_detalle(int.Parse(codigo_accesorio), int.Parse(Accesorios.Rows[i].Cells[4].Text), int.Parse(cantidad));
                        ComandoDA.SelectCommand.ExecuteNonQuery();

                        ok++;
                    }
                    catch (Exception ex)
                    {
                        nok++;
                        objConexion.Close();
                        continue;
                    }
                    objConexion.Close();
                }
                else {
                    //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error('Un item no tiene stock suficiente');", true);
                    Accesorios.Rows[i].Cells[6].BackColor = System.Drawing.Color.Red;
                    nok++;
                }

            }
        }

        carga_accesorios();
        if (ok > 0) ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " cambio_ordenes('" + ok + "','" + (ok + nok) + "');", true);
        else ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " cambio_ordenes_error('" + ok + "','" + (ok + nok) + "');", true);        
        
    }

    protected void inserta_detalle(int COD,int dia,int cantidad)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter ComandoDA;

        objConexion.Open();
        ComandoDA = new OracleDataAdapter("PK_CARGA_DD_GUIA.CARGA_INSERCION_DETALLE", objConexion);
        ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;
        PRO.agrega_parametro_sp(ComandoDA, "i_guia", OracleType.Number, ParameterDirection.Input,numero_guia.Text);
        PRO.agrega_parametro_sp(ComandoDA, "i_codigo", OracleType.Number, ParameterDirection.Input,COD.ToString());
        PRO.agrega_parametro_sp(ComandoDA, "i_cantidad", OracleType.Number, ParameterDirection.Input,cantidad.ToString());
         PRO.agrega_parametro_sp(ComandoDA, "i_diametro", OracleType.Number, ParameterDirection.Input,dia.ToString());

        try
        {
            ComandoDA.SelectCommand.ExecuteNonQuery();
            objConexion.Close();

        }
        catch (Exception ex)
        {
            
        }


        objConexion.Dispose();
    }

    public Boolean valida_check()
    {
        int c;
        Boolean check = false;
        //DataGridItem item_grilla;
        GridViewRow gvRow;
        CheckBox check_row = new CheckBox();
        for (c = 0; c < medidores.Rows.Count; c++)
        {
            gvRow = medidores.Rows[c];
            check_row = (CheckBox)(gvRow.FindControl("cambiar"));
            if (check_row.Checked == true)
            {
                check = true;
            }
        }
        return check;
    }

    public String valida_check_accesorios()
    {
        int c;
        String check = "NOK";
        String mayor = "";
        String texto = "";
        //DataGridItem item_grilla;
        TextBox x = new TextBox();
        String cantidad_ingreso;

        for (c = 0; c < Accesorios.Rows.Count; c++)
        {

            x = (TextBox)(Accesorios.Rows[c].Cells[7].Controls[1]);
            cantidad_ingreso = x.Text;

            if (cantidad_ingreso != "" && verifica_numero(cantidad_ingreso) == true)
            {
                if (int.Parse(cantidad_ingreso) > 0 && int.Parse(cantidad_ingreso) <= int.Parse(Accesorios.Rows[c].Cells[6].Text))
                {
                    check = "OK";
                    x.ForeColor = System.Drawing.Color.Black;
                    x.BorderColor = System.Drawing.ColorTranslator.FromHtml("#94B1E5");

                }
                else
                {
                    x.ForeColor = System.Drawing.Color.Red;
                    x.BorderColor = System.Drawing.Color.Red;

                    if (int.Parse(cantidad_ingreso) > int.Parse(Accesorios.Rows[c].Cells[5].Text)) mayor = "MAYOR";
                    else mayor = "MENOR";
                }
            }
            else
            {
                long n;
                if (!long.TryParse(cantidad_ingreso, out n) && cantidad_ingreso.Length > 0)
                {
                    x.ForeColor = System.Drawing.Color.Red;
                    x.BorderColor = System.Drawing.Color.Red;
                    texto = "TEXTO";
                    
                }
                else
                {//ok
                    x.ForeColor = System.Drawing.Color.Black;
                    x.BorderColor = System.Drawing.ColorTranslator.FromHtml("#94B1E5");
                }
                
            }
        }

        if (texto.Length > 0) return texto;
        else if (mayor.Length > 0) return mayor;
        else return check;
    }

    public Boolean verifica_numero(String texto)
    {

        try
        {

            int.Parse(texto);
        }
        catch (Exception e)
        {

            return false;

        }

        return true;
    }


    public static bool ValidaRut(string rut)
    {
        if(rut==""){

            return false;

        }

        rut = rut.Replace(".", "").ToUpper();
        Regex expresion = new Regex("^([0-9]+-[0-9K])$");
        string dv = rut.Substring(rut.Length - 1, 1);

        if (!expresion.IsMatch(rut))
        {
            return false;
        }

        char[] charCorte = { '-' };
        string[] rutTemp = rut.Split(charCorte);

        if (dv != Digito(int.Parse(rutTemp[0])))
        {
            return false;
        }
        return true;
    }

    public static string Digito(int rut)
    {
        int suma = 0;
        int multiplicador = 1;
        while (rut != 0)
        {
            multiplicador++;
            if (multiplicador == 8)
                multiplicador = 2;
            suma += (rut % 10) * multiplicador;
            rut = rut / 10;
        }
        suma = 11 - (suma % 11);
        if (suma == 11)
        {
            return "0";
        }
        else if (suma == 10)
        {
            return "K";
        }
        else
        {
            return suma.ToString();
        }
    }

    public void ddcontratista_SelectedIndexChanged(object sender, EventArgs e)
    {

        carga_bodegas_destino(int.Parse(ddcontratista.SelectedValue), int.Parse(ddregion.SelectedValue),int.Parse(ddbodegas_origen.SelectedValue));
        carga_accesorios();
        carga_medidores_ingresados();

    }
    protected void ddregion_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_bodegas_destino(int.Parse(ddcontratista.SelectedValue), int.Parse(ddregion.SelectedValue), int.Parse(ddbodegas_origen.SelectedValue));
        carga_accesorios();
        carga_medidores_ingresados();
    }



    
  

    protected void medidores_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        medidores.PageIndex = e.NewPageIndex;
        carga_medidores_ingresados();
    }
    protected void medidores_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "cambiar_todo")
        {
            checkTodos("cambiar");
        }

    }

    public void checkTodos(String check)
    {
        int c;

        GridViewRow gvRow;
        CheckBox check_row = new CheckBox();
        for (c = 0; c < medidores.Rows.Count; c++)
        {

            gvRow = medidores.Rows[c];
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

    public void carga_accesorios()
    {
        Accesorios.Columns[0].Visible = true;
        Accesorios.Columns[1].Visible = true;

        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";

        int id_contratis = 0, id_region = 0;

        id_contratis = int.Parse(PRO.recSession(rutaXml, "ID_CONTRATISTA"));
        //id_region = int.Parse(PRO.recSession(rutaXml, "ID_REGION"));

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_TRASPASO.CARGA_ACCESORIOS", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_bodega", OracleType.Number, ParameterDirection.Input, ddbodegas.SelectedValue);
        PRO.agrega_parametro_sp(da, "i_diametro", OracleType.Number, ParameterDirection.Input, ddDiametroAcc.SelectedValue);
        PRO.agrega_parametro_sp(da, "i_tipo", OracleType.Number, ParameterDirection.Input, ddTipoMaterialAcc.SelectedValue);
        PRO.agrega_parametro_sp(da, "i_bodega_origen", OracleType.Number, ParameterDirection.Input, ddbodegas_origen.SelectedValue );
        PRO.agrega_parametro_sp(da, "i_contratista", OracleType.Number, ParameterDirection.Input, id_contratis.ToString());


        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        DataTable dtAccesorios = new DataTable();

        try
        {
            CnOra.Open();
            da.Fill(dtAccesorios);
            CnOra.Close();
            CnOra.Dispose();

        }
        catch (Exception ex)
        {

        }

        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("ID_ACCESORIO", typeof(String)));
        dt.Columns.Add(new DataColumn("CODIGO_PROVEEDOR", typeof(String)));
        dt.Columns.Add(new DataColumn("STOCK_TOTAL", typeof(String)));
        dt.Columns.Add(new DataColumn("STOCK", typeof(String)));
        dt.Columns.Add(new DataColumn("ID_BODEGA", typeof(String)));
        dt.Columns.Add(new DataColumn("BODEGA", typeof(String)));
        dt.Columns.Add(new DataColumn("DIAMETRO", typeof(String)));

        DataRow dr;

        int total = 0;

        foreach (DataRow drAccesorioItem in dtAccesorios.Rows)
        {

            dr = dt.NewRow();

            dr["ID_ACCESORIO"] = drAccesorioItem["ID_ACCESORIO"].ToString();
            dr["CODIGO_PROVEEDOR"] = drAccesorioItem["CODIGO_PROVEEDOR"].ToString() + " - " + drAccesorioItem["CATEGORIA"].ToString();
            dr["STOCK_TOTAL"] = drAccesorioItem["STOCK_TOTAL"].ToString();//
            dr["STOCK"] = drAccesorioItem["STOCK"].ToString();
            dr["ID_BODEGA"] = drAccesorioItem["ID_BODEGA"].ToString();
            dr["BODEGA"] = drAccesorioItem["BODEGA"].ToString();
            dr["DIAMETRO"] = drAccesorioItem["DIAMETRO"].ToString();

            dt.Rows.Add(dr);

            total = total + 1;

        }

        DataView MydataView;
        MydataView = new DataView(dt);
        Accesorios.DataSource = MydataView;
        Accesorios.DataBind();

        Accesorios.Columns[0].Visible = false;
        Accesorios.Columns[1].Visible = false;
    }

    protected void Accesorios_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        Accesorios.PageIndex = e.NewPageIndex;
        carga_accesorios();
    }

    protected void Accesorios_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }


    protected void cambiar_accesorio(object sender, EventArgs e)
    {
                    int i;

                    OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
                    OracleDataAdapter ComandoDA;
                    String cantidad;
                    TextBox x = new TextBox();
                    String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                    int id_usuario = int.Parse(PRO.recSession(rutaXml, "ID_USUARIO"));

                    for (i = 0; i < Accesorios.Rows.Count; i++)
                    {

                        x = (TextBox)(Accesorios.Rows[i].Cells[6].Controls[1]);
                        cantidad = x.Text;

                        //CONSULTAR SI TIENE LA CANTIDAD INGRESADA DISPONIBLE
                        if (cantidad != "")
                        {

                            if (int.Parse(Accesorios.Rows[i].Cells[5].Text) >= int.Parse(cantidad) && int.Parse(cantidad) > 0)
                            {

                                objConexion.Open();
                                ComandoDA = new OracleDataAdapter("PK_ASIGNA_ACCESORIOS.INSERTA_ASIGNACION", objConexion);
                                ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

                                //PRO.agrega_parametro_sp(ComandoDA, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
                                PRO.agrega_parametro_sp(ComandoDA, "i_accesorio", OracleType.Number, ParameterDirection.Input, Accesorios.Rows[i].Cells[0].Text);
                                PRO.agrega_parametro_sp(ComandoDA, "cantidad", OracleType.Number, ParameterDirection.Input, cantidad);
                                PRO.agrega_parametro_sp(ComandoDA, "i_bodega", OracleType.Number, ParameterDirection.Input, Accesorios.Rows[i].Cells[1].Text);

                                try
                                {
                                    ComandoDA.SelectCommand.ExecuteNonQuery();
                                    objConexion.Close();
                                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " correcto('');", true);
                                }
                                catch (Exception ex)
                                {
                                }
                                

                            }
                            else
                            {
                                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error('Un item no tiene stock suficiente');", true);
                                Accesorios.Rows[i].Cells[6].BackColor = System.Drawing.Color.Red;
                            }
                        }
                    }

                    objConexion.Dispose();
                    carga_accesorios();

   }

    protected void ddbodegas_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_medidores_ingresados();
        carga_accesorios();
    }

    protected void ddbodega_origen_change(object sender, EventArgs e)
    {
        if (!bodega_origen_con_stock(ddbodegas_origen.SelectedValue)) ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " atencion('Bodega seleccionada sin stock, seleccione otra!');", true);
        carga_regiones(ddbodegas_origen.SelectedValue);
        carga_bodegas_destino(int.Parse(ddcontratista.SelectedValue), int.Parse(ddregion.SelectedValue), int.Parse(ddbodegas_origen.SelectedValue));
        carga_filtros_traspaso(ddbodegas_origen.SelectedValue);
        carga_medidores_ingresados();
        carga_accesorios();
    }


    /*FILTROS PARA EL TRASPASO DE MEDIDORES Y ACCESORIOS*/
    public void carga_diametro(String bodega, String stock)
    {
     
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_TRASPASO.CARGA_DIAMETRO", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "bodega", OracleType.Number, ParameterDirection.Input, bodega.ToString());
        PRO.agrega_parametro_sp(objComando, "stock", OracleType.NVarChar, ParameterDirection.Input, stock.ToString());

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "DIAMETRO");
        objConexion.Close();

        int i = 1;
        if (stock.Equals("MEDIDOR")) //RELLENAMOS EL COMBO DE DIAMETROS MEDIDOR.
        {
            ddDiametroMed.Items.Clear();
            ddDiametroMed.Items.Add("Todos...");
            ddDiametroMed.Items[0].Value = "0";

            foreach (DataRow row in objDS.Tables["DIAMETRO"].Rows)
            {

                ddDiametroMed.Items.Add(row[0].ToString());
                ddDiametroMed.Items[i].Value = row[0].ToString();
                i = i + 1;

            }
        }
        else //RELLENAMOS EL COMBO DE DIAMETROS ACCESORIO
        {
            ddDiametroAcc.Items.Clear();
            ddDiametroAcc.Items.Add("Todos...");
            ddDiametroAcc.Items[0].Value = "0";

            foreach (DataRow row in objDS.Tables["DIAMETRO"].Rows)
            {

                ddDiametroAcc.Items.Add(row[0].ToString());
                ddDiametroAcc.Items[i].Value = row[0].ToString();
                i = i + 1;

            }
        }
       
    }
    //OBTENEMOS LAS MARCAS DE MEDIDOR QUE EXISTEN DISPONIBLES EN BODEGA.
    public void carga_marca_medidor(String bodega)
    {

        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_TRASPASO.CARGA_MARCA_MEDIDOR", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "bodega", OracleType.Number, ParameterDirection.Input, bodega.ToString());

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "MARCA");
        objConexion.Close();

        int i = 1;

        ddMarcaMed.Items.Clear();
        ddMarcaMed.Items.Add("Todas...");
        ddMarcaMed.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["MARCA"].Rows)
        {

            ddMarcaMed.Items.Add(row[0].ToString());
            ddMarcaMed.Items[i].Value = row[1].ToString();
            i = i + 1;

        }
    }

    //OBTENEMOS LOS TIPOS DE MATERIAL DE ACCESORIOS QUE EXISTEN DISPONIBLES EN BODEGA.
    public void carga_tipo_material_accesorio(String bodega)
    {

        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_TRASPASO.CARGA_TIPO_MATERIAL_ACCESORIO", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "bodega", OracleType.Number, ParameterDirection.Input, bodega.ToString());

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "TIPO_MATERIAL");
        objConexion.Close();

        int i = 1;

        ddTipoMaterialAcc.Items.Clear();
        ddTipoMaterialAcc.Items.Add("Todos...");
        ddTipoMaterialAcc.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["TIPO_MATERIAL"].Rows)
        {

            ddTipoMaterialAcc.Items.Add(row[0].ToString());
            ddTipoMaterialAcc.Items[i].Value = row[1].ToString();
            i = i + 1;

        }
    }

    //CARGAMOS LOS FILTROS SEGÚN BODEGA PARA EL TRASPASO.
    public void carga_filtros_traspaso(String bodega)
    {
        carga_diametro(bodega,"MEDIDOR");
        carga_diametro(bodega, "ACCESORIO");
        carga_marca_medidor(bodega);
        carga_tipo_material_accesorio(bodega);

    }

    protected void ddDiametroMed_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_medidores_ingresados();
    }
    protected void ddMarcaMed_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_medidores_ingresados();
    }
    protected void ddDiametroAcc_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_accesorios();
    }
    protected void ddTipoMaterialAcc_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_accesorios();
    }
    protected void ddSerieDesde_TextChanged(object sender, EventArgs e)
    {        
        carga_medidores_ingresados();
    }
    protected void ddSerieHasta_TextChanged(object sender, EventArgs e)
    {
        carga_medidores_ingresados();
    }
    protected void Button4_Click(object sender, EventArgs e)
    {
        if (cancela_todo(numero_guia.Text))
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " cancelar_todo('');", true);
            panel1.Visible = true;
            Div1.Visible = true;
            Div2.Visible = true;
            panel2.Visible = false;
        }
    }

    public Boolean cancela_todo(String guia)
    {
        try
        {
            //eliminamos detalle.
            if (articulos.Rows.Count > 0)
            {
                foreach (GridViewRow row in articulos.Rows)
                {
                    elimina_detalle_masivo(int.Parse(row.Cells[0].Text));
                }
            }
            //eliminar guia y foto.
            elimina_guia_traspaso(int.Parse(numero_guia.Text));
            elimina_foto_respaldo(numero_guia.Text);

            carga_articulos();
            carga_accesorios();
            carga_medidores_ingresados();
            return true;
            
        }
        catch (Exception ex)
        {
            return false;
        }

    }
    protected void btn_traspasar_medidores_Click(object sender, EventArgs e)
    {
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";

        if (valida_check() == true)
        {
            int i;
            GridViewRow gvRow;

            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter ComandoDA;

            TextBox x = new TextBox();
            CheckBox chk_as = new CheckBox();

            int id_usuario = int.Parse(PRO.recSession(rutaXml, "ID_USUARIO"));

            for (i = 0; i < medidores.Rows.Count; i++)
            {

                gvRow = medidores.Rows[i];
                chk_as = (CheckBox)(gvRow.FindControl("cambiar"));

                if (chk_as.Checked == true)
                {

                    objConexion.Open();
                    ComandoDA = new OracleDataAdapter("PK_TRASPASO.CAMBIAR_MEDIDOR", objConexion);
                    ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

                    //PRO.agrega_parametro_sp(ComandoDA, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
                    PRO.agrega_parametro_sp(ComandoDA, "i_medidor", OracleType.Number, ParameterDirection.Input, medidores.Rows[i].Cells[1].Text);
                    PRO.agrega_parametro_sp(ComandoDA, "guia_destino", OracleType.Number, ParameterDirection.Input, numero_guia.Text);

                    try
                    {
                        ComandoDA.SelectCommand.ExecuteNonQuery();
                        objConexion.Close();

                        inserta_detalle(int.Parse(medidores.Rows[i].Cells[9].Text), int.Parse(medidores.Rows[i].Cells[4].Text), 1);

                    }
                    catch (Exception ex)
                    {
                        break;
                    }
                }
            }

            objConexion.Dispose();
            carga_medidores_ingresados();
            carga_articulos();
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " sucess('');", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error('No ha seleccionado ningún medidor!');", true);
        }
    }

    protected void btn_traspasar_acc_Click(object sender, EventArgs e)
    {
        String valida_acc = valida_check_accesorios();

        if (valida_acc.Equals("OK")) //ingresamos accesorios traspasado.
        {
            traspaso_accesorios();
            carga_articulos();
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " sucess('');", true);
        }
        else
        {
            if (valida_acc.Equals("TEXTO")) ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error_plantilla('No se permiten textos en la cantidad ingresada');", true);
            else if (valida_acc.Equals("MAYOR") || valida_acc.Equals("MENOR")) ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error_plantilla('Cantidad de accesorio debe ser mayor a 0 y menor o igual a la cantidad disponible');", true);
            else ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error_plantilla('No se ha ingresado cantidad > 0 de un accesorio');", true);
                  
        }
    }

    protected Boolean elimina_guia_traspaso(int guia)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter ComandoDA;

        objConexion.Open();
        ComandoDA = new OracleDataAdapter("PK_TRASPASO.ELIMINA_GUIA", objConexion);
        
        PRO.agrega_parametro_sp(ComandoDA, "i_guia", OracleType.Number, ParameterDirection.Input, guia.ToString());
        ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;
        try
        {
            ComandoDA.SelectCommand.ExecuteNonQuery();
            objConexion.Close();
            return true;

        }
        catch (Exception ex)
        {

            objConexion.Dispose();
            return false;
        }


    }

    protected Boolean elimina_foto_respaldo(String guia)
    {
        try
        {
            String ruta_fotos_raiz = "FOTOS_GUIA/";
            String foto_respaldo = "RECEPCION_" + guia;

            if (!Directory.Exists(Server.MapPath("./" + ruta_fotos_raiz + "/"))) System.IO.Directory.CreateDirectory(Server.MapPath("./" + ruta_fotos_raiz + "/"));

            String[] allfiles = Directory.GetFiles(Server.MapPath("./" + ruta_fotos_raiz + "/"), "*" + foto_respaldo + "*", SearchOption.AllDirectories);

            foreach (var mi_archivo in allfiles)
            {
                FileInfo archivo = new FileInfo(mi_archivo);

                archivo.Delete();
            }

            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
        
    }
    protected void numero_guia_TextChanged(object sender, EventArgs e)
    {
        long n;
        if (!long.TryParse(numero_guia.Text, out n))
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('Número de guía debe ser numérico');", true);
            
        }
        else if (!valida_numero_guia(numero_guia.Text))
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('Número de guía ya existe en plataforma');", true);
        }
    }
}




