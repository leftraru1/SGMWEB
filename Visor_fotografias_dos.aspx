<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Visor_fotografias_dos.aspx.vb" Inherits="Visor_fotografias_dos" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" > 
<head runat="server"> 

 
 <title>Visor Fotografico - Sistema CYR </title> 
 
  
      <link type="text/css" rel="stylesheet" href="estilos/page.css">
      <link type="text/css" rel="stylesheet" href="estilos/controls.css">
      <link type="text/css" rel="stylesheet" href="estilos/grid.css">
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css">
      <link type="text/css" rel="stylesheet" href="estilos/menu.css">
      <link type="text/css" rel="stylesheet" href="estilos/others.css">
      
      <script src="/js/PopBox.js"  type="text/javascript"></script> 
      
       <script type="text/javascript">
popBoxWaitImage.src = "/images/spinner40.gif";
popBoxRevertImage = "/images/magminus.gif";
popBoxPopImage = "/images/magplus.gif";
</script>  
      
     <script type="text/javascript" language="javascript"> 

 function PopDetalles(p_var_foto)      
 {
 var url = 'zoom_image.aspx?var_foto='+p_var_foto; 
 open(url,'DetalleLecturas','top=20,left=100,width=1200,height=700,status=yes,resizable=yes,scrollbars=yes');
 }  
              
</script>
    
</head> 
<body style="text-align: center"> 


<form id="form1" runat="server"> 
<div style="text-align: center"> <div id="Div1" runat="server" class="WebPartTitle_analizador" style="text-align: left; width: 912px;">
    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></div>
    <table cellspacing="0" style="width: 1px; text-align: left;" class="WebPartShadow_analizador" frame="border">
        <tr>
            <td colspan="7" style="height: 3px; text-align: left;">
                <div id="titulo_mod" runat="server" class="WebPartTitle_analizador" style="text-align: left; width: 912px;">
                    Visor Fotografias en proceso 2.0</div>
                <asp:RadioButtonList ID="tipo_busqueda" runat="server" AutoPostBack="True" Font-Names="Arial"
                    Height="17px" RepeatDirection="Horizontal" Width="328px">
                    <asp:ListItem Selected="True" Value="BUSQUEDA SERVICIO">BUSQUEDA SERVICIO</asp:ListItem>
                    <asp:ListItem Value="CARGA DE ARCHIVO">CARGA DE ARCHIVO</asp:ListItem>
                </asp:RadioButtonList></td>
        </tr>
        <tr>
            <td colspan="7" style="height: 4px; text-align: left">
                &nbsp;<table cellspacing="0" style="width: 704px; text-align: center; height: 1px;" id="TBL_BUSQUEDA_SERVICIO" runat="server">
                    <tr>
                        <td align="right" style="width: 20%; height: 30px">
                            <h2>
                                Servicio&nbsp;
                            </h2>
                        </td>
                        <td style="width: 34%; height: 30px;">
                            <asp:TextBox ID="txt_servicio" runat="server" CssClass="TextBox" Font-Names="Arial"
                                Font-Size="X-Small" Width="135px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_servicio"
                                ErrorMessage="*" Width="1px"></asp:RequiredFieldValidator></td>
                        <td style="width: 20%; height: 30px;">
                            <asp:ImageButton ID="btn_busqueda" runat="server" ImageUrl="~/fotos/img_buscar.gif" />
                            </td>
                        <td style="width: 20%; height: 30px;">
                            <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label></td>
                        <td style="width: 20%; height: 30px">
                            <asp:Button ID="btn_back" runat="server" CssClass="Button" Text="<< Volver Menu"
                                Width="120px" ValidationGroup="grupo_inexistente" /></td>
                    </tr>
                </table>
                <table id="TBL_CARGA_ARCHIVO" runat="server" align="center" border="0" cellspacing="4" style="width: 709px;
                    height: 66px" width="709">
                    <tr>
                        <td align="left" colspan="2" nowrap="nowrap" style="height: 15px">
                            <h2>
                                Por favor, carge el archivo con servicios a visualizar:
                                <asp:FileUpload ID="CargaArchivo" runat="server" Width="371px" ToolTip="Archivo Que Contiene Numero de Servicio, el cual visualizara imagenes conformes de este." />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="CargaArchivo"
                                    ErrorMessage="Sólo archivos en formato TXT" ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))+(.txt|.TXT|.TxT)$"></asp:RegularExpressionValidator></h2>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 9px; text-align: left">
                            <asp:Button ID="btnCargaRutero" runat="server" CssClass="Button" Text="Cargar Archivo"
                                Width="128px" />&nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2" style="height: 9px; text-align: left;">
                            &nbsp;<img id="Img1" runat="server" src="fotos/ok.bmp" visible="false" /><asp:Label ID="Label1" runat="server"
                                Font-Bold="True" Font-Names="Arial" ForeColor="Navy" Width="792px"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" style="height: 3px">
                            &nbsp;<asp:Button ID="btnVolver" runat="server" CssClass="Button" Text="<< Volver Menu"
                                Width="120px" /></td>
                    </tr>
                &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</table>
            </td>
        </tr>
        <tr>
            <td colspan="7" style="height: 4px; text-align: center">
                <asp:Label ID="lb_error" runat="server" Font-Names="Arial" ForeColor="Red" Width="272px"></asp:Label><img id="img_ok" runat="server" src="fotos/ok.bmp" style="height: 16px" visible="false" />
                <asp:Label ID="lb_mensaje" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="Navy"
                    Width="592px"></asp:Label></td>
        </tr>
    </table>
</div> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    <asp:DataGrid ID="Grillafotografia" runat="server" AutoGenerateColumns="False"  
        BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1" CssClass="GridAlternativeItems"
        Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
        Font-Underline="False" GridLines="Horizontal" Height="1px" PageSize="3" Width="920px">
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
            <asp:BoundColumn DataField="archivo" HeaderText="Servicio">
                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                    Font-Underline="False" Width="15%" />
                <ItemStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Size="Large"
                    Font-Strikeout="False" Font-Underline="True" />
            </asp:BoundColumn>
            <asp:TemplateColumn HeaderText="Fotografias">
                <ItemTemplate>
                    &nbsp;<asp:DataList ID="DataList2" runat="server" RepeatDirection="Horizontal">
                        <ItemTemplate>
                            <asp:ImageButton ID="ImageButton1" runat="server" Width="368px" Height="160px" />
                            <asp:Label ID="lbl_eval" runat="server" Text="Label" Width="368px"></asp:Label>
                        </ItemTemplate>
                    </asp:DataList>
                </ItemTemplate>
                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                    Font-Underline="False" />
            </asp:TemplateColumn>
        </Columns>
        <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False"
            Font-Strikeout="False" Font-Underline="False" ForeColor="White" HorizontalAlign="Center" />
    </asp:DataGrid>
    <asp:DataGrid ID="Grillafotografia2" runat="server" AutoGenerateColumns="False"  
        BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1" CssClass="GridAlternativeItems"
        Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
        Font-Underline="False" GridLines="Horizontal" Height="1px" PageSize="3" Width="128px" Visible="False">
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
            <asp:BoundColumn DataField="archivo_2" HeaderText="Archivo(INDICE DATALIST2 TEMPORAL)">
                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                    Font-Underline="False" Width="15%" />
            </asp:BoundColumn>
        </Columns>
        <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False"
            Font-Strikeout="False" Font-Underline="False" ForeColor="White" HorizontalAlign="Center" />
    </asp:DataGrid>
    &nbsp; &nbsp;
    &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; 
</form> 
</body> 
</html> 

