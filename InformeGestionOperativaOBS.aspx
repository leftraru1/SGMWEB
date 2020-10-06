<%@ Page Language="VB" AutoEventWireup="false" CodeFile="InformeGestionOperativaOBS.aspx.vb" Inherits="InformeGestionOperativaOBS" %>

<%@ Register Assembly="WebChart" Namespace="WebChart" TagPrefix="Web" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Informe Gestión Operativa - Claves de Observación</title>
      <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/others.css"/>  
      
      <link type="text/css" rel="stylesheet" href="estilos/loadingbox.css" />          
      <script type="text/javascript" src="js/jquery.js"></script>            
      <script type="text/javascript" src="js/progressPOP.js" ></script>        
      
      <script language="Javascript" type="text/javascript" src="../FusionCharts/FusionCharts.js"></script>
     
          
</head>
<body>    
    <form id="form1" runat="server">   
    <img src="fotos/procesando3.gif" alt="" style="display:none;" />     
    <div>
        <table id="tbl_inicio" runat="server" align="center" border="0" cellpadding="0" cellspacing="0" style="width: 900px">
            <tr>
                <td align="left">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr>
                <td align="left">
                    <div class="WebPartShadow" style="text-align: left">
                        <div id="Div2" runat="server" class="WebPartTitle">
                            INDICADORES (Detalle Informe Gestión Operativa).</div>
                        &nbsp;&nbsp;
                        <table border="0" style="width: 864px">
                            <tr>
                                <td style="height: 11px">
                                    &nbsp;<asp:Label ID="lb_titulo1" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"
                                        ForeColor="#A53902">CLAVES DE OBSERVACION</asp:Label></td>
                            </tr>
                            <tr style="color: #000000">
                                <td align="left">
                                    <asp:Label ID="lb_contador_efe" runat="server" Font-Bold="True" Font-Names="Verdana"
                                        Font-Size="X-Small" ForeColor="#003366"></asp:Label>
                                    <asp:DataGrid ID="GrillaClavesObservaciones" OnItemCommand="GrillaClavesObservaciones_RowCommand" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                                        CellPadding="1" CellSpacing="1" CssClass="GridPager" Height="1px" HorizontalAlign="Center"
                                        Width="800px">
                                        <PagerStyle BackColor="Control" Font-Bold="True" Mode="NumericPages" Visible="False" />
                                        <ItemStyle BackColor="White" />
                                        <Columns>
                                            <asp:BoundColumn DataField="CLAVE_OBS" HeaderText="CODIGO CLAVE OBSERVACI&#211;N">
                                                <HeaderStyle BackColor="#006699" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="True" ForeColor="White" Width="20%" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="CLAVE_LECTURA" HeaderText="CODIGO CLAVE LECTURA" Visible="False">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="ATENDIDO" HeaderText="ATENDIDO" Visible="False"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="DESCRIPCION_CLV_OBS" HeaderText="DESCRIPCION CLAVE OBSERVACION">
                                                <HeaderStyle BackColor="#006699" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="True" ForeColor="White" Width="45%" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Left" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="DESCRIPCION_CLV_LECTURA" HeaderText="CLAVE LECTURA">
                                                <HeaderStyle BackColor="#006699" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="True" ForeColor="White" Width="20%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="CANTIDAD" HeaderText="CANTIDAD" Visible="False">
                                                <HeaderStyle BackColor="#006699" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="True" ForeColor="White" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" />
                                            </asp:BoundColumn>
                                            <asp:TemplateColumn HeaderText="CANTIDAD">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lb_cantidad" CommandName="EXCEL" runat="server" ForeColor="Blue" OnClientClick="$.showprogress()"></asp:LinkButton>
                                                    <asp:HyperLink ID="hiper_link_obs" runat="server">[hiper_link_obs]</asp:HyperLink>
                                                    <asp:Table ID="tbl_servicios_obs" runat="server" ForeColor="Blue">
                                                    </asp:Table>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#006699" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="True" ForeColor="White" Width="15%" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" />
                                            </asp:TemplateColumn>
                                        </Columns>
                                        <HeaderStyle BackColor="Control" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" ForeColor="Black" HorizontalAlign="Center" />
                                    </asp:DataGrid></td>
                            </tr>
                            <tr style="color: #000000">
                                <td align="left">
                                    <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="left">
                                    <table border="0" cellpadding="0" cellspacing="0" style="width: 312px">
                                        <tr>
                                            <td style="width: 203px; height: 21px">
                                                <h2 style="text-align: left">
                                                    ENTREGADOS</h2>
                                            </td>
                                            <td style="width: 201px; height: 21px; text-align: left">
                                                :<asp:TextBox ID="txt_total" runat="server" CssClass="TextBox" ReadOnly="True" Width="50px"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 203px">
                                                <h2 style="text-align: left">
                                                    TOTAL EFECTIVAS</h2>
                                            </td>
                                            <td style="width: 201px; height: 21px; text-align: left">
                                                :<asp:TextBox ID="txt_cant_efectivas" runat="server" CssClass="TextBox" ReadOnly="True"
                                                    Width="50px"></asp:TextBox>
                                                <asp:TextBox ID="txt_porcentaje_efe" runat="server" CssClass="TextBox" ReadOnly="True"
                                                    Width="50px"></asp:TextBox>
                                                %</td>
                                        </tr>
                                        <tr>
                                            <td style="width: 203px">
                                                <h2 style="text-align: left">
                                                    TOTAL IMPROCEDENTES</h2>
                                            </td>
                                            <td style="width: 201px; text-align: left">
                                                :<asp:TextBox ID="txt_cant_improcedentes" runat="server" CssClass="TextBox" ReadOnly="True"
                                                    Width="50px"></asp:TextBox>
                                                <asp:TextBox ID="txt_porcentaje_imp" runat="server" CssClass="TextBox" ReadOnly="True"
                                                    Width="50px"></asp:TextBox>
                                                %</td>
                                        </tr>
                                        <tr>
                                            <td style="width: 203px; height: 19px;">
                                                <h2 style="text-align: left">
                                                    EFECTIVIDAD
                                                </h2>
                                            </td>
                                            <td style="width: 201px; text-align: left; height: 19px;">
                                                :<asp:TextBox ID="txt_efectividad" runat="server" CssClass="TextBox" ReadOnly="True"
                                                    Width="50px"></asp:TextBox>
                                                %</td>
                                        </tr>
                                    </table>
                                    </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Button ID="btnvolver" runat="server" CssClass="Button" Text="Cerrar Ventana"
                                        Width="120px" /></td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>    
    
    </div>
        <table id="Tabla_GraficoTortas" runat="server" align="center" border="0" cellpadding="0"
            cellspacing="0" class="WebPartShadow" onclick="return TABLE2_onclick()" style="width: 900px;
            height: 152px">
            <tr style="font-weight: bold; font-size: 8pt; color: #000000; font-family: Times New Roman">
                <td align="center" style="width: 50%; height: 12px">
                    <table>
                        <tr>
                            <td align="center">
                                <asp:Literal ID="LiteralTorta1" runat="server"></asp:Literal>
                            </td>
                        </tr>
                    </table>
                </td>
                <td align="center" style="width: 50%; height: 12px">
                    &nbsp;<asp:Literal ID="LiteralTorta2" runat="server"></asp:Literal></td>
            </tr>
        </table>
        <table id="Tabla_GraficoTLF" runat="server" align="center" border="0" cellpadding="0"
            cellspacing="0" class="WebPartShadow" onclick="return TABLE2_onclick()" style="width: 900px;
            height: 152px">
            <tr style="font-weight: bold; font-size: 8pt; color: #000000; font-family: Times New Roman">
                <td align="center" style="width: 50%; height: 12px">
                    <asp:Literal ID="Literal_TiposLectura" runat="server"></asp:Literal>&nbsp;</td>
                <td align="center" style="width: 50%; height: 12px">
                    &nbsp;<asp:Literal ID="Literal_EvaluacionFotografica" runat="server"></asp:Literal></td>
            </tr>
        </table>
        
    </form>
</body>
</html>
