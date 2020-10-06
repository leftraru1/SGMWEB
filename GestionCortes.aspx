<%@ Page Language="VB" AutoEventWireup="false" CodeFile="GestionCortes.aspx.vb" Inherits="GestionHistorica" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Gestión de Cortes Históricos - Sistema CYR</title>
    <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/others.css"/>
      
<%--            <style type="text/css">
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

      function PopVisitas(p_id_servicio,p_num_orden)      
       {       
       var url = 'popVisitas.aspx?id_servicio='+p_id_servicio+'&num_orden='+p_num_orden;
       open(url,'DetalleVisitas','top=30,left=10,width=1300,height=380,status=no,resizable=yes');
      
       }           
       
      function PopFoto(p_id_servicio,p_num_orden,p_glosa_tipoorden,p_cod_localidad,p_ubicacion_foto)      
       {       
       var url = 'popFoto.aspx?id_servicio='+p_id_servicio+'&num_orden='+p_num_orden+'&glosa_tipoorden='+p_glosa_tipoorden+'&cod_localidad='+p_cod_localidad+'&ubicacion_foto='+p_ubicacion_foto;
       open(url,'DetalleFoto','top=30,left=10,width=1300,height=380,status=no,resizable=yes');
      
       }                  
                 
      </script> 
</head>
<body>
    <form id="form1" runat="server">
    <div style="text-align: center">
        <table id="Table5" runat="server" align="center" border="0" cellpadding="0" cellspacing="0" style="width: 872px">
            <tr>
                <td id="panel_sesion" align="left">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True" CssClass="Label">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small" CssClass="Label"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True" CssClass="Label">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small" CssClass="Label"></asp:Label><asp:Label ID="lb_rut_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small" CssClass="Label"></asp:Label></td>
            </tr>
            <tr style="font-family: Trebuchet MS">
                <td id="Td1" runat="server" class="WebPartShadow">
                                        <table id="B" align="center" border="0" cellspacing="0" onclick="return Table2_onclick()" class="WebPartShadow">
                                            <tr runat="server">
                                                <td align="left" class="WebPartTitle" colspan="3" nowrap="nowrap">
                                                    Gestión de cortes y reposiciones.</td>
                                            </tr>
                                            <tr id="Tr6" runat="server">
                                                <td align="left" colspan="3" nowrap="nowrap">
                                                    <h2>
                                                        Ingrese el Número de Cliente y luego oprima "VER CLIENTE".</h2>
                                                </td>
                                            </tr>
                                            <tr id="Tr7" runat="server">
                                                <td colspan="3" style="text-align: left">
                                                    <asp:RadioButtonList ID="Rd_tipo_Busqueda" runat="server" RepeatDirection="Horizontal" CssClass="Label">
                                                        <asp:ListItem Value="1" Selected="True">IC</asp:ListItem>
                                                    </asp:RadioButtonList><h2>
                                                        &nbsp;</h2>
                                                </td>
                                            </tr>
                                            <tr id="Tr2" runat="server">
                                                <td align="left" colspan="3" nowrap="nowrap" style="text-align: center">
                                                    <asp:LinkButton ID="lk_VerRegistro" runat="server" Font-Bold="True" ForeColor="#0000C0" CssClass="Label" Visible="False">VER CLIENTE</asp:LinkButton>&nbsp;
                                                    
                                                 <br />
                                                        
                                                    <asp:Panel ID="Panel2" runat="server" DefaultButton="btn_buscarP" Height="15px" Width="300px">
                                                        <asp:RequiredFieldValidator
                                                            ID="RequiredFieldValidator1" runat="server" ControlToValidate="texto_Busqueda"
                                                            Display="Dynamic" ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator>
                                                        <asp:TextBox ID="texto_Busqueda" runat="server" CssClass="TextBox2"></asp:TextBox>
                                                        <asp:Label ID="lb_busca" runat="server" CssClass="Label"></asp:Label>
                                                    
                                                        <asp:Button ID="btn_buscarP" runat="server" Style="display: none" />&nbsp;
                                                        &nbsp;
                                                        <asp:Button id="btn_buscar" runat="server" CssClass="botonnew" CausesValidation="False" Text="Ver Cliente"></asp:Button>
                                                     </asp:Panel>
                                                
                                                </td>
                                            </tr>
                                            <tr runat="server" id="Tr4">
                                                <td align="left" colspan="3" nowrap="nowrap">
                                                    <asp:RegularExpressionValidator ID="Expr_valida" runat="server" ControlToValidate="texto_Busqueda"
                                                        ErrorMessage="SE ACEPTAN SÓLO NUMEROS EN EL TEXTO DE BUSQUEDA!" ValidationExpression="^([0-9]{1,18})$" Font-Names="Arial" CssClass="ErrorMessage"></asp:RegularExpressionValidator></td>
                                            </tr>
                                            <tr runat="server" id="Tr5">
                                                <td align="left" colspan="3" nowrap="nowrap">
                                                    <asp:Label ID="lb_mensaje_busqueda" runat="server" ForeColor="Red" Font-Names="Arial" CssClass="ErrorMessage"></asp:Label></td>
                                            </tr>
                                        </table>
                    <table id="Table1" align="center" border="0" cellspacing="0" class="WebPartShadow" style="width: 760px">
                        <tr id="Tr8" runat="server">
                        </tr>
                        <tr runat="server">
                            <td align="right" nowrap="nowrap" style="width: 165px">
                                <h2>Nombre Cliente:&nbsp;</h2>
                            </td>
                            <td colspan="3" align="left">
                                <asp:TextBox ID="txt_nomCliente" runat="server" CssClass="TextBox4" ReadOnly="True" Width="510px"></asp:TextBox></td>
                        </tr>
                        <tr id="Tr9" runat="server">
                            <td align="right" nowrap="nowrap" style="width: 165px">
                            <h2>
                                                        &nbsp;Dirección:&nbsp;</h2></td>
                            <td colspan="3" align="left">
                                <asp:TextBox ID="txt_Direccion" runat="server" CssClass="TextBox4" ReadOnly="True" Width="510px" Height="30px" TextMode="MultiLine"></asp:TextBox></td>
                        </tr>
                        <tr id="Tr10" runat="server">
                            <td align="right" nowrap="nowrap" style="height: 20px; width: 165px;">
                                <h2>
                                                        Medidor:&nbsp;
                                </h2>
                            </td>
                            <td align="left" nowrap="nowrap" style="width: 122px">
                                <asp:TextBox ID="txt_medidor" runat="server" CssClass="TextBox" ReadOnly="True" Width="135px"></asp:TextBox></td>
                            <td align="right" style="width: 78px; height: 20px">
                                <h2 style="text-align: right">Marca:</h2>
                            </td>
                            <td style="width: 169px" align="left">
                                <asp:TextBox ID="txt_marca_medidor" runat="server" CssClass="TextBox" ReadOnly="True"
                                    Width="161px"></asp:TextBox></td>
                        </tr>
                        <tr id="Tr14" runat="server">
                            <td align="right" nowrap="nowrap" style="height: 22px; width: 165px;">
                                <h2>
                                    Diametro:&nbsp;
                                </h2>
                            </td>
                            <td align="left" nowrap="nowrap" style="width: 122px">
                                <asp:TextBox ID="txt_diametro_medidor" runat="server" CssClass="TextBox" ReadOnly="True"
                                    Width="135px"></asp:TextBox></td>
                            <td align="right" style="width: 78px; height: 22px">
                                <h2 style="text-align: right">
                                                        Localidad:</h2>
                            </td>
                            <td style="width: 169px" align="left">
                                <asp:TextBox ID="txt_localidad" runat="server" CssClass="TextBox" ReadOnly="True"
                                    Width="161px"></asp:TextBox></td>
                        </tr>
                        <tr id="Tr15" runat="server">
                            <td align="right" nowrap="nowrap" style="height: 20px; width: 165px;">
                                <h2>
                                                        Orden Ruta:&nbsp;
                                </h2>
                            </td>
                            <td align="left" nowrap="nowrap" style="width: 122px">
                                <asp:TextBox ID="txt_ordenRuta" runat="server" CssClass="TextBox" ReadOnly="True"
                                    Width="135px"></asp:TextBox></td>
                            <td align="right" style="width: 78px">
                                <h2 style="text-align: right">
                                    Ruta:</h2>
                            </td>
                            <td style="width: 169px" align="left">
                                <asp:TextBox ID="txt_ruta" runat="server" CssClass="TextBox" ReadOnly="True" Width="161px"></asp:TextBox></td>
                        </tr>
                        <tr id="Tr16" runat="server">
                            <td align="right" nowrap="nowrap" style="height: 32px; width: 165px;">
                                <h2>
                                    &nbsp;
                                </h2>
                            </td>
                            <td nowrap="nowrap" style="height: 32px; width: 122px;">
                            </td>
                            <td style="height: 32px; width: 78px;">
                            </td>
                            <td style="width: 169px; height: 32px;" align="right">
                    <asp:Button ID="btnVolver" runat="server" CssClass="botonnew" Text="<< Volver " CausesValidation="False" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    
    </div>
        <table border="0" cellspacing="0" style="text-align:center; width:1163px;" class="WebPartShadow_seguimiento">
            <tr>
                <td style="text-align:center;" colspan="2" align="center">                                                                                                                
                                                <asp:DataGrid ID="GrillaHistorica" runat="server" AutoGenerateColumns="False" BorderStyle="Solid" CellPadding="1" CellSpacing="1"
                                                    CssClass="GridAlternativeItems" GridLines="None" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Width="1129px" >
                                                    <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="False" Font-Italic="False"
                                                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                                                        VerticalAlign="Middle" Wrap="False" />
                                                    <AlternatingItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                                    <ItemStyle BackColor="White" HorizontalAlign="Center" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle BackColor="CornflowerBlue" BorderColor="Black" Font-Bold="True" Font-Underline="True"
                                                        ForeColor="White" HorizontalAlign="Center" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Wrap="False" />
                                                    <Columns>
                                                        <asp:BoundColumn DataField="TIPO_ORDEN" HeaderText="Tipo Orden">
                                                            <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="True" Wrap="False" Width="4%" />
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="ID_SERVICIO" HeaderText="Nro Cliente">
                                                            <HeaderStyle Width="5%" Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" Wrap="False" />
                                                            <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="NRO_ORDEN" HeaderText="Nro Orden">
                                                            <HeaderStyle Width="7%" Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" Wrap="False" />
                                                            <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="FECHA_GENERACION" HeaderText="Fecha Generaci&#243;n">
                                                            <HeaderStyle Width="4%" />                                                          
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="FECHA_ASIGNACION" HeaderText="Fecha Asignaci&#243;n">
                                                            <HeaderStyle Width="4%" />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="FECHA_EJECUCION" HeaderText="Fecha Ejecuci&#243;n">
                                                            <HeaderStyle Width="6%"  />                                                            
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="TIPO_RESPUESTA" HeaderText="Tipo">
                                                            <HeaderStyle Width="11%" Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" Wrap="False" />
                                                            <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="RESPUESTA" HeaderText="Resultado">
                                                            <HeaderStyle Width="11%" Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" Wrap="False" />
                                                            <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="CORTADOR" HeaderText="Operador (Cod)">
                                                            <HeaderStyle Width="16%" Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" Wrap="False" />
                                                            <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="OBSERVACION" HeaderText="Observaci&#243;n">
                                                            <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="True" Wrap="False" Width="8%" />
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="GRUPO_PROCESO" HeaderText="Grupo Proceso">
                                                            <HeaderStyle Width="5%" />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="TIPO_PROCESO" HeaderText="Tipo Proceso">
                                                            <HeaderStyle Width="6%" Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" Wrap="False" />
                                                            <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        
                                                        <asp:BoundColumn DataField="NUM_SELLO" HeaderText="Nro Sello">
                                                            <HeaderStyle Width="5%" />
                                                        </asp:BoundColumn>
                                                        
                                                        <asp:BoundColumn DataField="LECTURA" HeaderText="Lectura">
                                                            <HeaderStyle Width="5%" />
                                                        </asp:BoundColumn>
                                                        
                                                        <asp:BoundColumn DataField="DEUDA" HeaderText="Deuda">
                                                            <HeaderStyle Width="5%" />
                                                        </asp:BoundColumn>
                                                        
                                                        <asp:BoundColumn DataField="TIPO_INGRESO" HeaderText="Tipo Ingreso">
                                                            <HeaderStyle Width="5%" />
                                                        </asp:BoundColumn>
                                                        
                                                        <asp:TemplateColumn HeaderText="Fotograf&#237;a">
                                                            <ItemTemplate>
                                                                <img id="btnDetalles" runat="server" src="fotos/camera_48.png" style="height: 24px" />
                                                                <asp:Image ID="img_error" runat="server" Height="24px" ImageUrl="fotos/cross_48.png" />
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="2%" />
                                                        </asp:TemplateColumn>
                                                        
                                                        <asp:BoundColumn DataField="ESTADO" HeaderText="Estado OT">
                                                            <HeaderStyle Width="6%" />
                                                        </asp:BoundColumn>
                                                        
                                                        <asp:TemplateColumn HeaderText="VISITAS">
                                                            <ItemTemplate>
                                                                <img id="btnVerVisitas" runat="server" alt="" class="Label" src="fotos/lupa.png" />
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:BoundColumn DataField="cod_localidad" HeaderText="cod_localidad" Visible="False"></asp:BoundColumn>
                                                        <asp:BoundColumn DataField="ID_TIPOORDEN" HeaderText="ID_TIPOORDEN" Visible="False"></asp:BoundColumn>
                                                    </Columns>
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <EditItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <SelectedItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:DataGrid></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: right">
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="2" style="height: 17px">
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
