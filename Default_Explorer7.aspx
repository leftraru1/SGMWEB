<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default_Explorer7.aspx.vb" Inherits="Default_Explorer7" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" 
"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"> 

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Sistema CyR LIPIGAS</title>
    <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/others.css"/> 

<style type="text/css">
body {
margin:0;
width: 100%;
height: 100%;
}
</style>
    
<%--<script type="text/javascript" language="JavaScript1.2">
window.moveTo(0,0);
top.window.resizeTo(screen.availWidth,screen.availHeight);
</script>   --%>
    
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table border="0" cellspacing="0">
            <tr>
                <td align="left" class="TitleBorderCell" style="width: 300px">
                    <h1 class="AppTitle">
                        Sistema de Corte y Reposición de Medidores.</h1>
                    <table style="width: 355px">
                        <tr>
                            <td style="width: 59px">
                    <asp:Label ID="lb_bienvenido" runat="server" Font-Names="Arial" Font-Size="X-Small"
                        Text="Bienvenido" CssClass="Label"></asp:Label></td>
                            <td colspan="2">
                    <asp:Label ID="lb_session" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        ForeColor="#C00000" Width="218px" CssClass="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 59px">
                                <asp:Label ID="Label1" runat="server"
                            Font-Names="Arial" Font-Size="X-Small" Text="Empresa" CssClass="Label"></asp:Label></td>
                            <td colspan="2">
                    <asp:Label ID="lb_empresa" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        ForeColor="#C00000" Width="217px" CssClass="Label"></asp:Label></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="left" class="TitleBorderCell">
                    <asp:TreeView ID="Arbol_Menu" runat="server" Font-Names="Arial" Font-Size="X-Small">
                    </asp:TreeView>
                </td>
            </tr>
            <tr>
                <td align="left" style="width: 300px; height: 29px;">
                    <asp:ImageButton ID="img_CierraSession" runat="server" ImageUrl="fotos/cerrar_sesion_a.gif" />
                    <asp:Label ID="lb_id_usuario" runat="server" Text="Label"></asp:Label>
                    <asp:Label ID="lb_id_perfil" runat="server"></asp:Label></td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
