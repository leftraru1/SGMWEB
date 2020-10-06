<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MantencionMensajes.aspx.vb" Inherits="MantencionMensajes" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Mantenedor de Mensajes - Sistema CYR</title>
      <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/others.css"/> 
      
      
<%--      <style type="text/css">
body {
margin:0;
width: 100%;
height: 100%;
}
</style>

<script type="text/javascript" language="JavaScript1.2">
window.moveTo(0,0);
top.window.resizeTo(screen.availWidth,screen.availHeight);

</script>   --%>
      
      <script type="text/javascript" language="javascript">    
      
         function PopDetalles_mensaje(id_mensaje,cod_lector,nombre_lector,apellido_lector,asunto,mensaje,id_zona,id_lector,tipo_mensaje,id_sincronizacion)
       {
       var url = 'Vistamensajepop.aspx?i_id_mensaje='+id_mensaje+'&i_cod_lector='+cod_lector+'&i_nombre_lector='+nombre_lector+'&i_apellido_lector='+apellido_lector+'&i_asunto='+asunto+'&i_mensaje='+mensaje+'&i_id_zona='+id_zona+'&i_id_lector='+id_lector+'&i_tipo_mensaje='+tipo_mensaje+'&i_id_sincronizacion='+id_sincronizacion;
       open(url,'DetalleLectura','top=20,left=50,width=900,height=480,status=yes,resizable=no');
        
       }     
      
          function PopDetalles_marcar_como_leido(id_mensaje,marca)
       {
       var url = 'Mensajepop_noleido.aspx?i_id_mensaje='+id_mensaje+'&i_marca='+marca;
       open(url,'DetalleLectura','top=20,left=50,width=900,height=480,status=yes,resizable=no');
      
       }     
     
          function PopDetalles_marcar_como_no_leido(id_mensaje,marca)
       {
       var url = 'Mensajepop_noleido.aspx?i_id_mensaje='+id_mensaje+'&i_marca='+marca;
       open(url,'DetalleLectura','top=20,left=50,width=900,height=480,status=yes,resizable=no');
      
       }  
      
   </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 984px;
            height: 152px">
            <tr>
                <td style="width: 725px">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 725px">
                    <div class="WebPartShadow_ext" style="width: 936px">
                        <div class="WebPartTitle_ext" id="titulo_mod" runat="server">
                            Mantencion Mensajes
                            <asp:Image ID="Image2" runat="server" Height="16px" ImageUrl="~/fotos/book_open.png"
                                                        Width="24px" /></div>
                        <table align="center" border="0" cellspacing="0" style="width: 920px; height: 1px">
                            <tr id="criterio_busqueda" runat="server">
                                <td align="right" nowrap="nowrap" style="width: 41%; height: 14px">
                                <h2>
                                    &nbsp;</h2></td>
                                <td align="left" nowrap="nowrap" style="width: 411px; height: 14px">
                                    </td>
                            </tr>
                            <tr id="row_l1" runat="server">
                                <td align="left" nowrap="nowrap" style="width: 41%; height: 15px">
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 411px; height: 15px">
                                    <asp:Label ID="lb_cantidad_contratistas" runat="server"></asp:Label>
                                    <asp:Label ID="lb_codigos_contratistas" runat="server"></asp:Label></td>
                            </tr>
                            <tr  id="row_l2" runat="server">
                                <td align="left" nowrap="nowrap" style="height: 15px">
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 411px; height: 15px">
                                    <h2>
                                        &nbsp;
                                    &nbsp;</h2>
                                </td>
                            </tr>
                            <tr id="row_empresa" runat="server">
                                <td align="left" colspan="2" nowrap="nowrap" style="height: 15px">
                                <h2>
                                    &nbsp;</h2>
                                </td>
                            </tr>
                            <tr runat="server">
                                <td align="right" colspan="2" style="height: 3px; text-align: left">
                                    <asp:RadioButtonList ID="Sector_busqueda" runat="server" AutoPostBack="True" Font-Names="Arial"
                                        RepeatDirection="Horizontal" TextAlign="Left" Width="320px">
                                        <asp:ListItem Selected="True" Value="No Le&#237;dos">No Le&#237;dos</asp:ListItem>
                                        <asp:ListItem Value="Le&#237;dos">Le&#237;dos</asp:ListItem>
                                        <asp:ListItem>Todos</asp:ListItem>
                                        <asp:ListItem>Enviados</asp:ListItem>
                                    </asp:RadioButtonList></td>
                            </tr>
                            <tr id="tr_btn_agrega" runat="server">
                                <td align="right" colspan="2" style="height: 3px; text-align: center;">
                                    &nbsp;<asp:LinkButton ID="btnAgregaLector" runat="server" Font-Bold="True" Font-Names="Arial"
                                        ForeColor="#0000C0">Enviar Mensaje Operador</asp:LinkButton></td>
                            </tr>
                            <tr runat="server">
                                <td align="right" colspan="2" style="height: 3px; text-align: left">
                                        <asp:Label ID="lb_cantidad_registros" runat="server" Text="coincidencia(s) encontrada(s)" Width="153px"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="text-align: right">
                                    <div class="WebPartShadow" style="text-align: center" id="div_grilla" runat="server">
                                        <asp:DataGrid ID="GrillaLectores" runat="server" OnDeleteCommand="cmDelete" OnEditCommand="MyDataGrid_Edit" OnUpdateCommand="cmUpdate" AutoGenerateColumns="False" BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1"
                                            CssClass="GridAlternativeItems" GridLines="Horizontal" Height="1px"
                                            Width="872px" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" AllowPaging="True">
                                            <HeaderStyle Font-Bold="True" Font-Underline="False" HorizontalAlign="Center" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" ForeColor="White" />
                                            <Columns>
                                                <asp:BoundColumn DataField="id_mensaje" HeaderText="id_mensaje" Visible="False">
                                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                        Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="cod_lector" HeaderText="Operador">
                                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                        Font-Strikeout="False" Font-Underline="False" ForeColor="White" Width="29%" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" HorizontalAlign="Left" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="nombre_lector" HeaderText="Nombre_lector" Visible="False">
                                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                        Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="apellido_lector" HeaderText="Apellido Lector" Visible="False">
                                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                        Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="asunto" HeaderText="Asunto">
                                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                        Font-Strikeout="False" Font-Underline="False" ForeColor="White" Width="30%" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" HorizontalAlign="Left" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="mensaje" HeaderText="Mensaje" Visible="False">
                                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                        Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="id_zona" HeaderText="id_zona" Visible="False">
                                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                        Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="id_cortador" HeaderText="id_cortador" Visible="False">
                                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                        Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="tipo_mensaje" HeaderText="Tipo_mensaje" Visible="False">
                                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                        Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="id_sincronizacion" HeaderText="id_sincronizacion" Visible="False">
                                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                        Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="estado" HeaderText="Estado">
                                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                        Font-Strikeout="False" Font-Underline="False" ForeColor="White" Width="10%" />
                                                </asp:BoundColumn>
                                                <asp:TemplateColumn HeaderText="Leer." Visible="False">
                                                    <ItemTemplate>
                                                        &nbsp;<img id="btnDetalles" runat="server" src="fotos/hoja.gif" />
                                                    </ItemTemplate>
                                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                        Font-Strikeout="False" Font-Underline="False" ForeColor="White" Width="10%" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Marcar le&#237;do" Visible="False">
                                                    <ItemTemplate>
                                                        <img id="btnmleidos" runat="server" src="fotos/book_open.png" />
                                                    </ItemTemplate>
                                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                        Font-Strikeout="False" Font-Underline="False" ForeColor="White" Width="10%" />
                                                </asp:TemplateColumn>
                                                <asp:EditCommandColumn CancelText="Cancel" EditText="Leer" HeaderText="Leer Mensaje"
                                                    UpdateText="Update">
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" ForeColor="#0000CC" />
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" ForeColor="Green" />
                                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                        Font-Strikeout="False" Font-Underline="False" ForeColor="White" Width="10%" />
                                                </asp:EditCommandColumn>
                                                <asp:TemplateColumn HeaderText="Marcar No le&#237;do" Visible="False">
                                                    <ItemTemplate>
                                                        <img id="btnmnoleidos" runat="server" src="fotos/book.png" />
                                                    </ItemTemplate>
                                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                        Font-Strikeout="False" Font-Underline="False" ForeColor="White" Width="10%" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" ForeColor="#0000CC" />
                                                </asp:TemplateColumn>
                                                <asp:ButtonColumn CommandName="Delete" HeaderText="Marcar" Text="No Le&#237;do">
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" ForeColor="#0000CC" />
                                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                        Font-Strikeout="False" Font-Underline="False" ForeColor="White" Width="10%" />
                                                </asp:ButtonColumn>
                                                <asp:ButtonColumn CommandName="update" HeaderText="Marcar" Text="Le&#237;do">
                                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                        Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" ForeColor="#0000CC" />
                                                </asp:ButtonColumn>
                                            </Columns>
                                            <PagerStyle Font-Bold="True" Font-Italic="False"
                                                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Mode="NumericPages" BackColor="Control" NextPageText="Siguientes" PrevPageText="Anteriores" />
                                            <ItemStyle BackColor="White" HorizontalAlign="Center" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                            <AlternatingItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                            <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" />
                                            <EditItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" />
                                            <SelectedItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" />
                                        </asp:DataGrid>
                                     </div>
                                    <asp:Label ID="valida_borra_lector" runat="server" Font-Names="Arial" ForeColor="Red"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="height: 1px">
                                <div class="WebPartShadow" style="text-align: center" id="div_nuevo_lector" runat="server">
                                    <table style="width: 832px;" id="tbl_ingreso_lector" runat="server">
                                        <tr>
                                            <td align="right" style="width: 249px; height: 27px">
                                            </td>
                                            <td align="right" colspan="3" style="height: 27px">
                                            </td>
                                            <td style="width: 30%; height: 27px">
                                                <asp:Label ID="lbEmpresaLector" runat="server" Font-Names="Arial"></asp:Label>
                                                <asp:Label ID="lbRutEmpresa" runat="server" Font-Names="Arial"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 249px; height: 17px">
                                                <h2><strong>
                                                    <asp:Image ID="Image1" runat="server" Height="16px" ImageUrl="~/fotos/book_open.png"
                                                        Width="24px" />
                                                    &nbsp;Destinatario:&nbsp; </strong></h2></td>                                                
                                            <td colspan="4" style="height: 17px">
                                                <h2 style="text-align: left"><strong>
                                                <asp:DropDownList ID="combo_Lector" runat="server" CssClass="ComboBox" Width="384px" AutoPostBack="True">
                                            </asp:DropDownList>&nbsp;</strong></h2>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 249px; height: 17px;" align="right">
                                                <h2><strong>Asunto:&nbsp; </strong></h2></td>
                                            <td colspan="4" style="height: 17px; text-align: left">
                                                <strong>
                                                <asp:TextBox ID="txt_asunto" runat="server" CssClass="TextBox" MaxLength="50" Width="376px"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txt_asunto"
                                                    ErrorMessage="*" Width="1px"></asp:RequiredFieldValidator></strong></td>
                                        </tr>
                                        <tr>
                                            <td colspan="5" style="height: 17px">
                                                <h2 style="text-align: left"><strong>&nbsp;&nbsp; Mensaje:</strong></h2>
                                                <h2 style="text-align: center">
                                                    <strong>&nbsp; </strong>
                                                <asp:TextBox ID="txt_mensaje" runat="server" CssClass="TextBox" MaxLength="200" Width="680px" Height="88px" TextMode="MultiLine"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_mensaje"
                                                    ErrorMessage="*" Width="1px"></asp:RequiredFieldValidator></h2>
                                                <h2><strong>&nbsp; </strong></h2>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5" style="height: 8px">
                                                &nbsp;<asp:Label ID="lbl_error" runat="server" ForeColor="Red" Width="352px"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td colspan="5" style="height: 8px; text-align: right">
                                                <asp:Label ID="lb_id_usuario" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr>
                                          
                                            <td align="right" style="height: 7px" colspan="5">
                                                &nbsp;<asp:Button ID="btnInsertaLector" runat="server" CssClass="botonnew" Text="Enviar Mensaje"
                                                    Width="120px" />
                                                <asp:Button ID="btnCancelar" runat="server" CssClass="botonnew" Text="Cancelar" Width="120px" CausesValidation="False" />
                    <asp:Button ID="btnVolver" runat="server" CssClass="botonnew" Text="<< Volver" Width="120px" CausesValidation="False" />
                                            </td>
                                        </tr>
                                    </table>
                                    <table style="width: 728px; height: 1px;" id="tbl_ingreso_ok" runat="server">
                                    <tr>
                                    <td align="left">
                                    <img id="img_ok" runat="server" src="fotos/ok.bmp" />
                                    <asp:Label ID="lb_mensaje_ingreso"
                                        runat="server" Font-Names="Arial Unicode MS" Width="476px" Font-Size="Small" ForeColor="#0000C0"></asp:Label></td>
                                    </tr>
                                    </table>
                                </div>
                                    </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="height: 1px">                                
                                    <asp:Button ID="btn_actualiza" runat="server" CssClass="botonnew" Text="Actualizar Mensajes"
                                        Width="128px" />
                                    <asp:Button ID="btn_aceptar" runat="server" CssClass="botonnew" Text="Aceptar" Width="120px" CausesValidation="False" />
                                    <asp:Button ID="btn_volver2" runat="server" CssClass="botonnew" Text="<< Volver " Width="120px" CausesValidation="False" /></td>
                            </tr>
                        </table>
                    </div>
                    </td>
            </tr>
        </table>
    
    </div>
        &nbsp;
    </form>
</body>
</html>
