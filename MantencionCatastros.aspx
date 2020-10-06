<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MantencionCatastros.aspx.vb" Inherits="MantencionCatastros" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Mantenedor de Catastros - Sistema CYR</title>
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
            height: 143px" width="758">
            <tr>
                <td style="width: 732px">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 732px; height: 559px;" align="left">
                    <div class="WebPartShadow_ext" style="text-align: center">
                        <div id="titulo_mod" runat="server" class="WebPartTitle_ext">
                            Mantenedor de Catastros</div>
                        <table align="center" border="0" cellspacing="4" style="width: 709px; height: 93px"
                            width="709">
                            <tr>
                                <td align="left" colspan="2" nowrap="nowrap" style="width: 760px; height: 15px">
                                    <asp:LinkButton ID="catastro_Agregar" runat="server" CausesValidation="False">Agregar Catastro</asp:LinkButton>&nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                                    &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="2" nowrap="nowrap" style="width: 760px; height: 15px">
                                    <asp:Label ID="lb_perfil_usuario" runat="server"></asp:Label>
                                    <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label></td>
                            </tr>
                            <tr style="color: #000000">
                                <td align="center" colspan="2" style="width: 760px; height: 3px; text-align: left;">
                                    &nbsp;<asp:Label ID="LB_REGISTROS" runat="server" Text="0 coincidencia(s) encontrada(s)"
                                        Width="314px"></asp:Label>
                                    <asp:DataGrid ID="GrillaCatastros" runat="server" OnDeleteCommand="cmDelete" OnEditCommand="MyDataGrid_Edit" AllowSorting="True"
                                        AutoGenerateColumns="False" CssClass="GridAlternativeItems" Height="1px" PageSize="6" Width="756px" BorderWidth="0px" CellPadding="1" CellSpacing="1" GridLines="Horizontal">
                                        <HeaderStyle BackColor="Control" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="True" ForeColor="Black" HorizontalAlign="Center" />
                                        <Columns>
                                            <asp:BoundColumn DataField="id_catastro" HeaderText="IDCatastro" Visible="False">
                                                <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="cod_catastro" HeaderText="Codigo Catastro">
                                                <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="descripcion" FooterText="sfgdgf" HeaderText="Descripci&#243;n Catastro">
                                                <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="rut_empresa" HeaderText="RutEmpresa" Visible="False">
                                                <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="nom_empresa" HeaderText="Empresa">
                                                <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="estado_catastro" HeaderText="Estado Catastro">
                                                <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                            </asp:BoundColumn>
                                            <asp:EditCommandColumn CancelText="Cancel" EditText="Editar" UpdateText="Update" HeaderText="Modificar">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" ForeColor="#3300CC" />
                                                <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                            </asp:EditCommandColumn>
                                            <asp:ButtonColumn CommandName="Delete" Text="Eliminar" HeaderText="Eliminar">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" ForeColor="#3300CC" />
                                                <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                            </asp:ButtonColumn>
                                        </Columns>
                                        <EditItemStyle Font-Bold="False" BackColor="Honeydew" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                        <PagerStyle Mode="NumericPages" NextPageText="Siguientes" PrevPageText="Anteriores" BackColor="Control" Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                        <AlternatingItemStyle BackColor="White" />
                                        <ItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                    </asp:DataGrid></td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="width: 760px; height: 224px;">
                                    <strong>
                                        <table id="tbl_NuevoCatastro" runat="server" style="width: 710px">
                                            <tr>
                                                <td align="left" colspan="5" style="width: 12%; height: 4px">
                                                    <asp:Label ID="lb_codigo_repetido" runat="server" ForeColor="Red" Text="Código de catastro existe en la Base de Datos! Elija Otro." Font-Bold="False" Font-Names="Arial" Width="472px"></asp:Label></td>                                                
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 12%; height: 4px">                                                
                                                   Codigo Catastro:&nbsp;</td>
                                                <td align="left" style="width: 35%; height: 4px" colspan="4">
                                                    <asp:TextBox ID="txt_codigo" runat="server" CssClass="TextBox" Width="200px" MaxLength="3"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rq_codigo" runat="server" ErrorMessage="*" ControlToValidate="txt_codigo"></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Sólo caracteres alfanuméricos!" ControlToValidate="txt_codigo" ValidationExpression="^([0-9a-zA-Z]{1,3})$" Font-Bold="False" Font-Names="Arial"></asp:RegularExpressionValidator></td>                                              
                                            </tr>
                                            <tr>
                                                <td align="right" style="height: 21px">
                                                    Descripción Catastro:&nbsp;</td>
                                                <td align="left" colspan="4" style="height: 21px">
                                                    <asp:TextBox ID="txt_descripcion" runat="server" CssClass="TextBox" ForeColor="ControlText"
                                                        Width="328px" MaxLength="50" TabIndex="1"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rq_descripcion" runat="server" ErrorMessage="*" ControlToValidate="txt_descripcion"></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Sólo caracteres alfanuméricos!" ControlToValidate="txt_descripcion" ValidationExpression="^([0-9a-zA-Z]{1,50})([\s]{0,1}[0-9a-zA-Z]{0,50})([\s]{0,1}[0-9a-zA-Z]{0,50})([\s]{0,1}[0-9a-zA-Z]{0,50})([\s]{0,1}[0-9a-zA-Z]{0,50})([\s]{0,1}[0-9a-zA-Z]{0,50})([\s]{0,1}[0-9a-zA-Z]{0,50})$" Font-Bold="False" Font-Names="Arial"></asp:RegularExpressionValidator></td>                                             
                                            </tr>
                                            <tr>
                                                <td align="right" style="height: 12px">
                                                    &nbsp;Tipo Catastro:&nbsp;
                                                </td>
                                                <td align="left" colspan="4" style="width: 926px; height: 12px">
                                                    <asp:DropDownList ID="cbo_tipoCatastro" runat="server" CssClass="ComboBox" Width="328px" TabIndex="3">
                                                    </asp:DropDownList></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="height: 12px">
                                                </td>
                                                <td align="right" style="width: 926px; height: 12px" colspan="4">
                                                    &nbsp;<asp:Button ID="btn_ok_ingreso" runat="server" CssClass="Button" Text="Aceptar" Width="128px" CausesValidation="False" TabIndex="6" />
                                                    <asp:Button ID="btn_agrega_catastro" runat="server" CssClass="Button" Text="Agregar Catastro" Width="128px" TabIndex="4" />
                                                    <asp:Button ID="Btn_Cancelar" runat="server" CssClass="Button" Text="Cancelar" Width="128px" CausesValidation="False" TabIndex="5" /></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="height: 12px">
                                                </td>
                                                <td align="right" colspan="4" style="width: 926px; height: 12px">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="height: 12px">
                                                    <asp:Label ID="lbl_text" runat="server" Text="Digite Respuesta:" Visible="False"></asp:Label>&nbsp;</td>
                                                <td align="right" colspan="4" style="width: 926px; height: 12px; text-align: left">
                                                    <asp:TextBox ID="txt_pregunta" runat="server" CssClass="TextBox" Visible="False"
                                                        Width="328px" ValidationGroup="2" TabIndex="7"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_pregunta"
                                        ErrorMessage="*" ValidationGroup="2" Visible="False"></asp:RequiredFieldValidator></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="height: 12px">
                                                    <asp:TextBox ID="MAX_ID_CATASTRO" runat="server" Height="8px" Visible="False" Width="56px"></asp:TextBox></td>
                                                <td align="right" colspan="4" style="width: 926px; height: 12px">
                                    <asp:Button ID="btn_clean" runat="server" Text="Nueva Respuesta. <" ValidationGroup="2"
                                        Width="128px" Visible="False" TabIndex="8" />
                                                    <asp:Button ID="btn_guardar" runat="server" TabIndex="9" Text="Guardar" ValidationGroup="2"
                                        Width="128px" Visible="False" Height="24px" />&nbsp;
                                    <asp:Button ID="btn_cancel" runat="server" Text="Volver" ValidationGroup="2"
                                        Width="128px" Visible="False" TabIndex="10" /></td>
                                            </tr>
                                            <tr>
                                                <td align="right" colspan="5" style="height: 12px; text-align: left">
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
                                            <tr>
                                                <td colspan="5" align="center" style="height: 12px; text-align: left;">
                                                    <img id="img_ok" runat="server" src="fotos/ok.bmp" /><asp:Label ID="lb_mensaje_ingreso"
                                                        runat="server" Font-Bold="False" Font-Names="Arial" Width="456px"></asp:Label></td>                                                                                              
                                            </tr>
                                        </table>
                                    </strong>
                                    <asp:Label ID="lb_id_usuario" runat="server"></asp:Label></td>
                            </tr>
                        </table>
                    </div>
                    &nbsp;
                    </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Button ID="btnVolver" runat="server" CssClass="Button" Text="<< Volver Menu" Width="120px" CausesValidation="False" /></td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
