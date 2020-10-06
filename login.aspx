<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

    <link href="lksMenuSkin2.css" rel="stylesheet" />
    <link href="estilos/texto.css" rel="stylesheet" />
    <link href="estilos/tabla.css" rel="stylesheet" />
    <link href="estilos/grid.css" rel="stylesheet" />
    <link href="estilos/webpart.css" rel="stylesheet" />
    <link href="estilos/calendario.css" rel="stylesheet" />
    <link href="estilos/controls.css" rel="stylesheet" />

    <style type="text/css">

       

        .auto-style2
        {
            height: 123px;
            /*
            background-image:url("Imagenes/app_back.gif");
            background-repeat: repeat-x;
           */
        }
        .auto-style4
        {
            width: 438px;
        }
        .auto-style5
        {
            width: 404px;
            height: 287px;
        }
        .auto-style6
        {
            width: 404px;
            height: 38px;
        }
        .auto-style7
        {
            width: 404px;
            height: 61px;
        }
        .auto-style8 {
            height: 31px;
        }
        .auto-style9 {
            height: 30px;
        }
        .auto-style10 {
            height: 27px;
        }
        .auto-style11 {
            height: 21px;
        }
        </style>

</head>

<body class="auto-style2">
    <form id="form1" runat="server">
    <div>
     <table align="center" border="0" cellpadding="1" cellspacing="4" style="WIDTH: 81%; height: 21px;">
                        <tr>
                            <td align="center"  class="WebPartMenu" >
                                <h2 class="AppTitle">&nbsp;SISTEMA DE GESTIÓN DE MEDIDORES&nbsp; (SGM) - ESSBIO</h2>
                            </td>
                            <td class="WebPartMenu" style="WIDTH: 5%; HEIGHT: 34px">
                                <img src="Imagenes/essbio.PNG" style="height: 80px; width: 294px"/>&nbsp;
                            </td>
                        </tr>
     </table>
        <table class="auto-style2" style="width: 100%; height: 438px;">
            <tr>
                <td rowspan="3" class="auto-style4">
                    <asp:Label ID="lb_id_usuario" runat="server"></asp:Label>
                    <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label>
                </td>
                <td class="auto-style6"></td>
                <td rowspan="3">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style5">

                    <asp:Login ID="logSistema" runat="server" Width="421px" FailureText="Usuario y/o Password Incorrecto. Inténtelo de nuevo." Height="227px" OnAuthenticate="Login1_Authenticate" CssClass="WebPartMenu">
                        <LayoutTemplate>
                            <table cellpadding="1" cellspacing="0" style="border-collapse:collapse;">
                                <tr>
                                    <td>
                                        <table cellpadding="0" style="height:227px;width:421px;">
                                            
                                            <tr>

                                                <td align="center" class="WebPartTitle" colspan="2">INICIAR SESIÓN</td>
                                            </tr>
                                            <tr>
                                                <td align="center" class="WebPartTitle" colspan="2">
                                                    <img src="Imagenes/user.png" style="height: 106px; width: 104px" />
                                                    &nbsp;<br />
                                                    <br />
                                                </td>
                                                <tr>
                                                    <td align="right" class="auto-style8">
                                                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">NOMBRE DE USUARIO:</asp:Label>
                                                    </td>
                                                    <td class="auto-style8">
                                                        <asp:TextBox ID="UserName" runat="server" style="border-radius:5px;"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="El nombre de usuario es obligatorio." ToolTip="El nombre de usuario es obligatorio." ValidationGroup="logSistema">*</asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" class="auto-style9">
                                                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">CONTRASEÑA:</asp:Label>
                                                    </td>
                                                    <td class="auto-style9">
                                                        <asp:TextBox ID="Password" runat="server" TextMode="Password" style="border-radius:5px;"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="La contraseña es obligatoria." ToolTip="La contraseña es obligatoria." ValidationGroup="logSistema">*</asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" align="center" class="auto-style10">
                                                        <asp:CheckBox ID="RememberMe" runat="server" Text="Recordármelo la próxima vez." />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center" colspan="2" style="color:Red;" class="auto-style11">
                                                        <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center" colspan="2">
                                                        <asp:Button ID="LoginButton" Height="25px" cssClass="botonnew" runat="server" CommandName="Login" Text="INICIAR SESIÓN" ValidationGroup="logSistema" OnClick="LoginButton_Click" />
                                                    </td>
                                                    <td></td>
                                                    <caption>
                                                        <br />
                                                        <tr>
                                                            <td>
                                                                <br />
                                                            </td>
                                                        </tr>
                                                </tr>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </LayoutTemplate>
                    </asp:Login>
                </td>
            </tr>
            <tr>
                <td class="auto-style7"></td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
