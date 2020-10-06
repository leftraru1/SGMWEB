<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SeguimientoCortes.aspx.vb" Inherits="SeguimientoCortes" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Informe de Cortes y Reposiciones - Sistema CYR</title>
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
</style>   --%>     

        
<%--<script type="text/javascript" language="JavaScript1.2">
window.moveTo(0,0);
top.window.resizeTo(screen.availWidth,screen.availHeight);
</script>   --%>
       
<script type="text/javascript" language="javascript">    
function openCalendar(obj)
      {
        var url = 'calendario.aspx?textbox=' + obj;
        window.open(url,'cal','width=260,height=210,left=280 70,top=80,resizable=0,scrollbars=0');
      }              
    function AbrirGrafico(pid_grupoproceso,pid_lector,pnom_lector,pid_localidad,pleidas,pefectivas,pimprocedentes,pbusqueda)
      {
       if (pbusqueda!='NADA') 
          { 
           var url = 'GraficoLoteLector.aspx?IDgrupoproceso=' + pid_grupoproceso + '&IDlector=' + pid_lector + '&NomLector=' + pnom_lector + '&IDlocalidad=' + pid_localidad + '&leidas=' + pleidas + '&efectivas=' + pefectivas + '&improcedentes=' + pimprocedentes + '&busqueda=' + pbusqueda;
           window.open(url,'cal','width=580,height=580,left=0,top=0,resizable=yes,scrollbars=0');
          }  
         else
          {
          alert('DEBE SELECCIONAR UN LOTE');
          }
      }    
       function imprimir()
      {
        //var url = 'POPLectores.aspx?textbox=' + obj;
       // alert();
       window.print();
        //window.open(url,'cal','width=820,height=320,left=200,top=50,resizable=0,scrollbars=yes');
      }      

</script>
      
