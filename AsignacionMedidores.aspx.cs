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

public partial class AsignacionMedidores : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();
    public static int id_cont = 0, id_region = 0, id_usuario = 0;
    public string min = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            try
            {
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                PRO.recSession(rutaXml, "RUT_EMPRESA");
                

                id_cont = int.Parse(PRO.recSession(rutaXml, "ID_CONTRATISTA"));
                id_usuario = int.Parse(PRO.recSession(rutaXml, "ID_USUARIO"));

                //id_region = int.Parse(PRO.recSession(rutaXml, "ID_REGION"));
                carga_regiones();
                carga_contratistas(id_cont);
                carga_bodegas(int.Parse(ddcontratista.SelectedValue), int.Parse(ddregion.SelectedValue),id_usuario);
                carga_diametro();
                carga_estado();
                carga_guia();
                carga_instaladores(ddcontratista.SelectedValue, ddbodegas.SelectedValue);
                carga_grilla();

                if (id_cont != 0)
                {
                    ddcontratista.SelectedValue = id_cont.ToString();
                    ddcontratista.Enabled = false;
                }

            }
            catch(Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }     
        }
    }

    public void carga_guia()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_ASIGNACION_MEDIDORES.CARGA_GUIA", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "contratista", OracleType.Int32, ParameterDirection.Input,ddcontratista.SelectedValue.ToString());
        PRO.agrega_parametro_sp(objComando, "bodega", OracleType.NVarChar, ParameterDirection.Input, ddbodegas.SelectedValue.ToString());

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "GUIA");

        objConexion.Close();

        int i = 1;
        ddguia.Items.Clear();
        ddguia.Items.Add("Todos...");
        ddguia.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["GUIA"].Rows)
        {

            ddguia.Items.Add(row[1].ToString());
            ddguia.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }

    public void carga_estado()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_ASIGNACION_MEDIDORES.CARGA_ESTADO", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "ESTADO");

        objConexion.Close();

        int i = 1;
        ddestado.Items.Clear();
        ddestado.Items.Add("Todos...");
        ddestado.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["ESTADO"].Rows)
        {

            ddestado.Items.Add(row[1].ToString());
            ddestado.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }

    public void carga_diametro()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_CARGA_DD_GUIA.CARGA_DIAMETRO", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "DIAMETRO");
        objConexion.Close();

        int i = 1;
        dddiametro.Items.Clear();
        dddiametro.Items.Add("Todos...");
        dddiametro.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["DIAMETRO"].Rows)
        {

            dddiametro.Items.Add(row[1].ToString());
            dddiametro.Items[i].Value = row[1].ToString();
            i = i + 1;

        }
    }

    public void carga_grilla()
    {
        if (ddbodegas.SelectedValue.Equals(""))
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " Error('No tiene bodegas asignadas');", true);
            DataView MydataView;
            MydataView = new DataView(new DataTable());
            gridOrden.DataSource = MydataView;
            gridOrden.DataBind();
        }
        else if (ddbodegas.SelectedValue.Equals("0"))
        {
            DataView MydataView;
            MydataView = new DataView(new DataTable());
            gridOrden.DataSource = MydataView;
            gridOrden.DataBind();
        }
        else
        {
            String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
            int id_contratis = 0, id_region = 0;
            id_contratis = int.Parse(PRO.recSession(rutaXml, "ID_CONTRATISTA"));
            //id_region = int.Parse(PRO.recSession(rutaXml, "ID_REGION"));

            OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
            OracleCommand cmdAcceso = new OracleCommand("PK_ASIGNACION_MEDIDORES.CARGAR_MEDIDORES", CnOra);
            OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

            gridOrden.Columns[0].Visible = true;
            gridOrden.Columns[1].Visible = true;
            gridOrden.Columns[2].Visible = true;
            gridOrden.Columns[3].Visible = true;
            gridOrden.Columns[4].Visible = true;
            gridOrden.Columns[5].Visible = true;
            gridOrden.Columns[6].Visible = true;

            PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
            PRO.agrega_parametro_sp(da, "i_bodega", OracleType.NVarChar, ParameterDirection.Input, ddbodegas.SelectedValue.ToString());
            PRO.agrega_parametro_sp(da, "i_estado", OracleType.Int32, ParameterDirection.Input, ddestado.SelectedValue.ToString());
            //PRO.agrega_parametro_sp(da, "i_nombre", OracleType.NVarChar, ParameterDirection.Input, );
            //PRO.agrega_parametro_sp(da, "i_codigo", OracleType.Int32, ParameterDirection.Input, );
            //PRO.agrega_parametro_sp(da, "i_ano", OracleType.Int32, ParameterDirection.Input, );

            if (serie_desde.Text == "")
            {
                PRO.agrega_parametro_sp(da, "i_serie_desde", OracleType.Int32, ParameterDirection.Input, "0");
            }
            else
            {
                PRO.agrega_parametro_sp(da, "i_serie_desde", OracleType.Int32, ParameterDirection.Input, serie_desde.Text.ToString());
            }

            if (serie_hasta.Text == "")
            {
                PRO.agrega_parametro_sp(da, "i_serie_hasta", OracleType.Int32, ParameterDirection.Input, "0");
            }
            else
            {
                PRO.agrega_parametro_sp(da, "i_serie_hasta", OracleType.Int32, ParameterDirection.Input, serie_hasta.Text.ToString());
            }


            if (dddiametro.SelectedValue == "0")
            {
                PRO.agrega_parametro_sp(da, "i_diametro", OracleType.Int32, ParameterDirection.Input, "0");

            }
            else
            {
                PRO.agrega_parametro_sp(da, "i_diametro", OracleType.Int32, ParameterDirection.Input, dddiametro.SelectedItem.ToString());
            }

            if (id_region == 0 && ddregion.SelectedValue == "0")
            {
                PRO.agrega_parametro_sp(da, "i_region", OracleType.Int32, ParameterDirection.Input, id_region.ToString());
            }
            else
            {
                PRO.agrega_parametro_sp(da, "i_region", OracleType.Int32, ParameterDirection.Input, ddregion.SelectedValue.ToString());
            }

            if (id_contratis == 0)
            {

                PRO.agrega_parametro_sp(da, "i_contratista", OracleType.Int32, ParameterDirection.Input, ddcontratista.SelectedValue.ToString());
            }
            else
            {
                PRO.agrega_parametro_sp(da, "i_contratista", OracleType.Int32, ParameterDirection.Input, id_contratis.ToString());
            }

            PRO.agrega_parametro_sp(da, "i_guia", OracleType.Int32, ParameterDirection.Input, ddguia.SelectedValue.ToString());
            PRO.agrega_parametro_sp(da, "i_instalador", OracleType.Number, ParameterDirection.Input, ddInstalador.SelectedValue);

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
                //lbErrorGrilla.Text = ex.ToString() + servicio;
                //lbErrorGrilla.ForeColor = System.Drawing.Color.Red;
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " Error('Error en los parametros de entrada');", true);
                gridOrden.Columns[0].Visible = false;
                gridOrden.Columns[1].Visible = false;
                gridOrden.Columns[2].Visible = false;
                gridOrden.Columns[3].Visible = false;
                gridOrden.Columns[4].Visible = false;
                gridOrden.Columns[5].Visible = false;
                gridOrden.Columns[6].Visible = false;
                return;

            }

            DataTable dt = new DataTable();
            dt.Columns.Add(new DataColumn("ID_MEDIDOR", typeof(String)));
            dt.Columns.Add(new DataColumn("ID_GUIA", typeof(String)));
            dt.Columns.Add(new DataColumn("ID_ESTADO_MEDIDOR", typeof(String)));
            dt.Columns.Add(new DataColumn("ID_CONTRATISTA", typeof(String)));
            dt.Columns.Add(new DataColumn("ID_ORDEN", typeof(String)));
            dt.Columns.Add(new DataColumn("ID_INSPECTOR", typeof(String)));
            dt.Columns.Add(new DataColumn("ID_REGION", typeof(String)));
            dt.Columns.Add(new DataColumn("NUMERO_GUIA", typeof(String)));
            dt.Columns.Add(new DataColumn("CONTRATISTA", typeof(String)));
            dt.Columns.Add(new DataColumn("MODELO", typeof(String)));
            dt.Columns.Add(new DataColumn("CODIGO", typeof(String)));
            dt.Columns.Add(new DataColumn("SERIE", typeof(String)));
            dt.Columns.Add(new DataColumn("ANO", typeof(String)));
            dt.Columns.Add(new DataColumn("DIAMETRO", typeof(String)));
            dt.Columns.Add(new DataColumn("ESTADO", typeof(String)));
            dt.Columns.Add(new DataColumn("INSTALADOR", typeof(String)));

            DataRow dr;

            int total = 0;

            foreach (DataRow drOrdenItem in dtOrdenes.Rows)
            {

                dr = dt.NewRow();

                dr["ID_MEDIDOR"] = drOrdenItem["ID_MEDIDOR"].ToString();
                dr["ID_GUIA"] = drOrdenItem["ID_GUIA"].ToString();
                dr["ID_ESTADO_MEDIDOR"] = drOrdenItem["ID_ESTADO_MEDIDOR"].ToString();//
                dr["ID_CONTRATISTA"] = drOrdenItem["ID_CONTRATISTA"].ToString();
                dr["ID_ORDEN"] = drOrdenItem["ID_ORDEN"].ToString();
                dr["ID_REGION"] = drOrdenItem["ID_REGION"].ToString();
                dr["NUMERO_GUIA"] = drOrdenItem["NUMERO_GUIA"].ToString();
                dr["CONTRATISTA"] = drOrdenItem["CONTRATISTA"].ToString();
                dr["MODELO"] = drOrdenItem["MODELO"].ToString();
                dr["CODIGO"] = drOrdenItem["CODIGO"].ToString();
                dr["SERIE"] = drOrdenItem["SERIE"].ToString();
                dr["ANO"] = drOrdenItem["ANO"].ToString();
                dr["INSTALADOR"] = drOrdenItem["COD_INSTALADOR"].ToString() + " - " + drOrdenItem["NOMBRE"].ToString() + " " + drOrdenItem["APELLIDO"].ToString();
                dr["DIAMETRO"] = drOrdenItem["DIAMETRO"].ToString();
                dr["ESTADO"] = drOrdenItem["ESTADO"].ToString();

                dt.Rows.Add(dr);

                total = total + 1;

            }

            DataView MydataView;
            MydataView = new DataView(dt);
            gridOrden.DataSource = MydataView;
            gridOrden.DataBind();

            lbTotal.Text = total + " registro(s) encontrado(s)";

            int i;
            GridViewRow gvRow;
            CheckBox chk_as;
            CheckBox chk_des;

            for (i = 0; i < gridOrden.Rows.Count; i++)
            {

                gvRow = gridOrden.Rows[i];
                chk_as = ((CheckBox)gvRow.FindControl("check_asigna"));
                chk_des = ((CheckBox)gvRow.FindControl("chk_des"));

                switch (gridOrden.Rows[i].Cells[2].Text)
                {

                    case "3": //POR ASIGNAR

                        chk_as.Enabled = true;
                        chk_des.Enabled = false;
                        break;

                    case "4": //ASIGNADO

                        chk_as.Enabled = false;
                        chk_des.Enabled = true;
                        break;

                    default: //NO DISPONIBLE, DESCARGADO, CARGADO, EXTRAVIADO, ETC.    
                        chk_as.Enabled = false;
                        chk_des.Enabled = false;
                        break;

                }

            }


            gridOrden.Columns[0].Visible = false;
            gridOrden.Columns[1].Visible = false;
            gridOrden.Columns[2].Visible = false;
            gridOrden.Columns[3].Visible = false;
            gridOrden.Columns[4].Visible = false;
            gridOrden.Columns[5].Visible = false;
            gridOrden.Columns[6].Visible = false;

            //MUEUSTRA EL ESTADO DEL STOCK MINIMO
            String mi_estado = verifica_stock_minimo(ddbodegas.SelectedValue,dddiametro.SelectedValue);
            txt_stock_minimo.Text = "STOCK EN ESTADO " + mi_estado + " (" + min + ")";
            switch (mi_estado)
            {
                case "NORMAL":
                    txt_stock_minimo.Visible = true;
                    txt_stock_minimo.BackColor = System.Drawing.Color.DarkGreen;
                    break;
                case "ADVERTENCIA":
                    txt_stock_minimo.Visible = true;
                    txt_stock_minimo.BackColor = System.Drawing.Color.Orange;
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " advertencia('STOCK EN ESTADO ADVERTENCIA');", true);
                    break;
                case "CRITICO":
                    txt_stock_minimo.Visible = true;
                    txt_stock_minimo.BackColor = System.Drawing.Color.IndianRed;

                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " advertencia('STOCK EN ESTADO CRITICO');", true);
            
                    break;
                case "SIN DEFINIR":
                    txt_stock_minimo.Visible = true;
                    txt_stock_minimo.BackColor = System.Drawing.Color.White;
                    txt_stock_minimo.Visible = false;
                    break;
                default:
                    txt_stock_minimo.Visible = false;
                    break;
            }
        }
        
     
    }

    public String verifica_stock_minimo(String bodega, String diametro)
    {

        String estado = "";
        try
        {
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();

            objConexion.Open();
            objComando = new OracleDataAdapter("PK_ASIGNACION_MEDIDORES.VERIFICA_STOCK_MINIMO", objConexion);
            objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

            PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
            PRO.agrega_parametro_sp(objComando, "i_id_bodega", OracleType.Int32, ParameterDirection.Input, bodega);
            PRO.agrega_parametro_sp(objComando, "i_diametro", OracleType.Int32, ParameterDirection.Input, diametro);

            objComando.SelectCommand.ExecuteNonQuery();
            objComando.Fill(objDS, "VALIDA");
            objConexion.Close();

            estado = "SIN DEFINIR";
            foreach (DataRow row in objDS.Tables["VALIDA"].Rows)
            {
                double stock_disp = 0;
                double stock_min = 0;                

                try { stock_disp = double.Parse(row[0].ToString()); }
                catch (Exception ex) { }

                try { 
                    stock_min = double.Parse(row[1].ToString());
                    min = row[1].ToString();
                }
                catch (Exception ex) {
                    min = "N/A";
                }

                //ESTADO SEGÚN UMBRALES DE SLA PARA EL STOCK MINIMO RESPECTO AL DISPONIBLE.
                if (stock_disp >= stock_min * 1.5)
                { //150% O MÁS -> STOCK EN ESTADO NORMAL.
                    estado = "NORMAL";
                }
                else if (stock_disp >= stock_min && stock_disp < stock_min * 1.5) //100% - 149% -> STOCK EN ESTADO ADVERTENCIA.
                {
                    estado = "ADVERTENCIA";
                }
                else //STOCK EN ESTADO CRÍTICO.
                {
                    estado = "CRITICO";
                }
                
            }

            return estado;
        }
        catch (Exception ex)
        {
            return estado;
        }

    }


    public Boolean valida_instalador(String cod_instalador,String bodega)
    {
        try
        {
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();

            objConexion.Open();
            objComando = new OracleDataAdapter("PK_ASIGNACION_MEDIDORES.VALIDA_BODEGA_INSTALADOR", objConexion);
            objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

            PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
            PRO.agrega_parametro_sp(objComando, "i_cod_instalador", OracleType.Int32, ParameterDirection.Input, cod_instalador);
            PRO.agrega_parametro_sp(objComando, "i_id_bodega", OracleType.Int32, ParameterDirection.Input, bodega);

            objComando.SelectCommand.ExecuteNonQuery();
            objComando.Fill(objDS, "VALIDA");
            objConexion.Close();


            foreach (DataRow row in objDS.Tables["VALIDA"].Rows)
            {
                if (row[0].ToString().Equals(cod_instalador)) return true;
            }

            return false;
        }
        catch (Exception ex)
        {
            return false;
        }
     
    }
   
    public Boolean valida_check(String check_item)
    {
        int c;
        Boolean check=false;
        //DataGridItem item_grilla;
        GridViewRow gvRow;
        CheckBox check_row = new CheckBox();
        for (c = 0; c < gridOrden.Rows.Count; c++)
        {
            String bandera = gridOrden.Rows[c].Cells[16].Text;
            bandera = gridOrden.Rows[c].Cells[15].Text;
            //item_grilla = gridOrden.Items[c];
            gvRow = gridOrden.Rows[c];
            check_row = (CheckBox)(gvRow.FindControl(check_item));
            if (check_item.Equals("check_asigna"))
            {
                if ((check_row.Checked == true) && (gridOrden.Rows[c].Cells[2].Text == "3"))
                {
                    check = true;
                }
            }
            else
            {
                if ((check_row.Checked == true) && (gridOrden.Rows[c].Cells[2].Text == "4"))
                {
                    check = true;
                }
            }
        }
        return check;
    }

    /* -------------------BOTON PARA ASIGNAR ORDEN ----------- */
    protected void btnAsignar_Click(object sender, EventArgs e)
    {
        gridOrden.Columns[2].Visible = true;
        gridOrden.Columns[0].Visible = true;

        if( txtInstalador.Text == "" ){
            //lb_valida.Visible = true;
            //lbTxtIn.ForeColor = System.Drawing.Color.Red;
            //lbTxtIn.Text = "Ingrese código de Instalador";
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " Selecione_instalador('');", true);
            txtInstalador.Focus();

        }
        //SI INSTALADOR NO PERTENECE A BODEGA Y HAY CHECKS ASIGNADOS?
        else if (!valida_instalador(txtInstalador.Text, ddbodegas.SelectedValue) && valida_check("check_asigna")) 
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " Error('Operador no está asignado a bodega seleccionada');", true);
            txtInstalador.Focus();
        }
        else if (!valida_instalador_habilitado(txtInstalador.Text) && valida_check("check_asigna"))
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " Error('Operador no está habilitado para asignar');", true);
            txtInstalador.Focus();
        }
        else
        {

            String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";

            lbTxtIn.Text = "";
            String codLector;
            codLector = PRO.existeInstalador(txtInstalador.Text, PRO.recSession(rutaXml, "RUT_EMPRESA"));

            if (codLector == "OK")
            {


                //VALIDACION_CODIGO_LECTOR.Visible = false;
                lbTxtIn.Text = "";

                if (valida_check("check_asigna") == true)
                {

                    int i;
                    GridViewRow gvRow;

                    CheckBox check_permiso = new CheckBox();

                    OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
                    OracleDataAdapter ComandoDA;
                    int cont = 0;

                    for (i = 0; i < gridOrden.Rows.Count; i++)
                    {

                        gvRow = gridOrden.Rows[i];

                        check_permiso = (CheckBox)(gvRow.FindControl("check_asigna"));

                        if ((check_permiso.Checked == true) && (gridOrden.Rows[i].Cells[2].Text == "3"))
                        {

                            objConexion.Open();
                            ComandoDA = new OracleDataAdapter("PK_ASIGNACION_MEDIDORES.ASIGNAR_MEDIDOR", objConexion);
                            ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;


                            PRO.agrega_parametro_sp(ComandoDA, "i_medidor", OracleType.Int32, ParameterDirection.Input, gridOrden.Rows[i].Cells[0].Text);
                            PRO.agrega_parametro_sp(ComandoDA, "i_inspector", OracleType.Int32, ParameterDirection.Input, txtInstalador.Text);

                            try
                            {
                                ComandoDA.SelectCommand.ExecuteNonQuery();
                                objConexion.Close();
                                cont = cont + 1;
                                txtInstalador.Focus();
                                gridOrden.Columns[10].Visible = false;
                                gridOrden.Columns[0].Visible = false;
                            }
                            catch (Exception ex)
                            {

                                lbResultado.Text = "Error al asignar el medidor " + gridOrden.Rows[i].Cells[0].Text + ". Descripción: " + ex.Message.ToString();

                                txtInstalador.Focus();

                                break;
                            }


                        }
                    }
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " cambio_ordenes('" + cont + "');", true);
                    objConexion.Dispose();
                    carga_grilla();

                }
                else
                {

                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " Seleccione('');", true);


                    txtInstalador.Focus();

                }

            }
            else
            {


                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " instalador_no_valido('');", true);
                //lbTxtIn.ForeColor = System.Drawing.Color.Red;
                //lbTxtIn.Text = codLector;

                txtInstalador.Focus();
            }

        }

        gridOrden.Columns[2].Visible = false;
        gridOrden.Columns[0].Visible = false;
    }


    /*-------------------------BOTON DESASIGNAR-------------------------- */
    protected void btnDesAsignar_Click(object sender, EventArgs e)
    {
                    int i;
                    GridViewRow gvRow;
                    CheckBox chk_des = new CheckBox();

                    OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
                    OracleDataAdapter ComandoDA;
                    int cont = 0;
                    
                    for (i = 0; i < gridOrden.Rows.Count; i++)
                    {
                        if (valida_check("chk_des"))
                        {
                            gvRow = gridOrden.Rows[i];
                            chk_des = (CheckBox)(gvRow.FindControl("chk_des"));

                            if ((chk_des.Checked == true) && (gridOrden.Rows[i].Cells[2].Text == "4"))
                            {
                                objConexion.Open();
                                ComandoDA = new OracleDataAdapter("PK_ASIGNACION_MEDIDORES.DESASIGNAR_MEDIDOR", objConexion);
                                ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;
                                PRO.agrega_parametro_sp(ComandoDA, "i_medidor", OracleType.Int32, ParameterDirection.Input, gridOrden.Rows[i].Cells[0].Text);

                                try
                                {
                                    ComandoDA.SelectCommand.ExecuteNonQuery();
                                    objConexion.Close();
                                    cont = cont + 1;
                                    txtInstalador.Focus();

                                }
                                catch (Exception ex)
                                {
                                    //lbResultado.Text = "Error al Desasignar la orden " + gridOrden.Rows[i].Cells[0].Text + ". Descripción: " + ex.ToString();


                                    txtInstalador.Focus();

                                    break;
                                }
                            }
                            else
                            {
                                //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " Seleccione('');", true);
                            }
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " Seleccione('');", true);
                        }
                    }
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " cambio_ordenes_desasigna('" + cont + "');", true);
                    objConexion.Dispose();
                    carga_grilla();
                    gridOrden.Columns[2].Visible = false;
                    gridOrden.Columns[0].Visible = false;
    }
    
    protected void gridOrden_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if(e.CommandName=="asignar")
        {
            checkTodos("check_asigna");
        }

        if (e.CommandName == "desasignar")
        {
            checkTodos("chk_des");
        }
    }

    protected void gridOrden_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridOrden.PageIndex = e.NewPageIndex;
        carga_grilla();

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        txtInstalador.Text = gridOrden.Rows[0].Cells[0].Text;
    }

    public void checkTodos(String check)
    {
        int c;
        
        GridViewRow gvRow;
        CheckBox check_row = new CheckBox();
        for (c = 0; c < gridOrden.Rows.Count; c++)
        {
           
            gvRow = gridOrden.Rows[c];
            check_row = (CheckBox)(gvRow.FindControl(check));

                    if ((check_row.Enabled == true ))
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

    protected void lkbAsignar_Click(object sender, EventArgs e)
    {

    }

    protected void gridOrden_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    public void carga_bodegas(int contratista, int region,int usuario)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_ASIGNACION_MEDIDORES.CARGA_BODEGAS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "contratista", OracleType.Int32, ParameterDirection.Input, contratista.ToString());
        PRO.agrega_parametro_sp(objComando, "region", OracleType.Int32, ParameterDirection.Input, region.ToString());
        PRO.agrega_parametro_sp(objComando, "usuario", OracleType.Int32, ParameterDirection.Input, usuario.ToString());

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "BODEGAS");
        objConexion.Close();

        int i = 0;
        ddbodegas.Items.Clear();

        if (objDS.Tables["BODEGAS"].Rows.Count == 0)
        {
            i = 1;
            ddbodegas.Items.Clear();
            ddbodegas.Items.Add("SIN BODEGAS ASIGNADAS");
            ddbodegas.Items[0].Value = ""; 
        }
        else if(contratista == 0)
        {
            i = 1;
            ddbodegas.Items.Clear();
            ddbodegas.Items.Add("SELECCIONE BODEGA");
            ddbodegas.Items[0].Value = "0";
        }


        foreach (DataRow row in objDS.Tables["BODEGAS"].Rows)
        {

            ddbodegas.Items.Add(row[1].ToString());
            ddbodegas.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }

    public void carga_contratistas(int contratista)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_ASIGNACION_MEDIDORES.CARGA_CONTRATISTAS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "contratista", OracleType.Int32, ParameterDirection.Input, contratista.ToString());

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "CONTRATISTAS");
        objConexion.Close();

        int i = 1;

        if (contratista == 0)
        {
            ddcontratista.Items.Clear();
            ddcontratista.Items.Add("Todos...");
            ddcontratista.Items[0].Value = "0";
        }
        else
        {
            i = 0;
        }
        

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

        int i = 1;
        ddregion.Items.Clear();
        ddregion.Items.Add("Todos...");
        ddregion.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["REGIONES"].Rows)
        {

            ddregion.Items.Add(row[1].ToString());
            ddregion.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }


    public void ddcontratista_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_bodegas(int.Parse(ddcontratista.SelectedValue), int.Parse(ddregion.SelectedValue), id_usuario);
        carga_guia();
        carga_instaladores(ddcontratista.SelectedValue, ddbodegas.SelectedValue);
        carga_grilla();
    }
    protected void ddregion_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_bodegas(int.Parse(ddcontratista.SelectedValue), int.Parse(ddregion.SelectedValue), id_usuario);
        carga_grilla();
    }
    protected void ddguia_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla();
    }
    protected void ddestado_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla();
    }
    protected void dddiametro_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla();
    }
    protected void ddbodegas_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_guia();
        carga_instaladores(ddcontratista.SelectedValue, ddbodegas.SelectedValue);
        carga_grilla();
    }
    protected void serie_desde_TextChanged(object sender, EventArgs e)
    {
        carga_grilla();
    }
    protected void serie_hasta_TextChanged(object sender, EventArgs e)
    {
        carga_grilla();
    }

    public Boolean valida_instalador_habilitado(String cod_instalador)
    {
        try
        {
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();

            objConexion.Open();
            objComando = new OracleDataAdapter("PK_ORDEN.VALIDA_INSTALADOR_HABILITADO", objConexion);
            objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

            PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
            PRO.agrega_parametro_sp(objComando, "i_cod_instalador", OracleType.Int32, ParameterDirection.Input, cod_instalador);

            objComando.SelectCommand.ExecuteNonQuery();
            objComando.Fill(objDS, "VALIDA");
            objConexion.Close();


            foreach (DataRow row in objDS.Tables["VALIDA"].Rows)
            {
                if (row[0].ToString().Equals(cod_instalador)) return true;
            }

            return false;
        }
        catch (Exception ex)
        {
            return false;
        }

    }
    protected void ddInstalador_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla();
    }

    public void carga_instaladores(String contratista, String bodega)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_ASIGNA_ACCESORIOS.CARGA_INSTALADORES", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "contratista", OracleType.Int32, ParameterDirection.Input, contratista);
        PRO.agrega_parametro_sp(objComando, "bodega", OracleType.Int32, ParameterDirection.Input, bodega);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "INSTALADOR");

        objConexion.Close();

        int i = 0;

        i = 1;
        ddInstalador.Items.Clear();
        ddInstalador.Items.Add("Todos...");
        ddInstalador.Items[0].Value = "0";

        if (ddbodegas.SelectedValue != "0")
        {
            foreach (DataRow row in objDS.Tables["INSTALADOR"].Rows)
            {

                ddInstalador.Items.Add(row[1].ToString());
                ddInstalador.Items[i].Value = row[0].ToString();
                i = i + 1;

            }
        }
    }
}