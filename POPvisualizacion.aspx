<%@ Page Language="VB" AutoEventWireup="false" CodeFile="POPvisualizacion.aspx.vb" Inherits="POPvisualizacion" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" > 
<head runat="server"> 

 
 <title>Visor Fotografico - Sistema CYR </title> 
 
  
      <link type="text/css" rel="stylesheet" href="estilos/page.css">
      <link type="text/css" rel="stylesheet" href="estilos/controls.css">
      <link type="text/css" rel="stylesheet" href="estilos/grid.css">
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css">
      <link type="text/css" rel="stylesheet" href="estilos/menu.css">
      <link type="text/css" rel="stylesheet" href="estilos/others.css">
      
  <script type="text/javascript" language="javascript">  

      function Pophistorial(p_id_servicio)      
       {
       var url = 'GestionHistorica_analisis.aspx?idServicio='+p_id_servicio; 
       open(url,'DetalleLectura','top=20,left=100,width=1200,height=520,status=yes,resizable=yes');
       }  
            
      function PopDetalles(p_var_foto)      
       {
       var url = 'zoom_image.aspx?var_foto='+p_var_foto; 
       open(url,'DetalleLecturas','top=20,left=100,width=1200,height=700,status=yes,resizable=yes,scrollbars=no');
       }  
         


   </script>
    
</head> 
<body style="text-align: center"> 


