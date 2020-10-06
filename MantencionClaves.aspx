<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MantencionClaves.aspx.vb" Inherits="MantencionClaves" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Mantenedor de Claves de Lectura - Sistema CYR</title>
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
            height: 152px" width="758">
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
                            Mantención de Claves de Lectura</div>
                        <table align="center" border="0" cellspacing="4" style="width: 709px; height: 107px"
                            width="709">
                            <tr>
                                <td align="left" colspan="2" nowrap="nowrap" style="width: 760px; height: 15px">
                                    <asp:LinkButton ID="clv_Agregar" runat="server">Agregar Clave</asp:LinkButton>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 
                                        <asp:LinkButton ID="clv_buscar" runat="server">Buscar Clave</asp:LinkButton></td>
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
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<asp:LinkButton ID="BtnMostrar_todos" runat="server">Mostrar todos</asp:LinkButton>
                                    <asp:DataGrid OnPageIndexChanged="GrillaClavesLectura_PageIndexChanged1" ID="GrillaClavesLectura" runat="server" OnDeleteCommand="Siguientes" AutoGenerateColumns="False"
                                        CssClass="GridAlternativeItems" Height="76px" Width="699px" AllowPaging="True" PageSize="6" AllowSorting="True" BackColor="Black" BorderWidth="0px" CellPadding="1" CellSpacing="1" GridLines="Horizontal" HorizontalAlign="Center">
                                        <HeaderStyle BackColor="Control" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" ForeColor="Black" HorizontalAlign="Center" />
                                        <Columns>
                                            <asp:BoundColumn DataField="id_clvlectura" HeaderText="IDclave" Visible="False">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="cod_clvlectura" HeaderText="Codigo">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="descripcion" HeaderText="Nombre Clave">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="valida" HeaderText="VALIDA">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="atendido" HeaderText="ATENDIDO">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" />
                                            </asp:BoundColumn>
                                            <asp:EditCommandColumn CancelText="Cancel" EditText="Editar" UpdateText="Update" HeaderText="Modificar">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" ForeColor="#3300CC" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" ForeColor="#000000" />
                                            </asp:EditCommandColumn>
                                            <asp:ButtonColumn CommandName="Delete" Text="Eliminar" HeaderText="Eliminar">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" ForeColor="#3300CC" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" ForeColor="#000000" />
                                            </asp:ButtonColumn>
                                        </Columns>
                                        <EditItemStyle Font-Bold="False" />
                                        <PagerStyle NextPageText="Siguientes" PrevPageText="Anteriores" Mode="NumericPages" BackColor="Control" Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                        <AlternatingItemStyle BackColor="Honeydew" />
                                        <ItemStyle BackColor="White" />
                                    </asp:DataGrid></td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="width: 760px">
                                    <strong><table id="tbl_NuevaClave" runat="server" style="width: 710px">
                                            <tr>
                                                <td style="width: 12%; height: 4px">
                                                    Nombre Clave</td>
                                                <td align="left" style="width: 35%; height: 4px">
                                                    <asp:TextBox ID="txt_nombre" runat="server" CssClass="TextBox" Width="200px"></asp:TextBox>
                                                </td>
                                                <td style="width: 3%; height: 4px">
                                                    &nbsp;</td>
                                                <td style="width: 15%; height: 4px">
                                                    &nbsp; &nbsp; &nbsp;Código Clave</td>
                                                <td align="left" style="width: 35%; height: 4px">
                                                    <asp:TextBox ID="txt_codClv" runat="server" CssClass="TextBox" ForeColor="ControlText"
                                                        Width="200px" Enabled="False">0001</asp:TextBox></td>
                                            </tr>
                                            <tr>                                           
                                                <td style="width: 214px">
                                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Valida</td>
                                                <td  align="left" >
                                                    <select id="combo_validaCLV" runat="server" class="ComboBox" style="width: 200px;
                                                        height: 1px">
                                                        <option selected="selected" value="0">LECTURA EFECTIVA</option>
                                                        <option>CON LECTURA</option>
                                                        <option>SIN LECTURA</option>
                                                    </select></td>
                                                <td style="width: 130px">
                                                </td>
                                                <td style="width: 247px">
                                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Atendido</td>
                                                <td align="left">
                                                    <select id="combo_atendido_CLV" runat="server" class="ComboBox" style="height: 1px">
                                                        <option selected="selected">EFECTIVO</option>
                                                        <option>IMPROCEDENTE</option>
                                                    </select></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 214px; height: 12px">
                                                    </td>
                                                <td style="width: 926px; height: 12px">
                                                    &nbsp;</td>
                                                <td style="width: 130px; height: 12px">
                                                </td>
                                                <td style="width: 247px; height: 12px">
                                                    </td>
                                                <td style="width: 670px; height: 12px">
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td style="width: 214px; height: 17px">
                                                </td>
                                                <td style="width: 926px; height: 17px">
                                                </td>
                                                <td style="width: 130px; height: 17px">
                                                </td>
                                                <td style="width: 247px; height: 17px">
                                                </td>
                                                <td style="width: 670px; height: 17px" align="right">
                                                    <asp:Button ID="btn_agregaCLV" runat="server" CssClass="Button" Text="Aceptar" />
                                                    <asp:Button ID="Btn_Cancelar" runat="server" CssClass="Button" Text="Cancelar" /></td>
                                            </tr>
                                        </table>
                                    </strong></td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="width: 760px">
                                    &nbsp;</td>
                            </tr>
                        </table>
                    </div>
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="fotos/cerrar.gif" /></td>
            </tr>
        </table>
    
    </div>
                                        &nbsp;
    </form>
</body>
</html>
