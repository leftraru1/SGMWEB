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

/// <summary>
/// Descripción breve de Procedimientos
/// </summary>
public class Procedimientos
{
    String estado, id_perfil, nombre, id_usuario, mIP, mEquipo, winSession, descripcion, url, fecha, ser;
    IPAddress oAddr;
    String conexion_cliente_oracle = ConfigurationManager.AppSettings["ConnectionString_ClienteOracle"];


	public Procedimientos()
	{
		
	}

    public String recSession(String ruta, String nodo)
    {

        XmlDataDocument recupera_xml = new XmlDataDocument();

        recupera_xml.Load(ruta);

        
        return recupera_xml.SelectSingleNode("SESSION/DATOS_USUARIO/" + nodo).InnerText;

    }

    public String existeInstalador(String cod,String rut)
    {

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_INSTALADOR.VALIDA_INSTALADOR_EXISTE", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

        agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        agrega_parametro_sp(da, "i_cod_instalador", OracleType.NVarChar, ParameterDirection.Input, cod);
        agrega_parametro_sp(da, "i_rut_empresa", OracleType.Number, ParameterDirection.Input, rut);


        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        CnOra.Open();
        DataSet dsCatastros = new DataSet();
        da.Fill(dsCatastros, "INSTALADOR");
        CnOra.Close();
        CnOra.Dispose();

        if (dsCatastros.Tables["INSTALADOR"].Rows.Count != 0)
        {
            return "OK";
        }
        else
        {
            
            return "Instalado no registrado.";
        }
    
    }

    public void agrega_parametro_sp(OracleDataAdapter da, String parametro, OracleType par_tipo,ParameterDirection p_direccion,String valor)
    {
        //parametro procedimiento almacenado
        OracleParameter workParam1 = new OracleParameter(parametro, par_tipo);
        workParam1.Direction = p_direccion;
        workParam1.Value = valor;
        da.SelectCommand.Parameters.Add(workParam1);
        //parametro procedimiento almacenado
    }

    public void Insertamos_log(String SESSION,String PERFIL,String USUARIO,String URL,String FECHA,String NOMBRE_EQUIPO,String NOMBRE_CUENTA_EQUIPO,String P_IP,String DESCRIPCION)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        objConexion.Open();

        OracleDataAdapter ComandoDA;
        ComandoDA = new OracleDataAdapter("INSERTA_LOG_SESSION", objConexion);
        ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

        agrega_parametro_sp(ComandoDA, "i_session", OracleType.NVarChar, ParameterDirection.Input, SESSION);
        agrega_parametro_sp(ComandoDA, "i_perfil", OracleType.NVarChar, ParameterDirection.Input, PERFIL);
        agrega_parametro_sp(ComandoDA, "i_usuario", OracleType.NVarChar, ParameterDirection.Input, USUARIO);
        agrega_parametro_sp(ComandoDA, "i_url", OracleType.NVarChar, ParameterDirection.Input, URL);
        agrega_parametro_sp(ComandoDA, "i_fecha", OracleType.DateTime, ParameterDirection.Input, FECHA);
        agrega_parametro_sp(ComandoDA, "i_nombre_equipo", OracleType.NVarChar, ParameterDirection.Input, NOMBRE_EQUIPO);
        agrega_parametro_sp(ComandoDA, "i_nombre_cuenta", OracleType.NVarChar, ParameterDirection.Input, NOMBRE_CUENTA_EQUIPO);
        agrega_parametro_sp(ComandoDA, "i_ip", OracleType.NVarChar, ParameterDirection.Input, P_IP);
        agrega_parametro_sp(ComandoDA, "i_descripcion", OracleType.NVarChar, ParameterDirection.Input, DESCRIPCION);

