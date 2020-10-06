<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Visor_fotografia.aspx.vb" Inherits="Visor_fotografia" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" > 
<head id="Head1" runat="server"> 

 
 <title>Visor Fotografico - Sistema CYR </title> 
 
  
      <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/others.css"/>
      
      
<script type="text/javascript"> 

function Nodigita() {
//document.getElementById("i1").style.display="" ;
document.i1.style.display="";
}      

     function VER_IMAGEN(pUrlImagen)
      {
        var url = 'VerImagen.aspx?URL=' + pUrlImagen;
        window.open(url,'cal','width=720,height=590,left=25,top=25,resizable=1,scrollbars=yes');
      }

</script>      
      
      
<script type="text/javascript" language="javascript"> 
function zoomImage(idImg,i)

{
 
msie = navigator.appVersion.indexOf("MSIE")>0;
 
IF (msie){
objref.style.zoom = i+'%';
}
ELSE {
rx = objref.naturalWidth;
ry = objref.naturalHeight;
 
objref.width = (i*rx)/100;
objref.height =  (i*ry)/100;
}
}    

    </script>
    
</head> 
<body style="text-align: center" id="imgHTML"> 


<form id="form1" runat="server"> 
<div style="text-align: center"> 
    <table id="Table5" runat="server" align="center" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="panel_sesion" style="text-align: left">
    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
        </tr>
        <tr style="font-family: Trebuchet MS">
            <td id="tbl_inicio" runat="server" class="WebPartShadow">
                <table align="center" cellpadding="0">
                    <tr runat="server">
                        <td align="left" class="WebPartTitle_ext" colspan="6" nowrap="nowrap">
                            <asp:RadioButtonList ID="Sector_busqueda" runat="server" CssClass="Label"
                                Font-Names="Arial" Height="36px" RepeatDirection="Horizontal" Width="220px" ToolTip='*En proceso: "Cuando servicios a consultar, no han sido cerrados y transferidos a historicos" *Historicos: "Cuando servicios han sido cerrados y transferidos a Historicos".' AutoPostBack="True">
                                <asp:ListItem Selected="True" Value="0">En Proceso</asp:ListItem>
                                <asp:ListItem Value="1">Hist&#243;ricos</asp:ListItem>
                            </asp:RadioButtonList>
                            <asp:Label ID="lb_rut_empresa" runat="server" CssClass="Label"></asp:Label></td>
                    </tr>
                    <tr id="Tr1" runat="server">
                        <td align="left" class="WebPartTitle_ext" colspan="6" nowrap="nowrap">
                    Visor Fotografías</td>
                    </tr>
                    <tr runat="server">
                        <td align="left" colspan="6" nowrap="nowrap" rowspan="1">
                            <h2>Ingrese Número de Servicio y presione "BUSCAR"</h2>
                        </td>
                    </tr>
                    <tr id="Tr3" runat="server">
                        <td align="center" colspan="6" nowrap="nowrap" rowspan="4">
                <table cellspacing="0" style="width: 548px">
                    <tr>
                        <td style="width: 25%; text-align:right;">
                            <h2>
                                Número de Servicio:&nbsp;
                            </h2>
                        </td>
                        <td style="width: 5%;">
                            &nbsp;&nbsp;
                        </td>
                        <td style="width: 45%; text-align:left;">
                            <asp:TextBox ID="txt_servicio" runat="server" CssClass="TextBox2" Font-Names="Arial"
                                Font-Size="X-Small" ToolTip="Servicio."></asp:TextBox>
                            <asp:RegularExpressionValidator ID="rqexp_LECTURA" runat="server" ControlToValidate="txt_servicio"
                                CssClass="Label" Display="Dynamic" ErrorMessage="Sólo números" Font-Size="XX-Small"
                                ValidationExpression="^([0-9]{1,12})$"></asp:RegularExpressionValidator><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_servicio"
                                ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator>&nbsp;</td>
                        <td style="width: 25%; text-align:left;">
                            <asp:ImageButton ID="btn_busqueda" runat="server" ImageUrl="~/fotos/img_buscar.gif" ToolTip="Buscar: Realizar la busqueda de fotografias de cierto servicio ingresado en caja de texto." /></td>
                    </tr>
                    <tr>
                        <td style="width: 25%; text-align:right;">
                        <h2>Número de Orden:&nbsp;
                        </h2>
                        </td>
                        <td style="width: 5%;">
                            </td>
                        <td style="width: 45%; text-align:left;">
                            <asp:DropDownList ID="comboNumeroOrden" runat="server" AutoPostBack="True" CssClass="ComboBox"
                                Width="224px">
                            </asp:DropDownList></td>
                        <td style="width: 25%;">
                        </td>
                    </tr>
                </table>
                            <asp:Label ID="lb_numero_orden" runat="server"></asp:Label>
                            <asp:Label ID="lb_id_grupoproceso" runat="server"></asp:Label>
                            <asp:Label ID="lb_cod_cortador" runat="server"></asp:Label>
                            <asp:Label ID="lb_cantidad_contratistas" runat="server"></asp:Label>
                            <asp:Label ID="lb_codigos_contratistas" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                    </tr>
                    <tr id="Tr8" runat="server">
                    </tr>
                    <tr id="Tr14" runat="server">
                    </tr>
                    <tr id="Tr4" runat="server">
                        <td align="left" colspan="6" nowrap="nowrap" style="text-align: left">
                <img id="img_ok" runat="server" src="fotos/ok.bmp" style="height: 16px" visible="false" />
                <asp:Label ID="lb_mensaje" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="Navy"
                    Width="592px" CssClass="Label"></asp:Label>
                <asp:Label ID="lb_error" runat="server" Font-Names="Arial" ForeColor="Red" CssClass="Label"></asp:Label></td>
                    </tr>
                    <tr runat="server">
                        <td align="left" colspan="6" nowrap="nowrap" style="text-align: right">
                            <asp:Button ID="btnVolver" runat="server" CausesValidation="False" CssClass="botonnew"
                                Text="<< Volver " /></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="font-family: Trebuchet MS">
            <td runat="server" class="WebPartShadow" id="Td1">
                &nbsp;&nbsp;
                <table style="width: 192px">
                    <tr>
                        <td style="width: 890px">
                        <asp:DataGrid ID="GrillaFotos" runat="server" AutoGenerateColumns="False"
                    BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1" CssClass="GridAlternativeItems"
                    Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                    Font-Underline="False" GridLines="Horizontal" Height="1px" PageSize="3" Width="884px">
                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" />
                    <EditItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" />
                    <SelectedItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" />
                    <PagerStyle BackColor="Control" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                        Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Mode="NumericPages"
                        NextPageText="Siguientes" PageButtonCount="1" PrevPageText="Anteriores" />
                    <AlternatingItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                        Font-Strikeout="False" Font-Underline="False" />
                    <ItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                        Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                    <Columns>
                        <asp:TemplateColumn HeaderText="Foto Fachada">
                            <ItemTemplate>
                                <asp:ImageButton ID="btn_img1" runat="server" Height="100px" Width="100px"/>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="Foto Instalaci&#243;n">
                            <ItemTemplate>
                                <asp:ImageButton ID="btn_img2" runat="server" Height="100px" Width="100px"/>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="Foto Medidor">
                            <ItemTemplate>
                                <asp:ImageButton ID="btn_img3" runat="server" Height="100px" Width="100px"/>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="Foto Documento">
                            <ItemTemplate>
                                <asp:ImageButton ID="btn_img4" runat="server" Height="100px" Width="100px"/>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="Foto N&#250;mero Fiscal">
                            <ItemTemplate>
                                <asp:ImageButton ID="btn_img5" runat="server" Height="100px" Width="100px"/>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                    </Columns>
                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                        Font-Strikeout="False" Font-Underline="False" ForeColor="White" HorizontalAlign="Center" />
                </asp:DataGrid>
                            </td>
                    </tr>
                    <tr>
                        <td style="text-align:center; font-weight: bold; color: white; height: 17px; background-color: cornflowerblue; width: 900px;" align="center" >
                            LISTADO DE IMAGENES ENCONTRADAS</td>
                    </tr>
                   <tr>
                        <td align="left" style="width: 890px">
                            <asp:Label ID="lb_registros" runat="server" Font-Names="Arial Unicode MS" Font-Size="Small" Width="900px"></asp:Label></td>
                    </tr>                    
                    <tr>
                        <td style="width: 890px">
                            <asp:GridView ID="gv1" runat="server" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" Width="900px">
                                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Visualizar Imagen">
                                        <ItemTemplate>
                                            &nbsp;<img alt="Click para ampliar" src="" runat="server" style="width: 100px; height: 95px" id="imgHTML"/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" ForeColor="#F7F7F7" />
                                <AlternatingRowStyle BackColor="#F7F7F7" />
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
                &nbsp;
            </td>
        </tr>
    </table>
</div> 
</form> 
</body> 
</html> 

