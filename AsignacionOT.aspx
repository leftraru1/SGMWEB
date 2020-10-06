<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AsignacionOT.aspx.vb" Inherits="AsignacionOT" %>
 

<!--%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %-->
    

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Asignación de OT - Sistema CYR </title>
     <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/others.css"/> 
      <link type="text/css" rel="stylesheet" href="estilos/style.css"/>  
      <link type="text/css" rel="stylesheet" href="estilos/loadingbox.css" />  
      
      <script src="js/jquery.js" type="text/javascript"></script>    
      <script src="js/progress.js" type="text/javascript"></script>
      <link rel="stylesheet" type="text/css" href="estilos/contenido.css"/> 
      <link type="text/css" rel="stylesheet" href="estilos/loadingbox.css" /> 
      <script type="text/javascript" src="js/jquery-1.4.min.js"></script>
      <script type="text/javascript" src="js/jquery.notasalpie.js"></script>
      

    

<%--<style type="text/css">
body {
margin:0;
width: 100%;
height: 100%;
}
</style>--%>

<%--<script type="text/javascript" language="JavaScript1.2">
window.moveTo(0,0);
top.window.resizeTo(screen.availWidth,screen.availHeight);
</script>   --%> 

       <script type="text/javascript" language="javascript">    
    
//<%--    var cabecera=window.screenTop

//if (navigator.appName == 'Microsoft Internet Explorer')
//{
//   window.moveTo(-6,-cabecera)
//   window.resizeTo(screen.width+9,screen.height+cabecera+25)
//}--%>

    function AbrirDetalleRepos(p_id_generico,p_grupo,p_sector_busqueda,p_fecha_ini,p_fecha_fin,p_id_lector,p_id_gp,p_id_zona,p_id_localidad,p_ruta,p_id_tp,p_tipo_aparato,p_id_contratista,p_id_tipoorden,p_cod_contratista,p_sector_fecha)
             {                                                
             
                   var url = 'GestionOperativaOtras.aspx?id_generico='+p_id_generico+'&grupo='+p_grupo+'&sector_busqueda='+p_sector_busqueda+'&fecha_ini='+p_fecha_ini+'&fecha_fin='+p_fecha_fin+'&id_lector='+p_id_lector+'&id_gp='+p_id_gp+'&id_zona='+p_id_zona+'&id_localidad='+p_id_localidad+'&ruta='+p_ruta+'&id_tp='+p_id_tp+'&tipo_aparato='+p_tipo_aparato+'&id_contratista='+p_id_contratista+'&cual_detalle=DET'+'&id_tipoorden='+p_id_tipoorden+'&cod_contratista='+p_cod_contratista+'&sector_fecha='+p_sector_fecha;
                   window.open(url,'calOBS','width=940,height=780,left=0,top=0,resizable=yes,scrollbars=yes');

              }
                       
     function openLectores(obj)
      {
        var url = 'POPcortadores.aspx?textbox=' + obj;
        window.open(url,'cal','width=800,height=450,left=220,top=142,resizable=0,scrollbars=yes');
      }

  function openCalendar(obj)
      {
        var url = 'calendario.aspx?textbox=' + obj;
        window.open(url,'cal','width=260,height=210,left=410 410,top=330,resizable=0,scrollbars=0');
      }                

 function PopDetalles(p_id_servicio,medidorv,num_ordenv,id_tipoordenv,id_grupoprocesov,id_localidadv,lat,lon)      
       {
       
       var url = 'popdetalles.aspx?idServicio='+p_id_servicio+'&medidor='+medidorv+'&num_orden='+num_ordenv+'&id_tipoorden='+id_tipoordenv+'&id_grupoproceso='+id_grupoprocesov+'&id_localidad='+id_localidadv+'&lat='+lat+'&lon='+lon;
       open(url,'DetalleLectura','top=20,left=300,width=690,height=430,status=yes,resizable=no');
       //open(url,'_blank','top=20,left=300,width=690,height=400,status=yes,resizable=no');
      
       }  

