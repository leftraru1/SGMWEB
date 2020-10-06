<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Crear_proceso.aspx.cs" Inherits="Crear_proceso" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

        <script type="text/javascript">

            function openCalendar(obj) {
                var url = 'calendario2.aspx?textbox=' + obj;
                window.open(url, 'cal', 'width=260,height=210,left=410 410,top=330,resizable=0,scrollbars=0');
            }

        </script>

        
<head id="Head1" runat="server">

    <style type="text/css">
            .styletd{
                 width: 110px;
                 height: 30px;
            }
            .styletdbutton {
                flex-align: center;
            }
        .styletd_tipo {
            height:60px;
            padding-top:30px;
        }
        </style>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

    <script type="text/javascript" src="jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="jquery.lksMenu.js"></script>
    
    <link href="lksMenuSkin2.css" rel="stylesheet" />
    <link href="estilos/texto.css" rel="stylesheet" />
    <link href="estilos/tabla.css" rel="stylesheet" />
    <link href="estilos/grid.css" rel="stylesheet" />
    <link href="estilos/webpart.css" rel="stylesheet" />
    <link href="estilos/calendario.css" rel="stylesheet" />
    <link href="estilos/controls.css" rel="stylesheet" />

</head>
<body>
    
        <h1 class="WebPartTitle">CREAR PROCESO<asp:Label ID="Label1" runat="server" ></asp:Label></h1>
    <asp:Label ID="lbmensaje" runat="server" visible="false" ></asp:Label>
      <form id="form_crear" runat="server">

        <table style="width:89%; height: 308px;" >
               
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                    
                    <tr>
                        <td class="styletd">
                            <asp:Label Text="Periodo:" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="grupo_proceso" runat="server" Width="122px" CssClass="ComboBox" Enabled="False"></asp:TextBox>
                            <asp:DropDownList ID="mePeriodo" runat="server" AutoPostBack="True" OnSelectedIndexChanged="mePeriodo_SelectedIndexChanged" CssClass="ComboBox"></asp:DropDownList>
                            <asp:DropDownList ID="cb_agno" runat="server" AutoPostBack="True" CssClass="ComboBox" Height="19px" OnSelectedIndexChanged="mePeriodo_SelectedIndexChanged" Width="78px"></asp:DropDownList>
                        </td>
                    </tr>


                    <tr>
                        
                        <td class="styletd_tipo">
                            <asp:Label ID="Label2" runat="server"  Font-Bold="true" Text="NUEVO TIPO DE PROCESO"></asp:Label>
                        </td>
                        <td class="styletd_tipo">
                             <asp:DropDownList ID="ddTproceso" runat="server" Height="16px" Width="250px" CssClass="ComboBox"></asp:DropDownList>
                        </td>
                    </tr>

                    <tr>
                        <td class="styletd">
                            <asp:Label ID="Lb_fecha" runat="server" Text="Fecha Proceso:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="fechaPro" runat="server" ReadOnly="false" CssClass="ComboBox" Enabled="False"></asp:TextBox>
                            <asp:Image ID="Image1" runat="server" onclick="openCalendar('ctl00_ContentPlaceHolder1_fechaPro');" ImageUrl="~/Imagenes/calendario.gif" />
                            <asp:RequiredFieldValidator ID="rfvFecha" runat="server" ControlToValidate="fechaPro" ErrorMessage="*"></asp:RequiredFieldValidator>
                         
                        </td>
                    </tr>
                    <tr>
                        <td class="styletd">
                            <asp:Label runat="server" Text="Nombre Archivo:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="nomArch" runat="server" Width="252px" CssClass="ComboBox"></asp:TextBox>
                        </td>

                    </tr>
                    <tr>
                        <td></td>
                        <td class="styletdbutton">
                           <asp:Button ID="Button1"  runat="server" Text="CREAR" OnClick="recepcionar_archivo" CssClass="botonnew" />

                        </td>
                    </tr>

                </ContentTemplate>
                </asp:UpdatePanel>
        </table>
          </form>
</body>
</html>
