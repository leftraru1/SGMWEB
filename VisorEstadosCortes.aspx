<%@ Page Language="VB" AutoEventWireup="false" CodeFile="VisorEstadosCortes.aspx.vb" Inherits="VisorEstadosCortes" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Visor Estados de Cortes - Sistema CYR</title>
     <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/others.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/style.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/style.css"/>  
      
<%--<script type="text/javascript" language="JavaScript1.2">
window.open ("VisorEstadosCortes.aspx",status=no,resizable=no,scrollbars=yes,toolbar=yes,fullscreen=yes)
</script>--%>

<%--
<style type="text/css">
body {
margin:0;
width: 100%;
height: 100%;
</style>   
--%>

<%--<script type="text/javascript" language="JavaScript1.2">
window.moveTo(0,0);
top.window.resizeTo(screen.availWidth,screen.availHeight);
</script>  --%>
  <link type="text/css" href="estilos/jquery-ui.css" rel="stylesheet" />
  <script type="text/javascript" src="js/jquery.min.js"></script>
  <script type="text/javascript" src="js/jquery-ui.min.js"></script>
  <script src="js/AyudaVisor.js" type="text/javascript"></script>
  <script type="text/javascript">
    $(document).ready(function () {
      var $dialogD;      
      PageInitD();
    });   
  </script>
          
<script type="text/javascript" language="javascript">    

     function imprimir()
      {
        //var url = 'POPLectores.aspx?textbox=' + obj;
       // alert();
       window.print();
        //window.open(url,'cal','width=820,height=320,left=200,top=50,resizable=0,scrollbars=yes');
      }    
function Table1_onclick() {

}

   </script>
</head>
<body> 


    <form id="form1" name="form1" runat="server" method="post" action="">
    <div style="text-align: left">
    
    </div>
        <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 63px;
            height: 1px">
            <tr>
                <td>
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr style="font-family: Times New Roman">
                <td style="width: 732px">
                        <table align="center" border="0" cellspacing="0" class="WebPartShadow">
                            <tr id="Tr1" runat="server">
                                <td align="left" colspan="2" nowrap="nowrap" style="width: 100%; height: 15px">
                                    <div id="Div1" runat="server" class="WebPartTitle_ext">
                            Visor Estados de Cortes</div>
                                </td>
                            </tr>
                            <tr id="Tr2" runat="server">
                                <td align="left" colspan="2" nowrap="nowrap" style="width: 100%; height: 15px">
                                    <h2>
                                        Introduzca los valores deseados y oprima "BUSCAR"</h2>
                                </td>
                            </tr>
                            <tr id="Tr3" runat="server">
                                <td style="height: 15px; width:40%; text-align:right;">
                                    <h2>
                                        Proceso:&nbsp;</h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 418px; height: 15px">
                                    <asp:DropDownList ID="combo_lotes" runat="server" CssClass="ComboBox2" AutoPostBack="True">
                                    </asp:DropDownList>
                                    <asp:Label ID="lb_codigos_contratistas" runat="server"></asp:Label></td>
                            </tr>
                            <tr runat="server" id="Tr4">
                                <td align="right" nowrap="nowrap">
                                   <h2 style="text-align: right">Zonas:&nbsp;</h2> 
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 418px;">
                                    <asp:DropDownList ID="Combozonas" runat="server" AutoPostBack="True" CssClass="ComboBox2">
                                    </asp:DropDownList>
                                    <asp:Label ID="lb_cantidad_contratistas" runat="server"></asp:Label></td>
                            </tr>
                            <tr id="Tr8" runat="server">
                                <td align="right" nowrap="nowrap" style="height: 15px;">
                                    <h2 style="text-align: right">
                                        Localidad:&nbsp;</h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 418px; height: 15px">
                                    <asp:DropDownList ID="combo_localidades" runat="server" CssClass="ComboBox2" AutoPostBack="True">
                                    </asp:DropDownList></td>
                            </tr>
                            <tr id="Tr5" runat="server">
                                <td align="right" nowrap="nowrap" style="height: 9px;">
                                    <h2 style="text-align: right">
                                        Estado Asignación:&nbsp;</h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 418px; height: 9px">
                                    <asp:DropDownList ID="combo_estados" runat="server" CssClass="ComboBox2" AutoPostBack="True">
                                        <asp:ListItem Selected="True" Value="0">Todos...</asp:ListItem>
                                        <asp:ListItem Value="1">Recepcionado</asp:ListItem>
                                        <asp:ListItem Value="2">Asignado (En espera PDA)</asp:ListItem>
                                        <asp:ListItem Value="3">Asignaci&#243;n Liberada</asp:ListItem>
                                        <asp:ListItem Value="4">Cargado en PDA</asp:ListItem>
                                        <asp:ListItem Value="5">Descargado PDA</asp:ListItem>
                                        <asp:ListItem Value="6">Proceso Cerrado Parcial</asp:ListItem>
                                    </asp:DropDownList></td>
                            </tr>
                            <tr id="Tr6" runat="server">
                                <td align="right" nowrap="nowrap" style="height: 9px;">
                                    <h2 style="text-align: right">
                                        Ruta:&nbsp;</h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 418px; height: 9px">
                                    <asp:DropDownList ID="combo_rutas" runat="server" CssClass="ComboBox2" AutoPostBack="True">
                                    </asp:DropDownList></td>
                            </tr>
                            <tr>
                                <td align="left" colspan="2" style="height: 3px">
                                    &nbsp;&nbsp;
                                    <img id="btnDialog2" alt="" onmouseout="OcultarTipoGestion()"
                                        onmouseover="MostrarTipoGestion()" src="fotos/icono_ayuda2.gif" />
                                    <asp:Button ID="btn_mesagge" runat="server" Text="Enviar Mensaje" Visible="False" CssClass="botonnew" />
                                    <asp:Label ID="lb_nom_usuario" runat="server" Text="lb_nom_usuario" CssClass="Label"></asp:Label>
                                    <asp:Label ID="lb_id_perfil" runat="server" Text="lb_id_perfil" CssClass="Label"></asp:Label>
                                    <asp:Label ID="lb_id_usuario" runat="server" Text="lb_id_usuario" CssClass="Label"></asp:Label>
                                    &nbsp;<asp:Label ID="lb_rut_empresa" runat="server" CssClass="Label"></asp:Label>
                                    <asp:Button ID="btnFiltra" runat="server" CssClass="botonnew" Text="BUSCAR" />&nbsp;</td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="height: 3px; text-align: left">
                                    &nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
                                    </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="height: 3px; text-align: center">
                                    <asp:Image ID="Image1" runat="server" ImageUrl="fotos/warning.bmp" /><asp:Label ID="Label1" runat="server" CssClass="Label" Text="Orden Recepcionada"></asp:Label>&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;
                                    <asp:Image
                                        ID="Image2" runat="server" ImageUrl="fotos/reloj2.bmp" /><asp:Label ID="Label2" runat="server" CssClass="Label" Text="Orden en Proceso: Asignado, Liberado o Cargado"></asp:Label>
                                    &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;
                                    <asp:Image ID="Image3" runat="server" ImageUrl="fotos/post.bmp" /><asp:Label ID="Label3" runat="server" CssClass="Label" Text="Orden Descargada"></asp:Label></td>
                            </tr>
                        </table>
                </td>
            </tr>
        </table>
        <table id="Table2" align="center" border="0" cellspacing="0">
                                            <tr style="color: #000000">
                                            
                                                <td align="center" colspan="2" style="text-align: left" class="WebPartShadow"><div id="Div2" runat="server" class="WebPartTitle_ext">
                            Resultados...</div>
                                                    <asp:Label ID="LB_REGISTROS_GRID" runat="server" CssClass="Label"></asp:Label>
                                                    <asp:DataGrid ID="GrillaPrincipal" runat="server" AutoGenerateColumns="False"
                                                        BorderColor="#003366" BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1"
                                                        CssClass="GridAlternativeItems" ForeColor="Black" GridLines="Horizontal" Font-Overline="False">
                                                        <HeaderStyle BackColor="CornflowerBlue" BorderColor="Black" Font-Bold="True" Font-Underline="True"
                                                            ForeColor="White" HorizontalAlign="Center" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" />
                                                        <Columns>
                                                            <asp:BoundColumn DataField="id_localidad" HeaderText="IDLocalidad" Visible="False">
                                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Names="Arial" Font-Overline="False"
                                                                    Font-Size="Small" Font-Strikeout="False" Font-Underline="False" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="lote" HeaderText="Lote" Visible="False"></asp:BoundColumn>
                                                            <asp:BoundColumn DataField="cod_localidad" HeaderText="Cod Localidad">
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="nom_localidad" HeaderText="Localidad">
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="libreta" HeaderText="Ruta">
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="tipo_asignacion" HeaderText="Tipo Asignaci&#243;n">
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="datos_lector" HeaderText="Operador">
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" HorizontalAlign="Left" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="recepcionado" HeaderText="Recepcionado">
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="asignado" HeaderText="Asignado">
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="liberado" HeaderText="Liberado">
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="cargado" HeaderText="Cargado">
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="descargado" HeaderText="Descargado">
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="cerrado_parcial" HeaderText="Cerrado Parcial">
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="total" HeaderText="TOTAL">
                                                            </asp:BoundColumn>
                                                            <asp:TemplateColumn HeaderText="Estado">
                                                                <ItemTemplate>
                                                                    <asp:Image ID="ico_estado" runat="server" />
                                                                </ItemTemplate>
                                                            </asp:TemplateColumn>
                                                        </Columns>
                                                        <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                                                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                                                            VerticalAlign="Middle" />
                                                        <ItemStyle BackColor="White" HorizontalAlign="Center" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                        <AlternatingItemStyle BackColor="White" />
                                                    </asp:DataGrid>
                                                    <table runat="server" id="tbl_estadisticas">
                                                        <tr>
                                                            <td style="background-color:buttonface; width: 174px; height: 19px;" align="right">
                                                            <h2>Recepcionados:&nbsp;
                                                            </h2>
                                                            </td>
                                                            <td style="width: 50px; height: 19px;">                                                            
                                                                <asp:Label ID="txt_sum_recepcionados" runat="server" CssClass="Label"></asp:Label></td>
                                                            <td style="width: 45px; height: 19px;">                                                           
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" style="width: 174px; background-color: buttonface">
                                                            <h2>
                                                                Asignados:&nbsp;
                                                            </h2>
                                                            </td>
                                                            <td style="width: 50px">
                                                                <asp:Label ID="txt_sum_asignados" runat="server" CssClass="Label"></asp:Label></td>
                                                            <td style="width: 45px">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" style="width: 174px; background-color: buttonface; height: 9px;">
                                                             <h2>
                                                                 Liberados:&nbsp;
                                                             </h2>
                                                            </td>
                                                            <td style="width: 50px; height: 9px;">
                                                                <asp:Label ID="txt_sum_liberados" runat="server" CssClass="Label"></asp:Label></td>
                                                            <td style="width: 45px; height: 9px;">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" style="width: 174px; background-color: buttonface; height: 8px;">
                                                            <h2>
                                                                Cargados en PDA:&nbsp;
                                                             </h2>
                                                            </td>
                                                            <td style="width: 50px; height: 8px;">
                                                                <asp:Label ID="txt_sum_cargados" runat="server" CssClass="Label"></asp:Label></td>
                                                            <td style="width: 45px; height: 8px;">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" style="width: 174px; background-color: buttonface">
                                                            <h2>
                                                                Descargados en PDA:&nbsp;
                                                             </h2>
                                                            </td>
                                                            <td style="width: 50px">
                                                                <asp:Label ID="txt_sum_descargados" runat="server" CssClass="Label"></asp:Label></td>
                                                            <td style="width: 45px">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" style="width: 174px; background-color: buttonface">
                                                            <h2>
                                                                Cerrados Parcial:&nbsp;
                                                             </h2>
                                                            </td>
                                                            <td style="width: 50px">
                                                                <asp:Label ID="txt_sum_cerrados" runat="server" CssClass="Label"></asp:Label></td>
                                                            <td style="width: 45px">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" style="width: 174px; background-color: buttonface">
                                                               <h2>
                                                                TOTAL:&nbsp;
                                                             </h2>
                                                            </td>
                                                            <td style="width: 50px">
                                                                <asp:Label ID="TXT_TOTAL_FINAL" runat="server" Font-Bold="True" ForeColor="Navy" CssClass="Label"></asp:Label></td>
                                                            <td style="width: 45px">
                                                            </td>
                                                        </tr>
                                                    </table></td>
                                            </tr>
            <tr style="color: #000000">
            </tr>
                                            <tr style="color: #000000">
                                                <td align="center" colspan="2" style="text-align: right" class="WebPartShadow">
                                                    &nbsp;<asp:DropDownList ID="comboExcel" runat="server" CssClass="ComboBox" Enabled="False"
                                                    Width="141px">
                                                    <asp:ListItem>Excel 97 - 2000</asp:ListItem>
                                                    <asp:ListItem>Excel 2003 - 2007</asp:ListItem>
                                                </asp:DropDownList>
                                                                <asp:Button ID="btnGenerarExcel" runat="server" CssClass="botonnew" Text="Generar Excel" />
                                                                <input id="btn_imprime" runat="server" class="botonnew" type="button"
                                                    value="Imprimir " size="" />
                                                                <asp:Button ID="btnVolver" runat="server" CssClass="botonnew" Text="<< Volver " /></td>
                                            </tr>
                                        </table>
        <br />
        <br />
    </form>
</body>

</html>
