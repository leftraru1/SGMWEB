<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ZonasUsuarios.aspx.vb" Inherits="ZonasUsuarios" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" id="docx" runat="server" >
<head runat="server">
    <title>Zonas de Usuario - Sistema CYR</title>
    <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/others.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/style.css"/>   
    
<%--    <script language="JavaScript1.2">
window.moveTo(0,0);
top.window.resizeTo(screen.availWidth,screen.availHeight);
</script> --%>
      
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table style="WIDTH: 700px; HEIGHT: 285px" cellSpacing="0" cellPadding="0"
				align="center" border="0">
        <tr>
            <td style="width: 701px">
                <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                    Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                        Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                            Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
        </tr>
				<tr>
					<td style="WIDTH: 701px" align="left">
						<DIV class="WebPartShadow">
							<DIV class="WebPartTitle">
                                Zonas Por Usuarios</DIV>
							<table style="WIDTH: 537px; HEIGHT: 159px" cellSpacing="4" align="center" border="0">
                                <tr>
                                    <td align="center" colspan="2" nowrap="nowrap" style="height: 15px">
                                        <asp:LinkButton ID="lk_AgregaPerfil" runat="server" Font-Bold="True" ForeColor="#0000C0" Visible="False">Agregar Perfil</asp:LinkButton></td>
                                </tr>
								<tr>
									<td style="HEIGHT: 15px" noWrap align="left" colSpan="2">
										<h2>Por favor, seleccione Usuario para&nbsp;editar zonas:&nbsp;&nbsp;<asp:DropDownList
                                                ID="comboUsuario" runat="server" CssClass="ComboBox" Width="190px" AutoPostBack="True">
                                            </asp:DropDownList>
											<asp:button id="BtnVerPermisos" runat="server" Text="Ver Permisos" CssClass="botonnew" Width="96px"></asp:button></h2>
									</td>
								</tr>
								<tr>
									<TD style="HEIGHT: 9px" colSpan="2" align="left">
                                        <asp:Label ID="lb_perfil_usuario" runat="server"></asp:Label>
                                        <asp:Label ID="lb_Perfil_Actual" runat="server" Font-Bold="True" Font-Names="Arial"
                                            ForeColor="Black"></asp:Label></TD>
								</tr>
                                <tr>
                                    <td align="left" colspan="2" style="height: 9px; text-align: right">
                                        <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" ForeColor="Blue">Marcar Todos</asp:LinkButton>
                                        &nbsp;
                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" ForeColor="Blue">Desmarcar Todos</asp:LinkButton>
                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</td>
                                </tr>
								<tr>
									<TD style="HEIGHT: 3px" align="left" colSpan="2"><asp:datagrid id="GrillaPermisos" runat="server" CssClass="GridAlternativeItems" Width="560px" AutoGenerateColumns="False" BackColor="Black" CellSpacing="1" ForeColor="Black" GridLines="Horizontal" Height="1px" BorderWidth="0px" CellPadding="1">
											<HeaderStyle HorizontalAlign="Center" BackColor="Control" Font-Underline="True"></HeaderStyle>
											<Columns>
												<asp:BoundColumn DataField="id_usuario" HeaderText="id_usuario" Visible="False">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" BackColor="CornflowerBlue" ForeColor="White" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="id_zona" HeaderText="id_zona" Visible="False">
                                                    <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                        Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                                </asp:BoundColumn>
												<asp:BoundColumn DataField="nombre" HeaderText="Zona">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Width="50%" BackColor="CornflowerBlue" ForeColor="White" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" HorizontalAlign="Center" />
                                                </asp:BoundColumn>
												<asp:TemplateColumn HeaderText="Acceso">
													<HeaderStyle Font-Bold="True" Width="30%" BackColor="CornflowerBlue" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="White"></HeaderStyle>
													<ItemStyle HorizontalAlign="Center" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"></ItemStyle>
													<ItemTemplate>
														&nbsp;
														<asp:CheckBox id="checkPermiso" runat="server"></asp:CheckBox>
													</ItemTemplate>
												</asp:TemplateColumn>
											</Columns>
                                        <PagerStyle BackColor="Control" Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                        <ItemStyle BackColor="White" />
                                        <AlternatingItemStyle BackColor="White" />
										</asp:datagrid>
                                        <asp:Image ID="img_ok" runat="server" ImageUrl="fotos/ok.bmp" /><asp:Label ID="lb_mensaje"
                                            runat="server" Font-Names="Arial Unicode MS" ForeColor="#0000C0" Width="352px" Font-Size="Small"></asp:Label>
                                        <asp:Label ID="lb_error" runat="server" CssClass="ErrorMessage" Font-Names="Arial Unicode MS"
                                            Font-Size="Small" ForeColor="Red" Height="18px"></asp:Label></TD>
								</tr>
                                <tr>
                                    <td align="right" colspan="2" style="text-align: left">
                                        </td>
                                </tr>
								<TR>
									<TD colSpan="2" align="right">
                                        <asp:Label ID="lb_id_usuario" runat="server"></asp:Label>
                                        <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label>&nbsp;<asp:button id="ActulizaPerfil" runat="server" Text="Actualizar Zonas" CssClass="botonnew" Width="122px"></asp:button>
                        <asp:Button ID="btnVolver" runat="server" CssClass="botonnew" Text="<< Volver" Width="115px" />
                                    </TD>
								</TR>
							</table>
						</DIV>
                        &nbsp;&nbsp;&nbsp;
                        </td>
				</tr>
			</table>
    
    </div>
    </form>
</body>
</html>
