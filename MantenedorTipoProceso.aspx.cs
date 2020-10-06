using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OracleClient;
using System.Data.SqlTypes;
using System.Data.SqlClient;
using System.Data.Sql;
using System.Data.OleDb;
using System.Drawing;
using ASP;
using System.Xml;
using System.Configuration;
using Microsoft.VisualBasic;

public partial class MantenedorTipoProceso : System.Web.UI.Page
{
    string id_perfil;
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();
    public DataTable dt;

    internal void inicializa_pagina()
    {
        GrillaTipo_proceso.Visible = true;
        tablaCausaCambio.Visible = false;
        btnok_agregar0.Visible = true;
        //btnvolver_agregar.Visible = false;
        //check();


    }


    protected void Page_Load(object sender, EventArgs e)
    {

        XmlDataDocument doc_xml = new XmlDataDocument();
         CargaGrilla();
       
        inicializa_pagina();


        try
        {
            doc_xml.Load(Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml");
        }
        catch (Exception ex)
        {
            Response.Redirect("ErrorSession.aspx");
        }

        string XMLperfil;
        XMLperfil = doc_xml.SelectSingleNode("SESSION/DATOS_USUARIO/ID_PERFIL").InnerText;
        lb_perfil_usuario.Text = XMLperfil.ToString();
        lb_perfil_usuario.Visible = false;
        lb_rut_empresa.Text = doc_xml.SelectSingleNode("SESSION/DATOS_USUARIO/RUT_EMPRESA").InnerText;
        lb_rut_empresa.Visible = false;
        lb_id_usuario.Text = doc_xml.SelectSingleNode("SESSION/DATOS_USUARIO/ID_USUARIO").InnerText;

        LOG_ID_USUARIO.Text = doc_xml.SelectSingleNode("SESSION/DATOS_USUARIO/ID_USUARIO").InnerText;
        LOG_ID_USUARIO.Visible = false;

        string session_user, session_empresa;
        session_user = doc_xml.SelectSingleNode("SESSION/DATOS_USUARIO/NOMBRE").InnerText;
        session_empresa = doc_xml.SelectSingleNode("SESSION/DATOS_USUARIO/NOMBRE_EMPRESA").InnerText;
        lb_session_user.Text = ": " + session_user + " / ";
        lb_session_user.Visible = false;
        lb_session_empresa.Visible = false;
        lb_session_empresa.Text = ": " + session_empresa;
        Session[Session.SessionID + "_Empresa"] = doc_xml.SelectSingleNode("SESSION/DATOS_USUARIO/NOMBRE_EMPRESA").InnerText;
        //inicializa_pagina();
        lb_id_usuario.Visible = false;
    
        //Llena_combo_perfiles(XMLperfil); //PASAR PARAMETRO SESSION TIPO DE PERFIL
    }

    internal void recupera_session()
    {
        XmlDataDocument recupera_xml = new XmlDataDocument();
        recupera_xml.Load(Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml");
        string session_user, session_empresa;
        session_user = recupera_xml.SelectSingleNode("SESSION/DATOS_USUARIO/NOMBRE").InnerText;
        session_empresa = recupera_xml.SelectSingleNode("SESSION/DATOS_USUARIO/NOMBRE_EMPRESA").InnerText;
        lb_rut_empresa.Text = recupera_xml.SelectSingleNode("SESSION/DATOS_USUARIO/RUT_EMPRESA").InnerText;
        lb_id_usuario.Text = recupera_xml.SelectSingleNode("SESSION/DATOS_USUARIO/ID_USUARIO").InnerText;
        id_perfil = recupera_xml.SelectSingleNode("SESSION/DATOS_USUARIO/ID_PERFIL").InnerText;
        lb_session_user.Text = ": " + session_user + " / ";

        lb_session_empresa.Text = ": " + session_empresa;

        lb_session_user.Visible = false;
        lb_session_empresa.Visible = false;
    }
    protected void Btn_Cancelar_Click(object sender, EventArgs e)
    {
        GrillaTipo_proceso.Visible = true;
        tablaCausaCambio.Visible = false;
        btnok_agregar0.Visible = true;
        //btnvolver_agregar.Visible = true;
        btnok_agregar0.Visible = true;
        lb_cantidad_registros.Visible = true;
        tablaMant.Visible = true;
        CargaGrilla();

    }

    protected void btn_agregaCausaC_Click(object sender, EventArgs e)
    {
        //if (Page.IsValid)
       // { //validaciones NUEVO_TIPO_PROCESO(i_DETALLE IN NVARCHAR2)

            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            objConexion.Open();
            OracleDataAdapter ComandoDA = new OracleDataAdapter("PK_MANTENEDOR_TIP_PROC.NUEVO_TIPO_PROCESO", objConexion);
            ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;
            PRO.agrega_parametro_sp(ComandoDA, "i_DETALLE", OracleType.NVarChar, ParameterDirection.Input, txtDescripcionCausa.Text);
            ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;
            try
            {
                
                ComandoDA.SelectCommand.ExecuteNonQuery();
                GrillaTipo_proceso.Visible = true;
                tablaCausaCambio.Visible = false;
                btnok_agregar0.Visible = true;
               // btnvolver_agregar.Visible = true;
                btnok_agregar0.Visible = true;
                lb_cantidad_registros.Visible = true;
                System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, typeof(System.Web.UI.Page), "Script", "MensajeCorrecto();", true);
                tablaMant.Visible = true;
                CargaGrilla();
                objConexion.Close();
                objConexion.Dispose();
            }
            catch (Exception ex)
            {
                GrillaTipo_proceso.Visible = false;
                btnok_agregar0.Visible = false;
                lb_cantidad_registros.Visible = false;
                tablaCausaCambio.Visible = true;
                tablaMant.Visible = false;
                System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, typeof(System.Web.UI.Page), "Script", "alerta();", true);
                
            }
       
        //}
    }

