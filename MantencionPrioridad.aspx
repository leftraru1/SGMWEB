<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MantencionPrioridad.aspx.vb" Inherits="MantencionPrioridad" AspCompat="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html id="doc_html" xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Mantenedor de Prioridad - Sistema CYR</title>
      <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/others.css"/>  
        <link type="text/css" rel="stylesheet" href="estilos/style.css"/>   
    
<%--<script language="JavaScript1.2">
window.moveTo(0,0);
top.window.resizeTo(screen.availWidth,screen.availHeight);
</script>     --%>
    
      <script language="Javascript">    
 function valida(){
 if (document.form1.txt_nombre.value='') {
 alert('incorrecto');
 }
 else alert('Porfavor espere estamos procesando su pedido');
    }
 </script>

     
 
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <table style="WIDTH: 758px; HEIGHT: 152px" cellSpacing="0" cellPadding="0" width="758"
				align="center" border="0">
         <tr>
             <td style="width: 732px">
                 <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                     Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                         Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                             Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                 ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
         </tr>
				<tr>
					<td style="WIDTH: 732px">
						<DIV class="WebPartShadow">
							<DIV id="titulo_mod" class="WebPartTitle" runat="server">
                                Mantenedor Prioridad Horaria
                            </DIV>                                
							<table style="WIDTH: 709px; HEIGHT: 1px" cellSpacing="0" width="709" align="center" border="0">
                                <tr>
                                    <td align="right" colspan="2" nowrap="nowrap" style="height: 15px">
                                            </td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="2" style="height: 3px">
                                        <asp:Label ID="lb_cantidad_registros" runat="server" Text="coincidencia(s) encontrada(s)"
                                            Width="153px"></asp:Label></td>
                                </tr>
								<tr>
									<TD style="HEIGHT: 1px" align="center" colSpan="2">
                                        &nbsp;<asp:DataGrid ID="Grillaprioridad" runat="server" AutoGenerateColumns="False"
                                            CssClass="GridPager" Width="704px" Height="1px"  BorderWidth="0px" CellPadding="1" CellSpacing="1">
                                            <HeaderStyle HorizontalAlign="Center" BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                            <Columns>
                                                <asp:BoundColumn DataField="id_prioridad" HeaderText="id_prioridad" Visible="False">
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                        Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="Descripcion" HeaderText="Descripci&#243;n">
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                        Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Width="50%" />
                                                </asp:BoundColumn>
                                                <asp:TemplateColumn HeaderText="Hora">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txt_hora" runat="server" CssClass="TextBox" MaxLength="20" Text='<%# Eval("hora") %>'
                                                            Width="60px"></asp:TextBox><asp:RequiredFieldValidator ID="rq_lectura" runat="server"
                                                                ControlToValidate="txt_hora" Display="Dynamic" ErrorMessage="*"></asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                                                    ID="rqexp_LECTURA" runat="server" ControlToValidate="txt_hora" Display="Dynamic"
                                                                    ErrorMessage="Sólo números y Distintos de 0" Font-Size="XX-Small" ValidationExpression="^([1-9]{1,12})$" Width="130px"></asp:RegularExpressionValidator>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Width="50%" />
                                                </asp:TemplateColumn>
                                            </Columns>
                                            <PagerStyle BackColor="Control" Font-Bold="True" />
                                            <ItemStyle BackColor="White" />
                                        </asp:DataGrid>&nbsp;&nbsp;</TD>
								</tr>
                                <tr>
                                    <td align="left" colspan="2" style="height: 2px">
                                        <img src="fotos/ok.bmp" runat="server" id="img_ok"/>
                                        <asp:Label ID="lb_mensaje_ingreso" runat="server" Width="506px" Font-Names="Arial Unicode MS" Font-Size="Small" ForeColor="#0000C0"></asp:Label>
                                        <asp:Label ID="lb_error" runat="server" Font-Names="Arial Unicode MS" Font-Size="Small"
                                            ForeColor="Red"></asp:Label></td>
                                </tr>
								<TR>
									<TD colSpan="2" align="center"><STRONG>
                                    </STRONG>&nbsp;&nbsp;
                                    </TD>
								</TR>
                                <tr id="row_aceptar_ok" runat="server">
                                    <td align="right" colspan="2" style="height: 17px">
                                        <asp:Button ID="btnok_modificar" runat="server" CssClass="botonnew" Text="Actualizar Hora" Width="120px" CausesValidation="False" />
                                        <asp:Button ID="btnvolver_agregar" runat="server" CssClass="botonnew" Text="<< Volver" Width="120px" CausesValidation="False"/></td>
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
