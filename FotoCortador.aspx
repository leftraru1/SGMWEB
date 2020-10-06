<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FotoCortador.aspx.vb" Inherits="FotoCortador" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Foto Cortador</title>
    

    
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Image ID="foto_cortador" runat="server" EnableViewState="False" Height="150px"
            Width="130px" onclick="openCalendar('1');"/>
        <asp:Label ID="Label1" runat="server"></asp:Label></div>
    </form>
</body>
</html>
