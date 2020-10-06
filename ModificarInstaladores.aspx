<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="ModificarInstaladores.aspx.cs" Inherits="ModificarInstalador" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .auto-style12 {
            height: 16px;
            width: 10px;
        }

        .auto-style13 {
            width: 818px;
        }

        .auto-style14 {
            width: 132px;
        }

        .auto-style15 {
            width: 265px;
        }

        .auto-style20 {
            height: 4px;
            width: 132px;
        }

        .auto-style21 {
            height: 4px;
            width: 265px;
        }

        .auto-style23 {
            width: 250px;
        }

        .auto-style24 {
            width: 10px;
        }

        .auto-style25 {
            width: 139px;
        }

        .auto-style26 {
            height: 4px;
            width: 10px;
        }

        .auto-style27 {
            height: 17px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <title>Modificación de Instalador</title>
    <link type="text/css" rel="stylesheet" href="estilos/page.css" />
    <link type="text/css" rel="stylesheet" href="estilos/controls.css" />
    <link type="text/css" rel="stylesheet" href="estilos/grid.css" />
    <link type="text/css" rel="stylesheet" href="estilos/webpart.css" />
    <link type="text/css" rel="stylesheet" href="estilos/menu.css" />
    <link type="text/css" rel="stylesheet" href="estilos/others.css" />
    <link type="text/css" rel="stylesheet" href="estilos/style.css" />

    <%--<style type="text/css">
body {
margin:0;
width: 100%;
height: 100%;
}
</style>

<script type="text/javascript" language="JavaScript1.2">
window.moveTo(0,0);
top.window.resizeTo(screen.availWidth,screen.availHeight);

</script>  --%>

    <div>
        &nbsp;<table align="center" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True"></asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small" CssClass="Label"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True" CssClass="Label"></asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small" CssClass="Label"></asp:Label>
                    <asp:Label ID="LB_id_usuario" runat="server" CssClass="Label"></asp:Label>
                    <asp:Label ID="lbIDRegion" runat="server" CssClass="Label"></asp:Label>
                    <asp:Label ID="lbRutEmpresa" runat="server" Font-Names="Arial" CssClass="Label"></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <div class="WebPartShadow">
                        <div id="titulo_mod" runat="server">
                        </div>
                        <table align="center" border="0" cellspacing="0">
                            <tr>
                                <td colspan="2">

                                    <table class="auto-style13">
                                        <tr>
                                            <td class="WebPartTitle" colspan="5">Modificación de Instalador</td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style14">
                                                <h2 style="text-align: right">Código Instalador:&nbsp;
                                                </h2>
                                            </td>
                                            <td class="auto-style15">
                                                <asp:TextBox ID="txt_codLector" runat="server" CssClass="TextBox" MaxLength="4" Width="184px"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_codLector"
                                                    ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                            <td class="auto-style24"></td>
                                            <td>
                                                <h2 style="text-align: right">Fotografía:
                                                </h2>

                                            </td>
                                            <td style="text-align: left;">
                                                <asp:DropDownList ID="dr_foto" runat="server" CssClass="ComboBox">
                                                    <asp:ListItem Value="0">Sin Fotograf&#237;a</asp:ListItem>
                                                    <asp:ListItem Value="1">Con Fotograf&#237;a</asp:ListItem>
                                                </asp:DropDownList></td>

                                            <tr>
                                                <td class="auto-style14">
                                                    <h2 style="text-align: right">Nombre Instalador:&nbsp;
                                                    </h2>
                                                </td>
                                                <td class="auto-style15">
                                                    <asp:TextBox ID="txt_nomLector" runat="server" CssClass="TextBox" MaxLength="50">
                                                    </asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txt_nomLector"
                                                        ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                                <td class="auto-style24"></td>
                                                <td class="auto-style25">
                                                    <h2 style="text-align: right">Cantidad:
                                                    </h2>
                                                </td>

                                                <td>

                                                    <asp:TextBox ID="txt_cantidad" runat="server" CssClass="TextBox" MaxLength="4" Width="184px">

                                                    </asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txt_cantidad"
                                                        ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator>


                                                </td>

                                            </tr>
                                        <tr>
                                            <td style="text-align: right;" class="auto-style14">
                                                <h2>Apellido Instalador:&nbsp;</h2>
                                            </td>
                                            <td class="auto-style15">
                                                <asp:TextBox ID="txt_apeLector" runat="server" CssClass="TextBox" MaxLength="50">
                                                </asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txt_apeLector"
                                                    ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                            <td class="auto-style24"></td>
                                            <td class="auto-style25"></td>

                                            <td style="text-align: right">
                                                <asp:RegularExpressionValidator ID="rev" Text="<p>*Solo se admiten números para cantidad" ControlToValidate="txt_cantidad" runat="server" Display="Dynamic" EnableClientScript="False" ValidationExpression="\d+">
                                                </asp:RegularExpressionValidator>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td class="auto-style14">
                                                <h2 style="text-align: right">Clave Administrador:&nbsp;
                                                </h2>
                                            </td>
                                            <td class="auto-style15">
                                                <asp:TextBox ID="txt_claveAdmin" runat="server" CssClass="TextBox" MaxLength="8">
                                                </asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txt_claveAdmin"
                                                    ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                            <td class="auto-style24"></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right;" class="auto-style14">
                                                <h2>Clave Instalador:&nbsp;
                                                </h2>
                                            </td>
                                            <td class="auto-style15">
                                                <asp:TextBox ID="txt_ClaveInstalador" runat="server" CssClass="TextBox" MaxLength="6">
                                                </asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txt_ClaveInstalador"
                                                    ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                            <td class="auto-style24"></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right" class="auto-style14">
                                                <h2>Correo electrónico:&nbsp;
                                                </h2>
                                            </td>
                                            <td class="auto-style15">
                                                <asp:TextBox ID="txt_email" runat="server" CssClass="TextBox" MaxLength="40"></asp:TextBox><asp:RequiredFieldValidator
                                                    ID="RFV_email" runat="server" ControlToValidate="txt_email" CssClass="ErrorMessage"
                                                    ErrorMessage="*"></asp:RequiredFieldValidator></td>
                                            <td class="auto-style24"></td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style14">
                                                <h2 style="text-align: right">Región:&nbsp;
                                                </h2>
                                            </td>
                                            <td class="auto-style15">
                                                <asp:DropDownList ID="combo_regiones" runat="server" CssClass="ComboBox" AutoPostBack="True">
                                                </asp:DropDownList></td>
                                            <td class="auto-style24"></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right;" class="auto-style20">
                                                <h2>Zona:&nbsp;
                                                </h2>
                                            </td>
                                            <td class="auto-style21">
                                                <asp:DropDownList ID="combo_zonaLector" runat="server" CssClass="ComboBox">
                                                </asp:DropDownList></td>
                                            <td class="auto-style26"></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right" class="auto-style20">
                                                <h2>Forma Gestión:&nbsp;
                                                </h2>
                                            </td>
                                            <td class="auto-style21">
                                                <asp:DropDownList ID="cmb_formagestion" runat="server" CssClass="ComboBox" Width="200px">
                                                    <asp:ListItem Selected="True" Value="1">PDA</asp:ListItem>
                                                    <asp:ListItem Value="2">PAPEL</asp:ListItem>
                                                </asp:DropDownList></td>
                                            <td class="auto-style26"></td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style14">
                                                <h2 style="text-align: right">Serie Máquina:&nbsp;
                                                </h2>
                                            </td>
                                            <td class="auto-style15">
                                                <asp:TextBox ID="txt_serie_maquina" runat="server" CssClass="TextBox" MaxLength="50">
                                                </asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txt_serie_maquina"
                                                    ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                            <td class="auto-style24"></td>
                                            <td class="auto-style25"></td>
                                            <td class="auto-style23"></td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style14">

                                                <h2 style="text-align: right">Número Celular:&nbsp;
                                                </h2>
                                            </td>
                                            <td class="auto-style15">
                                                <asp:TextBox ID="txt_num_celular" runat="server" CssClass="TextBox" MaxLength="50">
                                                </asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txt_num_celular"
                                                    ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                            <td class="auto-style24"></td>
                                            <td class="auto-style25">
                                                <h2 style="text-align: right">&nbsp;</h2>
                                            </td>
                                            <td class="auto-style23">&nbsp;<asp:TextBox ID="txt_cantidad_descarga" runat="server" CssClass="TextBox" Width="174px"></asp:TextBox><asp:RequiredFieldValidator
                                                ID="RequiredFieldValidator6" runat="server" ControlToValidate="txt_cantidad_descarga"
                                                ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style14">
                                                <h2 style="text-align: right">Modelo Máquina:&nbsp;
                                                </h2>
                                            </td>
                                            <td class="auto-style15">
                                                <asp:DropDownList ID="combo_modelo" runat="server" CssClass="ComboBox">
                                                </asp:DropDownList></td>
                                            <td class="auto-style24"></td>
                                            <td class="auto-style25">
                                                <h2 style="text-align: right">Estado Instalador:</h2>
                                            </td>
                                            <td class="auto-style23">
                                                <asp:DropDownList ID="combo_estado_lector" runat="server" CssClass="ComboBox">
                                                    <asp:ListItem Value="1">Deshabilitado</asp:ListItem>
                                                    <asp:ListItem Value="0">Habilitado</asp:ListItem>
                                                </asp:DropDownList></td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style14">
                                                <h2 style="text-align: right">Contratista:&nbsp;
                                                </h2>
                                            </td>
                                            <td class="auto-style15">
                                                <asp:DropDownList ID="combo_contratistas" runat="server" CssClass="ComboBox">
                                                </asp:DropDownList></td>
                                            <td class="auto-style24"></td>
                                            <td class="auto-style25">
                                                <h2 style="text-align: right">&nbsp;</h2>
                                            </td>
                                            <td class="auto-style23">
                                                <asp:DropDownList ID="combo_fotografia" runat="server" CssClass="ComboBox">
                                                    <asp:ListItem>Sin Fotografia</asp:ListItem>
                                                    <asp:ListItem>Con Fotografia</asp:ListItem>
                                                </asp:DropDownList></td>
                                        </tr>
                                        <tr>
                                            <td colspan="5">
                                                <asp:Label ID="lb_valida_claves" runat="server" Font-Names="Arial" ForeColor="Red" CssClass="ErrorMessage"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <table id="TABLE1" border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td style="height: 15px">
                                                            <asp:RegularExpressionValidator ID="ER_nom" runat="server" ControlToValidate="txt_nomLector"
                                                                Display="Dynamic" ErrorMessage="Error Nombre Instalador: Se aceptan sólo letras!"
                                                                ValidationExpression="[a-zA-Z]{3,50}([\s]{0,1}[a-zA-Z]{0,50})([\s]{0,1}[a-zA-Z]{0,50})([\s]{0,1}[a-zA-Z]{0,50})([\s]{0,1}[a-zA-Z]{0,50})" CssClass="ErrorMessage"></asp:RegularExpressionValidator></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:RegularExpressionValidator ID="ER_ape" runat="server" ControlToValidate="txt_apeLector"
                                                                Display="Dynamic" ErrorMessage="Error Apellido Instalador: Se aceptan sólo letras!"
                                                                ValidationExpression="[a-zA-Z]{3,50}([\s]{0,1}[a-zA-Z]{0,50})([\s]{0,1}[a-zA-Z]{0,50})([\s]{0,1}[a-zA-Z]{0,50})" CssClass="ErrorMessage"></asp:RegularExpressionValidator></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:RegularExpressionValidator ID="ER_codLector" runat="server" ControlToValidate="txt_codLector"
                                                                Display="Dynamic" ErrorMessage="Error Código Instalador: se aceptan sólo numéricos!"
                                                                ValidationExpression="^([0-9]{1,6})$" CssClass="ErrorMessage"></asp:RegularExpressionValidator></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:RegularExpressionValidator ID="ER_Claveadmin" runat="server" ControlToValidate="txt_claveAdmin"
                                                                Display="Dynamic" ErrorMessage="Error Clave Administrador: se aceptan sólo alfanuméricos!"
                                                                ValidationExpression="^([0-9a-zA-Z]{1,8})$" CssClass="ErrorMessage"></asp:RegularExpressionValidator></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:RegularExpressionValidator ID="ER_ClaveLector" runat="server" ControlToValidate="txt_ClaveInstalador"
                                                                Display="Dynamic" ErrorMessage="Error Clave Instalador: se aceptan sólo alfanuméricos!"
                                                                ValidationExpression="^([0-9a-zA-Z]{1,6})$" CssClass="ErrorMessage"></asp:RegularExpressionValidator></td>
                                                    </tr>
                                                </table>
                                                <asp:RegularExpressionValidator ID="ER_email" runat="server" ControlToValidate="txt_email"
                                                    ErrorMessage="Error email: Email inválido!" Font-Names="Arial" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"></asp:RegularExpressionValidator></td>
                                            <td class="auto-style24"></td>
                                            <td class="auto-style25">
                                                <asp:Label ID="lb_id_cortador" runat="server" Visible="False"></asp:Label></td>
                                            <td class="auto-style23">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="right" style="height: 16px">&nbsp;</td>
                                            <td class="auto-style12"></td>
                                            <td colspan="2" style="height: 16px">

                                                <asp:Button ID="btn_Actualiza" runat="server" CssClass="botonnew" Text="Guardar Cambios" Width="113px" OnClick="btn_Actualiza_Click" />
                                                <asp:Button ID="btnNewEdit" runat="server" CausesValidation="False" CssClass="botonnew"
                                                    Text="Volver a editar" />
                                                <asp:Button ID="btn_volver" runat="server" CssClass="botonnew" Text="<< Volver" CausesValidation="False" /></td>
                                        </tr>
                                    </table>

                                </td>
                            </tr>
                            <tr>
                                <td colspan="2"></td>
                            </tr>
                        </table>
                    </div>
                    <img id="img_ok" runat="server" src="fotos/ok.bmp" /><asp:Label ID="lb_mensaje_edicion"
                        runat="server" Font-Names="Arial Unicode MS" CssClass="Label" Font-Size="Small" ForeColor="#0000C0" Width="415px"></asp:Label>
                    <asp:Label ID="lb_error" runat="server" CssClass="ErrorMessage" Font-Names="Arial Unicode MS"
                        Font-Size="Small" ForeColor="Red"></asp:Label></td>
            </tr>
        </table>

    </div>



</asp:Content>

