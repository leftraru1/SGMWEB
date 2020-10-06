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
    String id_contr = "0";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

            try
            {
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                PRO.recSession(rutaXml, "RUT_EMPRESA");
                id_contr = PRO.recSession(rutaXml, "ID_CONTRATISTA");

                carga_contratistas(id_contr);

                    DateTime primerDiaMes= new DateTime();
                    primerDiaMes = DateTime.Now;
                    primerDiaMes = primerDiaMes.AddDays(-primerDiaMes.Day + 1);
                    
                    DateTime ultimoDiaMes= new DateTime();
                    ultimoDiaMes = DateTime.Now;
                    ultimoDiaMes = ultimoDiaMes.AddDays(-ultimoDiaMes.Day + 1).AddMonths(1).AddDays(-1);
                    
                //carga_fechain();

                    txtDesde.Text = primerDiaMes.ToString("dd-MM-yyyy");
                    txtHasta.Text = ultimoDiaMes.ToString("dd-MM-yyyy");

            }
            catch (Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }



        }
    }

    //CARGAMOS LOS CONTRATISTAS.
    public void carga_contratistas(String contratista)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_EEPP.CARGA_CONTRATISTAS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "contratista", OracleType.Int32, ParameterDirection.Input, contratista);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "CONTRATISTAS");
        objConexion.Close();

        int i = 1;

        if (contratista.Equals("0"))
        {
            cb_contratista.Items.Clear();
            cb_contratista.Items.Add("Todos...");
            cb_contratista.Items[0].Value = "0";
        }
        else
        {
            i = 0;
        }


        foreach (DataRow row in objDS.Tables["CONTRATISTAS"].Rows)
        {

            cb_contratista.Items.Add(row[1].ToString());
            cb_contratista.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }

    private void cargarGrilla()
    {

      
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataTable dtOrdenes = new DataTable();
        objComando = new OracleDataAdapter("PK_EEPP.ESTADO_PAGO_MEDIDOR", objConexion);
        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_FECHA_INICIO", OracleType.NVarChar, ParameterDirection.Input, txtDesde.Text);
        PRO.agrega_parametro_sp(objComando, "i_FECHA_FIN", OracleType.NVarChar, ParameterDirection.Input, txtHasta.Text);
        PRO.agrega_parametro_sp(objComando, "i_id_contratista", OracleType.NVarChar, ParameterDirection.Input, cb_contratista.SelectedValue);

        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

       // DataTable dtOrdenes = new DataTable();

        try
        {
            objConexion.Open();
            objComando.Fill(dtOrdenes);
            objConexion.Close();
            objConexion.Dispose();

        }
        catch (Exception ex)
        {

            string mensaje2 = ex.Message;
            //lbErrorGrilla.Text = ex.ToString() + servicio;
            //lbErrorGrilla.ForeColor = System.Drawing.Color.Red;

            //lbErrorGrilla.Text = ex.ToString() + numero_orden;
            //lbErrorGrilla.ForeColor = System.Drawing.Color.Red;
            //lbErrorGrilla.Text = desde + "***" + hasta;

        }

        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("CONTRATISTA", typeof(String)));
        dt.Columns.Add(new DataColumn("REGION", typeof(String)));
        dt.Columns.Add(new DataColumn("COD_INSTALADOR", typeof(String)));
        dt.Columns.Add(new DataColumn("ZONA", typeof(String))); //
        dt.Columns.Add(new DataColumn("LOCALIDAD", typeof(String)));
        dt.Columns.Add(new DataColumn("DIRECCION", typeof(String)));
        dt.Columns.Add(new DataColumn("CLIENTE", typeof(String)));
        dt.Columns.Add(new DataColumn("RUTA", typeof(Int64)));
        dt.Columns.Add(new DataColumn("ID_ORDEN", typeof(String)));
        dt.Columns.Add(new DataColumn("NUMERO_ORDEN", typeof(String)));
        dt.Columns.Add(new DataColumn("ID_SERVICIO", typeof(String)));
        dt.Columns.Add(new DataColumn("LECTURA_RET", typeof(String)));
        dt.Columns.Add(new DataColumn("DIAMETRO_RET", typeof(String)));
        dt.Columns.Add(new DataColumn("ANO_MN", typeof(String)));
        dt.Columns.Add(new DataColumn("NUMERO_MN", typeof(String)));
        dt.Columns.Add(new DataColumn("DIAMETRO_NU", typeof(String)));
        dt.Columns.Add(new DataColumn("LECTURA_MN", typeof(String)));
        dt.Columns.Add(new DataColumn("MATERIAL_VARAL", typeof(String)));
        dt.Columns.Add(new DataColumn("TIPO_LLAVE_PASO", typeof(String)));
        dt.Columns.Add(new DataColumn("NUM_SELLO", typeof(String)));
        dt.Columns.Add(new DataColumn("COLOR_SELLO", typeof(String)));
        dt.Columns.Add(new DataColumn("RUT_CLIENTE", typeof(String)));
    //    dt.Columns.Add(new DataColumn("OBSERVACION_OUT", typeof(String)));
        dt.Columns.Add(new DataColumn("FECHA_CREACION", typeof(String)));
        dt.Columns.Add(new DataColumn("FECHA_INST", typeof(String)));
        dt.Columns.Add(new DataColumn("FECHA_INTEGRACION", typeof(String)));
        dt.Columns.Add(new DataColumn("TIPO_MARCA_DI", typeof(String)));
        dt.Columns.Add(new DataColumn("ORDEN_ESTATUS", typeof(String)));
        dt.Columns.Add(new DataColumn("ESTATUS_MEDIDOR", typeof(String)));
        dt.Columns.Add(new DataColumn("MARCA", typeof(String)));
        dt.Columns.Add(new DataColumn("VARAL_ESTATUS", typeof(String)));
        dt.Columns.Add(new DataColumn("LLAVE_ESTATUS", typeof(String)));
        dt.Columns.Add(new DataColumn("CAMBIO_CAUSA", typeof(String)));
        dt.Columns.Add(new DataColumn("TIPO_EVENTO", typeof(String)));
        dt.Columns.Add(new DataColumn("NOMBRE", typeof(String)));
        dt.Columns.Add(new DataColumn("ID_PROCESO", typeof(String)));
        dt.Columns.Add(new DataColumn("GRUPO_PROCESO", typeof(String)));
        dt.Columns.Add(new DataColumn("ID_TIPO_PROCESO", typeof(String)));
        dt.Columns.Add(new DataColumn("DETALLE", typeof(String)));
        dt.Columns.Add(new DataColumn("OBSERVACION_IN", typeof(String)));
        dt.Columns.Add(new DataColumn("OBSERVACION_OUT", typeof(String)));
        dt.Columns.Add(new DataColumn("SERIE_MEDIDOR", typeof(String)));
        dt.Columns.Add(new DataColumn("COD_IMPROCEDENCIA", typeof(String)));
        dt.Columns.Add(new DataColumn("DIAMETRO_MEDIDOR", typeof(String)));
        dt.Columns.Add(new DataColumn("FABRICANTE", typeof(String)));
        dt.Columns.Add(new DataColumn("ID_SINCRONIZACION", typeof(String)));
        dt.Columns.Add(new DataColumn("VISITA", typeof(String)));
        

        DataRow dr;

        int total = 0;

        foreach (DataRow drOrdenItem in dtOrdenes.Rows)
        {

            dr = dt.NewRow();

            dr["CONTRATISTA"] = drOrdenItem["CONTRATISTA"].ToString();
            dr["REGION"] = drOrdenItem["REGION"].ToString();
            dr["ZONA"] = drOrdenItem["ZONA"].ToString();//.Replace(" 0:00:00", "");
            dr["LOCALIDAD"] = drOrdenItem["LOCALIDAD"].ToString();//
            dr["DIRECCION"] = drOrdenItem["DIRECCION"].ToString();
            dr["CLIENTE"] = drOrdenItem["CLIENTE"].ToString();
            dr["RUTA"] = drOrdenItem["RUTA"].ToString();
            dr["ID_ORDEN"] = drOrdenItem["ID_ORDEN"].ToString();
            dr["NUMERO_ORDEN"] = drOrdenItem["NUMERO_ORDEN"].ToString();
            dr["ID_SERVICIO"] = drOrdenItem["ID_SERVICIO"].ToString();
            dr["LECTURA_RET"] = drOrdenItem["LECTURA_RET"].ToString();
            dr["ANO_MN"] = drOrdenItem["ANO_MN"].ToString();
            dr["NUMERO_MN"] = drOrdenItem["NUMERO_MN"].ToString();
            dr["DIAMETRO_NU"] = drOrdenItem["DIAMETRO_NU"].ToString();
            dr["LECTURA_MN"] = drOrdenItem["LECTURA_MN"].ToString();
            dr["MATERIAL_VARAL"] = drOrdenItem["MATERIAL_VARAL"].ToString();
            dr["TIPO_LLAVE_PASO"] = drOrdenItem["TIPO_LLAVE_PASO"].ToString();
            dr["NUM_SELLO"] = drOrdenItem["NUM_SELLO"].ToString();
            dr["COLOR_SELLO"] = drOrdenItem["COLOR_SELLO"].ToString();  //.Replace(" 0:00:00", "");
            dr["RUT_CLIENTE"] = drOrdenItem["RUT_CLIENTE"].ToString();
            dr["OBSERVACION_OUT"] = drOrdenItem["OBSERVACION_OUT"].ToString();
            dr["FECHA_CREACION"] = drOrdenItem["FECHA_CREACION"].ToString(); //+ " " + drOrdenItem["APELLIDO"].ToString();
            dr["FECHA_INST"] = drOrdenItem["FECHA_INST"].ToString();
            dr["FECHA_INTEGRACION"] = drOrdenItem["FECHA_INTEGRACION"].ToString();
            dr["TIPO_MARCA_DI"] = drOrdenItem["TIPO_MARCA_DI"].ToString();
            dr["ORDEN_ESTATUS"] = drOrdenItem["ORDEN_ESTATUS"].ToString();
            dr["ESTATUS_MEDIDOR"] = drOrdenItem["ESTATUS_MEDIDOR"].ToString();
            dr["MARCA"] = drOrdenItem["MARCA"].ToString();
            dr["VARAL_ESTATUS"] = drOrdenItem["VARAL_ESTATUS"].ToString();
            dr["LLAVE_ESTATUS"] = drOrdenItem["LLAVE_ESTATUS"].ToString();
            dr["CAMBIO_CAUSA"] = drOrdenItem["CAMBIO_CAUSA"].ToString();
            dr["TIPO_EVENTO"] = drOrdenItem["TIPO_EVENTO"].ToString();
            dr["NOMBRE"] = drOrdenItem["NOMBRE"].ToString();
            dr["ID_PROCESO"] = drOrdenItem["ID_PROCESO"].ToString();
            dr["GRUPO_PROCESO"] = drOrdenItem["GRUPO_PROCESO"].ToString();
            dr["ID_TIPO_PROCESO"] = drOrdenItem["VARAL_ESTATUS"].ToString();
            dr["DETALLE"] = drOrdenItem["DETALLE"].ToString();
            dr["OBSERVACION_IN"] = drOrdenItem["OBSERVACION_IN"].ToString();
            dr["OBSERVACION_OUT"] = drOrdenItem["OBSERVACION_OUT"].ToString();
            dr["SERIE_MEDIDOR"] = drOrdenItem["SERIE_MEDIDOR"].ToString();
            dr["COD_IMPROCEDENCIA"] = drOrdenItem["COD_IMPROCEDENCIA"].ToString();
            dr["DIAMETRO_MEDIDOR"] = drOrdenItem["DIAMETRO_MEDIDOR"].ToString();
            dr["FABRICANTE"] = drOrdenItem["FABRICANTE"].ToString();
            dr["ID_SINCRONIZACION"] = drOrdenItem["ID_SINCRONIZACION"].ToString();
            dr["VISITA"] = drOrdenItem["VISITA"].ToString();
            dr["COD_INSTALADOR"] = drOrdenItem["COD_INSTALADOR"].ToString();
            


            dt.Rows.Add(dr);

            total = total + 1;

        }

        DataView MydataView;
        MydataView = new DataView(dt);
        gridEstadoPago.DataSource = MydataView;
        gridEstadoPago.DataBind();

        lbTotal.Text = total + " registro(s) encontrado(s)";

    }

    private void cargarGrillaSinprocesar()
    {

        string Sql;

        Sql = "";
        Sql = Sql + "SELECT  C.NOMBRE AS CONTRATISTA,REGION.DESCRIPCION AS REGION,ZONA.NOMBRE AS ZONA, LOCALIDAD.NOMBRE AS LOCALIDAD,O.DIRECCION,O.CLIENTE,O.RUTA, O.ID_ORDEN,O.NUMERO_ORDEN,O.ID_SERVICIO,O.LECTURA_RET,O.DIAMETRO_RET,O.ANO_MN,O.NUMERO_MN,O.DIAMETRO_NU, ";
        Sql = Sql + "O.LECTURA_MN,O.MATERIAL_VARAL,O.TIPO_LLAVE_PASO,O.NUM_SELLO,O.COLOR_SELLO,O.RUT_CLIENTE,O.OBSERVACION_OUT, ";
        Sql = Sql + "O.FECHA_CREACION,O.FECHA_INST,O.COD_INSTALADOR,O.TIPO_MARCA_DI,  ";
        Sql = Sql + "EO.DESCRIPCION AS ORDEN_ESTATUS,EMR.DESCRIPCION AS ESTATUS_MEDIDOR,MM.FABRICANTE AS MARCA,  ";
        Sql = Sql + "EV.DESCRIPCION AS VARAL_ESTATUS,ELL.DESCRIPCION AS LLAVE_ESTATUS,CC.DESCRIPCION AS CAMBIO_CAUSA,CC.TIPO_EVENTO AS TIPO_EVENTO, ";
        Sql = Sql + "(I.NOMBRE|| ' ' ||I.APELLIDO) AS NOMBRE,P.ID_PROCESO,P.GRUPO_PROCESO,TP.ID_TIPO_PROCESO,TP.DETALLE,  ";
        Sql = Sql + "O.OBSERVACION_IN,O.OBSERVACION_OUT,O.SERIE_MEDIDOR,O.COD_IMPROCEDENCIA,O.DIAMETRO_MEDIDOR,MM.FABRICANTE,O.ID_SINCRONIZACION,O.VISITA ";
        Sql = Sql + "FROM ORDEN O INNER JOIN PROCESO P ON P.ID_PROCESO=O.ID_PROCESO ";
        Sql = Sql + "INNER JOIN TIPO_PROCESO TP ON TP.ID_TIPO_PROCESO=P.ID_TIPO_PROCESO   ";
        Sql = Sql + "INNER JOIN EMPRESA E ON E.RUT_EMPRESA=O.RUT_EMPRESA   ";
        Sql = Sql + "LEFT JOIN ESTATUS_ORDEN EO ON EO.COD_ESTATUS_ORDEN= O.COD_IMPROCEDENCIA  ";
        Sql = Sql + "LEFT JOIN ESTADO_MEDIDOR_RETIRADO EMR ON EMR.COD_ESTATUS_MR =O.COD_ESTADO_MR ";
        Sql = Sql + "LEFT JOIN MARCA_MEDIDOR MM ON MM.COD_MARCA_MEDIDOR =O.COD_MARCA  ";
        Sql = Sql + "LEFT JOIN ESTATUS_VARAL_RETIRADO EV ON EV.COD_VR =O.COD_VARAL  ";
        Sql = Sql + "LEFT JOIN ESTATUS_LLAVE_RETIRADA ELL ON ELL.COD_LLR=O.COD_LLAVE  ";
        Sql = Sql + "LEFT JOIN CAUSA_CAMBIO CC ON CC.COD_CAUSA =O.CAUSA  ";
        Sql = Sql + "LEFT JOIN INSTALADOR I ON I.COD_INSTALADOR=O.COD_INSTALADOR  ";
        Sql = Sql + "JOIN  LOCALIDAD  ON LOCALIDAD.ID_LOCALIDAD=O.ID_LOCALIDAD  ";
        Sql = Sql + "JOIN  ZONA  ON LOCALIDAD.ID_ZONA=ZONA.ID_ZONA  ";
        Sql = Sql + "JOIN  REGION REGION ON REGION.ID_REGION=ZONA.ID_REGION   ";
        Sql = Sql + "JOIN SINCRONIZACION SINC ON SINC.ID_SINCRONIZACION=O.ID_SINCRONIZACION ";
        Sql = Sql + "where  o.fecha_creacion BETWEEN TO_DATE ('" + txtDesde.Text + "', 'dd-mm-yyyy') AND TO_DATE ('" + txtHasta.Text + "', 'dd-mm-yyyy') AND SINC.ID_SINCRONIZACION<>5";
        Sql = Sql + "UNION ";
        Sql = Sql + "SELECT REGION.DESCRIPCION AS REGION,ZONA.NOMBRE AS ZONA, LOCALIDAD.NOMBRE AS LOCALIDAD,O.DIRECCION,O.CLIENTE,O.RUTA,O.ID_ORDEN,O.NUMERO_ORDEN,O.ID_SERVICIO,O.LECTURA_RET,O.DIAMETRO_RET,O.ANO_MN,O.NUMERO_MN,O.DIAMETRO_NU, ";
        Sql = Sql + "O.LECTURA_MN,O.MATERIAL_VARAL,O.TIPO_LLAVE_PASO,O.NUM_SELLO,O.COLOR_SELLO,O.RUT_CLIENTE,O.OBSERVACION_OUT,  ";
        Sql = Sql + "O.FECHA_CREACION,O.FECHA_INST,O.COD_INSTALADOR,O.TIPO_MARCA_DI,  ";
        Sql = Sql + "EO.DESCRIPCION AS ORDEN_ESTATUS,EMR.DESCRIPCION AS ESTATUS_MEDIDOR,MM.FABRICANTE AS MARCA, ";
        Sql = Sql + "EV.DESCRIPCION AS VARAL_ESTATUS,ELL.DESCRIPCION AS LLAVE_ESTATUS,CC.DESCRIPCION AS CAMBIO_CAUSA, CC.TIPO_EVENTO AS TIPO_EVENTO, ";
        Sql = Sql + "(I.NOMBRE|| ' ' ||I.APELLIDO) AS NOMBRE,P.ID_PROCESO,P.GRUPO_PROCESO,TP.ID_TIPO_PROCESO,TP.DETALLE,";
        Sql = Sql + "O.OBSERVACION_IN,O.OBSERVACION_OUT,O.SERIE_MEDIDOR,O.COD_IMPROCEDENCIA,O.DIAMETRO_MEDIDOR,MM.FABRICANTE,O.ID_SINCRONIZACION,O.VISITA ";
        Sql = Sql + "FROM ORDEN_HISTORICOS O INNER JOIN PROCESO P ON P.ID_PROCESO=O.ID_PROCESO  ";
        Sql = Sql + "INNER JOIN TIPO_PROCESO TP ON TP.ID_TIPO_PROCESO=P.ID_TIPO_PROCESO  ";
        Sql = Sql + "INNER JOIN EMPRESA E ON E.RUT_EMPRESA=O.RUT_EMPRESA  ";
        Sql = Sql + "LEFT JOIN ESTATUS_ORDEN EO ON EO.COD_ESTATUS_ORDEN= O.COD_IMPROCEDENCIA  ";
        Sql = Sql + "LEFT JOIN ESTADO_MEDIDOR_RETIRADO EMR ON EMR.COD_ESTATUS_MR =O.COD_ESTADO_MR ";
        Sql = Sql + "LEFT JOIN MARCA_MEDIDOR MM ON MM.COD_MARCA_MEDIDOR =O.COD_MARCA  ";
        Sql = Sql + "LEFT JOIN ESTATUS_VARAL_RETIRADO EV ON EV.COD_VR =O.COD_VARAL  ";
        Sql = Sql + "LEFT JOIN ESTATUS_LLAVE_RETIRADA ELL ON ELL.COD_LLR=O.COD_LLAVE  ";
        Sql = Sql + "LEFT JOIN CAUSA_CAMBIO CC ON CC.COD_CAUSA =O.CAUSA  ";
        Sql = Sql + "LEFT JOIN INSTALADOR I ON I.COD_INSTALADOR=O.COD_INSTALADOR  ";
        Sql = Sql + "JOIN  LOCALIDAD  ON LOCALIDAD.ID_LOCALIDAD=O.ID_LOCALIDAD ";
        Sql = Sql + "JOIN  ZONA  ON LOCALIDAD.ID_ZONA=ZONA.ID_ZONA  ";
        Sql = Sql + "JOIN  REGION REGION ON REGION.ID_REGION=ZONA.ID_REGION ";
        Sql = Sql + "JOIN SINCRONIZACION SINC ON SINC.ID_SINCRONIZACION=O.ID_SINCRONIZACION ";
        Sql = Sql + "where o.fecha_creacion BETWEEN TO_DATE ('" + txtDesde.Text + "', 'dd-mm-yyyy') AND TO_DATE ('" + txtHasta.Text + "', 'dd-mm-yyyy') AND SINC.ID_SINCRONIZACION<>5";
    


        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        objConexion.Open();
        OracleCommand cmd = new OracleCommand();
        cmd.Connection = objConexion;
        cmd.CommandText = Sql;
        cmd.CommandType = CommandType.Text;
        OracleDataReader dr = cmd.ExecuteReader();
        dr.Read();
        gridEstadoPago.DataSource = dr;
        gridEstadoPago.DataBind();
        objConexion.Dispose();

        int total = 0;

        total = gridEstadoPago.Rows.Count;
        lbTotal.Text = total + " registro(s) encontrado(s)";




    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }

    protected void Button1_Click1(object sender, EventArgs e)
    {
        //if (chkSinPro.Checked)
        //{
        //    cargarGrillaSinprocesar();
        //}
        //else
        try
        {
            cargarGrilla();
        }
        catch (Exception ex)
        {
            String mensaje = ex.Message;
        }
       
    }


    protected void Button2_Click1(object sender, EventArgs e)
    {
        Response.ClearContent();
        Response.AddHeader("content-disposition", "attachment;filename=Estado_Pago_" + txtDesde.Text.ToString() + "_" + txtHasta.Text.ToString() + ".xls");
        Response.ContentType = "applicatio/excel";
        StringWriter sw = new StringWriter(); ;
        HtmlTextWriter htm = new HtmlTextWriter(sw);
        gridEstadoPago.RenderControl(htm);
        Response.Write(sw.ToString());
        Response.End();

    }
    protected void cb_contratista_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}