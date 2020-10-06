<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Importacion_Excel.aspx.vb" Inherits="Importacion_Excel" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Importar Archivos de Salida - Sistema CYR</title>
    <link type="text/css" rel="stylesheet" href="estilos/page.css">
    <link type="text/css" rel="stylesheet" href="estilos/controls.css">
    <link type="text/css" rel="stylesheet" href="estilos/grid.css">
    <link type="text/css" rel="stylesheet" href="estilos/webpart.css">
    <link type="text/css" rel="stylesheet" href="estilos/menu.css">
    <link type="text/css" rel="stylesheet" href="estilos/others.css">
<script language="javascript" type="text/javascript">
<!--

function TABLE1_onclick() {

}

// -->
</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 758px;
            height: 23px" width="758">
            <tr>
                <td style="width: 722px">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 722px">
                    <div class="WebPartShadow_ext" style="text-align: center">
                        <div class="WebPartTitle_ext">
                            Importar Archivo Excel(Rutas)</div>
                        <table align="center" border="0" cellspacing="4" style="width: 709px; height: 66px"
                            width="709">
                            <tr>
                                <td align="left" colspan="2" nowrap="nowrap" style="height: 15px">
                                    <h2>
                                        Por favor, carge el archivo de rutas:
                                        <asp:FileUpload ID="CargaArchivo" runat="server" Width="371px" />
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="CargaArchivo"
                                            ErrorMessage="Sólo archivos en formato XLS" ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))+(.xls|.XLS|.Xls)$"></asp:RegularExpressionValidator></h2>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="height: 9px; text-align: left;">
                                    <asp:Button ID="btnCargaRutero" runat="server" CssClass="Button" Text="Importar Lecturas" Width="128px" />
                                    <br />
                                    <table border="0" cellpadding="0" cellspacing="0" style="width: 589px; height: 15px" id="TABLE1" language="javascript" onclick="return TABLE1_onclick()">
                                        <tr>
                                            <td align="center" colspan="3" style="width: 605px; height: 21px; text-align: left">
                                                &nbsp;<a href="Descargas/ESTRUCTURA.xls" style="color: #0000ff; background-color: #f5f5f5"
                                                    target="_blank">Formato - Archivo Excel</a></td>
                                        </tr>
                                    </table>
                                    </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="height: 9px">
                                    <img id="img_ok" runat="server" src="fotos/ok.bmp" /><asp:Label ID="lb_mensaje" runat="server"
                                        Font-Bold="True" Font-Names="Arial" ForeColor="Navy"></asp:Label></td>
                            </tr>
                            <tr>
                                <td colspan="2" style="height: 9px; text-align: right;">
                                    &nbsp;<asp:Button ID="btnVolver" runat="server" CssClass="Button" Text="<< Volver Menu"
                                        Width="120px" />&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="2" style="height: 9px; text-align: left">
                    <asp:Label ID="lb_mensaje_error" runat="server" Font-Bold="True" Font-Names="Arial"
                        Font-Size="X-Small" ForeColor="Red"></asp:Label>
                                    <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label></td>
                            </tr>
                        </table>
                    </div>
                    </td>
            </tr>
            <tr>
                <td style="width: 722px; height: 57px;">
                    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Small"></asp:Label>&nbsp;
                    <br />
                    <asp:RadioButtonList ID="Tipo_lecturas" runat="server" AutoPostBack="True" Font-Names="Arial"
                        Height="17px" RepeatDirection="Horizontal" Visible="False" Width="408px">
                        <asp:ListItem Selected="True">Informacion Procesamiento</asp:ListItem>
                        <asp:ListItem Value="Errores">Detalles.</asp:ListItem>
                    </asp:RadioButtonList></td>
            </tr>
            <tr>
                <td style="width: 722px; height: 19px">
                    &nbsp;
                    <br />
                    <asp:DataGrid ID="Grillatrab" runat="server" AutoGenerateColumns="False" BorderColor="#003366"
                        BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1" CssClass="GridAlternativeItems"
                        ForeColor="Black" GridLines="Horizontal" Height="1px" PageSize="100" Visible="False"
                        Width="816px">
                        <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                            Mode="NumericPages" VerticalAlign="Middle" Visible="False" />
                        <AlternatingItemStyle BackColor="White" />
                        <ItemStyle BackColor="MenuBar" HorizontalAlign="Center" />
                        <Columns>
                            <asp:BoundColumn DataField="NOMBRE_ARCHIVO" HeaderText="NOMBRE_ARCHIVO">
                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                    Font-Strikeout="False" Font-Underline="False" Width="10%" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="DESCRIPCION" HeaderText="DESCRIPCION">
                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                    Font-Strikeout="False" Font-Underline="False" Width="10%" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="DUPLICADOS" HeaderText="DUPLICADOS">
                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                    Font-Strikeout="False" Font-Underline="False" Width="10%" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="CARGADOS" HeaderText="CARGADOS">
                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                    Font-Strikeout="False" Font-Underline="False" Width="10%" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="ERRORES" HeaderText="ERRORES">
                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                    Font-Strikeout="False" Font-Underline="False" Width="10%" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="ESTADO" HeaderText="ESTADO">
                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                    Font-Strikeout="False" Font-Underline="False" Width="10%" />
                            </asp:BoundColumn>
                        </Columns>
                        <HeaderStyle BackColor="Control" BorderColor="Black" Font-Bold="True" Font-Underline="True"
                            ForeColor="Black" HorizontalAlign="Center" />
                    </asp:DataGrid><br />
        <asp:DataGrid ID="detalle_errores" runat="server" AutoGenerateColumns="False" BorderColor="#003366"
            BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1" CssClass="GridAlternativeItems"
            ForeColor="Black" GridLines="Horizontal" Height="1px" PageSize="100" Visible="False"
            Width="816px">
            <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                Mode="NumericPages" VerticalAlign="Middle" Visible="False" />
            <AlternatingItemStyle BackColor="White" />
            <ItemStyle BackColor="MenuBar" HorizontalAlign="Center" />
            <Columns>
                <asp:BoundColumn DataField="NOMBRE_ARCHIVO" HeaderText="NOMBRE_ARCHIVO">
                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                        Font-Strikeout="False" Font-Underline="False" Width="10%" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="DESCRIPCION" HeaderText="DESCRIPCION">
                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                        Font-Strikeout="False" Font-Underline="False" Width="10%" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="LOTE" HeaderText="LOTE">
                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                        Font-Strikeout="False" Font-Underline="False" Width="10%" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="LOCALIDAD" HeaderText="LOCALIDAD">
                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                        Font-Strikeout="False" Font-Underline="False" Width="10%" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="RUTA" HeaderText="RUTA">
                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                        Font-Strikeout="False" Font-Underline="False" Width="10%" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="ORDEN" HeaderText="ORDEN">
                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                        Font-Strikeout="False" Font-Underline="False" Width="10%" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="MEDIDOR" HeaderText="MEDIDOR">
                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                        Font-Strikeout="False" Font-Underline="False" Width="10%" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="SERVICIO" HeaderText="SERVICIO">
                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                        Font-Strikeout="False" Font-Underline="False" Width="10%" />
                </asp:BoundColumn>
            </Columns>
            <HeaderStyle BackColor="Control" BorderColor="Black" Font-Bold="True" Font-Underline="True"
                ForeColor="Black" HorizontalAlign="Center" />
        </asp:DataGrid></td>
            </tr>
        </table>
    
    </div>
        <br />
        &nbsp;
    </form>
</body>
</html>
