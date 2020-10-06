<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ModificarUsuario.aspx.vb" Inherits="ModificarUsuario" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Modificación de Usuario</title>
    <link type="text/css" rel="stylesheet" href="estilos/page.css">
      <link type="text/css" rel="stylesheet" href="estilos/controls.css">
      <link type="text/css" rel="stylesheet" href="estilos/grid.css">
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css">
      <link type="text/css" rel="stylesheet" href="estilos/menu.css">
      <link type="text/css" rel="stylesheet" href="estilos/others.css">
        <link type="text/css" rel="stylesheet" href="estilos/style.css">    
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
            <tr>
                <td style="width: 732px">
                    <div class="WebPartShadow">
                        <div id="titulo_mod" runat="server" class="WebPartTitle">
                            <strong>Modificación</strong> de <strong>Usua</strong>rios</div>
                        <table align="center" border="0" cellspacing="4" style="width: 709px; height: 107px"
                            width="709">
                            <tr>
                                <td align="left" colspan="2" nowrap="nowrap" style="height: 15px">
                                    <h2>
                                        <asp:Label ID="lb_minihead" runat="server" Text="Por favor, seleccione los datos de Usuario a modificar:"></asp:Label></h2>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2">
                                    <strong>
                                        <table id="tbl_NuevoUser" runat="server" style="width: 710px">
                                            <tr>
                                                <td align="left" colspan="5" style="width: 12%; height: 4px">
                                                    <h2>
                                                        (*) Campos Obligatorios</h2>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" colspan="1" style="width: 14%; height: 4px">
                                                    <h2>
                                                        &nbsp;<strong>Nombre:</strong>&nbsp;
                                                    </h2>
                                                </td>
                                                <td align="left" colspan="1" style="width: 33%; height: 4px">
                                                    &nbsp;
                                                    <input id="txt_nombre" runat="server" class="TextBox" type="text" />
                                                    <asp:RequiredFieldValidator ID="rq_nombre" runat="server" ControlToValidate="txt_nombre"
                                                        ErrorMessage="*"></asp:RequiredFieldValidator></td>
                                                <td colspan="1" style="width: 3%; height: 4px">
                                                    &nbsp;</td>
                                                <td align="right" colspan="1" style="width: 105px; height: 4px">
                                                    <h2>
                                                        &nbsp;<strong>RUT:</strong>&nbsp;
                                                    </h2>
                                                </td>
                                                <td align="left" style="width: 35%; height: 4px">
                                                    &nbsp;
                                                    <asp:TextBox ID="txt_rut" runat="server" CssClass="TextBox" ForeColor="ControlText"
                                                        MaxLength="8" Width="106px"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator2"
                                                            runat="server" ControlToValidate="txt_rut" ErrorMessage="*"></asp:RequiredFieldValidator>-
                                                    <asp:TextBox ID="txt_dv" runat="server" CssClass="TextBox" MaxLength="1" Width="23px"></asp:TextBox><asp:RequiredFieldValidator
                                                        ID="RequiredFieldValidator4" runat="server" ControlToValidate="txt_dv" ErrorMessage="*"></asp:RequiredFieldValidator></td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <h2>
                                                        &nbsp;<strong>Usuario:</strong>&nbsp;
                                                    </h2>
                                                </td>
                                                <td align="left">
                                                    &nbsp;
                                                    <asp:TextBox ID="txt_login" runat="server" CssClass="TextBox" Width="200px"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_login"
                                                        ErrorMessage="*"></asp:RequiredFieldValidator>&nbsp;</td>
                                                <td style="width: 130px">
                                                </td>
                                                <td align="right" style="width: 105px">
                                                    <h2>
                                                        &nbsp;<strong>Clave Acceso:</strong>&nbsp;
                                                    </h2>
                                                </td>
                                                <td align="left">
                                                    &nbsp;
                                                    <asp:TextBox ID="txt_pass" runat="server" CssClass="TextBox" Width="200px"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txt_pass"
                                                        ErrorMessage="*"></asp:RequiredFieldValidator></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 214px; height: 12px">
                                                    <h2>
                                                        &nbsp;<strong>Empresa:</strong>&nbsp;
                                                    </h2>
                                                </td>
                                                <td align="left" style="width: 926px; height: 12px">
                                                    &nbsp;&nbsp;<asp:DropDownList ID="combo_empresas" runat="server" CssClass="ComboBox"
                                                        Width="200px">
                                                    </asp:DropDownList></td>
                                                <td style="width: 130px; height: 12px">                                               
                                                </td>
                                                <td align="right" style="width: 105px; height: 12px">
                                                    <h2>
                                                        &nbsp;<strong>Tipo Usuario:</strong>&nbsp;
                                                    </h2>
                                                </td>
                                                <td align="left" style="width: 670px; height: 12px">
                                                    &nbsp;
                                                    <asp:DropDownList ID="combo_perfiles" runat="server" CssClass="ComboBox" Width="200px">
                                                    </asp:DropDownList></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 214px; height: 12px">
                                                   <h2>
                                                        <strong>Multiempresa:</strong>&nbsp;
                                                    </h2>
                                                </td>
                                                <td align="left" style="width: 926px; height: 12px">
                                                    &nbsp;
                                                    <asp:DropDownList ID="combo_multiempresa" runat="server" CssClass="ComboBox"
                                                        Width="64px">
                                                        <asp:ListItem Value="2">SI</asp:ListItem>
                                                        <asp:ListItem Value="1">NO</asp:ListItem>
                                                    </asp:DropDownList></td>
                                                <td style="width: 130px; height: 12px">
                                                </td>
                                                <td align="right" style="width: 105px; height: 12px">
                                                   <h2>
                                                        <strong>Active Directory:</strong>&nbsp;
                                                    </h2>
                                                </td>
                                                <td align="left" style="width: 670px; height: 12px">
                                                    &nbsp;
                                                    <asp:DropDownList ID="combo_active_directory" runat="server" CssClass="ComboBox"
                                                        Width="112px">
                                                        <asp:ListItem Selected="True" Value="Sin Validacion">Sin Validacion</asp:ListItem>
                                                        <asp:ListItem Value="Validar">Validar</asp:ListItem>
                                                    </asp:DropDownList></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 214px; height: 2px">                                                    
                                                    <h2><strong>Permisos App:&nbsp; </strong></h2>
                                                </td>
                                                <td align="left" style="width: 926px; height: 2px">
                                                    <asp:CheckBox ID="check_sgl" runat="server" Font-Bold="False" Font-Names="Arial Unicode MS" Text="SGL" /><br />
                                                    <asp:CheckBox ID="check_cyr" runat="server" Font-Bold="False" Font-Names="Arial Unicode MS" Text="SICORE" /></td>
                                                <td style="width: 130px; height: 2px">
                                                </td>
                                                <td align="right" style="width: 105px; height: 2px">
                                                </td>
                                                <td align="left" style="width: 670px; height: 2px">
                                                </td>
                                            </tr>                                               
                                            <tr>
                                                <td align="left" colspan="5" style="height: 12px">
                                                    <asp:Label ID="VALIDACION_RUT_USUARIO" runat="server" Font-Bold="False" Font-Names="Arial"
                                                        ForeColor="Red"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="3" style="height: 17px">
                                                    <table id="TABLE1" border="0" cellpadding="0" cellspacing="0" style="width: 310px">
                                                        <tr>
                                                            <td style="width: 310px">
                                                                <asp:RegularExpressionValidator ID="ER_nom" runat="server" ControlToValidate="txt_nombre"
                                                                    Display="Dynamic" ErrorMessage="Error Nombre Usuario: Se aceptan sólo letras!"
                                                                    Font-Bold="False" ValidationExpression="[a-zA-Z]{3,50}([\s]{0,1}[a-zA-Z]{0,50})([\s]{0,1}[a-zA-Z]{0,50})([\s]{0,1}[a-zA-Z]{0,50})([\s]{0,1}[a-zA-Z]{0,50})"></asp:RegularExpressionValidator></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 310px">
                                                                <asp:RegularExpressionValidator ID="ER_RUT" runat="server" ControlToValidate="txt_rut"
                                                                    Display="Dynamic" ErrorMessage="Error RUT Usuario: Formato incorrecto!" Font-Bold="False"
                                                                    ValidationExpression="[0-9]{7,8}"></asp:RegularExpressionValidator></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 310px">
                                                                <asp:RegularExpressionValidator ID="ER_RUT_DV" runat="server" ControlToValidate="txt_dv"
                                                                    Display="Dynamic" ErrorMessage="Error RUT(Dígito Verificador): Sólo números o letra k!"
                                                                    Font-Bold="False" ValidationExpression="[0-9kK]{1}"></asp:RegularExpressionValidator></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 310px; height: 15px">
                                                                <asp:RegularExpressionValidator ID="ER_login" runat="server" ControlToValidate="txt_login"
                                                                    Display="Dynamic" ErrorMessage="Error Login: se aceptan sólo alfanuméricos!"
                                                                    Font-Bold="False" ValidationExpression="^([0-9a-zA-Z]{1,50})$"></asp:RegularExpressionValidator></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 310px">
                                                                <asp:RegularExpressionValidator ID="ER_pass" runat="server" ControlToValidate="txt_pass"
                                                                    Display="Dynamic" ErrorMessage="Error Clave Acceso: se aceptan sólo alfanuméricos!"
                                                                    Font-Bold="False" ValidationExpression="^([0-9a-zA-Z]{1,50})$"></asp:RegularExpressionValidator></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 310px">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="width: 105px; height: 17px">
                                                </td>
                                                <td style="width: 670px; height: 17px">
                                                    <asp:Label ID="LB_RUT_EMPRESA" runat="server"></asp:Label>
                                                    <asp:Label ID="lb_id_usuario" runat="server"></asp:Label>&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" colspan="5" style="height: 17px">
                                                    &nbsp;<asp:Button ID="btn_actualiza" runat="server" CssClass="botonnew" Text="Guardar Cambios"
                                                        Width="120px" />
                                                    <asp:Button ID="Btn_newEDIT" runat="server" CausesValidation="False" CssClass="botonnew"
                                                        Text="Volver a Editar" Width="120px" />
                                                    <asp:Button ID="btnVolver" runat="server" CausesValidation="False" CssClass="botonnew"
                                                        Text="<< Volver" Width="120px" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="5" style="height: 17px">
                                                    &nbsp;</td>
                                            </tr>
                                        </table>
                                    </strong>&nbsp;&nbsp;
                                    </td>
                            </tr>
                        </table>
                    </div>
                                    <img id="img_ok" runat="server" src="fotos/img_ok2.bmp" />
                                    <asp:Label ID="lb_mensaje_edicion" runat="server" Font-Names="Arial Unicode MS" Width="447px" Font-Bold="False" Font-Size="Small" ForeColor="#0000C0" Height="18px"></asp:Label>
                    <asp:Label ID="lb_error" runat="server" CssClass="ErrorMessage" Font-Names="Arial Unicode MS"
                        Font-Size="Small" ForeColor="Red" Height="18px"></asp:Label></td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
