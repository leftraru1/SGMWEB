<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ModificarCatastro.aspx.vb" Inherits="ModificarCatastro" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link type="text/css" rel="stylesheet" href="estilos/page.css">
      <link type="text/css" rel="stylesheet" href="estilos/controls.css">
      <link type="text/css" rel="stylesheet" href="estilos/grid.css">
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css">
      <link type="text/css" rel="stylesheet" href="estilos/menu.css">
      <link type="text/css" rel="stylesheet" href="estilos/others.css">   
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 758px;
            height: 152px" width="758">
            <tr>
                <td style="width: 732px">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 732px; height: 446px;">
                    <div class="WebPartShadow">
                        <div id="titulo_mod" runat="server" class="WebPartTitle">
                            <strong>Modific</strong>ación d<strong>e Catastro</strong></div>
                        <table align="center" border="0" cellspacing="4" style="width: 709px; height: 107px"
                            width="709">
                            <tr>
                                <td align="left" colspan="2" nowrap="nowrap" style="height: 15px">
                                    <h2>
                                        <asp:Label ID="lb_minihead" runat="server" Text="Por favor, seleccione los datos de Usuario a modificar:"></asp:Label></h2>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2">
                                    <table id="tbl_NuevoUser" runat="server" style="font-weight: bold; width: 710px">
                                        <tr>
                                            <td align="left" colspan="5" style="width: 710px; height: 4px">
                                                <h2>
                                                    (*) Campos Obligatorios</h2>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" colspan="1" style="width: 25%; height: 1px">
                                                <h2>
                                                    &nbsp;Código catastro:&nbsp;
                                                </h2>
                                            </td>
                                            <td align="left" colspan="4" style="width: 75%; height: 1px">
                                                &nbsp;
                                                <input id="txt_codigo" runat="server" class="TextBox" type="text" maxlength="3" />
                                                <asp:RequiredFieldValidator ID="rq_nombre" runat="server" ControlToValidate="txt_codigo"
                                                    ErrorMessage="*"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="ER_nom" runat="server" ControlToValidate="txt_codigo"
                                                                Display="Dynamic" ErrorMessage="Sólo caracteres alfanuméricos!"
                                                                Font-Bold="False" ValidationExpression="^([0-9a-zA-Z]{1,3})$"></asp:RegularExpressionValidator></td>                                                                                        
                                        </tr>
                                        <tr>
                                            <td align="right" style="height: 1px">
                                                <h2>
                                                    Descripcion catastro:&nbsp;</h2>
                                            </td>
                                            <td align="left" colspan="4" style="height: 1px">
                                                &nbsp;
                                                <asp:TextBox ID="txt_descripcion" runat="server" CssClass="TextBox" Width="200px" MaxLength="50"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_descripcion"
                                                    ErrorMessage="*"></asp:RequiredFieldValidator>&nbsp;
                                                            <asp:RegularExpressionValidator ID="ER_login" runat="server" ControlToValidate="txt_descripcion"
                                                                Display="Dynamic" ErrorMessage="Sólo caracteres alfanuméricos!"
                                                                Font-Bold="False" ValidationExpression="^([0-9a-zA-Z]{1,50})([\s]{0,1}[0-9a-zA-Z]{0,50})([\s]{0,1}[0-9a-zA-Z]{0,50})([\s]{0,1}[0-9a-zA-Z]{0,50})([\s]{0,1}[0-9a-zA-Z]{0,50})([\s]{0,1}[0-9a-zA-Z]{0,50})([\s]{0,1}[0-9a-zA-Z]{0,50})$"></asp:RegularExpressionValidator></td>                                         
                                        </tr>
                                        <tr>
                                            <td align="right" style="height: 12px">
                                                <h2>
                                                    Estado catastro:&nbsp;</h2>
                                            </td>
                                            <td align="left" colspan="4" style="width: 926px; height: 12px">
                                                &nbsp;&nbsp;<asp:DropDownList ID="combo_estados" runat="server" CssClass="ComboBox"
                                                    Width="200px">
                                                </asp:DropDownList>&nbsp;
                                                <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label>
                                                <asp:Label ID="lb_id_usuario" runat="server"></asp:Label></td>                                           
                                        </tr>
                                        <tr>
                                            <td align="right" style="height: 12px">
                                                <h2> Tipo Catastro:&nbsp;</h2>
                                            </td>
                                            <td align="left" colspan="4" style="width: 926px; height: 12px">
                                                &nbsp;
                                                <asp:DropDownList ID="cbo_tipoCatastro" runat="server" CssClass="ComboBox" Width="296px" AutoPostBack="True">
                                                </asp:DropDownList></td>
                                        </tr>
                                        <tr>
                                            <td align="left" colspan="5" style="height: 17px">
                                                <asp:Label ID="lb_ValidaEstado" runat="server" Font-Bold="False" Font-Names="Arial" ForeColor="Red" Width="696px"></asp:Label></td>                                        
                                        </tr>
                                        <tr>
                                            <td align="right" colspan="5" style="height: 17px">
                                                &nbsp;<asp:Button ID="btn_actualiza" runat="server" CssClass="Button" Text="Actualizar datos"
                                                    Width="120px" />
                                                <asp:Button ID="Btn_newEDIT" runat="server" CausesValidation="False" CssClass="Button"
                                                    Text="Volver a Editar" Width="120px" />
                                                <asp:Button ID="btnVolver" runat="server" CausesValidation="False" CssClass="Button"
                                                    Text="<< Volver" Width="120px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" colspan="5" style="height: 17px">
                                                <asp:Button ID="btn_clean" runat="server" CssClass="Button" Height="24px" TabIndex="8"
                                                    Text="Ingresar Nueva Respuesta" ValidationGroup="2" Visible="False" Width="152px" /><asp:Button
                                                        ID="btn_guardar" runat="server" CssClass="Button" Height="24px" TabIndex="9"
                                                        Text="Guardar" ValidationGroup="2" Visible="False" Width="120px" /></td>
                                        </tr>
                                        <tr>
                                            <td align="right" colspan="5" style="height: 17px; text-align: center">
                                                <asp:Label ID="lbl_text" runat="server" Text="Digite Respuesta:" Visible="False"></asp:Label>
                                                <asp:TextBox ID="txt_pregunta" runat="server" CssClass="TextBox" TabIndex="7" ValidationGroup="2"
                                                    Visible="False" Width="296px"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txt_pregunta"
                                                    ErrorMessage="*" ValidationGroup="2"></asp:RequiredFieldValidator></td>
                                        </tr>
                                    </table>
                                    &nbsp;
                                    <img id="img_ok" runat="server" src="fotos/ok.bmp" />
                                    <asp:Label ID="lb_mensaje_edicion" runat="server" Font-Names="Arial" Width="420px"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="text-align: left">
                                    <asp:Label ID="lbl_respuestas_seleccion" runat="server" Font-Bold="True" Text="Respuestas Catastro Seleccion."
                                        Visible="False" CssClass="WebPartTitle"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2">
                                    <asp:DataGrid ID="grilla_respuesta" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                                        CellPadding="1" CellSpacing="1" CssClass="GridPager" Height="1px" OnDeleteCommand="cmDelete_respuesta"
                                        PageSize="4" Width="696px">
                                        <PagerStyle BackColor="Control" Font-Bold="True" Mode="NumericPages" />
                                        <ItemStyle BackColor="White" />
                                        <Columns>
                                            <asp:BoundColumn DataField="id_respuesta_catastro" HeaderText="id_respuesta_catastro"
                                                Visible="False">
                                                <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="respuesta" HeaderText="Respuesta Seleccion Catastro">
                                                <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" ForeColor="White" Width="50%" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" />
                                            </asp:BoundColumn>
                                            <asp:ButtonColumn CommandName="Delete" HeaderText="Eliminar" Text="Eliminar">
                                                <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" ForeColor="White" Width="50%" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" ForeColor="#3300CC" HorizontalAlign="Center" />
                                            </asp:ButtonColumn>
                                        </Columns>
                                        <HeaderStyle BackColor="Control" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" ForeColor="Black" HorizontalAlign="Center" />
                                    </asp:DataGrid></td>
                            </tr>
                        </table>
                    </div>
                    <asp:TextBox ID="MAX_ID_CATASTRO" runat="server" Width="8px" Visible="False"></asp:TextBox></td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
