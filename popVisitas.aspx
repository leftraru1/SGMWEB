<%@ Page Language="VB" AutoEventWireup="false" CodeFile="popVisitas.aspx.vb" Inherits="popVisitas" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
  <title>Visitas OT - Sistema CYR</title>
  <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
  <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
  <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
  <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
  <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
  <link type="text/css" rel="stylesheet" href="estilos/others.css"/> 
  <link type="text/css" rel="stylesheet" href="estilos/style.css"/>  
  <link type="text/css" rel="stylesheet" href="estilos/loadingbox.css" />     
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table id="tbl_lectores" runat="server" align="center" border="0" cellpadding="0"
            cellspacing="0" style="width: 1px; height: 5px">
            <tr>
                <td align="center" style="width: 903px">
                </td>
            </tr>
        </table>
                    <div class="WebPartShadow_seguimiento" style="width: 1250px">
                        <div id="Div1" runat="server" class="WebPartTitle_seguimiento" style="width: 1200px; text-align: left">
                            Listado de visitas realizadas...</div>
                        <table align="center" border="0" cellspacing="4" style="width: 1px; height: 10px">
                            <tr style="font-family: Times New Roman">
                                <td align="left" colspan="2" nowrap="nowrap" style="width: 1px; height: 15px">
                                    <table style="width: 636px">
                                        <tr>
                                            <td style="width:12%;">
                                                <asp:Label ID="Label1" runat="server" Text="ID Servicio:" Font-Bold="False" Font-Names="Arial Unicode MS" Font-Size="Small" ForeColor="#0000C0"></asp:Label></td>
                                            <td style="width:26%;">
                                                <asp:Label ID="lb_servicio" runat="server" Font-Bold="False" Font-Names="Arial Unicode MS"
                                                    Font-Size="Small" ForeColor="#C04000"></asp:Label></td>
                                            <td style="width:2%;">
                                            </td>
                                            <td style="width:18%;">
                                                <asp:Label ID="Label2" runat="server" Font-Bold="False" Font-Names="Arial Unicode MS"
                                                    Font-Size="Small" ForeColor="#0000C0" Text="Número de Orden:"></asp:Label></td>
                                            <td style="width:40%;">
                                                <asp:Label ID="lb_num_orden" runat="server" Font-Bold="False" Font-Names="Arial Unicode MS"
                                                    Font-Size="Small" ForeColor="#C04000">Número de Orden:</asp:Label></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr style="color: #000000; font-family: Times New Roman">
                                <td align="center" colspan="2" style="width: 1px; height: 3px; text-align: left">
                                    &nbsp;<asp:Label ID="lb_mensaje_coincidencias" runat="server" Width="653px" Font-Names="Arial Unicode MS" Font-Size="Small"></asp:Label>&nbsp;<asp:DataGrid
                                        ID="GrillaVisitas" runat="server" AutoGenerateColumns="False" BorderColor="#003366"
                                        BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1" CssClass="GridAlternativeItems"
                                        Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" ForeColor="Black" GridLines="Horizontal" Height="1px"
                                        Width="1129px">
                                        <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <EditItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <SelectedItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="False" Font-Italic="False"
                                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                                            VerticalAlign="Middle" Wrap="False" />
                                        <AlternatingItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                        <ItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
                                        <Columns>
                                            <asp:BoundColumn DataField="CORRELATIVO" HeaderText="N&#176; VISITA">
                                                <HeaderStyle Width="3%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="TIPO_ORDEN" HeaderText="Tipo Orden">
                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" Width="4%" Wrap="False" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="ID_SERVICIO" HeaderText="Servicio" Visible="False">
                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" Width="5%" Wrap="False" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="NRO_ORDEN" HeaderText="N&#250;mero Orden" Visible="False">
                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" Width="7%" Wrap="False" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="FECHA_GENERACION" HeaderText="Fecha Generaci&#243;n">
                                                <HeaderStyle Width="4%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="FECHA_ASIGNACION" HeaderText="Fecha Asignaci&#243;n">
                                                <HeaderStyle Width="4%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="FECHA_EJECUCION" HeaderText="Fecha Ejecuci&#243;n">
                                                <HeaderStyle Width="6%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="TIPO_RESPUESTA" HeaderText="Tipo Respuesta">
                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" Width="13%" Wrap="False" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="RESPUESTA" HeaderText="Respuesta">
                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" Width="13%" Wrap="False" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="CORTADOR" HeaderText="Operador (Cod.)">
                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" Width="18%" Wrap="False" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="OBSERVACION" HeaderText="Observaci&#243;n">
                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" Width="8%" Wrap="False" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="GRUPO_PROCESO" HeaderText="Grupo Proceso">
                                                <HeaderStyle Width="8%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="TIPO_PROCESO" HeaderText="Tipo Proceso">
                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" Width="6%" Wrap="False" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="NUM_SELLO" HeaderText="N&#176; Sello">
                                                <HeaderStyle Width="5%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="FOTO" HeaderText="Foto"><HeaderStyle Width="5%" /></asp:BoundColumn>
                                        </Columns>
                                        <HeaderStyle BackColor="CornflowerBlue" BorderColor="Black" Font-Bold="True" Font-Italic="False"
                                            Font-Overline="False" Font-Strikeout="False" Font-Underline="True" ForeColor="White"
                                            HorizontalAlign="Center" Wrap="False" />
                                    </asp:DataGrid>
                                </td>
                            </tr>
                            <tr style="font-family: Times New Roman">
                                <td align="right" colspan="2">
                                    <strong>
                                    <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label>
                                        <asp:Button ID="btnVolver" runat="server" CssClass="botonnew" Text="Cerrar Ventana"
                                            Width="120px" />
                                    </strong>
                                </td>
                            </tr>
                        </table>
                    </div>    
    
    
    
    </div>
    </form>
</body>
</html>
