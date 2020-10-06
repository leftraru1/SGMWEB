<%@ Page Language="VB" AutoEventWireup="false" CodeFile="GestionOperativaOtras.aspx.vb" Inherits="GestionOperativaOtras" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Informe Gestión Operativa</title>
      <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/others.css"/>

    <script type="text/javascript" language="javascript"> 
              
              function mostrardiv() 
                {
                div = document.getElementById('flotante');
                div.style.display =""; 
                }
 
              function cerrar() 
                {
                div = document.getElementById('flotante');
                div.style.display='none'; 
                }
    </script>    
       
</head>
<body onload="javascript:cerrar();">
    <form id="form1" runat="server">    
    <div id="flotante"><h3>Cargando información. Espere un momento por favor....</h3></div>
        <iframe width="920px" height="1400px" id="panel" runat="server" scrolling="auto" frameborder="0">        
        </iframe>
    </form>
</body>
</html>
