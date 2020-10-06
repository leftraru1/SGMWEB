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

public partial class Genera_guia : System.Web.UI.Page
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
    public int error_cod = 0,error_diam = 0, error_cant = 0,error_no_existe_marca = 0,error_no_existe_diametro = 0,error_otro = 0, registros_no_ingresados = 0;

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

                fecha_despacho.Text = DateTime.Today.ToString("dd/MM/yyyy");

                //carga_codigos();
                carga_descripcion();
                carga_contratistas();
                carga_regiones();
                carga_bodegas(int.Parse(ddcontratista.SelectedValue),int.Parse(ddregion.SelectedValue));
                //carga_diametro();
                carga_articulos();
                
            }
            catch (Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }

        }

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

    public void carga_regiones()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_CARGA_DD_GUIA.CARGA_REGION", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

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

    //toma el nombre del mes y lo asigna a un string
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

    //public Boolean validaArchivoMa(String nombreArchivo)
    //{

    //    OracleConnection objConexion1 = new OracleConnection(conexion_cliente_oracle);
    //    objConexion1.Open();
    //    DataSet objDS = new DataSet();
    //    OracleDataAdapter ComandoDE;

    //    ComandoDE = new OracleDataAdapter("PK_N_MAESTRO.BUSCAR_ARCHIVO", objConexion1);
    //    ComandoDE.SelectCommand.CommandType = CommandType.StoredProcedure;

    //    PRO.agrega_parametro_sp(ComandoDE, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
    //    PRO.agrega_parametro_sp(ComandoDE, "i_nombre_archivo", OracleType.NVarChar, ParameterDirection.Input, nombreArchivo);

    //    ComandoDE.SelectCommand.ExecuteNonQuery();
    //    ComandoDE.Fill(objDS, "VALIDA");
    //    objConexion1.Close();


    //    if (objDS.Tables["VALIDA"].Rows.Count == 0)
    //    {
    //        return false;
    //    }
    //    else
    //    {
    //        return true;
    //    }
    //}

    public void carga_codigos()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_CARGA_DD_GUIA.CARGA_CODIGOS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "CODIGOS");
        objConexion.Close();

        int i = 0;
        codigo.Items.Clear();

        foreach (DataRow row in objDS.Tables["CODIGOS"].Rows)
        {

            codigo.Items.Add(row[1].ToString());
            codigo.Items[i].Value = row[0].ToString();
            
            i = i + 1;

        }
    }

    public void carga_descripcion()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_CARGA_DD_GUIA.CARGA_DESCRIPCION", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "DESCRIPCION");
        objConexion.Close();

        int i = 0;
        ddescripcion.Items.Clear();

        foreach (DataRow row in objDS.Tables["DESCRIPCION"].Rows)
        {
            ddescripcion.Items.Add(row[3] +" - "+ row[2] + " - " + row[1].ToString());
            ddescripcion.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }

    public void carga_bodegas(int contratista,int region)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_CARGA_DD_GUIA.CARGA_BODEGAS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "contratista", OracleType.Number, ParameterDirection.Input, contratista.ToString());
        PRO.agrega_parametro_sp(objComando, "region", OracleType.Number, ParameterDirection.Input, region.ToString());

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

    //public void carga_diametro()
    //{
    //    OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
    //    OracleDataAdapter objComando;
    //    DataSet objDS = new DataSet();

    //    objConexion.Open();
    //    objComando = new OracleDataAdapter("PK_CARGA_DD_GUIA.CARGA_DIAMETRO", objConexion);
    //    objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

    //    PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

    //    objComando.SelectCommand.ExecuteNonQuery();
    //    objComando.Fill(objDS, "DIAMETRO");
    //    objConexion.Close();

    //    int i = 0;
    //    dddiametro.Items.Clear();

    //    foreach (DataRow row in objDS.Tables["DIAMETRO"].Rows)
    //    {

    //        dddiametro.Items.Add(row[1].ToString());
    //        dddiametro.Items[i].Value = row[1].ToString();
    //        i = i + 1;

    //    }
    //}

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

    public Boolean valida_cod_medidor(String numero_guia,String codigo,String serie, String ano, String diametro)
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

    public void init_diseno_campos()
    {
        //numero_guia
        numero_guia.ForeColor = System.Drawing.Color.Black;
        numero_guia.BorderColor = System.Drawing.ColorTranslator.FromHtml("#94B1E5");

        //reserva
        reserva.ForeColor = System.Drawing.Color.Black;
        reserva.BorderColor = System.Drawing.ColorTranslator.FromHtml("#94B1E5");

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
        if(valida_campos_guia()) {

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
            PRO.agrega_parametro_sp(ComandoDA, "i_bodega_origen", OracleType.Number, ParameterDirection.Input, int.Parse("0").ToString());

            try
            {
                ComandoDA.SelectCommand.ExecuteNonQuery();
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "creo_guia();", true);
                    carga_articulos();
                    panel1.Visible = false;
                    Div1.Visible = false;
                    Div2.Visible = false;
                    panel2.Visible = true;

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
                file.PostedFile.SaveAs(path + "RESPALDO_" + numero_guia + extension_imagen(fileExtension_1));
                boo = true;
            }
            else {
                
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error('Formato incorrecto del archivo de respaldo');", true);
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

    protected void agregar_detalle(object sender, EventArgs e)
    {
        if (  cantidad.Text == "" || int.Parse(cantidad.Text)<=0 || ddescripcion.SelectedValue == "0")
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('Complete los campos');", true);
        }
        else
        {
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            objConexion.Open();
            OracleDataAdapter ComandoDA = new OracleDataAdapter("PK_INSERTA_MEDIDORES.INSERTA_DETALLE", objConexion);

            ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

            PRO.agrega_parametro_sp(ComandoDA, "codigo", OracleType.Number, ParameterDirection.Input, (ddescripcion.SelectedValue).ToString());
            //PRO.agrega_parametro_sp(ComandoDA, "i_diametro", OracleType.Number, ParameterDirection.Input,diame.ToString());
            PRO.agrega_parametro_sp(ComandoDA, "i_cantidad", OracleType.Number, ParameterDirection.Input, cantidad.Text);
            PRO.agrega_parametro_sp(ComandoDA, "i_guia", OracleType.Number, ParameterDirection.Input, numero_guia.Text);

            try
            {
                ComandoDA.SelectCommand.ExecuteNonQuery();
                objConexion.Close();
                objConexion.Dispose();

                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "creo();", true);
                carga_articulos();
            
            }catch(Exception ex){

            }

            objConexion = null;

        }
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
         OracleCommand cmdAcceso = new OracleCommand("PK_INSERTA_MEDIDORES.ELIMINA_DETALLE", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
        
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        PRO.agrega_parametro_sp(da, "i_detalle", OracleType.Number, ParameterDirection.Input, id.ToString());

        try
        {
            CnOra.Open();
            da.SelectCommand.ExecuteNonQuery();
            CnOra.Close();
            CnOra.Dispose();

            carga_articulos();
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " se_elimino('');", true);
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error('Error al eliminar detalle');", true);

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
                
        //Response.Redirect("genera_guia.aspx");
        if (articulos.Rows.Count == 0)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('No es posible finalizar sin ningún detalle!');", true);
        }
        else
        {
            panel2.Visible = false;
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "correcto('');", true);
        }

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

        carga_bodegas(int.Parse(ddcontratista.SelectedValue), int.Parse(ddregion.SelectedValue));

    }
    protected void ddregion_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_bodegas(int.Parse(ddcontratista.SelectedValue),int.Parse(ddregion.SelectedValue));
    }

    protected void tipo_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_codigos();
        carga_descripcion();

    }

    protected void codigo_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_descripcion();
    }

    

    protected void carga_detalle(object sender, EventArgs e)
    {
        // Inicia el contador:
        DateTime tiempo1 = DateTime.Now;
        try
        {
            //inicializamos contadores de error...
            error_otro = error_cod = error_cant = error_diam = error_no_existe_diametro = error_no_existe_marca = registros_no_ingresados = 0;

            String ruta = Server.MapPath("./TXT/" + fuArchivo.PostedFile.FileName);
            String ext = Path.GetExtension(fuArchivo.PostedFile.FileName).ToString();

            int cont = 0;

            if (System.IO.File.Exists(ruta) == false)
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

                                    if (valida_registro(miArray))
                                    {
                                        OracleDataAdapter ComandoDA;
                                        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
                                        objConexion.Open();
                                        ComandoDA = new OracleDataAdapter("PK_CARGA_DD_GUIA.CARGA_INSERCION_DETALLE", objConexion);

                                        PRO.agrega_parametro_sp(ComandoDA, "i_guia", OracleType.NVarChar, ParameterDirection.Input, numero_guia.Text);
                                        PRO.agrega_parametro_sp(ComandoDA, "i_codigo", OracleType.Number, ParameterDirection.Input, miArray[0]);
                                        PRO.agrega_parametro_sp(ComandoDA, "i_cantidad", OracleType.Number, ParameterDirection.Input, miArray[3]);
                                        PRO.agrega_parametro_sp(ComandoDA, "i_diametro", OracleType.Number, ParameterDirection.Input, miArray[2]);
                                        //PRO.agrega_parametro_sp(ComandoDA, "i_tipo", OracleType.NVarChar, ParameterDirection.Input, miArray[1]);

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

                        if (registros_no_ingresados > 0)
                        {
                            String detalle = log_error();
                            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " carga_con_error('" + detalle + "','" + registros_no_ingresados + "');", true);

                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " carga_realizada('" + cont + "');", true);
                        }
                        carga_articulos();
                        
           
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error('El archivo ya existe');", true);
                }
            
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error(''No se pudo cargar);", true);
        }

    }

    public String log_error()
    {
        String mi_detalle = "";
        List<String> errores = new List<String>();

        if (error_cod > 0)
        {
            mi_detalle += "(" + error_cod + ") formato erroneo código marca (campo 1).";
            errores.Add(error_cod + " Error(es) con formato de código marca (campo 1).");
        }
        if (error_no_existe_marca > 0)
        {
            mi_detalle += "(" + error_no_existe_marca + ") no existe código marca en sistema.";
            errores.Add(error_no_existe_marca + " Error(es) no existe cód. marca en sistema.");
        }

        if (error_diam > 0)
        {
            mi_detalle += "(" + error_diam + ") formato erroneo diametro (campo 3).";
            errores.Add(error_diam + " Error(es) con formato diametro (campo 3).");
        }

        if (error_no_existe_diametro > 0)
        {
            mi_detalle += "(" + error_no_existe_diametro + ") no existe diametro en sistema.";
            errores.Add(error_no_existe_diametro + " no existe diametro en sistema.");
        }

        if (error_cant > 0)
        {
            mi_detalle += "(" + error_cant + ") formato erroneo contratista (campo 4).";
            errores.Add(error_cant + " Error(es) con formato contratista (campo 4).");
        }

      
        if (error_otro > 0)
        {
            mi_detalle += "(" + error_otro + ") ERROR DESCONOCIDO, revisar archivo.";
            errores.Add(error_otro + " Error(es) revisar archivo.");
        }
        
        return mi_detalle;
    }

    public Boolean valida_registro(String[] arreglo)
    {

        String val_cod_marca = arreglo[0], val_diametro = arreglo[2], val_cantidad = arreglo[3];

        int cont;
        //validamos formatos
        if (!int.TryParse(val_cod_marca, out cont))
        {
            error_cod++;
            return false;
        }
        else if (!int.TryParse(val_diametro, out cont))
        {
            error_diam++;
            return false;
        }
        else if (!int.TryParse(val_cantidad, out cont))
        {
            error_cant++;
            return false;
        }

        if (int.Parse(val_cantidad) < 1)
        {
            error_cant++;
            return false;
        }
       
              

        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_CARGA_DD_GUIA.VALIDA_DETALLE_GUIA", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_cod_marca", OracleType.NVarChar, ParameterDirection.Input, val_cod_marca);
        PRO.agrega_parametro_sp(objComando, "i_diametro", OracleType.NVarChar, ParameterDirection.Input, val_diametro);

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
           
        }

        return true;
    }

  
}




