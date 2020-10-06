using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MantencionCausaCambio : System.Web.UI.Page
{

    string id_perfil;
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();
    public DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {
        GrillaCausaCambio.Visible = true;
        tbl_NuevaCausa.Visible = false;
        img_ok.Visible = false;
    }

    private void Llena_combo_empresas(string IDPerfil, string EMPRESA_USER)
    {

        string sql_empresas;
        DataTable dtEmpresas = new DataTable();
        sql_empresas = "select * from EMPRESA"; // Para rellenar combo
        OracleDataAdapter objComando_Empresa;
        objComando_Empresa = new OracleDataAdapter(sql_empresas, conexion_cliente_oracle);
        objComando_Empresa.Fill(dtEmpresas);
        string valueCombo, textoCombo;
        combo_empresas.Items.Clear();

        if (IDPerfil == "3")
        {
            foreach (DataRow drEmpresaItem in dtEmpresas.Rows)
            {
                valueCombo = drEmpresaItem["rut_empresa"].ToString();
                textoCombo = drEmpresaItem["nombre"].ToString();
                combo_empresas.Items.Add(new ListItem(textoCombo, valueCombo));
            }
        }

        if (IDPerfil == "1")
        {
            foreach (DataRow drEmpresaItem in dtEmpresas.Rows)
            {
                if (EMPRESA_USER == drEmpresaItem["nombre"].ToString())
                {
                    valueCombo = drEmpresaItem["rut_empresa"].ToString();
                    textoCombo = drEmpresaItem["nombre"].ToString();
                    combo_empresas.Items.Add(new ListItem(textoCombo, valueCombo));
                }
            }
        }

    }
    protected void GrillaUsuarios_PageIndexChanged(object source, DataGridPageChangedEventArgs e)
    {

    }
    protected void GrillaCausaCambio_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    
    protected void Btn_Cancelar_Click(object sender, EventArgs e)
    {

    }
    protected void btnok_agregar_Click(object sender, EventArgs e)
    {

    }
    protected void lkb_Agregar_Click(object sender, EventArgs e)
    {
        GrillaCausaCambio.Visible = false;
        tbl_NuevaCausa.Visible = true;
        lkb_Agregar.Visible = false;
        
    }
  
}