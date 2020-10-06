<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ErrorSession.aspx.vb" Inherits="ErrorSession" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Sesión de Usuario Expirada.</title>
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
                    <div class="WebPartShadow_ext">
                        <div class="WebPartTitle_ext">
                            Alerta Error de la Sesión de Usuario...!</div>
                        <table align="center" border="0" cellspacing="4" style="width: 709px; height: 66px"
                            width="709">
                            <tr>
                                <td align="left" colspan="2" nowrap="nowrap" style="height: 15px">
                                    <h2>
                                        Estimado Usuario su Sesión ha expirado, puede iniciar una nueva sesión haciendo
                                        click en "&lt;&lt; Iniciar Nueva Sesión"&nbsp;</h2>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="height: 3px">
                                    <asp:Button ID="btnVolver" runat="server" CssClass="Button" Text="<< Iniciar Nueva Sesión"
                                        Width="152px" />
                                    <asp:Button ID="Button1" runat="server" CssClass="Button" Text="Salir Sistema CYR"
                                        Width="152px" /></td>
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
