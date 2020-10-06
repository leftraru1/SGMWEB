<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default_CLON.aspx.vb" Inherits="Default_CLON" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Sistema CYR</title>
    <link type="text/css" rel="stylesheet" href="estilos/page.css">
    <link type="text/css" rel="stylesheet" href="estilos/controls.css">
    <link type="text/css" rel="stylesheet" href="estilos/grid.css">
    <link type="text/css" rel="stylesheet" href="estilos/webpart.css">
    <link type="text/css" rel="stylesheet" href="estilos/menu.css">
    <link type="text/css" rel="stylesheet" href="estilos/others.css"> 
    
    <script language="JavaScript1.2">
window.moveTo(0,0);
top.window.resizeTo(screen.availWidth,screen.availHeight);
</script> 
    
</head>
<body bgcolor="#ffffff">
    <form id="form1" runat="server">
    <div>
        <table border="0" cellspacing="0" style="width: 360px; height: 690px;">
            <tr>
                <td class="TitleBorderCell" align="left" style="width: 300px; height: 10px;"><h1 class="AppTitle">
                    Sistema SGC - Corte y Reposicion De Medidores.</h1>
                    <asp:Label ID="lb_bienvenido" runat="server" Font-Names="Arial" Font-Size="X-Small"
                        Text="Bienvenido"></asp:Label>
                    <asp:Label ID="lb_session" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        ForeColor="#C00000" Width="236px"></asp:Label>
                    <asp:Label ID="Label1" runat="server" Font-Names="Arial" Font-Size="X-Small" Text="Empresa"></asp:Label>
                    &nbsp;&nbsp;
                    <asp:Label ID="lb_empresa" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        ForeColor="#C00000" Width="231px"></asp:Label></td>
            </tr>
            <tr>
                <td class="TitleBorderCell" style="width: 300px; height: 725px;" align="left">
        <asp:TreeView ID="Arbol_Menu" runat="server" Font-Names="Arial" Font-Size="X-Small"
            Height="1056px" Width="351px">
        </asp:TreeView>
                </td>
            </tr>
            <tr>
                <td style="width: 300px" align="left">
                    <asp:ImageButton ID="img_CierraSession" runat="server" ImageUrl="fotos/cerrar_sesion_a.gif" />
                    <asp:Label ID="lb_id_usuario" runat="server" Text="Label"></asp:Label>
                    <asp:Label ID="lb_id_perfil" runat="server"></asp:Label></td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