        try
        {
            ComandoDA.SelectCommand.ExecuteNonQuery();
            objConexion.Close();
            objConexion.Dispose();
        }
        catch(Exception ex)
        {
            ex.Message.ToString();
            objConexion.Close();
            objConexion.Dispose();
        }

    }

    //Insertamos log de recepción de proceso.
    public void Insertamos_log_proceso(String archivo, String desc,String duplicados, String errores, String cargados,String estado,String id_proceso,String rut_empresa,String grupo_proceso, String usuario)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        objConexion.Open();
       
        OracleDataAdapter ComandoDA;
        ComandoDA = new OracleDataAdapter("PK_LOG.INSERTA_LOG_PROCESO", objConexion);
        ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

        agrega_parametro_sp(ComandoDA, "i_archivo", OracleType.NVarChar, ParameterDirection.Input, archivo);
        agrega_parametro_sp(ComandoDA, "i_desc", OracleType.NVarChar, ParameterDirection.Input, desc);
        agrega_parametro_sp(ComandoDA, "i_duplicados", OracleType.Number, ParameterDirection.Input, duplicados);
        agrega_parametro_sp(ComandoDA, "i_errores", OracleType.Number, ParameterDirection.Input, errores);
        agrega_parametro_sp(ComandoDA, "i_cargados", OracleType.Number, ParameterDirection.Input, cargados);
        agrega_parametro_sp(ComandoDA, "i_estado", OracleType.Number, ParameterDirection.Input, estado);
        agrega_parametro_sp(ComandoDA, "i_fecha", OracleType.DateTime, ParameterDirection.Input, DateTime.Now.ToString("dd/MM/yyyy"));
        agrega_parametro_sp(ComandoDA, "i_id_proceso", OracleType.Number, ParameterDirection.Input, id_proceso );
        agrega_parametro_sp(ComandoDA, "i_rutempresa", OracleType.NVarChar, ParameterDirection.Input, rut_empresa);
        agrega_parametro_sp(ComandoDA, "i_grupoproceso", OracleType.NVarChar, ParameterDirection.Input, grupo_proceso);
        agrega_parametro_sp(ComandoDA, "i_usuario", OracleType.NVarChar, ParameterDirection.Input, usuario);

        if (int.Parse(estado) == 3)
        {
            actualizar_proceso_fallido(id_proceso); //deja proceso como fallido, para que no sea considerado a la hora de llamar grupos de proceso.
        }
        try
        {
            ComandoDA.SelectCommand.ExecuteNonQuery();
            objConexion.Close();
            objConexion.Dispose();
            
        }
        catch (Exception ex)
        {
            ex.Message.ToString();
            objConexion.Close();
            objConexion.Dispose();
        }

    }

    public void actualizar_proceso_fallido(String id_proceso)
    {
         OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
                    objConexion.Open();
                    OracleDataAdapter ComandoDA = null;
                    ComandoDA = new OracleDataAdapter("PK_LOG.ACTUALIZAR_PROCESO_FALLIDO", objConexion);

                    ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

                    agrega_parametro_sp(ComandoDA, "i_id_proceso", OracleType.Int32, ParameterDirection.Input, id_proceso);


                    try
                    {
                        ComandoDA.SelectCommand.ExecuteNonQuery();
                        objConexion.Close();
                        objConexion.Dispose();
                    }
                    catch (Exception ex)
                    {
                        ex.Message.ToString();
                        objConexion.Close();
                        objConexion.Dispose();
                    }
    }




    //Insertamos lod de detalle de integración de proceso.
    public void Insertamos_log_detalle(String ORDEN, String SERVICIO, String ID_PROCESO, String MENSAJE)
    {
        OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
        objConexion.Open();

        OracleDataAdapter ComandoDA;
        ComandoDA = new OracleDataAdapter("PK_LOG.INSERTA_LOG_DETALLE", objConexion);
        ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;

        agrega_parametro_sp(ComandoDA, "i_numero_orden", OracleType.NVarChar, ParameterDirection.Input, ORDEN);
        agrega_parametro_sp(ComandoDA, "i_id_servicio", OracleType.NVarChar, ParameterDirection.Input, SERVICIO);
        agrega_parametro_sp(ComandoDA, "i_id_proceso", OracleType.NVarChar, ParameterDirection.Input, ID_PROCESO);
        agrega_parametro_sp(ComandoDA, "i_mensaje_error", OracleType.NVarChar, ParameterDirection.Input, MENSAJE);

        try
        {
            ComandoDA.SelectCommand.ExecuteNonQuery();
            objConexion.Close();
            objConexion.Dispose();
        }
        catch (Exception ex)
        {
            ex.Message.ToString();
            objConexion.Close();
            objConexion.Dispose();
        }

    }

    //OBTENEMOS ID DE PROCESO DE ACUERDO A NOMBRE DE ARCHIVO (SUPONIENDO QUE ES ÚNICO EL NOMBRE DE ARCHIVO).
    public int OBTIENE_ID_PROCESO(String archivo)
    {
        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_LOG.OBTIENE_ID_PROCESO", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
        int valor = 0;
        agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        agrega_parametro_sp(da, "i_archivo", OracleType.NVarChar, ParameterDirection.Input, archivo);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        CnOra.Open();
        DataSet objDS = new DataSet();
        da.Fill(objDS, "obtiene_id_proceso");
        CnOra.Close();
        CnOra.Dispose();


        foreach (DataRow dr in objDS.Tables["obtiene_id_proceso"].Rows)
        {
            valor = int.Parse(dr["id_proceso"].ToString());
        }
        return valor;

    }

    
    public void EnviarAlerta(String ruta,String SESSION,String PERFIL,String USUARIO,String URL,String FECHA,String NOMBRE_EQUIPO,String NOMBRE_CUENTA_EQUIPO,String P_IP,String DESCRIPCION)
    {
        String user, pass, server, puerto, ssl, lto, cc, nombre, asunto, cuerpoHTML;
        server = ConfigurationManager.AppSettings["server"];
        puerto = ConfigurationManager.AppSettings["puerto"];
        ssl = ConfigurationManager.AppSettings["ssl"];
        user = ConfigurationManager.AppSettings["user"];
        pass = ConfigurationManager.AppSettings["pass"];
        nombre = ConfigurationManager.AppSettings["nombre"];
        lto = ConfigurationManager.AppSettings["lista_correoTO"];
        cc = ConfigurationManager.AppSettings["lista_correoCC"];
        asunto = ConfigurationManager.AppSettings["asunto"];
        miCorreo.Servidor Scorreo = new miCorreo.Servidor(server, int.Parse(puerto), user, pass, Convert.ToBoolean(ssl));

        miCorreo.Correo correos = new miCorreo.Correo();
        correos.AgregarTO(lto);
        String[] listacc;
        listacc = cc.Split(';');

        for(int x=0;x<listacc.Length;x++)
        {
            correos.AgregarCC(listacc[x]);
        }

        correos.Titulo(asunto);
        correos.esHTML(true);
        cuerpoHTML = File.ReadAllText(ruta);
        cuerpoHTML = cuerpoHTML.Replace("[NOMBRESESION]", SESSION);
        cuerpoHTML = cuerpoHTML.Replace("[PERFIL]", PERFIL);
        cuerpoHTML = cuerpoHTML.Replace("[ID USUARIO]", USUARIO);
        cuerpoHTML = cuerpoHTML.Replace("[NOMBRE LINK]", URL);
        cuerpoHTML = cuerpoHTML.Replace("[FECHA]", FECHA);
        cuerpoHTML = cuerpoHTML.Replace("[NOMBRE EQUIPO]", NOMBRE_EQUIPO);
        cuerpoHTML = cuerpoHTML.Replace("[NOMBRE CUENTA]", NOMBRE_CUENTA_EQUIPO);
        cuerpoHTML = cuerpoHTML.Replace("[IP EQUIPO]", P_IP);
        cuerpoHTML = cuerpoHTML.Replace("[DESCRIPCION]", DESCRIPCION);
        correos.Cuerpo(cuerpoHTML);
        Scorreo.EnviarCorreo(correos, nombre);
   

    }
         
        

    public void inserta_log_sistema(String P_ID_USUARIO,String P_RUT_EMPRESA,String P_FECHA,String P_HORA,String P_DESCRIPCION_EVENTO,String P_ID_GRUPOPROCESO,String P_ID_LOCALIDAD,String P_IP)
    {
        OracleConnection objConexion=new OracleConnection(conexion_cliente_oracle);
        objConexion.Open();

        OracleDataAdapter ComandoDA;
        ComandoDA = new OracleDataAdapter("INSERTA_LOG", objConexion);
        ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;
        agrega_parametro_sp(ComandoDA, "i_id_usuario", OracleType.Int32, ParameterDirection.Input, P_ID_USUARIO);
        agrega_parametro_sp(ComandoDA, "i_rut_empresa", OracleType.Number, ParameterDirection.Input, P_RUT_EMPRESA);
        agrega_parametro_sp(ComandoDA, "i_fecha", OracleType.DateTime, ParameterDirection.Input, P_FECHA);
        agrega_parametro_sp(ComandoDA, "i_hora", OracleType.NVarChar, ParameterDirection.Input, P_HORA);
        agrega_parametro_sp(ComandoDA, "i_descripcion_evento", OracleType.NVarChar, ParameterDirection.Input, P_DESCRIPCION_EVENTO);

        agrega_parametro_sp(ComandoDA, "i_id_grupoproceso", OracleType.Int32, ParameterDirection.Input, P_ID_GRUPOPROCESO);
        agrega_parametro_sp(ComandoDA, "i_id_localidad", OracleType.Int32, ParameterDirection.Input, P_ID_LOCALIDAD);
        agrega_parametro_sp(ComandoDA, "i_ip", OracleType.NVarChar, ParameterDirection.Input, P_IP);

        try
        {
            ComandoDA.SelectCommand.ExecuteNonQuery();
            objConexion.Close();
            objConexion.Dispose();
        }
        catch(Exception ex)
        {
           // Response.Write("Se ha producido un error al insertar el LOG del Sistema." & ex.Message & "  -  " & ex.InnerException.ToString)
            //Response.End()

            objConexion.Close();
            objConexion.Dispose();
        }

      
    }

        public bool obtiene_perfil(Int32 id_perfil, string link) {
        
            int valor=0;
        bool retorno;

        OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
        OracleCommand cmdAcceso = new OracleCommand("PK_PERFIL.OBTIENE_PERFIL", CnOra);
        OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
 
        agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
        agrega_parametro_sp(da, "i_id_perfil", OracleType.Int32, ParameterDirection.Input, id_perfil.ToString());
        agrega_parametro_sp(da, "i_link", OracleType.NVarChar, ParameterDirection.Input, link);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        CnOra.Open();
        DataSet objDS = new DataSet();
        da.Fill(objDS, "obtiene_perfil");
        CnOra.Close();
        CnOra.Dispose();
        

        foreach (DataRow dr in objDS.Tables["obtiene_perfil"].Rows)
        {
            valor = int.Parse(dr["valor"].ToString());
        }

 //       foreach(dr in objDS.Tables["obtiene_perfil"].Rows)
 ///*TODO: cambiar el nombre de la variable*/ row in objDS.Tables["obtiene_perfil"].Rows){
            
 //       }
        if( valor == 0 ){
            retorno= false;
        }else{
            retorno = true;
        }

        return retorno;

    }  

        public string ObtenerLink(string Ruta)
        {
            string[] arr;

            int c;

            arr = Ruta.Split('/');

            if ((arr.Length > 1))
            {
                foreach (string a in arr)
                {
                    if ((a.Contains(".aspx")))
                    {
                        if ((a.Contains("?")))
                        {
                            c = a.IndexOf("?");
                            string q = a.Substring(c);
                            return a.Replace(q, "");
                        }
                        else
                        {
                            return a;
                        }
                    }
                }
            }
            arr = Ruta.Split('\'');
            if ((arr.Length > 1))
            {
                foreach (string a in arr)
                {
                    if ((a.Contains(".aspx")))
                    {
                        if ((a.Contains("?")))
                        {
                            c = a.IndexOf("?");
                            string q = a.Substring(c);
                            return a.Replace(q, "");
                        }
                        else
                        {
                            return a;
                        }
                    }
                }
            }
            return "No Encontrado";
        }
        public string OBTIENE_NOMBRE_EMPRESA(string Rut_de_empresa)
        {

            OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
            OracleCommand cmdAcceso = new OracleCommand("PK_EMPRESA.NOMBRE_EMPRESA_X_RUT", CnOra);
            OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);

            agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
            agrega_parametro_sp(da, "i_rut_empresa", OracleType.Number, ParameterDirection.Input, Rut_de_empresa);

            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            CnOra.Open();

            DataSet objDS = new DataSet();
            da.Fill(objDS, "EMPRESAS");
            CnOra.Close();
            CnOra.Dispose();

            string resp =  (objDS.Tables["EMPRESAS"].Rows[0][0]).ToString();
            return resp;
        }

        public string OBTIENE_NOMBRE_PERFIL(string IDPERFIL)
        {

            string sSQL;
            OracleDataAdapter objComando;
            DataSet objDS = new DataSet();
            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            objConexion.Open();

            sSQL = "SELECT PERFIL.descripcion FROM PERFIL WHERE id_perfil=" + IDPERFIL;
            objComando = new OracleDataAdapter(sSQL, conexion_cliente_oracle);
            objComando.Fill(objDS, "PERFILES");
            objConexion.Close();
            objConexion.Dispose();

            string resp = (objDS.Tables["PERFILES"].Rows[0][0]).ToString();
            return resp;
        }

        public string CadenaSinCeros(string sEntrada)
        {
            int j = 0;
            string sIntermedio = null;
            sIntermedio = "";
            for (j = 1; j <= sEntrada.Length; j++)
            {
                if (sEntrada.Substring(j - 1, 1) != "0")
                {
                    sIntermedio = sEntrada.Substring(j - 1);
                    break;
                }
            }
            return sIntermedio;
        }
       
        public void Insertamos_log_del_Sistema(string P_ID_USUARIO, string P_RUT_EMPRESA, string P_FECHA, string P_HORA, string P_DESCRIPCION_EVENTO, string P_ID_GRUPOPROCESO, string P_ID_LOCALIDAD, string P_IP)
        {

            OracleConnection objConexion = new OracleConnection(conexion_cliente_oracle);
            objConexion.Open();

            OracleDataAdapter ComandoDA = new OracleDataAdapter("INSERTA_LOG_SGL", objConexion);
            ComandoDA.SelectCommand.CommandType = CommandType.StoredProcedure;
            agrega_parametro_sp(ComandoDA, "i_id_usuario", OracleType.Int32, ParameterDirection.Input, P_ID_USUARIO);
            agrega_parametro_sp(ComandoDA, "i_rut_empresa", OracleType.Number, ParameterDirection.Input, P_RUT_EMPRESA);
            agrega_parametro_sp(ComandoDA, "i_fecha", OracleType.DateTime, ParameterDirection.Input, P_FECHA);
            agrega_parametro_sp(ComandoDA, "i_hora", OracleType.NVarChar, ParameterDirection.Input, P_HORA);
            agrega_parametro_sp(ComandoDA, "i_descripcion_evento", OracleType.NVarChar, ParameterDirection.Input, P_DESCRIPCION_EVENTO);


            agrega_parametro_sp(ComandoDA, "i_id_grupoproceso", OracleType.Int32, ParameterDirection.Input, P_ID_GRUPOPROCESO);
            agrega_parametro_sp(ComandoDA, "i_id_localidad", OracleType.Int32, ParameterDirection.Input, P_ID_LOCALIDAD);
            agrega_parametro_sp(ComandoDA, "i_ip", OracleType.NVarChar, ParameterDirection.Input, P_IP);

            try
            {
                ComandoDA.SelectCommand.ExecuteNonQuery();
                objConexion.Close();
                objConexion.Dispose();

            }
            catch (Exception ex)
            {

                objConexion.Close();
                objConexion.Dispose();
            }

        }
        public void Combo_Contratistas_SoloItems(DropDownList P_ObjetoCombo, string P_NOM_SP, string P_RUT_EMPRESA)
        {

            OracleConnection CnOra = new OracleConnection(conexion_cliente_oracle);
            OracleCommand cmdAcceso = new OracleCommand(P_NOM_SP, CnOra);
            OracleDataAdapter da = new OracleDataAdapter(cmdAcceso);
            agrega_parametro_sp(da, "o_cursor", OracleType.Cursor, ParameterDirection.Output, "");
            agrega_parametro_sp(da, "i_rut_empresa", OracleType.Number, ParameterDirection.Input, P_RUT_EMPRESA);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            CnOra.Open();
            DataSet objDS = new DataSet();
            da.Fill(objDS, "CONTRATISTAS");
            CnOra.Close();
            CnOra.Dispose();
            //Response.Write(objDS.Tables("CONTRATISTAS").Rows.Count)
            //Response.End()

            int i = 0;
            i = 0;
            //INSTANT C# NOTE: Commented this declaration since looping variables in 'foreach' loops are declared in the 'foreach' header in C#:
            //		object row = null;

            P_ObjetoCombo.Items.Clear();
            foreach (DataRow row in objDS.Tables["CONTRATISTAS"].Rows)
            {
                P_ObjetoCombo.Items.Add(row["NOMBRE"].ToString());
                P_ObjetoCombo.Items[i].Value = row["ID_CONTRATISTA"].ToString();
                i = i + 1;
            }


            //string valueCombo = null;
            //string textoCombo = null;
            //combo_perfiles.Items.Clear();

            //foreach (DataRow drPerfilItem in dtPerfiles.Rows)
            //{
            //    valueCombo = drPerfilItem["id_perfil"].ToString();
            //    textoCombo = drPerfilItem["descripcion"].ToString();
            //    combo_perfiles.Items.Add(new ListItem(textoCombo, valueCombo));
            //}
        }

}


