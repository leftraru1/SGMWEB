<%@ Page Language="VB" AutoEventWireup="false" CodeFile="GestionHistorica_analisis.aspx.vb" Inherits="GestionHistorica_analisis" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Gestión de Lecturas Históricas - Sistema CYR</title>
    <link type="text/css" rel="stylesheet" href="estilos/page.css">
      <link type="text/css" rel="stylesheet" href="estilos/controls.css">
      <link type="text/css" rel="stylesheet" href="estilos/grid.css">
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css">
      <link type="text/css" rel="stylesheet" href="estilos/menu.css">
      <link type="text/css" rel="stylesheet" href="estilos/others.css">
      <script language="javascript">
      
                    window.onload = detectarCarga;
function detectarCarga(){
document.getElementById("imgLOAD").style.display="none";
}

      
      
      function PopDetalles(p_id_grupoproceso,p_id_servicio)      
       {
       
       var url = 'popdetalleshistoricos_analisis.aspx?idServicio='+p_id_servicio+'&idGrupoproceso='+p_id_grupoproceso;
       open(url,'DetalleLectura','top=20,left=100,width=690,height=480,status=yes,resizable=no');
      
       }            
      </script> 
</head>
<body>


<div id='imgLOAD' style="TEXT-ALIGN: center">
<b> CARGANDO </b>
<IMG src="http://i151.photobucket.com/albums/s137/andrewmusic1/loading.gif" style="width: 256px; height: 16px">
</div>

    <form id="form1" runat="server">
    <div style="text-align: center">
        <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 936px;
            height: 1px">
            <tr>
                <td style="width: 732px; height: 13px; text-align: left;">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 732px">
                    <div class="WebPartShadow_historicos" style="width: 888px">
                        <div id="titulo_mod" runat="server" class="WebPartTitle">
                            Gestión de Lecturas Históricas</div>
                        <table id="tbl_inicio" runat="server" align="center" border="0" cellpadding="0" cellspacing="0"
                            style="width: 888px; height: 52px">
                            <tr>
                                <td align="left" style="width: 732px; height: 400px">
                                    <div class="WebPartShadow">
                                        <table id="Table2" runat="server" align="center" border="0" cellspacing="0" onclick="return Table2_onclick()"
                                            style="width: 680px; height: 1px">
                                            <tr id="Tr6" runat="server">
                                                <td align="left" colspan="4" nowrap="nowrap">
                                                    <h2>
                                                        Seleccione el criterio de búsqueda:</h2>
                                                </td>
                                            </tr>
                                            <tr id="Tr7" runat="server">
                                                <td align="right" nowrap="nowrap" style="width: 117px; height: 2px">
                                                    <h2>
                                                        &nbsp;&nbsp;</h2>
                                                </td>
                                                <td style="width: 218px; height: 2px">
                                                    <asp:RadioButtonList ID="Rd_tipo_Busqueda" runat="server" RepeatDirection="Horizontal"
                                                        Width="190px">
                                                        <asp:ListItem Value="1" Selected="True">ID SERVICIO</asp:ListItem>
                                                    </asp:RadioButtonList></td>
                                                <td align="right" style="width: 71px; color: #000000; height: 2px">
                                                    <h2>
                                                        <asp:Label ID="lb_busca" runat="server"></asp:Label>&nbsp;</h2>
                                                </td>
                                                <td style="height: 2px">
                                                    <asp:TextBox ID="texto_Busqueda" runat="server" CssClass="TextBox" Width="135px"></asp:TextBox><asp:RequiredFieldValidator
                                                        ID="RequiredFieldValidator1" runat="server" ControlToValidate="texto_Busqueda"
                                                        Display="Dynamic" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                    <asp:LinkButton ID="lk_VerRegistro" runat="server" Font-Bold="True" ForeColor="#0000C0">VER CLIENTE</asp:LinkButton></td>
                                            </tr>
                                            <tr runat="server">
                                                <td align="left" colspan="4" nowrap="nowrap">
                                                    <asp:RegularExpressionValidator ID="Expr_valida" runat="server" ControlToValidate="texto_Busqueda"
                                                        ErrorMessage="SE ACEPTAN SÓLO NUMEROS EN EL TEXTO DE BUSQUEDA!" ValidationExpression="^([0-9]{1,18})$" Font-Names="Arial"></asp:RegularExpressionValidator></td>
                                            </tr>
                                            <tr runat="server">
                                                <td align="left" colspan="4" nowrap="nowrap">
                                                    <asp:Label ID="lb_mensaje_busqueda" runat="server" ForeColor="Red" Font-Names="Arial"></asp:Label></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="WebPartShadow" style="text-align: center">
                                        <table id="Table3" align="center" border="0" cellspacing="0" style="width: 680px;
                                            height: 1px">
                                            <tr id="Tr1" runat="server">
                                                <td align="right" colspan="1" nowrap="nowrap" style="height: 20px">
                                                    <h2>
                                                        &nbsp;Nombre Cliente: &nbsp;
                                                    </h2>
                                                </td>
                                                <td align="left" colspan="3" nowrap="nowrap" style="height: 20px">
                                                    <asp:TextBox ID="txt_nomCliente" runat="server" CssClass="TextBox" Width="424px" ReadOnly="True"></asp:TextBox></td>
                                            </tr>
                                            <tr id="Tr2" runat="server">
                                                <td align="right" colspan="1" nowrap="nowrap" style="height: 20px">
                                                    <h2>
                                                        &nbsp;Dirección: &nbsp;
                                                    </h2>
                                                </td>
                                                <td align="left" colspan="3" nowrap="nowrap" style="height: 20px">
                                                    <asp:TextBox ID="txt_Direccion" runat="server" CssClass="TextBox" Width="424px" ReadOnly="True"></asp:TextBox></td>
                                            </tr>
                                            <tr id="Tr11" runat="server">
                                                <td align="right" nowrap="nowrap" style="width: 117px; height: 20px">
                                                    <h2>
                                                        Medidor: &nbsp;</h2>
                                                </td>
                                                <td align="left" nowrap="nowrap" style="width: 218px; height: 20px;">
                                                    <asp:TextBox ID="txt_medidor" runat="server" CssClass="TextBox" Width="135px" ReadOnly="True"></asp:TextBox></td>
                                                <td align="right" style="width: 69px; height: 20px;">
                                                    <h2>
                                                        Marca: &nbsp;</h2>
                                                </td>
                                                <td style="height: 20px">
                                                    <asp:TextBox ID="txt_marca_medidor" runat="server" CssClass="TextBox" Width="135px" ReadOnly="True"></asp:TextBox></td>
                                            </tr>
                                            <tr id="Tr12" runat="server">
                                                <td align="right" nowrap="nowrap" style="width: 117px; height: 22px">
                                                    <h2>
                                                        Diámetro medidor: &nbsp;</h2>
                                                </td>
                                                <td align="left" nowrap="nowrap" style="width: 218px; height: 22px;">
                                                    <asp:TextBox ID="txt_diametro_medidor" runat="server" CssClass="TextBox" Width="135px" ReadOnly="True"></asp:TextBox></td>
                                                <td align="right" style="width: 69px; height: 22px;">
                                                    <h2>
                                                        Localidad:&nbsp;
                                                    </h2>
                                                </td>
                                                <td style="height: 22px">
                                                    <asp:TextBox ID="txt_localidad" runat="server" CssClass="TextBox" Width="135px" ReadOnly="True"></asp:TextBox></td>
                                            </tr>
                                            <tr id="Tr13" runat="server">
                                                <td align="right" nowrap="nowrap" style="width: 117px; height: 20px">
                                                    <h2>
                                                        Tipo Cliente: &nbsp;</h2>
                                                </td>
                                                <td align="left" nowrap="nowrap" style="width: 218px">
                                                    <asp:TextBox ID="txt_TipoCliente" runat="server" CssClass="TextBox" Width="135px" ReadOnly="True"></asp:TextBox></td>
                                                <td align="right" style="width: 69px">
                                                    <h2>
                                                        Ruta:&nbsp;
                                                    </h2>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_ruta" runat="server" CssClass="TextBox" Width="135px" ReadOnly="True"></asp:TextBox></td>
                                            </tr>
                                            <tr id="Tr3" runat="server">
                                                <td align="right" nowrap="nowrap" style="width: 117px; height: 20px">
                                                    <h2>
                                                        Orden Ruta:&nbsp;
                                                    </h2>
                                                </td>
                                                <td align="left" nowrap="nowrap" style="width: 218px">
                                                    <asp:TextBox ID="txt_ordenRuta" runat="server" CssClass="TextBox" Width="135px" ReadOnly="True"></asp:TextBox></td>
                                                <td style="width: 69px">
                                                </td>
                                                <td>
                                                    <asp:Label ID="lb_rut_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div id="Div2" runat="server" class="WebPartTitle" style="text-align: center">
                                        &nbsp;</div>
                                    <table id="TABLE1" align="center" border="0" cellspacing="0" style="width: 683px;
                                        height: 1px">
                                        <tr id="Tr15" runat="server">
                                            <td align="center" colspan="4" nowrap="nowrap" style="width: 153px; height: 30px">                                              
                                                <asp:DataGrid ID="GrillaHistorica" runat="server" AutoGenerateColumns="False"
                                                    BorderColor="#003366" BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1"
                                                    CssClass="GridAlternativeItems" ForeColor="Black" GridLines="Horizontal" Height="1px"
                                                    Width="784px">
                                                    <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                                                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                                                        VerticalAlign="Middle" />
                                                    <AlternatingItemStyle BackColor="White" />
                                                    <ItemStyle BackColor="White" HorizontalAlign="Center" />
                                                    <HeaderStyle BackColor="CornflowerBlue" BorderColor="Black" Font-Bold="True" Font-Underline="True"
                                                        ForeColor="White" HorizontalAlign="Center" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" />
                                                    <Columns>
                                                        <asp:BoundColumn DataField="id_grupoproceso" HeaderText="Id Grupoproceso" Visible="False">
                                                            <HeaderStyle Width="1%" />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="id_servicio" HeaderText="Id Servicio">
                                                            <HeaderStyle Width="10%" />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="lote" HeaderText="Grupo-Proceso">
                                                            <HeaderStyle Width="10%" />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="fecha" HeaderText="Fecha / Hora">
                                                            <HeaderStyle Width="14%" />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="clave_lectura" HeaderText="Clave Lectura">
                                                            <HeaderStyle Width="17%" />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="clave_obs" HeaderText="Clave Observaci&#243;n">
                                                            <HeaderStyle Width="20%" />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="lectura" HeaderText="Lectura">
                                                            <HeaderStyle Width="8%" />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="lector" HeaderText="Lector">
                                                            <HeaderStyle Width="25%" />
                                                        </asp:BoundColumn>
                                                        <asp:TemplateColumn HeaderText="Detalles">
                                                            <ItemTemplate>
                                                                <img src="fotos/hoja.gif" id="btnDetalles" runat="server"/>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="5%" />
                                                        </asp:TemplateColumn>
                                                    </Columns>
                                                </asp:DataGrid></td>                                           
                                        </tr>
                                        <tr>
                                            <td align="right" colspan="4" style="height: 22px">
                                                <input id="Button2" class="Button" onclick="history.go(-1)" style="width: 112px"
                                                    type="button" value="Atrás" />
                                                &nbsp;<asp:Button ID="btnVolver" runat="server" CssClass="Button" Text="<< Volver Menu"
                                                    Width="120px" CausesValidation="False" /></td>
                                        </tr>
                                    </table>
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
