using System;
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
using System.Security.Permissions;
using System.Data.OleDb;
using System.Net.Mail;
using System.Collections;

public partial class StockMinimo : System.Web.UI.Page
{

    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();
    FileInfo[] MisFicheros, MisFicherosVisita;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            try
            {

                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                PRO.recSession(rutaXml, "RUT_EMPRESA");

                lb_id_usuario.Text = PRO.recSession(rutaXml, "ID_USUARIO");
                lb_id_perfil.Text = PRO.recSession(rutaXml, "ID_PERFIL");
                lb_id_contratista.Text = PRO.recSession(rutaXml, "ID_CONTRATISTA");
                
                carga_contratistas(lb_id_perfil.Text, lb_id_contratista.Text);
                carga_regiones();
                carga_bodegas(ddContratista.SelectedValue, ddRegion.SelectedValue);
                carga_categorias();
                inicializar_campos();

                //según perfil permitimos editar o crear.
                valida_permisos_perfil(lb_id_perfil.Text);

                carga_grilla(ddContratista.SelectedValue,ddRegion.SelectedValue,ddBodega.SelectedValue,ddTipoMaterial.SelectedValue);
            }
            catch (Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }
        }

    }

    public void valida_permisos_perfil(String id_perfil)
    {

        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_STOCK_MINIMO.VALIDA_ADMIN", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_id_perfil", OracleType.NVarChar, ParameterDirection.Input,id_perfil);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "PERFIL");
        objConexion.Close();
        

        if (objDS.Tables["PERFIL"].Rows[0][0].ToString().Equals("0")) //adm gral, adm desarrollo, adm gral essbio.
        {
            gridOrden.Columns[10].Visible = false;
            gridOrden.Columns[11].Visible = false;
            btn_nuevo.Visible = false;
        }
    }
    
    protected void cb_filtro_busqueda_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla(ddContratista.SelectedValue, ddRegion.SelectedValue, ddBodega.SelectedValue, ddTipoMaterial.SelectedValue);
            
    }
  
    protected void gridOrden_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            var colsNoVisible = gridOrden.DataKeys[gridOrden.SelectedIndex].Values;
            String id_operador;

            id_operador = (string)colsNoVisible[0];
            main.Visible = false;
            agregar.Visible = true;
            inicializar_campos();

        }
        catch (Exception ex)
        {

        }

    }

    protected void btn_buscar_Click(object sender, EventArgs e)
    {
        carga_grilla(ddContratista.SelectedValue, ddRegion.SelectedValue, ddBodega.SelectedValue, ddTipoMaterial.SelectedValue);
            
    }

    protected void btn_nuevo_Click(object sender, EventArgs e)
    {
        main.Visible = false;
        agregar.Visible = true;
        tb_stock_minimo.Text = "";
        //inicializar_campos();
    }

    public void inicializar_campos()
    {
        lb_error.Text = "";
        carga_contratistas(lb_id_perfil.Text, lb_id_contratista.Text);
        carga_regiones();
        carga_bodegas(cb_contratistas.SelectedValue,cb_regiones.SelectedValue);
        carga_diametro();
    }

    //Cargamos las regiones posibles.
    public void carga_regiones()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_OPERADOR.CARGA_REGIONES", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "REGIONES");
        objConexion.Close();

        int i = 1;
        ddRegion.Items.Clear();
        ddRegion.Items.Add("TODAS...");
        ddRegion.Items[0].Value = "0";

        cb_regiones.Items.Clear();
        cb_regiones.Items.Add("TODAS...");
        cb_regiones.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["REGIONES"].Rows)
        {

            cb_regiones.Items.Add(row[0].ToString());
            cb_regiones.Items[i].Value = row[1].ToString();

            ddRegion.Items.Add(row[0].ToString());
            ddRegion.Items[i].Value = row[1].ToString();
            i = i + 1;

        }
    }

    //Cargamos las perfiles posibles.
    public void carga_contratistas(String id_perfil,String id_contratista)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_OPERADOR.CARGA_CONTRATISTAS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_id_perfil", OracleType.Number, ParameterDirection.Input, id_perfil);
        PRO.agrega_parametro_sp(objComando, "i_id_contratista", OracleType.Number, ParameterDirection.Input, id_contratista);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "CONTRATISTA");
        objConexion.Close();

        int i = 1;
        ddContratista.Items.Clear();
        cb_contratistas.Items.Clear();

        if (id_contratista.Equals("0"))
        {
            
            ddContratista.Items.Add("TODOS...");
            ddContratista.Items[0].Value = "0";

            cb_contratistas.Items.Add("TODOS...");
            cb_contratistas.Items[0].Value = "0";
        }
        else
        {
            i = 0;
        }
        

        foreach (DataRow row in objDS.Tables["CONTRATISTA"].Rows)
        {
            ddContratista.Items.Add(row[0].ToString());
            ddContratista.Items[i].Value = row[1].ToString();

            cb_contratistas.Items.Add(row[0].ToString());
            cb_contratistas.Items[i].Value = row[1].ToString();

            i = i + 1;

        }
    }

    //Cargamos las BODEGAS posibles.
    public void carga_bodegas(String id_contratista,String id_region)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_STOCK_MINIMO.CARGA_BODEGAS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_id_contratista", OracleType.Number, ParameterDirection.Input, id_contratista);
        PRO.agrega_parametro_sp(objComando, "i_id_region", OracleType.Number, ParameterDirection.Input, id_region);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "BODEGA");
        objConexion.Close();

        int i = 1;
        cb_bodegas.Items.Clear();
        cb_bodegas.Items.Add("SELECCIONE...");
        cb_bodegas.Items[0].Value = "0";

        ddBodega.Items.Clear();
        ddBodega.Items.Add("TODAS");
        ddBodega.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["BODEGA"].Rows)
        {

            cb_bodegas.Items.Add(row[0].ToString());
            cb_bodegas.Items[i].Value = row[1].ToString();

            ddBodega.Items.Add(row[0].ToString());
            ddBodega.Items[i].Value = row[1].ToString();

            i = i + 1;

        }
    }

    //Cargamos las BODEGAS posibles.
    public void carga_bodegas2(String id_contratista, String id_region)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_STOCK_MINIMO.CARGA_BODEGAS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_id_contratista", OracleType.Number, ParameterDirection.Input, id_contratista);
        PRO.agrega_parametro_sp(objComando, "i_id_region", OracleType.Number, ParameterDirection.Input, id_region);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "BODEGA");
        objConexion.Close();

        int i = 1;
        cb_bodegas.Items.Clear();
        cb_bodegas.Items.Add("SELECCIONE");
        cb_bodegas.Items[0].Value = "0";
          
        foreach (DataRow row in objDS.Tables["BODEGA"].Rows)
        {
            cb_bodegas.Items.Add(row[0].ToString());
            cb_bodegas.Items[i].Value = row[1].ToString();

            i = i + 1;

        }
    }

    //Cargamos los usuarios del sistema según su filtro de búsqueda, el campo para buscar un usuario en específico y de acuerdo al perfil del usuario logeado.
    public void carga_grilla(String contratista, String region, String bodega,String categoria)
    {
        
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_STOCK_MINIMO.CARGA_STOCK_MINIMO", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_id_contratista", OracleType.Number, ParameterDirection.Input, contratista);
        PRO.agrega_parametro_sp(da, "i_id_region", OracleType.Number, ParameterDirection.Input, region);
        PRO.agrega_parametro_sp(da, "i_id_bodega", OracleType.Number, ParameterDirection.Input, bodega);
        PRO.agrega_parametro_sp(da, "i_categoria", OracleType.NVarChar, ParameterDirection.Input, categoria);

        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        DataTable dtOrdenes = new DataTable();

        try
        {
            CnOra.Open();

            da.Fill(dtOrdenes);
            CnOra.Close();
            CnOra.Dispose();
            lb_mensaje.Text = "";
        }
        catch (Exception ex)
        {
            lb_mensaje.ForeColor = System.Drawing.Color.Red;
            lb_mensaje.Text = ex.Message;
        }


        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("ID_STOCK_MINIMO", typeof(String)));
        dt.Columns.Add(new DataColumn("ID_BODEGA", typeof(String)));
        dt.Columns.Add(new DataColumn("BODEGA", typeof(String)));
        dt.Columns.Add(new DataColumn("CONTRATISTA", typeof(String)));
        dt.Columns.Add(new DataColumn("REGION", typeof(String)));
        dt.Columns.Add(new DataColumn("CATEGORIA", typeof(String)));
        dt.Columns.Add(new DataColumn("DIAMETRO", typeof(String)));
        dt.Columns.Add(new DataColumn("STOCK_DISPONIBLE", typeof(String)));
        dt.Columns.Add(new DataColumn("STOCK_MINIMO", typeof(String)));
        dt.Columns.Add(new DataColumn("ESTADO", typeof(String)));

        DataRow dr;

        int total = 0;

        foreach (DataRow drOrdenItem in dtOrdenes.Rows)
        {

            dr = dt.NewRow();
            dr["ID_STOCK_MINIMO"] = drOrdenItem["ID_STOCK_MINIMO"].ToString();
            dr["ID_BODEGA"] = drOrdenItem["ID_BODEGA"].ToString();
            dr["BODEGA"] = drOrdenItem["BODEGA"].ToString();
            dr["CONTRATISTA"] = drOrdenItem["CONTRATISTA"].ToString();
            dr["REGION"] = drOrdenItem["REGION"].ToString();
            dr["CATEGORIA"] = drOrdenItem["CATEGORIA"].ToString();
            dr["DIAMETRO"] = drOrdenItem["DIAMETRO"].ToString();
            dr["STOCK_DISPONIBLE"] = drOrdenItem["STOCK_DISPONIBLE"].ToString();
            dr["STOCK_MINIMO"] = drOrdenItem["STOCK_MINIMO"].ToString();

            double stock_disp = 0;
            double stock_min = 0;

            try { stock_disp = double.Parse(drOrdenItem["STOCK_DISPONIBLE"].ToString()); }
            catch (Exception ex) { }

            try { stock_min = double.Parse(drOrdenItem["STOCK_MINIMO"].ToString()); }
            catch (Exception ex){ }            

            //ESTADO SEGÚN UMBRALES DE SLA PARA EL STOCK MINIMO RESPECTO AL DISPONIBLE.
            if(stock_disp >= stock_min*1.5) { //150% O MÁS -> STOCK EN ESTADO NORMAL.
                dr["ESTADO"] = "NORMAL";            
            }
            else if (stock_disp >= stock_min && stock_disp < stock_min * 1.5) //100% - 149% -> STOCK EN ESTADO ADVERTENCIA.
            {
                dr["ESTADO"] = "ADVERTENCIA";
            }
            else //STOCK EN ESTADO CRÍTICO.
            {
                dr["ESTADO"] = "CRITICO";
            }
            
            dt.Rows.Add(dr);

            total = total + 1;

        }

        DataView MydataView;
        MydataView = new DataView(dt);
        gridOrden.DataSource = MydataView;
        gridOrden.DataBind();
        gridOrden.Columns[0].Visible = false;
        gridOrden.Columns[1].Visible = false;

        lb_contador.Text = total + " registro(s) encontrado(s)";

        GridViewRow gvRow;

        for (int i = 0; i < gridOrden.Rows.Count; i++)
        {

            gvRow = gridOrden.Rows[i];
            gvRow.Cells[9].ForeColor = System.Drawing.Color.White;

            if (gvRow.Cells[9].Text.Equals("ADVERTENCIA"))
            {
                gvRow.Cells[9].BackColor = System.Drawing.Color.Orange;
            }
            else if (gvRow.Cells[9].Text.Equals("CRITICO"))
            {
                gvRow.Cells[9].BackColor = System.Drawing.Color.IndianRed;

            }
            else
            {
                gvRow.Cells[9].BackColor = System.Drawing.Color.DarkGreen;
            }

        }

    }
        
    public void guardar_stock_minimo(String bodega, String categoria, String diametro, String stock_minimo, String usuario,String id_stock)
    {
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_STOCK_MINIMO.GUARDAR_STOCK_MINIMO", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        PRO.agrega_parametro_sp(da, "i_bodega", OracleType.Number, ParameterDirection.Input, bodega);
        PRO.agrega_parametro_sp(da, "i_categoria", OracleType.NVarChar, ParameterDirection.Input, categoria);
        PRO.agrega_parametro_sp(da, "i_diametro", OracleType.Number, ParameterDirection.Input, diametro);
        PRO.agrega_parametro_sp(da, "i_stock_minimo", OracleType.Number, ParameterDirection.Input, stock_minimo);
        PRO.agrega_parametro_sp(da, "i_id_usuario", OracleType.Number, ParameterDirection.Input, usuario);

        int n;
        if (!int.TryParse(id_stock, out n)) id_stock = "0";
        PRO.agrega_parametro_sp(da, "i_id_stock_minimo", OracleType.Number, ParameterDirection.Input, id_stock);
        
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        
        try
        {
            CnOra.Open();

            da.SelectCommand.ExecuteNonQuery();
            CnOra.Close();
            CnOra.Dispose();    
            lb_mensaje.ForeColor = System.Drawing.Color.DarkGreen;
            lb_mensaje.Text = "STOCK MINIMO CREADO EXITOSAMENTE!";           
            
          
        }
        catch (Exception ex)
        {
            lb_mensaje.ForeColor = System.Drawing.Color.Red;
            lb_mensaje.Text = ex.Message;
            CnOra.Close();
            CnOra.Dispose();
            
        }
    }

   
    //panel de agregar, validar campos y guardar o volver, campo de familias para relacionar a los usuarios con ellas.
    protected void btn_guardar_Click(object sender, EventArgs e)
    {

        if (validar_formulario())
        {                       
            //si resulta verdadero permite crear ya que no existe, sino enviamos mensaje respectivo.
            if (valida_stock_minimo(cb_bodegas.SelectedValue, cb_categorias.SelectedValue, cb_diametros.SelectedValue))
            {
                guardar_stock_minimo(cb_bodegas.SelectedValue, cb_categorias.SelectedValue, cb_diametros.SelectedValue, tb_stock_minimo.Text, 
                    lb_id_usuario.Text,"0");

                main.Visible = true;
                agregar.Visible = false;
                String mensaje = lb_mensaje.Text;
                carga_grilla(ddContratista.SelectedValue, ddRegion.SelectedValue, ddBodega.SelectedValue, ddTipoMaterial.SelectedValue);
                lb_mensaje.Text = mensaje;
            }
            else
            {
                lb_error.Text = "YA EXISTE STOCK MINIMO!";
            }
                        
        }


    }

    public Boolean validar_formulario()
    {
        lb_error.Text = "";
        String respuesta = "";
        int pendientes = 0;
               
        
        if (cb_bodegas.SelectedIndex == 0)
        {
            if (pendientes > 0) respuesta = ", Debe seleccionar una bodega";
            else respuesta = " Debe seleccionar una bodega";

            lb_error.Text = lb_error.Text + respuesta;
            pendientes++;
        }

        if (cb_categorias.SelectedIndex == 0)
        {
            if (pendientes > 0) respuesta = ", Debe seleccionar una categoria";
            else respuesta = " Debe seleccionar una categoria";

            lb_error.Text = lb_error.Text + respuesta;
            pendientes++;
        }


        if (cb_diametros.SelectedIndex == 0)
        {
            if (pendientes > 0) respuesta = ", Debe seleccionar un diametro";
            else respuesta = " Debe seleccionar un diametro";

            lb_error.Text = lb_error.Text + respuesta;
            pendientes++;
        }

       
        int n;
        if (!int.TryParse(tb_stock_minimo.Text, out n))
        {
            if (pendientes > 0) respuesta = ", Debe ingresar un número válido para el stock mínimo";
            else respuesta = " Debe ingresar un número válido para el stock mínimo";

            lb_error.Text = lb_error.Text + respuesta;
            pendientes++;
        }
        else if(int.Parse(tb_stock_minimo.Text) < 0)
        {
            if (pendientes > 0) respuesta = ", Debe ingresar un stock mínimo mayor o igual a 0";
            else respuesta = " Debe ingresar un stock mínimo mayor o igual a 0";

            lb_error.Text = lb_error.Text + respuesta;
            pendientes++;
        }
        
        //hay cosas pendientes? pendientes > 0 indica que quedan pendientes
        if (pendientes > 0) return false;
        else return true;

    }

   
    protected void btn_volver_Click(object sender, EventArgs e)
    {
        main.Visible = true;
        agregar.Visible = false;
    }

    
    //CARGA DIAMETROS POSIBLES PARA EL STOCK MINIMO.
    public void carga_diametro()
    {

        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_STOCK_MINIMO.CARGA_DIAMETROS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "DIAMETRO");
        objConexion.Close();

        int i = 1;
       
            cb_diametros.Items.Clear();
            cb_diametros.Items.Add("SELECCIONE...");
            cb_diametros.Items[0].Value = "0";

            foreach (DataRow row in objDS.Tables["DIAMETRO"].Rows)
            {

                cb_diametros.Items.Add(row[0].ToString());
                cb_diametros.Items[i].Value = row[0].ToString();
                i = i + 1;

            }
        

    }

    protected void gridOrden_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {

            if (e.CommandName == "VALIDAR")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = (GridViewRow)gridOrden.Rows[index];//migrilla.Rows[index];
                TextBox stock_edit;
                
                stock_edit = (TextBox)row.Cells[0].FindControl("STOCK_MINIMO");

                var colsNoVisible = gridOrden.DataKeys[index].Values;
                string stock, id_stock,categoria,diametro,bodega;
                id_stock = (string)colsNoVisible[0]; //row.Cells[0].Text;
                bodega = (string)colsNoVisible[1]; //row.Cells[1].Text;
                stock = stock_edit.Text;
                categoria = row.Cells[5].Text;
                diametro = row.Cells[6].Text;
                lb_mensaje.Text = "";

                if (stock.Length > 0) //debe tener algún número.
                {
                    int n;
                    if (int.TryParse(stock,out n)) //debe ser único el nro orden en proceso e histórico.
                    {
                        guardar_stock_minimo(bodega, categoria, diametro,stock,lb_id_usuario.Text, id_stock);

                        carga_grilla(ddContratista.SelectedValue, ddRegion.SelectedValue, ddBodega.SelectedValue, ddTipoMaterial.SelectedValue);
                        lb_mensaje.Text = "STOCK ACTUALIZADO!";
                    }
                    else
                    {
                        lb_mensaje.ForeColor = System.Drawing.Color.Red;
                        lb_mensaje.Text = "Se permiten sólo números enteros";
                    }
                }
                else
                {
                    lb_mensaje.ForeColor = System.Drawing.Color.Red;
                    lb_mensaje.Text = "Debe ingresar un número válido";
                }
                                

            }
        }
        catch (Exception ex)
        {
            lb_mensaje.ForeColor = System.Drawing.Color.Red;
            lb_mensaje.Text = "Error: " + ex.Message;
        }


    }


    //CARGA CATEGORIAS DISPONIBLES PARA EL STOCK MINIMO
    public void carga_categorias()
    {

        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_STOCK_MINIMO.CARGA_CATEGORIAS", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "CATEGORIAS");
        objConexion.Close();

        int i = 1;

        ddTipoMaterial.Items.Clear();
        ddTipoMaterial.Items.Add("TODAS...");
        ddTipoMaterial.Items[0].Value = "";
        
        //nuevo stock minimo
        cb_categorias.Items.Clear();
        cb_categorias.Items.Add("SELECCIONE...");
        cb_categorias.Items[0].Value = "";

        foreach (DataRow row in objDS.Tables["CATEGORIAS"].Rows)
        {

            ddTipoMaterial.Items.Add(row[0].ToString());
            ddTipoMaterial.Items[i].Value = row[0].ToString();

            cb_categorias.Items.Add(row[0].ToString());
            cb_categorias.Items[i].Value = row[0].ToString();

            i = i + 1;

        }


    }

    //si resulta falso es porque no existe stock minimo, si es verdadero no debiese crearte el stock nuevo.
    public Boolean valida_stock_minimo(String bodega,String categoria,String diametro)
    {
        try
        {
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();

            objConexion.Open();
            objComando = new OracleDataAdapter("PK_STOCK_MINIMO.VALIDA_STOCK_MINIMO", objConexion);
            objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

            try
            {

                PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
                PRO.agrega_parametro_sp(objComando, "i_bodega", OracleType.Number, ParameterDirection.Input, bodega);
                PRO.agrega_parametro_sp(objComando, "i_categoria", OracleType.NVarChar, ParameterDirection.Input, categoria);
                PRO.agrega_parametro_sp(objComando, "i_diametro", OracleType.Number, ParameterDirection.Input, diametro);

            }
            catch (Exception ex)
            {
                objConexion.Close();
                return false;
            }

            objComando.SelectCommand.ExecuteNonQuery();
            objComando.Fill(objDS, "VALIDA_STOCK_MINIMO");
            objConexion.Close();

            foreach (DataRow row in objDS.Tables["VALIDA_STOCK_MINIMO"].Rows)
            {

                return false;
            }
        }
        catch (Exception ex)
        {
            return false;
        }

        return true;
    }

    protected void ddContratista_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_bodegas(ddContratista.SelectedValue, ddRegion.SelectedValue);
        cb_contratistas.SelectedIndex = ddContratista.SelectedIndex;
    }
    protected void ddRegion_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_bodegas(ddContratista.SelectedValue, ddRegion.SelectedValue);
        cb_regiones.SelectedIndex = ddRegion.SelectedIndex;
    }
    protected void ddBodega_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla(ddContratista.SelectedValue, ddRegion.SelectedValue, ddBodega.SelectedValue, ddTipoMaterial.SelectedValue);
    }
    protected void ddTipoMaterial_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla(ddContratista.SelectedValue, ddRegion.SelectedValue, ddBodega.SelectedValue, ddTipoMaterial.SelectedValue);
    }
    protected void cb_contratistas_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_bodegas(cb_contratistas.SelectedValue, cb_regiones.SelectedValue);
        ddContratista.SelectedIndex = cb_contratistas.SelectedIndex;
    }
    protected void cb_regiones_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_bodegas(cb_contratistas.SelectedValue, cb_regiones.SelectedValue);
        ddRegion.SelectedIndex = cb_regiones.SelectedIndex;
    }
    protected void cb_bodegas_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddBodega.SelectedIndex = cb_bodegas.SelectedIndex;
    }
}