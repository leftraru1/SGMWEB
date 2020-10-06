<%@ Page Language="VB"  CodeFile="Vistamensajepop.aspx.vb" Inherits="Vistamensajepop" %>

<script runat=server>
   
</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Visor Mensajes CYR</title>
      <link type="text/css" rel="stylesheet" href="estilos/page.css">
      <link type="text/css" rel="stylesheet" href="estilos/controls.css">
      <link type="text/css" rel="stylesheet" href="estilos/grid.css">
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css">
      <link type="text/css" rel="stylesheet" href="estilos/menu.css">
      <link type="text/css" rel="stylesheet" href="estilos/others.css">    
      
             
      
        <script type="text/javascript" language="javascript">    
       
     function openCalendar(obj)
      {
        var url = 'calendario.aspx?textbox=' + obj;
        window.open(url,'cal','width=260,height=210,left=280 70,top=80,resizable=0,scrollbars=0');
      }              
     function AbrirGrafico(pid_grupoproceso,pzonasfilter,pcod_localidadfilter,pruta_filter,plector_filter,pnom_lector,ptotal_lecturasproceso,pleidas,pefectivas,pimprocedentes,pbusqueda)
      {
       if (pbusqueda!='NADA') 
          { 
           var url = 'GraficoLoteLector.aspx?IDgrupoproceso=' + pid_grupoproceso + '&zonasfilter='  + pzonasfilter + '&localidadfilter=' + pcod_localidadfilter + '&ruta_filter=' + pruta_filter +  '&lector_filter=' + plector_filter + '&NomLector=' + pnom_lector  + '&lecturas_proceso=' + ptotal_lecturasproceso  + '&leidas=' + pleidas + '&efectivas=' + pefectivas + '&improcedentes=' + pimprocedentes + '&busqueda=' + pbusqueda;
           window.open(url,'cal','width=580,height=580,left=0,top=0,resizable=yes,scrollbars=0');
          }  
         else
          {
          alert('DEBE SELECCIONAR UN LOTE');
          }
      }    
       function AbrirGraficobarra(pid_grupoproceso,pzonasfilter,pcod_localidadfilter,pruta_filter,plector_filter,pnom_lector,ptotal_lecturasproceso,pleidas,pefectivas,pimprocedentes,pbusqueda)
      {
       if (pbusqueda!='NADA') 
          { 
           var url = 'GraficoBarra.aspx?IDgrupoproceso=' + pid_grupoproceso + '&zonasfilter='  + pzonasfilter + '&localidadfilter=' + pcod_localidadfilter + '&ruta_filter=' + pruta_filter +  '&lector_filter=' + plector_filter + '&NomLector=' + pnom_lector  + '&lecturas_proceso=' + ptotal_lecturasproceso  + '&leidas=' + pleidas + '&efectivas=' + pefectivas + '&improcedentes=' + pimprocedentes + '&busqueda=' + pbusqueda;
           window.open(url,'cal','width=720,height=250,left=0,top=0,resizable=yes,scrollbars=0');
          }  
         else
          {
          alert('DEBE SELECCIONAR UN LOTE');
          }
      } 
       function imprimir()
      {
        //var url = 'POPLectores.aspx?textbox=' + obj;
       // alert();
       window.print();
        //window.open(url,'cal','width=820,height=320,left=200,top=50,resizable=0,scrollbars=yes');
      }      




