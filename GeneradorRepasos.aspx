<%@ Page Language="VB" AutoEventWireup="false" CodeFile="GeneradorRepasos.aspx.vb" Inherits="GeneradorRepasos" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Generador de Repasos Reposiciones - Sistema CYR</title>
           <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/others.css"/>
      
<%--<style type="text/css">
body {
margin:0;
width: 100%;
height: 100%;
}
</style>

<script type="text/javascript" language="JavaScript1.2">
window.moveTo(0,0);
top.window.resizeTo(screen.availWidth,screen.availHeight);
</script>   --%>     


   <script type="text/javascript" language="javascript">    
    
   function openCalendar(obj)
      {
        var url = 'calendario.aspx?textbox=' + obj;
        window.open(url,'cal','width=260,height=210,left=410 410,top=330,resizable=0,scrollbars=0');
     }                
                  
  </script>

      
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table id="tbl_inicio" runat="server" align="center" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 732px">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True" CssClass="Label">Sesión</asp:Label>
                    <asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small" CssClass="Label"></asp:Label>
                    <asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True" CssClass="Label">Empresa</asp:Label>
                    <asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small" CssClass="Label"></asp:Label>
                    <asp:Label ID="lb_id_usuario" runat="server" CssClass="Label"></asp:Label>
                    <asp:Label ID="lb_rut_empresa" runat="server" CssClass="Label"></asp:Label></td>
            </tr>
            <tr>
                <td class="WebPartShadow">
                    <table id="Table5" runat="server" align="center" border="0" cellpadding="0" cellspacing="0">
                        <tr style="font-family: Trebuchet MS">
                            <td id="Td1" runat="server" class="WebPartShadow">
                                <table align="center" border="0" cellpadding="0">
                                    <tr id="Tr1" runat="server">
                                        <td align="left" class="WebPartTitle_ext" colspan="5" nowrap="nowrap">
                            Generador de Repasos Reposiciones</td>
                                    </tr>
                                    <tr id="Tr2" runat="server">
                                        <td align="left" colspan="5" nowrap="nowrap">
                                            <h2>
                                                Seleccione Rango de fechas y luego oprima "BUSCAR"</h2>
                                        </td>
                                    </tr>
                                    <tr id="Tr3" runat="server">
                                        <td nowrap="nowrap" style="text-align:right; width:20%;">
                                                <h2>Zona:&nbsp;
                                                </h2>
                                        </td>
                                        <td align="left" nowrap="nowrap" style="text-align: left; width:30%;">
                                            <strong>
                                            <asp:DropDownList ID="Combozonas" runat="server" AutoPostBack="True" CssClass="ComboBox2">
                                            </asp:DropDownList></strong>
                                       </td>
                                        <td nowrap="nowrap" style="text-align: right; width:15%;">
                                            <h2>Desde:<strong><span style="font-size: 8.3pt; color: #000000; font-family: Trebuchet MS">&nbsp;
                                                </span></strong>
                                            </h2>
                                        </td>
                                        <td align="left" nowrap="nowrap" style="text-align: left; color: #000000; font-family: Trebuchet MS; width:25%;">
                                                                <asp:TextBox ID="txtDate1" runat="server" CssClass="TextBox2" ReadOnly="false"></asp:TextBox><img
                                                                    id="Img2" runat="server" alt="calendario2" onclick="openCalendar('txtDate1');"
                                                                    src="fotos/calendario.gif" /><asp:RequiredFieldValidator ID="validar_inf_fecha_desde"
                                                                        runat="server" ControlToValidate="txtDate1" CssClass="ErrorMessage" ErrorMessage="*"
                                                                        Font-Bold="True" Height="8px" ValidationGroup="fecha">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                                                            ID="validar_fecha_desde" runat="server" BackColor="Transparent" ControlToValidate="txtDate1"
                                                                            CssClass="ErrorMessage" ErrorMessage="RegularExpressionValidator" Font-Bold="True"
                                                                            ValidationExpression="^[0-9]{2}-[0-9]{2}-[0-9]{4}$" ValidationGroup="fecha" Font-Names="Arial" Font-Size="X-Small" Display="Dynamic">Fecha errónea!</asp:RegularExpressionValidator>
                                        </td>
                                        <td align="left" nowrap="nowrap" style="text-align: left; color: #000000; font-family: Trebuchet MS; width:10%;">
                                            <strong></strong>
                                        </td>
                                    </tr>
                                    <tr runat="server" style="color: #000000; font-family: Trebuchet MS">
                                        <td align="right" nowrap="nowrap">
                                            <h2>Localidad:&nbsp;
                                            </h2>
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            <asp:DropDownList ID="combo_localidades" runat="server" AutoPostBack="True" CssClass="ComboBox2">
                                            </asp:DropDownList></td>
                                        <td nowrap="nowrap" style="text-align: right;">
                                            Hasta:&nbsp;
                                        </td>
                                        <td nowrap="nowrap" style="text-align: left;">
                                                            <asp:TextBox ID="txtDate2" runat="server" CssClass="TextBox2" ReadOnly="false"></asp:TextBox><img
                                                                id="Img4" runat="server" alt="Calendario2" onclick="openCalendar('txtDate2');"
                                                                src="fotos/calendario.gif" /><asp:RequiredFieldValidator ID="validar_inf_fecha_hasta"
                                                                    runat="server" ControlToValidate="txtDate2" CssClass="ErrorMessage" ErrorMessage="*"
                                                                    Font-Bold="True" ValidationGroup="fecha">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                                                        ID="validar_fecha_hasta" runat="server" BackColor="Transparent" ControlToValidate="txtDate2"
                                                                        CssClass="ErrorMessage" ErrorMessage="RegularExpressionValidator" Font-Bold="True"
                                                                        ValidationExpression="^[0-9]{2}-[0-9]{2}-[0-9]{4}$" ValidationGroup="fecha" Font-Names="Arial" Font-Size="X-Small" Display="Dynamic">Fecha errónea!</asp:RegularExpressionValidator></td>
                                        <td align="left" nowrap="nowrap">
                                                                &nbsp;</td>
                                    </tr>
                                    <tr runat="server" style="color: #000000; font-family: Trebuchet MS">
                                        <td align="right" nowrap="nowrap">
                                            <h2>Operador:&nbsp;</h2>
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            <asp:DropDownList ID="combo_lectores" runat="server" AutoPostBack="True" CssClass="ComboBox2">
                                            </asp:DropDownList></td>
                                        <td nowrap="nowrap" style="text-align: right">                                            
                                            <h2>
                                                Nro Cliente:&nbsp;</h2>
                                        </td>
                                        <td nowrap="nowrap" style="text-align: left">
                                            <asp:TextBox ID="txt_id_servicio" runat="server" CssClass="TextBox2" MaxLength="10"
                                                ReadOnly="false" Width="100px"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="ER_id_servicio" runat="server" ControlToValidate="txt_id_servicio"
                                                CssClass="ErrorMessage" Display="Dynamic" ErrorMessage="Sólo números!" Font-Bold="False"
                                                ValidationExpression="^([0-9]{1,50})$" Width="69px"></asp:RegularExpressionValidator></td>
                                        <td align="left" nowrap="nowrap">
                                        </td>
                                    </tr>
                                    <tr runat="server" style="color: #000000; font-family: Trebuchet MS">
                                        <td align="right" nowrap="nowrap">
                                            <h2>Clave Improcedente:&nbsp;</h2>
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            <asp:DropDownList ID="ComboClavesImprocedentes" runat="server" AutoPostBack="True"
                                                CssClass="ComboBox2">
                                            </asp:DropDownList></td>
                                        <td nowrap="nowrap" style="text-align: right">                                            
                                            <h2>
                                                Nro Orden:&nbsp;</h2>
                                        </td>
                                        <td nowrap="nowrap" style="text-align: left">
                                            <asp:TextBox ID="txt_num_orden" runat="server" CssClass="TextBox2" MaxLength="10"
                                                ReadOnly="false" Width="100px"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txt_num_orden"
                                                CssClass="ErrorMessage" Display="Dynamic" ErrorMessage="Sólo números!" Font-Bold="False"
                                                ValidationExpression="^([0-9]{1,50})$" Width="69px"></asp:RegularExpressionValidator></td>
                                        <td align="left" nowrap="nowrap">
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        <td align="right" nowrap="nowrap" style="height: 19px">
                                            
                                        </td>
                                        <td align="left" nowrap="nowrap" style="height: 19px">
                                            </td>
                                        <td align="left" nowrap="nowrap" style="text-align: right; height: 19px;">
                                        </td>
                                        <td nowrap="nowrap" style="text-align: right;">
                                            &nbsp;<asp:Button ID="btnBuscar" runat="server" CssClass="botonnew" Text="BUSCAR" ToolTip="Se actualizarán filtros Zona, Localidad y Operador." /></td>
                                        <td align="left" nowrap="nowrap" style="height: 19px">
                                                            </td>
                                    </tr>
                                    <tr runat="server">
                                        <td align="right" nowrap="nowrap">
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            <asp:Label ID="lb_cantidad_contratistas" runat="server"></asp:Label></td>
                                        <td align="left" nowrap="nowrap" style="text-align: right;">
                                            <asp:Label ID="lb_codigos_contratistas" runat="server"></asp:Label></td>
                                        <td align="left" nowrap="nowrap" style="text-align: right; width: 242px;">
                                            <asp:Label ID="lbl_id_perfil" runat="server"></asp:Label></td>
                                        <td align="left" nowrap="nowrap" style="text-align: left">
                                                            </td>
                                    </tr>
                                    <tr runat="server">
                                        <td align="left" colspan="4" nowrap="nowrap">
                                            <asp:Label ID="lb_error_filtro" runat="server" Font-Names="Arial Unicode MS" Font-Size="Small"
                                                ForeColor="Red"></asp:Label></td>
                                        <td align="left" nowrap="nowrap" style="text-align: left">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table align="center" border="0" cellpadding="0" cellspacing="0">
            <tr style="font-size: 12pt; font-family: Times New Roman">
                <td>
                    <div class="WebPartShadow">
                        <table align="center" border="0" cellspacing="0" id="TABLE1">
                            <tr>
                                <td align="left" class="WebPartTitle" colspan="2" nowrap="nowrap" style="height: 17px">
                            Resultados</td>
                            </tr>
                            <tr style="color: #000000">
                                <td colspan="2">
                                    &nbsp;<asp:Label ID="lb_cont_registros" runat="server" Text="0 coincidencia(s) encontrada(s)" CssClass="Label"></asp:Label>
                                    <asp:DataGrid ID="GrillaGeneraRepasos" runat="server" AllowSorting="True"
                                        AutoGenerateColumns="False" BorderWidth="0px" CellPadding="1" CellSpacing="1"
                                        CssClass="GridAlternativeItems" GridLines="Horizontal" Height="1px" PageSize="6"
                                        Width="852px">
                                        <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="True" ForeColor="White" HorizontalAlign="Center" Wrap="False" />
                                        <Columns>
                                            <asp:BoundColumn DataField="NOM_LOCALIDAD" HeaderText="Localidad"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="NUMERO_ORDEN" HeaderText="Nro Orden">
                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" Wrap="False" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="ID_SERVICIO" FooterText="sfgdgf" HeaderText="Nro Cliente">
                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" Wrap="False" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="DESCRIPCION_IMPROCEDENCIA" HeaderText="Clave Improcedente">
                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" Wrap="False" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn HeaderText="Fecha Generaci&#243;n" DataField="FECHA_GENERACION">
                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" Wrap="False" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn HeaderText="D&#237;as Cierre" DataField="DIAS_CIERRE">
                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" Wrap="False" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="DIAS_COMPLETADOS" HeaderText="D&#237;as Completados">
                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" Wrap="False" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="DIAS_RESTANTES" HeaderText="D&#237;as Restantes">
                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" Wrap="False" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:BoundColumn>
                                            <asp:TemplateColumn HeaderText="Repasar">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="check_repaso" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                        </Columns>
                                        <EditItemStyle BackColor="Honeydew" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                        <PagerStyle BackColor="Control" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Mode="NumericPages"
                                            NextPageText="Siguientes" PrevPageText="Anteriores" Wrap="False" />
                                        <AlternatingItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                        <ItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
                                        <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <SelectedItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:DataGrid>
                                    <asp:Image ID="img_ok" runat="server" ImageUrl="fotos/ok.bmp" /><asp:Label ID="lb_mensaje"
                                        runat="server" Font-Names="Arial Unicode MS" ForeColor="#0000C0" CssClass="Label" Font-Size="Small" Height="18px" Width="697px"></asp:Label>
                                    <asp:Label ID="lb_error" runat="server" CssClass="Label" Font-Names="Arial Unicode MS"
                                        Font-Size="Small" ForeColor="Red" Height="18px"></asp:Label></td>
                            </tr>
                            <tr style="color: #000000">
                                <td colspan="2">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <table>
                                        <tr>
                                            <td style="text-align: right">
                                             <h2>Total Improcedentes:</h2></td>
                                            <td>
                                        <asp:TextBox ID="txt_total_improcedentes" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox></td>
                                            <td>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right">
                                                <h2>
                                                    Total Factibles de Repasar:</h2></td>
                                            <td>
                                                <asp:TextBox ID="txt_total_factibles" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox></td>
                                            <td>
                                                </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right">
                                                <h2>
                                                    Total Días Cierre Completados:</h2></td>
                                            <td>
                                                <asp:TextBox ID="txt_total_cerrados" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox></td>
                                            <td>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="2">
                                    </td>
                            </tr>
                            <tr>
                                <td  colspan="2" align="right">
                                    <asp:Button ID="Button2" runat="server" CssClass="botonnew" Text="Button2" Visible="False" />
                                    <asp:Button ID="Button1" runat="server" CssClass="botonnew" Text="Button" Visible="False" />
                                    <asp:Button ID="btnGeneraRepaso" runat="server" Text="Generar Repaso" CssClass="botonnew" />
                    <asp:Button ID="btnVolver" runat="server" CssClass="botonnew" Text="<< Volver" />
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
