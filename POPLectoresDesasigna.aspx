<%@ Page Language="VB" AutoEventWireup="false" CodeFile="POPLectoresDesasigna.aspx.vb" Inherits="POPLectoresDesasigna" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
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
        <table id="tbl_lectores" runat="server" align="center" border="0" cellpadding="0"
            cellspacing="0" style="width: 758px; height: 152px" width="758">
            <tr>
                <td align="left" style="width: 732px">
                    <div class="WebPartShadow">
                        <div id="Div1" runat="server" class="WebPartTitle">
                            Lista de lectores con asignaciones...</div>
                        <table align="center" border="0" cellspacing="4" style="width: 709px; height: 107px"
                            width="709">
                            <tr style="font-family: Times New Roman">
                                <td align="left" colspan="2" nowrap="nowrap" style="width: 760px; height: 15px">
                                </td>
                            </tr>
                            <tr style="color: #000000; font-family: Times New Roman">
                                <td align="center" colspan="2" style="width: 760px; height: 3px; text-align: left">
                                    &nbsp;<asp:Label ID="Label2" runat="server" Text="0 coincidencia(s) encontrada(s)"
                                        Width="179px"></asp:Label><asp:DataGrid ID="GrillaLectores" runat="server" AllowPaging="True"
                                            AllowSorting="True" AutoGenerateColumns="False" BorderWidth="0px" CellPadding="1"
                                            CellSpacing="1" CssClass="GridAlternativeItems" GridLines="Horizontal" Height="1px"
                                            OnDeleteCommand="cmSelecciona" PageSize="6" Width="756px">
                                            <EditItemStyle BackColor="Honeydew" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                Font-Strikeout="False" Font-Underline="False" />
                                            <PagerStyle BackColor="Control" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                                Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Mode="NumericPages"
                                                NextPageText="Siguientes" PrevPageText="Anteriores" />
                                            <AlternatingItemStyle BackColor="White" />
                                            <ItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                            <HeaderStyle BackColor="Control" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                                Font-Strikeout="False" Font-Underline="True" ForeColor="Black" HorizontalAlign="Center" />
                                            <Columns>
                                                <asp:BoundColumn DataField="id_lector" HeaderText="IDLector" Visible="False"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="cod_lector" HeaderText="Codigo Lector">
                                                    <HeaderStyle Width="15%" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="nom_lector" FooterText="sfgdgf" HeaderText="Nombre Lector">
                                                    <HeaderStyle Width="45%" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="lector_asignaciones" HeaderText="Asignaciones"></asp:BoundColumn>
                                                <asp:ButtonColumn CommandName="Delete" HeaderText="Desasignar" Text="Desasignar..."></asp:ButtonColumn>
                                            </Columns>
                                        </asp:DataGrid></td>
                            </tr>
                            <tr style="font-family: Times New Roman">
                                <td align="right" colspan="2" style="width: 760px">
                                    <strong>
                                        <asp:Button ID="btnCancelLector" runat="server" CssClass="Button" Text="Cancelar" /></strong></td>
                            </tr>
                            <tr style="font-family: Times New Roman">
                                <td align="center" colspan="2" style="width: 760px">
                                    &nbsp;</td>
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
