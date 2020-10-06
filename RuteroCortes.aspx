<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RuteroCortes.aspx.vb" Inherits="RuteroCortes" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Rutero de Cortes</title>
    <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/others.css"/> 
    <link type="text/css" rel="stylesheet" href="estilos/style.css"/> 
    
    <script language="Javascript" type="text/javascript" src="../FusionCharts/FusionCharts.js"></script>
    
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table id="tbl_inicio" runat="server" align="center" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <asp:Label ID="Lb_user" runat="server" CssClass="Label" Font-Bold="True" Font-Names="Arial"
                        Font-Size="X-Small" Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user"
                            runat="server" CssClass="Label" Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label
                                ID="lb_empresa" runat="server" CssClass="Label" Font-Bold="True" Font-Names="Arial"
                                Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label ID="lb_session_empresa"
                                    runat="server" CssClass="Label" Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label
                                        ID="lb_rut_empresa" runat="server" CssClass="Label" Font-Names="arial" Font-Size="X-Small"></asp:Label><asp:Label
                                            ID="lb_id_usuario" runat="server" CssClass="Label"></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <table id="TABLE2" align="center" border="0" cellspacing="0" class="WebPartShadow"
                        onclick="return TABLE2_onclick()">
                        <tr id="Tr1" runat="server">
                            <td align="left" colspan="2" nowrap="nowrap">
                                <div id="titulo_mod" runat="server" class="WebPartTitle_ext">
                                    Rutero de Cortes</div>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" colspan="2">
                                <table align="center" cellpadding="0" style="width: 784px">
                                    <tr id="Tr5" runat="server">
                                        <td align="left" colspan="3" nowrap="nowrap" style="height: 16px; width:100%;">
                                            <h2>
                                                Seleccione información y luego oprima "Actualizar"</h2>
                                        </td>
                                    </tr>
                                    <tr id="Tr12" runat="server">
                                        <td align="left" nowrap="nowrap" style="width: 30%; height: 18px; text-align: right">
                                            <h2>
                                                Proceso:&nbsp;</h2>
                                        </td>
                                        <td align="left" nowrap="nowrap" style="height: 18px; width: 50%;">
                                            &nbsp;<asp:DropDownList ID="combo_procesos" runat="server" AutoPostBack="True"
                                                CssClass="ComboBox2" Width="200px">
                                            </asp:DropDownList></td>
                                        <td align="left" nowrap="nowrap" style="height: 18px; text-align: right; width: 20%;">
                                            <h2>
                                                
                                            </h2>
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        <td align="left" nowrap="nowrap" style="width: 30%; height: 18px; text-align: right">
                                            <h2>Zona:&nbsp;
                                            </h2></td>
                                        <td align="left" nowrap="nowrap" style="width: 50%; height: 18px">
                                            <asp:DropDownList ID="combo_zonas" runat="server" AutoPostBack="True"
                                                CssClass="ComboBox2" Width="204px">
                                        </asp:DropDownList>
                                            <asp:Label ID="lb_cantidad_contratistas" runat="server"></asp:Label></td>
                                        <td align="left" nowrap="nowrap" style="width: 20%; height: 18px; text-align: right">
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        <td align="left" nowrap="nowrap" style="width: 30%; height: 18px; text-align: right">
                                                <h2>Localidad:&nbsp;
                                                </h2>
                                        </td>
                                        <td align="left" nowrap="nowrap" style="width: 50%; height: 18px">
                                            <asp:DropDownList ID="combo_localidades" runat="server" AutoPostBack="True"
                                                CssClass="ComboBox2" Width="204px">
                                        </asp:DropDownList>
                                            <asp:Label ID="lb_codigos_contratistas" runat="server"></asp:Label></td>
                                        <td align="left" nowrap="nowrap" style="width: 20%; height: 18px; text-align: right">
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        <td align="left" nowrap="nowrap" style="width: 30%; height: 21px; text-align: right">
                                        <h2>
                                            Contratista:&nbsp;</h2> 
                                        </td>
                                        <td align="left" nowrap="nowrap" style="width: 50%; height: 21px"><asp:DropDownList ID="combo_contratistas" runat="server" AutoPostBack="True"
                                                CssClass="ComboBox2" Width="204px">
                                        </asp:DropDownList></td>
                                        <td align="left" nowrap="nowrap" style="width: 20%; height: 21px; text-align: right">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" nowrap="nowrap" style="height: 19px; text-align: right">
                                            <h2 style="text-align: right">
                                                Cortador:&nbsp;
                                            </h2>
                                        </td>
                                        <td align="left" nowrap="nowrap" style="height: 19px">
                                            <asp:DropDownList ID="combo_cortadores" runat="server" AutoPostBack="True"
                                                CssClass="ComboBox2" Width="204px">
                                        </asp:DropDownList></td>
                                        <td align="left" nowrap="nowrap" style="height: 19px">
                                            <h2 style="text-align: right">
                                                &nbsp;</h2>
                                        </td>
                                    </tr>
                                    <tr id="Tr14" runat="server">
                                        <td align="left" nowrap="nowrap">
                                            <h2 style="text-align: right">
                                                &nbsp;</h2>
                                        </td>
                                        <td align="left" nowrap="nowrap"></td>
                                        <td align="left" nowrap="nowrap">
                                            <h2 style="text-align: left">
                                                <asp:LinkButton ID="btnFiltra" runat="server" CssClass="Label" Font-Bold="True" Font-Names="Arial"
                                                    Font-Size="Small" ForeColor="#0000C0" ValidationGroup="fecha">FILTRAR</asp:LinkButton>&nbsp;</h2>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <asp:Label ID="lb_error" runat="server" CssClass="Label" Font-Names="Arial" ForeColor="Red"></asp:Label></td>
            </tr>
        </table>
    
    </div>
        <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 936px">
            <tr style="font-size: 12pt; font-family: Times New Roman">
                <td>
                    <div class="WebPartShadow">
                        <table id="TABLE1" align="center" border="0" cellspacing="0">
                            <tr>
                                <td align="left" class="WebPartTitle" colspan="2" nowrap="nowrap" style="height: 17px">
                                    Resultados</td>
                            </tr>
                            <tr style="color: #000000">
                                <td colspan="2">
                                    &nbsp;<asp:Label ID="lb_coincidencias" runat="server" CssClass="Label" Text="0 coincidencia(s) encontrada(s)"></asp:Label>
                                    
                                    <table id="tbl_datagrid" runat="server">                                                                        
                                    <tr>
                                    <td>
                                        <H2>
                                            <table border="0" style="width: 990px" runat="server" id="tbl_pdf">
                                                <tr>
                                                    <td align="center" colspan="4" style="width:100%;">
                                                        <asp:Label ID="lb_titulopdf" runat="server" Font-Bold="True" Font-Names="Arial Unicode MS"
                                                            Font-Size="Small" Text="Informe de Orden de Corte por Localidad" Font-Underline="True"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td style="width:15%;" align="right">
                                                        <asp:Label ID="Label1" runat="server" Text="NOMBRE OPERADOR:" Font-Bold="True" Font-Names="Arial Unicode MS" Font-Size="X-Small"></asp:Label>
                                                    </td>
                                                    <td style="width:35%;">
                                                        <asp:Label ID="lb_nom_operadorPDF" runat="server" Font-Names="Arial Unicode MS" Font-Size="X-Small"></asp:Label></td>
                                                    <td style="width:15%;" align="right">
                                                        <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Names="Arial Unicode MS"
                                                            Font-Size="X-Small" Text="FECHA GESTION:"></asp:Label></td>
                                                    <td style="width:35%;">
                                                        <asp:Label ID="lb_fecha_gestionPDF" runat="server" Font-Names="Arial Unicode MS"
                                                            Font-Size="X-Small"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                                    <td>
                                                    </td>
                                                    <td>
                                                    </td>
                                                    <td>
                                                    </td>
                                                </tr>
                                            </table>
                                        </H2></td>
                                    </tr>
                                    
                                    <tr>
                                    <td>
                                       <asp:DataGrid ID="GrillaRuteroCortes" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                        BorderWidth="1px" CellPadding="4" CssClass="GridAlternativeItems" Height="1px" PageSize="6" Width="991px" BackColor="White" BorderColor="Silver" Font-Size="XX-Small" BorderStyle="None">
                                        <FooterStyle Wrap="False" BackColor="#99CCCC" ForeColor="#003399" />
                                        <EditItemStyle Wrap="False" />
                                        <SelectedItemStyle Wrap="False" BackColor="#009999" ForeColor="Black" Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                        <PagerStyle BackColor="#99CCCC" HorizontalAlign="Left"
                                            NextPageText="Siguientes" PrevPageText="Anteriores" Wrap="False" ForeColor="#003399" Mode="NumericPages" />
                                        <AlternatingItemStyle Wrap="False" />
                                        <ItemStyle HorizontalAlign="Center" Wrap="False" BackColor="White" ForeColor="Black" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                        <Columns>
                                            <asp:BoundColumn DataField="correlativo" HeaderText="N&#176;">
                                                <HeaderStyle Width="2%" />
                                                <ItemStyle Width="2%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="NUMERO_ORDEN" HeaderText="N&#186; ORDEN">
                                                <HeaderStyle Width="5%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="ID_SERVICIO" HeaderText="ID SERVICIO">
                                                <HeaderStyle Width="5%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="NOMBRE" HeaderText="NOMBRE CLIENTE">
                                                <HeaderStyle Width="12%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="DIRECCION" HeaderText="DIRECCION CLIENTE">
                                                <HeaderStyle Width="12%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="LOCALIDAD" HeaderText="LOCALIDAD">
                                                <HeaderStyle Width="5%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="COSTO_VISITA" HeaderText="COSTO VISITA CORTE">
                                                <HeaderStyle Width="4%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="COD_SERVICIO" HeaderText="ORDEN RUTA">
                                                <HeaderStyle Width="6%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="DEUDA" HeaderText="DEUDA CORTE">
                                                <HeaderStyle Width="4%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="DEUDA_TOTAL" HeaderText="DEUDA TOTAL">
                                                <HeaderStyle Width="4%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="MEDIDOR" HeaderText="N&#176; MEDIDOR">
                                                <HeaderStyle Width="5%" />
                                            </asp:BoundColumn>
                                            <asp:TemplateColumn HeaderText="HORA CORTE">
                                                <HeaderStyle Width="5%" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="CAUSA IMPROCEDENCIA">
                                                <HeaderStyle Width="12%" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="LECTURA">
                                                <HeaderStyle Width="6%" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="OBSERVACION">
                                                <HeaderStyle Width="17%" />
                                                <ItemStyle Width="17%" />
                                            </asp:TemplateColumn>
                                        </Columns>
                                        <HeaderStyle BackColor="#669999" Font-Bold="True" Font-Underline="True" HorizontalAlign="Center"
                                            Wrap="False" ForeColor="Black" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" />
                                    </asp:DataGrid>
                                    </td>
                                    </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="text-align:right;">
                                    <asp:Button ID="btnPDF" runat="server" CssClass="botonnew" Text="Generar PDF" />                                    
                                    <asp:Button ID="btnGeneraExcel" runat="server" CssClass="botonnew" Text="Generar Excel" />
                                    <asp:Button ID="btnVolver" runat="server" CssClass="botonnew" Text="<< Volver" />
                                    </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
    </form>
   
  
    <asp:Literal ID="FCLiteral" runat="server"></asp:Literal>
        
        
    
</body>
</html>
