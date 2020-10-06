<%@ Page Language="VB" AutoEventWireup="false" CodeFile="POPRangos.aspx.vb" Inherits="POPRangos" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Rangos de la Localidad...</title>
      <link type="text/css" rel="stylesheet" href="estilos/page.css">
      <link type="text/css" rel="stylesheet" href="estilos/controls.css">
      <link type="text/css" rel="stylesheet" href="estilos/grid.css">
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css">
      <link type="text/css" rel="stylesheet" href="estilos/menu.css">
      <link type="text/css" rel="stylesheet" href="estilos/others.css"> 
      
<SCRIPT language=JavaScript>
function blockError(){return true;}
window.onerror = blockError;
</SCRIPT>

</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table align="center" border="0" cellpadding="0" cellspacing="0"
            height: style="width: 718px" 152px">
            <tr>
                <td style="width: 732px">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 750px">
                    <div class="WebPartShadow_rango" style="width: 750px">
                        <div id="titulo_mod" runat="server" class="WebPartTitle_ext" style="width: 754px">
                            Rangos de validacion de Lecturas de la Localidad</div>
                        <table align="center" border="0" cellspacing="0" style="width: 689px; height: 1px">
                            <tr id="tr_btn_agrega" runat="server">
                                <td align="right" colspan="2" style="height: 3px">
                                    </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2">
                                    <div id="div_grilla" runat="server" class="WebPartShadow" style="text-align: justify">
                                        <asp:Label ID="lb_cantidad_registros" runat="server" Text="coincidencia(s) encontrada(s)"
                                            Width="310px"></asp:Label>
                                        <asp:DataGrid ID="GrillaRangos" runat="server" AutoGenerateColumns="False" BorderColor="#003366"
                                            BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1" CssClass="GridAlternativeItems"
                                            ForeColor="Black" GridLines="Horizontal" Height="1px"
                                            OnEditCommand="MyDataGrid_Edit" Width="720px">
                                            <HeaderStyle BackColor="Control" BorderColor="Black" Font-Bold="True" Font-Underline="True"
                                                ForeColor="Black" HorizontalAlign="Center" />
                                            <Columns>
                                                <asp:BoundColumn DataField="id_localidad" HeaderText="IDLocalidad" Visible="False"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="cod_localidad" HeaderText="C&#243;digo Localidad">
                                                    <HeaderStyle Width="14%" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="nom_localidad" HeaderText="Nombre Localidad">
                                                    <HeaderStyle Width="22%" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="rango_inf3" HeaderText="RANGO M3 Inferior">
                                                    <HeaderStyle Width="13%" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="rango_max3" HeaderText="RANGO M3 Superior">
                                                    <HeaderStyle Width="13%" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="val_menor" HeaderText="Validacion Menor (%)">
                                                    <HeaderStyle Width="15%" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="val_mayor" HeaderText="Validacion Mayor (%)">
                                                    <HeaderStyle Width="15%" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="id_rango" HeaderText="IDRango" Visible="False"></asp:BoundColumn>
                                                <asp:EditCommandColumn CancelText="Cancel" EditText="Editar" HeaderText="Modificar"
                                                    UpdateText="Update">
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" ForeColor="#0000CC" />
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" ForeColor="Green" />
                                                    <HeaderStyle Width="8%" />
                                                </asp:EditCommandColumn>
                                            </Columns>
                                            <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                                                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                                                VerticalAlign="Middle" />
                                            <ItemStyle BackColor="MenuBar" HorizontalAlign="Center" />
                                            <AlternatingItemStyle BackColor="White" />
                                        </asp:DataGrid>
                                    </div>
                                    <asp:Label ID="valida_borra_lector" runat="server" Font-Names="Arial" ForeColor="Red"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="height: 1px">
                                    &nbsp;<asp:Button ID="btn_volver2" runat="server" CausesValidation="False" CssClass="Button"
                                        Text="Cerrar Ventana" Width="120px" /></td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
