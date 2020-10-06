<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popVisorFotosConsulta.aspx.cs" Inherits="popVisorFotosConsulta" %>

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
        .auto-style6
        {
            width: 361px;
            height: 10px;
        }
        .auto-style14
        {
            width: 418px;
            text-align: center;
            height: 10px;
        }
        .auto-style15
        {
            width: 322px;
            height: 10px;
        }
        .auto-style16
        {
            width: 418px;
            height: 9px;
        }
        .auto-style17
        {
            width: 361px;
            text-align: center;
            height: 9px;
        }
        .auto-style18
        {
            width: 322px;
            height: 9px;
        }
        .auto-style19
        {
            width: 418px;
            height: 15px;
        }
        .auto-style20
        {
            width: 361px;
            text-align: center;
            height: 15px;
        }
        .auto-style21
        {
            width: 322px;
            height: 15px;
        }
        .auto-style22
        {
            width: 418px;
            text-align: center;
            height: 502px;
        }
        .auto-style23
        {
            width: 361px;
            text-align: center;
            height: 199px;
        }
        .auto-style24
        {
            width: 322px;
            text-align: center;
            height: 199px;
        }
        .auto-style26
        {
            width: 418px;
            text-align: center;
            height: 233px;
        }
        .auto-style27
        {
            width: 418px;
            text-align: center;
            height: 199px;
        }
    </style>

    <script language="javascript">

        function PopZoom(foto) {

            var url = 'zoomFoto.aspx?foto=' + foto;
            open(url, 'Detalle', 'top=20,left=100,width=690,height=480,status=yes,resizable=no');

        }



      </script> 

</head>
<body>
    <form id="form1" runat="server">
        <div class="WebPartShadow">
            <h1 class="WebPartTitle">Visor Fotográfico </h1>
                
                <table style="width: 100%; height: 874px;">
                <tr>
                    <td class="auto-style16"></td>
                    <td class="auto-style17"></td>
                    <td class="auto-style18"></td>
                </tr>
                <tr>
                    <td class="auto-style14">
                        <asp:Label ID="Label1" runat="server" Text="SERVICIO:"></asp:Label>
&nbsp;<asp:Label ID="lbServ" runat="server"></asp:Label>
                    </td>
                    <td class="auto-style6" >
                        <asp:Label ID="Label2" runat="server" Text="GRUPO PROCESO:"></asp:Label>
&nbsp;<asp:Label ID="lbGrupo" runat="server"></asp:Label>
                    </td>
                    <td class="auto-style15">
                        <asp:Label ID="Label3" runat="server" Text="VISITA:"></asp:Label>
&nbsp;<asp:Label ID="lbVisita" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style19"></td>
                    <td class="auto-style20"></td>
                    <td class="auto-style21"></td>
                </tr>
                <tr>
                    <td class="auto-style27">
                        <asp:ImageButton ID="btFoto1" runat="server" Height="300px" OnClick="ImageButton1_Click" Width="300px" />
                        <asp:Label ID="lbImagen1" runat="server"></asp:Label>
                    </td>
                    <td class="auto-style23">
                        <asp:ImageButton ID="btFoto2" runat="server" Height="300px" Width="300px" OnClick="ImageButton2_Click" />

                        <asp:Label ID="lbImagen2" runat="server"></asp:Label>

                    </td>
                    <td class="auto-style24">
                        <asp:ImageButton ID="btFoto3" runat="server" Height="300px" Width="300px" OnClick="ImageButton3_Click" />
                        <asp:Label ID="lbImagen3" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style26">
                        <asp:ImageButton ID="btFoto4" runat="server" Height="300px" OnClick="btFoto4_Click" Width="300px" />
                        <asp:Label ID="lbImagen4" runat="server"></asp:Label>
                    </td>
                    <td class="auto-style26">
                        <asp:ImageButton ID="btFoto5" runat="server" Height="300px" Width="300px" OnClick="btFoto5_Click" />

                        <asp:Label ID="lbImagen5" runat="server"></asp:Label>
                    </td>
                    <td class="auto-style26">
                        <asp:ImageButton ID="btFoto6" runat="server" Height="300px" Width="300px" OnClick="btFoto6_Click" />
                        <asp:Label ID="lbImagen6" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style22">
                        <asp:ImageButton ID="btFoto7" runat="server" Height="300px" OnClick="btFoto7_Click" Width="300px" />
                        <asp:Label ID="lbImagen7" runat="server"></asp:Label>
                    </td>
                    <td class="auto-style22">
                        <asp:ImageButton ID="btFoto8" runat="server" Height="300px" Width="300px" OnClick="btFoto8_Click" />

                        <asp:Label ID="lbImagen8" runat="server"></asp:Label>
                    </td>
                    <td class="auto-style22">
                        <asp:ImageButton ID="btFoto9" runat="server" Height="300px" Width="300px" OnClick="btFoto9_Click" />
                        <asp:Label ID="lbImagen9" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>

           


        </div>
    </form>
</body>
</html>
