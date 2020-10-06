<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RuteroManual.aspx.vb" Inherits="RuteroManual" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Carga Manual Rutero - Sistema CYR</title>
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
        <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 758px;
            height: 23px" width="758">
            <tr>
                <td style="width: 732px">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr style="font-size: 12pt; font-family: Times New Roman">
                <td style="width: 732px">
                    <div class="WebPartShadow_ext">
                        <div class="WebPartTitle_ext">
                            Carga &nbsp;Manual de Rutero...</div>
                        <table align="center" border="0" cellspacing="4" style="width: 709px; height: 66px"
                            width="709">
                            <tr>
                                <td align="left" colspan="2" nowrap="nowrap" style="height: 15px">
                                    <h2>
                                        Por favor, carge el archivo de rutas:
                                        <asp:FileUpload ID="CargaArchivo" runat="server" Width="371px" />
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="CargaArchivo"
                                            ErrorMessage="Sólo archivos en formato XML" ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))+(.xml|.XML|.Xml)$"></asp:RegularExpressionValidator></h2>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="height: 9px">
                                    <asp:Button ID="btnCargaRutero" runat="server" CssClass="Button" Text="Cargar Rutero"
                                        Width="128px" />
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="height: 9px">
                                    <img id="img_ok" runat="server" src="fotos/ok.bmp" /><asp:Label ID="lb_mensaje" runat="server"
                                        Font-Bold="True" Font-Names="Arial" ForeColor="Navy"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="height: 3px">
                                    <asp:Button ID="btnVolver" runat="server" CssClass="Button" Text="<< Volver Menu"
                                        Width="120px" /></td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr style="font-family: Times New Roman">
                <td style="width: 732px">
                    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Small"></asp:Label>
                    <asp:Label ID="lb_mensaje_error" runat="server" Font-Bold="True" Font-Names="Arial"
                        Font-Size="X-Small" ForeColor="Red"></asp:Label>
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
