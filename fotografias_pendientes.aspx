<%@ Page Language="VB" AutoEventWireup="false" CodeFile="fotografias_pendientes.aspx.vb" Inherits="fotografias_pendientes" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title> Fotografias Pendientes - Sistema CYR</title>
      <link type="text/css" rel="stylesheet" href="estilos/page.css">
      <link type="text/css" rel="stylesheet" href="estilos/controls.css">
      <link type="text/css" rel="stylesheet" href="estilos/grid.css">
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css">
      <link type="text/css" rel="stylesheet" href="estilos/menu.css">
      <link type="text/css" rel="stylesheet" href="estilos/others.css">
          <script type="text/javascript" language="javascript">  
          
                 window.onload = detectarCarga;
function detectarCarga(){
document.getElementById("imgLOAD").style.display="none";
}

      function Pophistorial(p_id_servicio)      
       {
       var url = 'GestionHistorica_analisis.aspx?idServicio='+p_id_servicio; 
       open(url,'DetalleLectura','top=20,left=100,width=1200,height=520,status=yes,resizable=no,scrollbars=yes');
       }  

             
                         function PopDetalles(p_var_foto)      
       {
       var url = 'zoom_image.aspx?var_foto='+p_var_foto; 
       open(url,'DetalleLecturas','top=20,left=100,width=1200,height=700,status=yes,resizable=yes,scrollbars=yes');
       }  
          
          
             function PopDetalles2(var_listar_fotografias,var1,var2,var3,var4,var5,var6,var7,var8)
       {
       var url = 'POPvisualizacion.aspx?var_list='+var_listar_fotografias+'&varone='+var1+'&vartwo='+var2+'&varthree='+var3+'&varfor='+var4+'&varfive='+var5+'&varsix='+var6+'&varseven='+var7+'&vareight='+var8;
       
//       var url = 'MantencionIndicadorespop.aspx?rut_empre='+rut_empresa+'&id_grupoproceso='+id_grupoprocesos+'&zonas_filter='+zonas_filters+'&lector_filter='+lector_filters+'&ruta_filter='+ruta_filters;
       
       open(url,'DetalleLectura','top=20,left=20,width=990,height=600,status=yes,resizable=yes,scrolling=no,scrollbars=yes');
      
       }     
       
       
                    function PopDetalles3(var_listar_fotografias)
       {
       var url = 'POPlectores.aspx?var_list='+var_listar_fotografias;
       open(url,'DetalleLectura','top=20,left=50,width=900,height=480,status=yes,resizable=no');
      
       }   
       
              function openCalendar(obj)
      {
        var url = 'calendario.aspx?textbox=' + obj;
        window.open(url,'cal','width=260,height=210,left=280 70,top=80,resizable=0,scrollbars=0');
      }                
               
               
                    
function TABLE1_onclick() {

}



             </script>
      
</head>
<body>

