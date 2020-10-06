<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PopDigitacionRepos.aspx.vb" Inherits="PopDigitacionRepos" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Detalle CyR...</title>
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
        <table id="tbl_inicio" runat="server" align="center" border="0" cellpadding="0" cellspacing="0"
            style="width: 450px; height: 130px">
            <tr>
                <td align="left" style="width: 732px">
                    <div class="WebPartShadow">
                        <div id="Div2" runat="server" class="WebPartTitle">
                            <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                                Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                                    Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                        Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                            ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label><br />
                            Digitacion Ordenes De Reposiciones.</div>
                        <table id="TABLE1" align="center" border="0" cellspacing="0" style="width: 617px;
                            height: 1px">
                            <tr id="Tr1" runat="server">
                                <td colspan="5" style="height: 8px; text-align: right">
                                    <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label></td>
                            </tr>
                            <tr id="Tr2" runat="server">
                                <td align="left" nowrap="nowrap" style="height: 7px; text-align: left">
                                    <strong>
                                    Nª Orden</strong></td>
                                <td style="width: 224px; height: 7px; text-align: left">
                                    <strong>
                                    Servicio</strong></td>
                                <td colspan="3" style="height: 7px; text-align: left">
                                    <strong>
                                    Ruta</strong></td>
                            </tr>
                            <tr id="Tr3" runat="server">
                                <td align="left" nowrap="nowrap" style="height: 7px; text-align: left">
                                    <asp:TextBox ID="txt_num_orden" runat="server" CssClass="TextBox" Width="111px"></asp:TextBox></td>
                                <td style="width: 224px; height: 7px; text-align: left">
                                    <asp:TextBox ID="txt_id_servicio" runat="server" CssClass="TextBox" Width="111px"></asp:TextBox></td>
                                <td colspan="3" style="height: 7px; text-align: left">
                                    <asp:TextBox ID="txt_ruta" runat="server" CssClass="TextBox" Width="111px"></asp:TextBox></td>
                            </tr>
                            <tr id="Tr4" runat="server">
                                <td colspan="5" style="height: 7px; text-align: center">
                                    <table style="width: 636px">
                                        <tr>
                                            <td style="width: 128px; text-align: left">
                                                <strong>
                                                F. Emision</strong></td>
                                            <td style="text-align: left" colspan="2">
                                                <strong>
                                                T. Orden</strong></td>
                                            <td style="text-align: left">
                                                <strong>
                                                Deuda</strong></td>
                                            <td style="width: 4px; text-align: left">
                                                <strong>
                                                Abono</strong></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 128px; text-align: left">
                                                <asp:TextBox ID="txt_fechEmision" runat="server" CssClass="TextBox" Width="131px"></asp:TextBox></td>
                                            <td style="text-align: center" colspan="2">
                                                <asp:TextBox ID="txt_tipoOrden" runat="server" CssClass="TextBox" Width="111px"></asp:TextBox></td>
                                            <td style="text-align: left">
                                                <asp:TextBox ID="txt_deuda" runat="server" CssClass="TextBox" Width="111px"></asp:TextBox></td>
                                            <td style="width: 4px; text-align: left">
                                                <asp:TextBox ID="txt_abono" runat="server" CssClass="TextBox" Width="111px"></asp:TextBox></td>
                                        </tr>
                                    </table>
                                    <table style="width: 630px">
                                        <tr>
                                            <td style="text-align: left">
                                                <strong>
                                                Datos Medidor</strong></td>
                                            <td style="text-align: left">
                                                <strong>
                                                Cliente</strong></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: left">
                                                <asp:TextBox ID="txt_datos_medidor" runat="server" CssClass="TextBox" Width="300px"></asp:TextBox></td>
                                            <td style="text-align: left">
                                                <asp:TextBox ID="txt_nomcliente" runat="server" CssClass="TextBox" Width="300px"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: left">
                                                <strong>
                                                Direccion</strong></td>
                                            <td style="text-align: left">
                                                <strong>
                                                Localidad</strong></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: left">
                                                <asp:TextBox ID="txt_direccion" runat="server" CssClass="TextBox" Width="300px"></asp:TextBox></td>
                                            <td style="text-align: left">
                                                <asp:TextBox ID="txt_localidad" runat="server" CssClass="TextBox" Width="300px"></asp:TextBox></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="Tr5" runat="server">
                                <td colspan="5" style="height: 7px; text-align: center">
                                </td>
                            </tr>
                            <tr id="Tr6" runat="server">
                                <td colspan="5" style="height: 7px; text-align: center">
                                    <table style="width: 615px">
                                        <tr>
                                            <td style="text-align: left; width: 298px;">
                                                <strong>
                                                Tipo Corte</strong></td>
                                            <td style="text-align: left" colspan="2">
                                                <strong>Clave Orden</strong></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: left; width: 298px;">
                                                <asp:DropDownList ID="cbo_tipocorte" runat="server" BackColor="#FFFFC0" CssClass="ComboBox"
                                                    Width="298px" AutoPostBack="True">
                                                    <asp:ListItem>SELECCIONE TIPO CORTE</asp:ListItem>
                                                    <asp:ListItem Value="1">EFECTIVO</asp:ListItem>
                                                    <asp:ListItem Value="2">IMPROCEDENTE</asp:ListItem>
                                                </asp:DropDownList></td>
                                            <td style="text-align: left" colspan="2">
                                                <asp:DropDownList ID="cbo_clave_orden" runat="server" BackColor="#FFFFC0" CssClass="ComboBox"
                                                    Width="298px">
                                                </asp:DropDownList></td>
                                        </tr>
                                    </table>
                                    <table style="width: 608px">
                                        <tr>
                                            <td style="text-align: left; width: 203px;">
                                                <strong>Clave Lectura</strong></td>
                                            <td style="text-align: left; width: 210px;">
                                                <strong>
                                                Cortador</strong></td>
                                            <td style="text-align: left" colspan="2">
                                                <strong>Lectura</strong><strong></strong></td>
                                        </tr>
                                        <tr>
                                            <td style="height: 21px; text-align: left; width: 203px;"><asp:DropDownList ID="cbo_clave_lectura" runat="server" BackColor="#FFFFC0" CssClass="ComboBox"
                                                    Width="202px">
                                            </asp:DropDownList></td>
                                            <td style="height: 21px; text-align: left; width: 210px;">
                                                <asp:DropDownList ID="cbo_cortador" runat="server" BackColor="#FFFFC0" CssClass="ComboBox"
                                                    Width="209px">
                                                </asp:DropDownList></td>
                                            <td style="height: 21px; text-align: left" colspan="2">
                                                <asp:TextBox ID="txt_lectura" runat="server" BackColor="#FFFFC0" CssClass="TextBox"
                                                    Width="173px"></asp:TextBox></td>
                                        </tr>
                                    </table>
                                    <table style="width: 609px">
                                        <tr>
                                            <td style="text-align: left" colspan="2">
                                                <strong>
                                                Observacion</strong></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:TextBox ID="txt_observacion" runat="server" BackColor="#FFFFC0" CssClass="TextBox" Width="593px" Height="37px" MaxLength="50" TextMode="MultiLine"></asp:TextBox></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="Tr7" runat="server">
                                <td colspan="5" style="height: 7px; text-align: center">
                                    <table style="width: 615px">
                                        <tr>
                                            <td>
                                                <asp:Button ID="btn_grabar" runat="server" CssClass="botonnew" Text="Grabar" Width="120px" Height="24px" /></td>
                                            <td>
                                                <asp:Button ID="btn_limpiar" runat="server" CssClass="botonnew" Text="Limpiar" Width="120px" Height="24px" /></td>
                                            <td>
                                                <asp:Button ID="btnVolver" runat="server" CssClass="botonnew" Text="Cerrar Ventana"
                                                    Width="120px" Height="24px" /></td>
                                        </tr>
                                    </table>
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
