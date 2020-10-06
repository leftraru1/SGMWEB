<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popDetalleHistorico.aspx.cs" Inherits="popDetalleHistorico" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

    <link href="estilos/texto.css" rel="stylesheet" />
    <link href="estilos/tabla.css" rel="stylesheet" />
    <link href="estilos/grid.css" rel="stylesheet" />
    <link href="estilos/webpart.css" rel="stylesheet" />
    <link href="estilos/calendario.css" rel="stylesheet" />
    <link href="estilos/controls.css" rel="stylesheet" />

    <style type="text/css">
        .auto-style1
        {
        }
        .auto-style3
        {
            width: 164px;
            text-align:right
        }
        #form1
        {
            width: 825px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
    <div class="WebPartShadow">
                  <asp:Label ID="Label11" class="WebPartTitle" runat="server" Text="Detalle Historico"></asp:Label>
    
        <table style="width:95%;">
            <tr>
                <td class="auto-style1" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style1" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style3">
                    <asp:Label ID="Label12" runat="server" Text="Tipo/Marca/Diametro:"></asp:Label>
                </td>
                <td class="auto-style1">
                    <asp:Label ID="lbTmd" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style1" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style3">
                    <asp:Label ID="Label1" runat="server" Text="Observación de Ingreso:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtIn" runat="server" Enabled="False" Height="68px" TextMode="MultiLine" Width="402px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style3">
                    <asp:Label ID="Label3" runat="server" Text="Observación Terreno:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtOut" runat="server" Enabled="False" Height="68px" TextMode="MultiLine" Width="402px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
