<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AgregarPerfil.aspx.vb" Inherits="AgregarPerfil" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Ingreso Nuevo Perfil...</title>
      <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/others.css"/> 
    
<script language="JavaScript1.2">
window.moveTo(0,0);
top.window.resizeTo(screen.availWidth,screen.availHeight);
</script> 
    
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 758px;
            height: 152px" width="758">
            <tr>
                <td style="width: 732px">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr style="font-weight: bold">
                <td style="width: 732px; height: 244px;">
                    <div class="WebPartShadow_ext">
                        <div id="titulo_mod" runat="server" class="WebPartTitle_ext">
                            Ingreso de Nuevo Perfil...</div>
                        <table align="center" border="0" cellspacing="0" style="width: 709px; height: 1px"
                            width="709">
                            <tr>
                                <td align="right" colspan="2" style="height: 1px">
                                    <table style="width: 728px; height: 41px">
                                        <tr>
                                            <td align="right" style="width: 162px; height: 17px">
                                                <h2>
                                                    Descripción Perfil:&nbsp;
                                                </h2>
                                            </td>
                                            <td align="left" style="width: 223px; height: 17px">
                                                &nbsp;
                                                <asp:TextBox ID="txt_descripcion_perfil" runat="server" CssClass="TextBox" MaxLength="25" Width="184px"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_descripcion_perfil"
                                                    ErrorMessage="*" Width="1px"></asp:RequiredFieldValidator></td>
                                            <td style="width: 5%; height: 17px">
                                            </td>
                                            <td align="right" style="width: 14%; height: 17px">
                                                <h2>
                                                    &nbsp;
                                                </h2>
                                            </td>
                                            <td align="left" style="width: 30%; height: 17px">
                                                </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 162px; height: 19px">
                                                <h2>
                                                    ID Perfil a Asignar:&nbsp;
                                                </h2>
                                            </td>
                                            <td align="left" style="width: 223px; height: 19px">
                                                &nbsp;
                                                <asp:Label ID="lb_id_perfil" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Medium" Width="99px"></asp:Label></td>
                                            <td style="height: 19px">
                                            </td>
                                            <td align="right" style="height: 19px" colspan="2">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" colspan="5" style="height: 17px">
                                                <asp:Label ID="lb_valida_perfiles" runat="server" Font-Names="Arial" ForeColor="Red"
                                                    Width="546px" Font-Bold="False"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td align="left" colspan="2" style="width: 162px; height: 17px">
                                                <table id="TABLE1" border="0" cellpadding="0" cellspacing="0" style="width: 363px">
                                                    <tr>
                                                        <td style="height: 15px">
                                                            <asp:RegularExpressionValidator ID="ER_nom" runat="server" ControlToValidate="txt_descripcion_perfil"
                                                                Display="Dynamic" ErrorMessage="Error en descripción del perfil: Se aceptan sólo letras!"
                                                                ValidationExpression="[a-zA-Z]{3,50}([\s]{0,1}[a-zA-Z]{0,50})([\s]{0,1}[a-zA-Z]{0,50})([\s]{0,1}[a-zA-Z]{0,50})([\s]{0,1}[a-zA-Z]{0,50})" Font-Bold="False" Font-Names="Arial"></asp:RegularExpressionValidator></td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td style="height: 17px">
                                            </td>
                                            <td align="right" style="height: 17px">
                                            </td>
                                            <td style="height: 17px">
                                            </td>
                                        </tr>
                                    </table>
                                    <asp:Button ID="btn_Nuevo_Ingreso" runat="server" CssClass="botonnew" Text="Ingresar Nuevo Perfil"
                                        Width="130px" CausesValidation="False" />
                                    <asp:Button ID="btn_Ingreso_perfil" runat="server" CssClass="botonnew" Text="Ingresar Perfil"
                                        Width="120px" />
                                    <asp:Button ID="btn_volver" runat="server" CausesValidation="False" CssClass="botonnew"
                                        Text="<< Volver" Width="120px" />
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="height: 1px">
                                    </td>
                            </tr>
                        </table>
                    </div>
                                    <img id="img_ok" runat="server" src="fotos/img_ok2.bmp" /><asp:Label ID="lb_mensaje_edicion"
                                        runat="server" Font-Names="Arial Unicode MS" Width="450px" BackColor="Transparent" Font-Size="Small" ForeColor="#0000C0" Font-Bold="False" Height="18px">Perfil ha sido ingresado exitosamente!</asp:Label>
                    <asp:Label ID="lb_error" runat="server" CssClass="ErrorMessage" Font-Names="Arial Unicode MS"
                        Font-Size="Small" ForeColor="Red" Height="18px"></asp:Label></td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
