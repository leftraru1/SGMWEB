<%@ Page Language="VB" AutoEventWireup="false" CodeFile="CargaManualRepos.aspx.vb" Inherits="CargaManualRepos" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Importar Archivos de Reposiciones - Sistema CYR</title>
    <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/others.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/style.css"/>  
    
<%--<script language="JavaScript1.2">
window.moveTo(0,0);
top.window.resizeTo(screen.availWidth,screen.availHeight);
</script> --%>  
    
 </head>
<body>
    <form id="form1" runat="server">
        <div>
            <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 758px;
                height: 23px" width="758">
                <tr>
                    <td style="width: 732px">
                        <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                            Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                                Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                    Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                        ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
                </tr>
                <tr style="font-size: 12pt; font-family: Times New Roman">
                    <td style="width: 732px">
                        <div class="WebPartShadow_ext">
                            <div class="WebPartTitle_ext">
                            Importar Archivos de Integración de Reposiciones formato excel(xls)</div>
                            <table align="center" border="0" cellspacing="4" style="width: 709px; height: 66px"
                                width="709">
                                <tr>
                                    <td align="left" colspan="2" nowrap="nowrap" style="height: 15px">
                                        <h2>
                                            Por favor, cargue el archivo de rutas:
                                            <asp:FileUpload ID="CargaArchivo" runat="server" Width="371px" />
                                        </h2>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="height: 9px">
                                        <asp:Button ID="btnCargaRutero" runat="server" CssClass="botonnew" Text="Importar"
                                            Width="128px" />
                                        <asp:Button ID="Btncarga2" runat="server" CssClass="botonnew" Text="Prueba " Visible="False"
                                            Width="136px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="height: 9px">
                                        <table border="0" cellpadding="0" cellspacing="0" style="width: 695px; height: 15px">
                                            <tr>
                                                <td align="center" colspan="3" style="height: 19px; text-align: left">
                                                    <a href="Descargas/ESTRUCTURA_CARGA_MANUAL_REPOSICIONES .xls" style="color: #0000ff;
                                                        background-color: #f5f5f5" target="_blank">Descargar -Estructura Reposiciones</a>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2" style="height: 9px">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td align="right" colspan="2" style="height: 3px">
                                        &nbsp;<asp:Button ID="btnVolver" runat="server" CssClass="botonnew" Text="<< Volver"
                                            Width="120px" /></td>
                                </tr>
                                <tr>
                                    <td align="right" colspan="2" style="height: 3px; text-align: left">
                                        <asp:RadioButtonList ID="Seleccion_grillas" runat="server" AutoPostBack="True" Font-Names="Arial"
                                            Height="17px" RepeatDirection="Horizontal" Visible="False" Width="328px">
                                            <asp:ListItem Selected="True" Value="0">Informacion Procesamiento</asp:ListItem>
                                            <asp:ListItem Value="1">Detalles Errores</asp:ListItem>
                                        </asp:RadioButtonList></td>
                                </tr>
                            </table>
                        </div>
                        &nbsp;<img id="img_ok" runat="server" src="fotos/ok.bmp" /><asp:Label ID="lb_mensaje"
                                            runat="server" Font-Bold="False" Font-Names="Arial Unicode MS" ForeColor="#0000C0" Width="466px" Font-Size="Small"></asp:Label>
                        <asp:Label ID="lb_mensaje_error" runat="server" Font-Bold="True" Font-Names="Arial"
                            Font-Size="X-Small" ForeColor="Red" Width="122px"></asp:Label>
                        <asp:Label ID="lblcantidad" runat="server" Font-Bold="True" Font-Size="Small" ForeColor="Navy"></asp:Label><br />
                        <asp:DataGrid ID="GrillaGeneral" runat="server" AutoGenerateColumns="False" BorderColor="#003366"
                            BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1" CssClass="GridAlternativeItems"
                            ForeColor="Black" GridLines="Horizontal" Height="1px" PageSize="100" Visible="False"
                            Width="848px">
                            <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                                Mode="NumericPages" VerticalAlign="Middle" Visible="False" />
                            <AlternatingItemStyle BackColor="White" />
                            <ItemStyle BackColor="MenuBar" HorizontalAlign="Center" />
                            <Columns>
                                <asp:BoundColumn DataField="NOMBRE_ARCHIVO" HeaderText="NOMBRE_ARCHIVO">
                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                        Font-Strikeout="False" Font-Underline="True" ForeColor="White" Width="25%" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="DESCRIPCION" HeaderText="DESCRIPCION">
                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                        Font-Strikeout="False" Font-Underline="True" ForeColor="White" Width="25%" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="REGISTROS" HeaderText="REGISTROS">
                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                        Font-Strikeout="False" Font-Underline="False" ForeColor="White" Width="25%" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="ERRORES" HeaderText="ERRORES">
                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                        Font-Strikeout="False" Font-Underline="True" ForeColor="White" Width="25%" />
                                </asp:BoundColumn>
                            </Columns>
                            <HeaderStyle BackColor="Control" BorderColor="Black" Font-Bold="True" Font-Underline="True"
                                ForeColor="Black" HorizontalAlign="Center" />
                        </asp:DataGrid><asp:DataGrid ID="detalle_errores" runat="server" AutoGenerateColumns="False"
                            BorderColor="#003366" BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1"
                            CssClass="GridAlternativeItems" ForeColor="Black" GridLines="Horizontal" Height="1px"
                            PageSize="100" Visible="False" Width="848px">
                            <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                                Mode="NumericPages" VerticalAlign="Middle" Visible="False" />
                            <AlternatingItemStyle BackColor="White" />
                            <ItemStyle BackColor="MenuBar" HorizontalAlign="Center" />
                            <Columns>
                                <asp:BoundColumn DataField="NOMBRE_ARCHIVO" HeaderText="NOMBRE_ARCHIVO">
                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                        Font-Strikeout="False" Font-Underline="True" ForeColor="White" Width="14%" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="DESCRIPCION" HeaderText="DESCRIPCION">
                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                        Font-Strikeout="False" Font-Underline="True" ForeColor="White" Width="14%" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="LOTE" HeaderText="LOTE">
                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                        Font-Strikeout="False" Font-Underline="True" ForeColor="White" Width="14%" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="LOCALIDAD" HeaderText="LOCALIDAD">
                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                        Font-Strikeout="False" Font-Underline="True" ForeColor="White" Width="14%" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="ID_SERVICIO" HeaderText="SERVICIO">
                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                        Font-Strikeout="False" Font-Underline="True" ForeColor="White" Width="14%" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="MEDIDOR" HeaderText="MEDIDOR">
                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                        Font-Strikeout="False" Font-Underline="True" ForeColor="White" Width="14%" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="LIBRETA" HeaderText="LIBRETA">
                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                        Font-Strikeout="False" Font-Underline="True" ForeColor="White" Width="14%" />
                                </asp:BoundColumn>
                            </Columns>
                            <HeaderStyle BackColor="Control" BorderColor="Black" Font-Bold="True" Font-Underline="True"
                                ForeColor="Black" HorizontalAlign="Center" />
                        </asp:DataGrid>
                        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Small"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 732px">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td style="width: 732px; height: 19px">
                        <asp:DataGrid ID="GrillaClaves" runat="server" AutoGenerateColumns="False" BorderColor="#003366"
                            BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1" CssClass="GridAlternativeItems"
                            ForeColor="Black" GridLines="Horizontal" Height="1px" Width="848px">
                            <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                                VerticalAlign="Middle" />
                            <AlternatingItemStyle BackColor="White" />
                            <ItemStyle BackColor="MenuBar" HorizontalAlign="Center" />
                            <HeaderStyle BackColor="Control" BorderColor="Black" Font-Bold="True" Font-Underline="True"
                                ForeColor="Black" HorizontalAlign="Center" />
                            <Columns>
                                <asp:BoundColumn DataField="id_clave_lectura" HeaderText="IDCLAVE_LECTURA">
                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                        Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="id_clave_observacion" HeaderText="clvobs">
                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                        Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="COD_CLAVE_LECTURAPDA" HeaderText="COD_CLAVE_LECT">
                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                        Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="COD_CLAVEOBSERVACION" HeaderText="cod_obs">
                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                        Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="valida" HeaderText="VALIDA">
                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                        Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="parametros" HeaderText="PARAMETROS">
                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                        Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                </asp:BoundColumn>
                            </Columns>
                        </asp:DataGrid>&nbsp;
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
