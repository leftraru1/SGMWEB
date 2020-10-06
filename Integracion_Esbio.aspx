<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Integracion_Esbio.aspx.vb" Inherits="Integracion_Esbio" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Carga Rutero de Lecturas - Sistema SGL</title>
       <link type="text/css" rel="stylesheet" href="estilos/page.css">
    <link type="text/css" rel="stylesheet" href="estilos/controls.css">
    <link type="text/css" rel="stylesheet" href="estilos/grid.css">
    <link type="text/css" rel="stylesheet" href="estilos/webpart.css">
    <link type="text/css" rel="stylesheet" href="estilos/menu.css">
    <link type="text/css" rel="stylesheet" href="estilos/others.css">
 <script language="JavaScript">

//This script changes the graphic on mouse over and a graphic in
//another part of the screen

{
alt0 = new Image();
alt0.src = "fotos/espejo.bmp";

alt1 = new Image();
alt1.src = "fotos/nota.bmp";

alt2 = new Image();
alt2.src = "fotos/logotipo.bmp";

graphic1= new Image();
graphic1.src = "fotos/help2.bmp";
graphic1on = new Image();
graphic1on.src = "fotos/help2.bmp";

graphic2= new Image();
graphic2.src = "fotos/help2.bmp";
graphic2on = new Image();
graphic2on.src = "fotos/help2.bmp";
}
function imageChange(imageID,imageName,imageID2,imageName2) {


{
document.images[imageID].src = eval(imageName + ".src");
document.images[imageID2].src = eval(imageName2 + ".src");
}

}


function IMG1_onclick() {

}

function File1_onclick() {

}

function TABLE1_onclick() {

}

</script>

</head>
<body style="text-align: center">
    <form id="form1" runat="server">
    <div style="text-align: center">
        <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 758px;
            height: 23px" width="758" class="WebPartShadow_ext">
            <tr>
                <td style="width: 732px; text-align: left;">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr style="font-size: 12pt; font-family: Times New Roman">
                <td style="width: 732px; height: 392px;">
                    <div class="WebPartShadow_ext_intsap" style="text-align: left;">
                        <div class="WebPartTitle_ext_intsap" style="text-align: left">
                            &nbsp; &nbsp;&nbsp;&nbsp;
                        </div>
                        <table align="center" border="0" cellspacing="4" style="width: 813px; height: 66px">
                            <tr>
                                <td align="left" colspan="2" nowrap="nowrap" style="height: 15px; text-align: center;">
                                    <asp:Label ID="LBL_INFORMACION" runat="server" Text="Escriba Directorio De Archivos"
                                        Visible="False" Width="232px"></asp:Label></td>
                            </tr>
                            <tr runat="server" id="row_individual_encabezado">
                                <td align="left" colspan="2" nowrap="nowrap" style="height: 15px">
                                    <h2 style="text-align: center">
                                        &nbsp;
                                        <asp:TextBox ID="txt_cambio" runat="server" Visible="False" Width="400px" CssClass="TextBox"></asp:TextBox></h2>
                                </td>
                            </tr>
                            <tr runat="server" id="row_individual_cuerpo">
                                <td align="left" colspan="2" nowrap="nowrap" style="height: 15px; width:15%">
                                    &nbsp;<asp:Label ID="Label2" runat="server" Text="Ruta del Directorio:"></asp:Label>
                                    <asp:Label ID="lbl_Ruta_xml" runat="server" Width="456px"></asp:Label>&nbsp;
                                </td>
                            </tr>
                            <tr runat="server" id="row_todos_encabezado">
                                <td colspan="2" style="height: 9px; text-align: left;">
                                    &nbsp;<asp:ListBox ID="Box_archivos" runat="server" Width="792px" Height="144px" CssClass="TextBox"></asp:ListBox>
                                    </td>
                            </tr>
                            <tr runat="server" id="row_todos_cuerpo">
                                <td colspan="2" style="height: 9px; text-align: left;"><table
                                                    border="0" cellpadding="0" cellspacing="0" style="width: 136px; height: 16px;" id="TABLE1" language="javascript" onclick="return TABLE1_onclick()">
                                    <tr>
                                        <td style="width: 1%; height: 20px; text-align: center;">
                                    <asp:Button ID="btnCargaTODOS" runat="server" CssClass="Button" Text="Cargar Archivos"
                                        Width="128px" /></td>
                                    </tr>
                                </table>
                                    <br />
                                    &nbsp;
                                    <asp:Label ID="LBL_MENSAJE_ERROR" runat="server" ForeColor="Red" Width="792px" Height="14px"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="left" colspan="2" style="height: 9px; text-align: left;">
                                    &nbsp;<br />
                    </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="height: 3px; text-align: right;">
                                    &nbsp; &nbsp;
                        <asp:Button ID="BTN_VISUALIZAR" runat="server" CssClass="Button" Text="Visualizar Archivo"
                            Width="120px" Visible="False" />
                    <asp:Button ID="btn_cambios" runat="server" CssClass="Button" Text=" << Actualizar Directorio"
                                        Visible="False" Width="152px" />
                                    <asp:Button ID="btn_cambiar_ruta" runat="server" CssClass="Button" Text=" << Cambiar Ruta Del Directorio"
                                        Width="192px" />
                                    <asp:Button ID="Button1" runat="server" CssClass="Button" Text="<< Actualizar" Width="120px" />
                                    <asp:Button ID="btnVolver" runat="server" CssClass="Button" Text="<< Volver Menu"
                                        Width="128px" /></td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="height: 3px; text-align: left">
                                    <asp:Label ID="lb_mensaje_error" runat="server" Font-Bold="True" Font-Names="Arial"
                                        Font-Size="X-Small" ForeColor="Red"></asp:Label><asp:Label ID="lblcantidad" runat="server"
                                            Font-Bold="True" Font-Size="Small" ForeColor="Navy"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="height: 3px; text-align: left">
                                    <img id="img_ok" runat="server" src="fotos/ok.bmp" style="height: 14px" /><asp:Label ID="lb_mensaje" runat="server"
                                        Font-Bold="True" Font-Names="Arial" ForeColor="Navy" Width="768px" Height="13px">Los archivos Han sido procesado</asp:Label>&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="height: 3px; text-align: right">
                                    &nbsp;</td>
                            </tr>
                            <tr runat="server">
                                <td align="right" colspan="2" style="height: 1px; text-align: left">
                                    <asp:RadioButtonList ID="Seleccion_grillas" runat="server" AutoPostBack="True" Font-Names="Arial"
                                        Height="17px" RepeatDirection="Horizontal" Visible="False" Width="440px">
                                        <asp:ListItem Selected="True" Value="0">Informacion Procesamiento</asp:ListItem>
                                        <asp:ListItem Value="1">Detalles Errores</asp:ListItem>
                                    </asp:RadioButtonList></td>
                            </tr>
                        </table>
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
                        </asp:DataGrid><asp:DataGrid ID="GrillaClaves" runat="server" AutoGenerateColumns="False"
                            BorderColor="#003366" BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1"
                            CssClass="GridAlternativeItems" ForeColor="Black" GridLines="Horizontal" Height="1px"
                            Width="848px">
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
                        </asp:DataGrid>
                        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
                        <br />
                        <br />
                </td>
            </tr>
        </table>
        <br />
    
    </div>
    </form>
</body>
</html>
