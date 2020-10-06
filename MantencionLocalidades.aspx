<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MantencionLocalidades.aspx.vb" Inherits="MantencionLocalidades" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Mantenedor de Localidades - Sistema CYR</title>
    <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/others.css"/> 
    <link type="text/css" rel="stylesheet" href="estilos/style.css"/> 
 
    
        
<%--    
<script language="JavaScript1.2">
window.moveTo(0,0);
top.window.resizeTo(screen.availWidth,screen.availHeight);
</script> --%>
    
    
     <script type="text/javascript" language="javascript">    
     function openRangos(id_de_localidad)
      {
        //var url = 'POPLectores.aspx?textbox=' + obj;
        var url = 'POPRangos.aspx?idLocalidad='+id_de_localidad;
        window.open(url,'cal','width=800,height=300,left=200,top=50,resizable=0,scrollbars=0');
      }    

   </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 758px;
            height: 1px" width="758">
            <tr>
                <td style="width: 732px">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 732px; height: 1px;">
                    <div class="WebPartShadow_ext" style="width: 1003px">
                        <div class="WebPartTitle_ext" style="width: 997px">
                            Mantenedor de Localidades</div>
                        <table align="center" border="0" cellspacing="0" style="width: 999px; height: 1px">
                            <tr>
                                <td align="left" nowrap="nowrap" style="width: 41%; height: 15px">
                                <h2>
                                    Por favor, seleccione Región para ver Zonas:</td>
                                <td align="left" nowrap="nowrap" style="height: 15px; width: 418px;">                                <asp:DropDownList ID="comboRegiones"
                                            runat="server" CssClass="ComboBox" Width="165px" AutoPostBack="True">
                                        </asp:DropDownList>
                                    <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label>
                                    <asp:Label ID="lb_id_perfil" runat="server"></asp:Label>
                                    <asp:Label ID="lb_id_usuario" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap" style="height: 5px">
                                <h2> 
                                    Por favor, seleccione Zona para ver Localidades:</td>
                                <td align="left" nowrap="nowrap" style="height: 5px; width: 418px;">
                                    <h2>
                                        <asp:DropDownList ID="comboZonas" runat="server" CssClass="ComboBox" Width="165px" AutoPostBack="True">
                                        </asp:DropDownList>
                                        <asp:Button ID="BtnVerLocalidades" runat="server" CssClass="botonnew" Text="Ver Localidades"
                                            Width="102px" /></h2>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="height: 3px">
                                    &nbsp;<asp:LinkButton ID="btn_IngresaLocalidad" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0">Agregar Localidad</asp:LinkButton></td>
                            </tr>
                            <tr> 
                                <td colspan="2" align="right"><div class="WebPartShadow" style="text-align: justify">
                                    <asp:Label ID="lb_mensaje_coincidencias" runat="server" Width="377px"></asp:Label>
                                    <asp:DataGrid ID="GrillaLocalidades" runat="server" OnDeleteCommand="cmDelete" AutoGenerateColumns="False" CssClass="GridAlternativeItems" OnEditCommand="MyDataGrid_Edit"
                                        Width="967px" BorderColor="#003366" BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1" ForeColor="Black" GridLines="Horizontal" Height="1px">
                                        <HeaderStyle HorizontalAlign="Center" BackColor="CornflowerBlue" Font-Bold="True" Font-Underline="True" ForeColor="White" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" />
                                        <Columns>
                                            <asp:BoundColumn DataField="id_localidad" HeaderText="IDLocalidad" Visible="False"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="id_zona" HeaderText="IDZona" Visible="False"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="id_region" HeaderText="IDRegion" Visible="False"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="cod_localidad" HeaderText="C&#243;digo Localidad">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="nombre" HeaderText="Nombre Localidad">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="rut_empresa" HeaderText="RutEmpresa" Visible="False"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="nom_empresa" HeaderText="Empresa">
                                            </asp:BoundColumn>
                                            <asp:TemplateColumn HeaderText="Rango de Validaci&#243;n" Visible="False">
                                                <ItemTemplate>
                                                    <asp:Image ID="img_rangos" runat="server" ImageUrl="fotos/hoja.gif" />
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:BoundColumn HeaderText="Operador Asignado" DataField="nombre_cortador_asignado"></asp:BoundColumn>
                                            <asp:TemplateColumn HeaderText="Activaci&#243;n Operador Asignado">
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="cbo_cortador" runat="server" Width="103px" AutoPostBack="True" >
                                                        <asp:ListItem>Activado</asp:ListItem>
                                                        <asp:ListItem>Desactivado</asp:ListItem>
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:EditCommandColumn CancelText="Cancel" EditText="Editar" HeaderText="Modificar"
                                                UpdateText="Update">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" ForeColor="#0000CC" />
                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" ForeColor="Green" />
                                            </asp:EditCommandColumn>
                                            <asp:ButtonColumn CommandName="Delete" HeaderText="Eliminar" Text="Eliminar">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" ForeColor="#0000CC" />
                                            </asp:ButtonColumn>
                                            <asp:BoundColumn DataField="ID_CORTADOR_ASIGNADO" HeaderText="ID_CORTADOR_ASIGNADO"
                                                Visible="False"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="ESTADO_CORTADOR_ASIGNADO" HeaderText="ESTADO_CORTADOR_ASIGNADO"
                                                Visible="False"></asp:BoundColumn>
                                        </Columns>
                                        <PagerStyle BorderColor="Transparent" BackColor="Control" Font-Bold="True" VerticalAlign="Middle" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center"  BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                        <AlternatingItemStyle BackColor="White" />
                                    </asp:DataGrid>
                                    <asp:Label ID="lb_valida_asignaciones" runat="server" ForeColor="Red" Width="536px"></asp:Label></div>
                                    <asp:Button ID="btnExcel" runat="server" CausesValidation="False" CssClass="botonnew"
                                        Text="Exportar Excel" Width="120px" />
                    <asp:Button ID="btnVolver" runat="server" CssClass="botonnew" Text="<< Volver" Width="120px" /></td>                                    
                            </tr>
                        </table>
                    </div>
                    </td>
            </tr>
            <tr>
                <td align="left" style="width: 732px"><asp:DataGrid ID="GrillaLocalidadesExcel" runat="server" OnDeleteCommand="cmDelete" AutoGenerateColumns="False" CssClass="GridAlternativeItems" OnEditCommand="MyDataGrid_Edit"
                                        Width="967px" BorderColor="#003366" BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1" ForeColor="Black" GridLines="Horizontal" Height="1px" Visible="False">
                    <PagerStyle BorderColor="Transparent" BackColor="Control" Font-Bold="True" VerticalAlign="Middle" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                    <AlternatingItemStyle BackColor="White" />
                    <ItemStyle HorizontalAlign="Center"  BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                    <Columns>
                        <asp:BoundColumn DataField="id_localidad" HeaderText="IDLocalidad" Visible="False"></asp:BoundColumn>
                        <asp:BoundColumn DataField="id_zona" HeaderText="IDZona" Visible="False"></asp:BoundColumn>
                        <asp:BoundColumn DataField="id_region" HeaderText="IDRegion" Visible="False"></asp:BoundColumn>
                        <asp:BoundColumn DataField="cod_localidad" HeaderText="C&#243;digo Localidad"></asp:BoundColumn>
                        <asp:BoundColumn DataField="nombre" HeaderText="Nombre Localidad"></asp:BoundColumn>
                        <asp:BoundColumn DataField="rut_empresa" HeaderText="RutEmpresa" Visible="False"></asp:BoundColumn>
                        <asp:BoundColumn DataField="nom_empresa" HeaderText="Empresa"></asp:BoundColumn>
                        <asp:BoundColumn HeaderText="Operador Asignado" DataField="nombre_cortador_asignado">
                        </asp:BoundColumn>
                        <asp:BoundColumn DataField="ID_CORTADOR_ASIGNADO" HeaderText="ID_CORTADOR_ASIGNADO"
                                                Visible="False"></asp:BoundColumn>
                        <asp:BoundColumn DataField="ESTADO_CORTADOR_ASIGNADO" HeaderText="ESTADO_CORTADOR_ASIGNADO">
                        </asp:BoundColumn>
                    </Columns>
                    <HeaderStyle HorizontalAlign="Center" BackColor="CornflowerBlue" Font-Bold="True" Font-Underline="True" ForeColor="White" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" />
                </asp:DataGrid></td>
            </tr>
        </table>
        <br />
    
    </div>
        &nbsp;
    </form>
</body>
</html>