function PopDetallesRepos(p_cant_contratista,p_cod_contratista,p_f_desde,p_f_hasta)      
       {
       
       var url = 'ResumenReposPendientes.aspx?cant_contratista='+p_cant_contratista+'&cod_contratista='+p_cod_contratista+'&f_desde='+p_f_desde+'&f_hasta='+p_f_hasta;
       open(url,'DetRepos','top=20,left=300,width=900,height=650,status=yes,resizable=yes');
       //open(url,'_blank','top=20,left=300,width=690,height=400,status=yes,resizable=no');
      
       }           

 function PopDetallesC(p_id_servicio,medidorv,num_ordenv,id_tipoordenv,id_grupoprocesov,id_localidadv,DIM_RUTA,DIM_TIPO_ORDEN,DIM_GRUPO,DIM_ID_SINCRONIZACION,DIM_COD_CORTADOR,DIM_FECHA_ASIGNACION,DIM_HORA_ASIGNACION,DIM_FECHA_EMISION,DIM_DEUDA,DIM_ABONO,DIM_DIAMETRO,DIM_MARCA,DIM_NOMBRE_CLIENTE,DIM_DIRECCION,DIM_NOM_LOCALIDAD,NUM_SELLO)
       {
       
       var url = 'MantencionOT.aspx?idServicio='+p_id_servicio+'&medidor='+medidorv+'&num_orden='+num_ordenv+'&id_tipoorden='+id_tipoordenv+'&id_grupoproceso='+id_grupoprocesov+'&id_localidad='+id_localidadv+'&RUTA='+DIM_RUTA+'&TIPO_ORDEN='+DIM_TIPO_ORDEN+'&GRUPO='+DIM_GRUPO+'&ID_SINCRONIZACION='+DIM_ID_SINCRONIZACION+'&COD_CORTADOR='+DIM_COD_CORTADOR+'&FECHA_ASIGNACION='+DIM_FECHA_ASIGNACION+'&HORA_ASIGNACION='+DIM_HORA_ASIGNACION+'&FECHA_EMISION='+DIM_FECHA_EMISION+'&DEUDA='+DIM_DEUDA+'&ABONO='+DIM_ABONO+'&DIAMETRO='+DIM_DIAMETRO+'&MARCA='+DIM_MARCA+'&NOMBRE_CLIENTE='+DIM_NOMBRE_CLIENTE+'&DIRECCION='+DIM_DIRECCION+'&NOM_LOCALIDAD='+DIM_NOM_LOCALIDAD+'&num_sello='+NUM_SELLO;
       open(url,'DetalleLectura','status=no,resizable=yes,scrollbars=yes,toolbar=yes,fullscreen=no');
       //open(url,'DetalleLectura','status=no,resizable=no,scrollbars=yes,toolbar=yes,fullscreen=yes');
       //open(url,'DetalleLectura','top=20,left=300,width=690,height=450,status=yes,resizable=no,scrollbars=yes');
       
       }    
       
 function PopDetallesR(p_id_servicio,medidorv,num_ordenv,id_tipoordenv,id_grupoprocesov,id_localidadv,DIM_RUTA,DIM_TIPO_ORDEN,DIM_GRUPO,DIM_ID_SINCRONIZACION,DIM_COD_CORTADOR,DIM_FECHA_ASIGNACION,DIM_HORA_ASIGNACION,DIM_FECHA_EMISION,DIM_DEUDA,DIM_ABONO,DIM_DIAMETRO,DIM_MARCA,DIM_NOMBRE_CLIENTE,DIM_DIRECCION,DIM_NOM_LOCALIDAD)      
       {
       
//       var url = 'PopDigitacionRepos.aspx?idServicio='+p_id_servicio+'&medidor='+medidorv+'&num_orden='+num_ordenv+'&id_tipoorden='+id_tipoordenv+'&id_grupoproceso='+id_grupoprocesov+'&id_localidad='+id_localidadv+'&RUTA='+DIM_RUTA+'&TIPO_ORDEN='+DIM_TIPO_ORDEN+'&GRUPO='+DIM_GRUPO+'&ID_SINCRONIZACION='+DIM_ID_SINCRONIZACION+'&COD_CORTADOR='+DIM_COD_CORTADOR+'&FECHA_ASIGNACION='+DIM_FECHA_ASIGNACION+'&HORA_ASIGNACION='+DIM_HORA_ASIGNACION+'&FECHA_EMISION='+DIM_FECHA_EMISION+'&DEUDA='+DIM_DEUDA+'&ABONO='+DIM_ABONO+'&DIAMETRO='+DIM_DIAMETRO+'&MARCA='+DIM_MARCA+'&NOMBRE_CLIENTE='+DIM_NOMBRE_CLIENTE+'&DIRECCION='+DIM_DIRECCION+'&NOM_LOCALIDAD='+DIM_NOM_LOCALIDAD;
var url = 'MantencionOT.aspx?idServicio='+p_id_servicio+'&medidor='+medidorv+'&num_orden='+num_ordenv+'&id_tipoorden='+id_tipoordenv+'&id_grupoproceso='+id_grupoprocesov+'&id_localidad='+id_localidadv+'&RUTA='+DIM_RUTA+'&TIPO_ORDEN='+DIM_TIPO_ORDEN+'&GRUPO='+DIM_GRUPO+'&ID_SINCRONIZACION='+DIM_ID_SINCRONIZACION+'&COD_CORTADOR='+DIM_COD_CORTADOR+'&FECHA_ASIGNACION='+DIM_FECHA_ASIGNACION+'&HORA_ASIGNACION='+DIM_HORA_ASIGNACION+'&FECHA_EMISION='+DIM_FECHA_EMISION+'&DEUDA='+DIM_DEUDA+'&ABONO='+DIM_ABONO+'&DIAMETRO='+DIM_DIAMETRO+'&MARCA='+DIM_MARCA+'&NOMBRE_CLIENTE='+DIM_NOMBRE_CLIENTE+'&DIRECCION='+DIM_DIRECCION+'&NOM_LOCALIDAD='+DIM_NOM_LOCALIDAD+'&num_sello='+NUM_SELLO;
        window.open(url,'DetalleLectura','status=no,resizable=yes,scrollbars=yes,toolbar=yes,fullscreen=no')
        //window.open(url,'DetalleLectura','status=no,resizable=no,scrollbars=yes,toolbar=yes,fullscreen=yes')
        //window.open(url,'DetalleLectura','top=20,left=300,width=690,height=450,status=yes,resizable=no,scrollbars=yes')
       Opener.Attributes.Add("Onclick", Clientscript);
       }  
       
 function filtro_padre(){
 filtrado_rutas()

 }   
 
