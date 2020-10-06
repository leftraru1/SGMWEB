<%@ Page ValidateRequest="false" Language="C#" AutoEventWireup="true" CodeFile="errorSesion.aspx.cs" Inherits="errorSesion" %>

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
            text-align:center;
        }
       
         .auto-style5
         {
             text-align: right;
             width: 79%;
         }
         .auto-style6
         {
             width: 45%;
         }
         .auto-style8
         {
             width: 435px;
             
         }
         .auto-style9
         {
             vertical-align:central;
             
         }
       
    </style>

</head>
<body>
    <form id="form1" runat="server" class="auto-style9">
        

        <TABLE style="WIDTH: 758px; HEIGHT: 23px" cellSpacing=0 cellPadding=0 width=758 
align=center border=0 __designer:dtid="2251799813685260"><TBODY><TR 
__designer:dtid="2251799813685261"><TD style="WIDTH: 732px; HEIGHT: 162px" 
__designer:dtid="2251799813685262">
    <div class="WebPartShadow_ext">
            <h1 class="WebPartTitle">Error de Sesión</h1>
            <table style="width: 100%;">
                <tr>
                    <td class="auto-style5">&nbsp;</td>
                    <td class="auto-style8">&nbsp;</td>
                    <td class="auto-style6">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="3" class="auto-style1">
                        <asp:Label ID="Label1" runat="server" Text="Estimado Usuario su Sesión ha expirado, puede iniciar una nueva sesión&nbsp; haciendo click en Iniciar Nueva Sesión."></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style5">&nbsp;</td>
                    <td class="auto-style8">&nbsp;</td>
                    <td class="auto-style6">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style5">&nbsp;</td>
                    <td class="auto-style8">
                        <asp:Button ID="btSesion" runat="server" CssClass="botonnew" Text="&lt;&lt;Nueva Sesión" OnClick="btSesion_Click" />
                    </td>
                    <td class="auto-style6">
                        <asp:Button ID="Button2" runat="server" CssClass="botonnew" Text="Salir de SGM" OnClick="Button2_Click" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style5">&nbsp;</td>
                    <td class="auto-style8">&nbsp;</td>
                    <td class="auto-style6">&nbsp;</td>
                </tr>
            </table>

        </div>
                                   </TD></TR></TBODY></TABLE>
    </form>
</body>
</html>
