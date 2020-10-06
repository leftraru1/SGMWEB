<%@ Page Language="VB" AutoEventWireup="false" CodeFile="CierreProcesoGeneral.aspx.vb" Inherits="CierreProcesoGeneral" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Cierre Proceso Regional Cortes - Sistema CYR</title>
     <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/others.css"/>
      
<%-- <style type="text/css">
body {
margin:0;
width: 100%;
height: 100%;
}
</style>

<script type="text/javascript" language="JavaScript1.2">
window.moveTo(0,0);
top.window.resizeTo(screen.availWidth,screen.availHeight);

</script>       --%> 
      
      
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table id="Table3" align="center" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <asp:Label ID="Lb_user" runat="server" CssClass="Label" Font-Bold="True" Font-Names="Arial"
                        Font-Size="X-Small" Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user"
                            runat="server" CssClass="Label" Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label
                                ID="lb_empresa" runat="server" CssClass="Label" Font-Bold="True" Font-Names="Arial"
                                Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label ID="lb_session_empresa"
                                    runat="server" CssClass="Label" Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label
                                        ID="lb_rut_empresa" runat="server" CssClass="Label"></asp:Label>
                    <asp:Label ID="lb_id_usuario" runat="server" CssClass="Label"></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <div class="WebPartShadow_ext">
                        <div class="WebPartTitle">
                            Cierre Proceso Regional Cortes</div>
                        <table align="center" border="0" cellspacing="0" style="width: 364px">
                            <tr>
                                <td align="left" class="WebPartShadow" colspan="2" nowrap="nowrap">
                                    &nbsp;<table>
                                        <tr>
                                            <td colspan="1" style="width: 227px">
                                                <h2>
                                                    TIPO 
                                                    PROCESO</h2>
                                            </td>
                                            <td colspan="1" style="width: 227px">
                                                <h2>
                                                    PROCESO:</h2>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 227px">
                                                <asp:DropDownList ID="Combo_TiposProceso" runat="server" AutoPostBack="True" CssClass="ComboBox2">
                                                </asp:DropDownList></td>
                                            <td style="width: 227px">
                                                <asp:DropDownList ID="combo_lotes" runat="server" AutoPostBack="True" CssClass="ComboBox2">
                                                </asp:DropDownList></td>
                                        </tr>
                                        <tr>
                                            <td colspan="1" style="width: 227px">
                                            </td>
                                            <td colspan="1" style="width: 227px">
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <asp:Label ID="lb_grupoproceso" runat="server"></asp:Label><asp:Label ID="lb_lote"
                            runat="server"></asp:Label><asp:Label ID="lb_id_tipoproceso" runat="server"></asp:Label></div>
                </td>
            </tr>
        </table>
    
    </div>
        <table id="tbl_inicio2" runat="server" align="center" border="0" cellspacing="0"
            class="WebPartShadow">
            <tr>
                <td align="left" colspan="2">
                    <div>
                        <asp:Label ID="lb_cont_registros" runat="server" Width="463px"></asp:Label><asp:DataGrid ID="GrillaCierreProcesoGeneral" runat="server" AutoGenerateColumns="False"
                                                        BorderColor="#003366" BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1"
                                                        CssClass="GridAlternativeItems" ForeColor="Black" GridLines="Horizontal" Height="1px"
                                                        Width="840px">
                                                        <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                                                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                                                            VerticalAlign="Middle" />
                                                        <AlternatingItemStyle BackColor="White" />
                                                        <ItemStyle BackColor="White" HorizontalAlign="Center" />
                                                        <HeaderStyle BackColor="Control" BorderColor="Black" Font-Bold="True" Font-Underline="False"
                                                            ForeColor="Black" HorizontalAlign="Center" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" />
                                                        <Columns>
                                                            <asp:BoundColumn DataField="id_localidad" HeaderText="IDLocalidad" Visible="False">
                                                                <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                                    Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="cod_localidad" HeaderText="C&#243;digo Localidad">
                                                                <HeaderStyle Width="12%" BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="nom_localidad" HeaderText="Localidad">
                                                                <HeaderStyle Width="23%" BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="leidos" HeaderText="Le&#237;dos">
                                                                <HeaderStyle Width="13%" BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="pendientes" HeaderText="Pendientes">
                                                                <HeaderStyle Width="13%" BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="sin_lectura" HeaderText="Sin Corte">
                                                                <HeaderStyle Width="13%" BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="efectivas" HeaderText="Efectivas">
                                                                <HeaderStyle Width="13%" BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="total_localidad" HeaderText="Total Localidad">
                                                                <HeaderStyle Width="13%" BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                                            </asp:BoundColumn>
                                                        </Columns>
                                                    </asp:DataGrid>&nbsp;</div>
                                    <asp:Image ID="img_ok" runat="server" ImageUrl="fotos/ok.bmp" /><asp:Label ID="ok_cierre_general"
                                        runat="server" Font-Names="Arial Unicode MS" ForeColor="#0000C0" CssClass="Label" Font-Size="Small" Height="18px" Width="679px"></asp:Label><asp:Label ID="lbValida_cierre" runat="server" Font-Names="Arial Unicode MS" ForeColor="Red" CssClass="Label" Font-Size="Small" Height="18px"></asp:Label></td>
            </tr>
            <tr>
                <td align="left" colspan="2" style="height: 2px">
                                        <table id="Table2" align="center" border="0" cellspacing="0" width="840">
                                            <tr>
                                                <td align="left" colspan="1" style="width: 158px">
                                                 <h2>
                                                     Total Cortes</h2>
                                                </td>
                                                <td colspan="1" style="height: 3px">
                                                    <asp:TextBox ID="txt_total" runat="server" CssClass="TextBox" Width="50px"></asp:TextBox>
                                                    ( 100 % )</td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="1" style="width: 158px">
                                                    <strong>
                                                        <h2>
                                                            Cortes Leidos</h2>
                                                    </strong>
                                                </td>
                                                <td colspan="1" style="height: 3px">
                                                    <asp:TextBox ID="txt_cant_leidas" runat="server" CssClass="TextBox" Width="50px"></asp:TextBox>
                                                    <asp:TextBox ID="txt_leidas" runat="server" CssClass="TextBox" Width="50px"></asp:TextBox>
                                                    %</td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="1" style="width: 158px">
                                                    <h2>
                                                        Cortes Pendientes</h2>
                                                </td>
                                                <td colspan="1">
                                                    <asp:TextBox ID="txt_cant_pendientes" runat="server" CssClass="TextBox" Width="50px"></asp:TextBox>
                                                    <asp:TextBox ID="txt_pendientes" runat="server" CssClass="TextBox" Width="50px"></asp:TextBox>
                                                    %</td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="1" style="height: 3px; width: 158px;">
                                                    <h2>
                                                        Cortes Efectivos</h2>
                                                </td>
                                                <td colspan="1" style="height: 3px">
                                                    <asp:TextBox ID="txt_cant_efectivos" runat="server" CssClass="TextBox" Width="50px"></asp:TextBox>
                                                    <asp:TextBox ID="txt_efectivos" runat="server" CssClass="TextBox" Width="50px"></asp:TextBox>
                                                    %</td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="1" style="width: 158px">
                                                    <h2>
                                                        Cortes Improcedentes</h2>
                                                </td>
                                                <td colspan="1">
                                                    <asp:TextBox ID="txt_cant_sin_lecturas" runat="server" CssClass="TextBox" Width="50px"></asp:TextBox>
                                                    <asp:TextBox ID="txt_sin_lecturas" runat="server" CssClass="TextBox" Width="50px"></asp:TextBox>
                                                    %</td>
                                            </tr>
                                        </table>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: left">
                    &nbsp;<asp:Label ID="lb_error" runat="server" CssClass="Label" Font-Names="Arial Unicode MS"
                        Font-Size="Small" ForeColor="Red" Height="18px" Width="626px"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: right; height: 21px;">
                                    <asp:Button ID="btnCierreProcesoGeneral" runat="server" CssClass="botonnew" Text="Cierre Proceso" />
                    <asp:Button ID="btnCancelar" runat="server" CssClass="botonnew" Text="Reversar proceso (Cierre Parcial)"
                        Width="202px" />
                    <asp:Button ID="btnCancelarAdmin" runat="server" CssClass="botonnew" Text="Abrir Proceso Parcial (Administrador)"
                        Width="227px" />
                    <asp:Button ID="btnVolver" runat="server" CssClass="botonnew" Text="<< Volver" /></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: right">
                    &nbsp;</td>
            </tr>
        </table>
    </form>
</body>
</html>