<div id='imgLOAD' style="TEXT-ALIGN: center">
<b> CARGANDO INFORMACION </b>
<IMG src="fotos/progressbar.gif" style="width: 120px; height: 16px">
</div>

    <form id="form1" runat="server">
    <div>
        <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 1592px;
            height: 1px; position: absolute;" id="TABLE1" language="javascript" onclick="return TABLE1_onclick()">
            <tr>
                <td style="width: 736px; height: 4px;">
                    &nbsp;<asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial"
                        Font-Size="X-Small" Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user"
                            runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa"
                                runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 736px; height: 469px;">
                    <div class="WebPartShadow_analizador" style="width: 1552px; left: 0px; position: absolute; top: 16px; height: 3px;">
                        <div id="titulo_mod" runat="server" class="WebPartTitle_analizador" style="width: 1552px; left: 16px; top: 0px;">
                            Fotografias Pendientes</div>
                            
                            
                                    
                            
                        <table align="center" border="0" cellspacing="1" style="width: 1552px; height: 1px" id="tbl_Primaria" runat="server">
                            <tr>
                                <td align="left" colspan="2" nowrap="nowrap" style="width: 1015px; height: 3px">                                &nbsp;<asp:Label ID="lb_ID_PERFIL" runat="server"></asp:Label><br />
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="2" nowrap="nowrap" style="width: 1015px; height: 1px">                               &nbsp;
                                    <asp:Label ID="lb_id_usuario" runat="server" Text="lb_id_usuario"></asp:Label>
                                    <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label>
                                    <table cellspacing="0" style="width: 312px">
                                        <tr>
                                            <td colspan="5" style="height: 4px; text-align: center">
                                                <strong>RANGO FECHA DE LECTURAS</strong></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 484px; height: 4px; text-align: center;" align="right" colspan="4">
                                    <asp:RadioButtonList ID="TABLA_CONSULTAS" runat="server" AutoPostBack="True" Font-Names="Arial"
                                        Height="17px" RepeatDirection="Horizontal" Width="299px">
                                        <asp:ListItem Value="1">HISTORICOS</asp:ListItem>
                                        <asp:ListItem Selected="True" Value="2">EN PROCESO</asp:ListItem>
                                    </asp:RadioButtonList></td>
                                            <td style="width: 30%; height: 4px; text-align: center;"><asp:RadioButtonList ID="Tipo_lecturas" runat="server" RepeatDirection="Horizontal"
                                        Width="264px" Height="17px" Font-Names="Arial" AutoPostBack="True">
                                        <asp:ListItem Value="1" Selected="True">Fuera de Rango</asp:ListItem>
                                        <asp:ListItem Value="2">Improcedentes</asp:ListItem>
                                    </asp:RadioButtonList></td>
                                        </tr>
                                        <tr>
                                            <td colspan="5" style="height: 4px; text-align: center">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5" style="height: 4px; text-align: center">
                                                <strong>FILTRO BUSQUEDA FOTOGRAFIAS<br />
                                                </strong>
                                            <asp:DropDownList ID="cbo_filtro_fotografia" runat="server" AutoPostBack="True"
                                        CssClass="ComboBox" Width="272px">
                                            </asp:DropDownList></td>
                                        </tr>
            <tr>
                <td style="width: 484px; height: 4px; text-align: center;" align="right" colspan="4">
                    INICIAL</td>
                <td style="width: 30%; height: 4px; text-align: center;">
                    FINAL</td>
            </tr>
                                    <tr>
                                        <td align="right" style="width: 484px; height: 4px; text-align: center;" colspan="4">
                                            &nbsp;
                                            <asp:TextBox ID="txtDate1" runat="server" CssClass="TextBox" Width="111px"></asp:TextBox><img
                                                id="calendario_inv" runat="server" onclick="openCalendar('txtDate1');" src="fotos/calendario.gif" /></td>
                                        <td style="width: 30%; height: 4px; text-align: center;">
                                            <asp:TextBox ID="txtDate2" runat="server" CssClass="TextBox" Width="111px"></asp:TextBox><img
                                                id="calendario_inv2" runat="server" onclick="openCalendar('txtDate2');" src="fotos/calendario.gif" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right" style="height: 22px; text-align: center;" colspan="5">
                                        <h2>
                                            &nbsp;<asp:Button ID="btnFiltraRangoFecha" runat="server" CssClass="Button" Text="Filtrar"
                                                Width="120px" /></h2>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" style="width: 484px; height: 19px;" colspan="4">
                                            <asp:RequiredFieldValidator ID="rq_fecha_inicio" runat="server" ControlToValidate="txtDate1"
                                                ErrorMessage="¡Ingrese Fecha Inicio!" Font-Names="Arial"></asp:RequiredFieldValidator></td>
                                        <td style="width: 139px; height: 19px">
                                            <asp:RequiredFieldValidator ID="rq_fecha_termino" runat="server" ControlToValidate="txtDate2"
                                                ErrorMessage="¡Ingrese Fecha Término!" Font-Names="Arial"></asp:RequiredFieldValidator></td>
                                    </tr>
                                    <tr>
                                        <td align="right" style="width: 484px; height: 19px; text-align: right;" colspan="4">
                                                <asp:DropDownList ID="comboExcel" runat="server" CssClass="ComboBox" Enabled="False"
                                                    Width="136px">
                                                    <asp:ListItem>Excel 97 - 2000</asp:ListItem>
                                                    <asp:ListItem>Excel 2003 - 2007</asp:ListItem>
                                                </asp:DropDownList><asp:Button ID="btnExportExcel" runat="server" Text="Exportar Excel" CssClass="Button" Width="120px" /></td>
                                        <td style="width: 139px; height: 19px; text-align: right;">
                                                <asp:Button ID="btnVolver_alto" runat="server" CssClass="Button" Text="<< Volver Menu" Width="120px" /></td>
                                    </tr>
                                        <tr>
                                            <td align="right" colspan="4" style="width: 484px; height: 19px; text-align: right">
                                            </td>
                                            <td style="width: 139px; height: 19px; text-align: right">
                                            </td>
                                        </tr>
        </table>   
                                    <br />
                                    <br />
                                    <br />
                                    <table style="width: 1544px" border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td style="width:50%; height: 20px;">
                                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" ForeColor="Blue" Visible="False">Marcar Todos</asp:LinkButton>&nbsp;
                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False"
                                        ForeColor="Blue" Visible="False">Desmarcar Todos</asp:LinkButton></td>
                                            <td align="right" style="width: 1252px; height: 20px;">
                                                &nbsp;&nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                <asp:Label ID="lbRegistros" runat="server"
                                        Width="537px"></asp:Label></td>
                            </tr>
                            <tr style="color: #000000">
                                <td align="right" colspan="2" style="width: 1015px; height: 3px; text-align: center">
                                    <asp:DataGrid ID="GrillaAnalisisLect" runat="server"
                                        AutoGenerateColumns="False" BorderWidth="0px" CellPadding="1" CellSpacing="1"
                                        CssClass="GridAlternativeItems" GridLines="Horizontal" Height="1px" OnEditCommand="MyDataGrid_Edit" 
                                        Width="1544px">
                                        <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="True" ForeColor="White" HorizontalAlign="Center" />
                                        <Columns>
                                            <asp:TemplateColumn HeaderText="E" Visible="False">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="check_repaso" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Fotografia">
                                                <ItemTemplate>
                                                    <img id="btnDetalles" runat="server" src="fotos/camera_48.png" style="height: 24px" />
                                                    <asp:Image ID="img_error" runat="server" ImageUrl="~/fotos/cross_48.png" Height="24px" />
                                                    <img id="img_evaluado" runat="server" src="fotos/accepted_48.png" style="height: 24px" />
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:EditCommandColumn CancelText="Cancelar" EditText="◄ Evaluar" HeaderText="Evaluacion"
                                                UpdateText="Actualizar"></asp:EditCommandColumn>
                                            <asp:BoundColumn DataField="cod_localidad" HeaderText="C&#243;d Localidad">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="localidad" HeaderText="Localidad">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="lote" HeaderText="Lote" Visible="False">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="libro" HeaderText="Ruta">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="orden_ruta" HeaderText="Orden Ruta">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="id_servicio" HeaderText="Servicio">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="medidor" HeaderText="Medidor">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="lectura" HeaderText="Lectura">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="Lectura_ant" HeaderText="Lect Anterior">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="minimo" HeaderText="M&#237;nimo">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="maximo" HeaderText="M&#225;ximo">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="MENSAJE" HeaderText="Mensaje">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="hora_lectura" HeaderText="Hora">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="fecha_lectura" HeaderText="Fecha">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="intentos" HeaderText="Intentos">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="clave_lectura" HeaderText="Clave Lectura">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="clave_observacion" HeaderText="Clave Observacion">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="cod_lector" HeaderText="Lector">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="nombre" HeaderText="Cliente">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Left" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="id_grupoproceso" HeaderText="id_grupoproceso" Visible="False"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="foto" HeaderText="Fotografia" Visible="False"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="id_evaluacion_fotografia" HeaderText="id_evaluacion_fotografia"
                                                Visible="False"></asp:BoundColumn>
                                        </Columns>
                                        <EditItemStyle BackColor="Honeydew" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" />
                                        <PagerStyle BackColor="Control" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Mode="NumericPages"
                                            NextPageText="Siguientes" PrevPageText="Anteriores" />
                                        <AlternatingItemStyle BackColor="White" />
                                        <ItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                    </asp:DataGrid>
                                    <asp:Label ID="lb_error" runat="server" Font-Names="Arial" ForeColor="Red" Width="660px"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="width: 1288px; height: 1px; text-align: right;">
                                    <strong>
                                        <asp:Button ID="btnReleer" runat="server" Text="Re-leer" CssClass="Button" Width="120px" Visible="False" /><asp:Button ID="Button1" runat="server" CssClass="Button" Text="<< Volver Menu" Width="120px" /></strong></td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="height: 1px; width: 1015px;"></td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="width: 1015px; height: 1px; text-align: left">
                                    </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="width: 1015px;">
                                </td>
                            </tr>
                        </table>
                        <table id="tbl_NuevoSol" runat="server" style="width: 936px" border="0">
                            <tr>
                                <td align="left" colspan="5" style="height: 4px">
                                    <h2 class="WebPartTitle_analizador">
                                        Evaluacion Fotografia</h2>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 203px; height: 4px; text-align: right">
                                 <h2>
                                     <strong>Localidad:</strong></h2></td>
                                <td align="right" style="width: 367px; height: 4px; text-align: left">
                                    <asp:Label ID="lbl_localidad" runat="server" Text="Label" Width="216px" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                                <td align="right" style="width: 158px; height: 4px; text-align: right">
                                   <h2><strong> Lote: </strong></h2></td>
                                <td colspan="4" style="height: 4px; text-align: left">
                                    <asp:Label ID="lbl_lote" runat="server" Text="Label" Width="256px" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 203px; height: 4px; text-align: right">
                                   <h2> <strong>Ruta:</strong> </h2></td>
                                <td align="right" style="width: 367px; height: 4px; text-align: left">
                                    <asp:Label ID="lbl_ruta" runat="server" Text="Label" Width="216px" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                                <td align="right" style="width: 158px; height: 4px; text-align: right">
                                   <h2><strong> Servicio:</strong>
                                   </h2></td>
                                <td colspan="4" style="height: 4px; text-align: left">
                                    <asp:Label ID="lbl_servicio" runat="server" Text="Label" Width="256px" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 203px; height: 4px">
                                   <h2> <strong>Medidor:</strong> </h2></td>
                                <td align="right" style="width: 367px; height: 4px; text-align: left">
                                    <asp:Label ID="lbl_medidor" runat="server" Text="Label" Width="216px" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                                <td align="right" style="width: 158px; height: 4px">
                                   <h2><strong> Mensaje:</strong> </h2></td>
                                <td colspan="4" style="height: 4px; text-align: left">
                                    <asp:Label ID="lbl_mensaje" runat="server" Text="Label" Width="256px" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 203px; height: 4px">
                                   <h2> <strong>Lectura: </strong></h2></td>
                                <td align="right" style="width: 367px; height: 4px; text-align: left">
                                    <asp:Label ID="lbl_lectura" runat="server" Text="Label" Width="216px" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                                <td align="right" style="width: 158px; height: 4px">
                                   <h2> <strong>Cliente:</strong></h2></td>
                                <td colspan="4" style="height: 4px; text-align: left">
                                    <asp:Label ID="lbl_cliente" runat="server" Text="Label" Width="256px" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 203px; height: 4px">
                                   <h2> <strong> Direccion:</strong> </h2> </td>
                                <td align="right" style="width: 367px; height: 4px; text-align: left">
                                    <asp:Label ID="lbl_direccion" runat="server" Font-Bold="True" Font-Names="Arial"
                                        ForeColor="#0000C0" Text="Label" Width="328px"></asp:Label></td>
                                <td align="right" style="width: 158px; height: 4px">
                                   <h2> 
                                       <strong>Lectura Anterior:</strong></h2></td>
                                <td colspan="4" style="height: 4px; text-align: left">
                                    <asp:Label ID="lbl_lect_anterior" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"
                                        Text="Label" Width="216px"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 203px; height: 4px">
                                   <h2> <strong> Clave Lectura:</strong></h2></td>
                                <td align="right" style="width: 367px; height: 4px; text-align: left">
                                    <asp:Label ID="lbl_clave_lectura" runat="server" Font-Bold="True" Font-Names="Arial"
                                        ForeColor="#0000C0" Text="Label" Width="216px"></asp:Label></td>
                                <td align="right" style="width: 158px; height: 4px">
                                   <h2> <strong> Clave Observacion:</strong></h2></td>
                                <td colspan="4" style="height: 4px; text-align: left">
                                    <asp:Label ID="lbl_clave_observacion" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"
                                        Text="Label" Width="216px"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 203px; height: 4px">
                                   <h2> <strong>  Historial: </strong></h2> </td>
                                <td align="right" style="width: 367px; height: 4px; text-align: left">
                                    <asp:ImageButton ID="img_historial" runat="server" ImageUrl="~/fotos/hoja.gif" />
                                    <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                                <td align="right" style="width: 158px; height: 4px">
                                 <h2> <strong>   Usuario Evaluador: </strong></h2> </td>
                                <td colspan="4" style="height: 4px; text-align: left">
                                    <asp:Label ID="lbl_evaluador_inf" runat="server" Font-Bold="True" Font-Names="arial"
                                        ForeColor="#0000C0" Text="Label" Width="256px"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 203px;">
                                    <h2>
                                       <strong>Evaluacion:</strong>
                                    </h2>
                                </td>
                                <td align="left" colspan="1" style="width: 367px;">
                                    <asp:DropDownList ID="combo_evaluar" runat="server" AutoPostBack="True"
                                        CssClass="ComboBox" Width="304px">
                                    </asp:DropDownList></td>
                                <td align="left" colspan="3">
                                    <h2>
                                        <asp:Button ID="btn_evaluar" runat="server" CssClass="Button" Text="Evaluar" Width="120px" />
                                    <asp:Button ID="btn_editar" runat="server" CssClass="Button" Text="Volver a Editar"
                                        Width="120px" />
                                    <asp:Button ID="Btn_Cancelar" runat="server" CausesValidation="False"
                                            CssClass="Button" Text="Volver" Width="120px" /></h2>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 203px;">
                                  <h2><strong>  Clave Fotografia:</strong></h2></td>
                                <td align="left" colspan="1" style="width: 367px;">
                                    <asp:DropDownList ID="combo_clave_fotografia" runat="server" AutoPostBack="True"
                                        CssClass="ComboBox" Width="304px">
                                    </asp:DropDownList></td>
                                <td style="width: 158px;">
                                </td>
                                <td align="left" colspan="2" style="width: 670px;">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="5" style="height: 17px">
                                    &nbsp;<asp:Label ID="Label1" runat="server" Font-Names="Arial" ForeColor="Red"
                                        Width="272px"></asp:Label>
                                    <img id="img_ok" runat="server" src="fotos/ok.bmp" style="height: 16px" visible="false" />
                                    <asp:Label ID="lb_mensaje" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="Navy"
                                        Width="592px"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="right" colspan="5" style="height: 17px; text-align: left;">
                                    &nbsp; &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="5" style="height: 17px; text-align: left">
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
                                </td>
                            </tr>
                        </table>
    <asp:DataGrid ID="GrillaAnalisisLect_TEMP" runat="server" AllowSorting="True"
                                        AutoGenerateColumns="False" BorderWidth="0px" CellPadding="1" CellSpacing="1"
                                        CssClass="GridAlternativeItems" GridLines="Horizontal" Height="1px" PageSize="6"
                                        Width="928px">
                                    <EditItemStyle BackColor="Honeydew" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" />
                                    <PagerStyle BackColor="Control" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Mode="NumericPages"
                                            NextPageText="Siguientes" PrevPageText="Anteriores" />
                                    <AlternatingItemStyle BackColor="White" />
                                    <ItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="Control" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="True" ForeColor="Black" HorizontalAlign="Center" />
                                    <Columns>
                                        <asp:BoundColumn DataField="cod_localidad" HeaderText="C&#243;digo Localidad"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="localidad" HeaderText="Localidad">
                                            <HeaderStyle Width="15%" />
                                        </asp:BoundColumn>
                                        <asp:BoundColumn DataField="lote" HeaderText="Lote">
                                            <HeaderStyle Width="8%" />
                                        </asp:BoundColumn>
                                        <asp:BoundColumn DataField="libro" HeaderText="Ruta">
                                            <HeaderStyle Width="12%" />
                                        </asp:BoundColumn>
                                        <asp:BoundColumn DataField="orden_ruta" HeaderText="Orden Ruta"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="nombre" HeaderText="Cliente">
                                            <HeaderStyle Width="20%" />
                                        </asp:BoundColumn>
                                        <asp:BoundColumn DataField="id_servicio" HeaderText="Id. Servicio"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="medidor" HeaderText="Medidor"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="lectura" HeaderText="Lectura"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="minimo" HeaderText="M&#237;nimo"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="maximo" HeaderText="M&#225;ximo"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="hora_lectura" HeaderText="Hora Lectura"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="fecha_lectura" HeaderText="Fecha Lectura"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="intentos" HeaderText="Intentos"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="clave_lectura" HeaderText="Clave Lectura"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="clave_observacion" HeaderText="Clave Observacion"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="cod_lector" HeaderText="Codigo lector"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="LECTURA_ANT" HeaderText="Lectura Ant"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="MENSAJE" HeaderText="MENSAJE"></asp:BoundColumn>
                                    </Columns>
                                </asp:DataGrid></div>
                    </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