<form id="form1" runat="server"> 
<div style="text-align: center"> <div id="Div1" runat="server" class="WebPartTitle_analizador" style="text-align: left; width: 912px;">
    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></div>
    <table cellspacing="0" style="width: 1px; text-align: left;" class="WebPartShadow_analizador" frame="border">
        <tr>
            <td colspan="7" style="height: 3px; text-align: left;">
                <div id="titulo_mod" runat="server" class="WebPartTitle_analizador" style="text-align: left; width: 912px;">
                    Detalle Fotografias</div>
              
                    
            
                    
            </td>
        </tr>
        <tr>
            <td align="right" style="width: 244px; height: 4px; text-align: right">
               <h2> <strong>  Localidad:</strong></h2></td>
            <td align="right" style="width: 384px; height: 4px; text-align: left;">
                <asp:Label ID="lbl_localidad" runat="server" Text="Label" Width="216px" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
            <td align="right" style="width: 92px; height: 4px; text-align: right">
             <h2> <strong>Lote:</strong></h2></td>
            <td colspan="4" style="height: 4px; text-align: left">
                <asp:Label ID="lbl_lote" runat="server" Text="Label" Width="256px" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
        </tr>
        <tr>
            <td align="right" style="width: 244px; height: 4px; text-align: right">
             <h2> <strong>     Ruta:</strong></h2></td>
            <td align="right" style="width: 384px; height: 4px; text-align: left;">
                <asp:Label ID="lbl_ruta" runat="server" Text="Label" Width="216px" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
            <td align="right" style="width: 92px; height: 4px; text-align: right">
               <h2> <strong>Servicio</strong></h2></td>
            <td colspan="4" style="height: 4px; text-align: left">
                <asp:Label ID="lbl_servicio" runat="server" Text="Label" Width="256px" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
        </tr>
        <tr>
            <td align="right" style="width: 244px; height: 4px">
               <h2> <strong> Medidor:</strong></h2></td>
            <td align="right" style="width: 384px; height: 4px; text-align: left;">
                <asp:Label ID="lbl_medidor" runat="server" Text="Label" Width="216px" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
            <td align="right" style="width: 92px; height: 4px">
               <h2> <strong>Mensaje:</strong></h2></td>
            <td colspan="4" style="height: 4px; text-align: left">
                <asp:Label ID="lbl_mensaje" runat="server" Text="Label" Width="256px" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
        </tr>
        <tr>
            <td align="right" style="width: 244px; height: 4px">
            
             <h2><strong>Lectura:</strong></h2> </td>
            <td align="right" style="width: 384px; height: 4px; text-align: left">
                <asp:Label ID="lbl_lectura" runat="server" Text="Label" Width="216px" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
            <td align="right" style="width: 92px; height: 4px">
               <h2> <strong> Cliente:</strong></h2></td>
            <td colspan="4" style="height: 4px; text-align: left">
                <asp:Label ID="lbl_cliente" runat="server" Text="Label" Width="256px" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
        </tr>
        <tr>
            <td align="right" style="width: 203px; height: 4px">
                <h2>
                    <strong>Direccion:</strong>
                </h2>
            </td>
            <td align="right" style="width: 384px; height: 4px; text-align: left">
                <asp:Label ID="lbl_direccion" runat="server" Font-Bold="True" Font-Names="Arial"
                    ForeColor="#0000C0" Text="Label" Width="352px"></asp:Label></td>
            <td align="right" style="width: 158px; height: 4px">
                <h2>
                    <strong>Lectura Anterior:</strong></h2>
            </td>
            <td colspan="4" style="height: 4px; text-align: left">
                <asp:Label ID="lbl_lect_anterior" runat="server" Font-Bold="True" Font-Names="Arial"
                    ForeColor="#0000C0" Text="Label" Width="216px"></asp:Label></td>
        </tr>
        <tr>
            <td align="right" style="width: 203px; height: 4px">
                <h2>
                    <strong>Clave Lectura:</strong></h2>
            </td>
            <td align="right" style="width: 384px; height: 4px; text-align: left">
                <asp:Label ID="lbl_clave_lectura" runat="server" Font-Bold="True" Font-Names="Arial"
                    ForeColor="#0000C0" Text="Label" Width="216px"></asp:Label></td>
            <td align="right" style="width: 158px; height: 4px">
                <h2>
                    <strong>Clave Observacion:</strong></h2>
            </td>
            <td colspan="4" style="height: 4px; text-align: left">
                <asp:Label ID="lbl_clave_observacion" runat="server" Font-Bold="True" Font-Names="Arial"
                    ForeColor="#0000C0" Text="Label" Width="216px"></asp:Label></td>
        </tr>
        <tr>
            <td align="right" style="width: 203px; height: 4px">
                <h2>
                    <strong>Historial: </strong>
                </h2>
            </td>
            <td align="right" style="width: 384px; height: 4px; text-align: left">
                <asp:ImageButton ID="img_historial" runat="server" ImageUrl="~/fotos/hoja.gif" Width="24px" />
                </td>
            <td align="right" style="width: 158px; height: 4px">
               <h2> <strong> Usuario Evaluador:</strong></h2> </td>
            <td colspan="4" style="height: 4px; text-align: left">
                <asp:Label ID="lbl_evaluador_inf" runat="server" Font-Bold="True" Font-Names="arial"
                    ForeColor="#0000C0" Text="Label" Width="256px"></asp:Label></td>
        </tr>
                    <tr>
                        <td align="right" style="width: 244px; height: 4px">
                        </td>
                        <td colspan="6" style="height: 4px; text-align: left">
                            <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label></td>
                    </tr>
        <tr>
            <td align="right" style="width: 244px; height: 4px">
                Evaluacion Fotografia:</td>
            <td colspan="6" style="height: 4px; text-align: left">
                <asp:DropDownList ID="combo_evaluar" runat="server" AutoPostBack="True" CssClass="ComboBox"
                    Width="456px">
                </asp:DropDownList>
                <asp:Button ID="btn_evaluar" runat="server" CssClass="Button" Text="Evaluar" Width="88px" />
                <asp:Button ID="btn_editar" runat="server" Text="Volver a Editar" CssClass="Button" Width="88px" />&nbsp;<asp:Button
                    ID="btnVolver" runat="server" CssClass="Button" Text="<< Volver" Width="88px" /></td>
        </tr>
        <tr>
            <td align="right" style="width: 244px; height: 4px">
                Clave Fotografia:</td>
            <td colspan="6" style="height: 4px; text-align: left">
                <asp:DropDownList ID="combo_clave_fotografia" runat="server" AutoPostBack="True" CssClass="ComboBox"
                    Width="456px">
                </asp:DropDownList>&nbsp;</td>
        </tr>
        <tr>
            <td align="right" style="width: 244px; height: 4px">
                <asp:Label ID="lbl_infcabezera" runat="server" Text="Tipo Evaluacion" CssClass="Label"></asp:Label></td>
            <td colspan="6" style="height: 4px; text-align: left">
                <asp:Label ID="lbl_tipoevaluacion" runat="server" Text="tipo_evaluacion" Width="456px" CssClass="Label" Font-Bold="True" Font-Names="ARIAL" ForeColor="Navy"></asp:Label>
                <asp:Label ID="lb_ID_PERFIL" runat="server"></asp:Label>
                <asp:Label ID="lb_id_usuario" runat="server" Text="lb_id_usuario"></asp:Label></td>
        </tr>
        <tr>
            <td colspan="7" style="height: 4px; text-align: left">
                <asp:Label ID="lb_error" runat="server" Font-Names="Arial" ForeColor="Red" Width="272px"></asp:Label>
                <img id="img_ok" runat="server" src="fotos/ok.bmp" style="height: 16px" visible="false" />
                <asp:Label ID="lb_mensaje" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="Navy"
                    Width="592px"></asp:Label></td>
        </tr>
    </table>
</div> 
    <table align="center" border="0" cellspacing="4" style="width: 86%">
        <tr>
            <td style="width: 1%; text-align: left">
                &nbsp;<asp:ImageButton ID="image1" runat="server" BorderStyle="Solid" Height="280px"
                    Visible="False" Width="368px" />
                <asp:Label ID="lbl1" runat="server" Text="Label" Visible="False"></asp:Label></td>
            <td width="1%">
                <asp:ImageButton ID="image2" runat="server" BorderStyle="Solid" Height="280px" Visible="False"
                    Width="368px" />
                <asp:Label ID="lbl2" runat="server" Text="Label" Visible="False"></asp:Label></td>
            <td width="1%">
                &nbsp;<asp:ImageButton ID="image3" runat="server" BorderStyle="Solid" Height="280px"
                    Visible="False" Width="368px" />
                <asp:Label ID="lbl3" runat="server" Text="Label" Visible="False"></asp:Label></td>
        </tr>
    </table>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;
    &nbsp; &nbsp; &nbsp; &nbsp;
    &nbsp; &nbsp; &nbsp;&nbsp;
</form> 
</body> 
</html> 

