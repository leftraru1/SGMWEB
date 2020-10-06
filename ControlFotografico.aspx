<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ControlFotografico.aspx.vb" Inherits="ControlFotografico" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Control Fotográfico - Sistema CYR </title>
    <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/others.css"/> 
    <link type="text/css" rel="stylesheet" href="estilos/style.css"/>     
    <link type="text/css" rel="stylesheet" href="estilos/loadingbox.css" />              
    <link type="text/css" href="estilos/jquery-ui.css" rel="stylesheet" />
    
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-ui.min.js"></script>
    
    <script src="js/progress.js" type="text/javascript"></script>
    <script src="js/upload_progress.js" type="text/javascript"></script> 
    
    <script type="text/javascript" language="javascript">        
        function openCalendar(obj)
        {
        var url = 'calendario.aspx?textbox=' + obj;
        window.open(url,'cal','width=260,height=210,left=410 410,top=330,resizable=0,scrollbars=0');
        }                        

        function PopDetalles(p_id_servicio,p_medidor,p_num_orden,p_id_tipoorden,p_sector_busqueda)      
        {        
        var url = 'ControlFotograficoDetalle.aspx?idServicio='+p_id_servicio+'&medidor='+p_medidor+'&num_orden='+p_num_orden+'&id_tipoorden='+p_id_tipoorden+'&sector_busqueda='+p_sector_busqueda;
        open(url,'DetalleLectura','top=5,left=10,width=935,height=530,status=yes,resizable=yes');
        }          
    </script> 
      
</head>

