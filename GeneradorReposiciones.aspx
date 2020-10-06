<%@ Page Language="VB" AutoEventWireup="false" CodeFile="GeneradorReposiciones.aspx.vb" Inherits="GeneradorReposiciones" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Generador Reposiciones - Sistema CYR</title>
        <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
        <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
        <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
        <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
        <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
        <link type="text/css" rel="stylesheet" href="estilos/others.css"/>
      
</head>
<body>
    <form id="form1" runat="server">
    <div style="text-align: center">
        &nbsp;</div>
        <table id="Table5" runat="server" align="center" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td id="panel_sesion" align="left" style="width: 520px">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True" CssClass="Label">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small" CssClass="Label"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True" CssClass="Label">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small" CssClass="Label"></asp:Label><asp:Label ID="lb_rut_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small" CssClass="Label"></asp:Label></td>
            </tr>
            <tr style="font-family: Trebuchet MS">
                <td id="Td1" runat="server" class="WebPartShadow" style="width: 520px; height: 354px">
                                        <table id="B" align="center" border="0" cellspacing="0" onclick="return Table2_onclick()" class="WebPartShadow">
                                            <tr id="Tr1" runat="server">
                                                <td align="left" class="WebPartTitle" colspan="3" nowrap="nowrap">
                                                    Generador Reposiciones.</td>
                                            </tr>
                                            <tr id="Tr6" runat="server">
                                                <td align="left" colspan="3" nowrap="nowrap">
                                                    <h2>
                                                        Ingrese Número de Cliente y luego oprima "Buscar Cliente"</h2>
                                                </td>
                                            </tr>
                                            <tr id="Tr7" runat="server">
                                                <td colspan="3" style="text-align: left">
                                                    <asp:RadioButtonList ID="Rd_tipo_Busqueda" runat="server" RepeatDirection="Horizontal" CssClass="Label" Visible="False">
                                                        <asp:ListItem Value="1" Selected="True">IC</asp:ListItem>
                                                    </asp:RadioButtonList><h2>
                                                        &nbsp;</h2>
                                                </td>
                                            </tr>
                                            <tr id="Tr2" runat="server">
                                                <td align="left" colspan="3" nowrap="nowrap" style="text-align: center">
                                                    <%--<asp:LinkButton ID="lk_VerRegistro" runat="server" Font-Bold="True" ForeColor="#0000C0" CssClass="Label" Visible="False">VER CLIENTE</asp:LinkButton>&nbsp;--%>
                                                    <%--<asp:RequiredFieldValidator
                                                        ID="RequiredFieldValidator1" runat="server" ControlToValidate="texto_Busqueda"
                                                        Display="Dynamic" ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator>--%>
                                                        <asp:TextBox ID="texto_Busqueda" runat="server" CssClass="TextBox2"></asp:TextBox><asp:Label ID="lb_busca" runat="server" CssClass="Label"></asp:Label>
                                                    <asp:Button ID="btnBuscar" runat="server" CausesValidation="False" CssClass="botonnew"
                                                        Text="Buscar Cliente" /></td>
                                            </tr>
                                            <tr runat="server" id="Tr4">
                                                <td align="left" colspan="3" nowrap="nowrap">
                                                    <%--<asp:RegularExpressionValidator ID="Expr_valida" runat="server" ControlToValidate="texto_Busqueda"
                                                        ErrorMessage="SE ACEPTAN SÓLO NUMEROS EN EL TEXTO DE BUSQUEDA!" ValidationExpression="^([0-9]{1,18})$" Font-Names="Arial" CssClass="ErrorMessage"></asp:RegularExpressionValidator>--%></td>
                                            </tr>
                                            <tr runat="server" id="Tr5">
                                                <td align="left" colspan="3" nowrap="nowrap">
                                                    <asp:Label ID="lb_mensaje_busqueda" runat="server" ForeColor="Red" Font-Names="Arial" CssClass="ErrorMessage"></asp:Label></td>
                                            </tr>
                                        </table>
                    <table id="Table1" align="center" border="0" cellspacing="0" class="WebPartShadow">
                        <tr id="Tr8" runat="server">
                        </tr>
                        <tr id="Tr3" runat="server">
                            <td align="right" nowrap="nowrap">
                                <h2>Nombre Cliente:&nbsp;</h2>
                            </td>
                            <td colspan="3" align="left">
                                <asp:Label ID="lb_nomCliente" runat="server" Font-Bold="True"></asp:Label>
                                </td>
                        </tr>
                        <tr id="Tr9" runat="server">
                            <td align="right" nowrap="nowrap">
                            <h2>
                                                        &nbsp;Dirección:&nbsp;</h2></td>
                            <td colspan="3" align="left">
                                <asp:Label ID="lb_Direccion" runat="server" Text="" Font-Bold="True"></asp:Label>
                                </td>
                        </tr>
                        <tr id="Tr10" runat="server">
                            <td align="right" nowrap="nowrap" style="height: 20px">
                                <h2>
                                                        Medidor:&nbsp;
                                </h2>
                            </td>
                            <td align="left" nowrap="nowrap">
                                <asp:Label ID="lb_medidor" runat="server" Text="" Font-Bold="True"></asp:Label>
                                </td>
                            <td align="right" style="width: 71px; height: 20px">
                                <h2 style="text-align: right">
                                                        Marca:&nbsp;
                                </h2>
                            </td>
                            <td style="width: 169px" align="left">
                                <asp:Label ID="lb_marca_medidor" runat="server" Text="" Font-Bold="True"></asp:Label>
                                    </td>
                        </tr>
                        <tr id="Tr14" runat="server">
                            <td align="right" nowrap="nowrap" style="height: 22px">
                                <h2>
                                    Diametro:&nbsp;
                                </h2>
                            </td>
                            <td align="left" nowrap="nowrap">
                                <asp:Label ID="lb_diametro" runat="server" Text="" Font-Bold="True"></asp:Label>
                                    </td>
                            <td align="right" style="width: 71px; height: 22px">
                                <h2 style="text-align: right">
                                                        Localidad:&nbsp;
                                </h2>
                            </td>
                            <td style="width: 169px" align="left">
                                <asp:Label ID="lb_localidad" runat="server" Text="" Font-Bold="True"></asp:Label>
                                    </td>
                        </tr>
                        <tr id="Tr15" runat="server">
                            <td align="right" nowrap="nowrap" style="height: 20px">
                                <h2>
                                                        Orden Ruta:&nbsp;
                                </h2>
                            </td>
                            <td align="left" nowrap="nowrap">
                                <asp:Label ID="lb_ordenRuta" runat="server" Text="" Font-Bold="True"></asp:Label>
                                    </td>
                            <td align="right" style="width: 71px">
                                <h2 style="text-align: right">
                                    Ruta:&nbsp;
                                </h2>
                            </td>
                            <td style="width: 169px" align="left">
                                <asp:Label ID="lb_ruta" runat="server" Text="" Font-Bold="True"></asp:Label>
                                </td>
                        </tr>
                        
                        <tr id="Tr16" runat="server">
                            <td align="right" nowrap="nowrap"></td>
                            <td colspan="3" align="left">
                                &nbsp;<asp:Label ID="lb_idServicio" runat="server" Visible="False"></asp:Label>
                                &nbsp;<asp:Label ID="lb_lote" runat="server" Visible="False"></asp:Label>
                                &nbsp;<asp:Label ID="lb_codLocalidad" runat="server" Visible="False"></asp:Label>
                                &nbsp;<asp:Label ID="lb_libreta" runat="server" Visible="False"></asp:Label>
                            </td>
                        </tr>
                        <tr runat="server">
                            <td align="right" nowrap="nowrap">
                            </td>
                            <td align="left" colspan="3">
                                &nbsp;<asp:Label ID="lb_lect_ant" runat="server" Visible="False"></asp:Label>
                                &nbsp;<asp:Label ID="lb_minimo" runat="server" Visible="False"></asp:Label>
                                &nbsp;<asp:Label ID="lb_maximo" runat="server" Visible="False"></asp:Label>
                            </td>
                        </tr>
                        
                        <tr id="Tr17" runat="server">
                            <td align="right" nowrap="nowrap"></td>
                            <td align="left" class="WebPartTitle" colspan="3" nowrap="nowrap">
                                                    Selección</td>
                        </tr>
                        
                        <tr id="Tr18" runat="server">
                            <td align="right" nowrap="nowrap">
                                <h2>Contratistas:&nbsp;</h2>
                            </td>
                            <td colspan="3" align="left">
                                <asp:DropDownList ID="combo_contratista" onchange="$.showprogress()" runat="server" AutoPostBack="True" CssClass="ComboBox2" Width="304px">
                                </asp:DropDownList></td>
                        </tr>
                        <tr id="Tr19" runat ="server" >
                            <td align ="right" nowrap="nowrap">
                                <h2>Observación:&nbsp;</h2>
                            </td>
                            <td colspan="3" align="left">
                                <asp:TextBox ID="txt_observacion" runat="server" CssClass="TextBox"
                                    Width="224px" MaxLength="30"></asp:TextBox>&nbsp;</td>
                        </tr>
                        <tr runat="server">
                            <td align ="right" nowrap="nowrap">
                                <h2>Teléfono:&nbsp;</h2>
                            </td>
                            <td colspan="3" align="left">
                                <asp:TextBox ID="txt_telefono" runat="server" CssClass="TextBox"
                                    Width="224px" MaxLength="15"></asp:TextBox>&nbsp;</td>
                        </tr>
                        <tr runat="server">
                            <td align="right" nowrap="nowrap" style="height: 17px">
                            </td>
                            <td align="left" colspan="3" style="height: 17px">
                                <asp:Label ID="lb_error" runat="server" CssClass="ErrorMessage" Font-Names="Arial"
                                    ForeColor="Red"></asp:Label></td>
                        </tr>
                        
                        <tr id="Tr20" runat="server">
                            <td align="right" nowrap="nowrap" style="height: 32px">
                                <h2>&nbsp;</h2>
                                </td>
                            <td nowrap="nowrap" style="height: 32px">
                                </td>
                            <td style="height: 32px">
                                </td>
                            <td style="width: 169px; height: 32px;" align="right">
                            <asp:Button ID="btnGenerarRepo" runat="server" CssClass="botonnew" Text="Generar Reposición" CausesValidation="False" Width="144px" />
                                </td>
                        </tr>
                        <tr id="Tr21" runat="server">
                            <td align="right" nowrap="nowrap"><img alt="" id="img_ok" runat="server" src="fotos/ok.bmp" /></td>
                            <td align="left"  colspan="3" nowrap="nowrap">
                                <asp:Label ID="lb_mensajeok" runat="server" Text="" Font-Names="Arial Unicode MS"
                        Font-Size="Small" ForeColor="#0000C0" Height="18px"></asp:Label>
                                
                                </td>
                        </tr>
                      
                       
                    </table>
                    
                    
                </td>
            </tr>
        </table>
        
    </form>
</body>
</html>
