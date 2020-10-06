<%@ Page Language="VB" AutoEventWireup="false" CodeFile="zoom_imageCorte.aspx.vb" Inherits="zoom_image_Corte" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html dir="ltr" xmlns="http://www.w3.org/1999/xhtml" xmlns:b="http://www.google.com/2005/gml/b" xmlns:data="http://www.google.com/2005/gml/data" xmlns:expr="http://www.google.com/2005/gml/expr"><head>

<meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>

<link href="http://feeds2.feedburner.com/nihilogic" rel="alternate" title="Manipulación Fotografias - Sistema SGL" type="application/rss+xml"/>
<link href="http://feeds2.feedburner.com/nihilogic_games" rel="alternate" title="JavaScript Gaming" type="application/rss+xml"/>
<link href="http://feeds2.feedburner.com/nihilogic_links" rel="alternate" title="Nihilogic - Links" type="application/rss+xml"/>

<link rel="stylesheet" type="text/css"/>
<link href="js/styles_labs.css" rel="stylesheet" type="text/css"/>



<script type="text/javascript">
window.google_analytics_uacct = "UA-3940914-2";
</script>
<script type="text/javascript" src="js/ga.js"></script>
<script type="text/javascript">
var pageTracker = _gat._getTracker("UA-3940914-2");
pageTracker._initData();
pageTracker._trackPageview();
</script>

<script type="text/javascript">
//ROTAR IMAGENES.
function rotar(obj,angulo){
    if (angulo >= 0) {
        var rotation = Math.PI * angulo / 180;
    } else {
        var rotation = Math.PI * (360+angulo) / 180;
    }
    var costheta = Math.cos(rotation);
    var sintheta = Math.sin(rotation);
    if (document.createElement("canvas").getContext) {
    /* ---- canvas ---- */ 
        var c=document.createElement('canvas');
        c.width = Math.abs(costheta*obj.width) + Math.abs(sintheta*obj.height);
        c.style.width = c.width+'px';
        c.height = Math.abs(costheta*obj.height) + Math.abs(sintheta*obj.width);
        c.style.height=c.height+'px';
        c.id=obj.id;
        c.style.position='absolute';
        var ctx=c.getContext('2d');
        ctx.save();
        if (rotation <= Math.PI/2) {
            ctx.translate(sintheta*obj.height,0);
        } else if (rotation <= Math.PI) {
            ctx.translate(c.width,-costheta*obj.height);
        } else if (rotation <= 1.5*Math.PI) {
            ctx.translate(-costheta*obj.width,c.height);
        } else {
            ctx.translate(0,-sintheta*obj.width);
        }
        ctx.rotate(rotation);
        ctx.drawImage(obj, 0, 0, obj.width, obj.height);
        obj.parentNode.replaceChild(c,obj);
        ctx.restore();
    }else{
    /* ---- DXImageTransform ---- */
        obj.style.position='absolute';
        obj.style.filter="progid:DXImageTransform.Microsoft.Matrix(sizingMethod='auto expand')";
        obj.filters.item(0).M11 = costheta;
        obj.filters.item(0).M12 = -sintheta;
        obj.filters.item(0).M21 = sintheta;
        obj.filters.item(0).M22 = costheta;
    }
}

//FIN ROTAR IMAGENES

</script>



