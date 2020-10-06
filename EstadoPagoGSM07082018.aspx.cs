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
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

            try
            {
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                PRO.recSession(rutaXml, "RUT_EMPRESA");

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

    private void cargarGrilla()
    {

        string Sql;

        Sql = "";
        Sql = Sql + "SELECT  REGION.DESCRIPCION AS REGION,ZONA.NOMBRE AS ZONA, LOCALIDAD.NOMBRE AS LOCALIDAD,O.DIRECCION,O.CLIENTE,O.RUTA, O.ID_ORDEN,O.NUMERO_ORDEN,O.ID_SERVICIO,O.LECTURA_RET,O.DIAMETRO_RET,O.ANO_MN,O.NUMERO_MN,O.DIAMETRO_NU, ";
        Sql = Sql + "O.LECTURA_MN,O.MATERIAL_VARAL,O.TIPO_LLAVE_PASO,O.NUM_SELLO,O.COLOR_SELLO,O.RUT_CLIENTE,O.OBSERVACION_OUT, ";
        Sql = Sql + "O.FECHA_CREACION,O.FECHA_INST,O.COD_INSTALADOR,O.TIPO_MARCA_DI, ";
        Sql = Sql + "EO.DESCRIPCION AS ORDEN_ESTATUS,EMR.DESCRIPCION AS ESTATUS_MEDIDOR,MM.FABRICANTE AS MARCA, ";
        Sql = Sql + "EV.DESCRIPCION AS VARAL_ESTATUS,ELL.DESCRIPCION AS LLAVE_ESTATUS,CC.DESCRIPCION AS CAMBIO_CAUSA,CC.TIPO_EVENTO AS TIPO_EVENTO, ";
        Sql = Sql + "(I.NOMBRE|| ' ' ||I.APELLIDO) AS NOMBRE,P.ID_PROCESO,P.GRUPO_PROCESO,TP.ID_TIPO_PROCESO,TP.DETALLE, ";
        Sql = Sql + "O.OBSERVACION_IN,O.OBSERVACION_OUT,O.SERIE_MEDIDOR,O.COD_IMPROCEDENCIA,O.DIAMETRO_MEDIDOR,MM.FABRICANTE,O.ID_SINCRONIZACION,O.VISITA ";
        Sql = Sql + "FROM ORDEN O INNER JOIN PROCESO P ON P.ID_PROCESO=O.ID_PROCESO  ";
        Sql = Sql + "INNER JOIN TIPO_PROCESO TP ON TP.ID_TIPO_PROCESO=P.ID_TIPO_PROCESO  ";
        Sql = Sql + "INNER JOIN EMPRESA E ON E.RUT_EMPRESA=O.RUT_EMPRESA  ";
        Sql = Sql + "LEFT JOIN ESTATUS_ORDEN EO ON EO.COD_ESTATUS_ORDEN= O.COD_IMPROCEDENCIA ";
        Sql = Sql + "LEFT JOIN ESTADO_MEDIDOR_RETIRADO EMR ON EMR.COD_ESTATUS_MR =O.COD_ESTADO_MR ";
        Sql = Sql + "LEFT JOIN MARCA_MEDIDOR MM ON MM.COD_MARCA_MEDIDOR =O.COD_MARCA ";
        Sql = Sql + "LEFT JOIN ESTATUS_VARAL_RETIRADO EV ON EV.COD_VR =O.COD_VARAL ";
        Sql = Sql + "LEFT JOIN ESTATUS_LLAVE_RETIRADA ELL ON ELL.COD_LLR=O.COD_LLAVE ";
        Sql = Sql + "LEFT JOIN CAUSA_CAMBIO CC ON CC.COD_CAUSA =O.CAUSA ";
        Sql = Sql + "LEFT JOIN INSTALADOR I ON I.COD_INSTALADOR=O.COD_INSTALADOR ";
        Sql = Sql + "JOIN  LOCALIDAD  ON LOCALIDAD.ID_LOCALIDAD=O.ID_LOCALIDAD ";
        Sql = Sql + "JOIN  ZONA  ON LOCALIDAD.ID_ZONA=ZONA.ID_ZONA ";
        Sql = Sql + "JOIN  REGION REGION ON REGION.ID_REGION=ZONA.ID_REGION ";
        Sql = Sql + "WHERE  O.FECHA_INST BETWEEN TO_DATE ('" + txtDesde.Text + "', 'dd-mm-yyyy') AND TO_DATE ('" + txtHasta.Text + "', 'dd-mm-yyyy')";
        Sql = Sql + "UNION SELECT REGION.DESCRIPCION AS REGION,ZONA.NOMBRE AS ZONA, LOCALIDAD.NOMBRE AS LOCALIDAD,O.DIRECCION,O.CLIENTE,O.RUTA,O.ID_ORDEN,O.NUMERO_ORDEN,O.ID_SERVICIO,O.LECTURA_RET,O.DIAMETRO_RET,O.ANO_MN,O.NUMERO_MN,O.DIAMETRO_NU, ";
        Sql = Sql + "O.LECTURA_MN,O.MATERIAL_VARAL,O.TIPO_LLAVE_PASO,O.NUM_SELLO,O.COLOR_SELLO,O.RUT_CLIENTE,O.OBSERVACION_OUT, ";
        Sql = Sql + "O.FECHA_CREACION,O.FECHA_INST,O.COD_INSTALADOR,O.TIPO_MARCA_DI, ";
        Sql = Sql + "EO.DESCRIPCION AS ORDEN_ESTATUS,EMR.DESCRIPCION AS ESTATUS_MEDIDOR,MM.FABRICANTE AS MARCA, ";
        Sql = Sql + "EV.DESCRIPCION AS VARAL_ESTATUS,ELL.DESCRIPCION AS LLAVE_ESTATUS,CC.DESCRIPCION AS CAMBIO_CAUSA, CC.TIPO_EVENTO AS TIPO_EVENTO, ";
        Sql = Sql + "(I.NOMBRE|| ' ' ||I.APELLIDO) AS NOMBRE,P.ID_PROCESO,P.GRUPO_PROCESO,TP.ID_TIPO_PROCESO,TP.DETALLE, ";
        Sql = Sql + "O.OBSERVACION_IN,O.OBSERVACION_OUT,O.SERIE_MEDIDOR,O.COD_IMPROCEDENCIA,O.DIAMETRO_MEDIDOR,MM.FABRICANTE,O.ID_SINCRONIZACION,O.VISITA ";
        Sql = Sql + "FROM ORDEN_HISTORICOS O INNER JOIN PROCESO P ON P.ID_PROCESO=O.ID_PROCESO ";
        Sql = Sql + "INNER JOIN TIPO_PROCESO TP ON TP.ID_TIPO_PROCESO=P.ID_TIPO_PROCESO  ";
        Sql = Sql + "INNER JOIN EMPRESA E ON E.RUT_EMPRESA=O.RUT_EMPRESA ";
        Sql = Sql + "LEFT JOIN ESTATUS_ORDEN EO ON EO.COD_ESTATUS_ORDEN= O.COD_IMPROCEDENCIA ";
        Sql = Sql + "LEFT JOIN ESTADO_MEDIDOR_RETIRADO EMR ON EMR.COD_ESTATUS_MR =O.COD_ESTADO_MR ";
        Sql = Sql + "LEFT JOIN MARCA_MEDIDOR MM ON MM.COD_MARCA_MEDIDOR =O.COD_MARCA ";
        Sql = Sql + "LEFT JOIN ESTATUS_VARAL_RETIRADO EV ON EV.COD_VR =O.COD_VARAL ";
        Sql = Sql + "LEFT JOIN ESTATUS_LLAVE_RETIRADA ELL ON ELL.COD_LLR=O.COD_LLAVE ";
        Sql = Sql + "LEFT JOIN CAUSA_CAMBIO CC ON CC.COD_CAUSA =O.CAUSA ";
        Sql = Sql + "LEFT JOIN INSTALADOR I ON I.COD_INSTALADOR=O.COD_INSTALADOR ";
        Sql = Sql + "JOIN  LOCALIDAD  ON LOCALIDAD.ID_LOCALIDAD=O.ID_LOCALIDAD ";
        Sql = Sql + "JOIN  ZONA  ON LOCALIDAD.ID_ZONA=ZONA.ID_ZONA ";
        Sql = Sql + "JOIN  REGION REGION ON REGION.ID_REGION=ZONA.ID_REGION ";
        Sql = Sql + "WHERE  O.FECHA_INST BETWEEN TO_DATE ('" + txtDesde.Text + "', 'dd-mm-yyyy') AND TO_DATE ('" + txtHasta.Text + "', 'dd-mm-yyyy')";

        

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

    private void cargarGrillaSinprocesar()
    {

        string Sql;

        Sql = "";
        Sql = Sql + "SELECT  REGION.DESCRIPCION AS REGION,ZONA.NOMBRE AS ZONA, LOCALIDAD.NOMBRE AS LOCALIDAD,O.DIRECCION,O.CLIENTE,O.RUTA, O.ID_ORDEN,O.NUMERO_ORDEN,O.ID_SERVICIO,O.LECTURA_RET,O.DIAMETRO_RET,O.ANO_MN,O.NUMERO_MN,O.DIAMETRO_NU, ";
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
        cargarGrilla();
    }


    protected void Button2_Click1(object sender, EventArgs e)
    {
        Response.ClearContent();
        Response.AddHeader("content-disposition", "attachment;filename=Estado_Pago" + DateTime.Today + ".xls");
        Response.ContentType = "applicatio/excel";
        StringWriter sw = new StringWriter(); ;
        HtmlTextWriter htm = new HtmlTextWriter(sw);
        gridEstadoPago.RenderControl(htm);
        Response.Write(sw.ToString());
        Response.End();

    }
}