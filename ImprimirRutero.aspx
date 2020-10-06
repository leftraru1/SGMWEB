<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ImprimirRutero.aspx.vb" Inherits="ImprimirRutero" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Imprimir Reporte de Rutas...</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table id="Table3" border="0" cellpadding="0" cellspacing="0" style="width: 688px">
            <tr>
                <td style="height: 5px">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
        </table>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="841px" Height="445px">
            <ServerReport Timeout="6000000" />
        </rsweb:ReportViewer>
        <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label></div>
    </form>
</body>
</html>
