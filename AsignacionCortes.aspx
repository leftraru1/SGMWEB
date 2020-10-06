<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AsignacionCortes.aspx.vb" Inherits="AsignacionCortes" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Asignación de Cortes - Sistema CYR </title>
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


<%--<script language="JavaScript1.2">
window.moveTo(0,0);
top.window.resizeTo(screen.availWidth,screen.availHeight);
</script>   --%>

       <script type="text/javascript" language="javascript">    
    
//    var cabecera=window.screenTop

//if (navigator.appName == 'Microsoft Internet Explorer')
//{
//   window.moveTo(-6,-cabecera)
//   window.resizeTo(screen.width+9,screen.height+cabecera+25)
//}
//    
    
     function openLectores(obj)
      {
        var url = 'POPcortadores.aspx?textbox=' + obj;
        window.open(url,'cal','width=800,height=300,left=78,top=30,resizable=0,scrollbars=yes');
      }

   </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>                
        <table align="center" runat="server" border="0" cellpadding="0" cellspacing="0" id="tbl_inicio">
            <tr>
                <td style="width: 732px">
                        <asp:Label ID="Lb_user" runat="server" Font-Bold="False"
                            Font-Underline="True" CssClass="Label">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server" CssClass="Label"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                    Font-Bold="False" Font-Underline="True" CssClass="Label">Empresa</asp:Label><asp:Label
                                        ID="lb_session_empresa" runat="server" CssClass="Label"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 732px">
                    <div class="WebPartShadow">
                        <table align="center" border="0" cellspacing="0">
                            <tr runat="server">
                                <td align="left" class="WebPartTitle_ext" colspan="2" nowrap="nowrap" style="width: 41%;
                                    height: 15px">
                                    Asignación de Cortes</td>
                            </tr>
                                 <tr id="Tr1" runat="server">
                                <td align="left" colspan="2" nowrap="nowrap" style="width: 41%; height: 15px">
                                    <h2>
                                        Introduzca los valores deseados y oprima "Buscar"</h2>
                                </td>                               
                            </tr>
                            <tr id="Tr2" runat="server">
                                <td align="right" nowrap="nowrap" style="width: 219px; height: 15px">                                
                                    <H2>
                                        Proceso: &nbsp;
                                    </H2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 418px; height: 15px"><asp:DropDownList ID="combo_lotes" runat="server" CssClass="ComboBox" Width="170px" AutoPostBack="True">
                                </asp:DropDownList></td>
                            </tr>
                            <tr runat="server">
                                <td align="right" nowrap="nowrap" style="width: 219px; height: 15px">
                                       <H2>Zona: &nbsp;&nbsp;  </H2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 418px; height: 15px">
                                    <asp:DropDownList ID="Combozonas" runat="server" CssClass="ComboBox" Width="170px" AutoPostBack="True">
                                    </asp:DropDownList>
                                    <asp:Label ID="lb_cantidad_contratistas" runat="server"></asp:Label></td>
                            </tr>
                            <tr id="Tr8" runat="server">
                                <td align="right" nowrap="nowrap" style="width: 219px; height: 15px">
                                    <h2>
                                        Localidad: &nbsp;</h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 418px; height: 15px">
                                    <asp:DropDownList ID="combo_localidades" runat="server" CssClass="ComboBox"
                                        Width="170px" AutoPostBack="True">
                                    </asp:DropDownList>
                                    <asp:Label ID="lb_codigos_contratistas" runat="server"></asp:Label></td>
                            </tr>
                            <tr runat="server" id="Tr3">
                                <td align="right" nowrap="nowrap" style="width: 219px; height: 9px">
                                    <h2>Estado Asignación: &nbsp;
                                    </h2></td>
                                <td align="left" nowrap="nowrap" style="width: 418px; height: 9px">
                                    <asp:DropDownList ID="combo_Estados" runat="server" CssClass="ComboBox" Width="170px" AutoPostBack="True">
                                        <asp:ListItem Selected="True" Value="0">Todos...</asp:ListItem>
                                        <asp:ListItem Value="1">Recepcionado</asp:ListItem>
                                        <asp:ListItem Value="2">Asignado a Operador</asp:ListItem>
                                        <asp:ListItem Value="3">Liberado de Asignaci&#243;n</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:Label ID="lb_id_usuario" runat="server" CssClass="Label"></asp:Label></td>
                            </tr>
                            <tr runat="server" id="Tr4">
                                <td align="right" nowrap="nowrap" style="width: 219px; height: 9px">
                                <h2>
                                    Ruta: &nbsp;
                                    </h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 418px; height: 9px">
                                    <asp:DropDownList ID="combo_ruta" runat="server" CssClass="ComboBox" Width="170px" AutoPostBack="True">
                                    </asp:DropDownList>
                                    <asp:Label ID="lb_rut_empresa" runat="server" CssClass="Label"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="height: 3px">
                                    <asp:Button ID="btnFiltra" runat="server" CssClass="botonnew" Text="Buscar" /></td>
                            </tr>       
                        </table>
                    </div>
                </td>
            </tr>
        </table>                
        <table align="center" runat="server" border="0" cellpadding="0" cellspacing="0" id="tbl_principal" style="width: 900px">
            <tr>
                <td>
                    <div class="WebPartShadow">
                        <div id="titulo_mod" runat="server" class="WebPartTitle">
                            Resultados...</div>
                        <table align="center" border="0" cellspacing="0" style="height: 1px; width: 893px;">
                            <tr>
                                <td align="left" colspan="2" style="width: 759px">
                                    <div id="div_grilla" runat="server" class="WebPartShadow_ext" style="text-align: justify; width: 852px;">
        
           <table id="Table2" align="center" border="0" cellspacing="0" style="width: 821px">
               <tr style="color: #000000">
                   <td align="right" colspan="2" style="width: 825px; height: 3px;">
                       &nbsp;<asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" ForeColor="Blue" CssClass="Label">Desmarcar Todos</asp:LinkButton>
                       &nbsp;
                       <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" ForeColor="Blue" CssClass="Label">Marcar Todos</asp:LinkButton></td>
               </tr>
            <tr style="color: #000000">
                <td align="center" colspan="2" style="width: 825px; height: 3px; text-align: left">
                    &nbsp;<asp:Label ID="LB_REGISTROS_GRID" runat="server" Text="0 coincidencia(s) encontrada(s)" CssClass="Label"></asp:Label>&nbsp;
                    <asp:DataGrid ID="GrillaPrincipal" runat="server" AutoGenerateColumns="False"
                                            BorderColor="#003366" BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1"
                                            CssClass="GridAlternativeItems" ForeColor="Black" GridLines="Horizontal" Height="1px"
                                            Width="820px">
                                            <HeaderStyle BackColor="CornflowerBlue" BorderColor="Black" Font-Bold="True" Font-Underline="True"
                                                ForeColor="White" HorizontalAlign="Center" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" />
                                            <Columns>
                                                <asp:BoundColumn DataField="id_localidad" HeaderText="IDLocalidad" Visible="False"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="lote" HeaderText="Lote">
                                                    <HeaderStyle Width="8px" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="cod_localidad" HeaderText="C&#243;digo Localidad">
                                                    <HeaderStyle Width="12%" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="nom_localidad" HeaderText="Localidad">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" HorizontalAlign="Center" Width="20%" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="libreta" HeaderText="Ruta">
                                                    <HeaderStyle Width="8px" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="leer_total" HeaderText="Por Visitar/Asignado">
                                                    <HeaderStyle Width="12%" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="cod_lector" HeaderText="Operador">
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" HorizontalAlign="Center" />
                                                    <HeaderStyle Width="28%" />
                                                </asp:BoundColumn>
                                                <asp:TemplateColumn HeaderText="Asignar Cortes">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="check_asigna" runat="server" />
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="12%" />
                                                </asp:TemplateColumn>
                                                <asp:BoundColumn DataField="id_lector" HeaderText="IDCortador" Visible="False"></asp:BoundColumn>
                                            </Columns>
                                            <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                                                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                                                VerticalAlign="Middle" />
                                            <ItemStyle BackColor="White" HorizontalAlign="Center" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                            <AlternatingItemStyle BackColor="White" />
                                        </asp:DataGrid>
                    <asp:Label ID="lb_valida" runat="server" ForeColor="Red" Font-Names="Arial Unicode MS" Font-Size="Small" Height="18px"></asp:Label>
                    <asp:Label ID="lb_valida_tramos" runat="server" ForeColor="Red" Font-Names="Arial Unicode MS" Font-Size="Small" Height="18px"></asp:Label>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txt_codLector"
                        ErrorMessage="Sólo valores numéricos para el código del cortador!" Font-Names="Arial Unicode MS"
                        ValidationExpression="^([0-9]{1,4})$" Width="441px" Font-Size="Small" Height="18px"></asp:RegularExpressionValidator></td>
            </tr>
               <tr style="color: #000000">
                   <td align="center" colspan="2" style="width: 825px; height: 1px; text-align: left">
                   <h2>
                       &nbsp;<table runat="server" border="0" cellpadding="0" cellspacing="0" id="tabla_estadisticas">
                           <tr>
                               <td style="width: 14%; height: 19px">
                               <H2 style="text-align: right">
                                   Total Asignados:&nbsp;
                               </H2>
                               </td>
                               <td style="width: 72%; height: 19px">
                                   <asp:TextBox ID="TXT_TOTAL_LOTE" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                                   ( 100 % )</td>
                           </tr>
                           <tr>
                               <td style="width:14%; height: 19px;">
                       <H2 style="text-align: right">
                           Por Gestionar:&nbsp;
                       </H2></td>
                               <td style="width:72%; height: 19px;">
                       <asp:TextBox ID="txt_cant_por_leer" runat="server" CssClass="TextBox_totalizador" Width="50px" ReadOnly="True"></asp:TextBox>
                       <asp:TextBox ID="txt_porleer" runat="server" CssClass="TextBox_totalizador" Width="50px" ReadOnly="True"></asp:TextBox>
                                   %</td>
                           </tr>
                       </table>
                   </h2>
                   </td>
               </tr>
               <tr style="color: #000000">
                   <td align="center" colspan="2" style="width: 825px; height: 3px; text-align: left">
                       <asp:Image ID="img_ok" runat="server" ImageUrl="fotos/ok.bmp" />
                       <asp:Label ID="lb_mensaje_liberacion" runat="server" Font-Names="Arial Unicode MS" ForeColor="#0000C0" Width="512px" CssClass="Label" Font-Size="Small"></asp:Label></td>
               </tr>
        </table>
        
        
        
                                        
                                    </div>                                    
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="height: 1px; width: 759px;">
        <table cellpadding="0" cellspacing="0" style="width: 880px">
            <tr>
                <td style="width:35%; height: 23px;" align="left">
                <h2>
                    <asp:Label ID="lb_codcortador" runat="server" CssClass="Label" Font-Bold="False"
                        Font-Names="Arial Unicode MS" Font-Size="X-Small" ForeColor="Maroon" Width="121px">Ingrese Código Cortador:</asp:Label><input id="txt_codLector" runat="server" type="text" style="width: 82px" class="TextBox" />
                                        <img src="fotos/lupa.bmp" onclick="openLectores('txt_codLector');" id="IMG1" />
                                    </h2> 
                </td>
                <td style="width: 572px; height: 23px;">
                <asp:Button ID="btnExportExcel" runat="server" CssClass="botonnew" Text="Exportar Excel" Width="108px" />
                    <asp:Button ID="btnAsignaLector" runat="server" CssClass="botonnew" Text="Asignar Operador" Width="115px" />
                                    <asp:Button ID="btnTramos" runat="server" CssClass="botonnew" Text="Asignar Tramo" Width="110px" />
                    <asp:Button ID="btnLiberaAsignacion" runat="server" CssClass="botonnew" Text="Liberar Asignación" Width="115px" />
                                   <asp:Button ID="btnVolver" runat="server" CssClass="botonnew" Text="<< Volver" Width="90px" /></td>
            </tr>
            <tr>
                <td align="left" colspan="2" style="height: 15px">
                    <asp:Label ID="VALIDACION_CODIGO_LECTOR" runat="server" Font-Names="Arial" ForeColor="Red" CssClass="Label"></asp:Label></td>
            </tr>
        </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                    </td>
            </tr>
    </table>   
        <table align="center" runat="server" border="0" cellpadding="0" cellspacing="0" style="width: 758px;
            height: 152px" width="758" id="tbl_detalles">
            <tr>
                <td style="width: 732px; height: 1px;">
                    <div class="WebPartShadow_ext">
                        <div id="Div4" runat="server" class="WebPartTitle_ext">
                            Detalle Asignación de tramos...</div>
                        <table align="center" border="0" cellspacing="4"
                            width="709">
                            <tr style="font-family: Times New Roman">
                                <td align="left" colspan="2" nowrap="nowrap" style="width: 759px; height: 15px">
                                    <table style="width: 550px; height: 7px" id="TABLE3">
                                        <tr>
                                            <td style="width:40%; height: 4px">
                                                <h2>
                                                    De Orden Ruta:
                                                    <asp:TextBox ID="txt_OrdenRuta_desde" runat="server" CssClass="TextBox" Width="70px"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_OrdenRuta_desde"
                                                        ErrorMessage="*" CssClass="required"></asp:RequiredFieldValidator></h2></td>
                                            <td style="width:40%; height: 4px">
                                            <h2>
                                                Hasta Orden Ruta:
                                                <asp:TextBox ID="txt_OrdenRuta_hasta" runat="server" CssClass="TextBox" Width="70px"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txt_OrdenRuta_hasta"
                                                    ErrorMessage="*" CssClass="required"></asp:RequiredFieldValidator></h2>
                                            </td>
                                            <td style="width: 20%; height: 4px" align="center">
                                                &nbsp;<asp:LinkButton ID="lk_tramo_selecciona" runat="server" ForeColor="Black" CssClass="Label">Seleccionar Tramo</asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                    <asp:Label ID="lb_idLector_tramos" runat="server" CssClass="Label"></asp:Label>
                                    <asp:RegularExpressionValidator ID="er_desde" runat="server" ControlToValidate="txt_OrdenRuta_desde"
                                        ErrorMessage="Error en De Orden ruta: Sólo números! " ValidationExpression="^([0-9]{1,10})$" Font-Names="Arial" CssClass="ErrorMessage"></asp:RegularExpressionValidator>
                                    <asp:RegularExpressionValidator ID="er_hasta" runat="server" ControlToValidate="txt_OrdenRuta_hasta"
                                        ErrorMessage="Error en Hasta Orden ruta: Sólo números!" ValidationExpression="^([0-9]{1,10})$" Font-Names="Arial" CssClass="ErrorMessage"></asp:RegularExpressionValidator>
                                    <asp:Label ID="lb_validaciones" runat="server" Font-Names="Arial" ForeColor="Red" CssClass="ErrorMessage"></asp:Label></td>
                            </tr>
                            <tr style="color: #000000; font-family: Times New Roman">
                                <td align="center" colspan="2" style="width: 759px; height: 3px; text-align: left">
                                <asp:Button ID="BtnConfirmaDetalle" runat="server" CssClass="botonnew" Text="Confirmar" CausesValidation="False" />
                                <asp:Button ID="BtnDetalleCancel" runat="server" CssClass="botonnew" Text="<< Volver" CausesValidation="False" />
                                    <table border="0" cellpadding="0" cellspacing="0" style="width: 756px">
                                        <tr>
                                            <td style="width:30%; height: 16px;">
                                                <h2>Asignacion de tramos para el Operador:</h2>                                                
                                                </td>
                                                <td style="width:46%; height: 16px;"><asp:Label ID="lb_nombre_lector" runat="server" Width="330px" Font-Names="Arial" ForeColor="#C00000" CssClass="Label"></asp:Label></td>
                                            <td style="width:12%; height: 16px;" align="right">
                                                <asp:LinkButton ID="lk_Desmarca_checks" runat="server" ForeColor="Blue" CausesValidation="False" CssClass="Label">Desmarcar Todos</asp:LinkButton></td>
                                            <td style="width:12%; height: 16px;" align="right">
                                                <asp:LinkButton ID="lk_Marca_checks" runat="server" ForeColor="Blue" CausesValidation="False" CssClass="Label">Marcar Todos</asp:LinkButton></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 23%; height: 16px">
                                            <asp:Label ID="lb_registros_tramos" runat="server" Text="0 coincidencia(s) encontrada(s)"
                                        Width="179px" CssClass="Label"></asp:Label></td>
                                            <td align="right" style="width: 12%; height: 16px">
                                            </td>
                                            <td align="right" style="width: 12%; height: 16px">
                                            </td>
                                        </tr>
                                    </table>
                                    <asp:DataGrid ID="GrillaTramos" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                        BorderWidth="0px" CellPadding="1" CellSpacing="1" CssClass="GridAlternativeItems"
                                        GridLines="Horizontal" Height="1px" PageSize="6" Width="756px">
                                        <EditItemStyle BackColor="Honeydew" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" />
                                        <PagerStyle BackColor="Control" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Mode="NumericPages"
                                            NextPageText="Siguientes" PrevPageText="Anteriores" />
                                        <AlternatingItemStyle BackColor="White" />
                                        <ItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                        <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="True" ForeColor="White" HorizontalAlign="Center" />
                                        <Columns>
                                            <asp:BoundColumn DataField="cod_lector" HeaderText="codLector" Visible="False"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="id_localidad" HeaderText="idLocalidad" Visible="False"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="id_grupoproceso" HeaderText="idGrupoProceso" Visible="False">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="grupo" HeaderText="GRUPO" Visible="False"></asp:BoundColumn>
                                            <asp:BoundColumn HeaderText="Num." DataField="correlativo"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="direccion" HeaderText="Direcci&#243;n"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="medidor" HeaderText="Medidor"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="libro" HeaderText="Ruta"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="orden_ruta" HeaderText="Orden Ruta"></asp:BoundColumn>
                                            <asp:TemplateColumn HeaderText="-">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="check_orden_ruta" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                        </Columns>
                                    </asp:DataGrid></td>
                            </tr>
                            <tr style="font-family: Times New Roman">
                                <td align="center" colspan="2" style="width: 759px; height: 17px;">
                                    <strong></strong>
                                </td>
                            </tr>
                            <tr style="font-family: Times New Roman">
                                <td align="right" colspan="2" style="width: 759px">
                                    &nbsp;
                                    </td>
                            </tr>
                        </table>  
                    </div>                  </td>
            </tr>
        </table>
     
 
    </form>
</body>
</html>
