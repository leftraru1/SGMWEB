<%@ Page Language="VB" AutoEventWireup="false" CodeFile="CierraLoteCompleto.aspx.vb" Inherits="CierraLoteCompleto" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Cierre de Lote...</title>
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
        <table id="TABLE1" align="center" border="0" cellpadding="0" cellspacing="0" style="width: 758px;
            height: 118px" width="758">
            <tr>
                <td style="width: 732px; height: 11px">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr style="font-size: 12pt; font-family: Times New Roman">
                <td style="width: 732px; height: 1px">
                    <div class="WebPartShadow_ext">
                        <div class="WebPartTitle_ext">
                            Cierre de Lote...</div>
                        <table align="center" border="0" cellspacing="0" style="width: 709px; height: 1px"
                            width="709">
                            <tr>
                                <td align="right" nowrap="nowrap" style="width: 60%; height: 4px">
                                    <h2>
                                        &nbsp;Esta seguro que desea cerrar el LOTE (Grupo proceso):&nbsp;
                                    </h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 40%; height: 4px">
                                    <asp:Label ID="Lote_a_cerrar" runat="server" Font-Names="Arial" Font-Size="Small" Font-Bold="True" ForeColor="Black"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="height: 3px">
                                    <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="height: 1px">
                                    <asp:Image ID="img_ok" runat="server" ImageUrl="fotos/ok.bmp" /><asp:Label ID="ok_cierre_lote"
                                        runat="server" Font-Names="Arial" ForeColor="#0000C0" Width="512px"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="height: 1px">
                                    <asp:Label ID="Error_cierre_lote" runat="server" Font-Names="Arial" ForeColor="Red"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2">
                                    <asp:Button ID="btnCierraLOTE" runat="server" CssClass="Button" Text="Cerrar LOTE"
                                        Width="120px" />
                                    <asp:Button ID="btnVolver" runat="server" CssClass="Button" Text="<< Volver"
                                        Width="120px" /></td>
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