    private void CargaGrilla()
    {
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            objConexion.Open();
            OracleDataAdapter ComandoDA = new OracleDataAdapter("PK_MANTENEDOR_TIP_PROC.CARGA_GRILLA_TIPO", objConexion);
            ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;
            PRO.agrega_parametro_sp(ComandoDA, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
            ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;
        
            DataTable dtCausaC = new DataTable();
            ComandoDA.Fill(dtCausaC);
            objConexion.Close();
            objConexion.Dispose();

            dt = new DataTable();
            dt.Columns.Add(new DataColumn("id_TIPO_PROCESO", typeof(string)));
            dt.Columns.Add(new DataColumn("detalle", typeof(string)));
         

            DataRow dr;
            int cont_registros;
            cont_registros = 0;
            foreach (DataRow drCausaCItem in dtCausaC.Rows)
            {
                dr = dt.NewRow();
                dr["id_TIPO_PROCESO"] = drCausaCItem["id_TIPO_PROCESO"].ToString();
                dr["DETALLE"] = drCausaCItem["DETALLE"].ToString();
              
                dt.Rows.Add(dr);
                cont_registros = cont_registros + 1;

            }


            lb_cantidad_registros.Text = cont_registros.ToString() + " coincidencia(s) encontrada(s)";
            DataView MydataView;
            MydataView = new DataView(dt);
            GrillaTipo_proceso.DataSource = MydataView;
            GrillaTipo_proceso.DataBind();

    }


    protected void btnok_agregar0_Click(object sender, EventArgs e)
    {
        GrillaTipo_proceso.Visible = false;
        btnok_agregar0.Visible = false;
        lb_cantidad_registros.Visible = false;
        tablaCausaCambio.Visible = true;
        tablaMant.Visible = false;
    }
  
    //protected void GrillaTipo_proceso_UpdateCommand(object source, DataGridCommandEventArgs e)
    //{
    //    string indice, detalle;
    //    int id_tipo_proceso;

    //    indice = e.Item.ItemIndex.ToString();

    //    id_tipo_proceso = int.Parse(GrillaTipo_proceso.Items[Int32.Parse(indice)].Cells[0].Text);
    //    detalle = GrillaTipo_proceso.Items[Int32.Parse(indice)].Cells[1].Text;


    //    if (id_tipo_proceso <= 5)
    //    {

    //        System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, typeof(System.Web.UI.Page), "Script", "Error_mod();", true);

    //    }
    //    else
    //    {



    //        String vtn = "window.open('popModificaTipoProceso.aspx?id_tipo_proceso=" + id_tipo_proceso + "&detalle=" + detalle + "','Dates','scrollbars=yes,resizable=yes,height=160,width=510')";
    //        ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", vtn, true);



    //    }
    //}



    protected void GrillaTipo_proceso_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int index = int.Parse(e.CommandArgument.ToString());

        string detalle;
        int id_tipo_proceso;

        id_tipo_proceso = int.Parse(GrillaTipo_proceso.Rows[index].Cells[0].Text);
        detalle = HttpUtility.HtmlDecode(GrillaTipo_proceso.Rows[index].Cells[1].Text);

        if (e.CommandName == "modificar")
        {


            if (id_tipo_proceso <= 5)
            {

                System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, typeof(System.Web.UI.Page), "Script", "Error_mod();", true);

            }
            else
            {



                String vtn = "window.open('popModificaTipoProceso.aspx?id_tipo_proceso=" + id_tipo_proceso + "&detalle=" + detalle + "','Dates','scrollbars=yes,resizable=yes,height=160,width=510')";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", vtn, true);



            }
        }

    }
  
   
}