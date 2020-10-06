<%@ Page Language="VB" AutoEventWireup="false" CodeFile="InformeReposFueraHorario.aspx.vb" Inherits="InformeReposFueraHorario" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">



<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Página sin título</title>
          <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/others.css"/>
      
      <link type="text/css" rel="stylesheet" href="estilos/loadingbox.css" />    
       
      <script src="js/jquery.js" type="text/javascript"></script>
      <script src="js/progress.js" type="text/javascript"></script>        
      
      
      <script type="text/javascript" language="javascript">    
       
             
       
         function openCalendar(obj)
      {
        var url = 'calendario.aspx?textbox=' + obj;
        window.open(url,'cal','width=260,height=210,left=500,top=100,resizable=0,scrollbars=0');
      }      
      


      </script>
      
</head>
<body>
    <form id="form1" runat="server">
    <img src="fotos/procesando3.gif" alt="" style="display:none;" /> 
        <table id="tbl_inicio" runat="server" align="center" border="0" cellpadding="0" cellspacing="0" >
            <tr>
                <td align="left" style="height: 9px">
                                                            <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                                                                Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                                                                    Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                                                        Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                                                            ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr>
                <td align="left" style="height: 5px">
                    <div class="WebPartShadow" style="text-align: left">
                        <div id="Div2" runat="server" class="WebPartTitle" title="Informe Reposiciones fuera de Horario.">
                            Informe Reposiciones fuera de Horario.-.
                        &nbsp;&nbsp;
                        <table id="TABLE1" border="0" cellspacing="0">
                            <tr id="Tr1" runat="server">
                                <td align="left" colspan="4" nowrap="nowrap" style="height: 11px">
                                    <h2>
                                        Seleccione los valores a filtrar para la generación del Informe .-.</h2>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="4" style="height: 10px">
                                    <table align="center" border="0" cellspacing="0" style="width: 547px; height: 8px">
                                        <tr>
                                            <td align="right" colspan="2" style="height: 3px">
                                                <table align="center" cellpadding="0">
                                                    <tr id="Tr3" runat="server">
                                                        <td align="left" class="WebPartTitle_ext" colspan="5" nowrap="nowrap" style="height: 16px">
                                                            &nbsp;&nbsp;
                                                            </td>
                                                    </tr>
                                                    <tr id="Tr5" runat="server">
                                                        <td align="right" nowrap="nowrap" style="width: 92px;">
                                                            <h2 style="text-align: right">
                                                                Zonas:
                                                            </h2>
                                                        </td>
                                                        <td align="left" nowrap="nowrap" style="width: 275px;">
                                                            <asp:DropDownList ID="Combozonas" onchange="$.showprogress()" runat="server" AutoPostBack="True" CssClass="ComboZonas"
                                                                Width="280px">
                                                            </asp:DropDownList></td>
                                                        <td align="left" nowrap="nowrap" style="width: 33px; text-align: right;">
                                                            <h2>
                                                                &nbsp;</h2>
                                                        </td>
                                                        <td align="left" nowrap="nowrap" style="text-align: right;">
                                                            <h2>
                                                                Desde:</h2>
                                                        </td>
                                                        <td align="left" nowrap="nowrap">
                                                            <asp:TextBox ID="txtFechaDesde" runat="server" AutoPostBack="True" CssClass="TextBox2"
                                                                ReadOnly="false" Width="88px"></asp:TextBox><img id="Img1" runat="server" onclick="openCalendar('txtFechaDesde');"
                                                                    src="fotos/calendario.gif" />
                                                            <asp:RegularExpressionValidator ID="validar_fecha_desde" runat="server" BackColor="Transparent"
                                                                ControlToValidate="txtFechaDesde" CssClass="ErrorMessage" ErrorMessage="RegularExpressionValidator"
                                                                Font-Bold="True" ValidationExpression="^[0-9]{2}-[0-9]{2}-[0-9]{4}$" ValidationGroup="fecha">(Error)</asp:RegularExpressionValidator>
                                                            &nbsp;<asp:CheckBox ID="Check_dia" runat="server" AutoPostBack="True" CssClass="Label"
                                                                Text="Filtrar Dia" Width="72px" />&nbsp;&nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td nowrap="nowrap" style="width: 92px;">
                                                            <h2 style="text-align: right">
                                                                Localidad:</h2>
                                                        </td>
                                                        <td align="left" nowrap="nowrap" style="width: 275px;">
                                                            <asp:DropDownList ID="combo_localidades" onchange="$.showprogress()" runat="server" AutoPostBack="True" CssClass="Combo_Localidad"
                                                                Width="280px">
                                                            </asp:DropDownList></td>
                                                        <td align="left" nowrap="nowrap" style="width: 33px; text-align: right">
                                                            <h2 style="text-align: right">
                                                                &nbsp;</h2>
                                                        </td>
                                                        <td align="left" nowrap="nowrap">
                                                            <h2 style="text-align: right">
                                                                Hasta:</h2>
                                                        </td>
                                                        <td align="left" nowrap="nowrap">
                                                            <asp:TextBox ID="txtFechaHasta" runat="server" AutoPostBack="True" CssClass="TextBox2"
                                                                ReadOnly="false" Width="88px"></asp:TextBox><img id="Img2" runat="server" onclick="openCalendar('txtFechaHasta');"
                                                                    src="fotos/calendario.gif" />
                                                            <asp:RegularExpressionValidator ID="validar_fecha_hasta" runat="server" BackColor="Transparent"
                                                                ControlToValidate="txtFechaHasta" CssClass="ErrorMessage" ErrorMessage="RegularExpressionValidator"
                                                                Font-Bold="True" ValidationExpression="^[0-9]{2}-[0-9]{2}-[0-9]{4}$" ValidationGroup="fecha">(Error)</asp:RegularExpressionValidator>&nbsp;</td>
                                                    </tr>
                                                    <tr runat="server">
                                                        <td align="right" nowrap="nowrap" style="width: 92px; height: 20px">
                                                            <h2 style="text-align: right">
                                                                Hora:</h2>
                                                        </td>
                                                        <td align="left" nowrap="nowrap" style="width: 275px; height: 20px">
                                                        
                                                            <asp:TextBox ID="txtHora" runat="server" class="TextBox" MaxLength="2" Width="41px" CssClass="TextBox"></asp:TextBox>
                                                            <asp:RegularExpressionValidator ID="RE_hora" runat="server" ControlToValidate="txtHora"
                                                                Display="Dynamic" ErrorMessage="Sólo números!" Font-Bold="True" Font-Names="Arial"
                                                                Font-Size="X-Small" ValidationExpression="^([0-9]{1,12})$"></asp:RegularExpressionValidator></td>
                                                            
                                                        <td align="left" nowrap="nowrap" style="width: 33px; height: 20px">
                                                        </td>
                                                        <td align="left" nowrap="nowrap" style="height: 20px">
                                                        </td>
                                                        <td align="left" nowrap="nowrap" style="height: 20px; text-align: right">
                                                        <asp:Button ID="btnActualizar" runat="server" CssClass="botonnew" Text="BUSCAR"
                                        Width="120px" Height="20px" OnClientClick="$.showprogress()" CausesValidation="False" />
                                                        </td>
                                                    </tr>
                                                    <tr id="Tr8" runat="server">
                                                        <td align="right" nowrap="nowrap" style="height: 20px; width: 92px;">
                                                            <h2>
                                                                &nbsp;</h2>
                                                        </td>
                                                        <td align="left" nowrap="nowrap" style="height: 20px; width: 275px;">
                                                            <asp:Label ID="Lb_Tipo_Aparato" runat="server" Visible="False"></asp:Label>
                                                            <asp:Label ID="Lb_Numerador" runat="server" Visible="False"></asp:Label></td>
                                                        <td align="left" nowrap="nowrap" style="width: 33px; height: 20px;">
                                                            <h2 style="text-align: right">
                                                                &nbsp;</h2>
                                                        </td>
                                                        <td align="left" nowrap="nowrap" style="height: 20px">
                                                            <h2 style="text-align: right">
                                                                &nbsp;</h2>
                                                        </td>
                                                        <td align="left" nowrap="nowrap" style="text-align: right; height: 20px;">
                                                            <asp:Label ID="lb_id_usuario" runat="server" Text="lb_id_usuario"></asp:Label>
                                                            <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label>
                                    &nbsp;&nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr id="Tr6" runat="server">
                                                        <td align="right" nowrap="nowrap" style="height: 10px; width: 92px;">
                                                            <h2>
                                                                &nbsp;
                                                            </h2>
                                                        </td>
                                                        <td align="left" nowrap="nowrap" style="height: 10px; width: 275px;">
                                                            <asp:Label ID="lb_nom_usuario" runat="server" Text="lb_nom_usuario" Visible="False"></asp:Label><asp:Label
                                                                ID="lb_id_perfil" runat="server" Text="lb_id_perfil" Visible="False"></asp:Label></td>
                                                        <td align="left" nowrap="nowrap" style="width: 33px; height: 10px">
                                                            <h2 style="text-align: right">
                                                                &nbsp;</h2>
                                                        </td>
                                                        <td align="left" nowrap="nowrap" style="height: 10px">
                                                            <h2 style="text-align: right">
                                                                &nbsp;</h2>
                                                        </td>
                                                        <td align="left" nowrap="nowrap" style="height: 10px; text-align: right">
                                                            <asp:Button ID="btnExportExcel" runat="server" CssClass="botonnew" Text="Exportar Excel" Width="120px" Height="20px"  />
                                                            <asp:Button ID="btnvolver" runat="server" CssClass="botonnew" Text="<< Volver Menu" Width="120px" Height="20px" />
                                                            </td>
                                                    </tr>
                                                </table>
                                                <asp:Label ID="lb_cantidad_contratistas" runat="server"></asp:Label>
                                                <asp:Label ID="lb_codigos_contratistas" runat="server"></asp:Label></td>
                                        </tr>
                                    </table>
                                    </td>
                            </tr>
                        </table>
                    </div>
                    </div>
                    <asp:Label ID="lb_valida" runat="server" CssClass="Label" Font-Names="Arial Unicode MS"
                        Font-Size="Small" ForeColor="Red" Height="18px" Width="771px"></asp:Label></td>
            </tr>
        </table>
        <table id="TABLE2" align="center" border="0" cellpadding="0" cellspacing="0" class="WebPartShadow" style="width: 752px;">
            <tr style="font-weight: bold">
                <td style="width: 879px; height: 14px">
                    <asp:Label ID="P_TOTALIZADOR" runat="server" Width="404px" Font-Names="Arial" Height="16px"></asp:Label>
                                        <asp:DataGrid ID="GrillaHorarios" runat="server" AutoGenerateColumns="False"
                                            BorderWidth="1px" CellPadding="3" CssClass="GridAlternativeItems"
                                            Height="1px" Width="801px" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" Font-Names="Arial">
                                            <PagerStyle BackColor="White" Mode="NumericPages" Visible="False" ForeColor="#000066" HorizontalAlign="Left" />
                                            <ItemStyle ForeColor="#000066" />
                                            <Columns>
                                                <asp:BoundColumn DataField="tipo_orden" HeaderText="Tipo Orden">
                                                    <HeaderStyle Width="16%" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="zona" HeaderText="Zona">
                                                    <HeaderStyle Width="18%" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="localidad" HeaderText="Localidad">
                                                    <HeaderStyle Width="20%" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="fuera_horario" HeaderText="Fuera de Horario">
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    <HeaderStyle Width="8%" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="por_fuerah" HeaderText="% Fuera H.">
                                                    <HeaderStyle Width="10%" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" HorizontalAlign="Center" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="dentro_horario" HeaderText="Dentro de Horario">
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    <HeaderStyle Width="8%" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="por_dentroh" HeaderText="% Dentro H.">
                                                    <HeaderStyle Width="10%" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" HorizontalAlign="Center" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="total" HeaderText="Total">
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    <HeaderStyle Width="5%" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="por_total" HeaderText="% Total">
                                                    <HeaderStyle Width="5%" />
                                                </asp:BoundColumn>
                                            </Columns>
                                            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                            <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                        </asp:DataGrid></td>
            </tr>
        </table>
        <table id="TablaGrafico" runat="server" align="center" border="0" cellpadding="0" cellspacing="0" class="WebPartShadow"
            style="width: 440px; height: 168px">
            <tr style="font-weight: bold">
                <td style="width: 879px; height: 14px">
                    <asp:Literal ID="FCLiteral" runat="server"></asp:Literal></td>
            </tr>
        </table>
    </form>
</body>
</html>
