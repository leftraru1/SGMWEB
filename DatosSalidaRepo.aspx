<%@ Page Language="VB" AutoEventWireup="false" CodeFile="DatosSalidaRepo.aspx.vb" Inherits="DatosSalidaRepo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Estado de Reposiciones - Sistema CYR</title>
     <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/others.css"/>
  
  
 <style type="text/css">
body {
margin:0;
width: 100%;
height: 100%;
}
</style>

<%--<script type="text/javascript" language="JavaScript1.2">
window.moveTo(0,0);
top.window.resizeTo(screen.availWidth,screen.availHeight);
</script>   --%>
      
       
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
        &nbsp;<table id="TABLE1" align="center" border="0" cellpadding="0" cellspacing="0" style="width: 758px;
            height: 118px" width="758">
            <tr>
                <td style="width: 732px; height: 11px">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True" CssClass="Label">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small" CssClass="Label"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True" CssClass="Label">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small" CssClass="Label"></asp:Label>
                                    <asp:Label ID="lb_rut_empresa" runat="server" CssClass="Label"></asp:Label>
                                    <asp:Label ID="lb_id_usuario" runat="server" CssClass="Label"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 732px; height: 1px">
                    <div class="WebPartShadow_ext">
                        <div class="WebPartTitle_ext">
                            Estado de Reposiciones</div>
                        <table align="center" border="0" cellspacing="0" style="width: 709px; height: 1px"
                            width="709">
                            <tr>
                                <td align="center" colspan="2" style="height: 3px">
                                    <table align="center" border="0" cellspacing="0">
                                        <tr>
                                            <td align="left" class="WebPartShadow" colspan="2" nowrap="nowrap">
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
                                                                Hasta:</h2>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtDate2" runat="server" CssClass="TextBox2" ReadOnly="false"></asp:TextBox><img
                                                                id="calendario_inv2" runat="server" alt="Calendario2" onclick="openCalendar('txtDate2');"
                                                                src="fotos/calendario.gif" /><asp:RequiredFieldValidator ID="validar_inf_fecha_hasta"
                                                                    runat="server" ControlToValidate="txtDate2" CssClass="ErrorMessage" ErrorMessage="*"
                                                                    Font-Bold="True" ValidationGroup="fecha">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                                                        ID="validar_fecha_hasta" runat="server" BackColor="Transparent" ControlToValidate="txtDate2"
                                                                        CssClass="ErrorMessage" ErrorMessage="RegularExpressionValidator" Font-Bold="True"
                                                                        ValidationExpression="^[0-9]{2}-[0-9]{2}-[0-9]{4}$" ValidationGroup="fecha" Font-Names="Arial" Font-Size="X-Small">Error</asp:RegularExpressionValidator></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" style="text-align: right">
                                                            <asp:Button ID="btnBuscar" runat="server" CssClass="botonnew" Text="BUSCAR" />
                                                            </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td align="left" colspan="2" style="height: 3px">
                                    <asp:Label ID="lb_error_filtro" runat="server" Font-Names="Arial Unicode MS" Font-Size="Small"
                                        ForeColor="Red" Width="584px"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="left" colspan="2" style="height: 1px">
                                    <div class="WebPartShadow" style="text-align: justify">
                                        <table id="Table2" align="center" border="0" cellspacing="0" style="width: 709px;
                                            height: 3px" width="709">
                                            <tr style="color: #000000">
                                                <td align="center" colspan="2" style="width: 760px; height: 3px; text-align: left">
                                                    &nbsp;<asp:Label ID="lb_cont_registros" runat="server" Width="463px"></asp:Label>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                    &nbsp; &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False"
                                                        ForeColor="Blue" Visible="False">Marcar Todos</asp:LinkButton>&nbsp;
                                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" ForeColor="Blue" Visible="False">Desmarcar Todos</asp:LinkButton><asp:DataGrid ID="GrillaSalidaRFC" runat="server" AutoGenerateColumns="False" BorderWidth="0px" CellPadding="1" CellSpacing="1"
                                                        CssClass="GridAlternativeItems" GridLines="Horizontal" Height="1px"
                                                        Width="706px" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                                                        <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                                                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                                                            VerticalAlign="Middle" />
                                                        <AlternatingItemStyle BackColor="White" />
                                                        <ItemStyle BackColor="MenuBar" HorizontalAlign="Center" />
                                                        <HeaderStyle BackColor="CornflowerBlue" BorderColor="Black" Font-Bold="True" Font-Underline="True"
                                                            ForeColor="White" HorizontalAlign="Center" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" />
                                                        <Columns>
                                                            <asp:BoundColumn DataField="id_localidad" HeaderText="IDLocalidad" Visible="False">
                                                                <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                                    Font-Strikeout="False" Font-Underline="False" ForeColor="White" Width="14%" />
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="cod_localidad" HeaderText="C&#243;digo Localidad">
                                                                <HeaderStyle Width="14%" BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="id_cortador" HeaderText="id_cortador" Visible="False"></asp:BoundColumn>
                                                            <asp:BoundColumn DataField="nom_localidad" HeaderText="Localidad">
                                                                <HeaderStyle Width="15%" BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="ruta" HeaderText="Ruta">
                                                                <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                                    Font-Strikeout="False" Font-Underline="False" ForeColor="White" Width="14%" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="cod_cortador" HeaderText="cod cortador">
                                                                <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                                    Font-Strikeout="False" Font-Underline="False" ForeColor="White" Width="14%" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="pendiente" HeaderText="Pendientes">
                                                                <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                                    Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="descargado" HeaderText="Descargado">
                                                                <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                                    Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="total_localidad" HeaderText="Total Cortes">
                                                                <HeaderStyle Width="14%" BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                                            </asp:BoundColumn>
                                                            <asp:TemplateColumn HeaderText="Seleccion" Visible="False">
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="check_repaso" runat="server" />
                                                                </ItemTemplate>
                                                                <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                                    Font-Strikeout="False" Font-Underline="False" ForeColor="White" Width="5%" />
                                                            </asp:TemplateColumn>
                                                        </Columns>
                                                    </asp:DataGrid>
                                        <asp:Label ID="valida_envio_RFC" runat="server" Font-Names="Arial Unicode MS" ForeColor="Red"
                                            Width="669px" Font-Size="Small" Height="18px"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="1" style="width: 25%; height: 21px;">
                                                 <h2>
                                                            TOTAL REPOSICIONES</h2>
                                                </td>
                                                <td colspan="1" style="height: 21px">
                                                    <asp:TextBox ID="txt_total_lecturas" runat="server" CssClass="TextBox" Width="50px"></asp:TextBox>
                                                    ( 100 % )</td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="1" style="width: 25%; height: 21px;">
                                                    <strong>
                                                        <h2>
                                                            TOTAL REPOS DESCARGADAS&nbsp;</h2>
                                                    </strong>
                                                </td>
                                                <td colspan="1" style="height: 21px">
                                                    <asp:TextBox ID="txt_cant_repasos" runat="server" CssClass="TextBox" Width="50px"></asp:TextBox>
                                                    <asp:TextBox ID="txt_repasos_porcentaje" runat="server" CssClass="TextBox" Width="50px"></asp:TextBox>
                                                    %</td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="1" style="height: 17px">
                                                </td>
                                                <td colspan="1" style="height: 17px">
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <h2>
                                        &nbsp;</h2>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="2" style="height: 1px">
                                    <asp:Image ID="img_ok" runat="server" ImageUrl="fotos/ok.bmp" /><asp:Label ID="ok_cierre_general"
                                        runat="server" Font-Names="Arial Unicode MS" ForeColor="#0000C0" Width="688px" Font-Size="Small"></asp:Label>
                                    <asp:Label ID="Lb_contador" runat="server" Font-Names="Arial Unicode MS" ForeColor="#0000C0"
                                        Width="712px" Font-Size="Small"></asp:Label>
                                    <asp:Label ID="cont_registros_seleccion" runat="server" Text="0" Visible="False"></asp:Label>
                                    <asp:Label ID="observacion_null_seleccion" runat="server" Text="0" Visible="False"></asp:Label>
                                    <asp:Label ID="Lb_clavesnull" runat="server" Font-Names="Arial Unicode MS" ForeColor="#0000C0" Width="712px" Font-Size="Small" Height="18px"></asp:Label>&nbsp;&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="height: 22px">
                                    &nbsp;<asp:Button ID="btn_exportartxt" runat="server" CssClass="botonnew" Text="Exportar Reposiciones"
                                        Width="139px" />&nbsp;
                                    <asp:Button ID="btnVolver" runat="server" CssClass="botonnew" Text="<< Volver"
                                        Width="111px" ValidationGroup="NINGUNO" /></td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="height: 22px; text-align: left">
                                    <asp:Table ID="tbl_link" runat="server" Width="712px">
                                    </asp:Table><asp:Table ID="tbl_link2" runat="server" Width="712px">
                                    </asp:Table>
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