<body>
    <form id="form1" runat="server">
    <img src="fotos/procesando3.gif" alt="" style="display:none;" />
    <img src="fotos/uploading.gif" alt="" style="display:none;" />
    
    <div>
        <table id="Table5" runat="server" align="center" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td id="panel_sesion">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label
                                        ID="lb_rut_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label
                                            ID="lb_id_usuario" runat="server" CssClass="Label" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr style="font-family: Trebuchet MS">
                <td id="tbl_inicio" runat="server" class="WebPartShadow">
                    <table align="center" cellpadding="0">
                        <tr id="Tr1" runat="server">
                            <td align="left" class="WebPartTitle_ext" colspan="6" nowrap="nowrap">
                                Reporte de Control Fotográfico</td>
                        </tr>
                        <tr id="Tr2" runat="server">
                            <td align="left" colspan="3" nowrap="nowrap" style="height: 10px">
                                <asp:RadioButtonList ID="SectorBusqueda" runat="server" Height="16px" RepeatDirection="Horizontal"
                                    Width="264px" AutoPostBack="True" onchange="$.showprogress()">
                                    <asp:ListItem Value="0">En proceso</asp:ListItem>
                                    <asp:ListItem Value="1">Hist&#243;ricos</asp:ListItem>
                                </asp:RadioButtonList></td>
                            <td align="right" colspan="3" nowrap="nowrap" style="height: 10px">
                                </td>
                        </tr>
                        <tr id="Tr3" runat="server" style="font-family: Trebuchet MS">
                            <td align="left" colspan="3" nowrap="nowrap">
                                <h2>
                                    Seleccione información y luego oprima "BUSCAR"</h2>
                            </td>
                            <td align="right" colspan="3" nowrap="nowrap">
                                </td>
                        </tr>
                        <tr id="Tr4" runat="server" style="color: #4d4747; font-family: Trebuchet MS">
                            <td align="right" nowrap="nowrap">
                                <asp:Label ID="lbl_servicio" runat="server" CssClass="Label" Font-Names="calibri(cuerpo)"
                                    Font-Size="9pt" Text="Servicio:"></asp:Label>&nbsp;</td>
                            <td align="left" nowrap="nowrap">
                                <asp:TextBox ID="txt_servicio" runat="server" CssClass="TextBox3" MaxLength="20" Width="106px"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="re_servicios" runat="server" ControlToValidate="txt_servicio"
                                    Display="Dynamic" Font-Names="Arial Unicode MS" Font-Size="X-Small" ValidationExpression="^([0-9]{1,15})$">Sólo números!</asp:RegularExpressionValidator></td>
                            <td align="left" nowrap="nowrap" style="text-align: right">
                                <asp:Label ID="lbl_numOrden" runat="server" CssClass="Label" Font-Names="calibri(cuerpo)"
                                    Font-Size="9pt" Text="Num Orden:"></asp:Label>&nbsp;</td>
                            <td align="left" nowrap="nowrap">
                                <asp:TextBox ID="txt_numorden" runat="server" CssClass="TextBox3" MaxLength="15" Width="106px"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="re_num_orden" runat="server" ControlToValidate="txt_numorden"
                                    Display="Dynamic" Font-Names="Arial Unicode MS" Font-Size="X-Small" ValidationExpression="^([0-9]{1,15})$">Sólo números!</asp:RegularExpressionValidator></td>
                            <td align="left" nowrap="nowrap" style="text-align: right">
                            </td>
                            <td align="left" nowrap="nowrap">
                            </td>
                        </tr>
                        <tr id="Tr5" runat="server">
                            <td align="right" nowrap="nowrap" style="height: 19px">
                                <h2 style="text-align: right">
                                    Proceso:&nbsp;
                                </h2>
                            </td>
                            <td align="left" nowrap="nowrap" style="height: 19px">
                                <asp:DropDownList ID="combo_lotes" runat="server" AutoPostBack="True" CssClass="ComboBox2"
                                    onchange="$.showprogress()">
                                </asp:DropDownList></td>
                            <td align="left" nowrap="nowrap" style="width: 75px; height: 19px; text-align: right">
                                <h2>
                                    Clase OT:&nbsp;
                                </h2>
                            </td>
                            <td align="left" nowrap="nowrap" style="height: 19px">
                                <asp:DropDownList ID="clase_ot" runat="server" AutoPostBack="True" CssClass="ComboBox2"
                                    onchange="$.showprogress()">
                                </asp:DropDownList></td>
                            <td align="left" nowrap="nowrap" style="height: 19px; text-align: right">
                                <h2>
                                    Operador:
                                </h2>
                            </td>
                            <td align="left" nowrap="nowrap" style="height: 19px">
                                <asp:DropDownList ID="cbo_cortador" runat="server" AutoPostBack="True" CssClass="ComboBox2"
                                    onchange="$.showprogress()" Width="209px">
                                </asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap" style="height: 21px">
                                <h2 style="text-align: right">
                                    Zona:&nbsp;
                                </h2>
                            </td>
                            <td align="left" nowrap="nowrap" style="height: 21px">
                                <asp:DropDownList ID="Combozonas" runat="server" AutoPostBack="True" CssClass="ComboBox2" onchange="$.showprogress()">
                                </asp:DropDownList>
                            </td>
                            <td align="left" nowrap="nowrap" style="width: 75px; height: 21px; text-align: right">
                                <h2 style="text-align: right">
                                    Estado Asig:&nbsp;</h2>
                            </td>
                            <td align="left" nowrap="nowrap" style="height: 21px">
                                <asp:DropDownList ID="combo_Estados" runat="server" AutoPostBack="True" CssClass="ComboBox2"
                                    onchange="$.showprogress()">
                                </asp:DropDownList></td>
                            <td align="left" nowrap="nowrap" style="height: 21px">
                                <h2 style="text-align: right">
                                    Desde:</h2>
                            </td>
                            <td align="left" nowrap="nowrap" style="height: 21px">
                                <asp:TextBox ID="txtDate1" runat="server" CssClass="TextBox2" ReadOnly="false"></asp:TextBox><img
                                    id="Img2" runat="server" alt="calendario2" onclick="openCalendar('txtDate1');"
                                    src="fotos/calendario.gif" /><asp:RequiredFieldValidator ID="validar_inf_fecha_desde"
                                        runat="server" ControlToValidate="txtDate1" CssClass="ErrorMessage" ErrorMessage="*"
                                        Font-Bold="True" Height="8px" ValidationGroup="fecha">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                            ID="validar_fecha_desde" runat="server" BackColor="Transparent" ControlToValidate="txtDate1"
                                            CssClass="ErrorMessage" Display="Dynamic" ErrorMessage="RegularExpressionValidator"
                                            Font-Bold="False" Font-Size="X-Small" ValidationExpression="^[0-9]{2}-[0-9]{2}-[0-9]{4}$"
                                            ValidationGroup="fecha">Fecha no válida</asp:RegularExpressionValidator></td>
                        </tr>
                        <tr id="Tr8" runat="server">
                            <td align="right" nowrap="nowrap">
                                <h2>
                                    Localidad:&nbsp;</h2>
                            </td>
                            <td align="left" nowrap="nowrap">
                                <asp:DropDownList ID="combo_localidades" runat="server" AutoPostBack="True" CssClass="ComboBox2"
                                    onchange="$.showprogress()">
                                </asp:DropDownList></td>
                            <td align="left" nowrap="nowrap" style="width: 75px">
                                <h2 style="text-align: right">
                                    Ruta:&nbsp;</h2>
                            </td>
                            <td align="left" nowrap="nowrap">
                                <asp:DropDownList ID="combo_ruta" runat="server" AutoPostBack="True" CssClass="ComboBox2">
                                </asp:DropDownList></td>
                            <td align="left" nowrap="nowrap">
                                <h2 style="text-align: right">
                                    Hasta:</h2>
                            </td>
                            <td align="left" nowrap="nowrap">
                                <asp:TextBox ID="txtDate2" runat="server" CssClass="TextBox2" ReadOnly="false"></asp:TextBox><img
                                    id="Img4" runat="server" alt="Calendario2" onclick="openCalendar('txtDate2');"
                                    src="fotos/calendario.gif" /><asp:RequiredFieldValidator ID="validar_inf_fecha_hasta"
                                        runat="server" ControlToValidate="txtDate2" CssClass="ErrorMessage" ErrorMessage="*"
                                        Font-Bold="True" ValidationGroup="fecha">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                            ID="validar_fecha_hasta" runat="server" BackColor="Transparent" ControlToValidate="txtDate2"
                                            CssClass="ErrorMessage" Display="Dynamic" ErrorMessage="RegularExpressionValidator"
                                            Font-Bold="False" Font-Size="X-Small" ValidationExpression="^[0-9]{2}-[0-9]{2}-[0-9]{4}$"
                                            ValidationGroup="fecha">Fecha no válida</asp:RegularExpressionValidator></td>
                        </tr>
                        <tr id="Tr6" runat="server">
                            <td align="right" nowrap="nowrap">
                            </td>
                            <td align="left" nowrap="nowrap">
                                <asp:Label ID="lb_cantidad_contratistas" runat="server"></asp:Label></td>
                            <td align="left" nowrap="nowrap" style="width: 75px">
                            </td>
                            <td align="left" nowrap="nowrap">
                                <asp:Label ID="lb_codigos_contratistas" runat="server"></asp:Label></td>
                            <td align="left" nowrap="nowrap">
                            </td>
                            <td align="left" nowrap="nowrap" style="text-align: left">
                            </td>
                        </tr>
                        <tr id="Tr14" runat="server">
                            <td align="right" nowrap="nowrap" style="height: 19px">
                                <h2>
                                    &nbsp; &nbsp;&nbsp;
                                </h2>
                            </td>
                            <td align="left" nowrap="nowrap" style="height: 19px">
                                &nbsp;
                            </td>
                            <td align="left" nowrap="nowrap" style="width: 75px; height: 19px">
                                <h2 style="text-align: right">
                                    &nbsp;</h2>
                            </td>
                            <td align="left" nowrap="nowrap" style="height: 19px">
                            </td>
                            <td align="left" nowrap="nowrap" style="height: 19px">
                                <h2 style="text-align: right">
                                    &nbsp;&nbsp;</h2>
                            </td>
                            <td align="left" nowrap="nowrap" style="height: 19px; text-align: right">
                                <asp:Button ID="btnBuscar" runat="server" CausesValidation="False" CssClass="botonnew"
                                    OnClientClick="$.showprogress()" Text="BUSCAR" />
                            </td>
                        </tr>
                        <tr id="Tr9" runat="server">
                            <td align="left" colspan="6" nowrap="nowrap" style="height: 17px; text-align: left">
                                <asp:Label ID="lb_error_filtro" runat="server" CssClass="ErrorMessage" Font-Names="Arial Unicode MS"
                                    Font-Size="Small" ForeColor="Red"></asp:Label></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    
    </div>
        <table id="tbl_inicio2" runat="server" align="center" border="0" cellspacing="0"
            class="WebPartShadow">

            <tr>
                <td align="left" class="WebPartShadow" colspan="2" style="width: 1727px;">
                    <asp:Label ID="LB_REGISTROS_GRID" runat="server" CssClass="Label" Text="0 coincidencia(s) encontrada(s)"></asp:Label>
                    <asp:DataGrid ID="GrillaPrincipal" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                        BorderColor="#003366" BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1"                        
                        CssClass="GridAlternativeItems" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                        Font-Strikeout="False" Font-Underline="False" ForeColor="Black" GridLines="Horizontal"
                        Height="1px" OnEditCommand="SeleccionRegistro" PageSize="100" Width="1796px">
                        <HeaderStyle BackColor="CornflowerBlue" BorderColor="Black" Font-Bold="True" Font-Italic="False"
                            Font-Overline="False" Font-Strikeout="False" Font-Underline="True" ForeColor="White"
                            HorizontalAlign="Center" Wrap="False" />
                        <Columns>
                            <asp:BoundColumn DataField="direccion" HeaderText="Direcci&#243;n">
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="nom_cliente" HeaderText="Cliente">
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="orden_ruta" HeaderText="Orden Ruta">
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="tipo_orden" HeaderText="Tipo Orden"></asp:BoundColumn>
                            <asp:BoundColumn DataField="numero_orden" HeaderText="N&#250;mero Orden">
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="id_servicio" HeaderText="Servicio">
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="medidor" HeaderText="Medidor">
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="atendido" HeaderText="ATENDIDO" Visible="False"></asp:BoundColumn>
                            <asp:BoundColumn DataField="id_tipoorden" HeaderText="id_tipoorden" Visible="False">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="fecha" HeaderText="Fecha"></asp:BoundColumn>
                            <asp:BoundColumn DataField="hora" HeaderText="Hora"></asp:BoundColumn>
                            <asp:BoundColumn DataField="codigo_orden" HeaderText="C&#243;digo Orden"></asp:BoundColumn>
                            <asp:BoundColumn DataField="tipo_gestion" HeaderText="Tipo Gesti&#243;n"></asp:BoundColumn>
                            <asp:BoundColumn DataField="clave_lectura" HeaderText="Clave Lectura"></asp:BoundColumn>
                            <asp:BoundColumn DataField="lectura" HeaderText="Lectura"></asp:BoundColumn>
                            <asp:BoundColumn DataField="fecha_ejecucion" HeaderText="Fecha Ejecuci&#243;n (dd-mm-yyyy)">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="hora_ejecucion" HeaderText="Hora Ejecuci&#243;n (HH:MM)">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="tipo" HeaderText="Tipo"></asp:BoundColumn>
                            <asp:BoundColumn DataField="resultado" HeaderText="Resultado"></asp:BoundColumn>
                            <asp:BoundColumn DataField="codigo_operador" HeaderText="C&#243;digo Operador"></asp:BoundColumn>
                            <asp:BoundColumn DataField="observaciones" HeaderText="Observaciones"></asp:BoundColumn>
                            <asp:BoundColumn DataField="grupo_proceso" HeaderText="Grupo-Proceso"></asp:BoundColumn>
                            <asp:BoundColumn DataField="tipo_proceso" HeaderText="Tipo Proceso"></asp:BoundColumn>
                            <asp:BoundColumn DataField="numero_sello" HeaderText="N&#176; Sello"></asp:BoundColumn>
                            <asp:BoundColumn DataField="error_claves" HeaderText="Error Claves"></asp:BoundColumn>
                            <asp:BoundColumn DataField="fotografias_esperadas" HeaderText="Fotograf&#237;as Esperadas">
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="fotografias_tomadas" HeaderText="Fotograf&#237;as Tomadas ">
                            </asp:BoundColumn>
                            <asp:TemplateColumn HeaderText="Ver detalle">
                                <ItemTemplate>
                                    <img runat="server" alt="Ver fotografías" src="fotos/lupa.png" id="btnDetalles" />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                        </Columns>
                        <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                            Mode="NumericPages" Wrap="False" />
                        <ItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
                        <AlternatingItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
                        <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" Wrap="False" />
                        <EditItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" Wrap="False" />
                        <SelectedItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" Wrap="False" />
                    </asp:DataGrid>&nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: right">
                    <asp:HyperLink ID="control_HL_EFE" runat="server" Font-Bold="True" Font-Overline="False"
                        ForeColor="Blue" Style="text-align: center" Width="151px">Guardar Excel generado</asp:HyperLink>
                    &nbsp;<asp:Button ID="btnExcel" runat="server" CausesValidation="False" CssClass="botonnew"
                        Text="Generar Excel" ToolTip="Guardar en formato Libro Excel 97-2003" />
                    <asp:Button ID="btnVolver" runat="server" CssClass="botonnew" Text="<< Volver" ValidationGroup="ninguno" /></td>
            </tr>
        </table><asp:DataGrid ID="GrillaPrincipal_aux" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                        BorderColor="#003366" BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1"                        
                        CssClass="GridAlternativeItems" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                        Font-Strikeout="False" Font-Underline="False" ForeColor="Black" GridLines="Horizontal"
                        Height="1px" OnEditCommand="SeleccionRegistro" PageSize="100" Width="1796px">
            <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" Wrap="False" />
            <EditItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" Wrap="False" />
            <SelectedItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" Wrap="False" />
            <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                            Mode="NumericPages" Wrap="False" />
            <AlternatingItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
            <ItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
            <Columns>
                <asp:BoundColumn DataField="direccion" HeaderText="Direcci&#243;n">
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" HorizontalAlign="Left" Wrap="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="nom_cliente" HeaderText="Cliente">
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" HorizontalAlign="Left" Wrap="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="orden_ruta" HeaderText="Orden Ruta">
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="tipo_orden" HeaderText="Tipo Orden"></asp:BoundColumn>
                <asp:BoundColumn DataField="numero_orden" HeaderText="N&#250;mero Orden">
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="id_servicio" HeaderText="Servicio">
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="medidor" HeaderText="Medidor">
                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="True" Wrap="False" />
                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="False" />
                </asp:BoundColumn>
                <asp:BoundColumn DataField="atendido" HeaderText="ATENDIDO" Visible="False"></asp:BoundColumn>
                <asp:BoundColumn DataField="id_tipoorden" HeaderText="id_tipoorden" Visible="False">
                </asp:BoundColumn>
                <asp:BoundColumn DataField="fecha" HeaderText="Fecha"></asp:BoundColumn>
                <asp:BoundColumn DataField="hora" HeaderText="Hora"></asp:BoundColumn>
                <asp:BoundColumn DataField="codigo_orden" HeaderText="C&#243;digo Orden"></asp:BoundColumn>
                <asp:BoundColumn DataField="tipo_gestion" HeaderText="Tipo Gesti&#243;n"></asp:BoundColumn>
                <asp:BoundColumn DataField="clave_lectura" HeaderText="Clave Lectura"></asp:BoundColumn>
                <asp:BoundColumn DataField="lectura" HeaderText="Lectura"></asp:BoundColumn>
                <asp:BoundColumn DataField="fecha_ejecucion" HeaderText="Fecha Ejecuci&#243;n (dd-mm-yyyy)">
                </asp:BoundColumn>
                <asp:BoundColumn DataField="hora_ejecucion" HeaderText="Hora Ejecuci&#243;n (HH:MM)">
                </asp:BoundColumn>
                <asp:BoundColumn DataField="tipo" HeaderText="Tipo"></asp:BoundColumn>
                <asp:BoundColumn DataField="resultado" HeaderText="Resultado"></asp:BoundColumn>
                <asp:BoundColumn DataField="codigo_operador" HeaderText="C&#243;digo Operador"></asp:BoundColumn>
                <asp:BoundColumn DataField="observaciones" HeaderText="Observaciones"></asp:BoundColumn>
                <asp:BoundColumn DataField="grupo_proceso" HeaderText="Grupo-Proceso"></asp:BoundColumn>
                <asp:BoundColumn DataField="tipo_proceso" HeaderText="Tipo Proceso"></asp:BoundColumn>
                <asp:BoundColumn DataField="numero_sello" HeaderText="N&#176; Sello"></asp:BoundColumn>
                <asp:BoundColumn DataField="error_claves" HeaderText="Error Claves"></asp:BoundColumn>
                <asp:BoundColumn DataField="fotografias_esperadas" HeaderText="Fotograf&#237;as Esperadas">
                </asp:BoundColumn>
                <asp:BoundColumn DataField="fotografias_tomadas" HeaderText="Fotograf&#237;as Tomadas ">
                </asp:BoundColumn>
            </Columns>
            <HeaderStyle BackColor="CornflowerBlue" BorderColor="Black" Font-Bold="True" Font-Italic="False"
                            Font-Overline="False" Font-Strikeout="False" Font-Underline="True" ForeColor="White"
                            HorizontalAlign="Center" Wrap="False" />
        </asp:DataGrid>
    </form>
</body>
</html>
