<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ModificarLocalidades.aspx.vb" Inherits="ModificarLocalidades" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Modificación de Localidades</title>
    <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/others.css"/>
        <link type="text/css" rel="stylesheet" href="estilos/style.css"/>  
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
                <td style="width: 732px">
                    <div class="WebPartShadow_ext">
                        <div id="titulo_mod" runat="server" class="WebPartTitle_ext">
                            Modificación de Localidades</div>
                        <table align="center" border="0" cellspacing="0" style="width: 811px; height: 1px">
                            <tr>
                                <td align="right" colspan="2" style="height: 1px">
                                    <table style="width: 804px; height: 41px">
                                        <tr>
                                            <td align="right" style="width: 162px; height: 17px">
                                                <h2>
                                                    Empresa:&nbsp;
                                                </h2>
                                            </td>
                                            <td align="left" style="width: 223px; height: 17px">
                                                <asp:DropDownList ID="combo_Empresas" runat="server" CssClass="ComboBox" Width="184px" AutoPostBack="True">
                                                </asp:DropDownList></td>
                                            <td style="width: 5%; height: 17px">
                                                <asp:LinkButton ID="btn_CambioEmpresa" runat="server">Editar</asp:LinkButton></td>
                                            <td align="right" style="width: 14%; height: 17px">
                                                <h2>
                                                    &nbsp;
                                                </h2>
                                            </td>
                                            <td align="left" style="width: 215px; height: 17px">
                                                <asp:Label ID="lbEmpresaUsuario" runat="server" Font-Names="Arial"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 162px; height: 17px">
                                                <h2>
                                                    Nombre Localidad:&nbsp;
                                                </h2>
                                            </td>
                                            <td align="left" style="width: 223px; height: 17px">
                                                <asp:TextBox ID="txt_nomLocalidad" runat="server" CssClass="TextBox" MaxLength="50"
                                                    Width="184px"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txt_nomLocalidad"
                                                    ErrorMessage="*" Width="1px"></asp:RequiredFieldValidator></td>
                                            <td style="width: 5%; height: 17px">
                                            </td>
                                            <td align="right" style="width: 16%; height: 17px">
                                                <h2>
                                                    Código Localidad:&nbsp;
                                                </h2>
                                            </td>
                                            <td align="left" style="width: 215px; height: 17px">
                                                <asp:TextBox ID="txt_CodLocalidad" runat="server" CssClass="TextBox" MaxLength="3"
                                                    Width="184px"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                                                    Width="1px" ControlToValidate="txt_CodLocalidad"></asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 162px">
                                                <h2>
                                                    &nbsp;Región:&nbsp;
                                                </h2>
                                            </td>
                                            <td align="left" style="width: 223px; text-align: left;">
                                                <asp:DropDownList ID="combo_regiones" runat="server" CssClass="ComboBox" Width="184px">
                                                </asp:DropDownList></td>
                                            <td>
                                            </td>
                                            <td align="right">
                                                <h2>
                                                    Zona:&nbsp;
                                                </h2>
                                            </td>
                                            <td align="left" style="width: 215px">
                                                <asp:DropDownList ID="combo_zonas" runat="server" CssClass="ComboBox" Width="184px">
                                                </asp:DropDownList></td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 162px; height: 17px">
                                                <h2> Operador:&nbsp;</h2></td>
                                            <td align="left" style="width: 223px; height: 17px">
                                                <asp:DropDownList ID="cbo_cortador" runat="server" Width="251px" CssClass="ComboBox">
                                                </asp:DropDownList></td>
                                            <td style="height: 17px">
                                            </td>
                                            <td align="right" style="height: 17px">
                                               <h2>  Estado Operador:&nbsp;</h2></td>
                                            <td style="height: 17px; width: 215px; text-align: left;">
                                                <asp:DropDownList ID="cbo_estado_cortador" runat="server" Width="182px" CssClass="ComboBox">
                                                    <asp:ListItem>ACTIVADO</asp:ListItem>
                                                    <asp:ListItem>DESACTIVADO</asp:ListItem>
                                                </asp:DropDownList></td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 162px; height: 17px">
                                            </td>
                                            <td align="left" style="width: 223px; height: 17px">
                                            </td>
                                            <td style="height: 17px">
                                            </td>
                                            <td align="right" style="height: 17px">
                                            </td>
                                            <td style="width: 215px; height: 17px">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 162px; height: 17px">
                                                <asp:Label ID="lbRutEmpresa" runat="server" Font-Names="Arial"></asp:Label></td>
                                            <td align="left" style="width: 223px; height: 17px">
                                                <asp:Label ID="lbIDRegion" runat="server"></asp:Label></td>
                                            <td style="height: 17px">
                                            </td>
                                            <td align="right" style="height: 17px">
                                            </td>
                                            <td style="width: 215px; height: 17px">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" colspan="4" style="height: 17px">
                                                <asp:RegularExpressionValidator ID="ER_nom" runat="server" ControlToValidate="txt_nomLocalidad"
                                                    Display="Dynamic" ErrorMessage="Error Nombre Localidad: Sólo caracteres alfabéticos!"
                                                    Font-Bold="False" ValidationExpression="[a-zA-Z]{2,50}([\s]{0,3}[a-zA-Z]{0,50})([\s]{0,3}[a-zA-Z]{0,50})" Width="416px" Font-Names="Arial Unicode MS" Font-Size="Small"></asp:RegularExpressionValidator>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txt_CodLocalidad"
                                                    Display="Dynamic" ErrorMessage="Error Código Localidad: Sólo caracteres alfanuméricos!"
                                                    Font-Bold="False" ValidationExpression="^([0-9a-zA-Z]{1,3})$" Width="417px" Font-Names="Arial Unicode MS" Font-Size="Small"></asp:RegularExpressionValidator><asp:Label
                                                        ID="LB_ERROR" runat="server" Font-Bold="False" ForeColor="Red" Width="435px" Font-Names="Arial Unicode MS" Font-Size="Small"></asp:Label></td>                                            
                                            <td style="width: 215px; height: 17px">
                                                <asp:Label ID="lb_id_usuario" runat="server"></asp:Label></td>
                                        </tr>
                                    </table>
                                    <asp:Label ID="lb_perfil_usuario" runat="server"></asp:Label>
                                    <asp:Button ID="btn_Actualiza" runat="server" CssClass="botonnew" Text="Guardar Cambios"
                                        Width="120px" />
                                    <asp:Button ID="btnNewEdit" runat="server" CausesValidation="False" CssClass="botonnew"
                                        Text="Volver a editar" Width="120px" />
                                    <asp:Button ID="btn_volver" runat="server" CssClass="botonnew" Text="<< Volver" Width="120px" CausesValidation="False" />
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="2" style="height: 1px">
                                    <img id="img_ok" runat="server" src="fotos/ok.bmp" /><asp:Label ID="lb_mensaje_edicion"
                                        runat="server" Font-Names="Arial Unicode MS" Width="465px" Font-Bold="False" Font-Size="Small" ForeColor="#0000C0"></asp:Label></td>
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
