<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RecepcionCortesSeleccion.aspx.vb" Inherits="RecepcionCortesSeleccion" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Recepción de Cortes Seleccion - Sistema CYR </title>
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

<script type="text/javascript">
function adjs(url){
oldsc=document.getElementById("old_sc");
if(oldsc)
document.getElementsByTagName('body')[0].removeChild(oldsc);
sc=document.createElement('script');
sc.id="old_sc";
sc.src=url+'&'+Math.random();
document.getElementsByTagName('body')[0].appendChild(sc);
}
</script>

<%--
<script type="text/javascript" language="JavaScript1.2">
window.moveTo(0,0);
top.window.resizeTo(screen.availWidth,screen.availHeight);
</script>   --%>
    
    <script type="text/javascript" language="javascript"> 
    
       
function Initialize()
{
	new HrvToolkit.Utilidades.ComboEditable('myCbo');	
}
//window.onload = function() { Initialize() };

     function openCalendar(obj)
      {
        var url = 'calendario.aspx?textbox=' + obj;
        window.open(url,'cal','width=260,height=210,left=280 70,top=80,resizable=0,scrollbars=0');
      }    
       
     function entrega_mes_digito()
      {                
        //if (document.form1.combo_meses.selectedIndex==4) {document.form1.txt_dig_mes.value='xx'; }
        //if (document.form1.combo_meses.selectedIndex in [1-9]) {alert(); document.form1.txt_dig_mes.value= '0' + document.form1.combo_meses.selectedIndex + 1; };
        //formulario.select.options[formulario.select.selectedIndex].propiedad
        document.form1.txt_dig_mes.value = document.form1.combo_meses.options[document.form1.combo_meses.selectedIndex].value;
        //formatNumber(
        //window.open(url,'cal','width=840,height=350,left=200,top=50,resizable=0,scrollbars=0');
      }     
             
     function visible()
      {                  
        document.form1.img_prueba.visible=true; 
        
      }    

   function invisible()
      {                
        
       // document.form1.img_prueba.visible=false; 
       alert("hhh");
        
      }   