<style type="text/css">
          a.tooltip{font:15px Geneva, Arial, Helvetica, sans-serif; color:#003300; text-decoration:none;}
          a.tooltip:hover{border-bottom: 1px dotted #003300;}
          a.tooltip:hover {text-decoration:none;}
          a.tooltip span {display:none; margin:0 0 0 10px; padding:5px 5px; }
          a.tooltip:hover span{display:inline; position:absolute; border:1px solid #0000FF; background:#0000FF; color:#003300 !important;}
</style>

<link href="js/SyntaxHighlighter.css" rel="stylesheet" type="text/css" />
<script src="js/syntax.js" type="text/javascript"></script>

 <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/others.css"/>

<script src="js/jquery.js" type="text/javascript"></script>
<script src="js/jquery.imageLens.js" type="text/javascript"></script>

<%--zoom--%>
<%--<script type="text/javascript" language="javascript">
		$(function () {
			$("#img_01").imageLens();
			$("#filterimage").imageLens({ lensSize: 200 });
			$("#img_03").imageLens({ imageSrc: "sample01.jpg" });
			$("#img_04").imageLens({ borderSize: 8, borderColor: "#06f" });
		});	
		
	</script>--%>
	
	
<script type="text/javascript" language="javascript">
		function zoom_lupa() {
//			$("#img_01").imageLens();
			("filterimage").imageLens({ lensSize: 200 });
//			$("#img_03").imageLens({ imageSrc: "sample01.jpg" });
//			$("#img_04").imageLens({ borderSize: 8, borderColor: "#06f" });
		});	
	
</script>	

	
<script type="text/javascript" src="js/tjpzoom.js"></script>
<script type="text/javascript" src="js/tjpzoom.js"></script>
<script type="text/javascript" language="javascript">

function cambiaTamanio(){
  if (document.images) {
    document.images.filterimage.width=1000;
    document.images.filterimage.height=1500;
  } else {
    filterimage = document.getElementById("filterimage");
    filterimage.width = 1000;
    filterimage.height = 1500;
  }
}
</script>
<script type="text/javascript" src="js/slide.js"></script>
<script type="text/javascript" src="js/urchin.js"></script>
<script type="text/javascript" src="js/imagefx.js"></script>
<script type="text/javascript" src="js/imagefx_none.js"></script>
<script type="text/javascript" src="js/imagefx_invert.js"></script>
<script type="text/javascript" src="js/imagefx_desaturate.js"></script>
<script type="text/javascript" src="js/imagefx_blur.js"></script>
<script type="text/javascript" src="js/imagefx_blurfast.js"></script>
<script type="text/javascript" src="js/imagefx_blurmore.js"></script>
<script type="text/javascript" src="js/imagefx_blurmotion.js"></script>
<script type="text/javascript" src="js/imagefx_sharpen.js"></script>
<script type="text/javascript" src="js/imagefx_sharpenmore.js"></script>
<script type="text/javascript" src="js/imagefx_emboss.js"></script>
<script type="text/javascript" src="js/imagefx_fliphorizontal.js"></script>
<script type="text/javascript" src="js/imagefx_flipvertical.js"></script>
<script type="text/javascript" src="js/imagefx_noise.js"></script>
<script type="text/javascript" src="js/imagefx_lighten.js"></script>
<script type="text/javascript" src="js/imagefx_laplace.js"></script>
<script type="text/javascript" src="js/imagefx_edges.js"></script>
<script type="text/javascript" src="js/imagefx_brightness.js"></script>
<script type="text/javascript" src="js/imagefx_sepia.js"></script>
<script type="text/javascript" src="js/imagefx_histogram.js"></script>

<script type="text/javascript">

function filter(strFilter) 
{
//	document.getElementById("filterimagecontainer").innerHTML = "<img src=\"malcom.jpg\" id=\"filterimage\"/>"
	jsImageFX.doImage(document.getElementById("filterimage"), strFilter);
}
</script>



<link rel="stylesheet" type="text/css" href="js/common.css"/>
<link rel="stylesheet" type="text/css" href="js/styles.css"/>

<title>Manipulacion de Fotografias Sistema - SGL</title>

<%--<style type="text">

#cse-search-box input[type="submit"] {
  font-family : Trebuchet MS, sans-serif;
  background-color: #20282A; color: #d1d1d1; font-weight:bold; border: 1px solid #747E7F;
}

#cse-search-box input[type="text"] {
  font-family : Trebuchet MS, sans-serif;
  height : 16px;
  position : relative;
  top : 1px;
}

</style>--%>



