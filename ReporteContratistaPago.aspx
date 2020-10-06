<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ReporteContratistaPago.aspx.vb" Inherits="ReporteContratistaPago" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Reporte de Estado Pago Contratista</title>
    <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/others.css"/> 
      <link type="text/css" rel="stylesheet" href="estilos/style.css"/> 
      
      <link type="text/css" rel="stylesheet" href="estilos/loadingbox.css" />    
       
      <script src="js/jquery.js" type="text/javascript"></script>
      <script src="js/progress.js" type="text/javascript"></script>
            
         
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
    <img src="fotos/procesando3.gif" alt="" style="display:none;" /> 
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
                                            ID="lb_id_usuario" runat="server" CssClass="Label"></asp:Label>
                    <asp:Label ID="lbl_id_perfil" runat="server" CssClass="Label"></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <table id="TABLE2" align="center" border="0" cellspacing="0" class="WebPartShadow"
                        onclick="return TABLE2_onclick()">
                        <tr id="Tr1" runat="server">
                            <td align="left" colspan="2" nowrap="nowrap">
                                <div id="titulo_mod" runat="server" class="WebPartTitle_ext">
                                Reporte 
                                    Estado Pago Contratista</div>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" colspan="2">
                                <table align="center" cellpadding="0" style="width: 748px">
                                    <tr id="Tr5" runat="server">
                                        <td align="left" colspan="4" nowrap="nowrap">
                                            <h2>
                                    Seleccione información y luego oprima "BUSCAR"</h2>
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        <td align="right" nowrap="nowrap" style="height: 21px">
                                            <h2>
                                                &nbsp;</h2></td>
                                        <td align="left" colspan="2" nowrap="nowrap" style="height: 21px" valign="middle">
                                            <asp:RadioButtonList ID="TipoPago_Contratista" runat="server" onchange="$.showprogress()" RepeatDirection="Horizontal" Font-Names="Arial" Width="312px" AutoPostBack="True" Visible="False">
                                                <%--<asp:ListItem Value="1">REPOSICI&#211;N</asp:ListItem>--%>
                                                <asp:ListItem Value="0">CORTE Y REPOSICION</asp:ListItem>
                                            </asp:RadioButtonList></td>
                                        <td align="left" nowrap="nowrap" style="height: 21px">
                                        </td>
                                    </tr>
                                    <tr id="Tr12" runat="server">
                                        <td align="right" nowrap="nowrap" style="height: 21px">
                                            <h2 style="text-align: right">
                                                Contratista:&nbsp;</h2>
                                        </td>
                                        <td align="left" nowrap="nowrap" style="height: 21px"><asp:DropDownList onchange="$.showprogress()" ID="combo_contratistas" runat="server" AutoPostBack="True" CssClass="ComboBox2" Width="200px">
                                        </asp:DropDownList></td>
                                        <td nowrap="nowrap" style="text-align: right; height: 21px;">
                                            <h2>
                                    Desde:&nbsp;
                                            </h2>
                                        </td>
                                        <td align="left" nowrap="nowrap" style="height: 21px">
                                            <asp:TextBox ID="txtDate1" runat="server" CssClass="TextBox2" ReadOnly="false"></asp:TextBox>
                                            <img alt="" id="calendario_inv" runat="server" onclick="openCalendar('txtDate1');" src="fotos/calendario.gif" />
                                            <asp:RequiredFieldValidator ID="validar_inf_fecha_desde" runat="server" ControlToValidate="txtDate1"
                                                CssClass="ErrorMessage" ErrorMessage="*" Font-Bold="True" Height="8px" ValidationGroup="fecha" Width="8px">*</asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="validar_fecha_desde" runat="server" BackColor="Transparent"
                                                ControlToValidate="txtDate1" CssClass="ErrorMessage" ErrorMessage="RegularExpressionValidator"
                                                Font-Bold="False" ValidationExpression="^[0-9]{2}-[0-9]{2}-[0-9]{4}$" ValidationGroup="fecha" Width="56px">Fecha errónea!</asp:RegularExpressionValidator></td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap" style="height: 21px">
                                            <h2 style="text-align: right">
                                                Zona:&nbsp;
                                            </h2>
                                        </td>
                                        <td align="left" nowrap="nowrap" style="height: 21px"><asp:DropDownList onchange="$.showprogress()" ID="combo_zonas" runat="server" AutoPostBack="True" CssClass="ComboBox2" Width="200px">
                                        </asp:DropDownList></td>
                                        <td nowrap="nowrap" style="height: 21px;">
                                            <h2 style="text-align: right;">Hasta:&nbsp;
                                            </h2>
                                        </td>
                                        <td align="left" nowrap="nowrap" style="height: 21px">
                                            <asp:TextBox ID="txtDate2" runat="server" CssClass="TextBox2" ReadOnly="false"></asp:TextBox>
                                            <img alt="" id="calendario_inv2" runat="server" onclick="openCalendar('txtDate2');" src="fotos/calendario.gif" />
                                            <asp:RequiredFieldValidator ID="validar_inf_fecha_hasta" runat="server" ControlToValidate="txtDate2"
                                                CssClass="ErrorMessage" ErrorMessage="*" Font-Bold="True" ValidationGroup="fecha" Width="1px">*</asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="validar_fecha_hasta" runat="server" BackColor="Transparent"
                                                ControlToValidate="txtDate2" CssClass="ErrorMessage" ErrorMessage="RegularExpressionValidator"
                                                Font-Bold="False" ValidationExpression="^[0-9]{2}-[0-9]{2}-[0-9]{4}$" ValidationGroup="fecha">Fecha errónea!</asp:RegularExpressionValidator></td>
                                    </tr>
                                    <tr id="Tr14" runat="server">
                                        <td align="right" nowrap="nowrap">
                                            <h2>
                                                Localidad:&nbsp;</h2>
                                        </td>
                                        <td align="left" nowrap="nowrap"><asp:DropDownList ID="combo_localidades" onchange="$.showprogress()" runat="server" AutoPostBack="True" CssClass="ComboBox2" Width="200px">
                                        </asp:DropDownList></td>
                                        <td align="left" nowrap="nowrap" style="width: 75px">
                                            <h2 style="text-align: right">
                                                &nbsp;</h2>
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        <td align="right" nowrap="nowrap">
                                            <asp:Label ID="lb_cantidad_contratistas" runat="server"></asp:Label></td>
                                        <td align="left" nowrap="nowrap">
                                            <asp:Label ID="lb_codigos_contratistas" runat="server"></asp:Label></td>
                                        <td align="left" nowrap="nowrap" style="width: 75px">
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            <asp:Button ID="btnBuscar" runat="server" CssClass="botonnew" Text="BUSCAR" OnClientClick="$.showprogress()" /></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <asp:Label ID="lb_error" runat="server" CssClass="Label" Font-Names="Arial"
                        ForeColor="Red"></asp:Label></td>
            </tr>
        </table>
        <table id="TABLE1" align="center" border="0" cellspacing="0" class="WebPartShadow">
            <tr>
                <td align="left" class="WebPartShadow" colspan="2" style="height: 1px">
                    <asp:Label ID="lb_cont_registros" runat="server" CssClass="Label"></asp:Label>
                    <div id="Div1" runat="server" class="WebPartTitle_ext">CORTES - REPOSICIONES - COMPROMISOS DE PAGO</div>
                    <br />
                    <asp:DataGrid ID="GrillaPagoContratista" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                        BorderStyle="Solid" CellPadding="1" CellSpacing="1" CssClass="GridAlternativeItems"
                        Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" GridLines="None" PageSize="30">
                        <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" Wrap="False" />
                        <EditItemStyle BackColor="#2461BF" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                        <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" ForeColor="#333333" Wrap="False" />
                        <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                            Mode="NumericPages" VerticalAlign="Middle" Wrap="False" />
                        <AlternatingItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                        <ItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
                        <Columns>
                            <asp:BoundColumn DataField="nombre_contratista" HeaderText="Nombre Contratista"></asp:BoundColumn>
                            <asp:BoundColumn DataField="region" HeaderText="Regi&#243;n">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="nombre_localidad" HeaderText="Localidad">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="cod_localidad" HeaderText="Cod Localidad">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="grupo" HeaderText="Proceso">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="libreta" HeaderText="Libreta">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="orden_ruta" HeaderText="Orden Ruta">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="ID_TIPO_ORDEN" HeaderText="ID_TIPO_ORDEN" Visible="False">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="TIPO_ORDEN" HeaderText="TIPO ORDEN">
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" ForeColor="White" />
                                <ItemStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" ForeColor="Blue" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="numero_orden" HeaderText="Numero Orden" Visible="False">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="id_servicio" HeaderText="Servicio">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="medidor" HeaderText="Medidor">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="fecha_generacion" HeaderText="Fecha Generaci&#243;n">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="HORA_EJECUCION" HeaderText="Hora Ejecuci&#243;n">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="FECHA_EJECUCION" HeaderText="Fecha Ejecuci&#243;n">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="CORTE_IMPROCEDENTE" HeaderText="Corte Improcedente">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="corte_real" HeaderText="Corte Real">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="EVENTO" HeaderText="EVENTO"></asp:BoundColumn>
                            <asp:BoundColumn DataField="nivel_corte_real" HeaderText="Nivel Corte Real"></asp:BoundColumn>
                            <asp:BoundColumn DataField="nivel_solicitado" HeaderText="Nivel Solicitado"></asp:BoundColumn>
                            <asp:BoundColumn DataField="monto_neto" HeaderText="Monto Neto"></asp:BoundColumn>
                            <asp:BoundColumn DataField="COD_CORTADOR" HeaderText="C&#243;digo Cortador"></asp:BoundColumn>
                            <asp:BoundColumn DataField="NOM_CORTADOR" HeaderText="Nombre Cortador" Visible="False">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="APELLIDO_CORTADOR" HeaderText="Apellido Cortador" Visible="False">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="observacion" HeaderText="Observacion"></asp:BoundColumn>
                            <asp:BoundColumn DataField="COD_CLAVEIMPROCEDENTEPDA" HeaderText="COD CLAVE IMP PDA">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="COD_CLAVE_CORTEEFECTIVO" HeaderText="Cod Clave Corte Efec">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="FECHA_ASIGNACION" HeaderText="Fecha Asignaci&#243;n">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="HORA_ASIGNACION" HeaderText="Hora Asignaci&#243;n">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="CLAVE_LECTURA" HeaderText="Clave Lectura">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="ATENDIDO" HeaderText="ATENDIDO" Visible="False"></asp:BoundColumn>
                            <asp:BoundColumn DataField="rut_contratista" HeaderText="rut_contratista"></asp:BoundColumn>
                            <asp:BoundColumn DataField="num_contrato" HeaderText="num_contrato"></asp:BoundColumn>
                            <asp:BoundColumn DataField="ID_TIPOPROCESO" HeaderText="id_tipoproceso" Visible="False"></asp:BoundColumn>
                        </Columns>
                        <HeaderStyle BackColor="#507CD1" BorderColor="Black" Font-Bold="True" Font-Italic="False"
                            Font-Overline="False" Font-Strikeout="False" Font-Underline="True" ForeColor="White"
                            HorizontalAlign="Center" Wrap="False" />
                    </asp:DataGrid>
                    
                      <br />
                      <br />
                    
                    
                    <br />
                    <asp:DataGrid ID="GrillaPagoContratistaCom" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                        BorderStyle="Solid" CellPadding="1" CellSpacing="1" CssClass="GridAlternativeItems"
                        Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" GridLines="None" PageSize="30" Visible="False">
                        <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" Wrap="False" />
                        <EditItemStyle BackColor="#2461BF" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                        <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" ForeColor="#333333" Wrap="False" />
                        <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                            Mode="NumericPages" VerticalAlign="Middle" Wrap="False" />
                        <AlternatingItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                        <ItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
                        <Columns>
                            <asp:BoundColumn DataField="nombre_contratista" HeaderText="Nombre Contratista"></asp:BoundColumn>
                            <asp:BoundColumn DataField="region" HeaderText="Regi&#243;n">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="nombre_localidad" HeaderText="Localidad">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="cod_localidad" HeaderText="Cod Localidad">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="grupo" HeaderText="Proceso">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="libreta" HeaderText="Libreta">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="orden_ruta" HeaderText="Orden Ruta">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="ID_TIPO_ORDEN" HeaderText="ID_TIPO_ORDEN" Visible="False">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="TIPO_ORDEN" HeaderText="TIPO ORDEN">
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" ForeColor="White" />
                                <ItemStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" ForeColor="Blue" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="numero_orden" HeaderText="Numero Orden" Visible="False">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="id_servicio" HeaderText="Servicio">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="medidor" HeaderText="Medidor">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="fecha_generacion" HeaderText="Fecha Generaci&#243;n">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="HORA_EJECUCION" HeaderText="Hora Ejecuci&#243;n">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="FECHA_EJECUCION" HeaderText="Fecha Ejecuci&#243;n">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="CORTE_IMPROCEDENTE" HeaderText="Corte Improcedente">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="corte_real" HeaderText="Corte Real">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="EVENTO" HeaderText="EVENTO"></asp:BoundColumn>
                            <asp:BoundColumn DataField="nivel_corte_real" HeaderText="Nivel Corte Real"></asp:BoundColumn>
                            <asp:BoundColumn DataField="nivel_solicitado" HeaderText="Nivel Solicitado"></asp:BoundColumn>
                            <asp:BoundColumn DataField="monto_neto" HeaderText="Monto Neto"></asp:BoundColumn>
                            <asp:BoundColumn DataField="COD_CORTADOR" HeaderText="C&#243;digo Cortador"></asp:BoundColumn>
                            <asp:BoundColumn DataField="NOM_CORTADOR" HeaderText="Nombre Cortador" Visible="False">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="APELLIDO_CORTADOR" HeaderText="Apellido Cortador" Visible="False">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="observacion" HeaderText="Observacion"></asp:BoundColumn>
                            <asp:BoundColumn DataField="COD_CLAVEIMPROCEDENTEPDA" HeaderText="COD CLAVE IMP PDA">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="COD_CLAVE_CORTEEFECTIVO" HeaderText="Cod Clave Corte Efec">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="FECHA_ASIGNACION" HeaderText="Fecha Asignaci&#243;n">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="HORA_ASIGNACION" HeaderText="Hora Asignaci&#243;n">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="CLAVE_LECTURA" HeaderText="Clave Lectura">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="ATENDIDO" HeaderText="ATENDIDO" Visible="False"></asp:BoundColumn>
                            <asp:BoundColumn DataField="rut_contratista" HeaderText="rut_contratista"></asp:BoundColumn>
                            <asp:BoundColumn DataField="num_contrato" HeaderText="num_contrato"></asp:BoundColumn>
                            <asp:BoundColumn DataField="ID_TIPOPROCESO" HeaderText="id_tipoproceso" Visible="False"></asp:BoundColumn>
                        </Columns>
                        <HeaderStyle BackColor="#507CD1" BorderColor="Black" Font-Bold="True" Font-Italic="False"
                            Font-Overline="False" Font-Strikeout="False" Font-Underline="True" ForeColor="White"
                            HorizontalAlign="Center" Wrap="False" />
                    </asp:DataGrid>
                    
                    
                    
                 
                    
                    
                    <asp:DataGrid ID="GrillaPagoContratista_Aux" runat="server" AutoGenerateColumns="False"
                        BorderStyle="Solid" CellPadding="1" CellSpacing="1" CssClass="GridAlternativeItems"
                        Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" GridLines="None" PageSize="30" Visible="False">
                        <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" Wrap="False" />
                        <EditItemStyle BackColor="#2461BF" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                        <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" ForeColor="#333333" Wrap="False" />
                        <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                            Mode="NumericPages" VerticalAlign="Middle" Wrap="False" />
                        <AlternatingItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                        <ItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
                        <Columns>
                            <asp:BoundColumn DataField="nombre_contratista" HeaderText="Nombre Contratista"></asp:BoundColumn>
                            <asp:BoundColumn DataField="region" HeaderText="Regi&#243;n">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="nombre_localidad" HeaderText="Localidad">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="cod_localidad" HeaderText="Cod Localidad">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="grupo" HeaderText="Proceso">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="libreta" HeaderText="Libreta">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="orden_ruta" HeaderText="Orden Ruta">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="ID_TIPO_ORDEN" HeaderText="ID_TIPO_ORDEN" Visible="False">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="TIPO_ORDEN" HeaderText="TIPO ORDEN">
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" ForeColor="White" />
                                <ItemStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" ForeColor="Blue" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="numero_orden" HeaderText="Numero Orden">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="id_servicio" HeaderText="Servicio">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="medidor" HeaderText="Medidor">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="fecha_generacion" HeaderText="Fecha Generaci&#243;n">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="HORA_EJECUCION" HeaderText="Hora Ejecuci&#243;n">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="FECHA_EJECUCION" HeaderText="Fecha Ejecuci&#243;n">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="CORTE_IMPROCEDENTE" HeaderText="Corte Improcedente">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="corte_real" HeaderText="Corte Real">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="EVENTO" HeaderText="EVENTO"></asp:BoundColumn>
                            <asp:BoundColumn DataField="nivel_corte_real" HeaderText="Nivel Corte Real"></asp:BoundColumn>
                            <asp:BoundColumn DataField="nivel_solicitado" HeaderText="Nivel Solicitado"></asp:BoundColumn>
                            <asp:BoundColumn DataField="monto_neto" HeaderText="Monto Neto"></asp:BoundColumn>
                            <asp:BoundColumn DataField="COD_CORTADOR" HeaderText="C&#243;digo Cortador"></asp:BoundColumn>
                            <asp:BoundColumn DataField="NOM_CORTADOR" HeaderText="Nombre Cortador" Visible="False">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="APELLIDO_CORTADOR" HeaderText="Apellido Cortador" Visible="False">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="observacion" HeaderText="Observacion"></asp:BoundColumn>
                            <asp:BoundColumn DataField="COD_CLAVEIMPROCEDENTEPDA" HeaderText="COD CLAVE IMP PDA">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="COD_CLAVE_CORTEEFECTIVO" HeaderText="Cod Clave Corte Efec">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="FECHA_ASIGNACION" HeaderText="Fecha Asignaci&#243;n">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="HORA_ASIGNACION" HeaderText="Hora Asignaci&#243;n">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="CLAVE_LECTURA" HeaderText="Clave Lectura">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="ATENDIDO" HeaderText="ATENDIDO" Visible="False"></asp:BoundColumn>
                            <asp:BoundColumn DataField="rut_contratista" HeaderText="rut_contratista"></asp:BoundColumn>
                            <asp:BoundColumn DataField="num_contrato" HeaderText="num_contrato"></asp:BoundColumn>
                            <asp:BoundColumn DataField="ID_TIPOPROCESO" HeaderText="id_tipoproceso"></asp:BoundColumn>
                        </Columns>
                        <HeaderStyle BackColor="#507CD1" BorderColor="Black" Font-Bold="True" Font-Italic="False"
                            Font-Overline="False" Font-Strikeout="False" Font-Underline="True" ForeColor="White"
                            HorizontalAlign="Center" Wrap="False" />
                    </asp:DataGrid><br />
                    
                    
                    <asp:DataGrid ID="GrillaPagoContratista_Aux_Com" runat="server" AutoGenerateColumns="False"
                        BorderStyle="Solid" CellPadding="1" CellSpacing="1" CssClass="GridAlternativeItems"
                        Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" GridLines="None" PageSize="30" Visible="False">
                        <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" Wrap="False" />
                        <EditItemStyle BackColor="#2461BF" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                        <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" ForeColor="#333333" Wrap="False" />
                        <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                            Mode="NumericPages" VerticalAlign="Middle" Wrap="False" />
                        <AlternatingItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                        <ItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
                        <Columns>
                            <asp:BoundColumn DataField="nombre_contratista" HeaderText="Nombre Contratista"></asp:BoundColumn>
                            <asp:BoundColumn DataField="region" HeaderText="Regi&#243;n">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="nombre_localidad" HeaderText="Localidad">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="cod_localidad" HeaderText="Cod Localidad">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="grupo" HeaderText="Proceso">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="libreta" HeaderText="Libreta">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="orden_ruta" HeaderText="Orden Ruta">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="ID_TIPO_ORDEN" HeaderText="ID_TIPO_ORDEN" Visible="False">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="TIPO_ORDEN" HeaderText="TIPO ORDEN">
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" ForeColor="White" />
                                <ItemStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" ForeColor="Blue" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="numero_orden" HeaderText="Numero Orden" Visible="False">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="id_servicio" HeaderText="Servicio">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="medidor" HeaderText="Medidor">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="fecha_generacion" HeaderText="Fecha Generaci&#243;n">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="HORA_EJECUCION" HeaderText="Hora Ejecuci&#243;n">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="FECHA_EJECUCION" HeaderText="Fecha Ejecuci&#243;n">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="CORTE_IMPROCEDENTE" HeaderText="Corte Improcedente">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="corte_real" HeaderText="Corte Real">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="EVENTO" HeaderText="EVENTO"></asp:BoundColumn>
                            <asp:BoundColumn DataField="nivel_corte_real" HeaderText="Nivel Corte Real"></asp:BoundColumn>
                            <asp:BoundColumn DataField="nivel_solicitado" HeaderText="Nivel Solicitado"></asp:BoundColumn>
                            <asp:BoundColumn DataField="monto_neto" HeaderText="Monto Neto"></asp:BoundColumn>
                            <asp:BoundColumn DataField="COD_CORTADOR" HeaderText="C&#243;digo Cortador"></asp:BoundColumn>
                            <asp:BoundColumn DataField="NOM_CORTADOR" HeaderText="Nombre Cortador" Visible="False">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="APELLIDO_CORTADOR" HeaderText="Apellido Cortador" Visible="False">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="observacion" HeaderText="Observacion"></asp:BoundColumn>
                            <asp:BoundColumn DataField="COD_CLAVEIMPROCEDENTEPDA" HeaderText="COD CLAVE IMP PDA">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="COD_CLAVE_CORTEEFECTIVO" HeaderText="Cod Clave Corte Efec">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="FECHA_ASIGNACION" HeaderText="Fecha Asignaci&#243;n">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="HORA_ASIGNACION" HeaderText="Hora Asignaci&#243;n">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="CLAVE_LECTURA" HeaderText="Clave Lectura">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="ATENDIDO" HeaderText="ATENDIDO" Visible="False"></asp:BoundColumn>
                            <asp:BoundColumn DataField="rut_contratista" HeaderText="rut_contratista"></asp:BoundColumn>
                            <asp:BoundColumn DataField="num_contrato" HeaderText="num_contrato"></asp:BoundColumn>
                            <asp:BoundColumn DataField="ID_TIPOPROCESO" HeaderText="id_tipoproceso"></asp:BoundColumn>
                        </Columns>
                        <HeaderStyle BackColor="#507CD1" BorderColor="Black" Font-Bold="True" Font-Italic="False"
                            Font-Overline="False" Font-Strikeout="False" Font-Underline="True" ForeColor="White"
                            HorizontalAlign="Center" Wrap="False" />
                    </asp:DataGrid>
                    <br />
                    
                    

                    <asp:Label ID="Label1" runat="server" Text="Resumen de Pagos a Contratista" Font-Names="Arial" Font-Underline="True" Font-Bold="True" Font-Size="X-Small"></asp:Label>&nbsp;<br />
                   <asp:DataGrid ID="ResumenGrillaClaves" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                        BorderStyle="Solid" CellPadding="1" CellSpacing="1" CssClass="GridAlternativeItems"
                        Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" GridLines="None" PageSize="40" Width="751px">
                        <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" Wrap="False" />
                        <EditItemStyle BackColor="#2461BF" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                        <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" ForeColor="#333333" Wrap="False" />
                        <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                            Mode="NumericPages" VerticalAlign="Middle" Wrap="False" />
                        <AlternatingItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                        <ItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
                        <Columns>
                            <asp:BoundColumn DataField="nom_contratista" HeaderText="Nombre Contratista"></asp:BoundColumn>
                            <asp:BoundColumn DataField="rut_contratista" HeaderText="RUT Contratista"></asp:BoundColumn>
                            <asp:BoundColumn DataField="num_contrato" HeaderText="N&#176; Contrato"></asp:BoundColumn>
                            <asp:BoundColumn DataField="tipo_orden" HeaderText="Tipo Orden">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="cod_clave" HeaderText="C&#243;digo Clave"></asp:BoundColumn>
                            <asp:BoundColumn DataField="descripcion_clave" HeaderText="Descripci&#243;n">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>                        
                            <asp:BoundColumn DataField="cantidad" HeaderText="Cantidad">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="precio_unitario" HeaderText="Precio Unitario">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="monto_neto" HeaderText="Monto Neto">
                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="ID_CLAVE" HeaderText="ID_CLAVE" Visible="False"></asp:BoundColumn>
                            <asp:BoundColumn DataField="ATENDIDO" HeaderText="ATENDIDO" Visible="False"></asp:BoundColumn>
                        </Columns>
                        <HeaderStyle BackColor="#507CD1" BorderColor="Black" Font-Bold="True" Font-Italic="False"
                            Font-Overline="False" Font-Strikeout="False" Font-Underline="True" ForeColor="White"
                            HorizontalAlign="Center" Wrap="False" />
                    </asp:DataGrid>&nbsp;<br />
                    &nbsp;
                    
                    
                    
                    <br />
                        <%--<table border="1" style="border-right: black thin solid; border-top: black thin solid; border-left: black thin solid; border-bottom: black thin solid; width: 592px;" cellpadding="0" cellspacing="0" >
                        <tr>
                        <td style="width: 452px">
                        <table id="tbl_estadisticas" runat="server" style="width: 552px" border="0" cellpadding="0" cellspacing="0" >
                        <tr>
                            <td align="center" style="width: 252px; height: 19px; background-color: buttonface">
                                <h2 style="color: white; background-color: #2461bf">
                                    TIPO ORDEN&nbsp;
                                </h2>
                            </td>
                            <td align="center" style="width: 174px; height: 19px; background-color: buttonface">
                                <h2 style="color: white; background-color: #2461bf">
                                CANTIDAD
                                </h2>
                            </td>
                            <td  align="center" style="width: 186px; height: 19px; background-color: buttonface">
                                <h2 style="color: white; background-color: #2461bf;">
                                MONTO NETO ($)</h2>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="width: 252px; background-color: buttonface; height: 17px;">
                                <h2>
                                    Total Reposiciones:&nbsp;
                                </h2>
                            </td>
                            <td align="center" style="width: 50px; text-align:center; height: 17px;">
                                <asp:Label ID="txt_cantidad_reposiciones" runat="server" CssClass="Label"></asp:Label>
                            </td>
                            <td style="width: 186px; text-align:center; height: 17px;">
                                <asp:Label ID="txt_sum_reposiciones" runat="server" CssClass="Label"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="width: 252px; height: 9px; background-color: buttonface">
                                <h2>
                                    Total Cortes:&nbsp;
                                </h2>
                            </td>
                            <td align="center" style="width: 50px; height: 9px; text-align:center;">                            
                                <asp:Label ID="txt_cantidad_cortes" runat="server" CssClass="Label"></asp:Label>
                            </td>
                            <td style="width: 186px; height: 9px; text-align:center;">
                                <asp:Label ID="txt_sum_cortes" runat="server" CssClass="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <td align="right" style="width: 252px; background-color: buttonface; height: 17px;">
                                <h2>
                                    &nbsp;
                                Total Compromisos de Pago:&nbsp;</h2>
                            </td>
                            <td style="width: 50px; height: 17px;" align="center">
                                <asp:Label ID="txt_cantidad_VC" runat="server" CssClass="Label"></asp:Label></td>
                            <td style="width: 186px; text-align:center; height: 17px;">
                                <asp:Label ID="txt_sum_VC" runat="server" CssClass="Label"></asp:Label></td>
                        </tr>                                   
                        <tr>
                            <td align="right" style="width: 252px; height: 17px; background-color: buttonface">
                                <h2>
                                    Total Neto:&nbsp;
                                </h2>
                            </td>
                            <td style="width: 50px; height: 17px; text-align:center;">
                                <asp:Label ID="lb_cant_total" runat="server" CssClass="Label" Font-Bold="True" ForeColor="Navy"></asp:Label></td>
                            <td style="width: 186px; height: 17px; text-align:center;">
                                <asp:Label ID="TXT_TOTAL_FINAL" runat="server" CssClass="Label" Font-Bold="True"
                                    ForeColor="Navy"></asp:Label></td>
                        </tr>
                    </table>
                    </td>
                    </tr>
                    </table> --%>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: left">
                    

                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: left">
                    &nbsp;<asp:Button ID="BtnGeneraExcel" runat="server" CausesValidation="False" CssClass="botonnew"
                        Text="Generar Excel CYR" Width ="140px" />
                        
                    <asp:Button ID="btn_ExcelResumen" runat="server" CausesValidation="False" CssClass="botonnew"
                        Text="Generar Excel (Resumen Pago)" Width="200px" />
                        
                    <%--<input id="btn_imprime" runat="server" class="botonnew" type="button" value="Imprimir" onclick="javascript:imprimir();" />--%>
                    
                    <asp:Button ID="btnVolver" runat="server" CausesValidation="False" CssClass="botonnew"
                        Text="<< Volver" ValidationGroup="NINGUNO" /></td>
            </tr>
            <tr>
                <td colspan="2">
                    </td>
            </tr>
        </table>
        
        
        
    
    </div>
    </form>
</body>
</html>