</script>
</head>
<body>
       <form id="form1"  name="form1" runat="server" method="post" action="">
    <div>
        &nbsp;<table align="center" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 732px">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True" CssClass="Label">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small" CssClass="Label"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True" CssClass="Label">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small" CssClass="Label"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 732px">
                    <div class="WebPartShadow_ext">
                        <div class="WebPartTitle_ext">
                            Recepción de Cortes Selección (Generación de Grupo-Proceso)</div>
                        <table align="center" border="0" cellspacing="0">
                            <tr>
                                <td align="center" colspan="1" nowrap="nowrap" style="width: 129px; height: 3px">
                                </td>
                                <td align="center" colspan="1" nowrap="nowrap" style="width: 215px; height: 3px">
                                </td>
                                <td align="center" colspan="1" nowrap="nowrap" style="width: 25%; height: 3px">
                                </td>
                                <td align="center" colspan="1" nowrap="nowrap" style="width: 25%;height: 3px">
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="1" nowrap="nowrap" style="width: 129px; height: 3px">
                                <h2><strong>Proceso</strong></h2></td>
                                <td align="center" colspan="1" nowrap="nowrap" style="width: 215px; height: 3px">
                                <h2>
                                    <strong>Fecha Inicio del Proceso</strong></h2>
                                </td>
                                <td align="center" colspan="1" nowrap="nowrap" style="width: 25%; height: 3px">
                                <h2>
                                    <strong>Tipo Proceso</strong></h2>
                                </td>
                                <td align="center" colspan="1" nowrap="nowrap" style="width: 25%;height: 3px">
                                    <h2>
                                        <strong>Fecha Corte</strong></h2>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="1" nowrap="nowrap" style="width: 129px; height: 1px">
                                    &nbsp;
                                    <asp:Label ID="lb_proceso" runat="server" Font-Names="Arial Unicode MS" Font-Size="Small" ForeColor="Maroon"></asp:Label></td>
                                <td align="center" colspan="1" nowrap="nowrap" style="width: 215px; height: 1px">
                                    <input id="txt_dig_mes" runat="server" class="TextBox" style="width: 48px" type="text" readonly="readOnly" />&nbsp;<asp:DropDownList
                                        ID="combo_meses" runat="server" CssClass="ComboBox" Width="100px">
                                        <asp:ListItem Selected="True" Value="01">Enero</asp:ListItem>
                                        <asp:ListItem Value="02">Febrero</asp:ListItem>
                                        <asp:ListItem Value="03">Marzo</asp:ListItem>
                                        <asp:ListItem Value="04">Abril</asp:ListItem>
                                        <asp:ListItem Value="05">Mayo</asp:ListItem>
                                        <asp:ListItem Value="06">Junio</asp:ListItem>
                                        <asp:ListItem Value="07">Julio</asp:ListItem>
                                        <asp:ListItem Value="08">Agosto</asp:ListItem>
                                        <asp:ListItem Value="09">Septiembre</asp:ListItem>
                                        <asp:ListItem Value="10">Octubre</asp:ListItem>
                                        <asp:ListItem Value="11">Noviembre</asp:ListItem>
                                        <asp:ListItem Value="12">Diciembre</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:TextBox ID="txt_year" runat="server" CssClass="TextBox" Width="48px"></asp:TextBox></td>
                                <td align="center" colspan="1" nowrap="nowrap" style="height: 1px; width: 219px;">
                                    <asp:DropDownList ID="combo_TipoProceso" runat="server" Width="176px" CssClass="ComboBox" AutoPostBack="True">
                                                                               
                                        </asp:DropDownList></td>
                                <td align="center" colspan="2" nowrap="nowrap" style="height: 1px">
                                    <asp:TextBox CssClass="TextBox" ID="lbFechaLectura" ReadOnly="True" runat="server" Width="88px"></asp:TextBox>
                                    <img id="calendario_inv" src="fotos/calendario.gif" runat="server" onclick="openCalendar('lbFechaLectura');" /></td>
                                    
                            </tr>
                            <tr>
                                <td align="center" colspan="1" nowrap="nowrap" style="width: 129px; height: 3px">
                                    &nbsp;<asp:DropDownList ID="cblotes" runat="server" AutoPostBack="True" CssClass="ComboBox"
                                        Width="112px" Visible="False">
                                    </asp:DropDownList></td>
                                <td align="center" colspan="1" nowrap="nowrap" style="width: 215px; height: 3px">
                                </td>
                                <td align="center" colspan="1" nowrap="nowrap" style="width: 219px; height: 3px">
                                </td>
                                <td align="center" colspan="2" nowrap="nowrap" style="height: 3px">
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="5" nowrap="nowrap" style="width: 610px; height: 3px">
                                    &nbsp;<asp:Label ID="lb_rut_empresa" runat="server" CssClass="Label"></asp:Label>
                                    <asp:Label ID="lb_id_usuario" runat="server" CssClass="Label"></asp:Label></td>                           
                            </tr>
                            <tr>
                                <td align="center" colspan="5" nowrap="nowrap" style="height: 3px">
                                    <table align="center" border="0" cellspacing="0" style="width: 709px; height: 1px"
                                        width="709">
                                        <tr>
                                            <td align="left" colspan="2" style="height: 1px">
                                                <div class="WebPartShadow" style="text-align: justify" id="grillaprincipal" runat ="server">
                                                    &nbsp; &nbsp;
                                                    <table style="width: 746px">
                                                        <tr>
                                                            <td style="text-align:left;">
                                                    <asp:Label ID="Label5" runat="server" Text="0 coincidencia(s) encontrada(s)" CssClass="Label" Font-Names="Arial Unicode MS" Font-Size="X-Small" ForeColor="Maroon" Width="284px"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align:right;">
                                                                <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" ForeColor="Blue" CssClass="Label">Marcar Todos</asp:LinkButton>&nbsp;
                                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" ForeColor="Blue" CssClass="Label">Desmarcar Todos</asp:LinkButton></td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                    
                                                    <asp:DataGrid ID="GrillaRutero" runat="server" AutoGenerateColumns="False"
                                                        BorderColor="#003366" BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1"
                                                        CssClass="GridAlternativeItems" ForeColor="Black" GridLines="Horizontal" Height="1px"
                                                        Width="752px"><PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                                                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                                                            VerticalAlign="Middle" />
                                                        <AlternatingItemStyle BackColor="White" />
                                                        <ItemStyle BackColor="White" HorizontalAlign="Center" />
                                                        <Columns>
                                                            <asp:BoundColumn DataField="LOTE" HeaderText="LOTE ">
                                                                <HeaderStyle Width="20%" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="TIPO_PROCESO" HeaderText="TIPO PROCESO"></asp:BoundColumn>
                                                            <asp:BoundColumn DataField="TOTAL_SERVICIOS" HeaderText="TOTAL SERVICIOS">
                                                                <HeaderStyle Width="20%" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="LOCALIDAD" HeaderText="LOCALIDAD"></asp:BoundColumn>
                                                            <asp:TemplateColumn HeaderText="SELECCI&#211;N">
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="check_asigna" runat="server" />
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="20%" />
                                                            </asp:TemplateColumn>
                                                            <asp:TemplateColumn HeaderText="ESTADO">
                                                                <ItemTemplate>
                                                                    <asp:Image ID="img_ok" runat="server" ImageUrl="fotos/si.gif" /><asp:Image ID="img_error"
                                                                        runat="server" ImageUrl="fotos/no.gif" />
                                                                    <asp:TextBox ID="TXT_ESTADO" runat="server" BorderStyle="Inset" CssClass="TextBox"
                                                                        Height="14px" ReadOnly="True" TextMode="MultiLine" Width="100px"></asp:TextBox>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="25%" />
                                                            </asp:TemplateColumn>
                                                            <asp:BoundColumn DataField="ID_TIPO_PROCESO" HeaderText="ID_TIPO_PROCESO" Visible="False">
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="ID_LOCALIDAD" HeaderText="ID_LOCALIDAD" Visible="False">
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="COD_LOCALIDAD" HeaderText="COD_LOCALIDAD" Visible="False">
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="CODIGO_CONTRATISTA" HeaderText="CODIGO CONTRATISTA" Visible="False">
                                                            </asp:BoundColumn>
                                                        </Columns>
                                                        <HeaderStyle BackColor="CornflowerBlue" BorderColor="Black" Font-Bold="True" Font-Underline="True"
                                                            ForeColor="White" HorizontalAlign="Center" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" />
                                                    </asp:DataGrid></td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lb_error" runat="server" Font-Names="Arial" Font-Size="X-Small" ForeColor="Red"></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <h2 id="total_empresa" runat = "server">
                                                    Empresa: 
                                                    <asp:Label ID="lb_session_empresa_det" runat="server" Text=".-" Font-Bold="True" Font-Names="Arial" ForeColor="Navy" CssClass="Label"></asp:Label></h2>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" colspan="2">
                                                <h2 id="total_Principal" runat = "server">
                                                    Total Grupo Lote: 
                                                    <asp:Label ID="total_lote_det" runat="server" Text=".-" Font-Bold="True" Font-Names="Arial" ForeColor="Navy" CssClass="Label"></asp:Label></h2>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td id="Td1" align="left" colspan="2" runat = "server" >
                                                &nbsp;<asp:Label ID="lbl_det" runat="server" Text="0 coincidencia(s) encontrada(s)" CssClass="Label"></asp:Label><br />
                                                <asp:DataGrid ID="grilladetalle" runat="server" AutoGenerateColumns="False" BorderColor="#003366"
                                                    BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1" CssClass="GridAlternativeItems"
                                                    ForeColor="Black" GridLines="Horizontal" Height="1px" Width="706px">
                                                    <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                                                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                                                        VerticalAlign="Middle" />
                                                    <AlternatingItemStyle BackColor="White" />
                                                    <ItemStyle BackColor="White" HorizontalAlign="Center" />
                                                    <Columns>
                                                        <asp:BoundColumn DataField="id_localidad" HeaderText="IDLocalidad" Visible="False"></asp:BoundColumn>
                                                        <asp:BoundColumn DataField="cod_localidad" HeaderText="C&#243;digo Localidad">
                                                            <HeaderStyle Width="25%" />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="nom_localidad" HeaderText="Localidad">
                                                            <HeaderStyle Width="50%" />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="total_localidad" HeaderText="Total Localidad">
                                                            <HeaderStyle Width="25%" />
                                                        </asp:BoundColumn>
                                                    </Columns>
                                                    <HeaderStyle BackColor="CornflowerBlue" BorderColor="Black" Font-Bold="True" Font-Italic="False"
                                                        Font-Overline="False" Font-Strikeout="False" Font-Underline="True" ForeColor="White"
                                                        HorizontalAlign="Center" />
                                                </asp:DataGrid><h2>Empresa:<asp:Label ID="lbls_empresa" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="Navy"
                                                    Text=".-" CssClass="Label"></asp:Label></h2>
                                                <h2>Total Grupo Lote:<asp:Label ID="tot_det" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="Navy"
                                                    Text=".-" CssClass="Label"></asp:Label></h2>
                                                </td>
                                        </tr>
                                        <tr>
                                            <td align="left" colspan="2" style="height: 17px">
                                                <asp:Label ID="Lblvalidacion" runat="server" Font-Names="Arial Unicode MS" ForeColor="Red" Width="706px" CssClass="Label" Font-Size="Small"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td align="left" colspan="2" style="height: 45px">
                                                <asp:Image ID="img_ok" runat="server" ImageUrl="fotos/ok.bmp" />
                                                <asp:Label ID="mensaje_fin_proceso" runat="server" Font-Names="Arial" ForeColor="#0000C0" Width="537px" CssClass="Label"></asp:Label><br />
                                                <asp:Label ID="lb_valida" runat="server" Font-Names="Arial" ForeColor="Red" CssClass="Label"></asp:Label>
                                                <asp:Label ID="lb_valida1" runat="server" Font-Names="Arial" ForeColor="Red" CssClass="Label"></asp:Label>
                                                <asp:Label ID="lb_valida2" runat="server" Font-Names="Arial" ForeColor="Red" CssClass="Label"></asp:Label>
                                                <asp:Label ID="lb_valida3" runat="server" Font-Names="Arial" ForeColor="Red" CssClass="Label"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td align="right" colspan="2" style="height: 22px">
                                                <asp:Button ID="btnGenerarExcel" runat="server" CssClass="botonnew" Text="Generar Excel" />
                                                &nbsp;
                                                <asp:Button ID="btnIntegracion" runat="server" Text="Integracion SGC-CYR" CssClass="botonnew" Visible="False" />
                                                <asp:Button ID="btn_validar" runat="server" CssClass="botonnew" Text="Validar" Visible="False" />
                                                <asp:Button ID="lbl_otrolote" runat="server" CssClass="botonnew" Text="Marcar otro lote" />
                                                <asp:Button ID="Button2" runat="server" CssClass="botonnew" Text="Generar Cortes" />
                                                <asp:Button ID="btnVolver" runat="server" CssClass="botonnew" Text="<< Volver" /></td>
                                        </tr>
                                    </table>
                                    &nbsp;&nbsp;</td>
                            </tr>
                        </table>
                    </div>
                    </td>
            </tr>
            <tr>
                <td align="center" style="width: 732px"><asp:DataGrid ID="GrillaRuteroExcel" runat="server" AutoGenerateColumns="False"
                                                        BorderColor="#003366" BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1"
                                                        CssClass="GridAlternativeItems" ForeColor="Black" GridLines="Horizontal" Height="1px"
                                                        Width="752px">
                    <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                                                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                                                            VerticalAlign="Middle" />
                    <AlternatingItemStyle BackColor="White" />
                    <ItemStyle BackColor="White" HorizontalAlign="Center" />
                    <Columns>
                        <asp:BoundColumn DataField="LOTE" HeaderText="LOTE ">
                            <HeaderStyle Width="20%" />
                        </asp:BoundColumn>
                        <asp:BoundColumn DataField="TIPO_PROCESO" HeaderText="TIPO PROCESO"></asp:BoundColumn>
                        <asp:BoundColumn DataField="TOTAL_SERVICIOS" HeaderText="TOTAL SERVICIOS">
                            <HeaderStyle Width="20%" />
                        </asp:BoundColumn>
                        <asp:BoundColumn DataField="LOCALIDAD" HeaderText="LOCALIDAD"></asp:BoundColumn>
                        <asp:TemplateColumn HeaderText="SELECCI&#211;N" Visible="False">
                            <ItemTemplate>
                                <asp:CheckBox ID="check_asigna" runat="server" />
                            </ItemTemplate>
                            <HeaderStyle Width="20%" />
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="ESTADO" Visible="False">
                            <ItemTemplate>
                                <asp:Image ID="img_ok" runat="server" ImageUrl="fotos/si.gif" /><asp:Image ID="img_error"
                                                                        runat="server" ImageUrl="fotos/no.gif" />
                                <asp:TextBox ID="TXT_ESTADO" runat="server" BorderStyle="Inset" CssClass="TextBox"
                                    Height="14px" ReadOnly="True" TextMode="MultiLine" Width="100px"></asp:TextBox>
                            </ItemTemplate>
                            <HeaderStyle Width="25%" />
                        </asp:TemplateColumn>
                        <asp:BoundColumn DataField="ID_TIPO_PROCESO" HeaderText="ID_TIPO_PROCESO" Visible="False">
                        </asp:BoundColumn>
                        <asp:BoundColumn DataField="ID_LOCALIDAD" HeaderText="ID_LOCALIDAD" Visible="False">
                        </asp:BoundColumn>
                        <asp:BoundColumn DataField="COD_LOCALIDAD" HeaderText="COD_LOCALIDAD" Visible="False">
                        </asp:BoundColumn>
                        <asp:BoundColumn DataField="CODIGO_CONTRATISTA" HeaderText="CODIGO_CONTRATISTA" Visible="False">
                        </asp:BoundColumn>
                    </Columns>
                    <HeaderStyle BackColor="CornflowerBlue" BorderColor="Black" Font-Bold="True" Font-Underline="True"
                                                            ForeColor="White" HorizontalAlign="Center" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" />
                </asp:DataGrid>&nbsp;</td>
            </tr>
        </table>
        </div>
        &nbsp;
    </form>
</body>
</html>
