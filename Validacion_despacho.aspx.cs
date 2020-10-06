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

public partial class Validacion_despacho : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();
    public static int id_cont = 0, id_region = 0, id_usuario, codigo_articulo;

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

                cargar_filtros();
                carga_guia();
                carga_grilla();

            }
            catch(Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }     
        }
    }

    public void cargar_filtros()
    {
        txtDesde.Text = DateTime.Now.AddDays(-30).ToString("dd-MM-yyyy");
        txtHasta.Text = DateTime.Now.ToString("dd-MM-yyyy");
        carga_contratista();
        carga_region();
    }

    
    //OBTENEMOS LOS CONTRATISTAS.
    public void carga_contratista()
    {

        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_VALIDA_DESPACHO.CARGA_CONTRATISTA", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "CONTRATISTA");
        objConexion.Close();

        int i = 1;

        ddContratista.Items.Clear();
        ddContratista.Items.Add("Todos...");
        ddContratista.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["CONTRATISTA"].Rows)
        {

            ddContratista.Items.Add(row[0].ToString());
            ddContratista.Items[i].Value = row[1].ToString();
            i = i + 1;

        }
    }

    //OBTENEMOS LAS REGIONES.
    public void carga_region()
    {

        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_VALIDA_DESPACHO.CARGA_REGION", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "REGION");
        objConexion.Close();

        int i = 1;

        ddRegion.Items.Clear();
        ddRegion.Items.Add("Todos...");
        ddRegion.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["REGION"].Rows)
        {

            ddRegion.Items.Add(row[0].ToString());
            ddRegion.Items[i].Value = row[1].ToString();
            i = i + 1;

        }
    }

    public void carga_guia()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();
        
        objConexion.Open();
        objComando = new OracleDataAdapter("PK_VALIDA_DESPACHO.CARGA_GUIA", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "contratista", OracleType.Int32, ParameterDirection.Input, ddContratista.SelectedValue);
        PRO.agrega_parametro_sp(objComando, "region", OracleType.Int32, ParameterDirection.Input, ddRegion.SelectedValue);
        PRO.agrega_parametro_sp(objComando, "desde", OracleType.NVarChar, ParameterDirection.Input, txtDesde.Text.ToString());
        PRO.agrega_parametro_sp(objComando, "hasta", OracleType.NVarChar, ParameterDirection.Input, txtHasta.Text.ToString());
        PRO.agrega_parametro_sp(objComando, "usuario", OracleType.Int32, ParameterDirection.Input, id_usuario.ToString());
        PRO.agrega_parametro_sp(objComando, "estado_guia", OracleType.Int32, ParameterDirection.Input, ddEstadoGuia.SelectedValue);
        PRO.agrega_parametro_sp(objComando, "tipo_guia", OracleType.Int32, ParameterDirection.Input, ddTipoGuia.SelectedValue);
        //PRO.agrega_parametro_sp(objComando, "contratista", OracleType.Int32, ParameterDirection.Input, id_cont.ToString());

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "GUIA");

        objConexion.Close();

        int i = 1;

        ddguia.Items.Clear();
        ddguia.Items.Add("SELECCIONE GUIA");
        ddguia.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["GUIA"].Rows)
        {

            ddguia.Items.Add(row[1].ToString() + " - GUIA DE " + row[2].ToString() + " - BODEGA " + row[4].ToString() + " ( " + row[3].ToString() + " )");
            ddguia.Items[i].Value = row[0].ToString();
            i = i + 1;

        }

        if (objDS.Tables["GUIA"].Rows.Count == 0)
        {
            Table2.Visible = false;
            lb_resultlado_filtro.Text = "No se ha encontrado ninguna guia por validar (Verificar permisos a bodegas)";
        } else {
            lb_resultlado_filtro.Text = "";
            Table2.Visible = true;
        }
            
        
    }

    public void carga_grilla()
    {
        medidores.Visible = false; //INICIALIZAMOS NO VISUALIZAR TABLA DE DETALLE DE MEDIDORES.
        lb_detalle_medidores.Visible = false;

        if (ddguia.SelectedValue == "0")
        {
            Table2.Visible = false;
        }
        else
        {
            Table2.Visible = true;
            String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
            int id_contratis = 0, id_region = 0;
            id_contratis = int.Parse(PRO.recSession(rutaXml, "ID_CONTRATISTA"));
            //id_region = int.Parse(PRO.recSession(rutaXml, "ID_REGION"));

            OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
            OracleCommand cmdAcceso = new OracleCommand("PK_VALIDA_DESPACHO.CARGA_DETALLE", CnOra);
            OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

            GrillaValidacion.Columns[0].Visible = true;
            GrillaValidacion.Columns[1].Visible = true;
            GrillaValidacion.Columns[2].Visible = true;
            GrillaValidacion.Columns[12].Visible = true;
            //PENDIENTES DE VALIDAR gridOrden.Columns[9].Visible = true;

            PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
            PRO.agrega_parametro_sp(da, "guia", OracleType.Int32, ParameterDirection.Input, ddguia.SelectedValue.ToString());
            PRO.agrega_parametro_sp(da, "reserva", OracleType.Int32, ParameterDirection.Input, "0"); //ddreserva.SelectedValue.ToString());
            PRO.agrega_parametro_sp(da, "contratista", OracleType.Int32, ParameterDirection.Input, id_contratis.ToString());

            da.SelectCommand.CommandType = CommandType.StoredProcedure;

            DataTable dtDetalle = new DataTable();

            try
            {
                CnOra.Open();
                da.Fill(dtDetalle);
                CnOra.Close();
                CnOra.Dispose();

            }
            catch (Exception ex)
            {
                //lbErrorGrilla.Text = ex.ToString() + servicio;
                //lbErrorGrilla.ForeColor = System.Drawing.Color.Red;
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " Error('Error en los parametros de entrada');", true);

            }

            DataTable dt = new DataTable();
            dt.Columns.Add(new DataColumn("ID_DETALLE_GUIA", typeof(String)));
            dt.Columns.Add(new DataColumn("ID_GUIA", typeof(String)));
            dt.Columns.Add(new DataColumn("CODIGO_ARTICULO", typeof(String)));
            dt.Columns.Add(new DataColumn("NOMBRE_ARTICULO", typeof(String)));
            dt.Columns.Add(new DataColumn("CANTIDAD", typeof(String)));
            dt.Columns.Add(new DataColumn("DIAMETRO", typeof(String)));
            dt.Columns.Add(new DataColumn("TIPO", typeof(String)));
            dt.Columns.Add(new DataColumn("CODIGO_PROVEEDOR", typeof(String)));
            dt.Columns.Add(new DataColumn("CANTIDAD_PENDIENTE", typeof(String)));
            dt.Columns.Add(new DataColumn("EN_DIFERENCIA", typeof(String)));
            DataRow dr;

            int total = 0;

            foreach (DataRow drDetalleItem in dtDetalle.Rows)
            {

                dr = dt.NewRow();

                dr["ID_DETALLE_GUIA"] = drDetalleItem["ID_DETALLE_GUIA"].ToString();
                dr["ID_GUIA"] = drDetalleItem["ID_GUIA"].ToString();
                dr["CODIGO_ARTICULO"] = drDetalleItem["CODIGO_ARTICULO"].ToString();//
                dr["NOMBRE_ARTICULO"] = drDetalleItem["NOMBRE_ARTICULO"].ToString();
                dr["CANTIDAD"] = drDetalleItem["CANTIDAD"].ToString();
                dr["DIAMETRO"] = drDetalleItem["DIAMETRO"].ToString();
                dr["TIPO"] = drDetalleItem["TIPO"].ToString();
                dr["CODIGO_PROVEEDOR"] = drDetalleItem["CODIGO_PROVEEDOR"].ToString();
                dr["CANTIDAD_PENDIENTE"] = drDetalleItem["CANTIDAD_PENDIENTE"].ToString();
                dr["EN_DIFERENCIA"] = drDetalleItem["EN_DIFERENCIA"].ToString();

                dt.Rows.Add(dr);

                total = total + 1;

            }

            DataView MydataView;
            MydataView = new DataView(dt);
            GrillaValidacion.DataSource = MydataView;
            GrillaValidacion.DataBind();

            lbTotal.Text = total + " registro(s) encontrado(s)";
                        

            GrillaValidacion.Columns[0].Visible = false;
            GrillaValidacion.Columns[1].Visible = false;
            GrillaValidacion.Columns[2].Visible = false;
            GrillaValidacion.Columns[12].Visible = false;
            // PENDIENTES DE VALIDAR gridOrden.Columns[9].Visible = false;


        }
        
     
    }
   
    public Boolean valida_check()
    {
        int c;
        Boolean check=false;
        //DataGridItem item_grilla;
        GridViewRow gvRow;
        CheckBox check_row = new CheckBox();
        for (c = 0; c < GrillaValidacion.Rows.Count; c++)
        {
            String bandera = GrillaValidacion.Rows[c].Cells[16].Text;
            bandera = GrillaValidacion.Rows[c].Cells[15].Text;
            //item_grilla = gridOrden.Items[c];
            gvRow = GrillaValidacion.Rows[c];
            check_row = (CheckBox)(gvRow.FindControl("check_asigna"));
            if ((check_row.Checked == true) && (GrillaValidacion.Rows[c].Cells[2].Text == "2"))
            {
                check = true;
            }
        }
        return check;
    }

    protected void gridOrden_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        medidores.Visible = false;
        int index = int.Parse(e.CommandArgument.ToString());
        index = index % GrillaValidacion.PageSize;

        int id_detalle = int.Parse(GrillaValidacion.Rows[index].Cells[0].Text);
        int id_guia = int.Parse(GrillaValidacion.Rows[index].Cells[1].Text);
        codigo_articulo = int.Parse(GrillaValidacion.Rows[index].Cells[2].Text);

        TextBox x = new TextBox();
        x= (TextBox)(GrillaValidacion.Rows[index].Cells[10].Controls[1]);
        String cantidad_ingreso = x.Text;
        String cantidad_pendiente = GrillaValidacion.Rows[index].Cells[9].Text;
        String en_diferencia = GrillaValidacion.Rows[index].Cells[12].Text;
        String nombre_articulo = GrillaValidacion.Rows[index].Cells[6].Text;
        String diametro = GrillaValidacion.Rows[index].Cells[7].Text;
        Boolean band=false;

        if (e.CommandName == "aceptar")
        {
            lb_detalle_medidores.Text = "";
                if (GrillaValidacion.Rows[index].Cells[5].Text == "MEDIDOR")
                {
                    try
                    {
                        if (int.Parse(cantidad_ingreso) <= (int.Parse(cantidad_pendiente)-int.Parse(en_diferencia)) && int.Parse(cantidad_ingreso) > 0)
                        {
                            GrillaValidacion.Rows[index].BackColor = System.Drawing.Color.LightGreen;

                            band = recepcion_completa(id_guia, id_detalle, codigo_articulo, int.Parse(cantidad_ingreso), GrillaValidacion.Rows[index].Cells[5].Text, int.Parse(cantidad_pendiente));

                            carga_grilla();

                            if (band == true) { ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "correcto('Se valido correctamente');", true); }
                            else { ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('Ocurrio un problema al validar');", true); }


                        }
                        else
                        {
                            GrillaValidacion.Rows[index].BackColor = System.Drawing.Color.IndianRed;
                            lb_detalle_medidores.Visible = true;
                            lb_detalle_medidores.Text = "MEDIDOR " + nombre_articulo + " DE DIAMETRO " + diametro;
                            carga_medidores_ingresados(codigo_articulo);
                            medidores.Focus();
                            if (int.Parse(en_diferencia) > 0) ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('Existen medidores en diferencia, valide individualmente los medidores');", true);
                            else ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('Valide individualmente los medidores');", true);
                        
                        }
                    }
                    catch (Exception ex) //no ingresó algún número
                    {
                        GrillaValidacion.Rows[index].BackColor = System.Drawing.Color.IndianRed;
                        lb_detalle_medidores.Visible = true;
                        lb_detalle_medidores.Text = "MEDIDOR " + nombre_articulo + " DE DIAMETRO " + diametro;
                        carga_medidores_ingresados(codigo_articulo);
                        medidores.Focus();
                        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('Valide individualmente los medidores');", true);
                        
                    }
                   

                }
                else
                { //VALIDAMOS ACCESORIOS
                       
                    int n;
                    if (int.TryParse(cantidad_ingreso,out n) && int.TryParse(cantidad_pendiente,out n))
                    {
                        if (int.Parse(cantidad_ingreso) > 0 && int.Parse(cantidad_ingreso) <= int.Parse(cantidad_pendiente)) //DE 0 A PENDIENTE.
                        {
                            GrillaValidacion.Rows[index].BackColor = System.Drawing.Color.LightGreen;

                            band = recepcion_completa(id_guia, id_detalle, codigo_articulo, int.Parse(cantidad_ingreso), GrillaValidacion.Rows[index].Cells[5].Text, int.Parse(cantidad_pendiente));
                            carga_grilla();

                            if (band == true) ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "correcto('Se valido correctamente');", true); 
                            else  ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('Ocurrio un problema al validar');", true); 

                        }
                        else
                        {
                            GrillaValidacion.Rows[index].BackColor = System.Drawing.Color.IndianRed;

                            if (int.Parse(cantidad_ingreso) <= 0 || int.Parse(cantidad_ingreso) > int.Parse(cantidad_pendiente))
                            {
                                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('La cantidad ingresada debe ser mayor a 0 y menor o igual a la cantidad pendiente');", true);
                            }
                            else
                            {
                                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('Las cantidades no se pudieron validar...');", true);
                            }

                        }
                     }
                     else
                     {
                        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('Valor ingresado debe ser numérico');", true);
                        x.Focus();
                        GrillaValidacion.Rows[index].BackColor = System.Drawing.Color.IndianRed;
                     }                  
                    
                }
            } 
    }



    protected void gridOrden_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GrillaValidacion.PageIndex = e.NewPageIndex;
        carga_grilla();

    }

    protected void lkbAsignar_Click(object sender, EventArgs e)
    {

    }

    protected void gridOrden_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    protected void ddguia_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla();
        observacion.Text = carga_observacion(ddguia.SelectedValue);
        
    }

    protected void ddreserva_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    public String carga_observacion(String guia)
    {
        try
        {
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();

            objConexion.Open();
            objComando = new OracleDataAdapter("SELECT OBSERVACION FROM GUIA WHERE ID_GUIA = '" + guia + "'", objConexion);
            objComando.SelectCommand.CommandType = CommandType.Text;

            objComando.SelectCommand.ExecuteNonQuery();
            objComando.Fill(objDS, "OBS");
            objConexion.Close();

            foreach (DataRow row in objDS.Tables["OBS"].Rows)
            {
                return row[0].ToString();
            }

            return "";
        }
        catch (Exception ex)
        {
            return ex.Message;
        }
    }

    protected void ingresar_observacion_Click(object sender, EventArgs e)
    {
        
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_VALIDA_DESPACHO.INGRESA_OBSERVACION_CIERRA", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "guia", OracleType.Int32, ParameterDirection.Input, ddguia.SelectedValue);
        PRO.agrega_parametro_sp(objComando, "obs", OracleType.NVarChar, ParameterDirection.Input, observacion.Text);
        PRO.agrega_parametro_sp(objComando, "pendiente", OracleType.NVarChar, ParameterDirection.Input, GrillaValidacion.Rows.Count.ToString());

        

        try
        {
            objComando.SelectCommand.ExecuteNonQuery();
            objConexion.Close();
            if (GrillaValidacion.Rows.Count.ToString()!="0") ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " pendiente('Cierre parcial de guia');", true);
            else ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " correcto('Se ingresó observación y se cerró la validación ');", true);
            carga_guia();
            ddguia.SelectedIndex = 0;
            carga_grilla();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error('Error al ingresar guia y su observación');", true);
        }

        
    }

    protected void medidores_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int index = int.Parse(e.CommandArgument.ToString());
        index = index % medidores.PageSize;
        
        int id = int.Parse(medidores.Rows[index].Cells[1].Text);
        int codigo = int.Parse(medidores.Rows[index].Cells[2].Text);
        int tipo_articulo = int.Parse(medidores.Rows[index].Cells[9].Text);
        int estado_actual = int.Parse(medidores.Rows[index].Cells[11].Text);

        if(e.CommandName == "recepcionado") {

            recibido_bodega(id, tipo_articulo, 1,estado_actual);
        
        }

        if (e.CommandName == "no_recepcionado")
        {

            recibido_bodega(id, tipo_articulo, 0,estado_actual);

        }
    }

    protected void recibido_bodega(int id,int codigo,int estado,int estado_actual) {

        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;

        objComando = new OracleDataAdapter("PK_VALIDA_DESPACHO.RECIBIDO", objConexion);

        PRO.agrega_parametro_sp(objComando, "i_id", OracleType.Int32, ParameterDirection.Input, id.ToString());
        PRO.agrega_parametro_sp(objComando, "i_codigo", OracleType.Int32, ParameterDirection.Input, codigo.ToString());
        PRO.agrega_parametro_sp(objComando, "estado", OracleType.Int32, ParameterDirection.Input, estado.ToString());

        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        
        try
        {
            objConexion.Open();
            objComando.SelectCommand.ExecuteNonQuery();
            objConexion.Close();
            objConexion.Dispose();

            carga_grilla();
            carga_medidores_ingresados(codigo);

            if (estado == 1)
            {
                if (estado_actual < 9)
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "correcto('Se valido el medidor, ya esta disponible para gestionar');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "correcto('Medidor normalizado, volver a validar para liberar');", true);
            
                }
            }
            else {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "correcto('Se marco medidor como EN DIFERENCIA');", true);
            }

           
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", "error('Ocurrio un problema al validar');", true);

        }

    }

    protected Boolean recepcion_completa(int id_guia,int id, int codigo,int cantidad_ingreso, String tipo,int cantidad_pendiente){

        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;

        objComando = new OracleDataAdapter("PK_VALIDA_DESPACHO.RECEPCIONA_GRUPO", objConexion);

        PRO.agrega_parametro_sp(objComando, "i_id_guia", OracleType.Int32, ParameterDirection.Input, id_guia.ToString() );
        PRO.agrega_parametro_sp(objComando, "i_id", OracleType.Int32, ParameterDirection.Input, id.ToString());
        PRO.agrega_parametro_sp(objComando, "i_codigo", OracleType.Int32, ParameterDirection.Input, codigo.ToString());
        PRO.agrega_parametro_sp(objComando, "i_tipo", OracleType.NVarChar, ParameterDirection.Input, tipo.ToString());
        PRO.agrega_parametro_sp(objComando, "i_cantidad_ingresada", OracleType.Int32, ParameterDirection.Input, cantidad_ingreso.ToString());
        PRO.agrega_parametro_sp(objComando, "i_cantidad_pendiente", OracleType.Int32, ParameterDirection.Input, cantidad_pendiente.ToString());

        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        
        try
        {
            objConexion.Open();
            objComando.SelectCommand.ExecuteNonQuery();
            objConexion.Close();
            objConexion.Dispose();
            carga_grilla();

            //carga_medidores_ingresados(codigo);
            return true;
            
        }
        catch (Exception ex)
        {
            return false;

        }

    }

    protected void medidores_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        medidores.PageIndex = e.NewPageIndex;
        carga_medidores_ingresados(codigo_articulo);
    }

    protected void medidores_RowDataBound(object sender, GridViewRowEventArgs e)
    {


    }

    public void carga_medidores_ingresados(int codigo)
    {
        medidores.Columns[0].Visible = true;
        medidores.Columns[1].Visible = true;
        medidores.Columns[9].Visible = true;
        medidores.Columns[7].Visible = true;
        medidores.Columns[6].Visible = true;
        medidores.Columns[11].Visible = true;

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_VALIDA_DESPACHO.CARGA_GRILLA_MEDIDORES", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        if (ddguia.SelectedValue != "")
        {
            PRO.agrega_parametro_sp(da, "i_guia", OracleType.Int32, ParameterDirection.Input, ddguia.SelectedValue);
        }
        else
        {

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error('No existe numero de guía o ocurrio un error en la carga');", true);
            return;
        }

        PRO.agrega_parametro_sp(da, "i_codigo", OracleType.Int32, ParameterDirection.Input,codigo.ToString());

        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        DataTable dtMedidores = new DataTable();

        try
        {
            CnOra.Open();
            da.Fill(dtMedidores);
            CnOra.Close();
            CnOra.Dispose();
        }
        catch (Exception ex)
        {

        }


        DataTable dt = new DataTable();

        dt.Columns.Add(new DataColumn("ID_GUIA", typeof(int)));
        dt.Columns.Add(new DataColumn("ID_MEDIDOR", typeof(String)));
        dt.Columns.Add(new DataColumn("NOMBRE_MODELO", typeof(String)));
        dt.Columns.Add(new DataColumn("SERIE", typeof(String)));
        dt.Columns.Add(new DataColumn("ANO", typeof(int)));
        dt.Columns.Add(new DataColumn("DIAMETRO", typeof(String)));
        dt.Columns.Add(new DataColumn("CONTRATISTA", typeof(String)));
        dt.Columns.Add(new DataColumn("REGION", typeof(String)));
        dt.Columns.Add(new DataColumn("CODIGO", typeof(String)));
        dt.Columns.Add(new DataColumn("ID_TIPO_MEDIDOR", typeof(String)));
        dt.Columns.Add(new DataColumn("ID_ESTADO_MEDIDOR", typeof(String)));

        DataRow dr;

        int total = 0;

        foreach (DataRow drOrdenItem in dtMedidores.Rows)
        {
            dr = dt.NewRow();
            dr["ID_GUIA"] = drOrdenItem["ID_GUIA"].ToString();
            dr["ID_MEDIDOR"] = drOrdenItem["ID_MEDIDOR"].ToString();
            dr["NOMBRE_MODELO"] = drOrdenItem["NOMBRE_MODELO"].ToString();
            dr["SERIE"] = drOrdenItem["SERIE"].ToString();
            dr["ANO"] = drOrdenItem["ANO"].ToString();
            dr["DIAMETRO"] = drOrdenItem["DIAMETRO"].ToString();
            dr["CONTRATISTA"] = drOrdenItem["CONTRATISTA"].ToString();
            dr["REGION"] = drOrdenItem["REGION"].ToString();
            dr["CODIGO"] = drOrdenItem["CODIGO"].ToString();
            dr["ID_TIPO_MEDIDOR"] = drOrdenItem["ID_TIPO_MEDIDOR"].ToString();
            dr["ID_ESTADO_MEDIDOR"] = drOrdenItem["ID_ESTADO_MEDIDOR"].ToString();
            dt.Rows.Add(dr);

            total = total + 1;

        }


        DataView MydataView;
        MydataView = new DataView(dt);
        medidores.DataSource = MydataView;
        medidores.DataBind();

        GridViewRow gvRow;

        for (int i = 0; i < medidores.Rows.Count; i++)
        {

            gvRow = medidores.Rows[i];

            try
            {
                if (gvRow.Cells[11].Text.Equals("9"))
                {
                    gvRow.Cells[10].BackColor = System.Drawing.Color.IndianRed;
                }

            }
            catch (Exception ex)
            {
                continue;
            }

        }

        medidores.Columns[0].Visible = false;
        medidores.Columns[1].Visible = false;
        medidores.Columns[7].Visible = false;
        medidores.Columns[6].Visible = false;
        medidores.Columns[9].Visible = false;
        medidores.Columns[11].Visible = false;

        if (medidores.Rows.Count == 0) lb_detalle_medidores.Text = "";
        else medidores.Visible = true;

        
    }
    protected void ddDiametroMed_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_guia();
        carga_grilla();
    }
    protected void ddMarcaMed_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_guia();
        carga_grilla();
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        carga_guia();
        carga_grilla();
    }
    protected void ddTipoGuia_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_guia();
        carga_grilla();
    }
    protected void ddEstadoGuia_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_guia();
        carga_grilla();
    }
}