</script>
      
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <div>
            <table id="TABLE2" runat="server" align="center" border="0" cellpadding="0" cellspacing="0" style="width: 858px;
                height: 152px" class="WebPartShadow_ext">
                <tr>
                    <td align="right" style="width: 855px; text-align: left;">
                        <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                            Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                                Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                    Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                        ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label>&nbsp;
                    </td>
                </tr>
                <tr style="font-weight: bold">
                    <td style="width: 855px; height: 303px;">
                        <div class="WebPartShadow_more">
                            <div id="titulo_mod" runat="server" class="WebPartTitle_more">
                              <h2 class="WebPartTitle">  
                                    Visor Mensajes&nbsp;</h2>
                            </div>
                            <table id="tbl_ingreso_lector" runat="server" class="WebPartShadow_ext" style="width: 856px;
                                height: 41px">
                                &nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<tr>
                                    <td align="right" style="width: 162px; height: 17px">
                                        <h2>
                                            <strong>
                                                <asp:Image ID="Image1" runat="server" Height="16px" ImageUrl="~/fotos/book_open.png"
                                                    Width="24px" />
                                                &nbsp;Destinatario:&nbsp;</strong></h2>
                                    </td>
                                    <td colspan="4" style="height: 17px">
                                        <h2 style="text-align: left">
                                            <strong>
                                                <asp:TextBox ID="txt_lector" runat="server" CssClass="TextBox" Width="520px"></asp:TextBox></strong>&nbsp;</h2>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 162px; height: 17px">
                                        <h2>
                                            <strong>Asunto:&nbsp; </strong>
                                        </h2>
                                    </td>
                                    <td colspan="4" style="height: 17px; text-align: left">
                                        <strong>
                                            <asp:TextBox ID="txt_asunto" runat="server" CssClass="TextBox" MaxLength="50" Width="520px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txt_asunto"
                                                ErrorMessage="*" Width="1px"></asp:RequiredFieldValidator>
                                        </strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 162px; height: 17px; text-align: right">
                                        <strong> <h2><strong>
                                            &nbsp; &nbsp;&nbsp; Responder:&nbsp;</h2></strong></td>
                                    <td colspan="4" style="height: 17px; text-align: left">
                                        <asp:ImageButton ID="ImageButton1" runat="server" Height="16px" ImageUrl="~/fotos/book_go.png"
                                            Width="24px" /></td>
                                </tr>
                                <tr>
                                    <td colspan="5" style="height: 17px">
                                        <h2 style="text-align: left">
                                            <strong>&nbsp;&nbsp; Mensaje:</strong></h2>
                                        <h2 style="text-align: center">
                                            <strong>&nbsp; </strong>
                                            <asp:TextBox ID="txt_mensaje" runat="server" CssClass="TextBox" Height="96px" MaxLength="200"
                                                Width="728px" TextMode="MultiLine"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_mensaje"
                                                ErrorMessage="*" Width="1px"></asp:RequiredFieldValidator></h2>
                                        <h2>
                                            <strong>&nbsp; </strong>
                                        </h2>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="5" style="height: 8px; text-align: right">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="5" style="height: 8px; text-align: right">
                                        &nbsp;
                                        <asp:Button ID="btnVolver" runat="server" CssClass="botonnew" Text="Cerrar Ventana"
                                            Width="120px" />&nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" colspan="5" style="height: 7px">
                                        &nbsp; &nbsp;
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <table id="TABLE_ULT" align="center" border="0" cellpadding="0" cellspacing="0" style="width: 858px;
            height: 152px">
            <tr>
                <td align="right" style="width: 855px">
        <table id="Table1" runat="server" class="WebPartShadow_seguimiento" style="width: 888px; text-align: center;" visible="false">
            <tr>
                <td align="right" style="height: 27px; text-align: left;">
                </td>
                <td align="right" colspan="3" style="height: 27px; text-align: left;">
                </td>
                <td style="width: 30%; height: 27px; text-align: left;">
                    <asp:Label ID="lbEmpresaLector" runat="server" Font-Names="Arial"></asp:Label><strong>
                    </strong>
                    <asp:Label ID="lbRutEmpresa" runat="server" Font-Names="Arial"></asp:Label></td>
            </tr>
            <tr style="font-weight: bold">
                <td align="right" style="height: 17px">
                    <h2 style="text-align: right">
                        &nbsp;<asp:Image ID="Image2" runat="server" Height="16px" ImageUrl="~/fotos/book_open.png"
                            Width="24px" />
                        &nbsp;&nbsp;&nbsp;&nbsp;Destin<strong>at</strong>ario:&nbsp;
                    </h2>
                </td>
                <td colspan="4" style="height: 17px">
                    <h2 style="text-align: left">
                            <asp:TextBox ID="txt_lector_respuesta" runat="server" CssClass="TextBox" Width="400px"></asp:TextBox><strong></strong></h2>
                </td>
            </tr>
            <tr style="font-weight: bold">
                <td align="right" style="height: 17px">
                    <h2 style="text-align: right">
                        Asunto:&nbsp;<strong> </strong>
                    </h2>
                </td>
                <td colspan="4" style="height: 17px; text-align: left; font-weight: bold;">
                        <asp:TextBox ID="txt_asunto_resp" runat="server" CssClass="TextBox" MaxLength="50"
                            Width="400px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txt_asunto"
                            ErrorMessage="*" Width="1px"></asp:RequiredFieldValidator></td>
            </tr>
            <tr style="font-weight: bold">
                <td align="right" style="height: 9px; text-align: left;">
                </td>
                <td colspan="4" style="height: 9px; text-align: left">
                </td>
            </tr>
            <tr style="font-weight: bold">
                <td colspan="5" style="height: 17px">
                    <h2 style="text-align: left">
                        &nbsp;&nbsp; Mensaje:</h2>
                    <h2 style="text-align: center">
                        <strong>&nbsp; </strong>
                        <asp:TextBox ID="txt_mensaje_resp" runat="server" CssClass="TextBox" Height="88px"
                            MaxLength="200" TextMode="MultiLine" Width="768px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txt_mensaje"
                            ErrorMessage="*" Width="1px"></asp:RequiredFieldValidator>&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;
                    </h2>
                    <h2>
                        <strong>&nbsp; </strong>
                    </h2>
                </td>
            </tr>
            <tr>
                <td colspan="5" style="height: 8px">
                    &nbsp;<asp:Label ID="lbl_error" runat="server" ForeColor="Red" Width="352px"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="5" style="height: 8px; text-align: right">
                    <asp:Label ID="lb_id_usuario" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td align="right" colspan="5" style="height: 7px; text-align: right;">
                    &nbsp;<asp:Button ID="btnInsertaLector" runat="server" CssClass="botonnew" Text="Enviar Mensaje"
                        Width="120px" />
                    <asp:Button ID="btnCancelar" runat="server" CausesValidation="False" CssClass="botonnew"
                        Text="Cancelar" Width="120px" />
                    <asp:Button ID="Btn_cerrar2" runat="server" CausesValidation="False" CssClass="botonnew"
                        Text="<< Volver Menu" Width="120px" />
                </td>
            </tr>
            <tr>
                <td align="right" colspan="5" style="height: 7px; text-align: left">
                    <img id="img_ok" runat="server" src="fotos/ok.bmp" visible="false" /><asp:Label ID="lb_mensaje_ingreso"
                        runat="server" Font-Names="Arial" Width="680px"></asp:Label></td>
            </tr>
        </table>
                    &nbsp; &nbsp;&nbsp;
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
