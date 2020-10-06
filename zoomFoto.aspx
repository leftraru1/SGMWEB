<%@ Page Language="C#" AutoEventWireup="true" CodeFile="zoomFoto.aspx.cs" Inherits="zoomFoto" %>

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
        .auto-style2
        {
            width: 260px;
        }
        .auto-style3
        {
            width: 97px;
        }
        .auto-style4
        {
            width: 268435408px;
        }
        .auto-style5
        {
           text-align:right;
        }
        
    </style>

    

</head>
<body>
    <form id="form1" runat="server">
    <div class="WebPartShadow">
    
        <table style="width: 100%;">
            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td colspan="2" class="auto-style5">
    
                    &nbsp;</td>
                <td colspan="2">
    
        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Imagenes/misc_zoom_in_93647.jpg" OnClick="ImageButton1_Click" style="margin-left: 0px;" Height="57px" Width="62px" />
    
                    <asp:ImageButton ID="ImageButton2" runat="server" OnClick="ImageButton2_Click" Height="57px" ImageUrl="~/Imagenes/Misc-Zoom-Out-icon.png" />
                </td>
            </tr>
            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td class="auto-style4" colspan="3">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td class="auto-style2">&nbsp;</td>
                <td colspan="3">
                    <asp:Panel ID="pnFoto" runat="server" Height="600px" ScrollBars="Auto" Width="649px">
                        <asp:Image ID="image" runat="server" Height="560px" Width="400px" />
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td class="auto-style4" colspan="3">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
