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

public partial class popDetalleHistorico : System.Web.UI.Page
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

                String servicio = Request.QueryString["Servicio"];
                String grupo = Request.QueryString["Grupo"];
                cargaDetalle(servicio, grupo);

            }
            catch (Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }

        }

       


        

    }

    public void cargaDetalle(String servicio, String grupo)
    {
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_ORDEN.CARGA_DET_HISTORICO", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
              

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_rutem", OracleType.NVarChar, ParameterDirection.Input, PRO.recSession(rutaXml, "RUT_EMPRESA"));
        PRO.agrega_parametro_sp(da, "i_servicio", OracleType.NVarChar, ParameterDirection.Input, servicio);
        PRO.agrega_parametro_sp(da, "i_grupo", OracleType.NVarChar, ParameterDirection.Input, grupo);


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
            //lbErrorGrilla.ForeColor = System.Drawing.Color.Red;
            //lbErrorGrilla.Text = ex.Message.ToString();
            //lbErrorGrilla.Text = ex.ToString();
        }

        DataTable dt = new DataTable();
        /*
        dt.Columns.Add(new DataColumn("ID_ORDEN", typeof(Int32)));
        dt.Columns.Add(new DataColumn("NUMERO_ORDEN", typeof(Int32)));
        dt.Columns.Add(new DataColumn("ID_SERVICIO", typeof(String)));
        dt.Columns.Add(new DataColumn("LECTURA_RET", typeof(Int32)));
        dt.Columns.Add(new DataColumn("DIAMETRO_RET", typeof(Int32)));
        dt.Columns.Add(new DataColumn("ANO_MN", typeof(String)));
        dt.Columns.Add(new DataColumn("NUMERO_MN", typeof(String)));
        dt.Columns.Add(new DataColumn("DIAMETRO_NU", typeof(Int32)));
        dt.Columns.Add(new DataColumn("LECTURA_MN", typeof(Int32)));
        dt.Columns.Add(new DataColumn("MATERIAL_VARAL", typeof(String)));
        dt.Columns.Add(new DataColumn("TIPO_LLAVE_PASO", typeof(String)));
        dt.Columns.Add(new DataColumn("NUM_SELLO", typeof(String)));
        dt.Columns.Add(new DataColumn("COLOR_SELLO", typeof(String)));
        dt.Columns.Add(new DataColumn("RUT_CLIENTE", typeof(String)));
        dt.Columns.Add(new DataColumn("OBSERVACION_OUT", typeof(String)));
        dt.Columns.Add(new DataColumn("FECHA_CREACION", typeof(String)));
        dt.Columns.Add(new DataColumn("FECHA_INST", typeof(String)));
        dt.Columns.Add(new DataColumn("LOCALIDAD", typeof(String)));
        dt.Columns.Add(new DataColumn("DIRECCION", typeof(String)));
        dt.Columns.Add(new DataColumn("CLIENTE", typeof(String)));
        dt.Columns.Add(new DataColumn("RUTA", typeof(String)));
        dt.Columns.Add(new DataColumn("COD_INSTALADOR", typeof(String)));
        dt.Columns.Add(new DataColumn("TIPO_MARCA_DI", typeof(String)));
        dt.Columns.Add(new DataColumn("X", typeof(String)));
        dt.Columns.Add(new DataColumn("Y", typeof(String)));
        dt.Columns.Add(new DataColumn("ORDEN_ESTATUS", typeof(String)));
        dt.Columns.Add(new DataColumn("ESTATUS_MEDIDOR", typeof(String)));
        dt.Columns.Add(new DataColumn("MARCA", typeof(String)));
        dt.Columns.Add(new DataColumn("VARAL_ESTATUS", typeof(String)));
        dt.Columns.Add(new DataColumn("LLAVE_ESTATUS", typeof(String)));
        dt.Columns.Add(new DataColumn("CAMBIO_CAUSA", typeof(String)));
        dt.Columns.Add(new DataColumn("NOMBRE", typeof(String)));
        dt.Columns.Add(new DataColumn("ID_PROCESO", typeof(Int32)));
        dt.Columns.Add(new DataColumn("GRUPO_PROCESO", typeof(String)));
        dt.Columns.Add(new DataColumn("ID_TIPO_PROCESO", typeof(Int32)));
        dt.Columns.Add(new DataColumn("DETALLE", typeof(String)));
        */
        dt.Columns.Add(new DataColumn("TIPO_MARCA_DI", typeof(String)));
        dt.Columns.Add(new DataColumn("OBSERVACION_IN", typeof(String)));
        dt.Columns.Add(new DataColumn("OBSERVACION_OUT", typeof(String)));

        DataRow dr;

        int total = 0;

        foreach (DataRow drOrdenItem in dtOrdenes.Rows)
        {

            dr = dt.NewRow();
            /*
            dr["ID_ORDEN"] = drOrdenItem["ID_ORDEN"].ToString();
            dr["NUMERO_ORDEN"] = drOrdenItem["NUMERO_ORDEN"].ToString();
            dr["ID_SERVICIO"] = drOrdenItem["ID_SERVICIO"].ToString();
            dr["LECTURA_RET"] = drOrdenItem["LECTURA_RET"].ToString();
            dr["DIAMETRO_RET"] = drOrdenItem["DIAMETRO_RET"].ToString();
            dr["ANO_MN"] = drOrdenItem["ANO_MN"].ToString();
            dr["NUMERO_MN"] = drOrdenItem["NUMERO_MN"].ToString();
            dr["DIAMETRO_NU"] = drOrdenItem["DIAMETRO_NU"].ToString();
            dr["LECTURA_MN"] = drOrdenItem["LECTURA_MN"].ToString();
            dr["MATERIAL_VARAL"] = drOrdenItem["MATERIAL_VARAL"].ToString();
            dr["TIPO_LLAVE_PASO"] = drOrdenItem["TIPO_LLAVE_PASO"].ToString();
            dr["NUM_SELLO"] = drOrdenItem["NUM_SELLO"].ToString();
            dr["COLOR_SELLO"] = drOrdenItem["COLOR_SELLO"].ToString();
            dr["RUT_CLIENTE"] = drOrdenItem["RUT_CLIENTE"].ToString();
            dr["OBSERVACION_OUT"] = drOrdenItem["OBSERVACION_OUT"].ToString();
            dr["FECHA_CREACION"] = drOrdenItem["FECHA_CREACION"].ToString();
            dr["FECHA_INST"] = drOrdenItem["FECHA_INST"].ToString();
            dr["LOCALIDAD"] = drOrdenItem["LOCALIDAD"].ToString();
            dr["DIRECCION"] = drOrdenItem["DIRECCION"].ToString();
            dr["CLIENTE"] = drOrdenItem["CLIENTE"].ToString();
            dr["RUTA"] = drOrdenItem["RUTA"].ToString();
            dr["COD_INSTALADOR"] = drOrdenItem["COD_INSTALADOR"].ToString();
            dr["TIPO_MARCA_DI"] = drOrdenItem["TIPO_MARCA_DI"].ToString();
            dr["X"] = drOrdenItem["X"].ToString();
            dr["Y"] = drOrdenItem["Y"].ToString();
            dr["ORDEN_ESTATUS"] = drOrdenItem["ORDEN_ESTATUS"].ToString();
            dr["ESTATUS_MEDIDOR"] = drOrdenItem["ESTATUS_MEDIDOR"].ToString();
            dr["MARCA"] = drOrdenItem["MARCA"].ToString();
            dr["VARAL_ESTATUS"] = drOrdenItem["VARAL_ESTATUS"].ToString();
            dr["LLAVE_ESTATUS"] = drOrdenItem["LLAVE_ESTATUS"].ToString();
            dr["CAMBIO_CAUSA"] = drOrdenItem["CAMBIO_CAUSA"].ToString();
            dr["NOMBRE"] = drOrdenItem["NOMBRE"].ToString();
            dr["ID_PROCESO"] = drOrdenItem["ID_PROCESO"].ToString();
            dr["GRUPO_PROCESO"] = drOrdenItem["GRUPO_PROCESO"].ToString();
            dr["ID_TIPO_PROCESO"] = drOrdenItem["ID_TIPO_PROCESO"].ToString();
            dr["DETALLE"] = drOrdenItem["DETALLE"].ToString();
            */
            dr["TIPO_MARCA_DI"] = drOrdenItem["TIPO_MARCA_DI"].ToString();
            dr["OBSERVACION_IN"] = drOrdenItem["OBSERVACION_IN"].ToString();
            dr["OBSERVACION_OUT"] = drOrdenItem["OBSERVACION_OUT"].ToString();

            dt.Rows.Add(dr);

            total = total + 1;

            lbTmd.Text = dr["TIPO_MARCA_DI"].ToString();
            txtIn.Text = dr["OBSERVACION_IN"].ToString();
            txtOut.Text = dr["OBSERVACION_OUT"].ToString();
           
        }

        

    }
}