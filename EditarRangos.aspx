<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EditarRangos.aspx.vb" Inherits="EditarRangos" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Modificación de Rangos...</title>
    <link type="text/css" rel="stylesheet" href="estilos/page.css">
      <link type="text/css" rel="stylesheet" href="estilos/controls.css">
      <link type="text/css" rel="stylesheet" href="estilos/grid.css">
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css">
      <link type="text/css" rel="stylesheet" href="estilos/menu.css">
      <link type="text/css" rel="stylesheet" href="estilos/others.css"> 
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 684px;
            height: 152px">
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
                    <div class="WebPartShadow_rango">
                        <div id="titulo_mod" runat="server" class="WebPartTitle_rango" style="width: 734px">
                            Modificación de
                            Rangos de lecturas...</div>
                        <table align="center" border="0" cellspacing="0" style="width: 709px; height: 1px"
                            width="709">
                            <tr id="tr_btn_agrega" runat="server">
                                <td align="right" colspan="2" style="height: 3px">
                                    <asp:LinkButton ID="btnAgregaRango" runat="server" Font-Bold="True" Font-Names="Arial"
                                        ForeColor="#0000C0">Agregar Rango</asp:LinkButton></td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="height: 1px">
                                    <div id="div_nuevo_lector" runat="server" class="WebPartShadow" style="text-align: justify">
                                        <table id="tbl_ingreso_lector" runat="server" style="width: 692px; height: 41px">
                                            <tr>
                                                <td align="right" style="width:25%; height: 17px">
                                                    <h2>
                                                        <strong>Localidad:&nbsp; </strong>
                                                    </h2>
                                                </td>
                                                <td style="width: 20%; height: 17px">
                                                    <asp:Label ID="lbLocalidad_rango" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
                                                <td style="width: 5%; height: 17px">
                                                </td>
                                                <td align="right" style="width: 20%; height: 17px">
                                                    <h2>
                                                        <strong>Empresa:&nbsp; </strong>
                                                    </h2>
                                                </td>
                                                <td style="width: 30%; height: 17px">
                                                    <asp:Label ID="lbEmpresa_rango" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="height: 17px">
                                                    <h2>
                                                        <strong>Rango M3:&nbsp; </strong>
                                                    </h2>
                                                </td>
                                                <td style="height: 17px" colspan="4">                                                
                                                    <asp:Label ID="LB_RANGO_EDICION" runat="server" Font-Names="Arial Black" Font-Size="Small"
                                                        ForeColor="Navy"></asp:Label></td>                                                
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <h2>
                                                        <strong>&nbsp;Validación Menor (%):&nbsp; </strong>
                                                    </h2>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_valmenor" runat="server" CssClass="TextBox" MaxLength="8"
                                                        Width="100px"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txt_valmenor"
                                                        ErrorMessage="*" Width="1px"></asp:RequiredFieldValidator></td>                                                
                                                <td align="right" colspan="2">
                                                    <h2>
                                                        <strong>Validación Mayor (%):&nbsp; </strong>
                                                    </h2>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_valmayor" runat="server" CssClass="TextBox" MaxLength="6"
                                                        Width="100px"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txt_valmayor"
                                                        ErrorMessage="*" Width="1px"></asp:RequiredFieldValidator></td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="2" style="height: 1px">
                                                    &nbsp;<table id="TABLE1" border="0" cellpadding="0" cellspacing="0" style="width: 283px">
                                                        <tr>
                                                            <td>
                                                                <asp:RegularExpressionValidator ID="ER_nom" runat="server" ControlToValidate="txt_valmenor"
                                                                    Display="Dynamic" ErrorMessage="Error Validación menor: Se aceptan sólo números!"
                                                                    ValidationExpression="[0-9]{1,3}"></asp:RegularExpressionValidator></td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:RegularExpressionValidator ID="ER_ape" runat="server" ControlToValidate="txt_valmayor"
                                                                    Display="Dynamic" ErrorMessage="Error Validación mayor: Se aceptan sólo números!"
                                                                    ValidationExpression="[0-9]{1,3}"></asp:RegularExpressionValidator></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="height: 8px">
                                                </td>
                                                <td align="right" style="height: 1px">
                                                </td>
                                                <td style="height: 1px">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" colspan="5" style="height: 17px">
                                                    <asp:Label ID="lb_IDLocalidad" runat="server"></asp:Label>
                                                    <asp:Label ID="lbRutEmpresa" runat="server" Font-Names="Arial"></asp:Label>&nbsp;<asp:Button
                                                        ID="btnnewEdit" runat="server" CssClass="Button" Text="Volver a editar"
                                                        Width="120px" />
                                                    <asp:Button
                                                        ID="btnEditaRango" runat="server" CssClass="Button" Text="Actualizar datos"
                                                        Width="120px" />
                                                    <asp:Button ID="btnVolver" runat="server" CausesValidation="False" CssClass="Button"
                                                        Text="<< Volver" Width="120px" />
                                                </td>
                                            </tr>
                                        </table>
                                        <table id="tbl_ingreso_ok" runat="server" style="width: 690px; height: 1px">
                                            <tr>
                                                <td align="center">
                                                    <img id="img_ok" runat="server" src="fotos/ok.bmp" />
                                                    <asp:Label ID="lb_mensaje" runat="server" Font-Names="Arial" Width="175px"></asp:Label></td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
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
