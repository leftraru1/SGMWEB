<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ModificarCortador.aspx.vb" Inherits="ModificarCortador" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Modificación de Operador</title>
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
}
</style>

<script type="text/javascript" language="JavaScript1.2">
window.moveTo(0,0);
top.window.resizeTo(screen.availWidth,screen.availHeight);

</script>  --%>   
        
</head>
<body>
    <form id="form1" runat="server">
    <div>
        &nbsp;<table align="center" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small" CssClass="Label"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True" CssClass="Label">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small" CssClass="Label"></asp:Label>
                                                    <asp:Label ID="LB_id_usuario" runat="server" CssClass="Label"></asp:Label>
                                                    <asp:Label ID="lbIDRegion" runat="server" CssClass="Label"></asp:Label>
                                                    <asp:Label ID="lbRutEmpresa" runat="server" Font-Names="Arial" CssClass="Label"></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <div class="WebPartShadow">
                        <div id="titulo_mod" runat="server">
                            </div>
                        <table align="center" border="0" cellspacing="0">
                            <tr>
                                <td colspan="2">
                                    
                                        <table>
                                            <tr>
                                                <td class="WebPartTitle" colspan="5">
                            Modificación de Operador</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <h2 style="text-align: right">
                                                     Código Operador:&nbsp;
                                                    </h2>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_codLector" runat="server" CssClass="TextBox" MaxLength="4" Width="184px"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_codLector"
                                                        ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                                <td>
                                                </td>
                                                <td>
                                                    <h2 style="text-align: right">
                                                        <h2>Empresa: </h2>
                                                    </h2>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lbEmpresaLector" runat="server" Font-Names="Arial"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <h2 style="text-align: right">
                                                        <h2>Nombre Operador:&nbsp;
                                                        </h2></h2>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_nomLector" runat="server" CssClass="TextBox" MaxLength="50">
                                                        </asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txt_nomLector"
                                                        ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                                <td>
                                                </td>
                                                <td>
                                                    <h2 style="text-align: right">
                                                        Imagen Operador:&nbsp;</h2>
                                                </td>
                                                <td>
                                                    <asp:FileUpload ID="FileUpload_Cortador" runat="server" CssClass="botonnew" Width="200px" /></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align :right;">
                                                    <h2>Apellido Operador:&nbsp;</h2></td>
                                                <td>
                                                    <asp:TextBox ID="txt_apeLector" runat="server" CssClass="TextBox" MaxLength="50">
                                                        </asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txt_apeLector"
                                                        ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                                <td>
                                                </td>
                                                <td rowspan="7" style="vertical-align: middle;" valign="top" >
                                                    &nbsp;<h2 style="text-align: right">
                                                        <strong> </strong>
                                                    </h2>
                                                    
                                                
                                                            <table style="width: 93px; vertical-align:top;">
                                                                <tr>
                                                                    <td style="width: 89px; text-align:center;">
                                                                        <asp:Label ID="Label1" runat="server" Font-Names="Arial" Font-Size="X-Small" ForeColor="Navy"
                                                                            Text='Presione "F5"' Font-Bold="True"></asp:Label></td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 89px; text-align:center;">
                                                                        <asp:Label ID="Label2" runat="server" Font-Names="Arial" Font-Size="X-Small" ForeColor="Navy"
                                                                            Text="para actualizar" Font-Bold="True"></asp:Label></td>
                                                                </tr>                                                               
                                                                <tr>
                                                                    <td style="width: 89px; text-align: center">
                                                                        <asp:Label ID="Label3" runat="server" Font-Names="Arial" Font-Size="X-Small" ForeColor="Navy"
                                                                            Text="imagen" Font-Bold="True"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                       
                                                    
                                                </td>
                                                <td rowspan="7">
                                                    &nbsp;
                                                    <asp:Image ID="foto_cortador" runat="server" Height="150px" Width="130px" EnableViewState="False" />
                                                    </td>                                                    
                                            </tr> 
                                            <tr>
                                                <td>
                                                    <h2 style="text-align: right">
                                                        Clave Administrador:&nbsp;
                                                    </h2>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_claveAdmin" runat="server" CssClass="TextBox" MaxLength="8">
                                                        </asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txt_claveAdmin"
                                                        ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align :right;">
                                                    <h2>Clave Operador:&nbsp;
                                                    </h2></td>
                                                <td>
                                                    <asp:TextBox ID="txt_ClaveLector" runat="server" CssClass="TextBox" MaxLength="6">
                                                        </asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txt_ClaveLector"
                                                        ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right">
                                                    <h2>Correo electrónico:&nbsp;
                                                    </h2></td>
                                                <td>
                                                    <asp:TextBox ID="txt_email" runat="server" CssClass="TextBox" MaxLength="40"></asp:TextBox><asp:RequiredFieldValidator
                                                        ID="RFV_email" runat="server" ControlToValidate="txt_email" CssClass="ErrorMessage"
                                                        ErrorMessage="*"></asp:RequiredFieldValidator></td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <h2 style="text-align: right">
                                                        Región:&nbsp;
                                                    </h2>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="combo_regiones" runat="server" CssClass="ComboBox" AutoPostBack="True">
                                                    </asp:DropDownList></td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align:right; height: 4px;">
                                                    <h2>Zona:&nbsp;
                                                    </h2></td>
                                                <td style="height: 4px">
                                                    <asp:DropDownList ID="combo_zonaLector" runat="server" CssClass="ComboBox">
                                                    </asp:DropDownList></td>
                                                <td style="height: 4px">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 4px; text-align: right">
                                                    <h2>Forma Gestión:&nbsp;
                                                    </h2></td>
                                                <td style="height: 4px">
                                                    <asp:DropDownList ID="cmb_formagestion" runat="server" CssClass="ComboBox" Width="200px">
                                                        <asp:ListItem Selected="True" Value="1">PDA</asp:ListItem>
                                                        <asp:ListItem Value="2">PAPEL</asp:ListItem>
                                                    </asp:DropDownList></td>
                                                <td style="height: 4px">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                <h2 style="text-align: right">
                                                        Serie Máquina:&nbsp;
                                                </h2>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_serie_maquina" runat="server" CssClass="TextBox" MaxLength="50">
                                                        </asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txt_serie_maquina"
                                                        ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                                <td>
                                                </td>
                                                <td>
                                                    
                                                </td>
                                                <td >
                                                    </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    
                                                        <h2 style="text-align: right">Número Celular:&nbsp;
                                                        </h2></td>
                                                <td >
                                                    <asp:TextBox ID="txt_num_celular" runat="server" CssClass="TextBox" MaxLength="50">
                                                        </asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txt_num_celular"
                                                        ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                                <td>
                                                </td>
                                                <td>
                                                    <h2 style="text-align: right">
                                                        &nbsp;</h2>
                                                </td>
                                                <td >
                                                    &nbsp;<asp:TextBox ID="txt_cantidad_descarga" runat="server" CssClass="TextBox" Width="174px"></asp:TextBox><asp:RequiredFieldValidator
                                                        ID="RequiredFieldValidator6" runat="server" ControlToValidate="txt_cantidad_descarga"
                                                        ErrorMessage="*"  CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <h2 style="text-align: right">Modelo Máquina:&nbsp;
                                                    </h2></td>
                                                <td >
                                                    <asp:DropDownList ID="combo_modelo" runat="server" CssClass="ComboBox">
                                                    </asp:DropDownList></td>
                                                <td>
                                                </td>
                                                <td>
                                                    <h2 style="text-align: right">Estado Operador:</h2></td>
                                                <td >
                                                    <asp:DropDownList ID="combo_estado_lector" runat="server" CssClass="ComboBox">
                                                        <asp:ListItem>Habilitado</asp:ListItem>
                                                        <asp:ListItem>Deshabilitado</asp:ListItem>
                                                    </asp:DropDownList></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <h2 style="text-align: right">Contratista:&nbsp;
                                                    </h2></td>
                                                <td ><asp:DropDownList ID="combo_contratistas" runat="server" CssClass="ComboBox">
                                                </asp:DropDownList></td>
                                                <td>
                                                </td>
                                                <td>
                                                    <h2 style="text-align: right">
                                                        &nbsp;</h2>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="combo_fotografia" runat="server" CssClass="ComboBox">
                                                        <asp:ListItem>Sin Fotografia</asp:ListItem>
                                                        <asp:ListItem>Con Fotografia</asp:ListItem>
                                                    </asp:DropDownList></td>
                                            </tr>
                                            <tr>
                                                <td  colspan="5">
                                                    <asp:Label ID="lb_valida_claves" runat="server" Font-Names="Arial" ForeColor="Red" CssClass="ErrorMessage"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <table id="TABLE1" border="0" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td style="height: 15px">
                                                                <asp:RegularExpressionValidator ID="ER_nom" runat="server" ControlToValidate="txt_nomLector"
                                                                    Display="Dynamic" ErrorMessage="Error Nombre Operador: Se aceptan sólo letras!"
                                                                    ValidationExpression="[a-zA-Z]{3,50}([\s]{0,1}[a-zA-Z]{0,50})" CssClass="ErrorMessage"></asp:RegularExpressionValidator></td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:RegularExpressionValidator ID="ER_ape" runat="server" ControlToValidate="txt_apeLector"
                                                                    Display="Dynamic" ErrorMessage="Error Apellido Operador: Se aceptan sólo letras!"
                                                                    ValidationExpression="[a-zA-Z]{3,50}([\s]{0,1}[a-zA-Z]{0,50})" CssClass="ErrorMessage"></asp:RegularExpressionValidator></td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:RegularExpressionValidator ID="ER_codLector" runat="server" ControlToValidate="txt_codLector"
                                                                    Display="Dynamic" ErrorMessage="Error Código Operador: se aceptan sólo numéricos!"
                                                                    ValidationExpression="^([0-9]{1,4})$" CssClass="ErrorMessage"></asp:RegularExpressionValidator></td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:RegularExpressionValidator ID="ER_Claveadmin" runat="server" ControlToValidate="txt_claveAdmin"
                                                                    Display="Dynamic" ErrorMessage="Error Clave Administrador: se aceptan sólo alfanuméricos!"
                                                                    ValidationExpression="^([0-9a-zA-Z]{1,8})$" CssClass="ErrorMessage"></asp:RegularExpressionValidator></td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:RegularExpressionValidator ID="ER_ClaveLector" runat="server" ControlToValidate="txt_ClaveLector"
                                                                    Display="Dynamic" ErrorMessage="Error Clave Operador: se aceptan sólo alfanuméricos!"
                                                                    ValidationExpression="^([0-9a-zA-Z]{1,6})$" CssClass="ErrorMessage"></asp:RegularExpressionValidator></td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txt_codLector"
                                                                    Display="Dynamic" ErrorMessage="Error Código Operador: se aceptan sólo numéricos!"
                                                                    Font-Names="Arial" ValidationExpression="^([0-9]{1,4})$" CssClass="ErrorMessage"></asp:RegularExpressionValidator></td>
                                                        </tr>
                                                    </table>
                                                    <asp:RegularExpressionValidator ID="ER_email" runat="server" ControlToValidate="txt_email"
                                                        ErrorMessage="Error email: Email inválido!" Font-Names="Arial" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"></asp:RegularExpressionValidator></td>                                                
                                                <td>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lb_id_cortador" runat="server" Visible="False"></asp:Label></td>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td  colspan="2" align="right" style="height: 16px">
                                                    &nbsp;</td>
                                                <td style="height: 16px">
                                                </td>
                                                <td colspan="2" style="height: 16px">
                                   
                                                    <asp:Button ID="btn_Actualiza" runat="server" CssClass="botonnew" Text="Guardar Cambios" Width="113px" />
                                                    <asp:Button ID="btnNewEdit" runat="server" CausesValidation="False" CssClass="botonnew"
                                                        Text="Volver a editar" />
                                                    <asp:Button ID="btn_volver" runat="server" CssClass="botonnew" Text="<< Volver" CausesValidation="False" /></td>
                                            </tr>
                                        </table>
                                    
                                </td>
                            </tr>
                            <tr>
                                <td  colspan="2">
                                    </td>
                            </tr>
                        </table>
                    </div>
                <img id="img_ok" runat="server" src="fotos/ok.bmp" /><asp:Label ID="lb_mensaje_edicion"
                                        runat="server" Font-Names="Arial Unicode MS" CssClass="Label" Font-Size="Small" ForeColor="#0000C0" Width="415px"></asp:Label>
                    <asp:Label ID="lb_error" runat="server" CssClass="ErrorMessage" Font-Names="Arial Unicode MS"
                        Font-Size="Small" ForeColor="Red"></asp:Label></td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
