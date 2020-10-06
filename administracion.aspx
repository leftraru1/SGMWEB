<%@ Page Language="VB" AutoEventWireup="false" CodeFile="administracion.aspx.vb" Inherits="administracion" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>:: Acceso al Sistema CYR</title>
    <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/others.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/style.css"/> 
     <link rel="shortcut icon" href="./fotos/icoGasco.png" type="image/x-icon" />
    
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />  
<meta name="description" content="Sistema XHTML y CSS para centrar una web en pantalla, vertical y horizontalmente, siempre visible y sin usar tablas" />  
<style media="screen" type="text/css">  
html, body {  
    height:100%;  
    margin:0;  
}  
body {  
    position:relative;  
    min-width:700px;  
    min-height:500px;  
}  
#contenido {  
    position:absolute;  
  
    width:700px;  
    height:500px;  
    top:50%;  
    left:50%;  
    margin-top:-250px;  
    margin-left:-350px;  
}  
</style>  
<!--[if lte IE 6.0]>  
<style>  
#contenido {  
    top:expression(document.body.clientHeight < 501? "0px": "50%" );  
    margin-top:expression(document.body.clientHeight < 501? "0px": "-250px" );  
    left:expression(document.body.clientWidth < 701? "0px": "50%" );  
    margin-left:expression(document.body.clientWidth < 701? "0px": "-350px" );  
</style>  
<![endif]-->  
   

<%--<script type="text/javascript" language="JavaScript1.2">
window.moveTo(0,0);
top.window.resizeTo(screen.availWidth,screen.availHeight);
</script>   --%>
    
</head>

<%--<body style="position: absolute; text-align: center;">--%>
<body>

<div id="contenido">
     <form id="form1" runat="server">
      <center>
    <table border="0" cellpadding="1" cellspacing="4" align="center" style="width: 95%"><tr><td class="TitleBorderCell" width="15%" nowrap align="center" style="height: 34px"><h1 class="AppTitle" style="text-align: center">&nbsp;Sistema de Corte y Reposicion (CYR)&nbsp;- Version 3.2</h1></td><td class="TitleBorderCell" style="width: 5%; height: 34px;"><img src="fotos/gasco.png">&nbsp;</td></tr>
    </table>
  
    
   
        <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtusuario"
                        ErrorMessage="Usuario: Es necesario Ingresar su valor " Font-Size="Small"></asp:RequiredFieldValidator><br/>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtpass"
                        ErrorMessage="Contraseña: Es necesario Ingresar su valor " Font-Size="Small"></asp:RequiredFieldValidator><br/>
    <div style="text-align: center">

<table border="0" cellpadding="0" cellspacing="0" width="34%" align="Center" ><tr><td><DIV class="WebPartShadow"><div class="WebPartTitle" style="text-align: left">Control de Acceso</DIV><table border="0" width="98%" align="center" cellspacing="4"><tr><td align="left" colspan="2" nowrap><h2>Por favor, introduzca su nombre de usuario y contraseña</h2></td></tr><tr><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td></tr><tr><TD colspan=2><table border=0 width=100%><tr>
<TD nowrap align="right" width="35%">
<span class="Label">
<span class="Required">*</SPAN>
Usuario</SPAN>&nbsp;&nbsp;&nbsp;&nbsp;</TD>
<td nowrap valign="top" align="left" width="65%">
                    <asp:TextBox ID="txtusuario" runat="server" class="TextBox" MaxLength="40" CssClass="TextBox"></asp:TextBox></TD>
</tr></table></td>
</tr><tr><TD colspan=2><table border=0 width=100%><tr>
<td nowrap align="right" width="35%">
<span class="Label">
<span class="Required">*</span>
Contraseña</span>&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td nowrap vAlign="top" align="left" style="width: 65%">
                    <asp:TextBox ID="txtpass" runat="server" TextMode="Password" class="TextBox" MaxLength="40" CssClass="TextBox"></asp:TextBox></TD>
</tr></table></td>
</tr><tr><td colspan="2" align="right">
                    <asp:Label ID="lb_mensaje" runat="server" ForeColor="Red" CssClass="Label"></asp:Label>
                    <asp:Button ID="btnEntrar" runat="server" Text="Entrar" class="Button" CssClass="Button" />
    </td></tr></table></DIV>
    <asp:Label ID="lb_id_usuario" runat="server" CssClass="Label"></asp:Label>
    <asp:Label ID="lb_rut_empresa" runat="server" CssClass="Label"></asp:Label></td></tr>
</table>

    </div>
        <br />
        <table border="0" cellpadding="0" cellspacing="0" class="punteado">
            <tr>
                <td colspan="3" style="height: 20px" align="center" class="punteado">
                <a target="_blank" href="Descargas/ManualCapturador.aspx" style="color: #0000ff; background-color: #f5f5f5">
                    Ayuda - Utilitarios Capturador</a>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <br />
        <br />
        <br />
        <table border="0" cellpadding="0" cellspacing="0" class="punteado">
            <tr>
                <td style="height: 19px">
                </td>
            </tr>
            <tr>
                <td style="height: 15px">
                    <asp:Label ID="lb_acerca1" runat="server" Font-Size="X-Small" Text="www.alcia.cl®copyright 2013 - Política de Privacidad" Font-Names="Arial"></asp:Label></td>
            </tr>
            <tr>
                <td style="height: 13px">
                    <asp:Label ID="lb_acerca2" runat="server" Font-Size="X-Small" Text="Sitio desarrollado por ALCIA SOLUCIONES S.A." Font-Names="Arial"></asp:Label></td>
            </tr>
        </table>
        <br />
        <br />
        <br />
        <br />
        <br />
    
              </center>
            
   </form>
</div> 
</body>
</html>
