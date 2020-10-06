<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MantencionEmail.aspx.vb" Inherits="MantencionEmail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Mantención de Correo Electrónico - Sistema CYR</title>
      <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/others.css"/>  
      <link type="text/css" rel="stylesheet" href="estilos/style.css"/>       
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 950px;
            height: 152px">
            <tr>
                <td style="width: 732px">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 732px">
                    <div class="WebPartShadow_analizador">
                        <div id="titulo_mod" runat="server" class="WebPartTitle_analizador">
                            Mantenedor de Email (Visor estado de mensajes):</div>
                        <table align="center" border="0" cellspacing="0" class="punteado" style="width: 709px;
                            height: 1px" width="709">
                            <tr>
                                <td align="center" colspan="2" nowrap="nowrap" style="width: 709px; height: 15px">
                                    </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" nowrap="nowrap" style="height: 15px">
                                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" Font-Bold="False"
                                        Font-Names="Arial Unicode MS" Font-Size="Small" ForeColor="Blue">Agregar E-mail</asp:LinkButton></td>
                            </tr>
                            <tr>
                                <td align="left" colspan="2" style="width: 709px; height: 3px">
                                    <asp:Label ID="lb_cantidad_registros" runat="server" CssClass="Label" Text="coincidencia(s) encontrada(s)"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="width: 709px; height: 1px">
                                    <asp:GridView ID="GrillaEmail" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                        Font-Names="Arial Unicode MS" Font-Size="X-Small" ForeColor="#333333" GridLines="None" Width="892px">
                                        <RowStyle BackColor="#EFF3FB" />
                                        <Columns>
                                            <asp:BoundField DataField="id_correo" HeaderText="ID" >
                                                <ItemStyle Width="10%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="id_zona" HeaderText="id_zona" Visible="False" />
                                            <asp:BoundField DataField="nom_zona" HeaderText="Nombre Zona" >
                                                <ItemStyle Width="15%" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Nombre Destinatario">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Eval("nom_destinatario") %>' Font-Names="Arial Unicode MS" Font-Size="X-Small"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rq_nombre" runat="server" ControlToValidate="TextBox2"
                                                        ErrorMessage="(*)" Display="Dynamic"></asp:RequiredFieldValidator>
                                                    <br />
                                                    <asp:RegularExpressionValidator ID="ER_nom" runat="server" ControlToValidate="TextBox2"
                                                        Display="Dynamic" ErrorMessage="Sólo letras!" Font-Bold="False" Font-Names="Arial Unicode MS"
                                                        Font-Size="X-Small" ValidationExpression="[a-zA-Z]{2,50}([\s]{0,3}[a-zA-Z]{0,50})([\s]{0,3}[a-zA-Z]{0,50})"></asp:RegularExpressionValidator>
                                                </ItemTemplate>
                                                <ItemStyle Width="20%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Correo Destinatario">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Eval("CORREO") %>' Font-Names="Arial Unicode MS" Font-Size="X-Small"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rq_mail" runat="server" ControlToValidate="TextBox1"
                                                        ErrorMessage="(*)" Display="Dynamic"></asp:RequiredFieldValidator>
                                                    <br />
                                                    <asp:RegularExpressionValidator ID="ER_email" runat="server" ControlToValidate="TextBox1"
                                                        ErrorMessage="Mail inválido!" Font-Bold="False" Font-Names="Arial Unicode MS"
                                                        Font-Size="X-Small" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                </ItemTemplate>
                                                <ItemStyle Width="20%" />
                                            </asp:TemplateField>     
                                            <asp:BoundField DataField="rut_empresa" HeaderText="Empresa">
                                                <ItemStyle Width="15%" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Eliminar">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Delete" OnClientClick="return confirm('Esta seguro que desea eliminar el registro?');" ImageUrl="~/img/eliminar.png" />
                                                </ItemTemplate>
                                                <ItemStyle Width="20%" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <EditRowStyle BackColor="#2461BF" />
                                        <AlternatingRowStyle BackColor="White" />
                                    </asp:GridView>
                                    &nbsp;&nbsp;</td>
                            </tr>
                            <tr>
                                <td align="left" colspan="2" style="width: 709px; height: 2px">
                                    <img id="img_ok" runat="server" src="fotos/ok.bmp" />
                                    <asp:Label ID="lb_mensaje_update" runat="server" CssClass="Label" Font-Names="Arial Unicode MS"
                                        Font-Size="Small" ForeColor="#0000C0" Width="440px"></asp:Label><asp:Label ID="lb_error"
                                            runat="server" CssClass="Label" Font-Names="Arial Unicode MS" Font-Size="Small"
                                            ForeColor="Red" Height="18px"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="width: 709px">
                                    <strong></strong>&nbsp;&nbsp;
                                    <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label></td>
                            </tr>
                            <tr id="row_aceptar_ok" runat="server">
                                <td align="right" colspan="2" style="height: 21px;">
                                    &nbsp;<asp:Button ID="BtnActualizar" runat="server" CssClass="botonnew"
                                        Text="Actualizar Emails" Width="117px" />
                                    <asp:Button ID="BtnVolver" runat="server" CausesValidation="False" CssClass="botonnew"
                                        Text="<< Volver " /></td>
                            </tr>
                        </table>
                    </div>
                  </td>
            </tr>
            <tr>
                <td style="width: 732px">                
                              <div class="WebPartShadow_analizador">
                        <div id="Div1" runat="server" class="WebPartTitle_analizador">
                            Mantenedor de Email (Notificaciones del Sistema):</div>
                        <table align="center" border="0" cellspacing="0" class="punteado" style="width: 709px;
                            height: 1px" width="709">
                            <tr>
                                <td align="center" colspan="2" nowrap="nowrap" style="width: 709px; height: 15px">
                                    </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" nowrap="nowrap" style="height: 15px">
                                    <asp:LinkButton ID="lk_notificacion" runat="server" CausesValidation="False" Font-Bold="False"
                                        Font-Names="Arial Unicode MS" Font-Size="Small" ForeColor="Blue">Agregar E-mail Notificación</asp:LinkButton></td>
                            </tr>
                            <tr>
                                <td align="left" colspan="2" style="width: 709px; height: 3px">
                                    <asp:Label ID="lb_cantidad_registros2" runat="server" CssClass="Label" Text="coincidencia(s) encontrada(s)"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="width: 709px; height: 1px">
                                    <asp:GridView ID="GrillaEmailNot" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                        Font-Names="Arial Unicode MS" Font-Size="X-Small" ForeColor="#333333" GridLines="None" Width="892px">
                                        <RowStyle BackColor="#EFF3FB" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="ENVIA">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txt_envia" runat="server" Font-Names="Arial Unicode MS" Font-Size="X-Small" Text='<%# Eval("ENVIA") %>'></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rq_envia" runat="server" ControlToValidate="txt_envia"
                                                        Display="Dynamic" ErrorMessage="(*)"></asp:RequiredFieldValidator>
                                                    <br />
                                                    <asp:RegularExpressionValidator ID="ER_email_envia" runat="server" ControlToValidate="txt_envia"
                                                        Display="Dynamic" ErrorMessage="Mail inválido!" Font-Bold="False" Font-Names="Arial Unicode MS"
                                                        Font-Size="X-Small" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"></asp:RegularExpressionValidator>
                                                </ItemTemplate>
                                                <ItemStyle Width="21%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="RECIBE">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txt_recibe" runat="server" Text='<%# Eval("RECIBE") %>' Font-Names="Arial Unicode MS" Font-Size="X-Small"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rq_recibe" runat="server" ControlToValidate="txt_recibe"
                                                        ErrorMessage="(*)" Display="Dynamic"></asp:RequiredFieldValidator>
                                                    <br />
                                                    <asp:RegularExpressionValidator ID="ER_email_recibe" runat="server" ControlToValidate="txt_recibe"
                                                        ErrorMessage="Mail inválido!" Font-Bold="False" Font-Names="Arial Unicode MS"
                                                        Font-Size="X-Small" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                </ItemTemplate>
                                                <ItemStyle Width="21%" />
                                            </asp:TemplateField>     
                                            <asp:TemplateField HeaderText="HOST">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txt_host" runat="server" Text='<%# Eval("HOST") %>' Font-Names="Arial Unicode MS" Font-Size="X-Small" style="text-align:center;" ></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rq_nombre" runat="server" ControlToValidate="txt_host"
                                                        ErrorMessage="(*)" Display="Dynamic"></asp:RequiredFieldValidator>
                                                    <br />
                                                    <asp:RegularExpressionValidator ID="ER_nom" runat="server" ControlToValidate="txt_host"
                                                        Display="Dynamic" ErrorMessage="IP no válida!" Font-Bold="False" Font-Names="Arial Unicode MS"
                                                        Font-Size="X-Small" ValidationExpression="^(\d){1,3}\.(\d){1,3}\.(\d){1,3}\.(\d){1,3}$"></asp:RegularExpressionValidator>
                                                </ItemTemplate>
                                                <ItemStyle Width="23%" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="RUT_EMPRESA" HeaderText="RUT EMPRESA">
                                                <ItemStyle Width="0%" />
                                            </asp:BoundField>
                                            <asp:BoundField HeaderText="EMPRESA">
                                                <ItemStyle Width="20%" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Eliminar">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Delete" OnClientClick="return confirm('Esta seguro que desea eliminar el registro?');" ImageUrl="~/img/eliminar.png" />
                                                </ItemTemplate>
                                                <ItemStyle Width="15%" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <EditRowStyle BackColor="#2461BF" />
                                        <AlternatingRowStyle BackColor="White" />
                                    </asp:GridView>
                                    &nbsp;&nbsp;</td>
                            </tr>
                            <tr>
                                <td align="left" colspan="2" style="width: 709px; height: 2px">
                                    <img id="img_ok2" runat="server" src="fotos/ok.bmp" />
                                    <asp:Label ID="lb_mensaje_update2" runat="server" CssClass="Label" Font-Names="Arial Unicode MS"
                                        Font-Size="Small" ForeColor="#0000C0" Width="440px"></asp:Label><asp:Label ID="lb_error2"
                                            runat="server" CssClass="Label" Font-Names="Arial Unicode MS" Font-Size="Small"
                                            ForeColor="Red" Height="18px"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="width: 709px">
                                    <strong></strong>&nbsp;&nbsp;
                                    </td>
                            </tr>
                            <tr id="Tr1" runat="server">
                                <td align="right" colspan="2" style="height: 21px;">
                                    &nbsp;<asp:Button ID="btnActualizar2" runat="server" CssClass="botonnew"
                                        Text="Actualizar Emails" Width="117px" />
                                    <asp:Button ID="Button2" runat="server" CausesValidation="False" CssClass="botonnew"
                                        Text="<< Volver " /></td>
                            </tr>
                        </table>
                    </div>               
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