function Nodigita() {
alert("Servicio debe estar con asignacion Liberada Para su digitación!!!")
}      

function Sfecha() {
alert("Debe Seleccionar Fecha desde boton, no digitar!!!")
}    
            
   </script>
   
  
</head>
<body>
    <form id="form1" runat="server">            
    <img src="fotos/procesando3.gif" alt="" style="display:none;" />

                  
        <table id="Table5" runat="server" align="center" border="0" cellpadding="0" cellspacing="0" style="width: 950px">
            <tr>
                <td id="panel_sesion" style="width: 900px">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="False"
                        Font-Underline="True" CssClass="Label">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server" CssClass="Label"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="False" Font-Underline="True" CssClass="Label">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" CssClass="Label"></asp:Label><asp:Label ID="lb_id_usuario" runat="server" CssClass="Label"></asp:Label><asp:Label ID="lb_rut_empresa" runat="server" CssClass="Label"></asp:Label><asp:Label ID="lbl_id_perfil" runat="server" CssClass="Label"></asp:Label></td>
            </tr>
            <tr style="font-family: Trebuchet MS">
                <td id="tbl_inicio" runat="server" class="WebPartShadow" style="width: 900px">
                    <table align="center" cellpadding="0" style="width: 900px">
                        <tr runat="server">
                            <td align="left" class="WebPartTitle_ext" colspan="6" nowrap="nowrap">
                                Asignación Órdenes de Trabajo</td>
                        </tr>
                        <tr id="Tr2" runat="server">
                            <td align="left" colspan="6" nowrap="nowrap">
                                <h2>
                                        Seleccione información y luego oprima "BUSCAR"</h2>
                            </td>
                        </tr>
                        
                        <tr runat="server">
                            <td style="text-align: right; width:13%" nowrap="nowrap">
                                    <h2>Clase OT:&nbsp;</h2>
                            </td>
                            <td align="left" nowrap="nowrap" style="width:20%">
                                <asp:DropDownList ID="clase_ot" onchange="$.showprogress()" runat="server" AutoPostBack="True" CssClass="ComboBox2">
                                </asp:DropDownList></td>
                            <td nowrap="nowrap" style="width:13%; text-align: right">
                                <h2>Operador:</h2></td>
                            <td nowrap="nowrap" style=" width:20%;">
                                <asp:DropDownList ID="cbo_cortador" onchange="$.showprogress()" runat="server" AutoPostBack="True" CssClass="ComboBox2">
                                </asp:DropDownList></td>
                            <td nowrap="nowrap" style="text-align: right; width:9%;">
                                <h2>
                                    Desde:&nbsp;</h2>
                            </td>
                            <td nowrap="nowrap" style="width:25%;">
                                <asp:TextBox ID="txtDate1" runat="server" CssClass="TextBox2" ReadOnly="false"></asp:TextBox><img
                                    id="Img2" runat="server" alt="calendario2" onclick="openCalendar('txtDate1');"
                                    src="fotos/calendario.gif" /><asp:RequiredFieldValidator ID="validar_inf_fecha_desde"
                                        runat="server" ControlToValidate="txtDate1" CssClass="ErrorMessage" ErrorMessage="*"
                                        Font-Bold="True" Height="8px" ValidationGroup="fecha">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                            ID="validar_fecha_desde" runat="server" BackColor="Transparent" ControlToValidate="txtDate1"
                                            CssClass="ErrorMessage" ErrorMessage="RegularExpressionValidator" Font-Bold="False"
                                            ValidationExpression="^[0-9]{2}-[0-9]{2}-[0-9]{4}$" ValidationGroup="fecha" Font-Names="Verdana" Font-Size="X-Small" Width="28px">(Error)</asp:RegularExpressionValidator></td>
                        </tr>
                        <tr id="Tr1" runat="server">
                            <td align="right" nowrap="nowrap">
                                <h2 style="text-align: right;">
                                    Tipo Proceso:&nbsp;</h2>
                            </td>
                            <td align="left" nowrap="nowrap"><asp:DropDownList ID="cmb_TiposProcesos" onchange="$.showprogress()" runat="server" AutoPostBack="True" CssClass="ComboBox2">
                            </asp:DropDownList></td>
                            <td align="left" nowrap="nowrap" style="text-align: right">
                                <h2 style="text-align: right;">
                                        Proceso:&nbsp;</h2>
                            </td>
                            <td align="left" nowrap="nowrap">
                                <asp:DropDownList ID="combo_lotes" onchange="$.showprogress()" runat="server" AutoPostBack="True" CssClass="ComboBox2">
                                </asp:DropDownList></td>
                            <td nowrap="nowrap" style="text-align: right;">
                                <h2>
                                    Hasta:&nbsp;
                                </h2>
                            </td>
                            <td align="left" nowrap="nowrap">
                                <asp:TextBox ID="txtDate2" runat="server" CssClass="TextBox2" ReadOnly="false"></asp:TextBox><img
                                    id="Img4" runat="server" alt="Calendario2" onclick="openCalendar('txtDate2');"
                                    src="fotos/calendario.gif" />
                                <asp:RequiredFieldValidator ID="validar_inf_fecha_hasta"
                                        runat="server" ControlToValidate="txtDate2" CssClass="ErrorMessage" ErrorMessage="*"
                                        Font-Bold="True" ValidationGroup="fecha">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                            ID="validar_fecha_hasta" runat="server" BackColor="Transparent" ControlToValidate="txtDate2"
                                            CssClass="ErrorMessage" ErrorMessage="RegularExpressionValidator" Font-Bold="False"
                                            ValidationExpression="^[0-9]{2}-[0-9]{2}-[0-9]{4}$" ValidationGroup="fecha" Font-Names="Verdana" Font-Size="X-Small">(Error)</asp:RegularExpressionValidator></td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap" style="height: 19px">
                                <h2 style="text-align: right">
                                    Zona:&nbsp;
                                </h2>
                            </td>
                            <td align="left" nowrap="nowrap" style="height: 19px">
                                <asp:DropDownList ID="Combozonas" onchange="$.showprogress()" runat="server" AutoPostBack="True" CssClass="ComboBox2">
                                </asp:DropDownList></td>
                            <td align="left" nowrap="nowrap" style="height: 19px; text-align: right">
                                <h2 style="text-align: right">
                                    Estado Asign:</h2>
                            </td>
                            <td align="left" nowrap="nowrap" style="height: 19px">
                                <asp:DropDownList ID="combo_Estados" runat="server" AutoPostBack="True" CssClass="ComboBox2" onchange="$.showprogress()">
                                </asp:DropDownList></td>
                            <td nowrap="nowrap"  style="text-align: right; height: 19px;">
                                <h2>N° Cliente:&nbsp;</h2>
                            </td>
                            <td align="left" nowrap="nowrap" style="height: 19px">
                                <asp:TextBox ID="txt_id_servicio" runat="server" CssClass="TextBox2" MaxLength="10"
                                    ReadOnly="false" Width="100px"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="ER_id_servicio" runat="server" ControlToValidate="txt_id_servicio"
                                    CssClass="ErrorMessage" Display="Dynamic" ErrorMessage="Valor no numérico!" Font-Bold="False"
                                    ValidationExpression="^([0-9]{1,50})$" Width="90px"></asp:RegularExpressionValidator></td>
                        </tr>
                        <tr id="Tr8" runat="server">
                            <td align="right" nowrap="nowrap">
                                <h2>
                                        Localidad:&nbsp;</h2>
                            </td>
                            <td align="left" nowrap="nowrap">
                                <asp:DropDownList ID="combo_localidades" onchange="$.showprogress()" runat="server" AutoPostBack="True" CssClass="ComboBox2">
                                </asp:DropDownList></td>
                            <td align="left" nowrap="nowrap">
                                <h2 style="text-align: right">
                                    Ruta:&nbsp;
                                </h2>
                            </td>
                            <td align="left" nowrap="nowrap">
                                <asp:DropDownList ID="combo_ruta" onchange="$.showprogress()" runat="server" AutoPostBack="True" CssClass="ComboBox2">
                                </asp:DropDownList></td>
                            <td align="left" nowrap="nowrap">
                                <h2 style="text-align: right">N° Orden:&nbsp;</h2>
                            </td>
                            <td align="left" nowrap="nowrap">
                                <asp:TextBox ID="txt_num_orden" runat="server" CssClass="TextBox2" ReadOnly="false"
                                    Width="100px"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="ER_num_orden" runat="server" ControlToValidate="txt_num_orden"
                                    CssClass="ErrorMessage" Display="Dynamic" ErrorMessage="Valor no numérico!" Font-Bold="False"
                                    ValidationExpression="^([0-9]{1,50})$" Width="90px"></asp:RegularExpressionValidator></td>
                        </tr>
                        <tr runat="server">
                            <td align="right" nowrap="nowrap" style="height: 19px">
                                </td>
                            <td align="left" nowrap="nowrap" style="height: 19px">
                                <asp:Label ID="lb_cantidad_contratistas" runat="server"></asp:Label></td>
                            <td align="left" nowrap="nowrap" style="height: 19px;">
                            </td>
                            <td align="left" nowrap="nowrap" style="height: 19px">
                                <asp:Label ID="lb_codigos_contratistas" runat="server"></asp:Label></td>
                            <td align="left" nowrap="nowrap" style="height: 19px">
                            </td>
                            <td nowrap="nowrap" style="text-align: right; height: 19px;" align="right">
                                <asp:Button ID="Button1" runat="server" CssClass="botonnew" Text="BUSCAR" OnClientClick="$.showprogress()"/></td>
                        </tr>
                        <tr id="Tr14" runat="server">
                            <td align="right" nowrap="nowrap">
                                <h2>
                                    &nbsp;&nbsp;
                                </h2>
                            </td>
                            <td align="left" nowrap="nowrap">
                            </td>
                            <td align="left" nowrap="nowrap">
                                <h2 style="text-align: right">
                                    &nbsp;</h2>
                            </td>
                            <td align="left" nowrap="nowrap">
                            </td>
                            <td align="left" nowrap="nowrap">
                                <h2 style="text-align: right">
                                    &nbsp;</h2>
                            </td>
                            <td nowrap="nowrap" style="text-align: right;">
                            <%--<img
                                    id="Img3" runat="server" alt="calendario2" onclick="openCalendar('txtDate1');" src="fotos/hoja.gif" />--%>
                                    <img alt="" id="btnResumen" runat="server" src="fotos/hoja.gif" onclick="PopDetallesRepos()"  />
                                    <%--<img alt="" id="btnDetalles" runat="server" src="fotos/lupa.png" class="Label"/>--%>
                                </td>
                        </tr>
                        <tr runat="server">
                            <td align="left" colspan="6" nowrap="nowrap" style="text-align: center">
                                <asp:TextBox ID="TextBox4" runat="server" BackColor="Green" CssClass="TextBox_totalizador"
                                        ReadOnly="True" Enabled="False" ToolTip="Ordenes descargadas, repasar" Width="40px" ></asp:TextBox>
                                <asp:Label ID="Label2" runat="server" CssClass="Label" Text="Orden Descargada "></asp:Label>
                                
                                <asp:TextBox ID="TextBox2" runat="server" CssClass="TextBox_totalizador" ReadOnly="True" Enabled="False" 
                                    ToolTip="Cortes Menor a 24 hr. Después de la Generación"  Width="20px" Text="C" ></asp:TextBox>
                                <asp:TextBox ID="TextBox5" runat="server" CssClass="TextBox_totalizador" ReadOnly="True" Enabled="False" 
                                    ToolTip="Repos Menos de 12 hr. Después de la Generación"  Width="20px" Text="R" ></asp:TextBox>    
                                <asp:Label ID="Label3" runat="server" CssClass="Label" Text="Orden Nueva"></asp:Label>
                                
                                <asp:TextBox ID="TextBox1" runat="server" BackColor="Gold" CssClass="TextBox_totalizador" ReadOnly="True" 
                                    Enabled="False" ToolTip="Cortes Entre 24 y 48 hr. Después de la Generación" Width="20px" Text="C" ></asp:TextBox>
                                <asp:TextBox ID="TextBox6" runat="server" BackColor="Gold" CssClass="TextBox_totalizador" ReadOnly="True" 
                                    Enabled="False" ToolTip="Repos Entre 12 y 20 hr. Después de la Generación" Width="20px" Text="R" ></asp:TextBox>    
                                <asp:Label ID="Label1" runat="server" CssClass="Label" Text="A Punto de Exceder el Tiempo"></asp:Label>
                                
                                <asp:TextBox ID="TextBox3" runat="server" BackColor="Tomato" CssClass="TextBox_totalizador" ReadOnly="True" 
                                    Enabled="False" ToolTip="Cortes Mayor a 48 hr. Después de la Generación" Width="20px" Text="C" ></asp:TextBox>
                                <asp:TextBox ID="TextBox7" runat="server" BackColor="Tomato" CssClass="TextBox_totalizador" ReadOnly="True" 
                                    Enabled="False" ToolTip="Repos Mayor a 20 hr. Después de la Generación" Width="20px" Text="R" ></asp:TextBox>
                                <asp:Label ID="Label4" runat="server" CssClass="Label" Text="Superado el tiempo de ejecución"></asp:Label></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table id="tbl_inicio2" runat="server" align="center" border="0" cellspacing="0"
            class="WebPartShadow">
            <tr>
                <td align="left" class="WebPartShadow" colspan="2">                                                                
                            <table>
                                <tr>
                                <td align="right">
                                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" ForeColor="Blue" CssClass="Label">Marcar Asignación</asp:LinkButton>
                                    &nbsp;<asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" ForeColor="Blue" CssClass="Label">Desmarcar Asignación</asp:LinkButton>
                                </td>
                                </tr>
                                <tr>
                                    <td>
                                    <asp:Label ID="LB_REGISTROS_GRID" runat="server" Text="0 coincidencia(s) encontrada(s)" CssClass="Label" Font-Names="Arial Unicode MS" Font-Size="X-Small" ForeColor="Maroon" Width="258px"></asp:Label>
                                    <asp:DataGrid ID="GrillaPrincipal" runat="server" AutoGenerateColumns="False"
                                            BorderColor="#003366" BorderStyle="Solid" BorderWidth="0px" CellPadding="1"
                                            CssClass="GridAlternativeItems" ForeColor="Black" GridLines="Horizontal"
                                            OnDeleteCommand="cmDelete" CellSpacing="1" PageSize="200" AllowPaging="True">
                                            <HeaderStyle BackColor="CornflowerBlue" BorderColor="Black" Font-Bold="True" Font-Underline="False"
                                            ForeColor="White" HorizontalAlign="Center" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Wrap="False" VerticalAlign="Middle" Font-Names="Arial" />
                                            <Columns>
                                                <asp:BoundColumn DataField="nom_contratista" HeaderText="CONTRATISTA"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="id_grupoproceso" HeaderText="IDgrupoproceso" Visible="False">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="id_servicio" HeaderText="NRO CLIENTE">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" Font-Names="Arial" />
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="nom_tipoorden" HeaderText="To.">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="numero_orden" HeaderText="NUM ORDEN">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="monto_deuda" HeaderText="Monto">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="direccion" HeaderText="DIRECCI&#211;N">
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" HorizontalAlign="Left" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="nom_localidad" HeaderText="LOCALIDAD">
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" HorizontalAlign="Left" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="ruta" HeaderText="RUTA">
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" HorizontalAlign="Left" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="nivel_corte" HeaderText="NIVEL ">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="id_sincronizacion" HeaderText="id_sincronizacion" Visible="False">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="estado" HeaderText="ESTADO">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="libreta" HeaderText="Libreta(ruta)" Visible="False">
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="nom_cortador" HeaderText="OPERADOR">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="id_cortador" HeaderText="id_cortador" Visible="False">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="nombre" HeaderText="nombre" Visible="False">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="apellido" HeaderText="apellido" Visible="False">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="hora_generacion" HeaderText="Fecha Gen.">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="id_localidad" HeaderText="id_localidad" Visible="False">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="medidor" HeaderText="Medidor" Visible="False">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="id_tipoorden" HeaderText="id_tipoorden" Visible="False">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="grupo" HeaderText="GRUPO" Visible="False">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="cod_cortador" HeaderText="cod_cortador" Visible="False">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:TemplateColumn HeaderText="Asignar">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="check_asigna" runat="server" />
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Desasignar">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="check_desasigna" runat="server" />
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Detalle">
                                                    <ItemTemplate>
                                                        <img alt="" id="btnDetalles" runat="server" src="fotos/lupa.png" class="Label"/>&nbsp;
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" Wrap="False" />
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Digitar">
                                                    <ItemTemplate>
                                                        <img alt="" id="btnDigita" runat="server" src="fotos/lapiz3.png" height="18" width="18" class="Label" />
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" Wrap="False" />
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:TemplateColumn>
                                                <asp:ButtonColumn CommandName="Delete" HeaderText="Eliminar" Text="Eliminar">
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" ForeColor="Blue" Wrap="False" />
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                </asp:ButtonColumn>
                                                <asp:BoundColumn DataField="fecha_asignacion" HeaderText="fecha_asignacion" Visible="False">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="hora_asignacion" HeaderText="hora_asignacion" Visible="False">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="fecha_emision" HeaderText="FechaEmision" Visible="False">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="deuda" HeaderText="Deuda" Visible="False">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="Abono" HeaderText="Abono" Visible="False">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="diametro" HeaderText="Diametro" Visible="False">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="marca" HeaderText="Marca" Visible="False">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="nombre_cliente" HeaderText="Nombre_Cliente" Visible="False">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="Prioridad" HeaderText="Prioridad" Visible="False">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="FECHA_CREACION_SISTEMA" HeaderText="FECHA_CREACION_SISTEMA"
                                                    Visible="False"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="LAT" HeaderText="LAT" Visible="False"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="LON" HeaderText="LON" Visible="False"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="id_contratista" HeaderText="ID_CONTRATISTA" Visible="False">
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="num_sello" HeaderText="NUM_SELLO" Visible="False"></asp:BoundColumn>
                                            </Columns>
                                            <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                                                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                                                VerticalAlign="Middle" Mode="NumericPages" Wrap="False" />
                                            <ItemStyle BackColor="White" HorizontalAlign="Center" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                            <AlternatingItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                        <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" Wrap="False" />
                        <EditItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" Wrap="False" />
                        <SelectedItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" Wrap="False" />
                  </asp:DataGrid>
                  

                  </td>
                  </tr>
                  </table>
               </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: left">
                       <asp:Image ID="img_ok" runat="server" ImageUrl="fotos/ok.bmp" Height="16px" Width="20px" /><asp:Label ID="lb_mensaje_liberacion" runat="server" Font-Names="Arial Unicode MS" ForeColor="#0000C0" CssClass="Label" Font-Size="Small"></asp:Label>
                    <asp:Label ID="lb_valida" runat="server" ForeColor="Red" Font-Names="Arial Unicode MS" CssClass="Label" Font-Size="Small" Height="18px"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: left">
                    <asp:Label ID="VALIDACION_CODIGO_LECTOR" runat="server" Font-Names="Arial Unicode MS" ForeColor="Red" CssClass="Label" Font-Size="Small"></asp:Label>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txt_codLector"
                        ErrorMessage="Sólo valores numéricos para el código del cortador!" Font-Names="Arial Unicode MS"
                        ValidationExpression="^([0-9]{1,4})$" CssClass="Label" Font-Size="Small" Height="18px"></asp:RegularExpressionValidator></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: right">
                    <asp:Label ID="lb_codcortador" runat="server" CssClass="Label" Font-Bold="False"
                        Font-Names="Arial Unicode MS" Font-Size="X-Small" ForeColor="Maroon" Width="181px">Ingrese Código Cortador:</asp:Label>
                    <input id="txt_codLector" runat="server" type="text" class="TextBox2"/>
                                        <img alt="Ver Cortadores" src="fotos/lupa.bmp" onclick="openLectores('txt_codLector');" id="IMG1" height="15" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                        
                    <asp:Button ID="btnExportExcel" runat="server" CssClass="botonnew"
                        Text="Exportar Excel" />
                    <asp:Button ID="btnAsignaLector" runat="server" CssClass="botonnew" Text="Asignar Operador" Width="108px" />
                    <asp:Button
                        ID="btnDesasignaTramo" runat="server" CssClass="botonnew" Text="Des-Asignar" />
                    <asp:Button ID="btnVolver" runat="server" CssClass="botonnew" Text="<< Volver" /></td>
            </tr>
        </table>
        <br />
        <table align="center" runat="server" border="0" cellpadding="0" cellspacing="0" style="width: 758px;
            height: 152px" width="758" id="tbl_detalles">
            <tr>
                <td style="width: 732px; height: 1px;">
                    <div class="WebPartShadow_ext">
                        <div id="Div4" runat="server" class="WebPartTitle_ext">
                            Detalle Asignación de tramos...<asp:Button ID="btnLiberaAsignacion" runat="server" CssClass="botonnew" Text="Liberar Asignacion" Visible="False" />
                    <asp:Button ID="btnTramos" runat="server" CssClass="botonnew" Text="Asignar Tramo" Visible="False" />
                            <asp:Label ID="lb_valida_tramos" runat="server" ForeColor="Red" Font-Names="Arial" CssClass="Label"></asp:Label></div>
                        <table align="center" border="0" cellspacing="4" style="width: 710px; height: 1px"
                            width="709">
                            <tr style="font-family: Times New Roman">
                                <td align="left" colspan="2" nowrap="nowrap" style="width: 759px; height: 15px">
                                    <table style="width: 550px; height: 7px" id="TABLE3">
                                        <tr>
                                            <td style="width:40%; height: 4px">
                                                <h2>
                                                    De Orden Ruta:
                                                    <asp:TextBox ID="txt_OrdenRuta_desde" runat="server" CssClass="TextBox" Width="70px"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_OrdenRuta_desde"
                                                        ErrorMessage="*"></asp:RequiredFieldValidator></h2></td>
                                            <td style="width:40%; height: 4px">
                                            <h2>
                                                Hasta Orden Ruta:
                                                <asp:TextBox ID="txt_OrdenRuta_hasta" runat="server" CssClass="TextBox" Width="70px"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txt_OrdenRuta_hasta"
                                                    ErrorMessage="*"></asp:RequiredFieldValidator></h2>
                                            </td>
                                            <td style="width: 20%; height: 4px" align="center">
                                                &nbsp;<asp:LinkButton ID="lk_tramo_selecciona" runat="server" ForeColor="Black">Seleccionar Tramo</asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                    <asp:Label ID="lb_idLector_tramos" runat="server"></asp:Label>
                                    <asp:RegularExpressionValidator ID="er_desde" runat="server" ControlToValidate="txt_OrdenRuta_desde"
                                        ErrorMessage="Error en orden ruta: Sólo números! " ValidationExpression="^([0-9]{1,10})$" Font-Names="Arial Unicode MS" Font-Size="Small"></asp:RegularExpressionValidator>
                                    <asp:RegularExpressionValidator ID="er_hasta" runat="server" ControlToValidate="txt_OrdenRuta_hasta"
                                        ErrorMessage="Error en Hasta Orden ruta: Sólo números!" ValidationExpression="^([0-9]{1,10})$" Font-Names="Arial"></asp:RegularExpressionValidator>
                                    <asp:Label ID="lb_validaciones" runat="server" Font-Names="Arial" ForeColor="Red"></asp:Label></td>
                            </tr>
                            <tr style="color: #000000; font-family: Times New Roman">
                                <td align="center" colspan="2" style="width: 759px; height: 3px; text-align: left">
                                <asp:Button ID="BtnConfirmaDetalle" runat="server" CssClass="botonnew" Text="Confirmar" Width="120px" CausesValidation="False" />
                                <asp:Button ID="BtnDetalleCancel" runat="server" CssClass="botonnew" Text="<< Volver" Width="120px" CausesValidation="False" />
                                    <table border="0" cellpadding="0" cellspacing="0" style="width: 756px">
                                        <tr>
                                            <td style="width:30%; height: 16px;">
                                                <h2>Asignacion de tramos para el lector:</h2>                                                
                                                </td>
                                                <td style="width:46%; height: 16px;"><asp:Label ID="lb_nombre_lector" runat="server" Width="330px" Font-Names="Arial" ForeColor="#C00000"></asp:Label></td>
                                            <td style="width:12%; height: 16px;" align="right">
                                                <asp:LinkButton ID="lk_Desmarca_checks" runat="server" ForeColor="Blue" CausesValidation="False">Desmarcar Todos</asp:LinkButton></td>
                                            <td style="width:12%; height: 16px;" align="right">
                                                <asp:LinkButton ID="lk_Marca_checks" runat="server" ForeColor="Blue" CausesValidation="False">Marcar Todos</asp:LinkButton></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 23%; height: 16px">
                                            <asp:Label ID="lb_registros_tramos" runat="server" Text="0 coincidencia(s) encontrada(s)"
                                        Width="179px"></asp:Label></td>
                                            <td align="right" style="width: 12%; height: 16px">
                                            </td>
                                            <td align="right" style="width: 12%; height: 16px">
                                            </td>
                                        </tr>
                                    </table>
                                    <asp:DataGrid ID="GrillaTramos" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                        BorderWidth="0px" CellPadding="1" CellSpacing="1" CssClass="GridAlternativeItems"
                                        GridLines="Horizontal" Height="1px" PageSize="6" Width="756px">
                                        <EditItemStyle BackColor="Honeydew" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" />
                                        <PagerStyle BackColor="Control" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Mode="NumericPages"
                                            NextPageText="Siguientes" PrevPageText="Anteriores" />
                                        <AlternatingItemStyle BackColor="White" />
                                        <ItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                        <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="True" ForeColor="White" HorizontalAlign="Center" />
                                        <Columns>
                                            <asp:BoundColumn DataField="cod_lector" HeaderText="codLector" Visible="False"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="id_localidad" HeaderText="idLocalidad" Visible="False"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="id_grupoproceso" HeaderText="idGrupoProceso" Visible="False">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="grupo" HeaderText="GRUPO" Visible="False"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="correlativo" HeaderText="Num."></asp:BoundColumn>
                                            <asp:BoundColumn DataField="direccion" HeaderText="Direcci&#243;n"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="medidor" HeaderText="Medidor"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="libro" HeaderText="Ruta"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="orden_ruta" HeaderText="Orden Ruta"></asp:BoundColumn>
                                            <asp:TemplateColumn HeaderText="-">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="check_orden_ruta" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                        </Columns>
                                    </asp:DataGrid></td>
                            </tr>
                            <tr style="font-family: Times New Roman">
                                <td align="center" colspan="2" style="width: 759px; height: 17px;">
                                    <strong></strong>
                                </td>
                            </tr>
                            <tr style="font-family: Times New Roman">
                                <td align="right" colspan="2" style="width: 759px">
                                    &nbsp;
                                    </td>
                            </tr>
                        </table>  
                    </div>                  </td>
            </tr>
        </table><asp:DataGrid ID="DataGrid_aux" runat="server" AutoGenerateColumns="False"
                                            BorderColor="#003366" BorderStyle="Solid" BorderWidth="0px" CellPadding="1"
                                            CssClass="GridAlternativeItems" ForeColor="Black" GridLines="Horizontal" Height="1px"
                                            Width="1152px" CellSpacing="1" PageSize="50" Visible="False" Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True">
            <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                                                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                                                VerticalAlign="Middle" Wrap="False" />
            <AlternatingItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
            <ItemStyle BackColor="White" HorizontalAlign="Center" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
            <Columns>
                <asp:BoundColumn DataField="nom_contratista" HeaderText="Contratista"></asp:BoundColumn>
                <asp:BoundColumn DataField="id_grupoproceso" HeaderText="IDgrupoproceso" Visible="False">
                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" HorizontalAlign="Center" Wrap="False" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="id_servicio" HeaderText="Nro Cliente">
                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" HorizontalAlign="Center" Wrap="False" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="nom_tipoorden" HeaderText="Tipo Orden">
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" HorizontalAlign="Center" Wrap="False" />
                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="numero_orden" HeaderText="Nro Orden">
                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" HorizontalAlign="Center" Wrap="False" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="monto_deuda" HeaderText="Monto Deuda">
                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" HorizontalAlign="Center" Wrap="False" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="medidor" HeaderText="Medidor">
                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" HorizontalAlign="Center" Wrap="False" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="nom_localidad" HeaderText="Localidad">
                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" HorizontalAlign="Center" Wrap="False" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="ruta" HeaderText="Ruta">
                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" HorizontalAlign="Center" Wrap="False" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="nombre_cliente" HeaderText="Cliente"></asp:BoundColumn>
                <asp:BoundColumn DataField="DIRECCION" HeaderText="Direcci&#243;n"></asp:BoundColumn>
                <asp:BoundColumn DataField="nivel_corte" HeaderText="Nivel ">
                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" HorizontalAlign="Center" Wrap="False" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="id_sincronizacion" HeaderText="id_sincronizacion" Visible="False">
                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" HorizontalAlign="Center" Wrap="False" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="estado" HeaderText="Estado">
                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" HorizontalAlign="Center" Wrap="False" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="libreta" HeaderText="Libreta(ruta)" Visible="False">
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" HorizontalAlign="Center" Wrap="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="nom_cortador" HeaderText="Operador">
                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" HorizontalAlign="Center" Wrap="False" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="id_cortador" HeaderText="id_cortador" Visible="False">
                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" HorizontalAlign="Center" Wrap="False" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="nombre" HeaderText="nombre" Visible="False">
                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" HorizontalAlign="Center" Wrap="False" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="apellido" HeaderText="apellido" Visible="False">
                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" HorizontalAlign="Center" Wrap="False" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="FECHA_GENERACION" HeaderText="Fecha Generaci&#243;n"></asp:BoundColumn>
                <asp:BoundColumn DataField="hora_generacion" HeaderText="Hora Generaci&#243;n">
                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" HorizontalAlign="Center" Wrap="False" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="id_localidad" HeaderText="id_localidad" Visible="False">
                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" HorizontalAlign="Center" Wrap="False" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="id_tipoorden" HeaderText="id_tipoorden" Visible="False">
                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" HorizontalAlign="Center" Wrap="False" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="grupo" HeaderText="GRUPO" Visible="False">
                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" HorizontalAlign="Center" Wrap="False" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="cod_cortador" HeaderText="cod_cortador" Visible="False">
                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" HorizontalAlign="Center" Wrap="False" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" Wrap="False" />
                </asp:BoundColumn>
            </Columns>
            <HeaderStyle BackColor="CornflowerBlue" BorderColor="Black" Font-Bold="True" Font-Underline="True"
                                                ForeColor="White" HorizontalAlign="Center" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Wrap="False" />
            <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                Font-Underline="False" Wrap="False" />
            <EditItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                Font-Underline="False" Wrap="False" />
            <SelectedItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                Font-Underline="False" Wrap="False" />
        </asp:DataGrid><br />
     
 
    </form>
</body>
</html>
