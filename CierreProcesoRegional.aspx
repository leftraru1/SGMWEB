<%@ Page Language="VB" AutoEventWireup="false" CodeFile="CierreProcesoRegional.aspx.vb" Inherits="CierreProcesoRegional" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
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
        <table id="TABLE1" align="center" border="0" cellpadding="0" cellspacing="0" style="width: 758px;
            height: 118px" width="758">
            <tr>
                <td style="width: 732px; height: 11px">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 732px; height: 1px">
                    <div class="WebPartShadow">
                        <div class="WebPartTitle">
                            Cierre Regional de Proceso</div>
                        <table align="center" border="0" cellspacing="0" style="width: 709px; height: 1px"
                            width="709">
                            <tr>
                                <td align="right" nowrap="nowrap" style="width: 41%; height: 4px">
                                    <h2>
                                        &nbsp;LOTE (Grupo proceso):&nbsp;
                                    </h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 418px; height: 4px">
                                    <select id="myCbo" runat="server" class="comboBox" name="myCbo" style="width: 165px">
                                        <option selected="selected" value="1">01</option>
                                        <option value="2">02</option>
                                        <option value="3">03</option>
                                        <option value="4">04</option>
                                        <option value="5">05</option>
                                        <option value="6">06</option>
                                        <option value="7">07</option>
                                        <option value="8">08</option>
                                        <option value="9">09</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                        <option value="13">13</option>
                                        <option value="14">14</option>
                                        <option value="15">15</option>
                                        <option value="16">16</option>
                                        <option value="17">17</option>
                                        <option value="18">18</option>
                                        <option value="19">19</option>
                                        <option value="20">20</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="height: 3px">
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="2" style="height: 1px">
                                    <div class="WebPartShadow" style="text-align: justify">
                                        <table id="Table2" align="center" border="0" cellspacing="0" style="width: 709px;
                                            height: 3px" width="709">
                                            <tr style="color: #000000">
                                                <td align="center" colspan="2" style="width: 760px; height: 3px; text-align: left">
                                                    <asp:Label ID="Label5" runat="server" Text="0 coincidencia(s) encontrada(s)" Width="153px"></asp:Label>
                                                    <asp:DataGrid ID="GrillaCierreProcesoRegional" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                        BorderColor="#003366" BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1"
                                                        CssClass="GridAlternativeItems" ForeColor="Black" GridLines="Horizontal" Height="1px"
                                                        Width="706px">
                                                        <HeaderStyle BackColor="Control" BorderColor="Black" Font-Bold="True" Font-Underline="True"
                                                            ForeColor="Black" HorizontalAlign="Center" />
                                                        <Columns>
                                                            <asp:BoundColumn DataField="id_localidad" HeaderText="IDLocalidad" Visible="False"></asp:BoundColumn>
                                                            <asp:BoundColumn DataField="cod_localidad" HeaderText="C&#243;digo Localidad">
                                                                <HeaderStyle Width="25%" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="nom_localidad" HeaderText="Localidad">
                                                                <HeaderStyle Width="50%" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="total_localidad" HeaderText="Total Localidad">
                                                                <HeaderStyle Width="25%" />
                                                            </asp:BoundColumn>
                                                        </Columns>
                                                        <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                                                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                                                            VerticalAlign="Middle" />
                                                        <ItemStyle BackColor="MenuBar" HorizontalAlign="Center" />
                                                        <AlternatingItemStyle BackColor="White" />
                                                    </asp:DataGrid></td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="1" style="width: 25%">
                                                    <strong>
                                                        <h2>
                                                            TOTAL EFECTIVAS</h2>
                                                    </strong>
                                                </td>
                                                <td colspan="1" style="height: 3px">
                                                    <asp:TextBox ID="TextBox1" runat="server" CssClass="TextBox" Width="50px"></asp:TextBox>
                                                    %</td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="1">
                                                    <h2>
                                                        TOTAL IMPROCEDENTES</h2>
                                                </td>
                                                <td colspan="1">
                                                    <asp:TextBox ID="TextBox2" runat="server" CssClass="TextBox" Width="50px"></asp:TextBox>
                                                    %</td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="1" style="height: 3px">
                                                    <h2>
                                                        LECTURAS PENDIENTES</h2>
                                                </td>
                                                <td colspan="1" style="height: 3px">
                                                    <asp:TextBox ID="TextBox4" runat="server" CssClass="TextBox" Width="50px"></asp:TextBox>
                                                    %</td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="1">
                                                    <h2>
                                                        TOTAL GENERAL</h2>
                                                </td>
                                                <td colspan="1">
                                                    <asp:TextBox ID="TextBox3" runat="server" CssClass="TextBox" Width="50px"></asp:TextBox>
                                                    ( 100 % )</td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="1">
                                                </td>
                                                <td colspan="1">
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <h2>
                                        Empresa: .-</h2>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="2">
                                    <h2>
                                        Total Grupo Lote: .-</h2>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2">
                                    <asp:Button ID="Button1" runat="server" CssClass="Button" Text="Cierre Proceso" Width="120px" />
                                    <asp:Button ID="btnCancelar" runat="server" CssClass="Button" Text="No Cerrar Proceso"
                                        Width="120px" />
                                    <asp:Button ID="btnVolver" runat="server" CssClass="Button" Text="<< Volver Menu"
                                        Width="120px" /></td>
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
