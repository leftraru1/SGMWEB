<%@ Page Language="VB" AutoEventWireup="false" CodeFile="popFoto.aspx.vb" Inherits="CYR_popFoto" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Consulta Fotografia - Sistema CYR</title>
    
    <script type="text/javascript" language="javascript">

      function ZoomImage(obj)      
       {
       debugger;       
       var pic1 = obj; 
       var url_image = pic1.src; 
       var url = 'zoom_imageCorte.aspx?var_foto='+url_image;
       open(url,'DetalleLecturas','top=20,left=100,width=1200,height=700,status=yes,resizable=yes,scrollbars=yes');
       } 
       
       </script> 
       
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table border="0" style="width: 900px">
            <tr>
                <td style="width:33%;">
                    <asp:ImageButton ID="image1" runat="server" BorderStyle="Solid" Height="280px" Visible="False"
                        Width="368px" OnClientClick="ZoomImage(this);return false" /></td>
                <td style="width:33%;">
                <asp:ImageButton ID="image2" runat="server" BorderStyle="Solid" Height="280px"
            Visible="False" Width="368px" OnClientClick="ZoomImage(this);return false" /></td>
                <td style="width:34%;">
        <asp:ImageButton ID="image3" runat="server" BorderStyle="Solid" Height="280px"
            Visible="False" Width="368px" OnClientClick="ZoomImage(this);return false" /></td>
            </tr>
            <tr>
                <td>
        <asp:Label ID="lb_pie_imagen1" runat="server" Font-Names="Arial Unicode MS" Font-Size="X-Small"
            Visible="False"></asp:Label></td>
                <td><asp:Label ID="lb_pie_imagen2" runat="server" Visible="False" Font-Names="Arial Unicode MS" Font-Size="X-Small" /></td>
                <td><asp:Label ID="lb_pie_imagen3" runat="server" Visible="False" Font-Names="Arial Unicode MS" Font-Size="X-Small" /></td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
            </tr>
        </table>
    
        
    
    </div>
    </form>
</body>
</html>
