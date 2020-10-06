<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ActivacionCatastros.aspx.vb" Inherits="ActivacionCatastros" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Activación de Catastros - Sistema CYR</title>
    <link type="text/css" rel="stylesheet" href="estilos/page.css">
      <link type="text/css" rel="stylesheet" href="estilos/controls.css">
      <link type="text/css" rel="stylesheet" href="estilos/grid.css">
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css">
      <link type="text/css" rel="stylesheet" href="estilos/menu.css">
      <link type="text/css" rel="stylesheet" href="estilos/others.css">
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <div class="WebPartTitle">
         <table id="TABLE1" border="0" cellpadding="0" cellspacing="0" style="width: 656px;
             height: 1px">
             <tr>
                 <td style="height: 5px">
                     <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                         Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                             Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                 Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                     ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
                 <td style="height: 5px">
                 </td>
             </tr>
             <tr>
                 <td>
                 </td>
                 <td>
                 </td>
             </tr>
         </table>
        Activación de Catastros:</div>
        <table id="tbl_inicio" runat="server" align="center" border="0" cellpadding="0" cellspacing="0"
            style="width: 590px; height: 130px">
            <tr>
                <td style="width: 732px">
                    <div class="WebPartShadow">
                        <div id="Div2" runat="server" class="WebPartTitle">
                            Filtrando por...</div>
                        <table align="center" border="0" cellspacing="0" style="width: 547px; height: 1px">
                            <tr id="Tr1" runat="server">
                                <td align="left" colspan="2" nowrap="nowrap" style="width: 41%; height: 15px">
                                    <h2>
                                        Introduzca los valores deseados y oprima "Filtrar"</h2>
                                </td>
                            </tr>
                            <tr id="Tr2" runat="server">
                                <td align="right" nowrap="nowrap" style="width: 219px; height: 15px">
                                    <h2>
                                        Lote: &nbsp;
                                    </h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 418px; height: 15px">
                                    <asp:DropDownList ID="combo_lotes" runat="server" CssClass="ComboBox" Width="170px" AutoPostBack="True">
                                    </asp:DropDownList></td>
                            </tr>
                            <tr id="Tr8" runat="server">
                                <td align="right" nowrap="nowrap" style="width: 219px; height: 15px">
                                    <h2>
                                        Localidad: &nbsp;</h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 418px; height: 15px">
                                    <asp:DropDownList ID="combo_localidades" runat="server" CssClass="ComboBox" Width="170px" AutoPostBack="True">
                                    </asp:DropDownList></td>
                            </tr>
                            <tr id="Tr3" runat="server">
                                <td align="right" nowrap="nowrap" style="width: 219px; height: 9px">
                                    <h2>
                                        Estado Asignación: &nbsp;
                                    </h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 418px; height: 9px">
                                    <asp:DropDownList ID="combo_estadoAsig" runat="server" CssClass="ComboBox" Width="170px" AutoPostBack="True">
                                        <asp:ListItem Selected="True" Value="1">Recepcionado</asp:ListItem>
                                    </asp:DropDownList></td>
                            </tr>
                            <tr id="Tr4" runat="server">
                                <td align="right" nowrap="nowrap" style="width: 219px; height: 9px">
                                    <h2>
                                        Ruta: &nbsp;
                                    </h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 418px; height: 9px">
                                    <asp:DropDownList ID="combo_libro" runat="server" CssClass="ComboBox" Width="170px" AutoPostBack="True">
                                    </asp:DropDownList>
                                    <asp:Label ID="lb_id_usuario" runat="server" Text="Label"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="height: 3px">
                                    <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label>
                                    <asp:Button ID="btnFiltra" runat="server" CssClass="Button" Text="Filtrar" Width="120px" /></td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <table id="tbl_principal" runat="server" align="center" border="0" cellpadding="0"
            cellspacing="0" style="width: 758px; height: 80px">
            <tr>
                <td>
                    <div class="WebPartShadow">
                        <div id="titulo_mod" runat="server" class="WebPartTitle">
                            Resultados...</div>
                        <table align="center" border="0" cellspacing="0" style="height: 1px" width="709">
                            <tr>
                                <td align="left" colspan="2">
                                    <div id="div_grilla" runat="server" class="WebPartShadow" style="text-align: justify">
                                        <table id="Table2" align="center" border="0" cellspacing="0" style="width: 707px;
                                            height: 79px">
                                            <tr style="color: #000000">
                                                <td align="center" colspan="2" style="width: 760px; height: 2px; text-align: left">
                                                    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="Navy"
                                                        Text="Catastro actual: " Font-Size="Small" Font-Underline="True"></asp:Label>
                                                    <asp:Label ID="lb_catastro_actual" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Small"></asp:Label></td>
                                            </tr>
                                            <tr style="color: #000000">
                                                <td align="center" colspan="2" style="width: 760px; height: 1px; text-align: left">
                                                    &nbsp;&nbsp;
                                                    <table cellpadding="0" cellspacing="0" style="width: 726px">
                                                        <tr>
                                                            <td style="width: 50%">
                                                            </td>
                                                            <td align="right" style="width: 50%">
                                                                <asp:LinkButton ID="LinkButton1" runat="server" Font-Bold="False" ForeColor="Blue" Font-Names="Arial">Desmarcar Todos</asp:LinkButton>
                                                                &nbsp; &nbsp;<asp:LinkButton ID="btn_Marcar_Todos" runat="server" Font-Bold="False" ForeColor="Blue" Font-Names="Arial">Marcar Todos</asp:LinkButton></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:50%">
                                                            <asp:Label ID="lb_cantidad_registros" runat="server" Text="0 coincidencia(s) encontrada(s)"
                                                        Width="327px"></asp:Label></td>
                                                            <td style="width:50%" align="right">
                                                                &nbsp; &nbsp;</td>
                                                        </tr>
                                                    </table>
                                                    <asp:DataGrid ID="GrillaPrincipal" runat="server" AutoGenerateColumns="False"
                                                        BorderColor="#003366" BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1"
                                                        CssClass="GridAlternativeItems" ForeColor="Black" GridLines="Horizontal" Height="1px"
                                                        Width="726px">
                                                        <HeaderStyle BackColor="Control" BorderColor="Black" Font-Bold="True" Font-Underline="True"
                                                            ForeColor="Black" HorizontalAlign="Center" />
                                                        <Columns>
                                                            <asp:BoundColumn DataField="id_servicio" HeaderText="Servicio" Visible="False"></asp:BoundColumn>
                                                            <asp:BoundColumn DataField="id_localidad" HeaderText="IDLocalidad" Visible="False">
                                                                <HeaderStyle Width="8%" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="lote" HeaderText="LOTE" Visible="False">
                                                                <HeaderStyle Width="8%" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="cod_localidad" HeaderText="C&#243;digo Localidad">
                                                                <HeaderStyle Width="10%" Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" HorizontalAlign="Center" Wrap="False" />
                                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" HorizontalAlign="Center" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="nom_localidad" HeaderText="Localidad">
                                                                <HeaderStyle Width="30%" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="libreta" HeaderText="Ruta">
                                                                <HeaderStyle Width="20%" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="total" HeaderText="Total">
                                                                <HeaderStyle Width="15%" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="direccion" HeaderText="Direcci&#243;n" Visible="False">
                                                                <HeaderStyle Width="32%" />
                                                            </asp:BoundColumn>
                                                            <asp:TemplateColumn HeaderText="Activar Catastro">
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="check_catastro" runat="server" />
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="8%" />
                                                            </asp:TemplateColumn>
                                                        </Columns>
                                                        <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                                                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                                                            VerticalAlign="Middle" />
                                                        <ItemStyle BackColor="MenuBar" HorizontalAlign="Center" />
                                                        <AlternatingItemStyle BackColor="White" />
                                                    </asp:DataGrid></td>
                                            </tr>
                                            <tr style="color: #000000">
                                                <td align="center" colspan="2" style="width: 760px; height: 3px">
                                                    <img id="img_ok" runat="server" src="fotos/ok.bmp" />
                                                    <asp:Label ID="lb_mensaje" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="Navy"
                                                        Width="512px"></asp:Label></td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="height: 1px">
                                    <table cellpadding="0" cellspacing="0" style="width: 756px">
                                        <tr>
                                            <td align="left" style="width: 35%; height: 19px;">
                                                <h2>
                                                    &nbsp;</h2>
                                            </td>
                                            <td style="width: 65%; height: 19px;">
                                                &nbsp;
                                                <asp:Button ID="btnActivaCatastros" runat="server" CssClass="Button" Text="Actualizar Catastro"
                                                    Width="120px" />
                                                <asp:Button ID="btnVolver" runat="server" CssClass="Button" Text="<< Volver a Menu"
                                                    Width="120px" /></td>
                                        </tr>
                                    </table>
                                </td>
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
