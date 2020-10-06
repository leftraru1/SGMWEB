<%@ Page Language="VB" AutoEventWireup="false" CodeFile="InformeGestionOperativaDet.aspx.vb" Inherits="InformeGestionOperativaDet" %>
<%@ Register Assembly="WebChart" Namespace="WebChart" TagPrefix="Web" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Informe Gestión Operativa - Detalle.</title>
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
                <td align="left" style="width: 900px">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr>
                <td align="left" style="width: 900px">
                    <div class="WebPartShadow" style="text-align: left">
                        <div id="Div2" runat="server" class="WebPartTitle">
                            INDICADORES (Detalle Informe Gestión Operativa).</div>
                        &nbsp;&nbsp;
                        <table border="0">
                            <tr>
                                <td style="height: 11px">
                                    &nbsp;
                                    <table style="width: 364px">
                                        <tr>
                                            <td style="width:50%;">
                                    <asp:Label ID="lb1" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                                        ForeColor="Navy">Consulta Agrupación:</asp:Label></td>
                                            <td  style="width:50%;">
                                                <asp:Label ID="lb_nom_grupo" runat="server" Font-Names="Arial" Font-Size="Small" ForeColor="#A53902" Width="128px"></asp:Label></td>
                                        </tr>
                                    </table>
                                    <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label>
                                    <asp:Table ID="tbl_link" runat="server" Width="712px">
                                    </asp:Table>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 11px">
                                    &nbsp;<asp:Label ID="lb_titulo1" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"
                                        ForeColor="#A53902">CLAVES EFECTIVAS</asp:Label></td>
                            </tr>
                            <tr style="color: #000000">
                                <td align="left">
                                    <asp:Label ID="lb_contador_efe" runat="server" Font-Bold="True" Font-Names="Verdana"
                                        Font-Size="X-Small" ForeColor="#003366"></asp:Label>
                                    <asp:DataGrid ID="GrillaClavesEfectivas" runat="server" OnItemCommand="GrillaClavesEfectivas_RowCommand" AutoGenerateColumns="False" BorderWidth="0px"
                                        CellPadding="1" CellSpacing="1" CssClass="GridPager" Height="1px" HorizontalAlign="Center"
                                        Width="800px">
                                        <PagerStyle BackColor="Control" Font-Bold="True" Mode="NumericPages" Visible="False" />
                                        <ItemStyle BackColor="White" />
                                        <Columns>
                                            <asp:BoundColumn DataField="CLAVE" HeaderText="CODIGO CLAVE">
                                                <HeaderStyle BackColor="#006699" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="True" ForeColor="White" Width="20%" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="DESCRIPCION" HeaderText="DESCRIPCION">
                                                <HeaderStyle BackColor="#006699" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="True" ForeColor="White" Width="50%" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Left" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="CANTIDAD" HeaderText="CANTIDAD" Visible="False">
                                                <HeaderStyle BackColor="#006699" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="True" ForeColor="White" Width="0%" HorizontalAlign="Center" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" />
                                            </asp:BoundColumn>
                                            <asp:TemplateColumn HeaderText="CANTIDAD">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lb_cantidad" CommandName="EXCEL" runat="server" ForeColor="Blue" OnClientClick="$.showprogress()"></asp:LinkButton>
                                                    <asp:HyperLink ID="hiper_link_efe" runat="server">[hiper_link_efe]</asp:HyperLink>
                                                    <asp:Table ID="tbl_servicios_efe" runat="server" ForeColor="Blue">
                                                    </asp:Table>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#006699" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="True" ForeColor="White" Width="30%" HorizontalAlign="Center" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False"  HorizontalAlign="Center" />
                                            </asp:TemplateColumn>
                                        </Columns>
                                        <HeaderStyle BackColor="Control" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" ForeColor="Black" HorizontalAlign="Center" />
                                    </asp:DataGrid></td>
                            </tr>
                            
                            <tr>
                                <td>
                                    <table  cellpadding="3" style="width: 800px" >
                                        <tr>
                                            <td style="width: 20%"> </td>
                                            <td style="width: 50%; text-align: left"> <h2 style="text-align: center">
                                                    TOTAL EFECTIVAS</h2> </td>
                                            <td style="width: 30%; text-align: center"> <asp:TextBox ID="txt_cant_efectivas" runat="server" CssClass="TextBox" ReadOnly="True"
                                                    Width="80px"></asp:TextBox></td>
                                        </tr>
                                    </table>
                                    </td>
                            </tr>
                            
                            
                            <tr style="color: #000000">
                                <td align="left">
                                    <asp:Label ID="lb_titulo2" runat="server" Font-Bold="True" Font-Names="Verdana"
                                        Font-Size="X-Small" ForeColor="#A53902">CLAVES IMPROCEDENTES</asp:Label></td>
                            </tr>
                            <tr style="color: #000000">
                                <td align="left">
                                    <asp:Label ID="lb_contador_imp" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"
                                        ForeColor="#003366"></asp:Label>
                                    <asp:DataGrid ID="GrillaClavesImprocedentes" OnItemCommand="GrillaClavesImprocedentes_RowCommand"  runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                                        CellPadding="1" CellSpacing="1" CssClass="GridPager" Height="1px" HorizontalAlign="Center"
                                        Width="800px">
                                        <PagerStyle BackColor="Control" Font-Bold="True" Mode="NumericPages" Visible="False" />
                                        <ItemStyle BackColor="White" />
                                        <Columns>
                                            <asp:BoundColumn DataField="CLAVE" HeaderText="CODIGO CLAVE">
                                                <HeaderStyle BackColor="#006699" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="True" ForeColor="White" Width="20%" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="DESCRIPCION" HeaderText="DESCRIPCION">
                                                <HeaderStyle BackColor="#006699" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="True" ForeColor="White" Width="50%" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Left" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="CANTIDAD" HeaderText="CANTIDAD" Visible="False">
                                                <HeaderStyle BackColor="#006699" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="True" ForeColor="White" Width="0%" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" />
                                            </asp:BoundColumn>
                                            <asp:TemplateColumn HeaderText="CANTIDAD">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lb_cantidad" CommandName="EXCEL" runat="server" ForeColor="Blue"></asp:LinkButton>
                                                    <asp:HyperLink ID="hiper_link_imp" runat="server">[hiper_link_imp]</asp:HyperLink>
                                                    <asp:Table ID="tbl_servicios_imp" runat="server" ForeColor="Blue">
                                                    </asp:Table>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#006699" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="True" ForeColor="White" Width="30%" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" />
                                            </asp:TemplateColumn>
                                        </Columns>
                                        <HeaderStyle BackColor="Control" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" ForeColor="Black" HorizontalAlign="Center" />
                                    </asp:DataGrid></td>
                            </tr>
                            
                            <tr>
                                <td>
                                    <table  cellpadding="3" style="width: 800px" >
                                        <tr>
                                            <td style="width: 20%"> </td>
                                            <td style="width: 50%; text-align: center">
                                                <h2 style="text-align: center">TOTAL IMPROCEDENTES</h2></td>
                                            <td style="width: 30%; text-align: center"> <asp:TextBox ID="txt_cant_improcedentes" runat="server" CssClass="TextBox" ReadOnly="True"
                                                    Width="80px"></asp:TextBox></td>
                                        </tr>
                                    </table>
                                    </td>
                            </tr>
                           
                            <tr style="color: #000000">
                                <td align="left" style="height: 17px">
                                    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Verdana"
                                        Font-Size="X-Small" ForeColor="#A53902" Visible="False">CLAVES INHIBIDAS</asp:Label></td>
                            </tr>
                            <tr style="color: #000000">
                                <td align="left">
                                    <asp:Label ID="lb_contador_inh"  runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"
                                        ForeColor="#003366" Visible="False"></asp:Label>
                                    <asp:DataGrid ID="GrillaClavesInhibidas" OnItemCommand="GrillaClavesInhibidas_RowCommand" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                                        CellPadding="1" CellSpacing="1" CssClass="GridPager" Height="1px" HorizontalAlign="Center"
                                        Width="800px" Visible="False">
                                        <PagerStyle BackColor="Control" Font-Bold="True" Mode="NumericPages" Visible="False" />
                                        <ItemStyle BackColor="White" />
                                        <Columns>
                                            <asp:BoundColumn DataField="CLAVE" HeaderText="CODIGO CLAVE">
                                                <HeaderStyle BackColor="#006699" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="True" ForeColor="White" Width="20%" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="DESCRIPCION" HeaderText="DESCRIPCION">
                                                <HeaderStyle BackColor="#006699" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="True" ForeColor="White" Width="50%" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Left" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="CANTIDAD" HeaderText="CANTIDAD" Visible="False">
                                                <HeaderStyle BackColor="#006699" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="True" ForeColor="White" Width="0%" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" />
                                            </asp:BoundColumn>
                                            <asp:TemplateColumn HeaderText="CANTIDAD">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lb_cantidad" CommandName="EXCEL" runat="server" ForeColor="Blue"></asp:LinkButton>
                                                    <asp:HyperLink ID="hiper_link_inh" runat="server">[hiper_link_inh]</asp:HyperLink>
                                                    <asp:Table ID="tbl_servicios_inh" runat="server" ForeColor="Blue">
                                                    </asp:Table>
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="#006699" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="True" ForeColor="White" Width="30%" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" />
                                            </asp:TemplateColumn>
                                        </Columns>
                                        <HeaderStyle BackColor="Control" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" ForeColor="Black" HorizontalAlign="Center" />
                                    </asp:DataGrid></td>
                                    
                            </tr>
                            
                            <tr>
                                <td>
                                    <table  cellpadding="3" style="width: 800px" >
                                        <tr>
                                            <td style="width: 20%"> </td>
                                            <td style="width: 50%; text-align: center">
                                                </td>
                                            <td style="width: 30%; text-align: center">
                                                <asp:TextBox ID="txt_cant_inhibidas" runat="server" CssClass="TextBox" ReadOnly="True" Width="80px" Visible="False"></asp:TextBox></td>
                                        </tr>
                                    </table>
                                    </td>
                            </tr>
                            
                            <tr>
                                <td align="left" style="height: 97px">
                                    <table border="0" cellpadding="0" cellspacing="0" style="width: 312px">
                                        <tr>
                                            <td style="width: 203px; height: 21px">
                                            </td>
                                            <td style="width: 201px; height: 21px; text-align: left">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 203px; height: 21px">
                                                <h2 style="text-align: left">
                                                    ENTREGADOS</h2>
                                            </td>
                                            <td style="width: 201px; height: 21px; text-align: left">
                                                :<asp:TextBox ID="txt_total" runat="server" CssClass="TextBox" ReadOnly="True" Width="50px"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 203px; height: 21px">
                                            </td>
                                            <td style="width: 201px; height: 21px; text-align: left">
                                                <asp:TextBox ID="txt_totalMenosInh" runat="server" CssClass="TextBox" ReadOnly="True" Width="50px" Visible="False"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 203px">
                                                <h2 style="text-align: left">
                                                    TOTAL EFECTIVAS</h2>
                                            </td>
                                            <td style="width: 201px; height: 21px; text-align: left">
                                                :
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
                                                :
                                                <asp:TextBox ID="txt_porcentaje_imp" runat="server" CssClass="TextBox" ReadOnly="True"
                                                    Width="50px"></asp:TextBox>
                                                %</td>
                                        </tr>
                                        <tr>
                                            <td style="width: 203px; height: 19px;">
                                                <%--<h2 style="text-align: left">
                                                    EFECTIVIDAD
                                                </h2>--%>
                                            </td>
                                            <td style="width: 201px; text-align: left; height: 19px;">
                                                &nbsp;
                                                <asp:TextBox ID="txt_efectividad" runat="server" CssClass="TextBox" ReadOnly="True"
                                                    Width="50px" Visible="False"></asp:TextBox></td>
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
            height: 190px">
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
                <td align="center" colspan="2" style="height: 12px">
                    &nbsp;
                    &nbsp;<asp:Literal ID="Literal_EvaluacionFotografica" runat="server"></asp:Literal></td>
            </tr>
        </table>
    </form>
</body>
</html>
