<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PopDigitacionCortes.aspx.vb" Inherits="PopDigitacionCortes" %>

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
                            Digitacion Ordenes De Cortes.</div>
                        <table id="TABLE1" align="center" border="0" cellspacing="0" style="width: 617px;
                            height: 1px">
                            <tr id="Tr1" runat="server">
                                <td colspan="5" style="height: 8px; text-align: right">
                                    <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label></td>
                            </tr>
                            <tr runat="server">
                                <td align="left" nowrap="nowrap" style="height: 7px; text-align: left">
                                    Nª Corte</td>
                                <td style="width: 224px; height: 7px; text-align: left">
                                    Servicio</td>
                                <td colspan="3" style="height: 7px; text-align: left">
                                    Ruta</td>
                            </tr>
                            <tr id="Tr3" runat="server">
                                <td align="left" nowrap="nowrap" style="height: 7px; text-align: left;">
                                    <asp:TextBox ID="txtDate1" runat="server" CssClass="TextBox" Width="111px"></asp:TextBox></td>
                                <td style="width: 224px; height: 7px; text-align: left;">
                                    <asp:TextBox ID="TextBox1" runat="server" CssClass="TextBox" Width="111px"></asp:TextBox></td>
                                <td colspan="3" style="height: 7px; text-align: left">
                                    <asp:TextBox ID="TextBox2" runat="server" CssClass="TextBox" Width="111px"></asp:TextBox></td>
                            </tr>
                            <tr runat="server">
                                <td colspan="5" style="height: 7px; text-align: center">
                                    <table style="width: 621px">
                                        <tr>
                                            <td style="width: 128px; text-align: left;">
                                                F. Emision</td>
                                            <td style="text-align: left">
                                                T. Corte</td>
                                            <td style="text-align: left">
                                                Saldos</td>
                                            <td style="text-align: left">
                                                Deuda</td>
                                            <td style="width: 4px; text-align: center">
                                                Abono</td>
                                        </tr>
                                        <tr>
                                            <td style="width: 128px; text-align: left;">
                                                <asp:TextBox ID="TextBox3" runat="server" CssClass="TextBox" Width="111px"></asp:TextBox></td>
                                            <td style="text-align: left">
                                                <asp:TextBox ID="TextBox4" runat="server" CssClass="TextBox" Width="111px"></asp:TextBox></td>
                                            <td style="text-align: left">
                                                <asp:TextBox ID="TextBox5" runat="server" CssClass="TextBox" Width="111px"></asp:TextBox></td>
                                            <td style="text-align: left">
                                                <asp:TextBox ID="TextBox6" runat="server" CssClass="TextBox" Width="111px"></asp:TextBox></td>
                                            <td style="width: 4px; text-align: left;">
                                                <asp:TextBox ID="TextBox7" runat="server" CssClass="TextBox" Width="111px"></asp:TextBox></td>
                                        </tr>
                                    </table>
                                    <table style="width: 609px">
                                        <tr>
                                            <td style="text-align: left">
                                                Datos Medidor</td>
                                            <td style="text-align: left">
                                                Cliente</td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: left">
                                                <asp:TextBox ID="TextBox8" runat="server" CssClass="TextBox" Width="300px"></asp:TextBox></td>
                                            <td style="text-align: left">
                                                <asp:TextBox ID="TextBox9" runat="server" CssClass="TextBox" Width="300px"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: left">
                                                Direccion</td>
                                            <td style="text-align: left">
                                                Localidad</td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: left">
                                                <asp:TextBox ID="TextBox10" runat="server" CssClass="TextBox" Width="300px"></asp:TextBox></td>
                                            <td style="text-align: left">
                                                <asp:TextBox ID="TextBox11" runat="server" CssClass="TextBox" Width="300px"></asp:TextBox></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr runat="server">
                                <td colspan="5" style="height: 7px; text-align: center">
                                </td>
                            </tr>
                            <tr id="Tr2" runat="server">
                                <td colspan="5" style="height: 7px; text-align: center">
                                    <table style="width: 615px">
                                        <tr>
                                            <td style="text-align: left">
                                                Tipo</td>
                                            <td style="text-align: left">
                                                Codigo</td>
                                            <td style="text-align: left">
                                                Cortador</td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: left"><asp:DropDownList ID="DropDownList3" runat="server" CssClass="ComboBox" Width="191px" BackColor="#FFFFC0">
                                                <asp:ListItem Value="IMPROCEDENTE">EFECTIVO</asp:ListItem>
                                            </asp:DropDownList></td>
                                            <td style="text-align: left">
                                                <asp:DropDownList ID="DropDownList2" runat="server" CssClass="ComboBox" Width="191px" BackColor="#FFFFC0">
                                                    <asp:ListItem>Corte 1 Instancia</asp:ListItem>
                                                    <asp:ListItem>Corte 2 Instancia</asp:ListItem>
                                                    <asp:ListItem>Corte arranque sin rotura</asp:ListItem>
                                                    <asp:ListItem>Corte arranque con rotura</asp:ListItem>
                                                    <asp:ListItem>Corte matriz sin rotura</asp:ListItem>
                                                    <asp:ListItem>Corte matriz con rotura</asp:ListItem>
                                                </asp:DropDownList></td>
                                            <td style="text-align: left">
                                                <asp:DropDownList ID="DropDownList1" runat="server" CssClass="ComboBox" Width="191px" BackColor="#FFFFC0">
                                                    <asp:ListItem>301 - VICTOR DARRY</asp:ListItem>
                                                    <asp:ListItem>302 - ORESTE RENE</asp:ListItem>
                                                    <asp:ListItem>304 - JUAN FRANCISCO</asp:ListItem>
                                                    <asp:ListItem>305 - LUIS ANTONIO</asp:ListItem>
                                                </asp:DropDownList></td>
                                        </tr>
                                    </table>
                                    <table style="width: 608px">
                                        <tr>
                                            <td style="text-align: left">
                                        Fecha</td>
                                            <td style="text-align: left">
                                     Hora</td>
                                            <td style="text-align: left">
                                                Lectura</td>
                                            <td style="text-align: left">
                                                Clave</td>
                                        </tr>
                                        <tr>
                                            <td style="height: 21px; text-align: left;">
                                                <asp:TextBox ID="TextBox13" runat="server" CssClass="TextBox" Width="111px" BackColor="#FFFFC0"></asp:TextBox></td>
                                            <td style="height: 21px; text-align: left;">
                                                <asp:TextBox ID="TextBox14" runat="server" CssClass="TextBox" Width="111px" BackColor="#FFFFC0"></asp:TextBox></td>
                                            <td style="height: 21px; text-align: left;">
                                                <asp:TextBox ID="TextBox15" runat="server" CssClass="TextBox" Width="111px" BackColor="#FFFFC0"></asp:TextBox></td>
                                            <td style="height: 21px; text-align: left;">
                                                <asp:TextBox ID="TextBox16" runat="server" CssClass="TextBox" Width="111px" BackColor="#FFFFC0"></asp:TextBox></td>
                                        </tr>
                                    </table>
                                    <table style="width: 609px">
                                        <tr>
                                            <td style="text-align: left">
                                                Observacion</td>
                                            <td style="text-align: left">
                                                Numero Solicitud</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:TextBox ID="txtnose" runat="server" CssClass="TextBox" Width="300px" BackColor="#FFFFC0"></asp:TextBox></td>
                                            <td>
                                                <asp:TextBox ID="Txtnose2" runat="server" CssClass="TextBox" Width="300px" BackColor="#FFFFC0"></asp:TextBox></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="Tr4" runat="server">
                                <td colspan="5" style="height: 7px; text-align: center">
                                    <table style="width: 615px">
                                        <tr>
                                            <td>
                                                <asp:Button ID="Button1" runat="server" CssClass="Button" Text="Grabar"
                                        Width="120px" /></td>
                                            <td>
                                                <asp:Button ID="Button2" runat="server" CssClass="Button" Text="Limpiar"
                                        Width="120px" /></td>
                                            <td>
                                                <asp:Button ID="btnVolver" runat="server" CssClass="Button" Text="Cerrar Ventana"
                                        Width="120px" /></td>
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
