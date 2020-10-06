<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MenuSICORE.aspx.vb" Inherits="CYR_MenuSICORE" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>::Sistema CYR - Menú principal SICORE::</title>
    <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/others.css"/>     
<script language="javascript" type="text/javascript">

</script>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <table border="0" cellspacing="0">
                <tr>
                    <td align="left" class="TitleBorderCell" style="width: 300px">
                        <h1 class="AppTitle">
                            Sistema SICORE - GASCO
                        </h1>
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="lb_bienvenido" runat="server" Font-Names="Arial" Font-Size="X-Small" Text="Bienvenido" CssClass="Label"></asp:Label>
                                </td>
                                <td colspan="2">
                                    <asp:Label ID="lb_session" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" ForeColor="#C00000" Width="218px" CssClass="Label"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label1" runat="server" Font-Names="Arial" Font-Size="X-Small" Text="Empresa" CssClass="Label"></asp:Label>
                                </td>
                                <td colspan="2">
                                    <asp:Label ID="lb_empresa" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" ForeColor="#C00000" Width="217px" CssClass="Label"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td align="center" class="TitleBorderCell" style="width: 700px">
                        
                    </td>
                </tr>
                <tr>
                    <td align="left" class="TitleBorderCell">
                        <asp:TreeView ID="Arbol_Menu" runat="server" Font-Names="Arial" Font-Size="X-Small">
                        </asp:TreeView>
                    </td>
                    <td align="left" class="TitleBorderCell">
                    </td>
                </tr>
                <tr>
                    <td align="left" style="height: 29px;">
                        <asp:ImageButton ID="img_CierraSession" runat="server" ImageUrl="fotos/cerrar_sesion_a.gif" />
                        <asp:Label ID="lb_id_usuario" runat="server" Text="Label"></asp:Label>
                        <asp:Label ID="lb_id_perfil" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="height: 29px">
                    </td>
                </tr>
            </table>               
            
        </div>
    </form>
</body>
</html>
