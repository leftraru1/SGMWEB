<%@ Page Language="VB" AutoEventWireup="false" CodeFile="popdetalles.aspx.vb" Inherits="popdetalles" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Detalle CyR...</title>
    <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/others.css"/>
            
      <script type="text/javascript" language="javascript">        
         function openMapa(lat,lon)
          {
            var url = 'MapaGis.aspx?LAT=' + lat + '&LON=' + lon;
            
            window.open(url,'cal','width=800,height=450,left=220,top=142,resizable=0,scrollbars=yes');
              
          }      
      </script>
      
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table id="tbl_inicio" runat="server" align="center" border="0" cellpadding="0" cellspacing="0"
            style="width: 450px; height: 130px">
            <tr>
                <td align="left" style="width: 732px">
                    <div class="WebPartShadow">
                        <div id="Div2" runat="server" class="WebPartTitle">
                            Detalles CyR.</div>
                        <table id="TABLE1" align="center" border="0" cellspacing="0" style="width: 617px;
                            height: 1px">
                            <tr id="Tr1" runat="server">
                                <td align="left" nowrap="nowrap" style="width: 126px; height: 8px">
                                    </td>
                                <td style="width: 131px; height: 8px">
                                </td>
                                <td style="width: 4150px; height: 8px">
                                </td>
                                <td style="width: 38%; height: 8px">
                                    <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label></td>
                            </tr>
                            <tr id="Tr2" runat="server">
                                <td align="left" colspan="4" nowrap="nowrap">
                                    <h2>
                                        Resumen CyR.</h2>
                                </td>
                            </tr>
                            <tr id="Tr3" runat="server">
                                <td align="left" nowrap="nowrap" style="width: 126px; height: 9px">
                                </td>
                                <td style="width: 131px; height: 9px">
                                </td>
                                <td style="width: 4150px; height: 9px">
                                </td>
                                <td style="height: 9px">
                                </td>
                            </tr>
                            <tr id="Tr4" runat="server">
                                <td align="right" nowrap="nowrap" colspan="1" style="width: 126px; height: 26px">
                                    <h2>
                                        &nbsp;Nombre Cliente: 
                                    </h2>
                                </td>
                                <td align="left" colspan="3" nowrap="nowrap" style="width: 177px; height: 26px">
                                    <asp:Label ID="lb_nom_cliente" runat="server" Font-Bold="True" Font-Names="Arial"
                                        ForeColor="#0000C0" Width="368px"></asp:Label></td>                           
                            </tr>
                            <tr runat="server">
                                <td align="right" nowrap="nowrap" colspan="1" style="width: 126px; height: 26px">
                                  <h2>
                                        &nbsp;Dirección: 
                                    </h2>
                                </td>
                                <td align="left" colspan="3" nowrap="nowrap" style="width: 177px; height: 26px">
                                    <asp:Label ID="lb_direccion" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0" Width="368px"></asp:Label></td>
                                <td align="right" style="width: 200px; height: 26px">
                                </td>
                                <td style="height: 32px">
                                </td>
                            </tr>
                            <tr id="Tr9" runat="server">
                                <td align="right" nowrap="nowrap" style="width: 126px; height: 26px">
                                  <h2>  Número de Orden:</h2></td>
                                <td align="left" nowrap="nowrap" style="width: 131px">
                                    <asp:Label ID="lb_num_orden" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                                <td align="right" style="width: 4150px">
                                   <h2> Servicio:</h2></td>
                                <td>
                                    <asp:Label ID="lb_servicio" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"
                                        Width="80px"></asp:Label></td>
                            </tr>
                            <tr id="Tr8" runat="server">
                                <td align="right" nowrap="nowrap" style="width: 126px; height: 26px">
                                    <h2>
                                        Lote:</h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 131px">
                                    <asp:Label ID="lb_lote" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                                <td align="right" style="width: 4150px">
                                    <h2>
                                        Fecha Generación:</h2>
                                </td>
                                <td>
                                    <asp:Label ID="lb_fecha_generacion" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                            </tr>
                            <tr runat="server" id="Tr5">
                                <td align="right" nowrap="nowrap" style="width: 126px; height: 26px">
                                <h2>
                                        Localidad:</h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 131px">                                
                                    <asp:Label ID="lb_localidad" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                                <td align="right" style="width: 4150px">
                                 <h2>
                                     Hora Generación:</h2>
                                </td>
                                <td>
                                    <asp:Label ID="lb_hora_generacion" runat="server" Font-Bold="True" Font-Names="Arial"
                                        ForeColor="#0000C0"></asp:Label></td>
                            </tr>
                            <tr id="Tr10" runat="server">
                                <td align="right" nowrap="nowrap" style="width: 126px; height: 26px">
                                    <h2>
                                        Ruta:</h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 131px">
                                    <asp:Label ID="lb_ruta" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                                <td style="width: 4150px">
                                    <h2 style="text-align: right">  Nivel: 
                                    </h2></td>
                                <td>
                                    <asp:Label ID="lb_nivel" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                            </tr>
                            <tr runat="server" id="Tr6">
                                <td align="right" nowrap="nowrap" style="width: 126px; height: 26px">
                                <h2>
                                     Orden
                                        Ruta:</h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 131px">
                                    <asp:Label ID="lb_Ordenruta" runat="server" Font-Bold="True" Font-Names="Arial"
                                        ForeColor="#0000C0"></asp:Label></td>
                                <td style="width: 4150px">
                                  <h2 style="text-align: right">  Observaciones:</h2></td>
                                <td>
                                    <asp:Label ID="lb_observaciones" runat="server" Font-Bold="True" Font-Names="Arial"
                                        ForeColor="#0000C0"></asp:Label></td>
                            </tr>
                            <tr runat="server" id="Tr11">
                                <td align="right" nowrap="nowrap" style="width: 126px; height: 26px">
                                <h2>
                                    Medidor:</h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 131px">
                                    <asp:Label ID="lb_medidor" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                                <td align="right" style="width: 4150px">
                                <h2>
                                    Marca Med:</h2>
                                </td>
                                <td>
                                    <asp:Label ID="lb_marca" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                            </tr>
                            <tr runat="server" id="Tr12">
                                <td align="right" nowrap="nowrap" style="width: 126px; height: 26px">
                                <h2>
                                    Diámetro:</h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 131px">
                                    <asp:Label ID="lb_diametro" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                                <td align="right" style="width: 4150px">
                                <h2>
                                    &nbsp;</h2>
                                </td>
                                <td>                                </td>
                            </tr>
                            <tr runat="server" id="Tr13">
                                <td align="right" nowrap="nowrap" style="width: 126px; height: 26px">
                                <h2>
                                    GIS ver mapa:</h2>
                                </td>
                                <td align="left" colspan="3" nowrap="nowrap">                                
                                    <asp:ImageButton ID="IMG_MAPA" runat="server" ImageUrl="fotos/ver_mapa.png" Height="40px" width="40px" />
                                        
                                        <!--
                                        <img id="imgMapa" runat="server" onclick="javascript:openMapa('LAT','LON');"  src="fotos/ver_mapa.png" height="40" width="40"  alt="Ver Mapa" style="cursor:hand;"/>                                        
                                        -->
                                        </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="4" style="height: 22px">
                                    &nbsp;<asp:Button ID="btnVolver" runat="server" CssClass="botonnew" Text="Cerrar Ventana"
                                        Width="120px" /></td>
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
