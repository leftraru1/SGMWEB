<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ReporteRutero.aspx.vb" Inherits="ReporteRutero" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Reporte de Rutas - Sistema CYR</title>
    <link type="text/css" rel="stylesheet" href="estilos/page.css">
      <link type="text/css" rel="stylesheet" href="estilos/controls.css">
      <link type="text/css" rel="stylesheet" href="estilos/grid.css">
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css">
      <link type="text/css" rel="stylesheet" href="estilos/menu.css">
      <link type="text/css" rel="stylesheet" href="estilos/others.css">
        <script type="text/javascript" language="javascript">    
     function imprimir()
      {
        //var url = 'POPLectores.aspx?textbox=' + obj;
       // alert();
       window.print();
        //window.open(url,'cal','width=820,height=320,left=200,top=50,resizable=0,scrollbars=yes');
      }    

   </script>
             
</head>
<body id="btn_imprime">
    <form id="form1" runat="server">
    
    <div>
        <table id="Table3" border="0" cellpadding="0" cellspacing="0" style="width: 688px">
            <tr>
                <td style="height: 5px">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
        </table>
        <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 750px;
            height: 1px">
            <tr>
                <td style="width: 860px; height: 1px;" align="left">
                    <div class="WebPartShadow">
                        <div id="Div1" runat="server" class="WebPartTitle">
                            Reporte de Rutas.</div>
                        <table border="0" cellpadding="0" cellspacing="0" style="width: 767px; height: 130px;" id="TABLE1">
                            <tr>
                                <td style="width: 750px; height: 126px">
                                    <div class="WebPartShadow_rep_rutero">
                                        <table align="center" border="0" cellspacing="0" style="width: 767px; height: 1px">
                                            <tr id="Tr1" runat="server">
                                                <td align="left" colspan="2" nowrap="nowrap" style="width: 41%; height: 1px">
                                                    <h2>
                                                        Introduzca los valores deseados y oprima "Filtrar"</h2>
                                                </td>
                                            </tr>
                                            <tr id="Tr2" runat="server">
                                                <td align="right" nowrap="nowrap" style="width: 226px; height: 15px">
                                                    <h2>
                                                        Lote:&nbsp;</h2>
                                                </td>
                                                <td align="left" nowrap="nowrap" style="width: 418px; height: 15px">
                                                    <asp:DropDownList ID="combo_lotes" runat="server" CssClass="ComboBox" Width="170px" AutoPostBack="True">
                                                    </asp:DropDownList></td>
                                            </tr>
                                            <tr id="Tr8" runat="server">
                                                <td align="right" nowrap="nowrap" style="width: 226px; height: 20px;">
                                                    <h2>
                                                        Localidad:&nbsp;</h2>
                                                </td>
                                                <td align="left" nowrap="nowrap" style="width: 418px; height: 20px;">
                                                    <asp:DropDownList ID="combo_localidades" runat="server" CssClass="ComboBox" Width="170px" AutoPostBack="True">
                                                    </asp:DropDownList></td>
                                            </tr>
                                            <tr id="Tr3" runat="server">
                                                <td align="right" nowrap="nowrap" style="width: 226px; height: 20px;">
                                                    <h2>
                                                        Ruta:&nbsp;</h2>
                                                </td>
                                                <td align="left" nowrap="nowrap" style="width: 418px; font-family: Times New Roman; height: 20px;">
                                                    <asp:DropDownList ID="combo_rutas" runat="server" CssClass="ComboBox" Width="170px" AutoPostBack="True">
                                                    </asp:DropDownList>
                                                    <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr style="font-family: Times New Roman">
                                                <td align="right" colspan="2" style="height: 3px">
                    <asp:Button ID="btnExportarExcel" runat="server" CssClass="Button" Text="Exportar a Excel"
                        Width="120px" />
                    <input id="btn_imprime" runat="server" type="button" value="Imprimir Reporte" style="width: 120px" class="Button" />                    
                                                    &nbsp;<asp:Button ID="btnVolver" runat="server" CssClass="Button" Text="<< Volver Menu"
                        Width="120px" CausesValidation="False" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>                                    
                                    </td>
                            </tr>
                        </table>
                        &nbsp;&nbsp;
                    </div>
                    <asp:Label ID="lbRegistros" runat="server" Font-Bold="True" Font-Names="Verdana"
                        Font-Size="X-Small" ForeColor="#003366"></asp:Label></td>
            </tr>
            <tr style="font-family: Times New Roman">            
                <td align="right" style="width: 734px; height: 67px;" runat="server" id="td_informe">
                    <table border="1" cellpadding="0" cellspacing="0" style="border-color:Black;width: 850px">
                        <tr>
                            <td>
                                <table style="width: 852px" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td colspan="2" align="center">
                                <H2>
                                    <asp:Label ID="Label1" runat="server" BackColor="Control" BorderWidth="0px" Font-Bold="True"
                                        Font-Names="Arial" ForeColor="Black" Text="INFORME RUTERO" Width="847px"></asp:Label>&nbsp;</H2></td>                          
                        </tr>
                        <tr>
                            <td style="width:50%" align="left">
                            <h2>Lote:
                                                <asp:Label ID="lbLote" runat="server" Font-Bold="True" ForeColor="Navy"></asp:Label></h2>
                                </td>
                            <td style="width:50%; color: #000000;" align="left">
                            <h2>Fecha Lectura:
                            <asp:Label ID="lbFechaLectura" runat="server" Font-Bold="True" ForeColor="Navy"></asp:Label></h2>
                                </td>
                        </tr>
                        <tr>
                            <td style="width:50%" align="left">
                            <h2>Localidad:
                            <asp:Label ID="lbLocalidad" runat="server" Font-Bold="True" ForeColor="Navy"></asp:Label></h2>
                                </td>
                            <td style="width:50%" align="left">
                            <h2>Ruta:
                            <asp:Label ID="lbRuta" runat="server" Font-Bold="True" ForeColor="Navy"></asp:Label></h2>
                                </td>
                        </tr>
                    </table>
                    <asp:DataGrid ID="GrillaReporteRutero" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                        BorderWidth="0px" CellPadding="1" CellSpacing="1" CssClass="GridAlternativeItems"
                        GridLines="Horizontal" Height="1px"
                        PageSize="6" Width="852px" ShowHeader="False">
                        <EditItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" />
                        <PagerStyle BackColor="Control" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Mode="NumericPages"
                            NextPageText="Siguientes" PrevPageText="Anteriores" />
                        <AlternatingItemStyle BackColor="White" />
                        <ItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                        <HeaderStyle BackColor="Control" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="True" ForeColor="Black" HorizontalAlign="Center" />
                        <Columns>
                            <asp:BoundColumn DataField="correlativo" HeaderText="Correlativo" Visible="False"></asp:BoundColumn>
                            <asp:TemplateColumn HeaderText="INFORME RUTERO">
                                <ItemTemplate>
                    <table id="Table5" style="width: 830px" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td align="left" colspan="4" style="width:50%">                            
                                <asp:Label ID="Label7" runat="server" Font-Names="Arial" Font-Size="X-Small" Text="Dirección:"></asp:Label>
                               <asp:Label ID="lbDireccion" runat="server" Font-Bold="False" Font-Size="X-Small"
                               ForeColor="Navy" Font-Names="Arial"></asp:Label></td>
                            <td align="left" colspan="4" style="width:50%; font-size: 9pt; color: #000000;">                            
                                <asp:Label ID="Label8" runat="server" Font-Names="Arial" Font-Size="X-Small" Text="Nombre del Cliente:"></asp:Label>
                             <asp:Label ID="lbNomcliente" runat="server" Font-Bold="False" Font-Size="X-Small"
                             ForeColor="Navy" Font-Names="Arial"></asp:Label></td>
                        </tr>
                        <tr style="font-size: 9pt; color: #000000">
                            <td align="center">                            
                                <asp:Label ID="Label5" runat="server" Font-Names="Arial" Font-Size="X-Small" Text="Nº Orden Ruta"></asp:Label></td>
                            <td align="center">                              
                                  <asp:Label ID="Label3" runat="server" Font-Names="Arial" Font-Size="X-Small" Text="Id. Servicio"></asp:Label>
                            </td>
                            <td align="center">
                                <asp:Label ID="Label2" runat="server" Font-Names="Arial" Font-Size="X-Small" Text="Medidor"></asp:Label></td>
                            <td align="center">                              
                                <asp:Label ID="Label4" runat="server" Font-Names="Arial" Font-Size="X-Small" Text="Info Instal."></asp:Label></td>
                            <td align="center" style="width:9%">                           
                                <asp:Label ID="Label9" runat="server" Font-Names="Arial" Font-Size="X-Small" Text="LECTURA"></asp:Label></td>
                            <td align="center" style="width:9%">                          
                                <asp:Label ID="Label10" runat="server" Font-Names="Arial" Font-Size="X-Small" Text="CLAVE"></asp:Label></td>
                            <td align="center" style="width:9%">                           
                                <asp:Label ID="Label11" runat="server" Font-Names="Arial" Font-Size="X-Small" Text="CLAVE OBS"></asp:Label></td>
                            <td align="center" style="width:25%">                            
                                <asp:Label ID="Label12" runat="server" Font-Names="Arial" Font-Size="X-Small" Text="Observaciones"></asp:Label></td>
                        </tr>
                        <tr>
                            <td align="center" style="width:12%; height: 16px;">
                                            <asp:Label ID="lbOrdenRuta" runat="server" Font-Size="X-Small" ForeColor="Navy" Font-Names="Arial"></asp:Label></td>
                            <td align="center" style="width:12%; height: 16px;">
                                            <asp:Label ID="lbIdServicio" runat="server" Font-Size="X-Small" ForeColor="Navy" Font-Names="Arial"></asp:Label></td>
                            <td align="center" style="width:12%; height: 16px;">
                            <asp:Label ID="lbMedidor" runat="server" Font-Size="X-Small" ForeColor="Navy" Font-Names="Arial"></asp:Label></td>
                            <td align="center" style="width:12%; height: 16px;">
                                            <asp:Label ID="Label6" runat="server" Font-Size="X-Small" ForeColor="Navy" Font-Names="Arial"></asp:Label></td>
                            <td style="height: 16px">
                            </td>
                            <td style="height: 16px">
                            </td>
                            <td style="height: 16px">
                            </td>
                            <td style="height: 16px">
                            </td>
                        </tr>
                    </table>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                        </Columns>
                    </asp:DataGrid></td>
                        </tr>
                    </table>
                    &nbsp;
                </td>
            </tr>
            <tr style="font-family: Times New Roman">
                <td align="right" style="width: 860px; height: 20px;">                &nbsp;<asp:Button ID="btnVolver2" runat="server" CssClass="Button" Text="<< Volver Menu"
                        Width="120px" CausesValidation="False" /></td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
