using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OracleClient;
using System.Xml;
using System.Net;
using System.Configuration;
using System.Net.Mail;
using System.IO;
using Microsoft.Reporting.WebForms;

public partial class popModificaTipoProceso : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();
    public String id_tipo_proceso, detalle, pr, tipo_proceso, empresa, visita;
   

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

            try
            {
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                empresa = PRO.recSession(rutaXml, "RUT_EMPRESA");

            }
            catch (Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }

            try
            {
                id_tipo_proceso = Request.QueryString["id_tipo_proceso"];
                detalle = Request.QueryString["detalle"];
                txtDescripcionCausa.Text = detalle;
                TXT_id_tipo_proceso.Text = id_tipo_proceso;

               
            }
            catch (Exception ex)
            {
                String error = ex.ToString();
            }

        }
    }


    private void modificaTipo_proceso()
    {

        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        objConexion.Open();
        OracleDataAdapter ComandoDA = new OracleDataAdapter("PK_MANTENEDOR_TIP_PROC.MODIFICA_TIPO_PROCESO", objConexion);
        ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;
        PRO.agrega_parametro_sp(ComandoDA, "i_DETALLE", OracleType.NVarChar, ParameterDirection.Input, txtDescripcionCausa.Text);
        PRO.agrega_parametro_sp(ComandoDA, "i_id_tipo_proceso", OracleType.Number, ParameterDirection.Input, TXT_id_tipo_proceso.Text);
        ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;
        try
        {

           ComandoDA.SelectCommand.ExecuteNonQuery();

            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, typeof(System.Web.UI.Page), "Script", "MODIFICA_CORRECTO();", true);
   
            objConexion.Close();
            objConexion.Dispose();
        }
        catch (Exception ex)
        {
          
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, typeof(System.Web.UI.Page), "Script", "alerta();", true);

        }
    
    
    }


    protected void btn_agregaCausaC_Click(object sender, EventArgs e)
    {
        modificaTipo_proceso();
    }
}