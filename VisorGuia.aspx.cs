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
using System.Text;


public partial class VisorGuia : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"]; //nuestra conexión a bbdd, obtenida del web config.
    Procedimientos PRO = new Procedimientos(); //para agregar parametros de entrada al procedimiento almacenado solicitado.
    public static DataTable mi_reclamo;
    FileInfo[] MisFicheros;
    public static String  ordenar_tipo=" ";
    public static String ordenar_por = " ";

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!Page.IsPostBack)
        {

            try
            {
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                lb_rut_empresa.Text = PRO.recSession(rutaXml, "RUT_EMPRESA");
                lb_id_perfil.Text = PRO.recSession(rutaXml, "ID_PERFIL");
                lb_id_usuario.Text = PRO.recSession(rutaXml, "ID_USUARIO");
                lb_contratista.Text = PRO.recSession(rutaXml, "ID_CONTRATISTA");
             
                mi_reclamo = new DataTable();
                //int id_cont = 0;
                //id_cont = int.Parse(PRO.recSession(rutaXml, "ID_CONTRATISTA"));

                carga_region();
                carga_bodega();                

                txtDesde.Text = DateTime.Now.AddDays(-30).ToString("dd-MM-yyyy");
                txtHasta.Text = DateTime.Now.ToString("dd-MM-yyyy");

                //carga_grilla(txtServ.Text);

                IMG2.Visible = false;
                IMG4.Visible = false;

            }
            catch (Exception ex)
            {

                //Response.Redirect("errorSesion.aspx"); //expira sesión.
            }



        }

    }       
    
    public void carga_grilla(String nro_guia,String desde,String hasta)
    {

        gridOrdenHistorico.Columns[0].Visible = true;
       
            lbTxtIn.ForeColor = System.Drawing.Color.Black;
            lbTxtIn.Text = "";

            IMG2.Visible = false;
            IMG4.Visible = false;
            
            OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
            OracleCommand cmdAcceso = new OracleCommand("PK_VISOR_STOCK.CARGA_GRILLA_GUIA", CnOra);
            OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
             
            PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
            PRO.agrega_parametro_sp(da, "i_nroguia", OracleType.NVarChar, ParameterDirection.Input, nro_guia);
            PRO.agrega_parametro_sp(da, "i_region", OracleType.Int32, ParameterDirection.Input, ddregion.SelectedValue.ToString());
            PRO.agrega_parametro_sp(da, "i_bodega", OracleType.Int32, ParameterDirection.Input, ddbodega.SelectedValue.ToString());
            PRO.agrega_parametro_sp(da, "i_fechadespachodesde", OracleType.NVarChar, ParameterDirection.Input, desde);
            PRO.agrega_parametro_sp(da, "i_fechadespachohasta", OracleType.NVarChar, ParameterDirection.Input, hasta);
            PRO.agrega_parametro_sp(da, "i_contratista", OracleType.Int32, ParameterDirection.Input, lb_contratista.Text);
           
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
             DataTable dtOrdenes = new DataTable();

            try
            {
                CnOra.Open();
               // btn_buscar.Attributes.Add("onclick", "return ShowProgress();"); //mostramos progreso.
                da.Fill(dtOrdenes);
                CnOra.Close();
                CnOra.Dispose();
                lbErrorGrilla.Text = "";
            }
            catch (Exception ex)
            {
                String msg = ex.ToString();
                lbErrorGrilla.ForeColor = System.Drawing.Color.Red;
                if (msg.Contains("ORA-01847")) msg = "NO EXISTEN REGISTROS ASOCIADOS A ESE NRO DE GUIA";
                else msg = "ERROR INESPERADO: " + ex.Message;
                //lbErrorGrilla.Text = ex.Message.ToString();
                lbErrorGrilla.Text = msg;
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error_carga('" + msg +"');", true);
      
            }

            
            DataTable dt = new DataTable();
            dt.Columns.Add(new DataColumn("ID_GUIA", typeof(String)));
            dt.Columns.Add(new DataColumn("NUMERO_GUIA", typeof(String)));
            dt.Columns.Add(new DataColumn("ID_TIPO_GUIA", typeof(String)));
            dt.Columns.Add(new DataColumn("ESTADO_GUIA", typeof(String)));
            dt.Columns.Add(new DataColumn("BODEGA_ORIGEN", typeof(String)));
            dt.Columns.Add(new DataColumn("BODEGA_DESTINO", typeof(String)));
            dt.Columns.Add(new DataColumn("FECHA_DESPACHO", typeof(String)));
           
          
            DataRow dr;

            int total = 0;

            foreach (DataRow drOrdenItem in dtOrdenes.Rows)
            {

                dr = dt.NewRow();
                dr["ID_GUIA"] = drOrdenItem["ID_GUIA"].ToString();
                dr["NUMERO_GUIA"] = drOrdenItem["NUMERO_GUIA"].ToString();
                dr["ID_TIPO_GUIA"] = drOrdenItem["TIPO"].ToString();
                dr["ESTADO_GUIA"] = drOrdenItem["ESTADO_GUIA"].ToString();
                dr["BODEGA_ORIGEN"] = drOrdenItem["BODEGA_ORIGEN"].ToString();
                dr["BODEGA_DESTINO"] = drOrdenItem["BODEGA_DESTINO"].ToString();
                dr["FECHA_DESPACHO"] = drOrdenItem["FECHA_DESPACHO"].ToString().Replace(" 0:00:00", "");
               
                
                dt.Rows.Add(dr);

                total = total + 1;

            }

            DataView MydataView;
            MydataView = new DataView(dt);
            gridOrdenHistorico.PageSize = int.Parse(ddPageSize.SelectedValue);    
            gridOrdenHistorico.DataSource = MydataView;
            gridOrdenHistorico.DataBind();

            lbTotal.Text = total + " registro(s) encontrado(s) - Página " + (gridOrdenHistorico.PageIndex + 1) + " de " + gridOrdenHistorico.PageCount;

            if (total > 0)
            {
                btn_limpiar.Enabled = true;
                btn_limpiar.BackColor = System.Drawing.Color.DarkGreen;
            }
            else
            {
                btn_limpiar.Enabled = false;
                btn_limpiar.BackColor = System.Drawing.Color.DarkGray;
            }


            int i;
            GridViewRow gvRow;

            ImageButton informe = new ImageButton();
            ImageButton respaldo_foto = new ImageButton();
            ImageButton respalfo_foto_no = new ImageButton();
            String  numero_guia= "";

            for (i = 0; i < gridOrdenHistorico.Rows.Count; i++)
            {
                
                gvRow = gridOrdenHistorico.Rows[i];
             
                numero_guia = gridOrdenHistorico.Rows[i].Cells[1].Text;
                informe = (ImageButton)(gvRow.FindControl("btn_informe"));
                respaldo_foto = (ImageButton)(gvRow.FindControl("btn_respaldoguia"));
                respalfo_foto_no = (ImageButton)(gvRow.FindControl("btn_respaldoguiano"));

                if (valida_fotoguia(numero_guia))
                {
                    respaldo_foto.Visible = true;
                    respalfo_foto_no.Visible = false;
                }
                else
                {
                    respaldo_foto.Visible = false;
                    respalfo_foto_no.Visible = true;
                }

            }




        gridOrdenHistorico.Columns[0].Visible = false; 
       
              
    }

    public Boolean valida_fotoguia(String numero_guia)
    {
        try
        {
            String CARPETA_FOTOS = "FOTOS_GUIA";
            String fotoguia = "RESPALDO_" + numero_guia;
            String ruta_directorio;
            String[] arrArchivosFotos;
            FileInfo[] MisFicheros;

            Boolean ex = false;

            //ruta_directorio = Server.MapPath("./FOTOS_GUIA/");
            arrArchivosFotos = Directory.GetFiles(Server.MapPath("./" + CARPETA_FOTOS + "/" + numero_guia + "/"), "*.*");
            MisFicheros = new DirectoryInfo(Server.MapPath("./" + CARPETA_FOTOS + "/" + numero_guia + "/")).GetFiles("*.*");
      


            for (int i = 0; i < MisFicheros.Length; i++)
            {
                String arch = MisFicheros[i].Name;
                String nam = MisFicheros[i].FullName.Replace(Server.MapPath(""), "~");
                return true;
            }


            return ex;
        }
        catch (Exception ex)
        {
            return false;
        }
       
        

    }
   


   

    protected void gridOrden_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //gridOrden.PageIndex = e.NewPageIndex;
        gridOrdenHistorico.PageIndex = e.NewPageIndex;
        carga_grilla(txtguia.Text,ordenar_por ,ordenar_tipo);

    }

    protected void gridOrden_RowCommand(object sender, GridViewCommandEventArgs e)
    {


        try
        {
           
            int index = int.Parse(e.CommandArgument.ToString());

            index = index % gridOrdenHistorico.PageSize;
            string id_guia;
            string nmro_guia;
            string tipo_guia;
            FileInfo []  Mi_Fichero;
            String []  ruta_respguia;
            String CARPETA_FOTOS = "FOTOS_GUIA" ;



            id_guia = gridOrdenHistorico.Rows[index].Cells[0].Text;
            nmro_guia = gridOrdenHistorico.Rows[index].Cells[1].Text;
            tipo_guia = gridOrdenHistorico.Rows[index].Cells[2].Text; 



            if (e.CommandName == "informe_guia")
            {

                String vtn = "window.open('InformeDetalleGuia.aspx?id_guia=" + id_guia + "','Dates','scrollbars=yes,resizable=yes,height=800,width=1200')";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", vtn, true);

            }
           
            if (e.CommandName == "respaldo_guia")
             {


                 ruta_respguia = Directory.GetFiles(Server.MapPath("./" + CARPETA_FOTOS + "/" + nmro_guia + "/"), "*.*");
                 Mi_Fichero = new DirectoryInfo(Server.MapPath("./" + CARPETA_FOTOS + "/" + nmro_guia + "/")).GetFiles("*.*");

                
                  string validafoto = "";
                  String imgext = Mi_Fichero[0].Extension.ToLower();
                  String[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".pdf" };

                 for (int i = 0; i < allowedExtensions.Length; i++)
                 {
                     if (imgext == "." + allowedExtensions[i])
                     {
                         validafoto =   imgext;
                     } break;
                 
                 }


          
                 string doc1 = "B:/AplicacionesWeb/SGM/FOTOS_GUIA/" + nmro_guia + "/RESPALDO_" + nmro_guia + imgext;

                 doc1 = Server.MapPath("./FOTOS_GUIA/" + nmro_guia +"/RESPALDO_" + nmro_guia + imgext);
                 try
                 {
                     if (System.IO.File.Exists(doc1))
                     {
                         Response.Redirect("~/FOTOS_GUIA/" + nmro_guia   + "/RESPALDO_" + nmro_guia + imgext);
                        
                     }
                     else
                     {
                         ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " archivo('');", true);
                     }

                 }
                 catch (Exception ex)
                 {

                 }

             }
            
              
                      
        }
        catch (Exception ex)
        {          
            lbTxtIn.ForeColor = System.Drawing.Color.Red;

            IMG2.Visible = false;
            IMG4.Visible = true;
            lbTxtIn.Text = ex.Message;
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SomestartupScript", " error_carga('" + ex.Message + "');", true);
      
        }
    }

    //public Boolean valida_extension_imagen(String extension)
    //{
       
    //    String[] allowedExtensions = { ".jpg",".jpeg",".png",".pdf" };

    //    for (int i = 0; i < allowedExtensions.Length; i++)
    //    {
    //        if (extension == allowedExtensions[i])
    //        {
    //            return true;
    //        }
    //    }

    //    return false;

    //}
    
   
    protected void txtServ_TextChanged(object sender, EventArgs e)
    {
        //carga_grilla(txtServ.Text);
    }
   
    
    protected void gridOrden_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.RowState == DataControlRowState.Alternate)
            {
                //  e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#FFFFE1';");
                // e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor='#f7fff8';");
            }
            else
            {
                // e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#FFFFE1';");
                // e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor='#eefef0';");
            }
        }
    }


    protected void gridOrden_SelectedIndexChanged(object sender, EventArgs e)
    {
       
     
    }      

    //muestra una ventana emergente con un mensaje de entrada y el tipo de ventana (alert o confirm)
    public void mensaje_emergente(String mensaje)
    {

        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append("<script type = 'text/javascript'>");
        sb.Append("window.onload=function(){");
        sb.Append("alert('");
        sb.Append(mensaje);
        sb.Append("')};");
        sb.Append("</script>");
        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());

    }
       

    
    protected void ddPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        carga_grilla(txtguia.Text, ordenar_por, ordenar_tipo);
    }
    protected void btn_buscar_Click(object sender, EventArgs e)
    {
        carga_grilla(txtguia.Text, txtDesde.Text,txtHasta.Text);
    }
    protected void btn_limpiar_Click(object sender, EventArgs e)
    {
        limpiar();
    }

    public void limpiar()
    {
        lbTxtIn.Text = "";
        txtguia.Text = "";
        IMG2.Visible = false;
        IMG4.Visible = false;
        DataTable dt = null;
     
        //limpiar tabla
        DataView MydataView;
        MydataView = new DataView(dt);
        gridOrdenHistorico.PageSize = int.Parse(ddPageSize.SelectedValue);
        gridOrdenHistorico.DataSource = MydataView;
        gridOrdenHistorico.DataBind();
        lbTotal.Text = "0 registro(s) encontrado(s) - Página " + (gridOrdenHistorico.PageIndex) + " de " + gridOrdenHistorico.PageCount;
        

    }

    public void carga_bodega()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();
        
        objConexion.Open();
        objComando = new OracleDataAdapter("PK_VISOR_STOCK.CARGA_BODEGA", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_contratista", OracleType.Int32, ParameterDirection.Input, lb_contratista.Text  );
        PRO.agrega_parametro_sp(objComando, "i_region", OracleType.Int32, ParameterDirection.Input, ddregion.SelectedValue);
       

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "bodega");
        objConexion.Close();

        int i = 1;
        ddbodega.Items.Clear();
        ddbodega.Items.Add("Todas...");
        ddbodega.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["bodega"].Rows)
        {
            ddbodega.Items.Add(row[1].ToString()); // + " " + row[1].ToString());
            ddbodega.Items[i].Value = row[0].ToString();
            i = i + 1;
        }
    }

    public void carga_region()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_VISOR_STOCK.CARGA_REGION", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "REGION");
        objConexion.Close();

        int i = 1;
        ddregion.Items.Clear();
        ddregion.Items.Add("Todos...");
        ddregion.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["REGION"].Rows)
        {
            ddregion.Items.Add(row[1].ToString());
            ddregion.Items[i].Value = row[0].ToString();
            i = i + 1;
        }
    }

    

 




    //protected void ORDENAR_SERVICIO_Click(object sender, EventArgs e)
    //{
    //    ordenar_por = "ID_SERVICIO";

    //    if (ordenar_tipo == " " || ordenar_tipo == "DESC")
    //    {
    //        ordenar_tipo = "ASC";
    //        carga_grilla(txtguia.Text, ordenar_por, ordenar_tipo);
    //    }
    //    else
    //    {
    //        ordenar_tipo = "DESC";
    //        carga_grilla(txtguia.Text, ordenar_por, ordenar_tipo);
    //    }

    //}









    protected void ID_TIPO_GUIA_Click(object sender, EventArgs e)
    {

    }
    protected void NUMERO_GUIA_Click(object sender, EventArgs e)
    {

    }
    protected void ESTADO_GUIA_Click(object sender, EventArgs e)
    {

    }
    protected void BODEGA_ORIGEN_Click(object sender, EventArgs e)
    {

    }
    protected void DESTINO_Click(object sender, EventArgs e)
    {

    }
}

