﻿using System;
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

public partial class GestionHistorico : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();

    String servicio, id, grupo, operador, orden,visita,atendido;

    protected void Page_Load(object sender, EventArgs e)
    {
        //carga_grilla(txtServ.Text);

        try
        {
            String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
            PRO.recSession(rutaXml, "RUT_EMPRESA");

        }
        catch (Exception ex)
        {
            Response.Redirect("errorSesion.aspx");
        }
            
                 
    }


    public void carga_clinte(String servicio)
    {
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_ORDEN.CARGAR_HISTORICO_CLIENTE", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";

        gridOrden.Columns[25].Visible = true;
        gridOrden.Columns[26].Visible = true;
        gridOrden.Columns[27].Visible = true;
        gridOrden.Columns[28].Visible = true;
        gridOrden.Columns[29].Visible = true;
        gridOrden.Columns[30].Visible = true;
        gridOrden.Columns[31].Visible = true;


        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_rutem", OracleType.NVarChar, ParameterDirection.Input, PRO.recSession(rutaXml, "RUT_EMPRESA"));
        PRO.agrega_parametro_sp(da, "i_servicio", OracleType.NVarChar, ParameterDirection.Input, servicio);


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
        dt.Columns.Add(new DataColumn("ID_ORDEN", typeof(Int32)));
        dt.Columns.Add(new DataColumn("NUMERO_ORDEN", typeof(Int64)));
        dt.Columns.Add(new DataColumn("ID_SERVICIO", typeof(String)));
        dt.Columns.Add(new DataColumn("LECTURA_RET", typeof(Int32)));
        dt.Columns.Add(new DataColumn("DIAMETRO_MEDIDOR", typeof(Int32)));
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
        dt.Columns.Add(new DataColumn("FECHA_CREACION", typeof(DateTime)));
        dt.Columns.Add(new DataColumn("FECHA_INST", typeof(DateTime)));
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
        dt.Columns.Add(new DataColumn("SERIE_MEDIDOR", typeof(String)));
        dt.Columns.Add(new DataColumn("FABRICANTE", typeof(String)));
        dt.Columns.Add(new DataColumn("CONTRATISTA", typeof(String)));



        DataRow dr;

        int total = 0;

        foreach (DataRow drOrdenItem in dtOrdenes.Rows)
        {

            dr = dt.NewRow();
            dr["ID_ORDEN"] = drOrdenItem["ID_ORDEN"].ToString();
            dr["NUMERO_ORDEN"] = drOrdenItem["NUMERO_ORDEN"].ToString();
            dr["ID_SERVICIO"] = drOrdenItem["ID_SERVICIO"].ToString();
            dr["LECTURA_RET"] = drOrdenItem["LECTURA_RET"].ToString();
            dr["DIAMETRO_MEDIDOR"] = drOrdenItem["DIAMETRO_MEDIDOR"].ToString();
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
            dr["SERIE_MEDIDOR"] = drOrdenItem["SERIE_MEDIDOR"].ToString();
            dr["FABRICANTE"] = drOrdenItem["FABRICANTE"].ToString();
            dr["CONTRATISTA"] = drOrdenItem["CONTRATISTA"].ToString();

            dt.Rows.Add(dr);

            total = total + 1;

            txtCliente.Text = dr["CLIENTE"].ToString();
            txtDireccion.Text = dr["DIRECCION"].ToString();
            txtMedidor.Text = dr["NUMERO_MN"].ToString();
            txtDiametro.Text = dr["DIAMETRO_MEDIDOR"].ToString();
            txtMarca.Text = dr["MARCA"].ToString();
            txtLocalidad.Text = dr["LOCALIDAD"].ToString();
            txtRuta.Text = dr["RUTA"].ToString();
            txtMedidor.Text = dr["SERIE_MEDIDOR"].ToString();
            txtMarca.Text = dr["FABRICANTE"].ToString();
            txtContratista.Text = dr["CONTRATISTA"].ToString();
        }
               


    }

    public void carga_grilla(String servicio)
    {
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_ORDEN.CARGAR_HISTORICO2", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";

        gridOrden.Columns[26].Visible = true;
        gridOrden.Columns[27].Visible = true;
        gridOrden.Columns[28].Visible = true;
        gridOrden.Columns[29].Visible = true;
        gridOrden.Columns[30].Visible = true;
        gridOrden.Columns[31].Visible = true;
        gridOrden.Columns[32].Visible = true;
        gridOrden.Columns[33].Visible = true;

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_rutem", OracleType.NVarChar, ParameterDirection.Input, PRO.recSession(rutaXml, "RUT_EMPRESA"));
        PRO.agrega_parametro_sp(da, "i_valor", OracleType.NVarChar, ParameterDirection.Input, servicio);

        if (RadioButton1.Checked)
        {
            PRO.agrega_parametro_sp(da, "i_tipo", OracleType.NVarChar, ParameterDirection.Input, "1");
        }
        if (RadioButton2.Checked)
        {
            PRO.agrega_parametro_sp(da, "i_tipo", OracleType.NVarChar, ParameterDirection.Input, "2");
        }

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
        dt.Columns.Add(new DataColumn("ID_ORDEN", typeof(String)));
        dt.Columns.Add(new DataColumn("NUMERO_ORDEN", typeof(String)));
        dt.Columns.Add(new DataColumn("ID_SERVICIO", typeof(String)));
        dt.Columns.Add(new DataColumn("LECTURA_RET", typeof(String)));
        dt.Columns.Add(new DataColumn("DIAMETRO_RET", typeof(String)));
        dt.Columns.Add(new DataColumn("ANO_MN", typeof(String)));
        dt.Columns.Add(new DataColumn("NUMERO_MN", typeof(String)));
        dt.Columns.Add(new DataColumn("DIAMETRO_NU", typeof(String)));
        dt.Columns.Add(new DataColumn("LECTURA_MN", typeof(String)));
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
        dt.Columns.Add(new DataColumn("ID_TIPO_PROCESO", typeof(String)));
        dt.Columns.Add(new DataColumn("DETALLE", typeof(String)));
        dt.Columns.Add(new DataColumn("COD_IMPROCEDENCIA", typeof(String)));
        dt.Columns.Add(new DataColumn("DIAMETRO_MEDIDOR", typeof(String)));
        dt.Columns.Add(new DataColumn("FABRICANTE", typeof(String)));
        dt.Columns.Add(new DataColumn("SERIE_MEDIDOR", typeof(String)));
        dt.Columns.Add(new DataColumn("ID_SINCRONIZACION", typeof(String)));
        dt.Columns.Add(new DataColumn("OBSERVACION_IN", typeof(String)));
        dt.Columns.Add(new DataColumn("VISITA", typeof(String)));
        dt.Columns.Add(new DataColumn("CONTRATISTA", typeof(String)));


        DataRow dr;

        int total = 0;

        foreach (DataRow drOrdenItem in dtOrdenes.Rows)
        {

            dr = dt.NewRow();

            if (drOrdenItem["COD_IMPROCEDENCIA"].ToString().Equals("24") || drOrdenItem["COD_IMPROCEDENCIA"].ToString().Equals("25"))
            {               
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
                dr["DIAMETRO_MEDIDOR"] = drOrdenItem["DIAMETRO_MEDIDOR"].ToString();
                dr["FABRICANTE"] = drOrdenItem["FABRICANTE"].ToString();
                dr["SERIE_MEDIDOR"] = drOrdenItem["SERIE_MEDIDOR"].ToString();
                dr["ID_SINCRONIZACION"] = drOrdenItem["ID_SINCRONIZACION"].ToString();
                dr["OBSERVACION_IN"] = drOrdenItem["OBSERVACION_IN"].ToString();
                dr["VISITA"] = drOrdenItem["VISITA"].ToString();
                dr["CONTRATISTA"] = drOrdenItem["CONTRATISTA"].ToString();
            }
            else {

                dr["ID_ORDEN"] = drOrdenItem["ID_ORDEN"].ToString();
                dr["NUMERO_ORDEN"] = drOrdenItem["NUMERO_ORDEN"].ToString();
                dr["ID_SERVICIO"] = drOrdenItem["ID_SERVICIO"].ToString();
                dr["LECTURA_RET"] = "";
                dr["DIAMETRO_RET"] = "";
                dr["ANO_MN"] = "";
                dr["NUMERO_MN"] = "";
                dr["DIAMETRO_NU"] = "";
                dr["LECTURA_MN"] = "";
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
                dr["VARAL_ESTATUS"] = "";
                dr["LLAVE_ESTATUS"] = "";
                dr["CAMBIO_CAUSA"] = drOrdenItem["CAMBIO_CAUSA"].ToString();
                dr["NOMBRE"] = drOrdenItem["NOMBRE"].ToString();
                dr["ID_PROCESO"] = drOrdenItem["ID_PROCESO"].ToString();
                dr["GRUPO_PROCESO"] = drOrdenItem["GRUPO_PROCESO"].ToString();
                dr["ID_TIPO_PROCESO"] = drOrdenItem["ID_TIPO_PROCESO"].ToString();
                dr["DETALLE"] = drOrdenItem["DETALLE"].ToString();
                dr["DIAMETRO_MEDIDOR"] = drOrdenItem["DIAMETRO_MEDIDOR"].ToString();
                dr["FABRICANTE"] = drOrdenItem["FABRICANTE"].ToString();
                dr["SERIE_MEDIDOR"] = drOrdenItem["SERIE_MEDIDOR"].ToString();
                dr["ID_SINCRONIZACION"] = drOrdenItem["ID_SINCRONIZACION"].ToString();
                dr["OBSERVACION_IN"] = drOrdenItem["OBSERVACION_IN"].ToString();
                dr["VISITA"] = drOrdenItem["VISITA"].ToString();
                dr["CONTRATISTA"] = drOrdenItem["CONTRATISTA"].ToString();
            }

 
          
            dt.Rows.Add(dr);

            total = total + 1;

            txtCliente.Text = dr["CLIENTE"].ToString();
            txtDireccion.Text = dr["DIRECCION"].ToString();
            txtMedidor.Text = dr["NUMERO_MN"].ToString();
            txtDiametro.Text = dr["DIAMETRO_MEDIDOR"].ToString();
            txtMarca.Text = dr["MARCA"].ToString();
            txtLocalidad.Text = dr["LOCALIDAD"].ToString();
            txtRuta.Text = dr["RUTA"].ToString();
            txtMedidor.Text = dr["SERIE_MEDIDOR"].ToString();
            txtContratista.Text = dr["CONTRATISTA"].ToString();

           
        }

        DataView MydataView;
        MydataView = new DataView(dt);
        gridOrden.DataSource = MydataView;
        gridOrden.DataBind();

        int c;
        GridViewRow gvRow;
        HyperLink hlMapa = new HyperLink();
        HyperLink hlDet = new HyperLink();
        Image ok = new Image();
        Image nOk = new Image();
        ImageButton det = new ImageButton();
        ImageButton mapa = new ImageButton();

        String LON;
        String LAT; 


        for (c = 0; c < gridOrden.Rows.Count; c++)
        {
            /// seteo lat y long       
            gvRow = gridOrden.Rows[c];
            mapa = (ImageButton)(gvRow.FindControl("btMapa"));

            LON = gvRow.Cells[32].Text;
            LAT = gvRow.Cells[31].Text;

            mapa.Attributes.Add("onclick", "javascript:PopMapa(" + LAT + "," + LON + ")");


            //hlMapa.NavigateUrl = "http://maps.googleapis.com/maps/api/staticmap?c&zoom=18&size=1600x600&maptype=roadmap&markers=color:blue%7Clabel:S%7C" + LAT + "," + LON + "&&sensor=false";

            /// fin seteo lat y long     

            ///verifica foto

            String serv = gvRow.Cells[29].Text;
            String di = gvRow.Cells[28].Text;
            String gru = gvRow.Cells[2].Text;
            String op = gvRow.Cells[26].Text;
            String vi = gvRow.Cells[0].Text;

            ///inicio detalle

            //det = (ImageButton)(gvRow.FindControl("btDet"));

            //det.Attributes.Add("onclick", "javascript:PopDetalles(" + txtServ.Text + "," + gru + ")");


            ///fin detalle

            Boolean foto=verificaFoto(di, serv, op,vi);
            
            ok = (Image)(gvRow.FindControl("imgOk"));
            nOk = (Image)(gvRow.FindControl("imgCru"));

            if (foto == true)
            {
                ok.Visible = true;
                nOk.Visible = false;
            }
            else
            {
                ok.Visible = false;
                nOk.Visible = true;
            }

            ///fin verifica foto
            
            

        }

        lbTotal.Text = total + " registro(s) encontrado(s)";

        
        gridOrden.Columns[26].Visible = false;
        gridOrden.Columns[27].Visible = false;
        gridOrden.Columns[28].Visible = false;
        gridOrden.Columns[29].Visible = false;
        gridOrden.Columns[30].Visible = false;
        gridOrden.Columns[31].Visible = false;
        gridOrden.Columns[32].Visible = false;
        gridOrden.Columns[33].Visible = false;
       
    }

    protected void gridOrden_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridOrden.PageIndex = e.NewPageIndex;
        carga_grilla(txtServ.Text);
    
    }
    
    protected void gridOrden_SelectedIndexChanged(object sender, EventArgs e)
    {
        servicio = gridOrden.SelectedRow.Cells[29].Text;
        id = gridOrden.SelectedRow.Cells[28].Text;
        grupo = gridOrden.SelectedRow.Cells[2].Text;
        operador = gridOrden.SelectedRow.Cells[26].Text;
        visita = gridOrden.SelectedRow.Cells[0].Text;
        String send = sender.ToString();
        String vtn = "window.open('popVisorFotos.aspx?servicio=" + servicio + "&id=" + id + "&operador=" + operador + "&grupo=" + grupo + "&visita=" + visita + "','Dates','scrollbars=yes,resizable=yes,height=675,width=1270')";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", vtn, true);

    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        //carga_clinte(txtServ.Text);
        carga_grilla(txtServ.Text);
    }


    public Boolean verificaFoto(String di,String serv,String op,String vi)
    {
	
        String CARPETA_FOTOS = "FOTOS";

        String ruta_directorio;
        String ruta_directorioVisita;
   
        String[] arrArchivosFotos;
        String[] arrArchivosFotosVisita;
 
        FileInfo[] MisFicheros;
        FileInfo[] MisFicherosVisita;
       
        Boolean ex = false;

        String fotoA = di + "A" + serv + "A" + op + "A";
        String fotoVisita = di + "A" + serv + "A" + op + "A" + vi + "A";

        ruta_directorio = Server.MapPath("./FOTOS/");
        ruta_directorioVisita = Server.MapPath("./FOTOS/"+ vi +"/");
        
        arrArchivosFotos = Directory.GetFiles(Server.MapPath("./" + CARPETA_FOTOS + "/"), "*" + fotoA + "*");
        arrArchivosFotosVisita = Directory.GetFiles(Server.MapPath("./" + CARPETA_FOTOS + "/"+ vi +"/"), "*" + fotoVisita + "*");
       
        MisFicheros = new DirectoryInfo(ruta_directorio).GetFiles("*" + fotoA + "*");
        MisFicherosVisita = new DirectoryInfo(ruta_directorioVisita).GetFiles("*" + fotoVisita + "*");
                       
        //String fotoN = di + "A" + serv + "A" + op + "_N.jpg";
        //String fotoE = di + "A" + serv + "A" + op + "_E.jpg";

        for (int i = 0; i < MisFicheros.Length; i++)
        {
            String arch = MisFicheros[i].Name;
            String nam = MisFicheros[i].FullName.Replace(Server.MapPath(""), "~");

            if (arch.Contains(fotoA))
            {
                ex = true;
            }

        }

        if (ex.Equals(false) )
        {
            for (int i = 0; i < MisFicherosVisita.Length; i++)
            {
                String arch = MisFicherosVisita[i].Name;
                String nam = MisFicherosVisita[i].FullName.Replace(Server.MapPath(""), "~");

                if (arch.Contains(fotoVisita))
                {
                    ex = true;
                }
           
            }
        }

        
  
        return ex;

    }

    protected void txtRuta_TextChanged(object sender, EventArgs e)
    {

    }
   
    protected void gridOrden_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int index = e.RowIndex;

        visita = gridOrden.Rows[index].Cells[0].Text;
        orden = gridOrden.Rows[index].Cells[1].Text;
        servicio = gridOrden.Rows[index].Cells[29].Text;
        id = gridOrden.Rows[index].Cells[28].Text;
        atendido = gridOrden.Rows[index].Cells[15].Text;
        //grupo = gridOrden.Rows[index].Cells[1].Text;
        //operador = gridOrden.Rows[index].Cells[24].Text;
        if (atendido.Equals("")) atendido = "2";
        else atendido = "1";


        String vtn = "window.open('InformeComercial.aspx?Servicio=" + servicio + "&orden=" + orden + "&pr=" + id + "&visita=" + visita + "&atendido=" + atendido + "','Dates','scrollbars=yes,resizable=yes,height=500,width=840')";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", vtn, true);
    }
    protected void RadioButton1_CheckedChanged(object sender, EventArgs e)
    {
        if (RadioButton1.Checked)
        {
            RadioButton2.Checked = false;
        }
    }
    protected void RadioButton2_CheckedChanged(object sender, EventArgs e)
    {
        if (RadioButton2.Checked)
        {
            RadioButton1.Checked = false;
        }
    }
    protected void gridOrden_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Int32 estado = Int32.Parse(DataBinder.Eval(e.Row.DataItem, "ID_SINCRONIZACION").ToString());

            if (estado <= 4)
            {
                e.Row.BackColor = System.Drawing.Color.Yellow;
            }

        }
    }
}