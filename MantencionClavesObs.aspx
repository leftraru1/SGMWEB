<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MantencionClavesObs.aspx.vb" Inherits="MantencionClavesObs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Mantenedor de Claves de Observación - Sistema CYR</title>
     <link type="text/css" rel="stylesheet" href="estilos/page.css">
      <link type="text/css" rel="stylesheet" href="estilos/controls.css">
      <link type="text/css" rel="stylesheet" href="estilos/grid.css">
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css">
      <link type="text/css" rel="stylesheet" href="estilos/menu.css">
      <link type="text/css" rel="stylesheet" href="estilos/others.css"> 
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 758px;
            height: 116px" width="758">
            <tr>
                <td style="width: 732px">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 732px">
                    <div class="WebPartShadow">
                        <div id="titulo_mod" runat="server" class="WebPartTitle">
                            Mantención de Claves de Observación de Lectura</div>
                        <table align="center" border="0" cellspacing="4" style="width: 709px; height: 107px"
                            width="709">
                            <tr>
                                <td align="left" colspan="2" nowrap="nowrap" style="width: 760px; height: 10px">
                                    <asp:LinkButton ID="clv_Agregar" runat="server">Agregar Clave</asp:LinkButton>&nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                                    &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp;&nbsp;
                                    <asp:LinkButton ID="btn_OpcFiltro" runat="server">Realizar Filtrado</asp:LinkButton>
                                    <hr style="width: 752px" />
                                </td>
                            </tr>
                            <tr id="Row_filtro" runat="server">                            
                                <td align="left" colspan="2" nowrap="nowrap" style="width: 760px; height: 15px">
                                    <asp:Label ID="lb_filtro" runat="server" Font-Bold="True" Font-Names="Arial"
                                        Font-Size="X-Small" Text="Seleccione Clave de Lectura" ForeColor="#000040"></asp:Label>
                                    <select id="combo_clvsLect" runat="server" class="ComboBox" style="width: 256px">
                                        <option selected="selected"></option>                                        
                                    </select>
                                    <asp:LinkButton ID="clv_filtrar" runat="server" Font-Bold="True" ForeColor="Maroon">FILTRAR</asp:LinkButton>
                                    &nbsp;
                                    <asp:LinkButton ID="btn_ocultafiltro" runat="server" Font-Bold="True" ForeColor="Maroon">OCULTAR</asp:LinkButton></td>
                            </tr>
                            <tr style="color: #000000">
                                <td align="center" colspan="2" style="width: 760px; height: 3px">
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;                              
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                                    <asp:DataGrid ID="GrillaClavesObs" runat="server" AllowPaging="True" AllowSorting="True"
                                        AutoGenerateColumns="False" CssClass="GridPager" Height="76px"
                                        OnPageIndexChanged="GrillaClavesObs_PageIndexChanged1" Width="758px" PageSize="14" BorderWidth="0px" CellPadding="1" CellSpacing="1">
                                        <HeaderStyle BackColor="Control" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" ForeColor="Black" HorizontalAlign="Center" />
                                        <Columns>
                                            <asp:BoundColumn DataField="id_claveobs" HeaderText="IDclaveObs" Visible="False">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="cod_claveobs" HeaderText="Codigo">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="id_clvlectura" HeaderText="IDCLVLectura" Visible="False">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="nombre_clv_lectura" HeaderText="Codigo Clave Lectura">
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="descripcion" HeaderText="Codigo Clave de Observaci&#243;n">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" />
                                            </asp:BoundColumn>
                                            <asp:EditCommandColumn CancelText="Cancel" EditText="Editar" UpdateText="Update" HeaderText="Modificar">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" ForeColor="#3300CC" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" />
                                            </asp:EditCommandColumn>
                                            <asp:ButtonColumn CommandName="Delete" Text="Eliminar" HeaderText="Eliminar">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" ForeColor="#3300CC" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" />
                                            </asp:ButtonColumn>
                                        </Columns>
                                        <EditItemStyle Font-Bold="False" />
                                        <PagerStyle Mode="NumericPages" NextPageText="Siguientes" PrevPageText="Anteriores" BackColor="Control" Font-Bold="True" ForeColor="Black" />
                                        <ItemStyle BackColor="White" />
                                    </asp:DataGrid></td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="width: 760px">
                                    <strong>
                                        <table id="tbl_NuevaClaveObs" runat="server" style="width: 757px">
                                            <tr>
                                                <td style="width: 12%; height: 4px">
                                                    </td>
                                                <td align="left" style="width: 35%; height: 4px" colspan="4">
                                                    &nbsp;</td>                                               
                                            </tr>
                                            <tr>
                                                <td style="width: 214px;">
                                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                    &nbsp; &nbsp; Clave de Lectura&nbsp; &nbsp; &nbsp;&nbsp;</td>
                                                <td align="left" colspan="4">
                                                    <select id="combo_CLVLecturaIng" runat="server" class="ComboBox" style="width: 200px;
                                                        height: 1px">                                                    
                                                    </select></td>
                                               
                                            </tr>
                                            <tr>
                                                <td style="width: 214px; height: 12px">
                                                    Nombre Clave de Observación</td>
                                                <td style="width: 926px; height: 12px" colspan="4" align="left">
                                                    <asp:TextBox ID="txt_nombre" runat="server" CssClass="TextBox" Width="200px"></asp:TextBox></td>                                               
                                            </tr>
                                            <tr>
                                                <td style="width: 214px; height: 12px">
                                                    Código Clave de Observación</td>
                                                <td style="width: 926px; height: 12px" colspan="4" align="left">
                                                    <asp:TextBox ID="txt_codClvObs" runat="server" CssClass="TextBox" ForeColor="ControlText"
                                                        Width="200px"></asp:TextBox></td>                                               
                                            </tr>
                                            <tr>
                                                <td style="width: 214px;">
                                                </td>
                                                <td style="width: 926px;">
                                                    </td>
                                                <td style="width: 130px;">
                                                </td>
                                                <td style="width: 247px;">
                                                </td>
                                                <td align="left" style="width: 670px;">
                                                    <asp:Button ID="btn_agregaCLV" runat="server" CssClass="Button" Text="Aceptar" />
                                                    <asp:Button ID="Btn_Cancelar" runat="server" CssClass="Button" Text="Cancelar" /></td>
                                            </tr>
                                        </table>
                                    </strong>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="width: 760px">
                                    &nbsp;</td>
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
