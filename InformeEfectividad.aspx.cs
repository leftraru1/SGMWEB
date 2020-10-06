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

public partial class EstadoPagoGSM : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();
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
        objComando = new OracleDataAdapter("PK_INFORME_EFECTIVIDAD.CARGA_OPERADORES", objConexion);
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


    private void Llena_combo_proceso()
    {

        string sql_zonas = null;
        DataTable dtZonas = new DataTable();
        sql_zonas = "SELECT * from tipo_proceso where estado=0";
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

    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }

    protected void Button1_Click1(object sender, EventArgs e)
    {
        cagar_grilla();
    }


    protected void Button2_Click1(object sender, EventArgs e)
    {
        Response.ClearContent();
        Response.AddHeader("content-disposition", "attachment;filename=INFORME_EFECTIVIDAD " + DateTime.Now + ".xls");
        Response.ContentType = "applicatio/excel";
        StringWriter sw = new StringWriter(); ;
        HtmlTextWriter htm = new HtmlTextWriter(sw);
        gridEstadoPago.RenderControl(htm);
        Response.Write(sw.ToString());
        Response.End();

    }
    public void cagar_grilla()
    {
        // OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        // OracleCommand cmdAcceso = new OracleCommand("PK_INFORME_EFECTIVIDAD.INFORME_EFECT", CnOra);
        // OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
        // CnOra.Open();
        // da.SelectCommand.CommandType = CommandType.StoredProcedure;

        // PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        // PRO.agrega_parametro_sp(da, "i_FECHA_INICIO", OracleType.NVarChar, ParameterDirection.Input, "01/09/2017");
        // PRO.agrega_parametro_sp(da, "i_FECHA_FIN", OracleType.NVarChar, ParameterDirection.Input, "10/09/2017");
        //// PRO.agrega_parametro_sp(da, "i_idRegion", OracleType.Number, ParameterDirection.Input, ddRegion.SelectedValue);
        //// PRO.agrega_parametro_sp(da, "i_idZona", OracleType.Number, ParameterDirection.Input, ddZona.SelectedValue);
        // //PRO.agrega_parametro_sp(da, "i_idlocalidad", OracleType.Number, ParameterDirection.Input, ddLocalidad.SelectedValue);
        // //PRO.agrega_parametro_sp(da, "i_cod_instalador", OracleType.Number, ParameterDirection.Input, ddlTrabajador.SelectedValue);
        // //PRO.agrega_parametro_sp(da, "i_cod_contratista", OracleType.Number, ParameterDirection.Input, combo_contratista.SelectedValue);
        // //PRO.agrega_parametro_sp(da, "i_id_tipoPro", OracleType.Number, ParameterDirection.Input, ddlProceso.SelectedValue);
        string Sql;
        Sql = "";
        Sql = Sql + " SELECT  O.NUMERO_ORDEN, ";
        Sql = Sql + "  O.ID_SERVICIO, ";
        Sql = Sql + "  O.FECHA_CREACION, ";
        Sql = Sql + "  O.RUTA,  ";
        Sql = Sql + "  REGION.DESCRIPCION as REGION,  ";
        Sql = Sql + "  LOCALIDAD.NOMBRE AS LOCALIDAD,  ";
        Sql = Sql + "  ZONA.NOMBRE AS ZONA,  ";
        Sql = Sql + "  EO.DESCRIPCION AS CODIGO_RESULTADO,  ";
        Sql = Sql + "  O.LECTURA_RET AS LECTURA_RETIRO,  ";
        Sql = Sql + "  O.DIAMETRO_RET AS DIAMETRO_MEDIDOR_RETIRADO,  ";
        Sql = Sql + "  MM.FABRICANTE AS MARCA_MEDIDOR_NUEVO,  ";
        Sql = Sql + "  O.ANO_MN as ANO_MEDIDOR_NUEVO,  ";
        Sql = Sql + "  O.numero_mn AS SERIE_MEDIDOR_NUEVO,  ";
        Sql = Sql + "  O.DIAMETRO_NU AS DIAMETRO_MEDIDOR_NUEVO,  ";
        Sql = Sql + "  O.LECTURA_MN AS LECTURA_MEDIDOR_NUEVO,  ";
        Sql = Sql + "  O.FECHA_INST AS FECHA_EJECUCION,  ";
        Sql = Sql + "  O.HORA_EJECUCION AS HORA_EJECUCION,  ";
        Sql = Sql + "  O.COD_CONTRATISTA AS CODIGO_CONTRATISTA,  ";
        Sql = Sql + "  EMR.DESCRIPCION AS CAUSA_CAMBIO,  ";
        Sql = Sql + "  CASE  ";
        Sql = Sql + "  WHEN EO.COD_ESTATUS_ORDEN=24 or EO.COD_ESTATUS_ORDEN=25 THEN 'EJECUTADO'  ";
        Sql = Sql + "  ELSE 'IMPROCEDENTE'   ";
        Sql = Sql + "  END  ";
        Sql = Sql + "  AS RESULTADO,  ";
        Sql = Sql + "  EV.DESCRIPCION AS CODIGO_VARAL,  ";
        Sql = Sql + "  MV.DESCRIPCION AS MATERIAL_VARAL,  ";
        Sql = Sql + "  ELL.DESCRIPCION,  ";
        Sql = Sql + "  TP.DESCRIPCION AS DETALLE,  ";
        Sql = Sql + "  O.RUT_CLIENTE,  ";
        Sql = Sql + "  O.OBSERVACION_IN AS OBSERVACION,  ";
        Sql = Sql + "  O.COD_INSTALADOR AS CODIGO_INSTALADOR, ";
	   Sql = Sql + "  TIP_PRO.DETALLE AS TIPO_PROCESO,";
        Sql = Sql + "  COD_CONT.NOMBRE AS NOMBRE_CONTRA, ";
        Sql = Sql + " CC.DESCRIPCION AS MOTIVO_CAMBIO ";

        Sql = Sql + " FROM ORDEN O ";
        Sql = Sql + " INNER JOIN PROCESO P ON P.ID_PROCESO=O.ID_PROCESO ";
        Sql = Sql + " INNER JOIN TIPO_PROCESO TIP_PRO ON TIP_PRO.ID_TIPO_PROCESO=P.ID_TIPO_PROCESO ";
        Sql = Sql + " INNER JOIN EMPRESA E ON E.RUT_EMPRESA=O.RUT_EMPRESA ";
        Sql = Sql + " LEFT JOIN ESTATUS_ORDEN EO ON EO.COD_ESTATUS_ORDEN= O.COD_IMPROCEDENCIA ";
        Sql = Sql + " LEFT JOIN ESTADO_MEDIDOR_RETIRADO EMR ON EMR.COD_ESTATUS_MR =O.COD_ESTADO_MR ";
        Sql = Sql + " LEFT JOIN MARCA_MEDIDOR MM ON MM.COD_MARCA_MEDIDOR =O.COD_MARCA ";
        Sql = Sql + " LEFT JOIN ESTATUS_VARAL_RETIRADO EV ON EV.COD_VR =O.COD_VARAL ";
        Sql = Sql + " LEFT JOIN ESTATUS_LLAVE_RETIRADA ELL ON ELL.COD_LLR=O.COD_LLAVE ";
        Sql = Sql + " LEFT JOIN CAUSA_CAMBIO CC ON CC.COD_CAUSA =O.CAUSA ";
        Sql = Sql + " LEFT JOIN INSTALADOR I ON I.COD_INSTALADOR=O.COD_INSTALADOR ";
        Sql = Sql + " LEFT JOIN  LOCALIDAD  ON LOCALIDAD.ID_LOCALIDAD=O.ID_LOCALIDAD ";
        Sql = Sql + " LEFT JOIN  ZONA  ON LOCALIDAD.ID_ZONA=ZONA.ID_ZONA ";
        Sql = Sql + " LEFT JOIN  REGION REGION ON REGION.ID_REGION=ZONA.ID_REGION   ";
        Sql = Sql + " LEFT JOIN CONTRATISTA COD_CONT ON COD_CONT.COD_CONTRATISTA=O.COD_CONTRATISTA ";
        Sql = Sql + " LEFT JOIN TIPO_LLAVE TP on TP.COD_TIPOLLAVE=O.COD_LLAVE  ";
        Sql = Sql + " LEFT JOIN MATERIAL_VARAL MV ON MV.COD_MATERIALVAR=O.MATERIAL_VARAL  ";
       // Sql = Sql + "  WHERE  O.FECHA_INST BETWEEN '" + txtDesde.Text + "' AND '" + txtHasta.Text + "'";
         Sql = Sql + "  WHERE  TO_DATE (o.FECHA_CREACION,'DD-MM-RRRR') BETWEEN TO_DATE ('" + txtDesde.Text + "', 'DD-MM-RRRR') AND TO_DATE ('" + txtHasta.Text + "', 'DD-MM-RRRR')";

        if (int.Parse(ddZona.SelectedValue) != 0 && ddZona.SelectedValue != "")
        {
            Sql = Sql + "  and ZONA.ID_ZONA='" + ddZona.SelectedValue + "' ";
        }
        if (int.Parse(ddRegion.SelectedValue) != 0 && ddRegion.SelectedValue != "")
        {
            Sql = Sql + "  and REGION.ID_REGION='" + ddRegion.SelectedValue + "' ";
        }
        if (int.Parse(ddLocalidad.SelectedValue) != 0 && ddLocalidad.SelectedValue != "")
        {
            Sql = Sql + "  and LOCALIDAD.ID_LOCALIDAD='" + ddLocalidad.SelectedValue + "' ";
        }
        if (int.Parse(ddlTrabajador.SelectedValue) != 0 && ddlTrabajador.SelectedValue != "")
        {
            Sql = Sql + "  and  I.COD_INSTALADOR='" + ddlTrabajador.SelectedValue + "' ";
        }
        if (int.Parse(combo_contratista.SelectedValue) != 0 && combo_contratista.SelectedValue != "")
        {
            Sql = Sql + "  and COD_CONT.ID_CONTRATISTA='" + combo_contratista.SelectedValue + "' ";
        }
        if (int.Parse(ddlProceso.SelectedValue) != 0 && ddlProceso.SelectedValue != "")
        {
            Sql = Sql + "  AND TIP_PRO.ID_TIPO_PROCESO='" + ddlProceso.SelectedValue + "' ";
        }
        Sql = Sql + "  UNION     ";
        Sql = Sql + "  SELECT O.NUMERO_ORDEN,        ";
        Sql = Sql + "  O.ID_SERVICIO,    ";
        Sql = Sql + "  O.FECHA_CREACION,    ";
        Sql = Sql + "  O.RUTA,    ";
        Sql = Sql + "  REGION.DESCRIPCION as REGION,    ";
        Sql = Sql + "  LOCALIDAD.NOMBRE AS LOCALIDAD,    ";
        Sql = Sql + "  ZONA.NOMBRE AS ZONA,    ";
        Sql = Sql + "  EO.DESCRIPCION AS CODIGO_RESULTADO,    ";
        Sql = Sql + "  O.LECTURA_RET AS LECTURA_RETIRO,    ";
        Sql = Sql + "  O.DIAMETRO_RET AS DIAMETRO_MEDIDOR_RETIRADO,    ";
        Sql = Sql + "  MM.FABRICANTE AS MARCA_MEDIDOR_NUEVO,    ";
        Sql = Sql + "  O.ANO_MN as ANO_MEDIDOR_NUEVO,    ";
        Sql = Sql + "  O.numero_mn AS SERIE_MEDIDOR_NUEVO,    ";
        Sql = Sql + "  O.DIAMETRO_NU AS DIAMETRO_MEDIDOR_NUEVO,    ";
        Sql = Sql + "  O.LECTURA_MN AS LECTURA_MEDIDOR_NUEVO,    ";
        Sql = Sql + "  O.FECHA_INST AS FECHA_EJECUCION,    ";
        Sql = Sql + "  O.HORA_EJECUCION AS HORA_EJECUCION,    ";
        Sql = Sql + "  O.COD_CONTRATISTA AS CODIGO_CONTRATISTA,    ";
        Sql = Sql + "  EMR.DESCRIPCION AS CAUSA_CAMBIO,    ";
        Sql = Sql + "  CASE    ";
        Sql = Sql + "  WHEN EO.COD_ESTATUS_ORDEN=24 or EO.COD_ESTATUS_ORDEN=25 THEN 'EJECUTADO'    ";
        Sql = Sql + "  ELSE 'IMPROCEDENTE'    ";
        Sql = Sql + "  END    ";
        Sql = Sql + "  AS RESULTADO,    ";
        Sql = Sql + "  EV.DESCRIPCION AS CODIGO_VARAL,    ";
        Sql = Sql + "  MV.DESCRIPCION AS MATERIAL_VARAL,    ";
        Sql = Sql + "  ELL.DESCRIPCION AS INSTALACION_LLAVE,    ";
        Sql = Sql + "  TP.DESCRIPCION AS DETALLE,    ";
        Sql = Sql + "  O.RUT_CLIENTE,    ";
        Sql = Sql + "  O.OBSERVACION_IN AS OBSERVACION,    ";
        Sql = Sql + "  O.COD_INSTALADOR AS CODIGO_INSTALADOR,     ";
  	Sql = Sql + "  TIP_PRO.DETALLE AS TIPO_PROCESO,";
        Sql = Sql + "  COD_CONT.NOMBRE AS NOMBRE_CONTRA, ";
        Sql = Sql + " CC.DESCRIPCION AS MOTIVO_CAMBIO ";
        Sql = Sql + " FROM ORDEN_HISTORICOS O ";
        Sql = Sql + " INNER JOIN PROCESO P ON P.ID_PROCESO=O.ID_PROCESO ";
        Sql = Sql + " INNER JOIN TIPO_PROCESO TIP_PRO ON TIP_PRO.ID_TIPO_PROCESO=P.ID_TIPO_PROCESO ";
        Sql = Sql + " INNER JOIN EMPRESA E ON E.RUT_EMPRESA=O.RUT_EMPRESA ";
        Sql = Sql + " LEFT JOIN ESTATUS_ORDEN EO ON EO.COD_ESTATUS_ORDEN= O.COD_IMPROCEDENCIA ";
        Sql = Sql + " LEFT JOIN ESTADO_MEDIDOR_RETIRADO EMR ON EMR.COD_ESTATUS_MR =O.COD_ESTADO_MR ";
        Sql = Sql + " LEFT JOIN MARCA_MEDIDOR MM ON MM.COD_MARCA_MEDIDOR =O.COD_MARCA ";
        Sql = Sql + " LEFT JOIN ESTATUS_VARAL_RETIRADO EV ON EV.COD_VR =O.COD_VARAL ";
        Sql = Sql + " LEFT JOIN ESTATUS_LLAVE_RETIRADA ELL ON ELL.COD_LLR=O.COD_LLAVE ";
        Sql = Sql + " LEFT JOIN CAUSA_CAMBIO CC ON CC.COD_CAUSA =O.CAUSA ";
        Sql = Sql + " LEFT JOIN INSTALADOR I ON I.COD_INSTALADOR=O.COD_INSTALADOR ";
        Sql = Sql + " LEFT JOIN  LOCALIDAD  ON LOCALIDAD.ID_LOCALIDAD=O.ID_LOCALIDAD ";
        Sql = Sql + " LEFT JOIN  ZONA  ON LOCALIDAD.ID_ZONA=ZONA.ID_ZONA ";
        Sql = Sql + " LEFT JOIN  REGION REGION ON REGION.ID_REGION=ZONA.ID_REGION   ";
        Sql = Sql + " LEFT JOIN CONTRATISTA COD_CONT ON COD_CONT.COD_CONTRATISTA=O.COD_CONTRATISTA ";
        Sql = Sql + " LEFT JOIN TIPO_LLAVE TP on TP.COD_TIPOLLAVE=O.COD_LLAVE  ";
        Sql = Sql + " LEFT JOIN MATERIAL_VARAL MV ON MV.COD_MATERIALVAR=O.MATERIAL_VARAL  ";
        //Sql = Sql + "  WHERE  O.FECHA_INST BETWEEN '" + txtDesde.Text + "' AND '" + txtHasta.Text + "'";
        Sql = Sql + "  WHERE TO_DATE (o.FECHA_CREACION,'DD-MM-RRRR') BETWEEN TO_DATE ('" + txtDesde.Text + "', 'DD-MM-RRRR') AND TO_DATE ('" + txtHasta.Text + "', 'DD-MM-RRRR')";
        if (int.Parse(ddZona.SelectedValue) != 0 && ddZona.SelectedValue != "")
        {
            Sql = Sql + "  and ZONA.ID_ZONA='" + ddZona.SelectedValue + "' ";
        }
        if (int.Parse(ddRegion.SelectedValue) != 0 && ddRegion.SelectedValue != "")
        {
            Sql = Sql + "  and REGION.ID_REGION='" + ddRegion.SelectedValue + "' ";
        }
        if (int.Parse(ddLocalidad.SelectedValue) != 0 && ddLocalidad.SelectedValue != "")
        {
            Sql = Sql + "  and LOCALIDAD.ID_LOCALIDAD='" + ddLocalidad.SelectedValue + "' ";
        }
        if (int.Parse(ddlTrabajador.SelectedValue) != 0 && ddlTrabajador.SelectedValue != "")
        {
            Sql = Sql + "  and  I.COD_INSTALADOR='" + ddlTrabajador.SelectedValue + "' ";
        }
        if (int.Parse(combo_contratista.SelectedValue) != 0 && combo_contratista.SelectedValue != "")
        {
            Sql = Sql + "  and COD_CONT.ID_CONTRATISTA='" + combo_contratista.SelectedValue + "' ";
        }
        if (int.Parse(ddlProceso.SelectedValue) != 0 && ddlProceso.SelectedValue != "")
        {
            Sql = Sql + "  AND TIP_PRO.ID_TIPO_PROCESO='" + ddlProceso.SelectedValue + "' ";
        }

        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        objConexion.Open();
        OracleCommand cmd = new OracleCommand();
        cmd.Connection = objConexion;
        cmd.CommandText = Sql;
        cmd.CommandType = CommandType.Text;
        OracleDataReader dr = cmd.ExecuteReader();
        dr.Read();
        //GridView1.DataSource = dr;
        //GridView1.DataBind();
        gridEstadoPago.DataSource = dr;
        gridEstadoPago.DataBind();
        objConexion.Dispose();
        objConexion.Close();
        int total = 0;

        total = gridEstadoPago.Rows.Count;
        lbTotal.Text = total + " registro(s) encontrado(s)";

    }
}