<script src="js/s_4463f2678d7e07eb78efac5525cfc028.js" id="_bsap_js_4463f2678d7e07eb78efac5525cfc028" type="text/javascript"></script><style type="text/css">.dp-xml .cdata { color: #ff1493; }.dp-xml .tag, .dp-xml .tag-name { color: #069; font-weight: bold; }.dp-xml .attribute { color: red; }.dp-xml .attribute-value { color: blue; }</style><style type="text/css">.dp-xml .cdata { color: #ff1493; }.dp-xml .tag, .dp-xml .tag-name { color: #069; font-weight: bold; }.dp-xml .attribute { color: red; }.dp-xml .attribute-value { color: blue; }</style>




</head>
<body >
<form id="form1" runat="server">

<div id="outer-wrapper" style="text-align: center">
    <table align="center" border="0" cellpadding="0" cellspacing="0">
              <tr>
                  <td align="left">
                      <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                          Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                              Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                  Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                      ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label>
                      <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label></td>
              </tr>
              <tr>
                  <td style="text-align: center">
                      <div style="text-align: center">
                          <div id="Div1" runat="server" class="WebPartTitle" style="text-align: left">
                              Zoom Fotografia</div>
                          <table id="TABLE1" border="0" cellpadding="0" cellspacing="0" onclick="return TABLE1_onclick()">
                              <tr>
                                  <td style="height: 254px">
                                      <div>
                                          <table align="center" border="0" cellspacing="0" style="width: 828px; height: 1px">
                                              <tr id="Tr1" runat="server">
                                                  <td align="left" colspan="2" nowrap="nowrap" style="width: 41%; height: 1px">
                   
                                                      <h2>
                                                      
                                                      
                                                      
                                                     

</h2>
                            <img src="fotos/book_open.png" runat="server" id="blur" height="20" title="Flip Horizontal" width="30" visible="false" />
                            <img src="fotos/book_open.png" runat="server" id="blurfast" height="20" title="Flip Horizontal" width="30" visible="false" />
                            <img src="fotos/book_open.png" runat="server" id="blurmore" height="20" title="Flip Horizontal" width="30" visible="false" />
                                                      <img src="fotos/book_open.png" runat="server" id="sharpen" height="20" title="Flip Horizontal" width="30" visible="false" />
                                                      <img src="fotos/book_open.png" runat="server" id="sharpenmore" height="20" title="Flip Horizontal" width="30" visible="false" />
                            <img src="fotos/book_open.png" runat="server" id="emboss" height="20" title="Flip Horizontal" width="30" visible="false" />
                            <img src="fotos/book_open.png" runat="server" id="laplace" height="20" title="Flip Horizontal" width="30" visible="false" />
                            <img src="fotos/book_open.png" runat="server" id="laplacecontrast" height="20" title="Flip Horizontal" width="30" visible="false" />
                            <img src="fotos/book_open.png" runat="server" id="laplacecontrast05" height="20" title="Flip Horizontal" width="30" visible="false" />
                            <img src="fotos/book_open.png" runat="server" id="noise" height="20" title="Flip Horizontal" width="30" visible="false" />
                            <img src="fotos/book_open.png" runat="server" id="noise05" height="20" title="Flip Horizontal" width="30" visible="false" /></td>
                                              </tr>
                                          </table>
                                      </div>

<img alt="fotografia" runat="server" id="filterimage" height="947" width="1200" /></td>
                              </tr>
                          </table>
                          &nbsp;&nbsp;
                      </div>

<div class="sampleimage">


	
<center>

<div id="filterimagecontainer" >
<p>
    &nbsp;</p>

<div id="ocultar_caracter_zoom" runat = "server">
<%--<pre>$("#filterimage").imageLens();</pre>--%>
</div>

</div>
</center>

</div>
                      <br />
                      &nbsp;</td>
              </tr>
          </table>

<div id="wrap2">
    <div id="header-wrapper">
      <div class="header section" id="header">
   <div class="widget Header" id="Header1">
          <div id="header-inner">
              &nbsp;<div id="search-div">
              
<!--
<form action='/search' id='searchthis' method='get' style='display:inline; align: right;'>
<input id='search-box' name='q' onfocus='javascript:document.getElementById("search-box").value="";' size='25' style='background-color: #20282a; color: #f1f1f1; border: 1px solid #747E7F; padding: 1px;' type='text' value='Search...'/>
<input id='search-btn' style='background-color: #20282A; color: #d1d1d1; font-weight:bold; border: 1px solid #747E7F;/' type='submit' value='>>'/>
</form>
-->



<%--<form action="http://www.nihilogic.dk/search/" id="cse-search-box" >
 

</form>--%>
<script type="text/javascript" src="js/brand">function TABLE1_onclick() {

}

</script> 

</div>

<div class="titlewrapper">
<span class="title">
</span></div>


<div class="descriptionwrapper" style="text-align: center">
    &nbsp;</div>



          </div>
        </div> 

      </div>
    </div>
    <div id="content-wrapper">

      <div id="main-wrapper" style="text-align: center">
    &nbsp;

</form>
</body></html>