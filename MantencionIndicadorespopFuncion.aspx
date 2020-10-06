<%@ Page Language="VB"  CodeFile="MantencionIndicadorespopFuncion.aspx.vb" Inherits="MantencionIndicadorespopFuncion" %>

<script runat=server>
   
</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>INDICADORES SELECCION</title>
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
<body>
    <form id="form1" runat="server">
        <div>
            <table id="TABLE2" align="center" border="0" cellpadding="0" cellspacing="0" style="width: 858px;
                height: 152px">
                <tr>
                    <td align="right" style="width: 855px">
                        &nbsp;&nbsp; &nbsp;<asp:LinkButton ID="lk_session" runat="server" CausesValidation="False"
                            Font-Bold="True" Font-Names="Arial" Font-Size="X-Small">Cerrar Sesion</asp:LinkButton>
                    </td>
                </tr>
                <tr style="font-weight: bold">
                    <td style="width: 855px">
                        <div class="WebPartShadow_more">
                            <div id="titulo_mod" runat="server" class="WebPartTitle_more">
                              <h2 class="WebPartTitle">  INDICADORES </h2>
                            </div>
                            <table align="center" border="0" cellspacing="0" style="width: 823px; height: 1px">
                                <tr>
                                    <td align="right" colspan="2" nowrap="nowrap" style="height: 23px; text-align: right">
                                        </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="3" style="height: 6px; width: 823px; text-align: left;">
                                      <h2>  CLAVES IMPROCEDENTES <br />
                                        <asp:DataGrid ID="GrillaImprocedentes" runat="server" AutoGenerateColumns="False"
                                            BorderWidth="0px" CellPadding="1" CellSpacing="1" CssClass="GridAlternativeItems" Height="1px"
                                                Width="808px">
                                            <PagerStyle BackColor="Control" Font-Bold="True" Mode="NumericPages" Visible="False" />
                                            <ItemStyle BackColor="White" />
                                            <Columns>
                                                <asp:BoundColumn DataField="clave" HeaderText="CLAVE">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Width="10%" BackColor="#006699" ForeColor="White" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" HorizontalAlign="Center" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="descripcion" HeaderText="DESCRIPCION">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Width="9%" BackColor="#006699" ForeColor="White" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" HorizontalAlign="Center" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="cantidad" HeaderText="CANTIDAD">
                                                    <HeaderStyle BackColor="#006699" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                                        Font-Strikeout="False" Font-Underline="True" ForeColor="White" Width="10%" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" HorizontalAlign="Center" />
                                                </asp:BoundColumn>
                                            </Columns>
                                            <HeaderStyle BackColor="Control" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                Font-Strikeout="False" Font-Underline="False" ForeColor="Black" HorizontalAlign="Center" />
                                        </asp:DataGrid> </h2> <h2>CLAVES EFECTIVAS </h2><asp:DataGrid ID="GrillaEfectivas" runat="server" AutoGenerateColumns="False"
                                            BorderWidth="0px" CellPadding="1" CellSpacing="1" CssClass="GridAlternativeItems" Height="1px"
                                            Width="808px">
                                            <PagerStyle BackColor="Control" Font-Bold="True" Mode="NumericPages" Visible="False" />
                                            <ItemStyle BackColor="White" />
                                            <Columns>
                                                <asp:BoundColumn DataField="clave" HeaderText="CLAVE">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Width="10%" BackColor="#006699" ForeColor="White" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" HorizontalAlign="Center" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="descripcion" HeaderText="DESCRIPCION">
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Width="9%" BackColor="#006699" ForeColor="White" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" HorizontalAlign="Center" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="cantidad" HeaderText="CANTIDAD">
                                                    <HeaderStyle BackColor="#006699" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                                        Font-Strikeout="False" Font-Underline="True" ForeColor="White" Width="10%" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" HorizontalAlign="Center" />
                                                </asp:BoundColumn>
                                            </Columns>
                                            <HeaderStyle BackColor="Control" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                Font-Strikeout="False" Font-Underline="False" ForeColor="Black" HorizontalAlign="Center" />
                                        </asp:DataGrid></td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2" style="height: 1px; text-align: left">
                                        &nbsp;<table border="0" cellpadding="0" cellspacing="0" style="width: 800px">
                                            <tr>
                                                <td style="width: 22%">
                                                    <h2>
                                                        ENTREGADOS</h2>
                                                </td>
                                                <td style="width: 27%">
                                                    <asp:TextBox ID="txt_total" runat="server" CssClass="TextBox" ReadOnly="True" Width="50px"></asp:TextBox></td>
                                                <td align="center" rowspan="3" style="width: 26%">
                                                    &nbsp;<br />
                                                    &nbsp;<br />
                                                </td>
                                                <td align="center" rowspan="3" style="width: 25%">
                                                    &nbsp;<br />
                                                    &nbsp;<br />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 19px">
                                                    <h2>
                                                        TOTAL EFECTIVAS</h2>
                                                </td>
                                                <td style="width: 129px; height: 19px">
                                                    <asp:TextBox ID="txt_cant_efectivas" runat="server" CssClass="TextBox" ReadOnly="True"
                                                        Width="50px"></asp:TextBox>
                                                    <asp:TextBox ID="txt_efectivos" runat="server" CssClass="TextBox" ReadOnly="True"
                                                        Width="50px"></asp:TextBox>%</td>
                                            </tr>
                                            <tr>
                                                <td style="height: 20px">
                                                    <h2>
                                                        TOTAL IMPROCEDENTES</h2>
                                                </td>
                                                <td style="width: 129px; height: 20px;">
                                                    <asp:TextBox ID="txt_cant_improcedentes" runat="server" CssClass="TextBox" ReadOnly="True"
                                                        Width="50px"></asp:TextBox>
                                                    <asp:TextBox ID="txt_sin_lecturas" runat="server" CssClass="TextBox" ReadOnly="True"
                                                        Width="50px"></asp:TextBox>%</td>
                                            </tr>
                                            <tr>
                                                <td style="height: 20px">
                                                   <h2>
                                                    EFECTIVIDAD </h2></td>
                                                <td style="width: 129px; height: 20px;">
                                                    <asp:TextBox ID="txt_efectividad" runat="server" CssClass="TextBox" ReadOnly="True" Width="50px"></asp:TextBox>
                                                    %</td>
                                                <td align="center" rowspan="1" colspan="2" style="text-align: right; height: 20px;">
                                                    <asp:Button ID="btnVolver" runat="server" CssClass="Button" Text="Cerrar Ventana"
                                                        Width="120px" /></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="2">
                                                                            <asp:Label ID="VALIDA_DELETE_PROVEEDOR" runat="server" Font-Bold="False" Font-Names="Arial"
                                            ForeColor="Red" Visible="False"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2">
                                        &nbsp;
                                        <img id="img_ok" runat="server" src="fotos/ok.bmp" visible="false" />
                                        <asp:Label ID="lb_mensaje_ingreso" runat="server" Font-Bold="True" Font-Names="Arial"
                                            Font-Size="X-Small" ForeColor="Navy" Width="175px" Visible="False"></asp:Label></td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr style="font-weight: bold">
                    <td style="width: 855px; height: 17px;">
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
