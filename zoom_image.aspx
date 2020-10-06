<%@ Page Language="VB" AutoEventWireup="false" CodeFile="zoom_image.aspx.vb" Inherits="zoom_image" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">



<html xmlns="http://www.w3.org/1999/xhtml" > 
<head id="Head1" runat="server"> 


<title>Visor Fotografico - Sistema CYR </title> 

      <link type="text/css" rel="stylesheet" href="estilos/page.css">
      <link type="text/css" rel="stylesheet" href="estilos/controls.css">
      <link type="text/css" rel="stylesheet" href="estilos/grid.css">
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css">
      <link type="text/css" rel="stylesheet" href="estilos/menu.css">
      
<script type="text/javascript" src="js/tjpzoom.js"></script>

<script language="JavaScript" type="text/JavaScript">

// transition effect. number between 0 and 23, 23 is random effect
effect = 23; 

// transition duration. number of seconds effect lasts
duration = 1.5; 

// seconds to diaply each image?
display = 4;

// width of stage (first image)
oW = 600;

// height of stage
oH = 500;

// zoom width by (add or subtracts this many pixels from image width)
zW = 60;

// zoom height by 
zH = 50;

// path to image/name of image in slide show. this will also preload all images
// each element in the array must be in sequential order starting with zero (0)
SLIDES = new Array();

SLIDES[0]  = ["/images/js/04b.jpg", "Office"];
SLIDES[1]  = ["/images/js/06b.jpg", "Front left"];
SLIDES[2]  = ["/images/js/07b.jpg", "Back left"];
SLIDES[3]  = ["/images/js/08b.jpg", "Sign"];
SLIDES[4]  = ["/images/js/09b.jpg", "Front left close up"];
SLIDES[5]  = ["/images/js/10b.jpg", "Office color board"];
SLIDES[6]  = ["/images/js/11b.jpg", "Back right"];
SLIDES[7]  = ["/images/js/12b.jpg", "Back middle"];

// end required modifications

S = new Array();
for(a = 0; a < SLIDES.length; a++){
	S[a] = new Image(); S[a].src  = SLIDES[a][0];
}

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

//DIFUMINADO


//FIN DIFUMINADO


//-->
</script>

</head> 
<body onload="setupZoom()" id="image1"> 

<form id="form1" runat="server"> 
<div style="text-align: center"> &nbsp;<div id="Div1" runat="server" class="WebPartTitle_analizador" style="text-align: left; width: 912px;">
    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></div>
</div> 

 <br/>


    

   
    
     <table runat="server" bgcolor=CornflowerBlue border=0 cellpadding=3 cellspacing=0 style="border: white outset 2px; text-align: center;" width=400 id="TABLE1">
     
<form name=_slideShow>
    &nbsp;
<tr>
<td>
<table border=0 bgcolor=#fcf9e8 cellpadding=0 cellspacing=0 style="border: white inset 2px;" width=100%><tr><td align=center style="text-align: center; height: 36px;">
    &nbsp;<img src=/images/js/toolsep.gif width=5 height=32 alt="" border=0><a href=javascript:; onclick="rotar(document.getElementById('image2'),360);"><img alt="" border=0 id="IMG9" style="width: 48px; height: 40px;" language="javascript" onclick="return IMG9_onclick()" src="fotos/zoom_girar360.gif"></a> <a href=javascript:; onclick=" rotar(document.getElementById('image2'),180);"><img alt="" border=0 id="IMG8" style="width: 48px; height: 40px;" src="fotos/zoom_girar180.gif"></a> <a href=javascript:; onclick="zoom(zW, zH)"><img src="fotos/zoom_in.gif" alt="" border=0 id="IMG1" style="width: 48px; height: 40px;"></a> <a href=javascript:; onclick="zoom(-zW, -zH)"><img src="fotos/zoom_out.gif" alt="" border=0 style="width: 40px; height: 40px;"></a> <img src=/images/js/toolsep.gif width=5 height=32 alt="" border=0> <a href=javascript:; onclick="zoom('')"><img src="fotos/zoom_reset.gif" alt="" border=0 style="width: 40px; height: 40px;"></a> 
    <asp:ImageButton ID="ImageButton1" runat="server" Height="40px" ImageUrl="~/fotos/zoom_detalle.png" Width="40px" /></td></tr></table></td></tr><tr><td><table border=0 cellpadding=0 cellspacing=0 style="border: white inset 2px;" id="image1"><tr><td style="width: 29px">
   

    <img src="" runat="server" style="filter: revealtrans()" name="stage" id="image2"  /></td></tr></table>




    </td></tr></form></table>

   
   
