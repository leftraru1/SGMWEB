<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AgregarEmailNotificacion.aspx.vb" Inherits="AgregarEmailNotificacion" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Agregar Email Notificación - Sistema CYR</title>        
    <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/others.css"/> 
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 758px"
            width="758">
            <tr>
                <td style="width: 732px">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr style="font-weight: bold">
                <td style="width: 732px">
                    <div class="WebPartShadow_ext" style="width: 931px">
                        <div id="titulo_mod" runat="server" class="WebPartTitle_ext" style="width: 909px">
                            Ingreso de nuevo E-mail de Notificación:</div>
                        <table align="center" border="0" cellspacing="0" style="width: 895px; height: 1px">
                            <tr>
                                <td align="center" colspan="2" style="height: 1px">
                                    <div id="div_nuevo_lector" runat="server" class="WebPartShadow" style="text-align: justify">
                                        <table id="tbl_ingreso_lector" runat="server" style="width: 856px">
                                            <tr>
                                                <td align="right" style="width: 162px; height: 17px">
                                                    <h2>
                                                        Empresa:&nbsp;
                                                    </h2>
                                                </td>
                                                <td style="width: 319px; height: 17px">
                                                    <asp:DropDownList ID="combo_empresa" runat="server" AutoPostBack="True" CssClass="ComboBox"
                                                        Width="184px">
                                                    </asp:DropDownList></td>
                                                <td style="height: 17px">
                                                </td>
                                                <td align="right" style="width: 14%; height: 17px">
                                                    <h2>
                                                    </h2>
                                                </td>
                                                <td style="width: 30%; height: 17px">
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 162px; height: 17px">
                                                    <h2>
                                                        E-mail ENVIA:&nbsp;
                                                    </h2>
                                                </td>
                                                <td style="width: 319px; height: 17px">
                                                    <asp:TextBox ID="txt_envia" runat="server" CssClass="TextBox" MaxLength="40" Width="184px"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_envia"
                                                        ErrorMessage="*" Width="1px"></asp:RequiredFieldValidator></td>
                                                <td style="height: 17px">
                                                </td>
                                                <td align="right" style="width: 16%; height: 17px">
                                                    <h2>
                                                        HOST:&nbsp;
                                                    </h2>
                                                </td>
                                                <td style="width: 30%; height: 17px">
                                                    <asp:TextBox ID="txt_host" runat="server" CssClass="TextBox" MaxLength="70"
                                                        Width="184px"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txt_host"
                                                        ErrorMessage="*" Width="1px"></asp:RequiredFieldValidator></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 162px">
                                                    <h2>
                                                        &nbsp;E-mail RECIBE:&nbsp;
                                                    </h2>
                                                </td>
                                                <td style="width: 319px">
                                                    <asp:TextBox ID="txt_recibe" runat="server" CssClass="TextBox" MaxLength="40" Width="184px"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txt_recibe"
                                                        ErrorMessage="*" Width="1px"></asp:RequiredFieldValidator></td>
                                                <td>
                                                </td>
                                                <td align="right">
                                                    <h2>
                                                        &nbsp;
                                                    </h2>
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="2" style="height: 8px">
                                                    &nbsp;<table id="TABLE1" border="0" cellpadding="0" cellspacing="0" style="width: 408px">
                                                        <tr>
                                                            <td style="height: 15px">
                                                                <asp:RegularExpressionValidator ID="ER_email" runat="server" ControlToValidate="txt_envia"
                                                                    ErrorMessage="Error E-mail ENVIA: formato no válido!" Font-Bold="False" Font-Names="Arial Unicode MS"
                                                                    Font-Size="Small" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"></asp:RegularExpressionValidator></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="height: 15px">
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txt_recibe"
                                                                    ErrorMessage="Error E-mail RECIBE: formato no válido!" Font-Bold="False" Font-Names="Arial Unicode MS"
                                                                    Font-Size="Small" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"></asp:RegularExpressionValidator></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="height: 15px">
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txt_host"
                                                                    Display="Dynamic" ErrorMessage="IP del HOST no es válida!" Font-Bold="False"
                                                                    Font-Names="Arial Unicode MS" Font-Size="Small" ValidationExpression="^(\d){1,3}\.(\d){1,3}\.(\d){1,3}\.(\d){1,3}$"></asp:RegularExpressionValidator></td>
                                                        </tr>
                                                    </table>
                                                    &nbsp;
                                                </td>
                                                <td style="height: 8px">
                                                </td>
                                                <td align="right" style="height: 8px">
                                                </td>
                                                <td style="height: 8px">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" colspan="5" style="height: 17px">
                                                    <asp:Button ID="btn_agregarOtro" runat="server" CssClass="botonnew" Text="Agregar Nuevo E-mail"
                                                        Width="143px" />
                                                    &nbsp;<asp:Button ID="btnNuevoCorreoNot" runat="server" CssClass="botonnew" Text="Agregar E-mail"
                                                        Width="120px" />
                                                    <asp:Button ID="btnVolver" runat="server" CausesValidation="False" CssClass="botonnew"
                                                        Text="<< Volver" Width="120px" />
                                                </td>
                                            </tr>
                                        </table>
                                        <table id="tbl_ingreso_ok" runat="server" style="width: 854px; height: 1px">
                                            <tr>
                                                <td align="center">
                                                    <asp:Label ID="LB_ID_USUARIO" runat="server"></asp:Label>
                                                    <asp:Label ID="lb_perfil_usuario" runat="server"></asp:Label>
                                                    <asp:Label ID="lb_nom_empresa" runat="server"></asp:Label>
                                                    <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label></td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <img id="img_ok" runat="server" alt="" src="fotos/img_ok2.bmp" style="height: 20px" />
                    <asp:Label ID="lb_mensaje_ingreso" runat="server" CssClass="Label" Font-Names="Arial Unicode MS"
                        Font-Size="Small" ForeColor="#0000C0" Height="18px" Width="533px"></asp:Label>
                    <asp:Label ID="lb_error" runat="server" CssClass="ErrorMessage" Font-Names="Arial Unicode MS"
                        Font-Size="Small" ForeColor="Red" Height="18px"></asp:Label></td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
