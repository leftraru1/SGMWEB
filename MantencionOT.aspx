<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MantencionOT.aspx.vb" Inherits="MantencionOT" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Mantencion de OT - Sistema CYR </title>
      <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/others.css"/> 
       <link type="text/css" rel="stylesheet" href="estilos/style.css"/>  
       
       <link rel="stylesheet" type="text/css" href="estilos/contenido.css"/>
       
       <link type="text/css" rel="stylesheet" href="estilos/loadingbox.css" />          

        <script type="text/javascript" src="js/jquery-1.4.min.js"></script>
        <script type="text/javascript" src="js/jquery.notasalpie.js"></script>

  <link type="text/css" href="estilos/jquery-ui.css" rel="stylesheet" />
  <script type="text/javascript" src="js/jquery.min.js"></script>
  <script type="text/javascript" src="js/jquery-ui.min.js"></script>


  <script src="js/ClavesInfo.js" type="text/javascript"></script>
  
        
      <script src="js/progress.js" type="text/javascript"></script>
      <script src="js/upload_progress.js" type="text/javascript"></script>
      

  <script type="text/javascript">
    $(document).ready(function () {
      var $dialogA,$dialogB,$dialogC;      
      PageInitA();
      PageInitB();
      PageInitC();
    });   
  </script>
  
  
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

<script language="javascript" type="text⁄javascript"> 

function CheckTime(str) 
{ 
hora=str.value; 
if (hora=='') { 
return; 
} 
if (hora.length>8) { 
alert("Introdujo una cadena mayor a 8 caracteres"); 
return; 
} 
if (hora.length!=8) { 
alert("Introducir HH:MM:SS"); 
return; 
} 
a=hora.charAt(0); //<=2 
b=hora.charAt(1); //<4 
c=hora.charAt(2); //: 
d=hora.charAt(3); //<=5 
e=hora.charAt(5); //: 
f=hora.charAt(6); //<=5 
if ((a==2 && b>3) || (a>2)) { 
alert("El valor que introdujo en la Hora no corresponde, introduzca un digito entre 00 y 23"); 
return; 
} 
if (d>5) { 
alert("El valor que introdujo en los minutos no corresponde, introduzca un digito entre 00 y 59"); 
return; 
} 
if (f>5) { 
alert("El valor que introdujo en los segundos no corresponde"); 
return; 
} 
if (c!=':' || e!=':') { 
alert("Introduzca el caracter ':' para separar la hora, los minutos y los segundos"); 
return; 
} 
} 

</script>

       <script type="text/javascript" language="javascript">    
     
    
// <%--    var cabecera=window.screenTop

//if (navigator.appName == 'Microsoft Internet Explorer')
//{
//   window.moveTo(-6,-cabecera)
//   window.resizeTo(screen.width+9,screen.height+cabecera+25)
//}--%>

    
    
     function openLectores(obj)
      {
        var url = 'POPcortadores.aspx?textbox=' + obj;
        window.open(url,'cal','width=800,height=250,left=78,top=30,resizable=0,scrollbars=yes');
      }


  function openCalendar(obj)
      {
        var url = 'calendario.aspx?textbox=' + obj;
        window.open(url,'cal','width=260,height=210,left=410 410,top=330,resizable=0,scrollbars=0');
      }                        

 function PopDetalles(p_id_servicio,medidorv,num_ordenv,id_tipoordenv,id_grupoprocesov,id_localidadv)      
       {
       
       var url = 'popdetalles.aspx?idServicio='+p_id_servicio+'&medidor='+medidorv+'&num_orden='+num_ordenv+'&id_tipoorden='+id_tipoordenv+'&id_grupoproceso='+id_grupoprocesov+'&id_localidad='+id_localidadv;
       open(url,'DetalleLectura','top=20,left=300,width=690,height=400,status=yes,resizable=no');
      
       }    

 function PopDetallesC(p_id_servicio,DIM_NOMBRE_CLIENTE,DIM_DIRECCION,medidorv,DIM_DIAMETRO,DIM_RUTA,DIM_MARCA,DIM_NOM_LOCALIDAD,DIM_ORDEN_RUTA)
       {
       
       var url = 'POPSubirImagen.aspx?idServicio='+p_id_servicio+'&NOMBRE_CLIENTE='+DIM_NOMBRE_CLIENTE+'&DIRECCION='+DIM_DIRECCION+'&medidor='+medidorv+'&DIAMETRO='+DIM_DIAMETRO+'&RUTA='+DIM_RUTA+'&MARCA='+DIM_MARCA+'&NOM_LOCALIDAD='+DIM_NOM_LOCALIDAD+'&V_ORDEN_RUTA='+DIM_ORDEN_RUTA;
        open(url,'DetalleLectura','top=50%,left=50%,width=758,height=618,status=yes,resizable=no');
       
       }    
       
 function PopDetallesR(p_id_servicio,DIM_NOMBRE_CLIENTE,DIM_DIRECCION,medidorv,DIM_DIAMETRO,DIM_RUTA,DIM_MARCA,DIM_NOM_LOCALIDAD,DIM_ORDEN_RUTA)
       {
       
       var url = 'POPSubirImagen.aspx?idServicio='+p_id_servicio+'&NOMBRE_CLIENTE='+DIM_NOMBRE_CLIENTE+'&DIRECCION='+DIM_DIRECCION+'&medidor='+medidorv+'&DIAMETRO='+DIM_DIAMETRO+'&RUTA='+DIM_RUTA+'&MARCA='+DIM_MARCA+'&NOM_LOCALIDAD='+DIM_NOM_LOCALIDAD+'&V_ORDEN_RUTA='+DIM_ORDEN_RUTA;
       window.open(url,'DetalleLectura','top=50%,left=50%,width=758,height=618,status=yes,resizable=no')
       Opener.Attributes.Add("Onclick", Clientscript);
       }          
function Sfecha() {
alert("Debe Seleccionar Fecha desde boton, no digitar!!!")

}
               
   </script>
