<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RuteroReposiciones.aspx.vb" Inherits="RuteroReposiciones" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Rutero de Reposiciones</title>
     <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/others.css"/> 
    <link type="text/css" rel="stylesheet" href="estilos/style.css"/> 
    <script type="text/javascript" language="javascript">    
function openCalendar(obj)
      {
        var url = 'calendario.aspx?textbox=' + obj;
        window.open(url,'cal','width=260,height=210,left=280 70,top=80,resizable=0,scrollbars=0');
      } 
         
function imprimir()
      {
       window.print();
      }      
</script>
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
                                    Rutero de Reposiciones</div>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" colspan="2">
                                <table align="center" cellpadding="0" style="width: 784px">
                                    <tr id="Tr5" runat="server">
                                        <td align="left" colspan="3" nowrap="nowrap" style="width: 100%; height: 16px">
                                            <h2>
                                                Seleccione información y luego oprima "Actualizar"</h2>
                                        </td>
                                    </tr>
                                    <tr id="Tr12" runat="server">
                                        <td align="left" nowrap="nowrap" style="width: 30%; height: 21px; text-align: right">
                                            <h2>
                                                Fecha Desde:&nbsp;</h2>
                                        </td>
                                        <td align="left" nowrap="nowrap" style="width: 50%; height: 21px">
                                            <asp:TextBox ID="txtDate1" runat="server" CssClass="TextBox2" ReadOnly="false"></asp:TextBox><img
                                                id="calendario_inv" runat="server" onclick="openCalendar('txtDate1');" src="fotos/calendario.gif" /><asp:RequiredFieldValidator
                                                    ID="validar_inf_fecha_desde" runat="server" ControlToValidate="txtDate1" CssClass="ErrorMessage"
                                                    ErrorMessage="*" Font-Bold="True" Height="8px" ValidationGroup="fecha" Width="8px">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                                        ID="validar_fecha_desde" runat="server" BackColor="Transparent" ControlToValidate="txtDate1"
                                                        CssClass="ErrorMessage" ErrorMessage="RegularExpressionValidator" Font-Bold="False"
                                                        ValidationExpression="^[0-9]{2}-[0-9]{2}-[0-9]{4}$" ValidationGroup="fecha">Fecha errónea!</asp:RegularExpressionValidator></td>
                                        <td align="left" nowrap="nowrap" style="width: 20%; height: 21px; text-align: right">
                                            <asp:Label ID="lbl_id_perfil" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="Tr2" runat="server">
                                        <td align="left" nowrap="nowrap" style="width: 30%; height: 21px; text-align: right">
                                            <h2>
                                                Fecha Hasta:&nbsp;</h2>
                                        </td>
                                        <td align="left" nowrap="nowrap" style="width: 50%; height: 21px">
                                            <asp:TextBox ID="txtDate2" runat="server" CssClass="TextBox2" ReadOnly="false"></asp:TextBox><img
                                                id="calendario_inv2" runat="server" onclick="openCalendar('txtDate2');" src="fotos/calendario.gif" /><asp:RequiredFieldValidator
                                                    ID="validar_inf_fecha_hasta" runat="server" ControlToValidate="txtDate2" CssClass="ErrorMessage"
                                                    ErrorMessage="*" Font-Bold="True" ValidationGroup="fecha" Width="1px">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator ID="validar_fecha_hasta" runat="server" BackColor="Transparent"
                                                ControlToValidate="txtDate2" CssClass="ErrorMessage" ErrorMessage="RegularExpressionValidator"
                                                Font-Bold="False" ValidationExpression="^[0-9]{2}-[0-9]{2}-[0-9]{4}$" ValidationGroup="fecha">Fecha errónea!</asp:RegularExpressionValidator></td>
                                        <td align="left" nowrap="nowrap" style="width: 20%; height: 21px; text-align: right">
                                            <asp:Label ID="lb_cantidad_contratistas" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td align="left" nowrap="nowrap" style="height: 15px; text-align: right">
                                            <h2 style="text-align: right">
                                                Localidad:&nbsp;
                                            </h2>
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            <asp:DropDownList ID="combo_localidades" runat="server" AutoPostBack="True" CssClass="ComboBox2"
                                                Width="204px">
                                            </asp:DropDownList></td>
                                        <td align="left" nowrap="nowrap">
                                            <h2 style="text-align: right">
                                                <asp:Label ID="lb_codigos_contratistas" runat="server"></asp:Label>&nbsp;</h2>
                                        </td>
                                    </tr>
                                    <tr id="Tr14" runat="server">
                                        <td align="left" nowrap="nowrap">
                                            <h2 style="text-align: right">
                                                Contratista:&nbsp;</h2>
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            <asp:DropDownList ID="combo_contratistas" runat="server" AutoPostBack="True" CssClass="ComboBox2"
                                                Width="204px">
                                            </asp:DropDownList></td>
                                        <td align="left" nowrap="nowrap">
                                            <h2 style="text-align: left">
                                                &nbsp;</h2>
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        <td align="right" nowrap="nowrap">
                                            <h2>Cortador:&nbsp;
                                            </h2></td>
                                        <td align="left" nowrap="nowrap">
                                            <asp:DropDownList ID="combo_cortadores" runat="server" AutoPostBack="True" CssClass="ComboBox2"
                                                Width="204px">
                                            </asp:DropDownList></td>
                                        <td align="left" nowrap="nowrap">
                                                <asp:Button ID="btnBuscar" runat="server" CssClass="botonnew" Text="BUSCAR" /></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <asp:Label ID="lb_error" runat="server" CssClass="Label" Font-Names="Arial Unicode MS" ForeColor="Red" Font-Size="Small"></asp:Label></td>
            </tr>
        </table>
        <table align="center" border="0" cellpadding="0" cellspacing="0">
            <tr style="font-size: 12pt; font-family: Times New Roman">
                <td>
                    <div class="WebPartShadow">
                        <table id="TABLE1" align="center" border="0" cellspacing="0" style="width: 855px">
                            <tr>
                                <td align="left" class="WebPartTitle" colspan="2" nowrap="nowrap" style="height: 17px; width: 162px;">
                                    Resultados</td>
                            </tr>
                            <tr style="color: #000000">
                                <td colspan="2" style="width: 162px">
                                    </td>
                                    
                                    <table id="tbl_datagrid" runat="server">                                                                        
                                    <tr>
                                        <td align="left">
                                            <table id="tbl_pdf" runat="server" border="0" style="width: 851px">
                                            <tr>
                                                <td align="center" colspan="4" style="width: 100%">
                                                    <asp:Label ID="lb_titulopdf" runat="server" Font-Bold="True" Font-Names="Arial Unicode MS"
                                                        Font-Size="Small" Font-Underline="True" Text="Informe de Reposiciones por Localidad"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 15%">
                                                    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Arial Unicode MS"
                                                        Font-Size="X-Small" Text="NOMBRE OPERADOR:"></asp:Label>
                                                </td>
                                                <td style="width: 35%">
                                                    <asp:Label ID="lb_nom_operadorPDF" runat="server" Font-Names="Arial Unicode MS" Font-Size="X-Small"></asp:Label></td>
                                                <td align="right" style="width: 15%">
                                                    <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Names="Arial Unicode MS"
                                                        Font-Size="X-Small" Text="FECHA GESTION:"></asp:Label></td>
                                                <td style="width: 35%">
                                                    <asp:Label ID="lb_fecha_gestionPDF" runat="server" Font-Names="Arial Unicode MS"
                                                        Font-Size="X-Small"></asp:Label></td>
                                            </tr>                                  
                                            </table>
                                    <asp:Label ID="lb_coincidencias" runat="server" CssClass="Label" Text="0 coincidencia(s) encontrada(s)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                    <td>
                                    <asp:DataGrid
                                        ID="GrillaRuteroRepo" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                        BorderWidth="1px" CellPadding="1" CellSpacing="1" CssClass="GridAlternativeItems"
                                        GridLines="Horizontal" Height="1px" PageSize="6" Width="852px" Font-Size="XX-Small">
                                        <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <EditItemStyle BackColor="Honeydew" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                        <SelectedItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <PagerStyle BackColor="Control" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Mode="NumericPages"
                                            NextPageText="Siguientes" PrevPageText="Anteriores" Wrap="False" />
                                        <AlternatingItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                        <ItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
                                        <Columns>
                                            <asp:BoundColumn DataField="correlativo" HeaderText="N&#176;">
                                                <HeaderStyle Width="2%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="NUMERO_ORDEN" HeaderText="N&#186; ORDEN">
                                                <HeaderStyle Width="5%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="ID_SERVICIO" HeaderText="ID SERVICIO">
                                                <HeaderStyle Width="5%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="NOMBRE" HeaderText="NOMBRE CLIENTE">
                                                <HeaderStyle Width="10%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="DIRECCION" HeaderText="DIRECCION CLIENTE">
                                                <HeaderStyle Width="10%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="TIPO_SERVICIO" HeaderText="Tipo Servicio" Visible="False"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="LOCALIDAD" HeaderText="LOCALIDAD">
                                                <HeaderStyle Width="6%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="COSTO_VISITA" HeaderText="Costo visita" Visible="False"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="COD_SERVICIO" HeaderText="ORDEN RUTA">
                                                <HeaderStyle Width="8%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="DEUDA" HeaderText="Deuda" Visible="False"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="DEUDA_TOTAL" HeaderText="Deuda Total" Visible="False"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="MEDIDOR" HeaderText="N&#176; MEDIDOR">
                                                <HeaderStyle Width="6%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="DATOS_ORDEN_REPOSICION" HeaderText="DATOS ORDEN REPOSICION">
                                                <HeaderStyle Width="12%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="NIVEL_SOLICITADO" HeaderText="Nivel Solicitado" Visible="False"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="FECHA_GENERACION" HeaderText="Fecha Generaci&#243;n" Visible="False"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="HORA_GENERACION" HeaderText="Hora Generaci&#243;n" Visible="False"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="CONTRATISTA" HeaderText="Contratista" Visible="False"></asp:BoundColumn>
                                            <asp:TemplateColumn HeaderText="Resultado Repo" Visible="False"></asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="FECHA REPO">
                                                <HeaderStyle Width="4%" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="HORA REPO">
                                                <HeaderStyle Width="4%" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Tipo Repo" Visible="False"></asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="CAUSA IMPROCEDENCIA">
                                                <HeaderStyle Width="12%" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="LECTURA">
                                                <HeaderStyle Width="4%" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="OBSERVACION">
                                                <HeaderStyle Width="15%" />
                                            </asp:TemplateColumn>
                                        </Columns>
                                        <HeaderStyle BackColor="#669999" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="True" ForeColor="Black" HorizontalAlign="Center"
                                            Wrap="False" />
                                    </asp:DataGrid>
                                    </td>
                                    </tr>
                                    </table>
                    </div>
                </td>
            </tr>
                            <tr>
                                <td align="right" colspan="2" style="height: 19px">
                                    <asp:Button ID="btnPDF" runat="server" CssClass="botonnew" Text="Generar PDF" />
                                    <asp:Button ID="btnGeneraExcel" runat="server" CssClass="botonnew" Text="Generar Excel" />
                                    <asp:Button ID="btnVolver" runat="server" CssClass="botonnew" Text="<< Volver" />
                                </td>
                            </tr>
        </table>
    
    </div>
    </form>
                          
</body>
</html>