</head>
<body>
    <form id="form1" runat="server">
    <div>
                            <tr>
                                <td style="height: 13px">
                    </td>
                            </tr>
                            <tr>
                                <td>
                                    <table id="tbl_inicio" runat="server" align="center" border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td>
                                                <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                                                    Font-Underline="True" CssClass="Label">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                                                        Font-Names="Arial" Font-Size="X-Small" CssClass="Label"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                                            Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True" CssClass="Label">Empresa</asp:Label><asp:Label
                                                                ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small" CssClass="Label"></asp:Label><asp:Label ID="lb_rut_empresa" runat="server" CssClass="Label" Font-Names="arial" Font-Size="X-Small"></asp:Label><asp:Label
                                                                    ID="lb_id_usuario" runat="server" CssClass="Label"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table align="center" border="0" cellspacing="0" class="WebPartShadow" id="TABLE2" onclick="return TABLE2_onclick()">
                                                    <tr id="Tr1" runat="server">
                                                        <td align="left" colspan="2" nowrap="nowrap">
                                                            <div id="titulo_mod" runat="server" class="WebPartTitle_ext">
                                                                Informe de Cortes y Reposiciones</div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right" colspan="2">
                                                            <table align="center" cellpadding="0">
                                                                <tr id="Tr5" runat="server">
                                                                    <td align="left" colspan="6" nowrap="nowrap">
                                                                        <h2>
                                                                            Seleccione información y luego oprima "BUSCAR"</h2>
                                                                    </td>
                                                                </tr>
                                                                <tr id="Tr12" runat="server">
                                                                    <td align="right" nowrap="nowrap">
                                                                        <h2 style="text-align: right">
                                                                Tipo Proceso:&nbsp;
                                                                        </h2>
                                                                    </td>
                                                                    <td align="left" nowrap="nowrap">
                                                            <asp:DropDownList ID="Sector_busqueda" runat="server" AutoPostBack="True" CssClass="ComboBox2">
                                                                <asp:ListItem>Reposicion en Proceso</asp:ListItem>
                                                                <asp:ListItem Selected="True">Cortes en proceso</asp:ListItem>
                                                                <asp:ListItem>Reposicion historica</asp:ListItem>
                                                                <asp:ListItem>Cortes Historicos</asp:ListItem>
                                                            </asp:DropDownList></td>
                                                                    <td align="left" nowrap="nowrap" style="width: 75px; text-align: right">
                                                                        <h2>
                                                                Zona:
                                                                        </h2>
                                                                    </td>
                                                                    <td align="left" nowrap="nowrap">
                                                            <asp:DropDownList ID="Combozonas" runat="server" AutoPostBack="True" CssClass="ComboBox2">
                                                            </asp:DropDownList></td>
                                                                    <td align="left" nowrap="nowrap" style="text-align: right">
                                                                        <h2>
                                                                            &nbsp; &nbsp; Desde:&nbsp;
                                                                        </h2>
                                                                    </td>
                                                                    <td align="left" nowrap="nowrap">
                                                                        <asp:TextBox ID="txtDate1" runat="server" CssClass="TextBox2" ReadOnly="false"></asp:TextBox><img
                                                                            id="calendario_inv" runat="server" onclick="openCalendar('txtDate1');" src="fotos/calendario.gif" /><asp:RequiredFieldValidator
                                                                                ID="validar_inf_fecha_desde" runat="server" ControlToValidate="txtDate1" CssClass="ErrorMessage"
                                                                                ErrorMessage="*" Font-Bold="True" Height="8px" ValidationGroup="fecha">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                                                                    ID="validar_fecha_desde" runat="server" BackColor="Transparent" ControlToValidate="txtDate1"
                                                                                    CssClass="ErrorMessage" ErrorMessage="RegularExpressionValidator" Font-Bold="True"
                                                                                    ValidationExpression="^[0-9]{2}-[0-9]{2}-[0-9]{4}$" ValidationGroup="fecha" Font-Names="Arial" Font-Size="X-Small">(Error)</asp:RegularExpressionValidator></td>
                                                                </tr>
                                                                <tr>
                                                                    <td nowrap="nowrap">
                                                                        <h2 style="text-align: right">
                                                                            Proceso:&nbsp;
                                                                        </h2>
                                                                    </td>
                                                                    <td align="left" nowrap="nowrap">
                                                            <asp:DropDownList ID="combo_lotes" runat="server" AutoPostBack="True" CssClass="ComboBox2">
                                                            </asp:DropDownList></td>
                                                                    <td align="left" nowrap="nowrap" style="width: 75px; height: 15px; text-align: right">
                                                                        <h2 style="text-align: right">
                                                                Localidad:</h2>
                                                                    </td>
                                                                    <td align="left" nowrap="nowrap">
                                                            <asp:DropDownList ID="combo_localidades" runat="server" AutoPostBack="True" CssClass="ComboBox2">
                                                            </asp:DropDownList></td>
                                                                    <td align="left" nowrap="nowrap">
                                                                        <h2 style="text-align: right">
                                                                             &nbsp; &nbsp;Hasta:&nbsp;
                                                                        </h2>
                                                                    </td>
                                                                    <td align="left" nowrap="nowrap">
                                                                        <asp:TextBox ID="txtDate2" runat="server" CssClass="TextBox2" ReadOnly="false"></asp:TextBox><img
                                                                            id="calendario_inv2" runat="server" onclick="openCalendar('txtDate2');" src="fotos/calendario.gif" /><asp:RequiredFieldValidator
                                                                                ID="validar_inf_fecha_hasta" runat="server" ControlToValidate="txtDate2" CssClass="ErrorMessage"
                                                                                ErrorMessage="*" Font-Bold="True" ValidationGroup="fecha">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                                                                    ID="validar_fecha_hasta" runat="server" BackColor="Transparent" ControlToValidate="txtDate2"
                                                                                    CssClass="ErrorMessage" ErrorMessage="RegularExpressionValidator" Font-Bold="True"
                                                                                    ValidationExpression="^[0-9]{2}-[0-9]{2}-[0-9]{4}$" ValidationGroup="fecha" Font-Names="Arial" Font-Size="X-Small">(Error)</asp:RegularExpressionValidator></td>
                                                                </tr>
                                                                <tr id="Tr13" runat="server">
                                                                    <td align="right" nowrap="nowrap" style="height: 21px">
                                                                        <h2>
                                                                            Operador:&nbsp;</h2>
                                                                    </td>
                                                                    <td align="left" nowrap="nowrap" style="height: 21px">
                                                            <asp:DropDownList ID="combo_lectores" runat="server" AutoPostBack="True" CssClass="ComboBox2">
                                                            </asp:DropDownList></td>
                                                                    <td align="left" nowrap="nowrap" style="width: 75px; height: 21px;">
                                                                        <h2 style="text-align: right">
                                                                        </h2>
                                                                    </td>
                                                                    <td align="left" nowrap="nowrap" style="height: 21px">
                                                                    </td>
                                                                    <td align="left" nowrap="nowrap" style="height: 21px">
                                                                        <h2 style="text-align: right">
                                                                            &nbsp;</h2>
                                                                    </td>
                                                                    <td align="left" nowrap="nowrap" style="height: 21px">
                                                                        </td>
                                                                </tr>
                                                                <tr id="Tr14" runat="server">
                                                                    <td align="right" nowrap="nowrap">
                                                                        <h2>
                                                                            &nbsp;&nbsp;
                                                                        </h2>
                                                                    </td>
                                                                    <td align="left" nowrap="nowrap">
                                                                        <asp:Label ID="lb_cantidad_contratistas" runat="server"></asp:Label>&nbsp;
                                                                    </td>
                                                                    <td align="left" nowrap="nowrap" style="width: 75px">
                                                                        <h2 style="text-align: right">
                                                                            &nbsp;</h2>
                                                                    </td>
                                                                    <td align="left" nowrap="nowrap">
                                                                        <asp:Label ID="lb_codigos_contratistas" runat="server"></asp:Label></td>
                                                                    <td align="left" nowrap="nowrap">
                                                                        <h2 style="text-align: right">
                                                                            &nbsp;</h2>
                                                                    </td>
                                                                    <td align="left" nowrap="nowrap" style="text-align: left">
                                                                        <asp:Button ID="btnActualizar" runat="server" CssClass="botonnew" Height="20px" OnClientClick="$.showprogress()"
                                                                            Text="BUSCAR" Width="120px" /></td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                   
                                </td>
                            </tr>
                        <table align="center" border="0" cellspacing="0" id="TABLE1" class="WebPartShadow">
                            <tr>
                                <td align="left" colspan="2" class="WebPartShadow">
                                    
                                    <asp:Label ID="lb_cont_registros" runat="server" CssClass="Label"></asp:Label>
                                        
                                                                            
                                        
                                        <asp:DataGrid ID="GrillaEfectividadLector" runat="server" AutoGenerateColumns="False"
                                            CssClass="GridAlternativeItems" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" CellPadding="1" GridLines="None" AllowPaging="True" BorderStyle="Solid" CellSpacing="1" PageSize="40"><FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                            <EditItemStyle BackColor="#2461BF" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                            <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                            <PagerStyle BackColor="Control" BorderColor="Transparent" HorizontalAlign="Center"
                                                VerticalAlign="Middle" Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Mode="NumericPages" Wrap="False" />
                                            <AlternatingItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                            <ItemStyle BackColor="White" HorizontalAlign="Center" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                            <Columns>
                                                <asp:BoundColumn DataField="REGION" HeaderText="Regi&#243;n">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="ZONA" HeaderText="Zona">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="COD_LOCALIDAD" HeaderText="Cod Localidad">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="LOCALIDAD" HeaderText="Localidad">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="GRUPO" HeaderText="Proceso">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="LIBRETA" HeaderText="Libreta">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="ORDEN_RUTA" HeaderText="Orden Ruta">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="NOM_CLIENTE" HeaderText="Cliente" Visible="False">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="direccion" HeaderText="Direcci&#243;n">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="ID_SERVICIO" HeaderText="Servicio">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn HeaderText="Medidor" DataField="MEDIDOR">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn HeaderText="Lectura" DataField="LECTURA">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
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
                                                <asp:BoundColumn DataField="FECHA_GENERACION" HeaderText="Fecha Generaci&#243;n">
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
                                                <asp:BoundColumn DataField="HORA_EJECUCION" HeaderText="Hora Ejecuci&#243;n">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="COD_CLAVEIMPROCEDENTEPDA" HeaderText="Cod. Improcedente">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="CORTE_IMPROCEDENTE" HeaderText="Improcedente">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="COD_CLAVE_CORTEEFECTIVO" HeaderText="Cod. Efectivo">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="CORTEEFECTIVO" HeaderText="Efectivo">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="COD_CLAVE_LECTURAPDA" HeaderText="Cod. Clave Lectura">
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
                                                <asp:BoundColumn DataField="COD_CORTADOR" HeaderText="Operador">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
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
                                                <asp:BoundColumn DataField="PX" HeaderText="Cordenada X">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="PY" HeaderText="Cordenada Y">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="OBSERVACION" HeaderText="Observaci&#243;n">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="NUMERO_ORDEN" HeaderText="NUMERO_ORDEN"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="FOTO" HeaderText="FOTO"></asp:BoundColumn>
                                            </Columns>
                                            <HeaderStyle BackColor="#507CD1" BorderColor="Black" Font-Bold="True" Font-Italic="False"
                                                Font-Overline="False" Font-Strikeout="False" Font-Underline="True" ForeColor="White"
                                                HorizontalAlign="Center" Wrap="False" />
                                        </asp:DataGrid>
                                    
                                    </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="text-align: right">
                                    <asp:HyperLink ID="control_HL_EFE" runat="server" CssClass="botonnew" style="text-align:center;" Width="143px" Font-Overline="False">Generar Excel</asp:HyperLink><asp:Button ID="BtnGeneraExcel" runat="server" CssClass="botonnew" Text="Generar Excel" CausesValidation="False" />
                                    <input id="btn_imprime" runat="server" class="botonnew" type="button"
                                        value="Imprimir" />
                                    <asp:Button ID="btnVolver" runat="server" CssClass="botonnew" Text="<< Volver" CausesValidation="False" ValidationGroup="NINGUNO" /></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Button ID="Button1" runat="server" Text="Ver Grafico" CssClass="botonnew" Visible="False" />
                                    <asp:GridView ID="gv_excel" runat="server">
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
    
        </div>
        
    </form>
</body>
</html>
