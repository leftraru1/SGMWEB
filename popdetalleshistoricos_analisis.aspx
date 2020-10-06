<%@ Page Language="VB" AutoEventWireup="false" CodeFile="popdetalleshistoricos_analisis.aspx.vb" Inherits="popdetalleshistoricos_analisis" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Detalle de la Lectura...</title>
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
                            Detalle Histórico de Lectura.</div>
                        <table id="TABLE1" align="center" border="0" cellspacing="0" style="width: 617px;
                            height: 1px">
                            <tr id="Tr1" runat="server">
                                <td align="left" nowrap="nowrap" style="width: 126px; height: 8px">
                                    </td>
                                <td style="width: 163px; height: 8px">
                                </td>
                                <td style="width: 5706px; height: 8px">
                                </td>
                                <td style="width: 38%; height: 8px">
                                    <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label></td>
                            </tr>
                            <tr id="Tr2" runat="server">
                                <td align="left" colspan="4" nowrap="nowrap">
                                    <h2>
                                        Resumen de la lectura histórica realizada.</h2>
                                </td>
                            </tr>
                            <tr id="Tr3" runat="server">
                                <td align="left" nowrap="nowrap" style="width: 126px; height: 9px">
                                </td>
                                <td style="width: 163px; height: 9px">
                                </td>
                                <td style="width: 5706px; height: 9px">
                                </td>
                                <td style="height: 9px">
                                </td>
                            </tr>
                            <tr id="Tr4" runat="server">
                                <td align="right" nowrap="nowrap" colspan="1" style="width: 126px; height: 26px">
                                    <h2>
                                        &nbsp;Nombre Cliente: &nbsp;
                                    </h2>
                                </td>
                                <td align="left" colspan="3" nowrap="nowrap" style="width: 177px; height: 26px">
                                    <asp:Label ID="lb_nom_cliente" runat="server" Font-Bold="True" Font-Names="Arial"
                                        ForeColor="#0000C0"></asp:Label></td>                           
                            </tr>
                            <tr runat="server">
                                <td align="right" nowrap="nowrap" colspan="1" style="width: 126px; height: 26px">
                                  <h2>
                                        &nbsp;Dirección: &nbsp;
                                    </h2>
                                </td>
                                <td align="left" colspan="3" nowrap="nowrap" style="width: 177px; height: 26px">
                                    <asp:Label ID="lb_direccion" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                                <td align="right" style="width: 200px; height: 26px">
                                </td>
                                <td style="height: 32px">
                                </td>
                            </tr>
                            <tr id="Tr8" runat="server">
                                <td align="right" nowrap="nowrap" style="width: 126px; height: 26px">
                                    <h2>
                                        Lote: &nbsp;</h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 163px">
                                    <asp:Label ID="lb_lote" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                                <td align="right" style="width: 5706px">
                                    <h2>
                                        Ruta: &nbsp;</h2>
                                </td>
                                <td>
                                    <asp:Label ID="lb_ruta" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                            </tr>
                            <tr runat="server">
                                <td align="right" nowrap="nowrap" style="width: 126px; height: 26px">
                                <h2>
                                        Localidad: &nbsp;</h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 163px">                                
                                    <asp:Label ID="lb_localidad" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                                <td align="right" style="width: 5706px">
                                 <h2>
                                     Orden
                                        Ruta:&nbsp;</h2>
                                </td>
                                <td>
                                    <asp:Label ID="lb_Ordenruta" runat="server" Font-Bold="True" Font-Names="Arial"
                                        ForeColor="#0000C0"></asp:Label></td>
                            </tr>
                            <tr id="Tr10" runat="server">
                                <td align="right" nowrap="nowrap" style="width: 126px; height: 26px">
                                    <h2>
                                        Clave Lectura: &nbsp;</h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 163px">
                                    <asp:Label ID="lb_clave_lectura" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                                <td style="width: 5706px">
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr runat="server">
                                <td align="right" nowrap="nowrap" style="width: 126px; height: 26px">
                                <h2>
                                        Clave Observación: &nbsp;</h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 163px">
                                    <asp:Label ID="lb_clave_observacion" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                                <td style="width: 5706px">
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr runat="server">
                                <td align="right" nowrap="nowrap" style="width: 126px; height: 26px">
                                <h2>
                                    Meses sin Lectura: &nbsp;</h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 163px">
                                    <asp:Label ID="lb_meses_sin_lectura" runat="server" Font-Bold="True" Font-Names="Arial"
                                        ForeColor="#0000C0"></asp:Label></td>
                                <td style="width: 5706px" align="right">
                                 <h2>
                                    Intentos:&nbsp;</h2>
                                </td>
                                <td align="left">
                                    <asp:Label ID="lb_intentos" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                            </tr>
                            <tr runat="server">
                                <td align="right" nowrap="nowrap" style="width: 126px; height: 26px">
                                <h2>
                                    Observaciones:&nbsp;</h2>
                                </td>
                                <td align="left" nowrap="nowrap" colspan="3">
                                    <asp:Label ID="lb_observaciones" runat="server" Font-Bold="True" Font-Names="Arial"
                                        ForeColor="#0000C0"></asp:Label></td>
                            </tr>
                            <tr runat="server">
                                <td align="right" nowrap="nowrap" style="width: 126px; height: 26px">
                                <h2>
                                    Medidor Nuevo: &nbsp;</h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 163px">
                                    <asp:Label ID="lb_medidor" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                                <td align="right" style="width: 5706px">
                                <h2>
                                    Marca M.N.:&nbsp;</h2>
                                </td>
                                <td>
                                    <asp:Label ID="lb_marca" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                            </tr>
                            <tr runat="server">
                                <td align="right" nowrap="nowrap" style="width: 126px; height: 26px">
                                <h2>
                                    Diámetro Nuevo: &nbsp;</h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 163px">
                                    <asp:Label ID="lb_diametro" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                                <td align="right" style="width: 5706px">
                                <h2>
                                    Folio:&nbsp;</h2>
                                </td>
                                <td>                                
                                    <asp:Label ID="lb_folio" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                            </tr>
                            <tr runat="server">
                                <td align="right" nowrap="nowrap" style="width: 126px; height: 26px">
                                <h2>
                                    Valor catastro: &nbsp;</h2>
                                </td>
                                <td align="left" colspan="3" nowrap="nowrap">
                                    <asp:Label ID="lb_catastro" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="right" colspan="4">
                                    &nbsp;<input id="Button2" class="Button" onclick="history.go(-1)" style="width: 112px"
                                        type="button" value="Atrás" />
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
