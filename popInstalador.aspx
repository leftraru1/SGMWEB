<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popInstalador.aspx.cs" Inherits="popInstalador" %>

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

</head>
<body>
    <form id="form1" runat="server">
    <div>
    <asp:Label ID="lbTotal" runat="server"></asp:Label>
        &nbsp;<asp:Label ID="lbError" runat="server"></asp:Label>
        <asp:GridView ID="gvInstalador" runat="server" AutoGenerateColumns="False" CellPadding="4" EnableModelValidation="True" ForeColor="#333333" OnSelectedIndexChanged="gvInstalador_SelectedIndexChanged">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="ID_INSTALADOR" HeaderText="Id" >
                <HeaderStyle ForeColor="White" />
                </asp:BoundField>
                <asp:BoundField DataField="COD_INSTALADOR" HeaderText="Código" >
                <HeaderStyle ForeColor="White" Width="10%" />
                </asp:BoundField>
                 <asp:BoundField DataField="REGION" HeaderText="Región" >
                <HeaderStyle ForeColor="White" Width="20%" />
                </asp:BoundField>
                <asp:BoundField DataField="NOMBRE" HeaderText="Nombre Operador" >
                <HeaderStyle ForeColor="White" Width="40%" />
                </asp:BoundField>
                <asp:BoundField DataField="BODEGA" HeaderText="Bodega Asignada" >
                <HeaderStyle ForeColor="White" Width="35%" />
                </asp:BoundField>
                <asp:ButtonField CommandName="Select" Text="Seleccionar" />
            </Columns>
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        </asp:GridView>
        
    
    </div>
    </form>
</body>
</html>
