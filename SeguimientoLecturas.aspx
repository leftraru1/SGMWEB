<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SeguimientoLecturas.aspx.vb" Inherits="SeguimientoLecturas" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Seguimiento de Lecturas - Sistema CYR</title>
    <link type="text/css" rel="stylesheet" href="estilos/page.css">
      <link type="text/css" rel="stylesheet" href="estilos/controls.css">
      <link type="text/css" rel="stylesheet" href="estilos/grid.css">
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css">
      <link type="text/css" rel="stylesheet" href="estilos/menu.css">
      <link type="text/css" rel="stylesheet" href="estilos/others.css">
        <script type="text/javascript" language="javascript">    
     function imprimir()
      {       
       window.print();        
      }    
   </script> 
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 758px;
            height: 119px" width="758" id="TABLE1">
            <tr>
                <td style="width: 732px; height: 4px">
                    &nbsp;<asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial"
                        Font-Size="X-Small" Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user"
                            runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa"
                                runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr style="font-size: 12pt; font-family: Times New Roman">
                <td style="width: 732px">
                    <div class="WebPartShadow_seguimiento">
                        <div id="titulo_mod" runat="server" class="WebPartTitle_seguimiento">
                            Seguimiento de Lecturas.</div>
                        <table align="center" border="0" cellspacing="1" style="width: 709px; height: 1px"
                            width="709">
                            <tr>
                                <td align="left" colspan="2" nowrap="nowrap" style="width: 953px; height: 1px">
                                    &nbsp;<asp:RadioButtonList ID="TABLA_CONSULTAS" runat="server" Font-Names="Arial" Height="17px"
                                        RepeatDirection="Horizontal" Width="299px" AutoPostBack="True">
                                        <asp:ListItem Value="1">HISTORICOS</asp:ListItem>
                                        <asp:ListItem Value="2" Selected="True">EN PROCESO</asp:ListItem>
                                    </asp:RadioButtonList>
                                    <table cellspacing="0" style="width: 586px">
                                        <tr>
                                            <td style="width: 50%; height: 4px" align="right">
                                                <h2>
                                                    LOTE:&nbsp;
                                                </h2>
                                            </td>
                                            <td style="width: 50%; height: 4px">
                                                <asp:DropDownList ID="combo_lotes" runat="server" AutoPostBack="True" CssClass="ComboBox"
                                                    Width="160px">
                                                </asp:DropDownList></td>
                                        </tr>
                                        <tr>
                                                    &nbsp;
                                            <td align="right">
                                             <h2>
                                                    LOCALIDAD:&nbsp;
                                                </h2>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="combo_localidades" runat="server" AutoPostBack="True" CssClass="ComboBox"
                                                    Width="160px">
                                                </asp:DropDownList></td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="height: 19px">
                                                 <h2>
                                                    RUTA:&nbsp;
                                                </h2>
                                            </td>
                                            <td style="height: 19px">
                                                <asp:DropDownList ID="combo_rutas" runat="server" AutoPostBack="True" CssClass="ComboBox"
                                                    Width="160px">
                                                </asp:DropDownList></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr style="color: #000000">
                                <td align="right" colspan="2" style="height: 3px; text-align: RIGHT">
                                    &nbsp;<asp:DropDownList ID="comboExcel" runat="server" CssClass="ComboBox" Enabled="False"
                                        Width="128px">
                                        <asp:ListItem>Excel 97 - 2000</asp:ListItem>
                                        <asp:ListItem>Excel 2003 - 2007</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:Button ID="btnExportExcel" runat="server" CssClass="Button" Text="Exportar Excel"
                                        Width="120px" />
                                        <input id="btn_imprime" runat="server" class="Button" style="width: 120px" type="button"
                                            value="Imprimir Reporte" />
                                    <asp:Button ID="Button1" runat="server" CssClass="Button" Text="<< Volver Menu" Width="120px" />
                                </td>
                            </tr>
                            <tr style="color: #000000">
                                <td align="right" colspan="2" style="width: 953px; height: 3px; text-align: left">
                                    &nbsp;<asp:Label ID="lbRegistros" runat="server" Width="537px"></asp:Label>
                                    <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label>
                                    <asp:Label ID="lb_id_usuario" runat="server" Text="Label"></asp:Label>&nbsp;
                                    <asp:DataGrid ID="GrillaAnalisisLect" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                        BorderWidth="0px" CellPadding="1" CellSpacing="1" CssClass="GridAlternativeItems"
                                        GridLines="Horizontal" Height="1px" PageSize="100" Width="1100px" AllowPaging="True">
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
                                            <asp:BoundColumn DataField="cod_localidad" HeaderText="C&#243;digo Localidad">
                                                <HeaderStyle Width="3%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="localidad" HeaderText="Localidad">
                                                <HeaderStyle Width="9%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="lote" HeaderText="Lote">
                                                <HeaderStyle Width="2%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="libro" HeaderText="Ruta">
                                                <HeaderStyle Width="3%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="orden_ruta" HeaderText="Orden Ruta">
                                                <HeaderStyle Width="3%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="nombre" HeaderText="Cliente">
                                                <HeaderStyle Width="15%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="id_servicio" HeaderText="Id. Servicio">
                                                <HeaderStyle Width="7%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="medidor" HeaderText="Medidor">
                                                <HeaderStyle Width="7%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="lectura" HeaderText="Lectura">
                                                <HeaderStyle Width="7%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="minimo" HeaderText="M&#237;nimo">
                                                <HeaderStyle Width="2%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="maximo" HeaderText="M&#225;ximo">
                                                <HeaderStyle Width="2%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="hora_lectura" HeaderText="Hora Lect.">
                                                <HeaderStyle Width="6%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="fecha_lectura" HeaderText="Fecha Lect.">
                                                <HeaderStyle Width="7%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="intentos" HeaderText="Intentos">
                                                <HeaderStyle Width="2%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="clave_lectura" HeaderText="Clave Lect.">
                                                <HeaderStyle Width="4%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="clave_observacion" HeaderText="Clave Obs.">
                                                <HeaderStyle Width="4%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="tipo" HeaderText="TIPO">
                                                <HeaderStyle Width="4%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="cod_lector" HeaderText="C&#243;digo Lector">
                                                <HeaderStyle Width="3%" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="nom_lector" HeaderText="Nombre Lector">
                                                <HeaderStyle Width="10%" />
                                            </asp:BoundColumn>
                                        </Columns>
                                    </asp:DataGrid>
                                    <asp:Label ID="lb_error" runat="server" Font-Names="Arial" ForeColor="Red" Width="660px"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="width: 1100px; height: 4px">
                                    <strong>&nbsp; &nbsp;<asp:Button ID="btn_bajo_back" runat="server" CssClass="Button" Text="<< Volver Menu" Width="120px" />
                                    </strong>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="width: 953px; height: 4px">
                                </td>
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
