<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MantencionPagoContratista.aspx.vb" Inherits="MantencionPagoContratista" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Mantención Pago Contratista</title>
      <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/others.css"/>  
      <link type="text/css" rel="stylesheet" href="estilos/style.css"/> 
 
 <script type="text/javascript" language="javascript">   
      
function soloNumeros(evt){    //Validar la existencia del objeto event
    evt = (evt) ? evt : event;     //Extraer el codigo del caracter de uno de los diferentes grupos de codigos    
    var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode : ((evt.which) ? evt.which : 0));     //Predefinir como valido    
    var respuesta = true;     //Validar si el codigo corresponde a los NO aceptables    
    if (charCode > 31 && (charCode < 48 || charCode > 57))    {        //Asignar FALSE a la respuesta si es de los NO aceptables
        respuesta = false;    
        }     //Regresar la respuesta    
        return respuesta;
        }            
           
        function SN()
            {
                if (!((event.keyCode>=48) && (event.keyCode<=57))){event.keyCode=0;}
                //alert();
            } 
                       
</script>
      
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 1038px">
            <tr>
                <td style="width: 900px">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 900px">
                    <div class="WebPartShadow_pago" style="width: 1000px">
                        <div id="titulo_mod" runat="server" class="WebPartTitle_pago">
                            Mantenedor Pagos Contratista.</div>
                        <table align="center" border="0" cellspacing="0" style="width: 932px; height: 1px">
                            <tr>
                                <td align="left" colspan="2" nowrap="nowrap" style="height: 15px">
                                    <h2>
                                        <asp:Label ID="lb_minihead" runat="server" Text="Por favor, seleccione la acción a realizar:"></asp:Label>
                                    </h2>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" nowrap="nowrap" style="height: 15px">
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="2" style="height: 3px">
                                    <asp:Label ID="lb_cantidad_registros" runat="server" Text="0 coincidencia(s) encontrada(s)"
                                        Width="224px" Font-Names="Arial" ForeColor="Navy"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="height: 1px">
                                    <asp:DataGrid ID="GrillaPagoContratistas" runat="server" AutoGenerateColumns="False"
                                        BorderWidth="0px" CellPadding="1" CellSpacing="1" CssClass="GridPager" Font-Overline="False"
                                        Font-Underline="False" Height="1px" Width="992px">
                                        <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" ForeColor="White" HorizontalAlign="Center" />
                                        <Columns>
                                            <asp:BoundColumn DataField="ID_CONTRATISTA" HeaderText="Id_Contratista" Visible="False">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="COD_CONTRATISTA" HeaderText="C&#211;DIGO">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Width="10%" Font-Names="Arial" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="NOM_CONTRATISTA" HeaderText="NOMBRE CONTRATISTA">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Width="15%" Font-Names="Arial" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="ID_PAGO_EVENTOS" HeaderText="ID_PAGO_EVENTOS" Visible="False">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" Width="10%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="DESCRIPCION_EVENTO" HeaderText="DESCRIPCION EVENTO">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Width="15%" Font-Names="Arial" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="ID_CLAVEEFECTIVA" HeaderText="ID_CLAVEEFECTIVA" Visible="False">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" Width="8%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="NOM_EFECTIVA" HeaderText="CLAVE EFECTIVA">
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Names="Arial" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" Width="15%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="ID_CLAVEIMPROCEDENTE" HeaderText="ID_CLAVEIMPROCEDENTE" Visible="False">
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" Width="10%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="NOM_IMPROCEDENTE" HeaderText="CLAVE IMPROCEDENTE">
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Names="Arial" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" Width="15%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="RUT_EMPRESA" HeaderText="RUT EMPRESA">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Width="10%" Font-Names="Arial" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="ID_TIPOORDEN" HeaderText="TIPO ORDEN">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Width="10%" Font-Names="Arial" />
                                            </asp:BoundColumn>
                                            <asp:TemplateColumn HeaderText="VALOR PAGO ($)">
                                                <ItemTemplate>                                                    
                                                    <asp:TextBox ID="txt_monto" style="text-align:center;" Text='<%# Eval("MONTO_NETO") %>' runat="server" MaxLength="10" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" ForeColor="Navy"></asp:TextBox>
                                                    <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txt_monto"
                                                        Display="Dynamic" ErrorMessage="Sólo números" MaximumValue="99999999" MinimumValue="0"
                                                        Type="Integer"></asp:RangeValidator>
                                                    &nbsp;
                                                </ItemTemplate>
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" Width="10%" Font-Names="Arial" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Names="Arial" Font-Overline="False"
                                                    Font-Size="X-Small" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                            </asp:TemplateColumn>
                                        </Columns>
                                        <PagerStyle BackColor="Control" Font-Bold="True" />
                                        <ItemStyle BackColor="White" />
                                    </asp:DataGrid></td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="height: 2px">
                                    <asp:Label ID="lb_id_contratista" runat="server"></asp:Label>
                                    <asp:Label ID="lb_id_usuario" runat="server"></asp:Label>
                                    <asp:Label ID="lb_rut_empresa"
                                        runat="server"></asp:Label></td>
                            </tr>
                            <tr id="row_aceptar_ok" runat="server">
                                <td align="right" colspan="2" style="height: 21px">
                                    <asp:Image ID="img_ok" runat="server" Height="16px" ImageUrl="fotos/ok.bmp" Width="20px" /><asp:Label
                                        ID="lb_mensaje" runat="server" CssClass="Label" Font-Names="Arial" ForeColor="#0000C0"></asp:Label><asp:Button ID="btn_ActualizarPrecios" runat="server" CssClass="botonnew"
                                        Text="Actualizar Precios" Width="120px" />
                                    <asp:Button ID="btnvolver_agregar" runat="server" CausesValidation="False" CssClass="botonnew"
                                        Text="<< Volver" Width="120px" /></td>
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
