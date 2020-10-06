<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AgregaLocalidad.aspx.vb" Inherits="AgregaLocalidad" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Ingreso Localidad Nueva - Sistema CYR</title>
    <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/others.css"/> 
      
<script type="text/javascript" language="javascript">   
window.moveTo(0,0);
top.window.resizeTo(screen.availWidth,screen.availHeight);
</script>       
      
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 758px; height: 152px" width="758">
            <tr>
                <td style="width: 732px">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 732px; height: 357px;">
                    <div class="WebPartShadow_ext" style="width: 931px">
                        <div id="titulo_mod" runat="server" class="WebPartTitle_ext" style="width: 909px">
                            Ingreso de Nueva Localidad:</div>
                        <table align="center" border="0" cellspacing="0" style="width: 895px; height: 1px">
                            <tr>
                                <td align="center" colspan="2" style="height: 1px">
                                    <div id="div_nuevo_lector" runat="server" class="WebPartShadow" style="text-align: justify">
                                        <table id="tbl_ingreso_lector" runat="server" style="width: 856px; height: 41px">
                                            <tr>
                                                <td align="right" style="width: 162px; height: 17px">
                                                    <h2>
                                                        <strong>Empresa:&nbsp; </strong>
                                                    </h2>
                                                </td>
                                                <td style="width: 319px; height: 17px"><asp:DropDownList ID="combo_empresa" runat="server" CssClass="ComboBox" Width="184px" AutoPostBack="True">
                                                </asp:DropDownList></td>
                                                <td style="height: 17px">
                                                </td>
                                                <td align="right" style="width: 14%; height: 17px">
                                                    <h2>
                                                        <strong>&nbsp; </strong>
                                                    </h2>
                                                </td>
                                                <td style="width: 30%; height: 17px">
                                                    <asp:Label ID="lbEmpresaLocalidad" runat="server" Font-Names="Arial"></asp:Label>
                                                    <asp:Label ID="lbRutEmpresa" runat="server" Font-Names="Arial"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 162px; height: 17px">
                                                    <h2>
                                                        <strong>Código Localidad:&nbsp; </strong>
                                                    </h2>
                                                </td>
                                                <td style="width: 319px; height: 17px">
                                                    <asp:TextBox ID="txt_CodLocalidad" runat="server" CssClass="TextBox" MaxLength="3"
                                                        Width="184px"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txt_CodLocalidad"
                                                        ErrorMessage="*" Width="1px"></asp:RequiredFieldValidator></td>
                                                <td style="height: 17px">
                                                </td>
                                                <td align="right" style="width: 16%; height: 17px">
                                                    <h2>
                                                        <strong>Región:&nbsp; </strong>
                                                    </h2>
                                                </td>
                                                <td style="width: 30%; height: 17px">
                                                    <asp:DropDownList ID="combo_regiones" runat="server" CssClass="ComboBox" Width="184px" AutoPostBack="True">
                                                    </asp:DropDownList></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 162px">
                                                    <h2>
                                                        <strong>&nbsp;Nombre Localidad:&nbsp; </strong>
                                                    </h2>
                                                </td>
                                                <td style="width: 319px">
                                                    <asp:TextBox ID="txt_NomLocalidad" runat="server" CssClass="TextBox" MaxLength="50"
                                                        Width="184px"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txt_NomLocalidad"
                                                        ErrorMessage="*" Width="1px"></asp:RequiredFieldValidator></td>
                                                <td>
                                                </td>
                                                <td align="right">
                                                    <h2>
                                                        <strong>Zona:&nbsp; </strong>
                                                    </h2>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="combo_zonaLocalidad" runat="server" CssClass="ComboBox" Width="184px">
                                                    </asp:DropDownList></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 162px">
                                                   <h2>
                                                        <strong>  Cortador:&nbsp;</strong>  </h2></td>
                                                <td style="width: 319px">
                                                    <asp:DropDownList ID="cbo_cortador" runat="server" AutoPostBack="True" CssClass="ComboBox"
                                                        Width="234px">
                                                    </asp:DropDownList></td>
                                                <td>
                                                </td>
                                                <td align="right">
                                                  <h2>
                                                        <strong>   Estado Cortador:</strong>  </h2></td>
                                                <td>
                                                    <asp:DropDownList ID="cbo_estado_cortador" runat="server" AutoPostBack="True" CssClass="ComboBox"
                                                        Width="182px">
                                                        <asp:ListItem>ACTIVADO</asp:ListItem>
                                                        <asp:ListItem Selected="True">DESACTIVADO</asp:ListItem>
                                                    </asp:DropDownList></td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="2" style="height: 8px">
                                                    &nbsp;<table id="TABLE1" border="0" cellpadding="0" cellspacing="0" style="width: 310px">
                                                        <tr>
                                                            <td>
                                                                <asp:RegularExpressionValidator ID="ER_nom" runat="server" ControlToValidate="txt_nomLocalidad"
                                                                    Display="Dynamic" ErrorMessage="Error Nombre Localidad: Se aceptan sólo letras!"
                                                                    ValidationExpression="[a-zA-Z]{2,50}([\s]{0,3}[a-zA-Z]{0,50})([\s]{0,3}[a-zA-Z]{0,50})" Font-Names="Arial"></asp:RegularExpressionValidator></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="height: 15px">
                                                                <asp:RegularExpressionValidator ID="ER_codLector" runat="server" ControlToValidate="txt_CodLocalidad"
                                                                    Display="Dynamic" ErrorMessage="Error Código Localidad: se aceptan sólo alfanuméricos!"
                                                                    ValidationExpression="^([0-9a-zA-Z]{1,3})$" Font-Names="Arial"></asp:RegularExpressionValidator></td>
                                                        </tr>
                                                    </table>
                                                    <asp:Label ID="LB_VALIDA_COD_LOCALIDAD" runat="server" ForeColor="Red" Width="309px" Font-Names="Arial"></asp:Label></td>
                                                <td style="height: 8px">
                                                </td>
                                                <td align="right" style="height: 8px">
                                                </td>
                                                <td style="height: 8px">
                                                    <asp:Label ID="lb_id_usuario" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td align="right" colspan="5" style="height: 17px">
                                                    <asp:Label ID="lb_perfil_usuario" runat="server"></asp:Label>
                                                    <asp:Label ID="lb_nom_empresa" runat="server"></asp:Label>
                                                    <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label>
                                                    &nbsp;<asp:Button ID="btnInsertaLocalidad" runat="server" CssClass="botonnew" Text="Agregar Localidad"
                                                        Width="120px" />
                                                    <asp:Button ID="btnCancelar" runat="server" CausesValidation="False" CssClass="botonnew"
                                                        Text="Cancelar" Width="120px" />
                                                    <asp:Button ID="btnVolver" runat="server" CausesValidation="False" CssClass="botonnew"
                                                        Text="<< Volver" Width="120px" />
                                                </td>
                                            </tr>
                                        </table>
                                        <table id="tbl_ingreso_ok" runat="server" style="width: 854px; height: 1px">
                                            <tr>
                                                <td align="center">
                                                    &nbsp;</td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                                                    <img alt="" id="img_ok" runat="server" src="fotos/img_ok2.bmp" style="height: 20px" />
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
