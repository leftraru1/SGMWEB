<%@ Page Language="VB" AutoEventWireup="false" CodeFile="CambioEmpresa.aspx.vb" Inherits="CambioEmpresa" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Cambio Empresa...</title>
      <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/others.css"/>
        <link type="text/css" rel="stylesheet" href="estilos/style.css"/> 

<%--<style type="text/css">
body {
margin:0;
width: 100%;
height: 100%;
</style>   --%>
      
<SCRIPT language=JavaScript>
function blockError(){return true;}
window.onerror = blockError;
</SCRIPT>

</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 63px;
            height: 1px">
            <tr>
                <td style="height: 13px;">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr style="font-family: Times New Roman">
                <td style="width: 732px">
                    <div class="WebPartShadow">
                        <div id="titulo_mod" runat="server" class="WebPartTitle_multiusuario" style="width: 248px">
                            Cambio Empresa (Multiusuario)</div>
                        <table align="center" border="0" cellspacing="0" id="TABLE1" class="WebPartShadow">
                            <tr>
                                <td align="center" colspan="2" style="height: 3px; width: 275px;">
                                    <img onclick="openCalendar('txtDate1');" src="fotos/usuario.bmp" />
                                    <h2>
                                        Por favor, seleccione la empresa en la cual desea iniciar sesión, luego presione
                                        "Cambiar".</h2>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2">
                                    <div id="div_grilla" runat="server" class="WebPartShadow">
                                        <asp:DropDownList ID="combo_empresas" runat="server" CssClass="ComboBox2">
                                        </asp:DropDownList>
                                        <table style="width: 184px">
                                            <tr>
                                                <td colspan="3" rowspan="3" style="text-align: center">
                                    <asp:Button ID="BtnCambioEmpresa" runat="server" CssClass="botonnew" Text="Cambiar" /></td>
                                            </tr>
                                            <tr>
                                            </tr>
                                            <tr>
                                            </tr>
                                        </table>
                                    </div>
                                    <asp:Label ID="lb_nom_empresa" runat="server" CssClass="Label"></asp:Label>
                                    <asp:Label ID="LB_RUT_EMPRESA" runat="server" CssClass="Label"></asp:Label>
                                    <asp:Label ID="lb_id_usuario" runat="server" CssClass="Label"></asp:Label>&nbsp;
                                    </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2">
                                    &nbsp;<asp:Button ID="btnVolver" runat="server" CssClass="botonnew" Text="<< Volver" /></td>
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
