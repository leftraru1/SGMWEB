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

public partial class GeneradorRepaso : System.Web.UI.Page
{
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];
    Procedimientos PRO = new Procedimientos();

    protected void ddZona_SelectedIndexChanged(object sender, EventArgs e)
    {
        tdSalida.InnerHtml = "";
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";


        carga_localidad(int.Parse(ddZona.SelectedValue));
        carga_Grupo(ddRegion.SelectedValue.ToString(), ddZona.SelectedValue.ToString(), ddLocalidad.SelectedValue.ToString(), PRO.recSession(rutaXml, "RUT_EMPRESA"));
        
    }

    protected void ddLocalidad_SelectedIndexChanged(object sender, EventArgs e)
    {
        tdSalida.InnerHtml = "";
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";



        carga_Grupo(ddRegion.SelectedValue.ToString(), ddZona.SelectedValue.ToString(), ddLocalidad.SelectedValue.ToString(), PRO.recSession(rutaXml, "RUT_EMPRESA"));
        
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

            try
            {
              


                    String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
                    PRO.recSession(rutaXml, "RUT_EMPRESA");


                    carga_region();



                    carga_zona(ddRegion.SelectedValue.ToString());
                    carga_localidad(int.Parse(ddZona.SelectedValue));
                    carga_Grupo(ddRegion.SelectedValue.ToString(), ddZona.SelectedValue.ToString(), ddLocalidad.SelectedValue.ToString(), PRO.recSession(rutaXml, "RUT_EMPRESA"));
                 





            }
            catch (Exception ex)
            {
                Response.Redirect("errorSesion.aspx");
            }



        }
    }

    public void carga_grilla(String idProceso)
    {
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_ORDEN.CARGA_ORDENES_REPASO", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";

        PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(da, "i_rutEmpresa", OracleType.Int32, ParameterDirection.Input, PRO.recSession(rutaXml, "RUT_EMPRESA"));
        PRO.agrega_parametro_sp(da, "i_idProceso", OracleType.Int32, ParameterDirection.Input, idProceso);

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
            CnOra.Close();
            CnOra.Dispose();

            lbResultado.ForeColor = System.Drawing.Color.Red;

            lbResultado.Text = ex.ToString();

            return;
        }

        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("ID_SERVICIO", typeof(String)));
        dt.Columns.Add(new DataColumn("DESCRIPCION", typeof(String)));
        dt.Columns.Add(new DataColumn("INSTALADOR", typeof(String)));
        dt.Columns.Add(new DataColumn("FECHA_IN_MN", typeof(String)));
        dt.Columns.Add(new DataColumn("HORA_EJECUCION", typeof(String)));
        dt.Columns.Add(new DataColumn("CLIENTE", typeof(String)));
        dt.Columns.Add(new DataColumn("DIRECCION", typeof(String)));
        dt.Columns.Add(new DataColumn("OBSERVACION_OUT", typeof(String)));



        DataRow dr;

        int total = 0;

        foreach (DataRow drOrdenItem in dtOrdenes.Rows)
        {

            dr = dt.NewRow();


            dr["ID_SERVICIO"] = drOrdenItem["ID_SERVICIO"].ToString();
            dr["DESCRIPCION"] = drOrdenItem["DESCRIPCION"].ToString();
            dr["INSTALADOR"] = drOrdenItem["INSTALADOR"].ToString();
            dr["FECHA_IN_MN"] = drOrdenItem["FECHA_IN_MN"].ToString();
            dr["HORA_EJECUCION"] = drOrdenItem["HORA_EJECUCION"].ToString();
            dr["CLIENTE"] = drOrdenItem["CLIENTE"].ToString();
            dr["DIRECCION"] = drOrdenItem["DIRECCION"].ToString();
            dr["OBSERVACION_OUT"] = drOrdenItem["OBSERVACION_OUT"].ToString();
               


            dt.Rows.Add(dr);

            total = total + 1;

          


        }

        DataView MydataView;
        MydataView = new DataView(dt);
        gridRepaso.DataSource = MydataView;
        gridRepaso.DataBind();


        lbTotal.ForeColor = System.Drawing.Color.Black;


        lbTotal.Text = total + " registro(s) encontrado(s)";


       

    }



    public void generaRepaso()
    {

        Int32 c;

        GridViewRow gvRow;
       

        CheckBox check_marca = new CheckBox();
 
                                 

        for (c = 0; c < gridRepaso.Rows.Count; c++)
        {

            gvRow = gridRepaso.Rows[c];

            check_marca = (CheckBox)(gvRow.FindControl("check_marcar"));

            if ((check_marca.Checked == true))
            {

                OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
                OracleCommand cmdAcceso = new OracleCommand("PK_ORDEN.GENERA_REPASO", CnOra);
                OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
                String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";

                PRO.agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
                PRO.agrega_parametro_sp(da, "i_rutEmpresa", OracleType.Int32, ParameterDirection.Input, PRO.recSession(rutaXml, "RUT_EMPRESA"));
                PRO.agrega_parametro_sp(da, "i_idProceso", OracleType.Int32, ParameterDirection.Input, ddGrupo.SelectedValue.ToString());
                PRO.agrega_parametro_sp(da, "i_servicio", OracleType.Int32, ParameterDirection.Input, gridRepaso.Rows[c].Cells[0].Text);

                da.SelectCommand.CommandType = CommandType.StoredProcedure;


                try
                {
                    CnOra.Open();

                    da.SelectCommand.ExecuteNonQuery();

                    CnOra.Close();
                    CnOra.Dispose();




                }
                catch (Exception ex)
                {
                    CnOra.Close();
                    CnOra.Dispose();

                    //lbResultado.ForeColor = System.Drawing.Color.Red;
                    //lbResultado.Text = ex.ToString();


                }

                lbResultado.ForeColor = System.Drawing.Color.Blue;
                lbResultado.Text = "REPASOS GENERADOS EXITOSAMENTE";


            }
         

        }

       




    }

    public void carga_Grupo(String region, String zona, String localidad, String empresa)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_PROCESO.CARGAR_GRUPO_REPASO", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_rutEmpresa", OracleType.Number, ParameterDirection.Input, empresa);
        PRO.agrega_parametro_sp(objComando, "i_idRegion", OracleType.Int32, ParameterDirection.Input, region);
        PRO.agrega_parametro_sp(objComando, "i_idZona", OracleType.Int32, ParameterDirection.Input, zona);
        PRO.agrega_parametro_sp(objComando, "i_idLocalidad", OracleType.Int32, ParameterDirection.Input, localidad);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "GRUPO");
        objConexion.Close();

        int i = 1;
        ddGrupo.Items.Clear();
        ddGrupo.Items.Add("Todos...");
        ddGrupo.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["GRUPO"].Rows)
        {

            ddGrupo.Items.Add(row[1].ToString() + " - " + row[2].ToString() + " - " + row[3].ToString());
            ddGrupo.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }

    public void carga_localidad(int zona)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_LOCALIDAD.CARGA_LOCALIDAD_SALIDA", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_zona", OracleType.Int32, ParameterDirection.Input, zona.ToString());


        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "LOCALIDAD");
        objConexion.Close();

        int i = 1;
        ddLocalidad.Items.Clear();
        ddLocalidad.Items.Add("Todas...");
        ddLocalidad.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["LOCALIDAD"].Rows)
        {

            ddLocalidad.Items.Add(row[1].ToString());
            ddLocalidad.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }


    public void carga_zona(String region)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_ZONA.CARGAR_ZONA_SALIDA", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        PRO.agrega_parametro_sp(objComando, "i_idRegion", OracleType.Int32, ParameterDirection.Input, region);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "ZONA");
        objConexion.Close();

        int i = 1;
        ddZona.Items.Clear();
        ddZona.Items.Add("Todas...");
        ddZona.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["ZONA"].Rows)
        {

            ddZona.Items.Add(row[1].ToString());
            ddZona.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }

    public void carga_region()
    {
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";
        String rutRegion = PRO.recSession(rutaXml, "RUT_EMPRESA");


        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_ZONA.CARGAR_REGION_SALIDA", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        PRO.agrega_parametro_sp(objComando, "i_rutEmpresa", OracleType.Number, ParameterDirection.Input, rutRegion);

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "REGION");
        objConexion.Close();

        int i = 1;
        ddRegion.Items.Clear();
        ddRegion.Items.Add("Todas...");
        ddRegion.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["REGION"].Rows)
        {

            ddRegion.Items.Add(row[1].ToString());
            ddRegion.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }

    public void carga_Grupo()
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        OracleDataAdapter objComando;
        DataSet objDS = new DataSet();

        objConexion.Open();
        objComando = new OracleDataAdapter("PK_PROCESO.CARGAR_GRUPO", objConexion);
        objComando.SelectCommand.CommandType = CommandType.StoredProcedure;

        PRO.agrega_parametro_sp(objComando, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");

        objComando.SelectCommand.ExecuteNonQuery();
        objComando.Fill(objDS, "GRUPO");
        objConexion.Close();

        int i = 1;
        ddGrupo.Items.Clear();
        ddGrupo.Items.Add("Todos...");
        ddGrupo.Items[0].Value = "0";

        foreach (DataRow row in objDS.Tables["GRUPO"].Rows)
        {

            ddGrupo.Items.Add(row[1].ToString() + " - " + row[14].ToString() + " - " + row[7].ToString());
            ddGrupo.Items[i].Value = row[0].ToString();
            i = i + 1;

        }
    }

    protected void ddRegion_SelectedIndexChanged(object sender, EventArgs e)
    {
        tdSalida.InnerHtml = "";
        String rutaXml = Server.MapPath("./sessiones/") + "usuario_" + Session.SessionID + ".xml";

        carga_zona(ddRegion.SelectedValue.ToString());
        carga_localidad(int.Parse(ddZona.SelectedValue));
        carga_Grupo(ddRegion.SelectedValue.ToString(), ddZona.SelectedValue.ToString(), ddLocalidad.SelectedValue.ToString(), PRO.recSession(rutaXml, "RUT_EMPRESA"));
       
    }
    protected void ddGrupo_SelectedIndexChanged(object sender, EventArgs e)
    {
        
        carga_grilla(ddGrupo.SelectedValue.ToString());       


    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        generaRepaso();
        carga_grilla(ddGrupo.SelectedValue.ToString());    
    }
    protected void gridRepaso_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "marcar")
        {
            checkTodos("check_marcar");
        }

      
    }

    public void checkTodos(String check)
    {
        int c;

        GridViewRow gvRow;
        CheckBox check_row = new CheckBox();
        for (c = 0; c < gridRepaso.Rows.Count; c++)
        {

            gvRow = gridRepaso.Rows[c];
            check_row = (CheckBox)(gvRow.FindControl(check));



            if ((check_row.Enabled == true))
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
    protected void marcar(object sender, CommandEventArgs e)
    {

    }
}