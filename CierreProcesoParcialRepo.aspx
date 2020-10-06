<%@ Page Language="VB" AutoEventWireup="false" CodeFile="CierreProcesoParcialRepo.aspx.vb" Inherits="CierreProcesoParcialRepo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" 
"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Cierre Proceso Parcial Reposicion - Sistema CYR</title>
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
</style>--%>

<%--<script type="text/javascript" language="JavaScript1.2">
window.moveTo(0,0);
top.window.resizeTo(screen.availWidth,screen.availHeight);

</script>   
 --%>
      
             <script type="text/javascript" language="javascript">    
             
               function openCalendar(obj)
      {
        var url = 'calendario.aspx?textbox=' + obj;
        window.open(url,'cal','width=260,height=210,left=430,top=320,resizable=0,scrollbars=0');
      }                

    </script>
      
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table id="TABLE1" align="center" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True" CssClass="Label">Sesi�n</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small" CssClass="Label"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True" CssClass="Label">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small" CssClass="Label"></asp:Label>
                                    <asp:Label ID="lb_rut_empresa" runat="server" CssClass="Label"></asp:Label>
                                    <asp:Label ID="lb_id_usuario" runat="server" CssClass="Label"></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <div class="WebPartShadow_ext">
                        <div class="WebPartTitle">
                            Cierre Proceso Parcial Reposici�n</div>
                        <table align="center" border="0" cellspacing="0">
                            <tr>
                                <td align="left" colspan="2" nowrap="nowrap" class="WebPartShadow">
                                    <table>
                                        <tr>
                                            <td colspan="2">
                                                <h2 style="text-align: center">
                                                    <strong>RANGO FECHA</strong></h2>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 50px">
                                                <h2 style="text-align: right">
                                                    Desde:</h2>
                                            </td>
                                            <td>
                                                <h2 style="text-align: center">
                                                    <asp:TextBox ID="txtDate1" runat="server" CssClass="TextBox2" ReadOnly="false"></asp:TextBox><img
                                                        id="Img2" runat="server" alt="calendario2" onclick="openCalendar('txtDate1');"
                                                        src="fotos/calendario.gif" /><asp:RequiredFieldValidator ID="validar_inf_fecha_desde"
                                                            runat="server" ControlToValidate="txtDate1" CssClass="ErrorMessage" ErrorMessage="*"
                                                            Font-Bold="True" Height="8px" ValidationGroup="fecha">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                                                ID="validar_fecha_desde" runat="server" BackColor="Transparent" ControlToValidate="txtDate1"
                                                                CssClass="ErrorMessage" ErrorMessage="RegularExpressionValidator" Font-Bold="True"
                                                                ValidationExpression="^[0-9]{2}-[0-9]{2}-[0-9]{4}$" ValidationGroup="fecha" Font-Names="Arial" Font-Size="X-Small">Error</asp:RegularExpressionValidator>&nbsp;</h2>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                               <h2 style="text-align: right">
                                                   Hasta:</h2></td>
                                            <td>
                                                <asp:TextBox ID="txtDate2" runat="server" CssClass="TextBox2" ReadOnly="false"></asp:TextBox><img
                                                    id="Img4" runat="server" alt="Calendario2" onclick="openCalendar('txtDate2');"
                                                    src="fotos/calendario.gif" /><asp:RequiredFieldValidator ID="validar_inf_fecha_hasta"
                                                        runat="server" ControlToValidate="txtDate2" CssClass="ErrorMessage" ErrorMessage="*"
                                                        Font-Bold="True" ValidationGroup="fecha">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                                            ID="validar_fecha_hasta" runat="server" BackColor="Transparent" ControlToValidate="txtDate2"
                                                            CssClass="ErrorMessage" ErrorMessage="RegularExpressionValidator" Font-Bold="True"
                                                            ValidationExpression="^[0-9]{2}-[0-9]{2}-[0-9]{4}$" ValidationGroup="fecha" Font-Names="Arial" Font-Size="X-Small">Error</asp:RegularExpressionValidator></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="text-align: right">
                                                &nbsp;<asp:Button ID="btnBuscar" runat="server" CssClass="botonnew" Text="BUSCAR" />
                                                </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <asp:Label ID="lb_error_filtro" runat="server" CssClass="Label" Font-Names="Arial Unicode MS"
                        Font-Size="Small" ForeColor="Red" Height="18px"></asp:Label></td>
            </tr>
        </table>
    
    </div>
        <table id="tbl_inicio2" runat="server" align="center" border="0" cellspacing="0"
            class="WebPartShadow">
            <tr>
                <td align="left" colspan="2">
                    <div>
                        <asp:Label ID="lbl_dias" runat="server" Text="D�as que deben transcurrir desde fecha de generaci�n para Cierre de Reposiciones Improcedentes" CssClass="Label"></asp:Label>
                        <asp:Label ID="lbl_diasnum" runat="server" ToolTip="Dias que deben transcurrir para realizar Cierre de reposiciones" CssClass="Label"></asp:Label><br />
                                                    <asp:Label ID="lb_cont_registros" runat="server" CssClass="Label"></asp:Label><asp:DataGrid ID="GrillaCierreProcesoParcial" runat="server" AutoGenerateColumns="False"
                                                        BorderColor="#003366" BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1"
                                                        CssClass="GridAlternativeItems" ForeColor="Black" GridLines="Horizontal"
                                                        Width="840px">
                                                        <HeaderStyle BackColor="Control" BorderColor="Black" Font-Bold="True" Font-Underline="True"
                                                            ForeColor="Black" HorizontalAlign="Center" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Wrap="False" />
                                                        <Columns>
                                                            <asp:BoundColumn DataField="id_localidad" HeaderText="IDLocalidad" Visible="False">
                                                                <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                                                    Font-Strikeout="False" Font-Underline="True" ForeColor="White" Wrap="False" />
                                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="cod_localidad" HeaderText="C&#243;digo Localidad">
                                                                <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" ForeColor="White" Wrap="False" />
                                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="nom_localidad" HeaderText="Localidad">
                                                                <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" ForeColor="White" Wrap="False" />
                                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="leidos" HeaderText="Visitados">
                                                                <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" ForeColor="White" Wrap="False" />
                                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="pendientes" HeaderText="Pendientes">
                                                                <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" ForeColor="White" Wrap="False" />
                                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="sin_lectura" HeaderText="Sin Corte">
                                                                <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" ForeColor="White" Wrap="False" />
                                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="efectivas" HeaderText="Efectivas">
                                                                <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" ForeColor="White" Wrap="False" />
                                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="total_localidad" HeaderText="Total Localidad">
                                                                <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" ForeColor="White" Wrap="False" />
                                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="dias_cierreok" HeaderText="D&#237;as Cierre Completados sin cortes">
                                                                <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                                                    Font-Strikeout="False" Font-Underline="True" ForeColor="White" Wrap="False" />
                                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="dias_cierreerror" HeaderText="D&#237;as Cierre No completados sin cortes">
                                                                <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                                                    Font-Strikeout="False" Font-Underline="True" ForeColor="White" Wrap="False" />
                                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:BoundColumn>
                                                        </Columns>
                                                        <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                                                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                                                            VerticalAlign="Middle" Wrap="False" />
                                                        <ItemStyle BackColor="White" HorizontalAlign="Center" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                                        <AlternatingItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                                        <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                            Font-Underline="False" Wrap="False" />
                                                        <EditItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                            Font-Underline="False" Wrap="False" />
                                                        <SelectedItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                            Font-Underline="False" Wrap="False" />
                                                    </asp:DataGrid></div>
                                    <asp:Image ID="img_ok" runat="server" ImageUrl="fotos/ok.bmp" /><asp:Label ID="ok_cierre_parcial"
                                        runat="server" Font-Names="Arial Unicode MS" ForeColor="#0000C0" CssClass="Label" Font-Size="Small" Height="18px" Width="657px"></asp:Label>
                                        <asp:Label ID="lbValida_cierre" runat="server" Font-Names="Arial Unicode MS" ForeColor="Red" CssClass="Label" Font-Size="Small" Height="18px"></asp:Label>
                    <asp:LinkButton ID="lk_ir_ManOT" runat="server" Font-Names="Arial Unicode MS" Font-Size="X-Small"
                        ForeColor="Blue">Aqu�</asp:LinkButton></td>
            </tr>
            <tr>
                <td align="left" colspan="2">
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: left">
                                        <table id="Table2" align="center" border="0" cellspacing="0" width="840">
                                            <tr>
                                                <td align="left" colspan="1" style="width: 179px; height: 19px;">
                                                    <strong>
                                                        <h2>
                                                            Total Reposiciones</h2>
                                                    </strong>
                                                </td>
                                                <td colspan="1">
                                                    <asp:TextBox ID="txt_total" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="1" style="height: 3px; width: 179px;">
                                                    <h2>
                                                        Reposiciones Visitadas</h2>
                                                </td>
                                                <td colspan="1">
                                                    <asp:TextBox ID="txt_cant_leidas" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                                                    <asp:TextBox ID="txt_leidas" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                                                    %</td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="1" style="height: 21px; width: 179px;">
                                                    <h2>
                                                        Reposiciones Pendientes</h2>
                                                </td>
                                                <td colspan="1">
                                                    <asp:TextBox ID="txt_cant_pendientes" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                                                    <asp:TextBox ID="txt_pendientes" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                                                    %</td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="1" style="height: 3px; width: 179px;">
                                                    <h2>
                                                        Reposiciones Efectivas</h2>
                                                </td>
                                                <td colspan="1">
                                                    <asp:TextBox ID="txt_cant_efectivos" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                                                    <asp:TextBox ID="txt_efectivos" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                                                    %</td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="1" style="width: 179px">
                                                    <h2>
                                                        Reposiciones Improcedentes</h2>
                                                </td>
                                                <td colspan="1">
                                                    <asp:TextBox ID="txt_cant_sin_lecturas" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                                                    <asp:TextBox ID="txt_sin_lecturas" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                                                    %
                                                </td>
                                            </tr>
                                        </table>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    &nbsp;<asp:Label ID="lb_cantidad_contratistas" runat="server"></asp:Label>
                    <asp:Label ID="lb_codigos_contratistas" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: right; height: 21px;">
                    &nbsp;<asp:Button ID="btnCierreProceso" runat="server" CssClass="botonnew" Text="Cierre Proceso" />
                    <asp:Button ID="btnCancelar" runat="server" CssClass="botonnew" Text="Abrir Proceso Parcial (Administrador)" ToolTip="Habilita �rdenes para digitaci�n seg�n filtro de fechas seleccionado. S�lo usuaria administradores!" Width="229px" />
                    <asp:Button ID="btnVolver" runat="server" CssClass="botonnew" Text="<< Volver" /></td>
            </tr>
        </table>
    </form>
</body>
</html>
