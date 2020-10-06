<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ResumenReposPendientes.aspx.vb" Inherits="CYR_ResumenReposPendientes" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Resumen Reposiciones Pendientes</title>
    <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/others.css"/>

    
</head>
<body>
    <form id="form1" runat="server">    
    <div id="flotante">
        <%--<div id="Div2" runat="server" class="WebPartTitle">Resumen en Proceso...</div>--%> 
        <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label> 
        
    </div>
    
    
    
       <%-- <iframe width="920px" height="1400px" id="panel" runat="server" scrolling="auto" frameborder="0">  
              
        </iframe>--%>
        
        <table id="tbl_inicio" runat="server" align="center" border="0" cellpadding="0" cellspacing="0"
            style="width: 450px; height: 130px">
            <tr>
                <td align="left" style="width: 732px">
                    <div class="WebPartShadow">
                        <div id="Div1" runat="server" class="WebPartTitle">Resumen Reposiciones Pendientes</div>
                        <table id="TABLE1" align="center" border="0" cellspacing="0" style="width: 617px;
                            height: 1px">
                            
                            <tr id="Tr2" runat="server">
                                <td align="left" colspan="4" nowrap="nowrap">
                                   
                                </td>
                            </tr>
                            <tr id="Tr3" runat="server">
                                <td align="left" nowrap="nowrap" style="width: 126px; height: 9px">
                                </td>
                                <td style="width: 131px; height: 9px">
                                </td>
                                <td style="width: 4150px; height: 9px">
                                </td>
                                <td style="height: 9px">
                                </td>
                            </tr>
                            <tr id="Tr4" runat="server">
                                <td align="right" nowrap="nowrap" colspan="1" style="width: 126px; height: 15px">
                                    <h2>&nbsp;Fecha Desde:</h2>
                                </td>
                                <td align="left" colspan="3" nowrap="nowrap" style="width: 126px; height: 15px">
                                    <asp:Label ID="lb_fecha_desde" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0" Width="368px" ></asp:Label>
                                </td>                           
                            </tr>
                            
                            <tr id="Tr5" runat="server">
                                <td align="right" nowrap="nowrap" colspan="1" style="width: 126px; height: 15px">
                                    <h2>&nbsp;Fecha Hasta:</h2>
                                </td>
                                <td align="left" colspan="3" nowrap="nowrap" style="width: 126px; height: 15px">
                                    <asp:Label ID="lb_fecha_hasta" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0" Width="368px"></asp:Label>
                                </td>
                            </tr>
                            
                            <tr>
                                <td align="right" colspan="4" style="height: 22px">
                                <asp:DataGrid ID="GrillaReposPendientes" runat="server" AllowSorting="True"
                                        AutoGenerateColumns="False" BorderWidth="0px" CellPadding="1" CellSpacing="1"
                                        CssClass="GridAlternativeItems" GridLines="Horizontal" Height="7px" PageSize="6"
                                        Width="668px">
                                        <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="True" ForeColor="White" HorizontalAlign="Center" Wrap="False" />
                                        <Columns>
                                            <asp:BoundColumn DataField="CONTRATISTA" HeaderText="Contratistas"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="BLANCO" HeaderText="Orden Nueva">
                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" Wrap="False" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="AMARILLO" FooterText="sfgdgf" HeaderText="A Punto de Exceder">
                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" Wrap="False" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="ROJO" HeaderText="Tiempo Excedido">
                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" Wrap="False" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:BoundColumn>
                                        </Columns>
                                        <EditItemStyle BackColor="Honeydew" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                        <PagerStyle BackColor="Control" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Mode="NumericPages"
                                            NextPageText="Siguientes" PrevPageText="Anteriores" Wrap="False" />
                                        <AlternatingItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                        <ItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
                                        <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <SelectedItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:DataGrid>
                                    &nbsp;<asp:Button ID="btnVolver" runat="server" CssClass="botonnew" Text="Cerrar Ventana"
                                        Width="120px"   />
                                    </td>
                                    
                            </tr>
                            
                            
                            
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        
    </form>
    <%--<form id="form1" runat="server">
    <div>
    
    </div>
    </form>--%>
</body>
</html>
