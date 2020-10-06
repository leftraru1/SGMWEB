<%@ Page Language="VB" AutoEventWireup="false" CodeFile="CargaManual.aspx.vb" Inherits="RecepcionLecturas" %>

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
            <tr>
                <td style="width: 732px">
                    <div class="WebPartShadow_ext">
                        <div class="WebPartTitle_ext">
                            Importar Archivos de Salida (carga de lecturas digitadas del PDA)</div>
                        <table align="center" border="0" cellspacing="4" style="width: 709px; height: 66px"
                            width="709">
                            <tr>
                                <td align="left" colspan="2" nowrap="nowrap" style="height: 15px">
                                    <h2>
                                        Por favor, carge el archivo de rutas:
                                        <asp:FileUpload ID="CargaArchivo" runat="server" Width="371px" />
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="CargaArchivo"
                                            ErrorMessage="Sólo archivos en formato XML" ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))+(.xml|.XML|.Xml)$"></asp:RegularExpressionValidator></h2>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="height: 9px">
                                    <asp:Button ID="btnCargaRutero" runat="server" CssClass="Button" Text="Importar Lecturas" Width="128px" />
                                    </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="height: 9px">
                                    <img id="img_ok" runat="server" src="fotos/ok.bmp" /><asp:Label ID="lb_mensaje" runat="server"
                                        Font-Bold="True" Font-Names="Arial" ForeColor="Navy"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="height: 3px">
                                    <asp:Button ID="btnVolver" runat="server" CssClass="Button" Text="<< Volver Menu"
                                        Width="120px" /></td>
                            </tr>
                        </table>
                    </div>
                    </td>
            </tr>
            <tr>
                <td style="width: 732px">
                    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Small"></asp:Label>
                    <asp:Label ID="lb_mensaje_error" runat="server" Font-Bold="True" Font-Names="Arial"
                        Font-Size="X-Small" ForeColor="Red"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="width: 732px; height: 19px">
                    <asp:DataGrid ID="GrillaClaves" runat="server" AutoGenerateColumns="False" BorderColor="#003366"
                        BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1" CssClass="GridAlternativeItems"
                        ForeColor="Black" GridLines="Horizontal" Height="1px" Width="726px">
                        <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                            VerticalAlign="Middle" />
                        <AlternatingItemStyle BackColor="White" />
                        <ItemStyle BackColor="MenuBar" HorizontalAlign="Center" />
                        <HeaderStyle BackColor="Control" BorderColor="Black" Font-Bold="True" Font-Underline="True"
                            ForeColor="Black" HorizontalAlign="Center" />
                        <Columns>
                            <asp:BoundColumn DataField="id_clave_lectura" HeaderText="IDCLAVE_LECTURA"></asp:BoundColumn>
                            <asp:BoundColumn DataField="id_clave_observacion" HeaderText="clvobs"></asp:BoundColumn>
                            <asp:BoundColumn DataField="COD_CLAVE_LECTURAPDA" HeaderText="COD_CLAVE_LECT"></asp:BoundColumn>
                            <asp:BoundColumn DataField="COD_CLAVEOBSERVACION" HeaderText="cod_obs"></asp:BoundColumn>
                            <asp:BoundColumn DataField="valida" HeaderText="VALIDA"></asp:BoundColumn>
                            <asp:BoundColumn DataField="parametros" HeaderText="PARAMETROS"></asp:BoundColumn>
                        </Columns>
                    </asp:DataGrid>&nbsp;
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
