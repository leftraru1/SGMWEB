using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OracleClient;
using System.Xml;
using System.Data.SqlClient;
using System.Net;
using System.Configuration;
using System.Net.Mail;
using System.IO;
using Microsoft.VisualBasic;



public partial class Imagenes_PerfilesUsuario : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();
    public DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!Page.IsPostBack)
        {

            try
            {
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                PRO.recSession(rutaXml, "RUT_EMPRESA");

                cargaPerfil();
                IMG2.Visible = false;
                IMG5.Visible = false;

            }
            catch (Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }

            
           
            
            
        }
        
             

    }

    public void cargaPerfil()
    {

        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_PERFIL.CARGA_PERFIL", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "PERFIL");
        objConexion.Close();

        int i = 1;
        comboPerfil.Items.Clear();
        comboPerfil.Items.Add("Seleccione Perfil...");
        comboPerfil.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["PERFIL"].Rows)
        {

            comboPerfil.Items.Add(row[1].ToString());
            comboPerfil.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
 
    }
    public void cargaGrilla()
    {

        String sSQL, perfilSQL;
        OracleDataAdapter objComando;
        DataTable dtSubmenuItems = new DataTable();
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        objConexion.Open();

        sSQL = "select "+
               "SUBMENU.ID_SUBMENU, " +
               "SUBMENU.ID_MENU, " + 
               "SUBMENU.MENU, " +
               "MENU.ID_MENU as id_menu_p, " +
               "MENU.MENU as menu_p "+
               "FROM SUBMENU JOIN MENU "+
               "ON SUBMENU.ID_MENU=MENU.ID_MENU  "+
               "ORDER BY MENU.NOMBRE,SUBMENU.MENU";

        objComando = new OracleDataAdapter(sSQL, conexion_cliente_oracle);
        objComando.Fill(dtSubmenuItems);

        dt = new DataTable();
        dt.Columns.Add(new DataColumn("id_submenu", typeof(String)));
        dt.Columns.Add(new DataColumn("menu", typeof(String)));
        dt.Columns.Add(new DataColumn("menup", typeof(String)));
        dt.Columns.Add(new DataColumn("id_perfil", typeof(String)));

        DataRow dr;

        foreach (DataRow drSubMenuItem in dtSubmenuItems.Rows)
        {
            dr = dt.NewRow();
            dr["id_submenu"] = drSubMenuItem["id_submenu"].ToString();
            dr["menu"] = drSubMenuItem["menu"].ToString();
            dr["menup"] = drSubMenuItem["menu_p"].ToString();
            dr["id_perfil"] = comboPerfil.Items[comboPerfil.SelectedIndex].Value;
            dt.Rows.Add(dr);
        }

        DataView MydataView;
        MydataView = new DataView(dt);
        GrillaPermisos.DataSource = MydataView;
        GrillaPermisos.DataBind();

        DataTable dtPermisosItems = new DataTable();
        perfilSQL = "SELECT * from PERMISO WHERE id_perfil=" + comboPerfil.Items[comboPerfil.SelectedIndex].Value.ToString() + " order by id_submenu";
        OracleDataAdapter daPermiso = new OracleDataAdapter(perfilSQL, conexion_cliente_oracle);
        daPermiso.SelectCommand.CommandType = CommandType.Text;
        daPermiso.Fill(dtPermisosItems);

        int i = 0;
        DataGridItem dtgitem;
        CheckBox check_permiso = new CheckBox();
        for (i = 0; i < GrillaPermisos.Items.Count; i++)
        {
            dtgitem = GrillaPermisos.Items[i];
            check_permiso = (CheckBox)(dtgitem.FindControl("checkPermiso"));
            foreach (DataRow drPermisoItem in dtPermisosItems.Rows)
            {
                String id_submenu_grilla, id_submenu_permiso;
                id_submenu_grilla = dtgitem.Cells[0].Text;
                id_submenu_permiso = drPermisoItem["id_submenu"].ToString();

                if (id_submenu_grilla.Equals(id_submenu_permiso))
                {
                    check_permiso.Checked = true;
                }                
            }
        }

        Label1.Text = "Perfiles disponibles para " + comboPerfil.SelectedItem.ToString();

       // GrillaPermisos.Enabled = true;
      //  ActulizaPerfil.Enabled = true;

    }

    protected void comboPerfil_SelectedIndexChanged(object sender, EventArgs e)
    {

        //Label1.Text = comboPerfil.SelectedValue.ToString() + "-" + comboPerfil.SelectedItem.ToString();
        cargaGrilla();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter ComandoDA;

        objConexion.Open();
        ComandoDA = new OracleDataAdapter("PK_PERMISO.ELIMINA_PERMISOS", objConexion);
        ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(ComandoDA, "i_id_perfil", OracleType.Int32,ParameterDirection.Input,comboPerfil.Items[comboPerfil.SelectedIndex].Value);
        ComandoDA.SelectCommand.ExecuteNonQuery();
        objConexion.Close();        

        int i;
        DataGridItem dtgitem;
        CheckBox check_permiso = new CheckBox();
        for(i=0;i<GrillaPermisos.Items.Count;i++)
        {
            dtgitem = GrillaPermisos.Items[i];
            check_permiso = (CheckBox)(dtgitem.FindControl("checkPermiso"));

            if(check_permiso.Checked == true)
            {
                agrega_permiso(int.Parse(dtgitem.Cells[0].Text));
            }
           
        }
        try
        {
            String str_fecha, str_hora, str_desc_evento;

            str_fecha=DateTime.Now.Date.ToString();
            str_hora=DateTime.Now.Hour.ToString() + ":" + DateTime.Now.Minute.ToString();
            str_desc_evento = "SE ACTUALIZO EL PERFIL " + comboPerfil.Items[comboPerfil.SelectedIndex].Text;
            PRO.inserta_log_sistema("1", "1005401", str_fecha, str_hora, str_desc_evento, "0", "0", Request.ServerVariables["REMOTE_ADDR"].ToString());
            
            lbResultado.ForeColor = System.Drawing.Color.Blue;
            lbResultado.Text = "Actualización realizada exitosamente.";
            
            IMG2.Visible = true;
            IMG5.Visible = false;
        }
        catch(Exception ex)
        {
            lbResultado.ForeColor = System.Drawing.Color.Red;
            lbResultado.Text = "Error: " + ex.Message;

            IMG2.Visible = false;
            IMG5.Visible = true;
        }
              
    }

    private void agrega_permiso(int indice_submenu)
    {
        OracleConnection objConn = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter ComandoAGREGAR;

        objConn.Open();
        ComandoAGREGAR = new OracleDataAdapter("PK_PERMISO.AGREGA_PERMISOS", objConn);
        ComandoAGREGAR.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(ComandoAGREGAR, "i_id_submenu", OracleType.Int32,ParameterDirection.Input, indice_submenu.ToString());
        PRO.agrega_parametro_sp(ComandoAGREGAR, "i_id_perfil", OracleType.Int32,ParameterDirection.Input,comboPerfil.Items[comboPerfil.SelectedIndex].Value);
        ComandoAGREGAR.SelectCommand.ExecuteNonQuery();
        objConn.Close();
    }

  
}