<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PruebaGrafico.aspx.vb" Inherits="PruebaGrafico" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server" >
    <title>PPrueba Grafico</title>
 
    <script type="text/javascript" src="js/jquery.js"></script>
    <script language="Javascript" type="text/javascript" src="../FusionCharts/FusionCharts.js"></script>  
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table id="Tabla_GraficoPrincipal" runat="server" align="center" border="0" cellpadding="0"
            cellspacing="0" onclick="return TABLE2_onclick()" style="width: 1164px;
            height: 152px">
            <tr style="font-weight: bold; font-size: 8pt; color: #000000; font-family: Times New Roman">
                <td style="width: 962px; height: 12px; text-align: center">
                    &nbsp;<asp:Literal ID="FCLiteral" runat="server"></asp:Literal></td>
            </tr>
        </table>
    
    </div>
        <asp:Literal ID="Literal1" runat="server"></asp:Literal>
    </form>
</body>
</html>
