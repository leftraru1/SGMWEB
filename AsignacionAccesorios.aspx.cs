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

public partial class AsignacionAccesorios : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();
    public static int id_cont = 0, id_usuario = 0;

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

                //CARGAMOS FILTROS
                carga_bodegas(id_cont.ToString(), id_usuario.ToString());
                carga_tipo_accesorios();
                carga_diametros();
                               
                carga_accesorios();
                carga_accesoriosxoperador();

                carga_instaladores(id_cont.ToString(),ddBodegas.SelectedValue);
                
            }
            catch(Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }     
        }
    }

    public void carga_bodegas(String contratista,String usuario)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_ASIGNA_ACCESORIOS.CARGA_BODEGAS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "contratista", OracleType.Int32, ParameterDirection.Input, contratista);
        PRO.agrega_parametro_sp(objComando, "usuario", OracleType.Int32, ParameterDirection.Input, usuario);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "BODEGAS");

        objConexion.Close();

        int i = 0;
        if (objDS.Tables["BODEGAS"].Rows.Count == 0)
        {
            i = 1;
            ddBodegas.Items.Clear();
            ddBodegas.Items.Add("SIN BODEGAS ASIGNADAS");
            ddBodegas.Items[0].Value = "";
        }
        else if (contratista.Equals("0"))
        {
            i = 1;
            ddBodegas.Items.Clear();
            ddBodegas.Items.Add("SELECCIONE BODEGA");
            ddBodegas.Items[0].Value = "0";
        }


        foreach (DataRow row in objDS.Tables["BODEGAS"].Rows)
        {

            ddBodegas.Items.Add(row[1].ToString());
            ddBodegas.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }

    public void carga_diametros()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_ASIGNA_ACCESORIOS.CARGAR_DIAMETROS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "DIAMETROS");

        objConexion.Close();

        int i = 1;
        ddDiametros.Items.Clear();
        ddDiametros.Items.Add("Todos...");
        ddDiametros.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["DIAMETROS"].Rows)
        {

            ddDiametros.Items.Add(row[1].ToString());
            ddDiametros.Items[i].Value = row[1].ToString();
            i = i + 1;

        }
    }

    public void carga_tipo_accesorios()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_ASIGNA_ACCESORIOS.CARGAR_TIPO_ACCESORIOS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "TIPO_ACCESORIOS");

        objConexion.Close();

        int i = 1;
        ddAccesorios.Items.Clear();
        ddAccesorios.Items.Add("Todos...");
        ddAccesorios.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["TIPO_ACCESORIOS"].Rows)
        {

            ddAccesorios.Items.Add(row[1].ToString());
            ddAccesorios.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }

    public void carga_accesorios()
    {
        if (ddBodegas.SelectedValue.Equals(""))
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error_plantilla('No tiene bodegas asignadas');", true);
            DataView MydataView;
            MydataView = new DataView(new DataTable());
            Accesorios.DataSource = MydataView;
            Accesorios.DataBind();
        }
        else if (ddBodegas.SelectedValue.Equals("0"))
        {
            DataView MydataView;
            MydataView = new DataView(new DataTable());
            Accesorios.DataSource = MydataView;
            Accesorios.DataBind();
        }
        else
        {
            Accesorios.Columns[0].Visible = true;
            Accesorios.Columns[1].Visible = true;
            Accesorios.Columns[6].Visible = true;
            String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";

            int id_contratis = 0, id_region = 0;

            id_contratis = int.Parse(PRO.recSession(rutaXml, "ID_CONTRATISTA"));
            //id_region = int.Parse(PRO.recSession(rutaXml, "ID_REGION"));

            OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
            OracleCommand cmdAcceso = new OracleCommand("PK_ASIGNA_ACCESORIOS.CARGA_ACCESORIOS", CnOra);
            OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

            PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
            PRO.agrega_parametro_sp(da, "i_bodega", OracleType.Int32, ParameterDirection.Input, ddBodegas.SelectedValue);
            PRO.agrega_parametro_sp(da, "i_diametro", OracleType.Int32, ParameterDirection.Input, ddDiametros.SelectedValue);
            PRO.agrega_parametro_sp(da, "i_tipo", OracleType.Int32, ParameterDirection.Input, ddAccesorios.SelectedValue);
            PRO.agrega_parametro_sp(da, "i_stock", OracleType.Int32, ParameterDirection.Input, ddStock.SelectedValue);
            //PRO.agrega_parametro_sp(da, "i_region", OracleType.Int32, ParameterDirection.Input, id_region.ToString());
            //PRO.agrega_parametro_sp(da, "i_contratista", OracleType.Int32, ParameterDirection.Input, id_contratis.ToString());

            da.SelectCommand.CommandType = CommandType.StoredProcedure;

            DataTable dtAccesorios = new DataTable();

            try
            {
                CnOra.Open();
                da.Fill(dtAccesorios);
                CnOra.Close();
                CnOra.Dispose();

            }
            catch (Exception ex)
            {

            }

            DataTable dt = new DataTable();
            dt.Columns.Add(new DataColumn("ID_ACCESORIO", typeof(String)));
            dt.Columns.Add(new DataColumn("CODIGO_PROVEEDOR", typeof(String)));
            dt.Columns.Add(new DataColumn("STOCK_TOTAL", typeof(String)));
            dt.Columns.Add(new DataColumn("STOCK", typeof(String)));
            dt.Columns.Add(new DataColumn("ID_BODEGA", typeof(String)));
            dt.Columns.Add(new DataColumn("BODEGA", typeof(String)));
            dt.Columns.Add(new DataColumn("STOCK_MINIMO", typeof(String)));

            DataRow dr;

            int total = 0;

            foreach (DataRow drAccesorioItem in dtAccesorios.Rows)
            {

                dr = dt.NewRow();

                dr["ID_ACCESORIO"] = drAccesorioItem["ID_ACCESORIO"].ToString();
                dr["CODIGO_PROVEEDOR"] = drAccesorioItem["CODIGO_PROVEEDOR"].ToString() + " - " + drAccesorioItem["CATEGORIA"].ToString() + " D" + drAccesorioItem["DIAMETRO"].ToString();
                dr["STOCK_TOTAL"] = drAccesorioItem["STOCK_TOTAL"].ToString();//
                dr["STOCK"] = drAccesorioItem["STOCK"].ToString();
                dr["ID_BODEGA"] = drAccesorioItem["ID_BODEGA"].ToString();
                dr["BODEGA"] = drAccesorioItem["BODEGA"].ToString();
                dr["STOCK_MINIMO"] = drAccesorioItem["STOCK_MINIMO"].ToString();
                dt.Rows.Add(dr);

                total = total + 1;

            }

            DataView MydataView;
            MydataView = new DataView(dt);
            Accesorios.DataSource = MydataView;
            Accesorios.DataBind();

            lbTotal.Text = total + " registro(s) encontrado(s)";
            Accesorios.Columns[0].Visible = false;
            Accesorios.Columns[1].Visible = false;
            Accesorios.Columns[6].Visible = false;

            GridViewRow gvRow;

            for (int i = 0; i < Accesorios.Rows.Count; i++)
            {

                gvRow = Accesorios.Rows[i];
                double stock_disp = 0;
                double stock_min = 0;

                try { stock_disp = double.Parse(gvRow.Cells[5].Text); }
                catch (Exception ex) { }

                String tooltiptext;
                try
                {
                    stock_min = double.Parse(gvRow.Cells[6].Text);
                    tooltiptext = int.Parse(gvRow.Cells[6].Text).ToString();
                }
                catch (Exception ex)
                {
                    tooltiptext = "N/A";
                }                 

                gvRow.Cells[5].Attributes.Add("title", "STOCK MIN: " + tooltiptext);

                //ESTADO SEGÚN UMBRALES DE SLA PARA EL STOCK MINIMO RESPECTO AL DISPONIBLE.
                if (stock_disp >= stock_min * 1.5)
                { //150% O MÁS -> STOCK EN ESTADO NORMAL.
                    
                }
                else if (stock_disp >= stock_min && stock_disp < stock_min * 1.5) //100% - 149% -> STOCK EN ESTADO ADVERTENCIA.
                {
                    gvRow.Cells[5].ForeColor = System.Drawing.Color.White;
                    gvRow.Cells[5].BackColor = System.Drawing.Color.Orange;
                }
                else //STOCK EN ESTADO CRÍTICO.
                {
                    gvRow.Cells[5].ForeColor = System.Drawing.Color.White;
                    gvRow.Cells[5].BackColor = System.Drawing.Color.IndianRed;
                }

                   

            }
        }

    }
   
    public String valida_check()
    {
        int c;
        String check="NOK";
        String mayor = "";
        //DataGridItem item_grilla;
        TextBox x = new TextBox();
        String cantidad_ingreso;

        for (c = 0; c < Accesorios.Rows.Count; c++)
        {
            
            x = (TextBox)(Accesorios.Rows[c].Cells[7].Controls[1]);
            cantidad_ingreso = x.Text;

            if (cantidad_ingreso != "" && verifica_numero(cantidad_ingreso) == true)
            {
                if (int.Parse(cantidad_ingreso) > 0 && int.Parse(cantidad_ingreso) <= int.Parse(Accesorios.Rows[c].Cells[5].Text))
                {
                    check = "OK";
                    x.ForeColor = System.Drawing.Color.Black;
                    x.BorderColor = System.Drawing.ColorTranslator.FromHtml("#94B1E5");
                    
                }
                else
                {                    
                    x.ForeColor = System.Drawing.Color.Red;
                    x.BorderColor = System.Drawing.Color.Red;

                    if (int.Parse(cantidad_ingreso) > int.Parse(Accesorios.Rows[c].Cells[5].Text)) mayor = "MAYOR";
                }
            }
            else {
                x.ForeColor = System.Drawing.Color.Black;
                //x.BorderColor = System.Drawing.Color.Black;
                //x.ForeColor = System.Drawing.ColorTranslator.FromHtml("#94B1E5");
                x.BorderColor = System.Drawing.ColorTranslator.FromHtml("#94B1E5");
            }
        }

        if(mayor.Equals("MAYOR")) return mayor;
        else return check;
    }

    public Boolean valida_check_desasigna()
    {
        int c;
        Boolean check = false;
        //DataGridItem item_grilla;
        GridViewRow gvRow;
        CheckBox check_row = new CheckBox();
        for (c = 0; c < accesoriosxoperador.Rows.Count; c++)
        {
           
            //item_grilla = gridOrden.Items[c];
            gvRow = accesoriosxoperador.Rows[c];
            check_row = (CheckBox)(gvRow.FindControl("check_desasignar"));

            if ((check_row.Checked == true) && (accesoriosxoperador.Rows[c].Cells[6].Text == "4"))
            {
                check = true;
            }   
            
        }
        return check;
    }

    public Boolean verifica_numero(String texto) {

        try {

            int.Parse(texto);
        }
        catch (Exception e) {

            return false;

        }

        return true;
    }

    public Boolean valida_instalador(String cod_instalador, String bodega)
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

    /* -------------------BOTON PARA ASIGNAR ORDEN ----------- */
    protected void btnAsignar_Click(object sender, EventArgs e)
    {

        String valida = valida_check();

        if( txtInstalador.Text == "" ){
            //lb_valida.Visible = true;
            //lbTxtIn.ForeColor = System.Drawing.Color.Red;
            //lbTxtIn.Text = "Ingrese código de Instalador";
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " Selecione_instalador('');", true);
            txtInstalador.Focus();
        }
        //SI INSTALADOR NO PERTENECE A BODEGA Y HAY CHECKS ASIGNADOS?
        else if (!valida_instalador(txtInstalador.Text, ddBodegas.SelectedValue) && valida.Equals("OK"))
        {
            if (!valida.Equals("OK"))
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error_plantilla('No se ha ingresado cantidad > 0 de un accesorio');", true);
            }
            else
            {
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                String codLector = PRO.existeInstalador(txtInstalador.Text, PRO.recSession(rutaXml, "RUT_EMPRESA"));

                if (codLector == "OK") ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error_plantilla('Operador no está asignado a bodega seleccionada');", true);
                else ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " instalador_no_valido('');", true);

                txtInstalador.Focus();
            }
        }
        else if (!valida_instalador_habilitado(txtInstalador.Text) && valida.Equals("OK"))
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error_plantilla('Operador no está habilitado para asignar');", true);
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

                lbTxtIn.Text = "";

                if (valida.Equals("OK"))
                {

                    int i;

                    OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
                    OracleDataAdapter ComandoDA;
                    String cantidad;
                    TextBox x = new TextBox();
                    int ok = 0, nok = 0;

                    int id_usuario = int.Parse(PRO.recSession(rutaXml, "ID_USUARIO"));

                    for (i = 0; i < Accesorios.Rows.Count; i++)
                    {

                        x = (TextBox)(Accesorios.Rows[i].Cells[7].Controls[1]);
                        cantidad = x.Text;

                        //CONSULTAR SI TIENE LA CANTIDAD INGRESADA DISPONIBLE
                        if (cantidad != "")
                        {

                            if (int.Parse(Accesorios.Rows[i].Cells[5].Text) >= int.Parse(cantidad) && int.Parse(cantidad) > 0)
                            {

                                objConexion.Open();
                                ComandoDA = new OracleDataAdapter("PK_ASIGNA_ACCESORIOS.INSERTA_ASIGNACION", objConexion);
                                ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

                                String id_accesorio = Accesorios.Rows[i].Cells[3].Text.Split('-')[0].Trim();
                                //PRO.agrega_parametro_sp(ComandoDA, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
                                PRO.agrega_parametro_sp(ComandoDA, "i_accesorio", OracleType.Int32, ParameterDirection.Input, id_accesorio);
                                PRO.agrega_parametro_sp(ComandoDA, "i_inspector", OracleType.Int32, ParameterDirection.Input, txtInstalador.Text);
                                PRO.agrega_parametro_sp(ComandoDA, "cantidad", OracleType.Int32, ParameterDirection.Input, cantidad);
                                PRO.agrega_parametro_sp(ComandoDA, "i_usuario", OracleType.Int32, ParameterDirection.Input, id_usuario.ToString());
                                PRO.agrega_parametro_sp(ComandoDA, "i_bodega", OracleType.Int32, ParameterDirection.Input, Accesorios.Rows[i].Cells[1].Text);

                                try
                                {
                                    DataSet objDS = new DataSet();
                                    ComandoDA.SelectCommand.ExecuteNonQuery();
                                    
                                    objConexion.Close();

                                    ok++;                        
                                    
                                }
                                catch (Exception ex)
                                {
                                    nok++;
                                    txtInstalador.Focus();
                                    break;
                                }

                            }
                            else
                            {
                                nok++;
                                //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error('Un item no tiene stock suficiente');", true);
                                //Accesorios.Rows[i].Cells[6].BackColor = System.Drawing.Color.Red;
                            }
                        }
                    }

                    objConexion.Dispose();
                    carga_accesorios();
                    carga_accesoriosxoperador();

                    if (ok > 0) ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " cambio_ordenes('" + ok + "','" + (ok + nok) + "');", true);
                    else ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " cambio_ordenes_error('" + ok + "','" + (ok + nok) + "');", true);

                }
                else
                {

                    if (valida.Equals("MAYOR")) ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error_plantilla('Cantidad de accesorio mayor al stock disponible');", true);
                    else ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error_plantilla('No se ha ingresado cantidad > 0 de un accesorio');", true);

                    txtInstalador.Focus();

                }

            }
            else
            {


                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " instalador_no_valido('');", true);
                txtInstalador.Focus();
            }

        }

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

        if (valida_check_desasigna())
        {
            for (i = 0; i < accesoriosxoperador.Rows.Count; i++)
            {
                gvRow = accesoriosxoperador.Rows[i];
                chk_des = (CheckBox)(gvRow.FindControl("check_desasignar"));

                if ((chk_des.Checked == true) && (accesoriosxoperador.Rows[i].Cells[6].Text == "4"))
                {
                    objConexion.Open();
                    ComandoDA = new OracleDataAdapter("PK_ASIGNA_ACCESORIOS.DESASIGNACION", objConexion);
                    ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;
                    String cod_accesorio = accesoriosxoperador.Rows[i].Cells[1].Text.Split('-')[0].Trim();
                    PRO.agrega_parametro_sp(ComandoDA, "i_id", OracleType.Int32, ParameterDirection.Input, accesoriosxoperador.Rows[i].Cells[0].Text);
                    PRO.agrega_parametro_sp(ComandoDA, "cod_accesorio", OracleType.Int32, ParameterDirection.Input, cod_accesorio);
                    PRO.agrega_parametro_sp(ComandoDA, "i_bodega", OracleType.Int32, ParameterDirection.Input, accesoriosxoperador.Rows[i].Cells[2].Text);
                    PRO.agrega_parametro_sp(ComandoDA, "cantidad", OracleType.Int32, ParameterDirection.Input, accesoriosxoperador.Rows[i].Cells[5].Text);

                    try
                    {
                        ComandoDA.SelectCommand.ExecuteNonQuery();
                        objConexion.Close();
                        cont = cont + 1;
                        txtInstalador.Focus();

                    }
                    catch (Exception ex)
                    {
                        //lbResultado.Text = "Error al Desasignar la orden " + Accesorios.Rows[i].Cells[0].Text + ". Descripción: " + ex.ToString();


                        txtInstalador.Focus();

                        break;
                    }


                }

            }

            objConexion.Dispose();
            carga_accesorios();
            carga_accesoriosxoperador();

            if (cont > 0) ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " cambio_ordenes_desasigna('" + cont + "');", true);
            else ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error_plantilla('No se pudo desasignar nada, refresque la página');", true);

        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " Seleccione('');", true);
        }

                            
    }
    
    //protected void Accesorios_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    if(e.CommandName=="asignar")
    //    {
    //        checkTodos("check_asigna");
    //    }

    //}

    protected void Accesorios_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        Accesorios.PageIndex = e.NewPageIndex;
        carga_accesorios();

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        txtInstalador.Text = Accesorios.Rows[0].Cells[0].Text;
    }

    public void checkTodos(String check)
    {
        int c;
        
        GridViewRow gvRow;
        CheckBox check_row = new CheckBox();
        for (c = 0; c < accesoriosxoperador.Rows.Count; c++)
        {
           
            gvRow = accesoriosxoperador.Rows[c];
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

    protected void Accesorios_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    protected void accesoriosxoperador_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        accesoriosxoperador.PageIndex = e.NewPageIndex;
        carga_accesoriosxoperador();
    }
    protected void accesoriosxoperador_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
    protected void accesoriosxoperador_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "desasignar")
        {
            checkTodos("check_desasignar");
        }
    }

    public void carga_accesoriosxoperador()
    {
        if (ddBodegas.SelectedValue.Equals(""))
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error_plantilla('No tiene bodegas asignadas');", true);
            DataView MydataView;
            MydataView = new DataView(new DataTable());
            Accesorios.DataSource = MydataView;
            Accesorios.DataBind();
        }
        else if (ddBodegas.SelectedValue.Equals("0"))
        {
            DataView MydataView;
            MydataView = new DataView(new DataTable());
            accesoriosxoperador.DataSource = MydataView;
            accesoriosxoperador.DataBind();
        }
        else
        {
            accesoriosxoperador.Columns[0].Visible = true;
            accesoriosxoperador.Columns[6].Visible = true;
            accesoriosxoperador.Columns[2].Visible = true;

            OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
            OracleCommand cmdAcceso = new OracleCommand("PK_ASIGNA_ACCESORIOS.CARGA_ACCESORIOSXOPERADOR", CnOra);
            OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

            PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
            PRO.agrega_parametro_sp(da, "i_bodega", OracleType.Int32, ParameterDirection.Input, ddBodegas.SelectedValue);
            PRO.agrega_parametro_sp(da, "i_diametro", OracleType.Int32, ParameterDirection.Input, ddDiametros.SelectedValue);
            PRO.agrega_parametro_sp(da, "i_tipo", OracleType.Int32, ParameterDirection.Input, ddAccesorios.SelectedValue);
            PRO.agrega_parametro_sp(da, "i_instalador", OracleType.Int32, ParameterDirection.Input, ddInstalador.SelectedValue);
            //PRO.agrega_parametro_sp(da, "i_region", OracleType.Int32, ParameterDirection.Input, id_region.ToString());
            //PRO.agrega_parametro_sp(da, "i_contratista", OracleType.Int32, ParameterDirection.Input, id_contratis.ToString());

            da.SelectCommand.CommandType = CommandType.StoredProcedure;

            DataTable dtCargaOperador = new DataTable();

            try
            {
                CnOra.Open();
                da.Fill(dtCargaOperador);
                CnOra.Close();
                CnOra.Dispose();

            }
            catch (Exception ex)
            {

            }

            DataTable dt = new DataTable();
            dt.Columns.Add(new DataColumn("ID_ACCESORIO", typeof(String)));
            dt.Columns.Add(new DataColumn("ID_ACCESORIOXOPERADOR", typeof(String)));
            dt.Columns.Add(new DataColumn("STOCK_ASIGNADO", typeof(String)));
            dt.Columns.Add(new DataColumn("INSTALADOR", typeof(String)));
            dt.Columns.Add(new DataColumn("ID_ESTADO", typeof(String)));
            dt.Columns.Add(new DataColumn("ESTADO", typeof(String)));
            dt.Columns.Add(new DataColumn("ID_BODEGA", typeof(String)));
            dt.Columns.Add(new DataColumn("BODEGA", typeof(String)));

            DataRow dr;

            int total = 0;

            foreach (DataRow drCargaItem in dtCargaOperador.Rows)
            {

                dr = dt.NewRow();

                dr["ID_ACCESORIO"] = drCargaItem["ID_ACCESORIO"].ToString() + " - " + drCargaItem["CATEGORIA"].ToString() + " D" + drCargaItem["DIAMETRO"].ToString();
                dr["INSTALADOR"] = drCargaItem["INSTALADOR"].ToString();
                dr["ID_ACCESORIOXOPERADOR"] = drCargaItem["ID_ACCESORIOXOPERADOR"].ToString();
                dr["STOCK_ASIGNADO"] = drCargaItem["STOCK_ASIGNADO"].ToString();
                dr["ID_ESTADO"] = drCargaItem["ID_ESTADO"].ToString();
                dr["ID_BODEGA"] = drCargaItem["ID_BODEGA"].ToString();
                dr["BODEGA"] = drCargaItem["BODEGA"].ToString();

                if (drCargaItem["ID_ESTADO"].ToString() == "4")
                {
                    dr["ESTADO"] = "ASIGNADO";
                }
                else
                {
                    if (drCargaItem["ID_ESTADO"].ToString() == "5")
                    {
                        dr["ESTADO"] = "CARGADO";
                    }
                    else
                    {
                        dr["ESTADO"] = "INSTALADO";
                    }
                }

                dt.Rows.Add(dr);

                total = total + 1;

            }

            DataView MydataView;
            MydataView = new DataView(dt);
            accesoriosxoperador.DataSource = MydataView;
            accesoriosxoperador.DataBind();

            lbTotal.Text = total + " registro(s) encontrado(s)";

            int i;
            GridViewRow gvRow;
            CheckBox chk_des;

            for (i = 0; i < accesoriosxoperador.Rows.Count; i++)
            {
                gvRow = accesoriosxoperador.Rows[i];
                chk_des = ((CheckBox)gvRow.FindControl("check_desasignar"));

                switch (accesoriosxoperador.Rows[i].Cells[6].Text)
                {
                    case "4":
                        chk_des.Enabled = true;
                        break;
                    case "5":
                        chk_des.Enabled = false;
                        break;
                    case "6":
                        chk_des.Enabled = false;
                        break;
                }
            }

            accesoriosxoperador.Columns[0].Visible = false;
            accesoriosxoperador.Columns[6].Visible = false;
            accesoriosxoperador.Columns[2].Visible = false;
        }

    }

    public void cambio_bodega(object sender, EventArgs e)
    {
        carga_accesorios();
        carga_accesoriosxoperador();
        carga_instaladores(id_cont.ToString(), ddBodegas.SelectedValue);
    }

    public void cambio_diametro(object sender, EventArgs e)
    {
        carga_accesorios();
        carga_accesoriosxoperador();
    }

    public void cambio_accesorio(object sender, EventArgs e)
    {
        carga_accesorios();
        carga_accesoriosxoperador();
    }

    protected void ddStock_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_accesorios();
    }

    protected void ddInstalador_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_accesoriosxoperador();
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
       

        foreach (DataRow row in objDS.Tables["INSTALADOR"].Rows)
        {

            ddInstalador.Items.Add(row[1].ToString());
            ddInstalador.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
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

}