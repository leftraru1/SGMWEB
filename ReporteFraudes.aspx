<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ReporteFraudes.aspx.vb" Inherits="ReporteFraudes" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Informe de Clientes Fraudulentos...</title>
      <link type="text/css" rel="stylesheet" href="estilos/page.css">
      <link type="text/css" rel="stylesheet" href="estilos/controls.css">
      <link type="text/css" rel="stylesheet" href="estilos/grid.css">
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css">
      <link type="text/css" rel="stylesheet" href="estilos/menu.css">
      <link type="text/css" rel="stylesheet" href="estilos/others.css">
      <script type="text/javascript" language="javascript">    
     function imprimir()
      {       
       window.print();        
      }    
      </script> 
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table id="TABLE1" align="center" border="0" cellpadding="0" cellspacing="0" style="width: 758px;
            height: 159px" width="758">
            <tr>
                <td style="width: 799px; height: 4px">
                    &nbsp;<asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial"
                        Font-Size="X-Small" Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user"
                            runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa"
                                runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr style="font-size: 12pt; font-family: Times New Roman">
                <td style="width: 799px">
                    <div class="WebPartShadow_rep">
                        <div id="titulo_mod" runat="server" class="WebPartTitle_rep">
                            Informe de Clientes Fraudulentos</div>
                        <table align="center" border="0" cellspacing="1" style="width: 709px; height: 1px"
                            width="709">
                            <tr>
                                <td align="left" colspan="2" nowrap="nowrap" style="width: 953px; height: 1px">
                                    &nbsp;<asp:RadioButtonList ID="TABLA_CONSULTAS" runat="server" AutoPostBack="True"
                                        Font-Names="Arial" Height="17px" RepeatDirection="Horizontal" Width="299px">
                                        <asp:ListItem Value="1">HISTORICOS</asp:ListItem>
                                        <asp:ListItem Selected="True" Value="2">EN PROCESO</asp:ListItem>
                                    </asp:RadioButtonList>
                                    <table cellspacing="0" style="width: 586px">
                                        <tr>
                                            <td align="right" style="width: 50%; height: 4px">
                                                <h2>
                                                    LOTE:&nbsp;
                                                </h2>
                                            </td>
                                            <td style="width: 50%; height: 4px">
                                                <asp:DropDownList ID="combo_lotes" runat="server" AutoPostBack="True" CssClass="ComboBox"
                                                    Width="160px">
                                                </asp:DropDownList></td>
                                        </tr>
                                        <tr>
                                            &nbsp;
                                            <td align="right">
                                                <h2>
                                                    LOCALIDAD:&nbsp;
                                                </h2>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="combo_localidades" runat="server" AutoPostBack="True" CssClass="ComboBox"
                                                    Width="160px">
                                                </asp:DropDownList></td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="height: 19px">
                                                <h2>
                                                    RUTA:&nbsp;
                                                </h2>
                                            </td>
                                            <td style="height: 19px">
                                                <asp:DropDownList ID="combo_rutas" runat="server" AutoPostBack="True" CssClass="ComboBox"
                                                    Width="160px">
                                                </asp:DropDownList></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr style="color: #000000">
                                <td align="right" colspan="2" style="height: 3px; text-align: right">
                                    <input id="btn_imprime" runat="server" class="Button" style="width: 120px" type="button"
                                        value="Imprimir Reporte" />
                                    <asp:Button ID="btnExportExcel" runat="server" CssClass="Button" Text="Exportar Excel"
                                        Width="120px" />
                                    <asp:Button ID="Button1" runat="server" CssClass="Button" Text="<< Volver Menu" Width="120px" />
                                </td>
                            </tr>
                            <tr style="color: #000000">
                                <td align="right" colspan="2" style="width: 953px; height: 3px; text-align: left">
                                    &nbsp;<asp:Label ID="lbRegistros" runat="server" Width="537px"></asp:Label>
                                    <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label>
                                    &nbsp;&nbsp;<asp:DataGrid ID="GrillaFraudulentos" runat="server" AllowSorting="True"
                                        AutoGenerateColumns="False" BorderWidth="0px" CellPadding="1" CellSpacing="1"
                                        CssClass="GridAlternativeItems" GridLines="Horizontal" Height="1px" PageSize="40"
                                        Width="950px" AllowPaging="True">
                                        <EditItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" />
                                        <PagerStyle BackColor="Control" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Mode="NumericPages"
                                            NextPageText="Siguientes" PrevPageText="Anteriores" />
                                        <AlternatingItemStyle BackColor="White" />
                                        <ItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                        <Columns>
                                            <asp:BoundColumn DataField="id_servicio" HeaderText="Id. Servicio">
                                                <HeaderStyle Width="6%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="medidor" HeaderText="Medidor">
                                                <HeaderStyle Width="6%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="direccion" HeaderText="Direcci&#243;n">
                                                <HeaderStyle Width="16%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="cod_localidad" HeaderText="C&#243;digo Localidad">
                                                <HeaderStyle Width="5%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="nom_localidad" HeaderText="Nombre Localidad">
                                                <HeaderStyle Width="10%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="fecha_lectura" HeaderText="Fecha Lectura">
                                                <HeaderStyle Width="8%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="lote" HeaderText="Lote">
                                                <HeaderStyle Width="5%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="ruta" HeaderText="Ruta">
                                                <HeaderStyle Width="5%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="orden_ruta" HeaderText="Orden Ruta">
                                                <HeaderStyle Width="5%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="cod_lector" HeaderText="C&#243;digo Lector">
                                                <HeaderStyle Width="6%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="nom_lector" HeaderText="Nombre Lector">
                                                <HeaderStyle Width="14%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="observacion" HeaderText="Observacion">
                                                <HeaderStyle Width="14%" />
                                            </asp:BoundColumn>
                                        </Columns>
                                        <HeaderStyle BackColor="Control" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="True" ForeColor="Black" HorizontalAlign="Center" />
                                    </asp:DataGrid>
                                    <asp:Label ID="lb_error" runat="server" Font-Names="Arial" ForeColor="Red" Width="660px"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="width: 1100px; height: 4px">
                                    <strong>&nbsp; &nbsp;<asp:Button ID="btn_bajo_back" runat="server" CssClass="Button"
                                        Text="<< Volver Menu" Width="120px" />
                                    </strong>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="width: 953px; height: 4px">
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
