﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="calendario2.aspx.cs" Inherits="calendario2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="Black" Font-Names="Verdana" Font-Size="9pt"
            ForeColor="Black" Height="180px" Width="240px" BorderStyle="Solid" CellSpacing="1" NextPrevFormat="ShortMonth" OnSelectionChanged="Calendar1_SelectionChanged">
            <SelectedDayStyle BackColor="#333399" ForeColor="White" />
            <TodayDayStyle BackColor="#999999" ForeColor="White" />
            <OtherMonthDayStyle ForeColor="#999999" />
            <NextPrevStyle Font-Size="8pt" ForeColor="White" Font-Bold="True" />
            <DayHeaderStyle Font-Bold="True" Height="8pt" Font-Size="8pt" ForeColor="#333333" />
            <TitleStyle BackColor="#333399" Font-Bold="True" Font-Size="12pt" ForeColor="White" BorderStyle="Solid" Height="12pt" />
            <DayStyle BackColor="#CCCCCC" />
        </asp:Calendar>
    
    </div>
    </form>
</body>
</html>
