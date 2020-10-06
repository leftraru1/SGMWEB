<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MantencionDiasCierrerepo.aspx.vb" Inherits="MantencionDiasCierrerepo" AspCompat="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html id="doc_html" xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Mantenedor dias cierre de reposiciones - Sistema CYR</title>
      <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/others.css"/>  
        <link type="text/css" rel="stylesheet" href="estilos/style.css"/>   
    
<%--<style type="text/css">
body {
margin:0;
width: 100%;
height: 100%;
}
</style>--%>

<%--<script type="text/javascript" language="JavaScript1.2">
window.moveTo(0,0);
top.window.resizeTo(screen.availWidth,screen.availHeight);

</script>    --%>   
    

      <script type="text/javascript" language="Javascript">    
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
                                Mantenedor Días Cierre Reposiciones</DIV>                                
							<table style="WIDTH: 709px; HEIGHT: 1px" cellSpacing="0" width="709" align="center" border="0" class="punteado">
                                <tr>
                                    <td align="right" colspan="2" nowrap="nowrap" style="height: 15px; width: 709px;">
                                            </td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="2" style="height: 3px; width: 709px;">
                                        <asp:Label ID="lb_cantidad_registros" runat="server" Text="coincidencia(s) encontrada(s)" CssClass="Label"></asp:Label></td>
                                </tr>
								<tr>
									<TD style="HEIGHT: 1px; width: 709px;" align="center" colSpan="2">
                                        &nbsp;<asp:DataGrid ID="Grillaprioridad" runat="server" AutoGenerateColumns="False"
                                            CssClass="GridPager" Width="214px" Height="1px"  BorderWidth="0px" CellPadding="1" CellSpacing="1">
                                            <HeaderStyle HorizontalAlign="Center" BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                            <Columns>
                                                <asp:BoundColumn DataField="id_cierre_repo" HeaderText="id_cierre_repo" Visible="False">
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                        Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" />
                                                </asp:BoundColumn>
                                                <asp:TemplateColumn HeaderText="D&#237;as Cierre Reposici&#243;n">
                                                    <ItemTemplate>
                                                        <center><asp:TextBox ID="txt_dia" runat="server" CssClass="TextBox" MaxLength="2" Text='<%# Eval("dias_reposiciones") %>'
                                                            Width="60px"></asp:TextBox><asp:RequiredFieldValidator ID="rq_lectura" runat="server"
                                                                ControlToValidate="txt_dia" Display="Dynamic" ErrorMessage="*"></asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                                                    ID="rqexp_LECTURA" runat="server" ControlToValidate="txt_dia" Display="Dynamic"
                                                                    ErrorMessage="Sólo números" Font-Size="XX-Small" ValidationExpression="^([0-9]{1,12})$"></asp:RegularExpressionValidator>
                                                                    </center>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Width="50%" />
                                                </asp:TemplateColumn>
                                            </Columns>
                                            <PagerStyle BackColor="Control" Font-Bold="True" />
                                            <ItemStyle BackColor="White" />
                                        </asp:DataGrid>&nbsp;</TD>
								</tr>
                                <tr>
                                    <td align="left" colspan="2" style="height: 2px; width: 709px;">
                                        <img src="fotos/ok.bmp" runat="server" id="img_ok"/>
                                        <asp:Label ID="lb_mensaje_ingreso" runat="server" Width="440px" Font-Names="Arial Unicode MS" CssClass="Label" Font-Size="Small" ForeColor="#0000C0"></asp:Label><asp:Label
                                            ID="lb_error" runat="server" CssClass="Label" Font-Names="Arial Unicode MS" Font-Size="Small"
                                            ForeColor="Red" Height="18px"></asp:Label></td>
                                </tr>
								<TR>
									<TD colSpan="2" align="center" style="width: 709px"><STRONG>
                                    </STRONG>&nbsp;&nbsp;
                                    </TD>
								</TR>
                                <tr id="row_aceptar_ok" runat="server">
                                    <td align="right" colspan="2" style="width: 709px; height: 21px;">
                                        <asp:Button ID="btnok_modificar" runat="server" CssClass="botonnew" Text="Actualizar Día" CausesValidation="False" />
                                        <asp:Button ID="btnvolver_agregar" runat="server" CssClass="botonnew" Text="<< Volver " CausesValidation="False"/></td>
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
