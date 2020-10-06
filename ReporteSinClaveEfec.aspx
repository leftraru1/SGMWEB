<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ReporteSinClaveEfec.aspx.vb" Inherits="ReporteSinClaveEfec" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Reporte sin Clave Efectiva - Sistema CYR</title>
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
<body>
    <form id="form1" runat="server">
    <div>
        <table id="Table3" border="0" cellpadding="0" cellspacing="0" style="width: 688px; height: 12px;">
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
        <table id="tbl_inicio" runat="server" align="center" border="0" cellpadding="0" cellspacing="0"
            style="width: 650px; height: 1px">
            <tr>
                <td style="width: 834px; height: 1px;" align="left">
                    <div class="WebPartShadow">
                        <div id="Div2" runat="server" class="WebPartTitle" style="width: 789px;">
                            Reporte sin Clave Efectiva.</div>
                        <table align="center" border="0" cellspacing="0" style="width: 779px; height: 1px" id="TABLE1">
                            <tr runat="server">
                                <td align="left" nowrap="nowrap" style="width: 134px; height: 8px">
                                    </td>
                                    <td  style="width: 218px; height: 8px">
                                    </td>
                                    <td style="width: 117px; height: 8px">
                                    </td>
                                    <td style="width: 260px; height: 8px">
                                    </td>
                            </tr>
                            <tr id="Tr1" runat="server">
                                <td align="left" colspan="4" nowrap="nowrap">
                                    <h2>
                                        Seleccione los valores a filtrar para la generación del Reporte.</h2>
                                </td>
                            </tr>
                            <tr runat="server">
                                <td align="left" nowrap="nowrap" style="width: 134px; height: 9px">
                                </td>
                                <td style="width: 218px; height: 9px">
                                    </td>
                                    <td style="width: 117px; height: 9px">
                                    </td>
                                    <td style="height: 9px; width: 260px;">
                                    </td>
                            </tr>
                            <tr id="Tr2" runat="server">
                                <td align="right" nowrap="nowrap" style="width: 134px; height: 32px">
                                    <h2>
                                        &nbsp;Lote: &nbsp;
                                    </h2>
                                </td>
                                <td align="left" colspan="1" nowrap="nowrap" style="height: 32px; width: 218px;">
                                    <asp:DropDownList ID="combo_lotes" runat="server" CssClass="ComboBox" Width="170px" AutoPostBack="True">
                                    </asp:DropDownList></td>
                                      <td align="right" style="height: 32px; width: 117px;">
                                          <h2>
                                        Clave Lectura: &nbsp;</h2>
                                          </td>
                                      <td style="height: 32px; width: 260px;" align="left">
                                    <asp:DropDownList ID="combo_clavesLectura" runat="server" CssClass="ComboBox" Width="170px" AutoPostBack="True">
                                    </asp:DropDownList></td>                                    
                            </tr>
                            <tr id="Tr8" runat="server">
                                <td align="right" nowrap="nowrap" style="width: 134px; height: 30px">
                                    <h2>
                                        Localidad: &nbsp;</h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 218px">
                                    <asp:DropDownList ID="combo_localidades" runat="server" CssClass="ComboBox" Width="170px" AutoPostBack="True">
                                    </asp:DropDownList>
                                </td>
                                <td align="right" style="width: 117px">
                                   <h2>
                                       Ruta: &nbsp;</h2>
                                  </td>                                                                               
                                    <td style="width: 260px" align="left">
                                        <asp:DropDownList ID="combo_rutas" runat="server" CssClass="ComboBox" Width="170px" AutoPostBack="True">
                                        </asp:DropDownList></td>
                            </tr>
                            <tr id="Tr10" runat="server">
                                <td align="right" nowrap="nowrap" style="width: 134px; height: 30px">
                                    <h2>
                                        Lector: &nbsp;</h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 218px">
                                          <asp:DropDownList ID="combo_lectores" runat="server" CssClass="ComboBox" Width="170px" AutoPostBack="True">
                                          </asp:DropDownList></td>
                                    <td style="width: 117px">
                                    </td>
                                    <td style="width: 260px">
                                        <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label>
                                    <asp:Button ID="btnFiltrar" runat="server" CssClass="Button" Text="Filtrar" Width="120px" /></td>
                            </tr>
                            <tr>
                                <td align="right" colspan="4">
                                    &nbsp;<asp:Button ID="btnGenerarExcel" runat="server" CssClass="Button" Text="Exportar a Excel" Width="120px" />
                                    <input id="btn_imprime" runat="server" class="Button" style="width: 120px" type="button"
                        value="Imprimir Reporte" />
                    <asp:Button ID="btnvolver" runat="server" CssClass="Button" Text="<< Volver Menu" Width="120px" /></td>
                            </tr>
                        </table>
                    </div>
                    <asp:Label ID="lb_cont_registros" runat="server" Font-Bold="True" Font-Names="Verdana"
                        Font-Size="X-Small" ForeColor="#003366"></asp:Label><asp:DataGrid ID="GrillaSinClavesEfectiva" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                        BorderWidth="0px" CellPadding="1" CellSpacing="1" CssClass="GridAlternativeItems"
                        GridLines="Horizontal" Height="1px" PageSize="6" Width="834px">
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
                            <asp:BoundColumn DataField="lote" HeaderText="GRUPO" Visible="False"></asp:BoundColumn>
                            <asp:BoundColumn DataField="cod_localidad" HeaderText="Cod. Localidad">
                                <HeaderStyle Width="10%" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="libreta" HeaderText="Ruta">
                                <HeaderStyle Width="7%" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="orden_ruta" HeaderText="Orden Ruta">
                                <HeaderStyle Width="10%" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="medidor" HeaderText="Medidor">
                                <HeaderStyle Width="10%" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="id_servicio" HeaderText="Id. Servicio">
                                <HeaderStyle Width="10%" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="direccion" HeaderText="Direcci&#243;n">
                                <HeaderStyle Width="21%" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="nombre" HeaderText="Nombre">
                                <HeaderStyle Width="18%" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="cod_clave_lecturapda" HeaderText="Cod Clave PDA" Visible="False">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="descripcion" HeaderText="Descripcion">
                                <HeaderStyle Width="14%" />
                            </asp:BoundColumn>
                        </Columns>
                    </asp:DataGrid></td>
            </tr>
            <tr>
                <td align="right" style="width: 835px; height: 1px">
                    &nbsp;</td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
