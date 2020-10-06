<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EfectividadCortador.aspx.vb" Inherits="EfectividadCortador" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Informe de Efectividad - Sistema CYR</title>
     <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/others.css"/> 
<%--
<style type="text/css">
body {
margin:0;
width: 100%;
height: 100%;
</style>   --%>
        
<%--<script type="text/javascript" language="JavaScript1.2">
window.moveTo(0,0);
top.window.resizeTo(screen.availWidth,screen.availHeight);
</script>  --%> 
        
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
        <table id="tbl_inicio" runat="server" align="center" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <asp:Label ID="Lb_user" runat="server" CssClass="Label" Font-Bold="True" Font-Names="Arial"
                        Font-Size="X-Small" Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user"
                            runat="server" CssClass="Label" Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label
                                ID="lb_empresa" runat="server" CssClass="Label" Font-Bold="True" Font-Names="Arial"
                                Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label ID="lb_session_empresa"
                                    runat="server" CssClass="Label" Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label
                                        ID="lb_rut_empresa" runat="server" CssClass="Label" Font-Names="arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <table id="TABLE2" align="center" border="0" cellspacing="0" class="WebPartShadow"
                        onclick="return TABLE2_onclick()">
                        <tr id="Tr1" runat="server">
                            <td align="left" colspan="2" nowrap="nowrap">
                                <div id="titulo_mod" runat="server" class="WebPartTitle_ext">
                                    Informe Efectividad OT.</div>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" colspan="2">
                                <table align="center" cellpadding="0" style="width: 780px">
                                    <tr id="Tr5" runat="server">
                                        <td align="left" colspan="6" nowrap="nowrap">
                                            <h2>
                                                Seleccione información y luego oprima "Buscar"</h2>
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        <td nowrap="nowrap" style="text-align: right;">
                                            <h2>Tipo Consulta:&nbsp;
                                            </h2></td>
                                        <td align="left" nowrap="nowrap" style="height: 21px">
                                            <asp:DropDownList ID="Sector_busqueda" runat="server" AutoPostBack="True" CssClass="ComboBox2">
                                                <asp:ListItem>Reposicion en Proceso</asp:ListItem>
                                                <asp:ListItem Selected="True">Cortes en proceso</asp:ListItem>
                                                <asp:ListItem>Reposicion historica</asp:ListItem>
                                                <asp:ListItem>Cortes Historicos</asp:ListItem>
                                            </asp:DropDownList></td>
                                        <td nowrap="nowrap" style="width: 75px; text-align: right; height: 21px;">
                                            <h2>
                                                Operador:&nbsp;
                                            </h2></td>
                                        <td align="left" nowrap="nowrap" style="height: 21px">
                                            <asp:DropDownList ID="combo_lectores" runat="server" AutoPostBack="True" CssClass="ComboBox2">
                                            </asp:DropDownList></td>
                                        <td nowrap="nowrap" style="text-align: right; height: 21px;">
                                                <h2>Desde:&nbsp;
                                                </h2></td>
                                        <td align="left" nowrap="nowrap" style="height: 21px">
                                            <asp:TextBox ID="txtDate1" runat="server" CssClass="TextBox2" ReadOnly="false"></asp:TextBox><img
                                                id="calendario_inv" runat="server" onclick="openCalendar('txtDate1');" src="fotos/calendario.gif" /><asp:RequiredFieldValidator
                                                    ID="validar_inf_fecha_desde" runat="server" ControlToValidate="txtDate1" CssClass="ErrorMessage"
                                                    ErrorMessage="*" Font-Bold="True" Height="8px" ValidationGroup="fecha">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                                        ID="validar_fecha_desde" runat="server" BackColor="Transparent" ControlToValidate="txtDate1"
                                                        CssClass="ErrorMessage" ErrorMessage="RegularExpressionValidator" Font-Bold="False"
                                                        ValidationExpression="^[0-9]{2}-[0-9]{2}-[0-9]{4}$" ValidationGroup="fecha" Font-Size="X-Small">Error</asp:RegularExpressionValidator></td>
                                    </tr>
                                    <tr id="Tr12" runat="server">
                                        <td nowrap="nowrap" style="text-align: right; height: 21px;">
                                            <h2>Tipo Proceso:&nbsp;
                                            </h2>
                                        </td>
                                        <td align="left" nowrap="nowrap" style="height: 21px"><asp:DropDownList ID="cmb_TiposProceso" runat="server" AutoPostBack="True" CssClass="ComboBox2">
                                        </asp:DropDownList></td>
                                        <td nowrap="nowrap" style="width: 75px; text-align: right; height: 21px;">
                                            <h2>
                                                Proceso:&nbsp;</h2>
                                        </td>
                                        <td align="left" nowrap="nowrap" style="height: 21px"><asp:DropDownList ID="combo_lotes" runat="server" AutoPostBack="True" CssClass="ComboBox2">
                                        </asp:DropDownList></td>
                                        <td align="left" nowrap="nowrap" style="text-align: right; height: 21px;">
                                            <h2>
                                                Hasta:&nbsp;
                                            </h2>
                                        </td>
                                        <td align="left" nowrap="nowrap" style="height: 21px">
                                            <asp:TextBox ID="txtDate2" runat="server" CssClass="TextBox2" ReadOnly="false"></asp:TextBox><img
                                                id="calendario_inv2" runat="server" onclick="openCalendar('txtDate2');" src="fotos/calendario.gif" /><asp:RequiredFieldValidator
                                                    ID="validar_inf_fecha_hasta" runat="server" ControlToValidate="txtDate2" CssClass="ErrorMessage"
                                                    ErrorMessage="*" Font-Bold="True" ValidationGroup="fecha">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                                        ID="validar_fecha_hasta" runat="server" BackColor="Transparent" ControlToValidate="txtDate2"
                                                        CssClass="ErrorMessage" ErrorMessage="RegularExpressionValidator" Font-Bold="False"
                                                        ValidationExpression="^[0-9]{2}-[0-9]{2}-[0-9]{4}$" ValidationGroup="fecha" Font-Size="X-Small">Error</asp:RegularExpressionValidator></td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap">
                                            <h2 style="text-align: right">
                                                        Zona:&nbsp;
                                            </h2>
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            <asp:DropDownList ID="Combozonas" runat="server" AutoPostBack="True" CssClass="ComboBox2">
                                            </asp:DropDownList></td>
                                        <td align="left" nowrap="nowrap" style="width: 75px; height: 15px; text-align: right">
                                            <h2 style="text-align: right">
                                        Localidad:&nbsp;
                                            </h2>
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            <asp:DropDownList ID="combo_localidades" runat="server" AutoPostBack="True" CssClass="ComboBox2">
                                            </asp:DropDownList></td>
                                        <td align="left" nowrap="nowrap">
                                            <h2 style="text-align: right">
                                                &nbsp;</h2>
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            </td>
                                    </tr>
                                    <tr id="Tr13" runat="server">
                                        <td align="right" nowrap="nowrap">
                                            <h2>
                                                &nbsp;</h2>
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            <asp:Label ID="lb_cantidad_contratistas" runat="server"></asp:Label></td>
                                        <td align="left" nowrap="nowrap" style="width: 75px">
                                            <h2 style="text-align: right">
                                            </h2>
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            <asp:Label ID="lb_cantidad_DPG" runat="server" Text="Label"></asp:Label>
                                            <asp:Label ID="lb_codigos_contratistas" runat="server"></asp:Label></td>
                                        <td align="left" nowrap="nowrap">
                                            <h2 style="text-align: right">
                                                &nbsp;</h2>
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            <asp:Button ID="btnBuscar" runat="server" CssClass="botonnew" Text="BUSCAR" /></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    
    </div>
                        <table align="center" border="0" cellspacing="0" id="Table3" class="WebPartShadow">
                            <tr style="font-family: Times New Roman">
                                <td align="left" colspan="2" style="width: 800px; text-align: center;">
        <table border="0" cellpadding="0" cellspacing="0" style="width: 800px">
            <tr>
                <td align="center" colspan="3" rowspan="1" style="width: 800px;">
                    <table style="width: 100%;">
                                            <tr>
                                                <td rowspan="1" style="height: 11px; width: 424px; text-align:left;">
                                                    <asp:Label ID="Label1" runat="server" CssClass="Label" Font-Names="Arial" ForeColor="Navy"
                                                        Width="103px" Font-Size="X-Small">TOTAL EFECTIVAS:</asp:Label><asp:Label ID="lbl_cant_efec" runat="server" Width="265px" CssClass="Label" Font-Bold="True" Font-Names="Arial" ForeColor="Navy"></asp:Label></td>
                                                <td rowspan="1" style="height: 11px; width: 405px; text-align:left;">
                                                    <asp:Label ID="Label2" runat="server" CssClass="Label" Font-Names="Arial" ForeColor="Navy"
                                                        Width="136px" Font-Size="X-Small">TOTAL IMPROCEDENTES:</asp:Label><asp:Label ID="lbl_cant_impro" runat="server" Width="243px" CssClass="Label" Font-Bold="True" Font-Names="Arial" ForeColor="Navy"></asp:Label></td>
                                            </tr>
                        <tr>
                            <td rowspan="1" style="width: 424px; height: 12px; text-align: left">
                                        <asp:Label style="text-align:left;" ID="lb_cont_registros" runat="server" Width="333px" CssClass="Label"></asp:Label></td>
                            <td rowspan="1" style="width: 405px; height: 12px; text-align: left">
                                                    <asp:Label style="text-align:left;" ID="lb_cont_registros2" runat="server" Width="347px" CssClass="Label"></asp:Label></td>
                        </tr>
                                            <tr>
                                                <td rowspan="3" style="width: 405px; height: 217px; vertical-align:top;">        
                                                                                            
                                        
                                         <%-- <div style="overflow:auto; width:400px; height: 200px;">--%>
                                        <asp:DataGrid ID="GrillaEfectividadLector" runat="server" AutoGenerateColumns="False"
                                            CssClass="GridAlternativeItems" Height="1px"
                                            Width="400px" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" CellPadding="4" ForeColor="#333333" GridLines="None"><FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                            <EditItemStyle BackColor="#2461BF" />
                                            <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                            <PagerStyle BorderColor="Transparent"
                                                VerticalAlign="Middle" BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                            <AlternatingItemStyle BackColor="White" />
                                            <ItemStyle HorizontalAlign="Center" BackColor="White" />
                                            <Columns>
                                                <asp:BoundColumn DataField="clave" HeaderText="Clave Efectiva"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="descripcion" HeaderText="Descripci&#243;n"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="cantidad" HeaderText="Cantidad"></asp:BoundColumn>
                                            </Columns>
                                            <HeaderStyle BorderColor="Black" Font-Underline="True" HorizontalAlign="Center" BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        </asp:DataGrid>
                                       <%--</div>--%>
                                        </td>
                                        <td rowspan="3" style="width: 405px; height: 217px; vertical-align:top;">
                                           <%-- <div style="overflow:auto; width:400px; height:200px;">--%>
                                                        <asp:DataGrid ID="GrillaEfectividad_lector_impro" runat="server" AutoGenerateColumns="False"
                                            CssClass="GridAlternativeItems" Height="1px"
                                            Width="384px" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" CellPadding="4" ForeColor="#333333" GridLines="None">
                                              <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                              <EditItemStyle BackColor="#2461BF" />
                                              <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                              <PagerStyle BorderColor="Transparent"
                                                VerticalAlign="Middle" BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                              <AlternatingItemStyle BackColor="White" />
                                              <ItemStyle HorizontalAlign="Center" BackColor="White" />
                                              <Columns>
                                                  <asp:BoundColumn DataField="clave" HeaderText="Clave Improcedente"></asp:BoundColumn>
                                                  <asp:BoundColumn DataField="descripcion" HeaderText="Descripci&#243;n"></asp:BoundColumn>
                                                  <asp:BoundColumn DataField="inhibida" HeaderText="Tipo"></asp:BoundColumn>
                                                  <asp:BoundColumn DataField="total" HeaderText="Cantidad"></asp:BoundColumn>
                                              </Columns>
                                              <HeaderStyle BorderColor="Black" Font-Underline="True" HorizontalAlign="Center" BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                          </asp:DataGrid>&nbsp;
                                         <%-- </div>--%>
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                            </tr>
                                            <tr>
                                            </tr>
                                        </table>
                </td>
            </tr>
            </table>
            
            <table style="width: 795px">
            <tr>
                <td style="width:40%; height: 19px;">
                  <%If Me.Sector_busqueda.SelectedIndex = 0 Or Me.Sector_busqueda.SelectedIndex = 2 Then%>                                
                            <h2 style="text-align: right">Total Ordenes de Reposición:&nbsp;</h2>
                  <% Else%>
                            <h2 style="text-align: right">Total Ordenes de Corte:&nbsp;</h2>
                  <%End If%>
                   
                </td>
                <td style="width:55%; text-align: left; height: 19px;">
                    &nbsp;<asp:TextBox ID="txt_total" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                </td>
                <td align="center" rowspan="1" style="width: 5%">
                    </td>
            </tr>
            <tr>
                <td style="height: 19px;">
                  <%If Me.Sector_busqueda.SelectedIndex = 0 Or Me.Sector_busqueda.SelectedIndex = 2 Then%>                                
                            <h2 style="text-align: right">Total Ordenes Visitas:&nbsp;</h2>
                  <% Else%>
                            <h2 style="text-align: right">Total Ordenes de Corte Visitadas:&nbsp;</h2>
                  <%End If%>
                
                </td>
                <td style="height: 19px; text-align: left;">
                    &nbsp;<asp:TextBox ID="txt_cant_leidas" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                    <asp:TextBox ID="txt_leidas" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                    %</td>
                  <td align="center" rowspan="9">
                    </td>              
            </tr>
            <tr>
                <td style="height: 19px;">
                  <%If Me.Sector_busqueda.SelectedIndex = 0 Or Me.Sector_busqueda.SelectedIndex = 2 Then%>                                
                            <h2 style="text-align: right">Total Ordenes Pendientes de Visitar:&nbsp;</h2>
                  <% Else%>
                            <h2 style="text-align: right">Total Ordenes de Corte por Visitar:&nbsp;</h2>
                  <%End If%>
                </td>
                <td style="text-align: left; height: 19px;">
                    &nbsp;<asp:TextBox ID="txt_cant_pendientes" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                    <asp:TextBox ID="txt_pendientes" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                    %</td>
            </tr>
            <tr>
                <td style="height: 19px;">
                  <%If Me.Sector_busqueda.SelectedIndex = 0 Or Me.Sector_busqueda.SelectedIndex = 2 Then%>                                
                            <h2 style="text-align: right">Total Reposición Efectivas:&nbsp;</h2>
                  <% Else%>
                            <h2 style="text-align: right">Total Cortes Efectivas:&nbsp;</h2>
                  <%End If%>
                </td>
                <td style="height: 19px; text-align: left;">
                    &nbsp;<asp:TextBox ID="txt_cant_efectivas" runat="server" CssClass="TextBox_totalizador" ReadOnly="True" BackColor="#80FF80"></asp:TextBox>
                    <asp:TextBox ID="txt_efectivos" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                    %</td>
            </tr>
            <tr>
                <td style="height: 23px;">
                  <%If Me.Sector_busqueda.SelectedIndex = 0 Or Me.Sector_busqueda.SelectedIndex = 2 Then%>                                
                            <h2 style="text-align: right">Total Reposiciones Improcedentes:&nbsp;</h2>
                  <% Else%>
                            <h2 style="text-align: right">Total Cortes Improcedentes:&nbsp;</h2>
                  <%End If%>
                </td>
                <td style="text-align: left; height: 23px;">
                    &nbsp;<asp:TextBox ID="txt_cant_improcedentes" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                    <asp:TextBox ID="txt_sin_lecturas" runat="server" CssClass="TextBox_totalizador" ReadOnly="True">
                    </asp:TextBox>
                    %
                    <asp:Label ID="lb_INFO_total_improcedentes" runat="server" Font-Names="Arial Unicode MS" Font-Size="XX-Small"
                        ForeColor="#804000" Text="(Improcedentes Contratistas + Improcedentes Empresas)"></asp:Label></td>
            </tr>
            <tr>
                <td style="height: 23px; text-align: right;">
                  <%If Me.Sector_busqueda.SelectedIndex = 0 Or Me.Sector_busqueda.SelectedIndex = 2 Then%>                                
                            <h2 style="text-align: right">Total Reposiciones Improcedentes Empresa:&nbsp;</h2>
                  <% Else%>
                            <h2 style="text-align: right">Total Cortes Improcedentes Empresa:&nbsp;</h2>
                  <%End If%>
                </td>
                <td style="height: 23px; text-align: left">
                    &nbsp;<asp:TextBox ID="txt_cantidad_empresa" runat="server" CssClass="TextBox_totalizador" ReadOnly="True" BackColor="#FFFFC0"></asp:TextBox>
                    <asp:TextBox ID="txt_porcentaje_empresa" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                    %</td>
            </tr>
            <tr>
                <td style="height: 23px; text-align: right;">
                  <%If Me.Sector_busqueda.SelectedIndex = 0 Or Me.Sector_busqueda.SelectedIndex = 2 Then%>                                
                            <h2 style="text-align: right">Total Reposiciones Improcedentes Técnica:&nbsp;</h2>
                  <% Else%>
                            <h2 style="text-align: right">Total Cortes Improcedentes Técnica:&nbsp;</h2>
                  <%End If%>
                </td>
                <td style="height: 23px; text-align: left">
                    &nbsp;<asp:TextBox ID="txt_cantidad_tecnica" runat="server" CssClass="TextBox_totalizador" ReadOnly="True" BackColor="#FFFFC0"></asp:TextBox>
                    <asp:TextBox ID="txt_porcentaje_tecnica" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                    %</td>
            </tr>
            <tr>
                <td style="height: 23px; text-align: right;">
                  <%If Me.Sector_busqueda.SelectedIndex = 0 Or Me.Sector_busqueda.SelectedIndex = 2 Then%>                                
                            <h2 style="text-align: right">Total Reposiciones Improcedentes Contratista:&nbsp;</h2>
                  <% Else%>
                            <h2 style="text-align: right">Total Cortes Improcedentes Contratista:&nbsp;</h2>
                  <%End If%>
                </td>
                <td style="height: 23px; text-align: left">
                    &nbsp;<asp:TextBox ID="txt_cantidad_contratista" runat="server" CssClass="TextBox_totalizador" ReadOnly="True" BackColor="#FFFFC0"></asp:TextBox>
                    <asp:TextBox ID="txt_porcentaje_contratista" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                    %
                    <asp:Label ID="lb_INFO__imp_contratistas" runat="server" Font-Names="Arial Unicode MS" Font-Size="XX-Small"
                        ForeColor="#804000" Text="(Improcedentes Contratistas - Visita Corte)"></asp:Label></td>
            </tr>
            <tr>
                <td style="height: 23px; text-align: right;">
                    <h2>Total Visita Corte Otorgadas:&nbsp;</h2>
                </td>
                <td style="height: 23px; text-align: left">
                    &nbsp;<asp:TextBox ID="txt_cantidad_VCO" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                    <asp:TextBox ID="txt_porcentaje_VCO" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                    %</td>
            </tr>
            <tr>
                <td style="height: 23px; text-align: right;">
                    <h2>
                            <%If Me.Sector_busqueda.SelectedIndex = 1 Or Me.Sector_busqueda.SelectedIndex = 3 Then%>
                                Total Visita Corte Efectivas o pagadas:&nbsp;
                            <% Else%>
                                Total Visitas Corte Efectivas:&nbsp;
                            <%End If%>
                    </h2>
                    </td>
                <td style="height: 23px; text-align: left">
                    &nbsp;<asp:TextBox ID="txt_cantidad_VCE" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                    <asp:TextBox ID="txt_porcentaje_VCE" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                    %</td>
            </tr>
                <tr id="fila_solo_reposiciones_resumen" runat="server">
                    <td style="height: 23px; text-align: right;">
                         <h2>
                            <%If Me.Sector_busqueda.SelectedIndex = 0 Or Me.Sector_busqueda.SelectedIndex = 2 Then%>
                                Total Cortes efectivos:&nbsp;
                            <% Else%>
                                Total Cortes efectivos:&nbsp;
                            <%End If%>
                         </h2>
                     </td>
                    <td style="height: 23px; text-align: left">
                        &nbsp;<asp:TextBox ID="txt_cant_efectivas_sinDPG" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                        <asp:TextBox ID="txt_porc_efectivas_sinDPG" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                        %
                    </td>
                    <td align="center" rowspan="1">
                    </td>
                </tr>
            <tr>
                <td style="height: 23px; text-align: right;">
                <h2 style="text-align: right">
                    <asp:Label ID="lb_efectividad_final" runat="server" Font-Bold="True" Font-Names="Arial"
                        Font-Size="X-Small" ForeColor="Navy"></asp:Label>:&nbsp;</h2></td>
                <td style="height: 23px; text-align: left">
                    &nbsp;<asp:TextBox ID="txt_efectividad" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                    %</td>
                <td align="center" rowspan="1">
                </td>
            </tr>
            </table>
        
        
        
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="text-align: right; height: 21px;">
                                    &nbsp;<asp:Button ID="BtnGeneraExcel" runat="server" CssClass="botonnew" Text="Generar Excel" CausesValidation="False" />
                                    <input id="btn_imprime" runat="server" class="botonnew" type="button"
                                        value="Imprimir" size="20" />
                                    <asp:Button ID="btnVolver" runat="server" CssClass="botonnew" Text="<< Volver" CausesValidation="False" />
                                    <asp:Button ID="Button1" runat="server" Text="Ver Grafico" CssClass="botonnew" Visible="False" /></td>
                            </tr>
                        </table>
    </form>
</body>
</html>