</head>
<body>
    <form id="form1" runat="server">
    <img src="fotos/procesando3.gif" alt="" style="display:none;" />
    <img src="fotos/uploading.gif" alt="" style="display:none;" />
    
        <div>
            <table id="Table5" runat="server" align="center" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td id="panel_sesion">
                        <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                            Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                                Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                    Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                        ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_rut_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_id_usuario" runat="server" CssClass="Label" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
                </tr>
                <tr style="font-family: Trebuchet MS">
                    <td class="WebPartShadow" id="tbl_inicio" runat="server">
                        <table align="center" cellpadding="0">
                            <tr runat="server">
                                <td align="left" class="WebPartTitle_ext" colspan="6" nowrap="nowrap">
                                    Mantención Órdenes de Trabajo
                                </td>                             
                            </tr>
                            <tr runat="server">
                                <td align="left" colspan="3" nowrap="nowrap">
                                </td>
                                <td align="right" colspan="3" nowrap="nowrap">
                                    <asp:CheckBox ID="check_inconsistentes_repo" runat="server" Text="Mostrar reposiciones inconsistentes" AutoPostBack="True" Font-Names="Arial Unicode MS" Font-Size="Small" ForeColor="Navy" /></td>
                            </tr>
                            <tr id="Tr2" runat="server">
                                 <td align="left" colspan="3" nowrap="nowrap">
                                    <h2>Seleccione información y luego oprima "BUSCAR"</h2>                                                                              
                                 </td>
                                <td align="right" colspan="3" nowrap="nowrap">
                                    <asp:CheckBox ID="check_inconsistentes" runat="server" Text="Mostrar cortes inconsistentes" AutoPostBack="True" Font-Names="Arial Unicode MS" Font-Size="Small" ForeColor="Navy" /></td>                                     
                            </tr>
                            <tr runat="server" id="Tr3">
                                <td align="right" nowrap="nowrap">
                                    <asp:Label ID="lbl_servicio" runat="server" CssClass="Label" Text="Servicio:" Font-Size="9pt" Font-Names="calibri(cuerpo)"></asp:Label>&nbsp;</td>
                                <td align="left" nowrap="nowrap">
                                    <asp:TextBox ID="txt_servicio" runat="server" CssClass="TextBox3" ReadOnly="True" MaxLength="20" Width="106px"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="re_servicios" runat="server" ControlToValidate="txt_servicio"
                                        Display="Dynamic" ValidationExpression="^([0-9]{1,15})$" Font-Names="Arial Unicode MS" Font-Size="X-Small">Sólo números!</asp:RegularExpressionValidator></td>
                                <td align="left" nowrap="nowrap" style="text-align: right">
                                    <asp:Label ID="lbl_numOrden" runat="server" CssClass="Label" Text="Num Orden:" Font-Size="9pt" Font-Names="calibri(cuerpo)"></asp:Label>&nbsp;</td>
                                <td align="left" nowrap="nowrap">
                                    <asp:TextBox ID="txt_numorden" runat="server" CssClass="TextBox3" ReadOnly="True" MaxLength="15" Width="106px"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="re_num_orden" runat="server" ControlToValidate="txt_numorden"
                                        Display="Dynamic" ValidationExpression="^([0-9]{1,15})$" Font-Names="Arial Unicode MS" Font-Size="X-Small">Sólo números!</asp:RegularExpressionValidator></td>
                                <td align="left" nowrap="nowrap" style="text-align: right">
                                </td>
                                <td align="left" nowrap="nowrap">
                                </td>
                            </tr>
                            <tr id="Tr4" runat="server">
                                <td align="right" nowrap="nowrap" style="height: 19px">                                
                                    <h2 style="text-align: right">
                                        Proceso:&nbsp;
                                    </h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="height: 19px"><asp:DropDownList ID="combo_lotes" onchange="$.showprogress()" runat="server" CssClass="ComboBox2" AutoPostBack="True">
                                </asp:DropDownList></td>
                                <td align="left" nowrap="nowrap" style="text-align: right; width: 75px; height: 19px;">
                                   <h2>
                                       Clase OT:&nbsp;
                                   </h2></td>
                                <td align="left" nowrap="nowrap" style="height: 19px"><asp:DropDownList ID="clase_ot" onchange="$.showprogress()" runat="server" CssClass="ComboBox2" AutoPostBack="True">
                                </asp:DropDownList></td>
                                <td align="left" nowrap="nowrap" style="text-align: right; height: 19px;">
                                    <h2>
                                        Operador:
                                    </h2></td>
                                <td align="left" nowrap="nowrap" style="height: 19px">
                                    <asp:DropDownList ID="cbo_cortador" onchange="$.showprogress()" runat="server" CssClass="ComboBox2" AutoPostBack="True">
                                    </asp:DropDownList></td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap" style="height: 21px">
                                    <h2 style="text-align: right">
                                        Zona:&nbsp;
                                    </h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="height: 21px">
                                    <asp:DropDownList ID="Combozonas" onchange="$.showprogress()" runat="server" AutoPostBack="True" CssClass="ComboBox2">
                                    </asp:DropDownList></td>
                                <td align="left" nowrap="nowrap" style="width: 75px; height: 21px; text-align: right">
                                    <h2 style="text-align: right">
                                        Estado Asig:&nbsp;</h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="height: 21px">
                                    <asp:DropDownList ID="combo_Estados" onchange="$.showprogress()" runat="server" AutoPostBack="True" CssClass="ComboBox2">
                                    </asp:DropDownList></td>
                                <td align="left" nowrap="nowrap" style="height: 21px">
                                   <h2 style="text-align: right">Desde:</h2></td>
                                <td align="left" nowrap="nowrap" style="height: 21px">
                                    <asp:TextBox ID="txtDate1" runat="server" CssClass="TextBox2" ReadOnly="false"></asp:TextBox><img
                                        id="Img2" runat="server" onclick="openCalendar('txtDate1');" src="fotos/calendario.gif" alt="calendario2" /><asp:RequiredFieldValidator
                                            ID="validar_inf_fecha_desde" runat="server" ControlToValidate="txtDate1" ErrorMessage="*"
                                            Font-Bold="True" Height="8px" ValidationGroup="fecha" CssClass="ErrorMessage">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                                ID="validar_fecha_desde" runat="server" ControlToValidate="txtDate1" ErrorMessage="RegularExpressionValidator"
                                                Font-Bold="False" ValidationExpression="^[0-9]{2}-[0-9]{2}-[0-9]{4}$" ValidationGroup="fecha" CssClass="ErrorMessage" BackColor="Transparent" Font-Size="X-Small" Display="Dynamic">Fecha no válida</asp:RegularExpressionValidator></td>
                            </tr>
                            <tr id="Tr8" runat="server">
                                <td align="right" nowrap="nowrap">
                                    <h2>
                                        Localidad:&nbsp;</h2>
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:DropDownList ID="combo_localidades" onchange="$.showprogress()" runat="server" CssClass="ComboBox2" AutoPostBack="True">
                                    </asp:DropDownList></td>
                                <td align="left" nowrap="nowrap" style="width: 75px">
                                   <h2 style="text-align: right"> Ruta:&nbsp;</h2></td>
                                <td align="left" nowrap="nowrap">
                                    <asp:DropDownList ID="combo_ruta" runat="server" CssClass="ComboBox2" AutoPostBack="True">
                                    </asp:DropDownList></td>
                                <td align="left" nowrap="nowrap">
                                    <h2 style="text-align: right"> Hasta:</h2></td>
                                <td align="left" nowrap="nowrap">
                                    <asp:TextBox ID="txtDate2" runat="server" CssClass="TextBox2" ReadOnly="false"></asp:TextBox><img
                                        id="Img4" runat="server" onclick="openCalendar('txtDate2');" src="fotos/calendario.gif" alt="Calendario2" /><asp:RequiredFieldValidator
                                            ID="validar_inf_fecha_hasta" runat="server" ControlToValidate="txtDate2" ErrorMessage="*"
                                            Font-Bold="True" ValidationGroup="fecha" CssClass="ErrorMessage">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                                ID="validar_fecha_hasta" runat="server" ControlToValidate="txtDate2" ErrorMessage="RegularExpressionValidator"
                                                Font-Bold="False" ValidationExpression="^[0-9]{2}-[0-9]{2}-[0-9]{4}$" ValidationGroup="fecha" CssClass="ErrorMessage" BackColor="Transparent" Font-Size="X-Small" Display="Dynamic">Fecha no válida</asp:RegularExpressionValidator></td>
                            </tr>
                            <tr runat="server">
                                <td align="right" nowrap="nowrap">
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lb_cantidad_contratistas" runat="server"></asp:Label></td>
                                <td align="left" nowrap="nowrap" style="width: 75px">
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lb_codigos_contratistas" runat="server"></asp:Label></td>
                                <td align="left" nowrap="nowrap">
                                </td>
                                <td align="left" nowrap="nowrap" style="text-align: left">
                                </td>
                            </tr>
                            <tr runat="server" id="Tr14">
                                <td align="right" nowrap="nowrap" style="height: 19px">
                                    <h2>
                                        &nbsp;
                                        &nbsp;&nbsp;
                                    </h2></td>
                                <td align="left" nowrap="nowrap" style="height: 19px">
                                    &nbsp;
                                    </td>
                                <td align="left" nowrap="nowrap" style="width: 75px; height: 19px;">
                                   <h2 style="text-align: right"> &nbsp;</h2></td>
                                <td align="left" nowrap="nowrap" style="height: 19px"></td>
                                <td align="left" nowrap="nowrap" style="height: 19px">
                               <h2 style="text-align: right"> &nbsp;&nbsp;</h2></td>
                                <td align="left" nowrap="nowrap" style="text-align: right; height: 19px;">
                                    <asp:Button ID="btnBuscar" runat="server" CssClass="botonnew" Text="BUSCAR" CausesValidation="False" OnClientClick="$.showprogress()"/>
                                    </td>
                            </tr>
                            <tr runat="server">
                                <td align="center" colspan="6" nowrap="nowrap" style="height: 19px; text-align: center">
                                    <table style="width: 750px">
                                        <tr>
                                            <td width="33%" style="text-align:left;">
                                                <asp:Image ID="Image1" runat="server" ImageUrl="fotos/si.gif" Width="14" Height="13" />
                                                <asp:Label ID="Label2" runat="server" CssClass="Label" Text='Validación Claves "OK"'></asp:Label></td>
                                            <td width="33%" style="text-align:left;">
                                    <asp:Image ID="Image2" Width="14" Height="13" runat="server" ImageUrl="fotos/no.gif" /><asp:Label ID="Label1" runat="server" CssClass="Label" Text='Validación Claves "Error"'></asp:Label></td>
                                            <td width="33%" style="text-align:left;">
                                    <asp:Image ID="Image3" runat="server" Width="24" Height="13" ImageUrl="~/CYR/fotos/OKcamera.png" /><asp:Label ID="Label3" runat="server" CssClass="Label" Text="Registro Guardado Con Fotografía"></asp:Label></td>
                                        </tr>
                                    </table> 
                                </td>
                            </tr>
                                <tr runat="server">
                                    <td align="left" colspan="6" nowrap="nowrap" style="text-align: left;">
                                        <asp:TextBox ID="TextBox4" runat="server" BackColor="SandyBrown" CssClass="TextBox_totalizador"
                                            ReadOnly="True" Enabled="False"></asp:TextBox>
                                    <asp:Label ID="Label4" runat="server" CssClass="Label" Text="Orden Compromiso de Pago Expirada" Width="195px"></asp:Label>
                                        &nbsp;
                                    <asp:TextBox ID="TextBox2" runat="server" CssClass="TextBox_totalizador" ReadOnly="True" Enabled="False"></asp:TextBox>
                                    <asp:Label ID="Label6" runat="server" CssClass="Label" Text="Orden Normal"></asp:Label>
                                        &nbsp;
                                </td>
                            </tr>
                            <tr runat="server">
                                <td align="left" colspan="6" nowrap="nowrap" style="height: 17px; text-align: left;">
                                    <asp:Label ID="lb_error_filtro" runat="server" CssClass="ErrorMessage" Font-Names="Arial Unicode MS"
                                        Font-Size="Small" ForeColor="Red"></asp:Label></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table id="tbl_inicio2" runat="server" align="center" border="0" cellspacing="0" class="WebPartShadow">
                <tr>
                    <td align="left" class="WebPartShadow" colspan="2" style="width: 1727px">
                        <asp:FileUpload ID="ExcelResultados" runat="server" Width="371px" />
                        <asp:Button ID="btnImportarResultados"  runat="server" CausesValidation="False" CssClass="botonnew"
                        Text="Importar Resultados" Width="134px" ToolTip="Formato a importar debe ser Libro Excel 97-2003" />
                        <asp:Label ID="lb_msg_CargaArchivo" runat="server" Font-Names="Arial Unicode MS"
                            Font-Size="X-Small"></asp:Label>
                        <asp:Label ID="lb_error_CargaArchivo" runat="server" Font-Names="Arial Unicode MS"
                            Font-Size="X-Small" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="left" class="WebPartShadow" colspan="2" style="width: 1727px; height: 197px;">
                                    <asp:Label ID="LB_REGISTROS_GRID" runat="server" Text="0 coincidencia(s) encontrada(s)" CssClass="Label" Font-Names="Arial Unicode MS" Font-Size="X-Small" ForeColor="Maroon" Width="291px"></asp:Label><asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txt_codLector"
                        ErrorMessage="SOLO VALORES NUMÉRICOS PARA EL CODIGO DE CORTADOR!" Font-Names="Arial"
                        ValidationExpression="^([0-9]{1,4})$" CssClass="ErrorMessage"></asp:RegularExpressionValidator><asp:Label ID="lb_valida_tramos" runat="server" ForeColor="Red" Font-Names="Arial" CssClass="Label"></asp:Label><asp:Label ID="lb_valida" runat="server" ForeColor="Red" Font-Names="Arial" CssClass="Label"></asp:Label>
                            
                            <asp:DataGrid ID="GrillaPrincipal" runat="server"
                                            BorderColor="#003366" BorderStyle="Solid" BorderWidth="0px" CellPadding="1"
                                            CssClass="GridAlternativeItems" ForeColor="Black" GridLines="Horizontal" Height="1px" OnEditCommand="cmcarga_magen" CellSpacing="1" AllowSorting="True"  PageSize="100" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" AutoGenerateColumns="False" Width="1796px">
                                            <HeaderStyle BackColor="CornflowerBlue" BorderColor="Black" Font-Bold="True" Font-Underline="True"
                                                ForeColor="White" HorizontalAlign="Center" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Wrap="False" />
                                            <Columns>
                                                <asp:BoundColumn DataField="direccion" HeaderText="Direcci&#243;n">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" HorizontalAlign="Left" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="nom_cliente" HeaderText="Cliente">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" HorizontalAlign="Left" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="orden_ruta" HeaderText="Orden Ruta">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="NUMERO_ORDEN" HeaderText="N&#250;mero Orden">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="id_servicio" HeaderText="Servicio">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="medidor" HeaderText="Medidor">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="fecha" HeaderText="Fecha">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="hora" HeaderText="Hora">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:TemplateColumn HeaderText="C&#243;digo Orden">
                                                    <ItemTemplate>
                                                          <img alt="" id="btnDialog" src="fotos/icono_ayuda2.gif" onmouseover="MostrarCodigoOrden('MOSTRAR CODIGO ORDEN')" onmouseout="OcultarCodigoOrden('OCULTAR CODIGO ORDEN')"/>
                                                          <asp:TextBox ID="txt_orden" runat="server" CssClass="TextBox_totalizador" MaxLength="3" Text='<%# Eval("atendido") %>'></asp:TextBox><asp:RequiredFieldValidator ID="rq_orden" runat="server"
                                                                ControlToValidate="txt_orden" Display="Dynamic" ErrorMessage="*" CssClass="Required"></asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                                                    ID="rqexp_LECTURA" runat="server" ControlToValidate="txt_orden" Display="Dynamic"
                                                                    ErrorMessage="Sólo números 1,2,3,4" Font-Size="XX-Small" ValidationExpression="^([1-4]{1,4})$" CssClass="Required"></asp:RegularExpressionValidator>                                                                   
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Tipo Gesti&#243;n">
                                                    <ItemTemplate>
                                                    <% if check_inconsistentes.Checked = true or check_inconsistentes_repo.Checked=True   then %>
                                                    
                                                        <% if check_inconsistentes.Checked=true  then %>
                                                        <img alt="" id="Img5" src="fotos/icono_ayuda2.gif" onmouseover="MostrarTipoGestion('1','<%# Eval("ID_TIPOPROCESO") %>')" onmouseout="OcultarTipoGestion('OCULTAR TIPO GESTION')"/>
                                                        <% end if %>
                                                        <% if check_inconsistentes_repo.Checked=true  then %>
                                                        <img alt="" id="Img6" src="fotos/icono_ayuda2.gif" onmouseover="MostrarTipoGestion('0','<%# Eval("ID_TIPOPROCESO") %>')" onmouseout="OcultarTipoGestion('OCULTAR TIPO GESTION')"/>
                                                        <% end if %>        
                                                    <% else %>        
                                                        
                                                    
                                                        <img alt="" id="btnDialog2" src="fotos/icono_ayuda2.gif" onmouseover="MostrarTipoGestion('<%= clase_ot.SelectedIndex %>','<%# Eval("ID_TIPOPROCESO") %>')" onmouseout="OcultarTipoGestion('OCULTAR TIPO GESTION')"/>
                                                    <% end if %>
                                                        
                                                        <asp:TextBox ID="txt_ClaveInf" runat="server" CssClass="TextBox_totalizador" MaxLength="3"></asp:TextBox><asp:RequiredFieldValidator
                                                                ID="rq_claverq" runat="server" ControlToValidate="txt_ClaveInf" Display="Dynamic"
                                                                ErrorMessage="*" CssClass="Required"></asp:RequiredFieldValidator><asp:RegularExpressionValidator ID="rqexp_clave_rqexp"
                                                                    runat="server" ControlToValidate="txt_ClaveInf" Display="Dynamic" ErrorMessage="Sólo numeros o letras Mayúsculas"
                                                                    Font-Size="XX-Small" ValidationExpression="^([0-9A-Z]{1,3})$" CssClass="Required"></asp:RegularExpressionValidator>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Clave Lectura" Visible="False">
                                                    <ItemTemplate>
                                                        <img alt="" id="btnDialog3" src="fotos/icono_ayuda2.gif" onmouseover="MostrarClaveLectura('1')" onmouseout="OcultarClaveLectura('OCULTAR CLAVE LECTURA')"/>
                                                        <asp:TextBox ID="txt_ClaveLectura" Text='<%# Eval("COD_CLAVE_LECTURAPDA") %>' runat="server" CssClass="TextBox_totalizador" MaxLength="3"></asp:TextBox><asp:RequiredFieldValidator ID="rq_clave_lectura" runat="server"
                                                                ControlToValidate="txt_ClaveLectura" Display="Dynamic" ErrorMessage="*" CssClass="Required"></asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                                                    ID="rqexp_clave_lect" runat="server" ControlToValidate="txt_ClaveLectura" Display="Dynamic"
                                                                    ErrorMessage="Sólo numeros o letras Mayúsculas" Font-Size="XX-Small" ValidationExpression="^([0-9A-Z]{1,3})$" CssClass="Required"></asp:RegularExpressionValidator>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="7%" Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Lectura">
                                                    <ItemTemplate>
                                                     
                                                        <asp:TextBox ID="txt_lecturainf" runat="server" CssClass="TextBox_totalizador" MaxLength="8" Text='<%# Eval("LECTURA") %>' ToolTip="Lectura "></asp:TextBox><asp:RequiredFieldValidator ID="rq_lecturaL" runat="server"
                                                                ControlToValidate="txt_lecturainf" Display="Dynamic" ErrorMessage="*" CssClass="Required"></asp:RequiredFieldValidator><asp:Label
                                                                    ID="lb_valida_rango" runat="server" Font-Size="XX-Small" ForeColor="Red" CssClass="Required"></asp:Label><asp:RegularExpressionValidator
                                                                        ID="rqexp_LECTURAL" runat="server" ControlToValidate="txt_lecturainf" Display="Dynamic"
                                                                        ErrorMessage="Sólo números" Font-Size="XX-Small" ValidationExpression="^([0-9]{1,12})$" CssClass="Required"></asp:RegularExpressionValidator>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Fecha Ejecuci&#243;n (dd-mm-yyyy)">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txt_FechaEjecucion" runat="server" CssClass="TextBox2" Text='<%# Eval("FECHA_EJECUCION") %>' Width="72px"></asp:TextBox>
                                                        <asp:RegularExpressionValidator ID="ER_FechaEjecucion" runat="server" ControlToValidate="txt_FechaEjecucion"
                                                            ErrorMessage="*" ValidationExpression="(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d" Display="Dynamic"></asp:RegularExpressionValidator>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txt_FechaEjecucion"
                                                            Display="Dynamic" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                        <asp:Label ID="lb_valida_FechaActual" runat="server" Font-Names="Arial Unicode MS"
                                                            Font-Size="X-Small" ForeColor="Red"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Hora Ejecuci&#243;n (HH:MM)">
                                                    <ItemTemplate>        
                                                        <asp:TextBox ID="txt_HoraEjecucion" runat="server" CssClass="TextBox2" Text='<%# Eval("HORA_EJECUCION") %>' Width="60px"></asp:TextBox>                                                        
                                                        <asp:RequiredFieldValidator ID="RFV_HoraEjecucion" runat="server" ControlToValidate="txt_HoraEjecucion"
                                                            Display="Dynamic" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                        <asp:RegularExpressionValidator ID="ER_HoraEjecucion" runat="server" ControlToValidate="txt_HoraEjecucion"
                                                            ErrorMessage="*" ValidationExpression="([0-1][0-9]|2[0-3]):[0-5][0-9]" Display="Dynamic"></asp:RegularExpressionValidator>
                                                        <asp:Label ID="lb_valida_Hora" runat="server" Font-Names="Arial Unicode MS" Font-Size="X-Small"
                                                            ForeColor="Red"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>

                                                <asp:TemplateColumn HeaderText="Nro Sello" Visible="False">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txt_sello" runat="server" CssClass="TextBox2" MaxLength="50"
                                                            Text='<%# Eval("NUM_SELLO") %>' ToolTip="Número de Sello"></asp:TextBox>                                                            
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:TemplateColumn>

                                                <asp:TemplateColumn HeaderText="Observaciones">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txt_Observaciones" runat="server" CssClass="TextBox2" MaxLength="50"
                                                            Text='<%# Eval("OBSERVACION") %>' ToolTip="Observación"></asp:TextBox>                                                            
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:TemplateColumn>                                                
                                                <asp:TemplateColumn HeaderText="Error Claves">
                                                    <ItemTemplate>                                                   
                                                        <asp:Image ID="img_ok" runat="server" ImageUrl="fotos/si.gif" Visible="False" /><asp:Image ID="img_error"
                                                            runat="server" ImageUrl="fotos/no.gif" Visible="False" />
                                                        <asp:Image ID="img_camaraok"
                                                            runat="server" ImageUrl="~/fotos/camera_ok.PNG" Visible="False" Width="28px" />
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:TemplateColumn>
                                                <asp:BoundColumn DataField="atendido" HeaderText="ATENDIDO" Visible="False">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="COD_CLAVE_LECTURAPDA" HeaderText="CLAVE LECTURA" Visible="False">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="COD_CLAVECORTEPDA" HeaderText="COD_CLAVECORTEPDA" Visible="False">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="COD_CLAVEIMPROCEDENTEPDA" HeaderText="COD_CLAVEIMPROCEDENTEPDA" Visible="False">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="lectura" HeaderText="LECTURA2" Visible="False">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>

                                                <asp:BoundColumn DataField="OBSERVACION" HeaderText="OBSERVACION" Visible="False">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:EditCommandColumn CancelText="Cancelar" EditText="SUBIR FOTOGRAFIA" HeaderText="Fotograf&#237;a"
                                                    UpdateText="Actualizar">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:EditCommandColumn>
                                                <asp:BoundColumn DataField="DIAMETRO" HeaderText="DIAMETRO" Visible="False">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="LIBRETA" HeaderText="LIBRETA" Visible="False">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="MARCA" HeaderText="MARCA" Visible="False">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="NOM_LOCALIDAD" HeaderText="NOM_LOCALIDAD" Visible="False">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="ID_GRUPOPROCESO" HeaderText="ID_GRUPOPROCESO" Visible="False">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="COD_CORTADOR" HeaderText="COD_CORTADOR" Visible="False">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="ID_EVALUACION_FOTOGRAFIA" HeaderText="ID_EVALUACION_FOTOGRAFIA"
                                                    Visible="False">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="ID_CORTADOR" HeaderText="ID_CORTADOR" Visible="False">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="ID_TIPOPROCESO" HeaderText="ID_TIPOPROCESO" Visible="False"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="NIVEL_SOLICITADO" HeaderText="NIVEL_SOLICITADO" Visible="False">
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="MINIMO" HeaderText="MIN" Visible="False"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="MAXIMO" HeaderText="MAX" Visible="False"></asp:BoundColumn>
                                                
                                                
                                            </Columns>

                                            <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                                                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Mode="NumericPages" Wrap="False" />
                                            <ItemStyle BackColor="White" HorizontalAlign="Center" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                            <AlternatingItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <EditItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <SelectedItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                           </asp:DataGrid>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: left; width: 1727px;">                    
                        <img alt="" id="Img3" runat="server" src="fotos/ok.bmp" style="width: 28px; height: 16px;" width="0" />
                        <asp:Label ID="lb_mensaje" runat="server" Font-Names="Arial Unicode MS" CssClass="Label" Width="543px" Font-Bold="False" ForeColor="#0000C0" Font-Size="Small"></asp:Label>                    
                        &nbsp;&nbsp;
                        <asp:Label ID="lb_error_claves" runat="server" CssClass="ErrorMessage" Font-Names="Arial Unicode MS"
                            Font-Size="Small" ForeColor="Red"></asp:Label>
                        <asp:Label ID="lb_error" runat="server" CssClass="ErrorMessage" Font-Names="Arial Unicode MS"
                            Font-Size="Small" ForeColor="Red"></asp:Label></td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: left; width: 1727px;">
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: right;">
                        &nbsp;<asp:Button ID="btnExcel"  runat="server" CausesValidation="False" CssClass="botonnew"
                        Text="Generar Excel" ToolTip="Guardar en formato Libro Excel 97-2003" />
                        <asp:Button ID="btnActualiza" runat="server" CausesValidation="False" CssClass="botonnew"
                        Text="Guardar Cambios" Width="116px" />
                        <asp:Button ID="btnValida_Datos" runat="server"
                            CausesValidation="False" CssClass="botonnew" Text="Validar datos" />
                        <asp:Button ID="btnVolver" runat="server" CssClass="botonnew" Text="<< Volver" ValidationGroup="ninguno" /></td>
                </tr>
            </table>
        </div>
        <table id="panel_subirImagen" runat="server" align="center" border="0" cellpadding="0" cellspacing="0"
            class="WebPartShadow" visible="true">
            <tr>
                <td>
                    <asp:TextBox ID="txt_id_evaluacion_fotografia" runat="server" Width="2px" Visible="False"></asp:TextBox>                            
                    <asp:TextBox ID="txt_cod_cortador" runat="server" Width="2px" Visible="False"></asp:TextBox>
                    <asp:TextBox ID="txt_id_grupoproceso" runat="server" Width="2px" Visible="False"></asp:TextBox>
                    <asp:TextBox ID="txt_numero_orden" runat="server" Width="2px" Visible="False"></asp:TextBox>
                    <asp:TextBox ID="txt_hora" runat="server" Width="2px" Visible="False"></asp:TextBox>
                    <asp:TextBox ID="txt_fecha" runat="server" Width="1px" Visible="False"></asp:TextBox>
                    <asp:TextBox ID="txt_EfecoImpro" runat="server" Visible="False" Width="11px"></asp:TextBox></td>
            </tr>
            <tr style="font-size: 12pt; font-family: Times New Roman">
                <td>
                    <div class="WebPartShadow">
                        <div class="WebPartTitle_ext">
                            Carga de imagenes...</div>
                        <table id="Table4" runat="server" align="center" border="0" cellspacing="4" class="WebPartShadow">
                            <tr>
                                <td align="right" colspan="2" nowrap="nowrap" style="height: 10px">
                                    </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="2" nowrap="nowrap">
                                    <table id="Table2" align="center" border="0" cellspacing="0" class="WebPartShadow">
                                        <tr id="Tr6" runat="server">
                                            <td align="right" colspan="1" nowrap="nowrap">
                                              <h2>
                                                  Servicio: &nbsp;
                                              </h2></td>
                                            <td align="left" colspan="3" nowrap="nowrap">
                                                <asp:TextBox ID="txt_id_servicio" runat="server" CssClass="TextBox" ReadOnly="True" Width="526px"></asp:TextBox></td>
                                        </tr>
                                        <tr id="Tr7" runat="server">
                                            <td align="right" colspan="1" nowrap="nowrap" style="height: 27px">
                                                <h2>
                                                    &nbsp;Nombre Cliente: &nbsp;
                                                </h2>
                                            </td>
                                            <td align="left" colspan="3" nowrap="nowrap">
                                                <asp:TextBox ID="txt_nomCliente" runat="server" CssClass="TextBox" ReadOnly="True"
                                                    Width="526px"></asp:TextBox></td>
                                        </tr>
                                        <tr id="Tr9" runat="server">
                                            <td align="right" colspan="1" nowrap="nowrap" style="height: 6px">
                                                <h2>
                                                    &nbsp;Dirección: &nbsp;
                                                </h2>
                                            </td>
                                            <td align="left" colspan="3" nowrap="nowrap" style="height: 6px">
                                                <asp:TextBox ID="txt_Direccion" runat="server" CssClass="TextBox" ReadOnly="True"
                                                    Width="526px"></asp:TextBox></td>
                                        </tr>
                                        <tr id="Tr11" runat="server">
                                            <td align="right" nowrap="nowrap" style="width: 117px; height: 33px">
                                                <h2>
                                                    Medidor: &nbsp;</h2>
                                            </td>
                                            <td align="left" nowrap="nowrap" style="height: 33px">
                                                <asp:TextBox ID="txt_medidor" runat="server" CssClass="TextBox" ReadOnly="True" Width="135px"></asp:TextBox></td>
                                            <td align="right" style="width: 71px; height: 33px">
                                                <h2 style="text-align: right">
                                                    Marca:</h2>
                                            </td>
                                            <td style="height: 33px">
                                                <asp:TextBox ID="txt_marca_medidor" runat="server" CssClass="TextBox" ReadOnly="True"
                                                    Width="152px"></asp:TextBox></td>
                                        </tr>
                                        <tr id="Tr12" runat="server">
                                            <td align="right" nowrap="nowrap" style="width: 117px; height: 17px">
                                                <h2>
                                                    Diámetro medidor: &nbsp;</h2>
                                            </td>
                                            <td align="left" nowrap="nowrap" style="height: 17px">
                                                <asp:TextBox ID="txt_diametro_medidor" runat="server" CssClass="TextBox" ReadOnly="True"
                                                    Width="135px"></asp:TextBox></td>
                                            <td align="right" style="width: 71px; height: 17px">
                                                <h2 style="text-align: right">
                                                    Localidad:</h2>
                                            </td>
                                            <td style="height: 17px">
                                                <asp:TextBox ID="txt_localidad" runat="server" CssClass="TextBox" ReadOnly="True"
                                                    Width="152px"></asp:TextBox></td>
                                        </tr>
                                        <tr id="Tr13" runat="server">
                                            <td align="right" nowrap="nowrap" style="width: 117px; height: 6px">
                                                <h2>
                                                    Ruta: &nbsp;</h2>
                                            </td>
                                            <td align="left" nowrap="nowrap" style="height: 6px">
                                                <asp:TextBox ID="txt_ruta" runat="server" CssClass="TextBox" ReadOnly="True" Width="152px"></asp:TextBox></td>
                                            <td align="right" style="width: 71px; height: 6px;">
                                                <h2 style="text-align: right">
                                                    Orden Ruta:</h2>
                                            </td>
                                            <td style="text-align: left; height: 6px;">
                                                <asp:TextBox ID="txt_ordenRuta" runat="server" CssClass="TextBox" ReadOnly="True"
                                                    Width="150px"></asp:TextBox></td>
                                        </tr>
                                        <tr id="Tr10" runat="server">
                                            <td align="right" nowrap="nowrap" style="width: 117px; height: 4px">
                                                <h2>
                                                    &nbsp;</h2>
                                            </td>
                                            <td align="left" nowrap="nowrap" style="height: 4px">
                                                <asp:Label ID="lb_id_grupoproceso_img" runat="server" Text=""></asp:Label></td>
                                            <td style="width: 71px; height: 4px;">
                                            </td>
                                            <td style="height: 4px">
                                                </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="row_individual_cuerpo" runat="server">
                                <td align="left" colspan="2" nowrap="nowrap">
                                    <table id="row_todos_encabezado" runat="server" border="0" cellspacing="0">
                                        <tr>
                                            <td class="WebPartTitle_ext" colspan="4" style="height: 6px">
                                                Seleccione Archivos
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="width: 392px; text-align: right">
                                                <h2>
                                                    Agregar Foto Fachada:</h2>
                                            </td>
                                            <td colspan="2" style="height: 16px; text-align: left">
                                                <asp:FileUpload ID="FileUpload1" runat="server" CssClass="botonnew" Width="400px" />
                                                <asp:Label ID="lb_img1" runat="server" CssClass="Label"></asp:Label>
                                                <asp:RequiredFieldValidator ID="VAL1" runat="server" ControlToValidate="FileUpload1"
                                                    ErrorMessage="*" ValidationGroup="grupo2" CssClass="Required"></asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr style="color: #000000">
                                            <td colspan="2" style="width: 392px; height: 5px; text-align: right">
                                                <h2>
                                                    Agregar Foto Instalacion:</h2>
                                            </td>
                                            <td colspan="2" style="height: 5px; text-align: left">
                                                <asp:FileUpload ID="FileUpload2" runat="server" CssClass="botonnew" Width="400px" />
                                                <asp:Label ID="lb_img2" runat="server" CssClass="Label"></asp:Label>
                                                <asp:RequiredFieldValidator ID="VAL2" runat="server" ControlToValidate="FileUpload2"
                                                    ErrorMessage="*" ValidationGroup="grupo2" CssClass="Required"></asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr style="color: #000000">
                                            <td colspan="2" style="width: 392px; height: 22px; text-align: right">
                                                <h2>
                                                    Agregar Foto
                                                    Medidor:</h2>
                                            </td>
                                            <td colspan="2" style="height: 22px; text-align: left">
                                                <asp:FileUpload ID="FileUpload3" runat="server" CssClass="botonnew" Width="400px" />
                                                <asp:Label ID="lb_img3" runat="server" CssClass="Label"></asp:Label>
                                                </td>
                                        </tr>
                                        <tr style="color: #000000">
                                            <td colspan="2" style="width: 392px; height: 26px; text-align: right">
                                                <h2>
                                                    Agregar Foto Documento:</h2>
                                            </td>
                                            <td colspan="2" style="height: 26px; text-align: left">
                                                <asp:FileUpload ID="FileUpload4" runat="server" CssClass="botonnew" Width="400px" />
                                                <asp:Label ID="lb_img4" runat="server" CssClass="Label"></asp:Label>
                                                </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="width: 392px; height: 18px; text-align: right">
                                                <h2>
                                                    &nbsp;Agregar Foto Número Fiscal:</h2>
                                            </td>
                                            <td colspan="2" style="height: 18px; text-align: left">
                                                <asp:FileUpload ID="FileUpload5" runat="server" CssClass="botonnew" Width="400px" />
                                                <asp:Label ID="lb_img5" runat="server" CssClass="Label"></asp:Label>
                                                </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="row_todos_cuerpo" runat="server">
                                <td colspan="2" style="height: 14px">
                                    <table border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td colspan="3" style="height: 19px">
                                                <asp:Button ID="btnCargaTodas" runat="server" CssClass="botonnew" Text="Subir Imagenes"
                                                    ValidationGroup="grupo2" OnClientClick="$.showprogressUpload()" CausesValidation="False" />&nbsp;
                                                <asp:Button ID="btn_back" runat="server" CssClass="botonnew" Text="<< Volver"
                                                    ValidationGroup="ninguno" /></td>
                                        </tr>
                                    </table>
                                    </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2">
                                    <asp:Label ID="lb_size_todas" runat="server" Font-Names="Arial" Font-Size="Small" CssClass="Label" Font-Bold="True" ForeColor="Navy"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <asp:Label ID="lb_mensaje_error" runat="server" Font-Bold="True" Font-Names="Arial"
                        Font-Size="X-Small" ForeColor="Red" CssClass="Label"></asp:Label></td>
            </tr>
            <tr style="font-family: Times New Roman">
               
                 </tr>
        </table>
        <table align="center" runat="server" border="0" cellpadding="0" cellspacing="0" style="width: 758px;
            height: 152px" width="758" id="tbl_detalles">
            <tr>
                <td style="width: 732px; height: 1px;">
                    <div class="WebPartShadow_ext" id="panel_detalles" runat="server">
                        <div id="Div4" runat="server" class="WebPartTitle_ext">
                            Detalle Asignación de tramos...</div>
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
                                        ErrorMessage="Error en De Orden ruta: Sólo números! " ValidationExpression="^([0-9]{1,10})$" Font-Names="Arial"></asp:RegularExpressionValidator>
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
                                <td align="right" colspan="2" style="width: 759px"><table cellpadding="0" cellspacing="0" style="width: 960px" class="WebPartShadow">
                                    <tr>
                <td style="width:30%; height: 55px;" align="left">
                <h2>Ingrese Código Cortador:<input id="txt_codLector" runat="server" type="text" style="width: 82px" class="TextBox" />
                                        <img alt="" src="fotos/lupa.bmp" onclick="openLectores('txt_codLector');" id="IMG1" /></h2> 
                </td>
                <td  style="width:65%; text-align: center; height: 55px;">
                    <asp:DropDownList ID="comboExcel" runat="server" CssClass="ComboBox" Enabled="False"
                        Width="128px">
                        <asp:ListItem>Excel 97 - 2000</asp:ListItem>
                        <asp:ListItem>Excel 2003 - 2007</asp:ListItem>
                    </asp:DropDownList>
                    <asp:Button ID="btnExportExcel" runat="server" CssClass="botonnew" Height="29px"
                        Text="Exportar Excel" Width="120px" />
                    <asp:Button ID="btnAsignaLector" runat="server" CssClass="botonnew" Text="Asignar Cortador" Width="120px" Height="29px" />
                    <asp:Button
                        ID="btnDesasignaTramo" runat="server" CssClass="botonnew" Height="29px" Text="Des-Asignar"
                        Width="120px" />
                    </td>
                                    </tr>
                                    <tr>
                <td align="left" colspan="2" style="height: 15px">
                    <asp:Label ID="VALIDACION_CODIGO_LECTOR" runat="server" Font-Names="Arial" ForeColor="Red"
                        Width="603px"></asp:Label>
                    <asp:Button ID="btnTramos" runat="server" CssClass="botonnew" Text="Asignar Tramo" Width="120px" Height="29px" Visible="False" />
                    <asp:Button ID="btnLiberaAsignacion" runat="server" CssClass="botonnew" Text="Liberar Asignacion" Width="120px" Height="29px" Visible="False" />
                    <table align="center" style="width: 920px; height: 1px" cellpadding="0">
                        <tr>
                                <td align="left" colspan="6" nowrap="nowrap" style="height: 9px; text-align: left">
                       <asp:Image ID="img_ok" runat="server" ImageUrl="fotos/ok.bmp" /><asp:Label ID="lb_mensaje_liberacion" runat="server" Font-Names="Arial" ForeColor="#0000C0" Width="720px"></asp:Label></td>
                        </tr>
                    </table>
                </td>
                                    </tr>
                                </table>
                                    &nbsp;
                                    </td>
                            </tr>
                        </table>  
                    </div>                  </td>
            </tr>
        </table>
        <asp:DataGrid ID="GrillaClvefectivas" runat="server" AllowSorting="True" AutoGenerateColumns="False"
            CellPadding="3" CssClass="GridAlternativeItems"
            Height="76px" HorizontalAlign="Center" 
             PageSize="6" Width="2834px" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" Visible="False">
            <FooterStyle BackColor="White" ForeColor="#000066" />
            <ItemStyle ForeColor="#000066" />
            <Columns>
                <asp:BoundColumn DataField="id_claveefectivo" HeaderText="id_claveefectivo">
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="cod_clavecortepda" HeaderText="cod_clavecortepda">
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="cod_clavecortesap" HeaderText="cod_clavecortesap">
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="descripcion" HeaderText="descripcion">
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="estado" HeaderText="estado">
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="atendido" HeaderText="atendido"></asp:BoundColumn>
                <asp:BoundColumn DataField="rut_empresa" HeaderText="rut_empresa"></asp:BoundColumn>
                <asp:BoundColumn DataField="id_tipoorden" HeaderText="id_tipoorden"></asp:BoundColumn>
                <asp:BoundColumn DataField="tipo_corte" HeaderText="tipo_corte"></asp:BoundColumn>
                <asp:BoundColumn DataField="foto_fachada" HeaderText="foto_fachada"></asp:BoundColumn>
                <asp:BoundColumn DataField="foto_precorte" HeaderText="foto_precorte"></asp:BoundColumn>
                <asp:BoundColumn DataField="foto_medidor" HeaderText="foto_medidor"></asp:BoundColumn>
                <asp:BoundColumn DataField="foto_corte" HeaderText="foto_corte"></asp:BoundColumn>
                <asp:BoundColumn DataField="foto_sello" HeaderText="foto_sello"></asp:BoundColumn>
                <asp:BoundColumn DataField="foto_lectura" HeaderText="foto_lectura"></asp:BoundColumn>
                <asp:BoundColumn DataField="foto_num_casa" HeaderText="foto_num_casa"></asp:BoundColumn>
                <asp:BoundColumn DataField="foto_documento" HeaderText="foto_documento"></asp:BoundColumn>
                <asp:BoundColumn DataField="foto_reposicion" HeaderText="foto_reposicion"></asp:BoundColumn>
                <asp:BoundColumn DataField="foto_filtracion" HeaderText="foto_filtracion"></asp:BoundColumn>
            </Columns>
            <HeaderStyle BackColor="#006699" Font-Bold="True" Font-Size="13px" Font-Underline="True"
                ForeColor="White" HorizontalAlign="Center" /><SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" NextPageText="Siguientes"
                PrevPageText="Anteriores" Mode="NumericPages" />
        </asp:DataGrid><br />
        &nbsp;<asp:DataGrid ID="GrillaClvImprocedentes" runat="server" AllowSorting="True" AutoGenerateColumns="False"
            CellPadding="3" CssClass="GridAlternativeItems"
            Height="76px" HorizontalAlign="Center" 
             PageSize="6" Width="2834px" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellSpacing="2" Visible="False">
            <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
            <SelectedItemStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
            <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" NextPageText="Siguientes"
                PrevPageText="Anteriores" Mode="NumericPages" />
            <ItemStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
            <Columns>
                <asp:BoundColumn DataField="ID_CLAVEIMPROCEDENTE" HeaderText="ID_CLAVEIMPROCEDENTE">
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="COD_CLAVEIMPROCEDENTEPDA" HeaderText="COD_CLAVEIMPROCEDENTEPDA">
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="COD_CLAVEIMPROCEDENTESAP" HeaderText="COD_CLAVEIMPROCEDENTESAP ">
                </asp:BoundColumn>
                <asp:BoundColumn DataField="DESCRIPCION" HeaderText="DESCRIPCION">
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="SOLICITA_GESTION" HeaderText="SOLICITA_GESTION"></asp:BoundColumn>
                <asp:BoundColumn DataField="INHIBIDA" HeaderText="INHIBIDA">
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="ESTADO" HeaderText="ESTADO"></asp:BoundColumn>
                <asp:BoundColumn DataField="ATENDIDO" HeaderText="ATENDIDO"></asp:BoundColumn>
                <asp:BoundColumn DataField="RUT_EMPRESA" HeaderText="RUT_EMPRESA">
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="ID_TIPOORDEN" HeaderText="ID_TIPOORDEN"></asp:BoundColumn>
                <asp:BoundColumn DataField="FOTO_PAGO" HeaderText="FOTO_PAGO"></asp:BoundColumn>
                <asp:BoundColumn DataField="FOTO_DOCUMENTO" HeaderText="FOTO_DOCUMENTO"></asp:BoundColumn>
                <asp:BoundColumn DataField="FOTO_FACHADA" HeaderText="FOTO_FACHADA"></asp:BoundColumn>
                <asp:BoundColumn DataField="FOTO_MEDIDOR" HeaderText="FOTO_MEDIDOR"></asp:BoundColumn>
                <asp:BoundColumn DataField="FOTO_VARALES" HeaderText="FOTO_VARALES"></asp:BoundColumn>
                <asp:BoundColumn DataField="FOTO_NUM_CASA" HeaderText="FOTO_NUM_CASA"></asp:BoundColumn>
                <asp:BoundColumn DataField="FOTO_FILTRACION" HeaderText="FOTO_FILTRACION"></asp:BoundColumn>
                <asp:BoundColumn DataField="FOTO_LLAVE" HeaderText="FOTO_LLAVE"></asp:BoundColumn>
                <asp:BoundColumn DataField="FOTO_CORTE_ANTERIOR" HeaderText="FOTO_CORTE_ANTERIOR"></asp:BoundColumn>
            </Columns>
            <HeaderStyle BackColor="#A55129" Font-Bold="True" Font-Size="13px" Font-Underline="True"
                ForeColor="White" HorizontalAlign="Center" />
        </asp:DataGrid>&nbsp;
        <asp:DataGrid ID="ClavesLecturas" runat="server" AllowSorting="True" AutoGenerateColumns="False"
            CellPadding="4" CssClass="GridAlternativeItems"
            Height="76px" HorizontalAlign="Center" 
             PageSize="6" Width="2834px" BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px" Visible="False">
            <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
            <SelectedItemStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
            <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" NextPageText="Siguientes"
                PrevPageText="Anteriores" />
            <ItemStyle BackColor="White" ForeColor="#330099" />
            <Columns>
                <asp:BoundColumn DataField="ID_CLAVE_LECTURA" HeaderText="ID_CLAVE_LECTURA">
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="RUT_EMPRESA" HeaderText="RUT_EMPRESA">
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="COD_CLAVE_LECTURAPDA" HeaderText="COD_CLAVE_LECTURAPDA">
                </asp:BoundColumn>
                <asp:BoundColumn DataField="COD_CLAVE_LECTURASGC" HeaderText="COD_CLAVE_LECTURASGC">
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="DESCRIPCION" HeaderText="DESCRIPCION"></asp:BoundColumn>
                <asp:BoundColumn DataField="ATENDIDO" HeaderText="ATENDIDO">
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="VALIDA" HeaderText="VALIDA"></asp:BoundColumn>
                <asp:BoundColumn DataField="PARAMETROS" HeaderText="PARAMETROS"></asp:BoundColumn>
                <asp:BoundColumn DataField="PRC_TIPO_TRANSACCION" HeaderText="PRC_TIPO_TRANSACCION">
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="True" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="PRC_ESTADO" HeaderText="PRC_ESTADO"></asp:BoundColumn>
                <asp:BoundColumn DataField="PRC_OBSERVACION" HeaderText="PRC_OBSERVACION"></asp:BoundColumn>
                <asp:BoundColumn DataField="PRC_FECHA_ACTUALIZACION" HeaderText="PRC_FECHA_ACTUALIZACION ">
                </asp:BoundColumn>
                <asp:BoundColumn DataField="IND_ACTIVACION" HeaderText="IND_ACTIVACION"></asp:BoundColumn>
                <asp:BoundColumn DataField="ID_SGLCLAVEL" HeaderText="ID_SGLCLAVEL"></asp:BoundColumn>
                <asp:BoundColumn DataField="METODO_CONSUMO" HeaderText="METODO_CONSUMO"></asp:BoundColumn>
            </Columns>
            <HeaderStyle BackColor="#990000" Font-Bold="True" Font-Size="13px" Font-Underline="True"
                ForeColor="#FFFFCC" HorizontalAlign="Center" />
        </asp:DataGrid>
     
 
    <asp:DataGrid ID="DataGrid_aux" runat="server" AutoGenerateColumns="False"
                                            BorderColor="#003366" BorderStyle="Solid" BorderWidth="0px" CellPadding="1"
                                            CssClass="GridAlternativeItems" ForeColor="Black" GridLines="Horizontal" Height="1px"
                                            Width="960px" CellSpacing="1" PageSize="50" Visible="False">
            <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                                                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                                                VerticalAlign="Middle" />
            <AlternatingItemStyle BackColor="White" />
            <ItemStyle BackColor="White" HorizontalAlign="Center" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
            <Columns>
                <asp:BoundColumn DataField="id_grupoproceso" HeaderText="IDgrupoproceso" Visible="False">
                </asp:BoundColumn>
                <asp:BoundColumn DataField="id_servicio" HeaderText="id_servicio" Visible="False"></asp:BoundColumn>
                <asp:BoundColumn DataField="nom_tipoorden" HeaderText="Tipo Orden">
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" HorizontalAlign="Center" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="numero_orden" HeaderText="Num Orden"></asp:BoundColumn>
                <asp:BoundColumn DataField="nom_localidad" HeaderText="Localidad"></asp:BoundColumn>
                <asp:BoundColumn DataField="ruta" HeaderText="Ruta"></asp:BoundColumn>
                <asp:BoundColumn DataField="nivel_corte" HeaderText="Nivel "></asp:BoundColumn>
                <asp:BoundColumn DataField="id_sincronizacion" HeaderText="id_sincronizacion" Visible="False">
                </asp:BoundColumn>
                <asp:BoundColumn DataField="estado" HeaderText="Estado"></asp:BoundColumn>
                <asp:BoundColumn DataField="libreta" HeaderText="Libreta(ruta)" Visible="False">
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" HorizontalAlign="Center" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="nom_cortador" HeaderText="Cortador"></asp:BoundColumn>
                <asp:BoundColumn DataField="id_cortador" HeaderText="id_cortador" Visible="False"></asp:BoundColumn>
                <asp:BoundColumn DataField="nombre" HeaderText="nombre" Visible="False"></asp:BoundColumn>
                <asp:BoundColumn DataField="apellido" HeaderText="apellido" Visible="False"></asp:BoundColumn>
                <asp:BoundColumn DataField="fecha_generacion" HeaderText="Fecha Generacion"></asp:BoundColumn>
                <asp:BoundColumn DataField="id_localidad" HeaderText="id_localidad" Visible="False">
                </asp:BoundColumn>
                <asp:BoundColumn DataField="medidor" HeaderText="Medidor" Visible="False"></asp:BoundColumn>
                <asp:BoundColumn DataField="id_tipoorden" HeaderText="id_tipoorden" Visible="False">
                </asp:BoundColumn>
                <asp:BoundColumn DataField="grupo" HeaderText="GRUPO" Visible="False"></asp:BoundColumn>
                <asp:BoundColumn DataField="cod_cortador" HeaderText="cod_cortador" Visible="False">
                </asp:BoundColumn>
            </Columns>
                   
       
                   
                   <HeaderStyle BackColor="CornflowerBlue" BorderColor="Black" Font-Bold="True" Font-Underline="True"
                                                ForeColor="White" HorizontalAlign="Center" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" />
        </asp:DataGrid>
     
 
    </form>    
</body>
</html>