<table id="Table_detalle" runat="server">
    <tr>
        <td colspan="3" style="text-align: center; width: 87px;">
    <asp:ImageButton ID="ImageButton2" runat="server" Height="24px" ImageUrl="~/fotos/back.png"
        Width="32px" CssClass="imagebutton" ToolTip="Vuelve a Imagen Inicial" Visible="False"/></td>
    </tr>
    <tr>
    <td colspan="3" style="width: 87px">
<div style="margin:20px; text-align: center;">
    &nbsp;
<img src="" runat="server" onmouseover="TJPzoom(this)" alt="" id="unique113" visible="false"/>&nbsp;&nbsp;</div>
        &nbsp;</td>
    </tr></table>









<script>
<!--

f = document._slideShow;
n = 0;
t = 0;

document.images["stage"].width  = oW;
document.images["stage"].height = oH;
f.delay.value = display;

// add image numbers to select menu
f.wichIm.options.length = 0;
for(i in SLIDES){
	f.wichIm.options[i] = new Option(SLIDES[i][1],i);
}

function startSS(){
	t = setTimeout("runSS(" + f.currSlide.value + ")", 1 * 1);
}

function runSS(n){
	n++;
	if(n >= SLIDES.length){
		n = 0;
	}
	document.images["stage"].src = S[n].src;
	if(document.all && navigator.userAgent.indexOf("Opera") < 0 && navigator.userAgent.indexOf("Windows") >= 0){
		document.images["stage"].style.visibility = "hidden";
		document.images["stage"].filters.item(0).apply();
		document.images["stage"].filters.item(0).transition = effect;
		document.images["stage"].style.visibility = "visible";
		document.images["stage"].filters(0).play(duration);
	}
	f.currSlide.value = n;
	f.wichIm[n].selected = true;
	t = setTimeout("runSS(" + f.currSlide.value + ")", f.delay.value * 1000);
}

function stopSS(){
	if(t){
		t = clearTimeout(t);
	}
}

function nextSS(){
	stopSS();
	n = f.currSlide.value;
	n++;
	if(n >= SLIDES.length){
		n = 0;
	}
	if(n < 0){
		n = SLIDES.length - 1;
	}
	document.images["stage"].src = S[n].src;
	f.currSlide.value = n;
	f.wichIm[n].selected = true;
	if(document.all && navigator.userAgent.indexOf("Opera") < 0 && navigator.userAgent.indexOf("Windows") >= 0){
		document.images["stage"].style.visibility = "hidden";
		document.images["stage"].filters.item(0).apply();
		document.images["stage"].filters.item(0).transition = effect;
		document.images["stage"].style.visibility = "visible";
		document.images["stage"].filters(0).play(duration);
	}
}

function prevSS(){
	stopSS();
	n = f.currSlide.value;
	n--;
	if(n >= SLIDES.length){
		n = 0;
	}
	if(n < 0){
		n = SLIDES.length - 1;
	}
	document.images["stage"].src = S[n].src;
	f.currSlide.value = n;
	f.wichIm[n].selected = true;
	
	if(document.all && navigator.userAgent.indexOf("Opera") < 0 && navigator.userAgent.indexOf("Windows") >= 0){
		document.images["stage"].style.visibility = "hidden";
		document.images["stage"].filters.item(0).apply();
		document.images["stage"].filters.item(0).transition = effect;
		document.images["stage"].style.visibility = "visible";
		document.images["stage"].filters(0).play(duration);
	}
}

function selected(n){
	stopSS();
	document.images["stage"].src = S[n].src;
	f.currSlide.value = n;
	
	if(document.all && navigator.userAgent.indexOf("Opera") < 0 && navigator.userAgent.indexOf("Windows") >= 0){
		document.images["stage"].style.visibility = "hidden";
		document.images["stage"].filters.item(0).apply();
		document.images["stage"].filters.item(0).transition = effect;
		document.images["stage"].style.visibility = "visible";
		document.images["stage"].filters(0).play(duration);
	}
}

function zoom(dim1, dim2){
	if(dim1){
		if(document.images["stage"].width < oW){
			document.images["stage"].width   = oW;
			document.images["stage"].height  = oH;
		} else {
			document.images["stage"].width  += dim1;
			document.images["stage"].height += dim2;
		}
		if(dim1 < 0){
			if(document.images["stage"].width < oW){
				document.images["stage"].width   = oW;
				document.images["stage"].height  = oH;
			}
		}
	} else {
		document.images["stage"].width   = oW;
		document.images["stage"].height  = oH;
	}
}




// -->
</script>
   
   
</form> 

</body> 
</html> 

