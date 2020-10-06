<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ControlFotograficoDetalle.aspx.vb" Inherits="ControlFotograficoDetalle" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Control Fotográfico - Sistema CYR </title>
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
        <table id="Table5" runat="server" align="center" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td id="panel_sesion" style="text-align: left">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr style="font-size: 12pt; font-family: Trebuchet MS">
                <td id="tbl_inicio" runat="server" class="WebPartShadow">
                    <table align="center" cellpadding="0" style="width: 900px">
                        <tr id="Tr2" runat="server">
                            <td class="WebPartTitle_ext" colspan="6" nowrap="nowrap" style="height: 30px; text-align:left;">
                                Detalle Control Fotográfico...</td>
                        </tr>
                        <tr id="Tr4" runat="server">
                            <td align="center" colspan="6" nowrap="nowrap" rowspan="4" style="height: 55px">
                                <table cellspacing="0" style="width: 880px">
                                    <tr>
                                        <td style="width: 8%; text-align: right; height: 19px;">
                                            <h2>
                                                ID Servicio:&nbsp;
                                            </h2>
                                        </td>
                                        <td style="width: 13%; height: 19px; text-align:left;">
                                            <asp:Label ID="lb_id_servicio" runat="server" Font-Names="Arial Unicode MS" ForeColor="#C00000"></asp:Label>
                                        </td>
                                        <td style="width: 10%; text-align: right; height: 19px; font-family: Trebuchet MS;">
                                            <h2>
                                                Tipo Orden:&nbsp;
                                            </h2>
                                        </td>
                                        <td style="width: 19%; text-align: left; height: 19px;">
                                            <asp:Label ID="lb_tipo_orden" runat="server" Font-Names="Arial Unicode MS" ForeColor="#C00000" Font-Bold="False"></asp:Label>
                                        </td>
                                        <td style="width: 8%; text-align: right">
                                            <h2>
                                                N° Orden:&nbsp;
                                            </h2>
                                        </td>
                                        <td style="text-align:left; width: 15%;">
                                            <asp:Label ID="lb_num_orden" runat="server" Font-Names="Arial Unicode MS" ForeColor="#C00000"></asp:Label>
                                        </td>
                                        <td style="text-align: right; width: 10%;">
                                            <h2>
                                                Estado Orden:&nbsp;
                                            </h2>                                        
                                        </td>
                                        <td style="text-align:left; width: 17%;">
                                            <asp:Label ID="lb_estado_orden" runat="server" Font-Bold="False" Font-Names="Arial Unicode MS"
                                                ForeColor="#C00000"></asp:Label>
                                        </td> 
                                    </tr>
              
                      
                                </table>
                                &nbsp; &nbsp;
                                &nbsp; &nbsp;
                            </td>
                        </tr>
                        <tr>
                        </tr>
                        <tr id="Tr8" runat="server">
                        </tr>
                        <tr id="Tr14" runat="server">
                        </tr>
                        <tr runat="server">
                            <td align="left" colspan="6" nowrap="nowrap" rowspan="1" style="height: 5px">
                                <asp:Label ID="lb_error" runat="server" CssClass="Label" Font-Names="Arial" ForeColor="Red"></asp:Label></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="font-family: Trebuchet MS">
                <td id="Td1" runat="server" class="WebPartShadow">
                    &nbsp;&nbsp;
                    <table>
                        <tr>
                            <td align="center" style="font-weight: bold; width: 900px; color: white; height: 17px;
                                background-color: cornflowerblue; text-align: center">
                                LISTADO DE IMAGENES ENCONTRADAS</td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 890px">
                                <asp:Label ID="lb_registros" runat="server" Font-Names="Arial Unicode MS" Font-Size="Small"
                                    Width="704px"></asp:Label>
                                <asp:Label ID="lb_rut_empresa" runat="server" CssClass="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 890px">
                                <asp:GridView ID="gv1" runat="server" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None"
                                    BorderWidth="1px" CellPadding="3" GridLines="Horizontal" Width="900px">
                                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Visualizar Imagen">
                                            <ItemTemplate>
                                                &nbsp;<img id="imgHTML" runat="server" alt="Click para ampliar" src="" style="width: 100px;
                                                    height: 95px" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" ForeColor="#F7F7F7" />
                                    <AlternatingRowStyle BackColor="#F7F7F7" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                    &nbsp;
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
