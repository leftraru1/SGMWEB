<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EvaluadorFotografia.aspx.vb" Inherits="CYR_EvaluadorFotografia" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">    
    <title>Evaluador Fotográfico - Sistema CYR</title>
    <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
    <link type="text/css" rel="stylesheet" href="estilos/others.css"/>
      
    <script type="text/javascript" language="javascript">           
     function openCalendar(obj)
      {
        var url = 'calendario.aspx?textbox=' + obj;
        window.open(url,'cal','width=260,height=210,left=280 70,top=80,resizable=0,scrollbars=0');
      } 
    </script>    
    
</head>
<body>
    <form id="form1" runat="server">
    <div align="left">
        <table align="center" border="0" cellpadding="0" cellspacing="0" style="height: 119px;">
            <tr>
                <td style="height: 4px;">
                    &nbsp;<asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial"
                        Font-Size="X-Small" Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user"
                            runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa"
                                runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr style="font-size: 12pt; font-family: Times New Roman">
                <td>
                    <div class="WebPartShadow_fotografia">
                        <div id="titulo_mod" runat="server" class="WebPartTitle_fotografia">Evaluador Fotográfico.</div>
                            <table align="left" border="0" cellspacing="1" style="height: 1px">
                                <tr id="fila_filtro_1" runat="server">
                                    <td align="left" colspan="2" nowrap="nowrap" style="height: 1px">
                                        &nbsp;<br/>
                                    
                                    <table>
                                        <tr>
                                        <td style="width:80%;">
                                            <table cellspacing="0" style="font-weight: bold; width: 1050px">
                                                <tr>
                                                    <td style="width: 10%; text-align:right; height: 12px;">
                                                        <h2>
                                                            TIPO DE ORDEN:&nbsp;
                                                        </h2>
                                                    </td>
                                                    <td align="left" colspan="2" style="width: 23%; text-align: left; height: 12px;">
                                                        <asp:DropDownList ID="rd_sector_busqueda" runat="server" AutoPostBack="True" CssClass="ComboBox"
                                                                Font-Names="Arial Unicode MS" Width="200px">
                                                            <asp:ListItem Value="R">REPOSICIONES</asp:ListItem>
                                                            <asp:ListItem Value="C">CORTES</asp:ListItem>
                                                            <asp:ListItem Value="RH">REPOSICIONES HISTORICAS</asp:ListItem>
                                                            <asp:ListItem Value="CH">CORTES HISTORICOS</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>                                         
                                                    <td style="width: 10%; text-align:right; height: 12px;">
                                                        <h2>
                                                            FOTOGRAFIA:&nbsp;
                                                        </h2>
                                                    </td>
                                                    <td colspan="2" style="height: 12px; text-align: left; width: 24%;">
                                                        <asp:DropDownList ID="combo_filtro_fotografia" runat="server" AutoPostBack="True" CssClass="ComboBox"
                                                            Width="200px">
                                                        </asp:DropDownList></td>
                                                    <td style="width: 10%; height: 12px; text-align:right;">
                                                        <h2>
                                                            TIPO ATENCIÓN:&nbsp;
                                                        </h2>                                                
                                                    </td>
                                                    <td style="width: 23%; height: 12px; text-align:left;">
                                                        <asp:DropDownList ID="combo_atendido" runat="server" AutoPostBack="True" CssClass="ComboBox"
                                                            Font-Names="Arial Unicode MS" Width="120px">
                                                            <asp:ListItem Value="T">TODAS</asp:ListItem>
                                                            <asp:ListItem Value="E">EFECTIVAS</asp:ListItem>
                                                            <asp:ListItem Value="I" Selected="True">IMPROCEDENTES</asp:ListItem>
                                                        </asp:DropDownList></td>
                                                </tr>
                                                <tr>
                                                    <td align="left" style="text-align: center; height: 17px;">
                                                    </td>
                                                    <td align="left" colspan="2" style="text-align: left; height: 17px;">
                                                        </td>
                                                    <td align="left" style="text-align: center; height: 17px;">
                                                    </td>
                                                    <td align="left" style="text-align: center; height: 17px;">
                                                    </td>
                                                    <td align="left" style="text-align: center; height: 17px;">
                                                    </td>
                                                    <td align="left" style="text-align: center; height: 17px;">
                                                    </td>
                                                    <td align="left" style="text-align: center; height: 17px;">
                                                    </td>
                                                </tr>            
                                                <tr id="fila_fechas_repo" runat="server">
                                                    <td style="text-align:right; height: 23px;">
                                                        <h2>
                                                            DESDE:&nbsp;
                                                        </h2>
                                                    </td>
                                                    <td colspan="2" style="text-align:left; height: 23px;">
                                                        <asp:TextBox ID="txtDate1" runat="server" CssClass="TextBox2" ReadOnly="false"></asp:TextBox>
                                                        <img
                                                            id="Img2" runat="server" alt="calendario2" onclick="openCalendar('txtDate1');"
                                                            src="fotos/calendario.gif" /><asp:RequiredFieldValidator ID="validar_inf_fecha_desde"
                                                                runat="server" ControlToValidate="txtDate1" CssClass="ErrorMessage" ErrorMessage="*"
                                                                Font-Bold="True" Height="8px" ValidationGroup="fecha">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                                                    ID="validar_fecha_desde" runat="server" BackColor="Transparent" ControlToValidate="txtDate1"
                                                                    CssClass="ErrorMessage" ErrorMessage="RegularExpressionValidator" Font-Bold="False"
                                                                    Font-Names="Arial Unicode MS" Font-Size="X-Small" ValidationExpression="^[0-9]{2}-[0-9]{2}-[0-9]{4}$"
                                                                    ValidationGroup="fecha">Fecha no válida!</asp:RegularExpressionValidator>                                               
                                                    </td>
                                                    <td style="text-align:right; height: 23px;">
                                                        <h2>
                                                            HASTA:&nbsp;
                                                        </h2>
                                                    </td>
                                                    <td colspan="2" style="height: 23px">
                                                        <asp:TextBox ID="txtDate2" runat="server" CssClass="TextBox2" ReadOnly="false"></asp:TextBox>
                                                        <img
                                                            id="Img4" runat="server" alt="Calendario2" onclick="openCalendar('txtDate2');"
                                                            src="fotos/calendario.gif" /><asp:RequiredFieldValidator ID="validar_inf_fecha_hasta"
                                                                runat="server" ControlToValidate="txtDate2" CssClass="ErrorMessage" ErrorMessage="*"
                                                                Font-Bold="True" ValidationGroup="fecha">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                                                    ID="validar_fecha_hasta" runat="server" BackColor="Transparent" ControlToValidate="txtDate2"
                                                                    CssClass="ErrorMessage" ErrorMessage="RegularExpressionValidator" Font-Bold="False"
                                                                    Font-Names="Arial Unicode MS" Font-Size="X-Small" ValidationExpression="^[0-9]{2}-[0-9]{2}-[0-9]{4}$"
                                                                    ValidationGroup="fecha">Fecha no válida!</asp:RegularExpressionValidator></td>
                                                    <td style="height: 23px">
                                                    </td>
                                                    <%--<td align="right" rowspan="2">--%>
                                                    <td style="width: 23%; height: 12px; text-align:left;">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr runat="server" id="fila_lotes_proceso">
                                                    <td style="text-align: right">
                                                        <h2>
                                                            PORCIÓN:&nbsp;
                                                        </h2>
                                                    </td>
                                                    <td colspan="2" style="text-align: left">
                                                        <asp:DropDownList ID="combo_lotes" runat="server" AutoPostBack="True" CssClass="ComboBox"
                                                            Font-Names="Arial Unicode MS" Width="200px">
                                                        </asp:DropDownList></td>
                                                    <td style="text-align: right">
                                                    </td>
                                                    <td colspan="2">
                                                    </td>
                                                    <td style="width: 10%; height: 12px; text-align:right;">
                                                    </td>
                                                    <td style="width: 23%; height: 12px; text-align:left;">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr style="color: #000000; font-family: Times New Roman">
                                                    <td align="right">
                                                        <h2>
                                                            ZONA:&nbsp;
                                                        </h2>
                                                    </td>
                                                    <td colspan="2">
                                                        <asp:DropDownList ID="combo_zonas" runat="server" AutoPostBack="True" CssClass="ComboBox"
                                                            Width="200px" Font-Names="Arial Unicode MS">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td colspan="1" style="text-align:right;">
                                                        <h2>
                                                            LOCALIDAD:&nbsp;
                                                        </h2>
                                                    </td>          
                                                    <td colspan="2">
                                                        <asp:DropDownList ID="combo_localidades" runat="server" AutoPostBack="True" CssClass="ComboBox"
                                                            Width="200px" Font-Names="Arial Unicode MS">
                                                        </asp:DropDownList></td>                                                      
                                                    <td colspan="1" style="text-align:right;">
                                                        <h2>
                                                            RUTA:&nbsp;
                                                        </h2>
                                                    </td>
                                                    <td style="width: 23%; height: 12px; text-align:left;">
                                                        <asp:DropDownList ID="combo_rutas" runat="server" AutoPostBack="True" CssClass="ComboBox"
                                                            Width="120px" Font-Names="Arial Unicode MS">
                                                        </asp:DropDownList></td>
                                                        
                                                        
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                    </td>
                                                    <td colspan="2">
                                                        &nbsp;<asp:Label ID="lb_rut_empresa" runat="server" Font-Bold="True" Font-Names="Arial Unicode MS"
                                                            ForeColor="DimGray"></asp:Label></td>
                                                    <td colspan="2">
                                                    <asp:Label ID="lb_id_perfil" runat="server" Font-Bold="True"
                                                                Font-Names="Arial Unicode MS" ForeColor="DimGray"></asp:Label></td>
                                                    <td colspan="1">
                                                    </td>
                                                    <td colspan="1">
                                                    </td>
                                                    <td colspan="1">
                                                    <asp:Label ID="lb_id_usuario"
                                                                    runat="server" Font-Bold="True" Font-Names="Arial Unicode MS" ForeColor="DimGray"
                                                                    Text="lb_id_usuario"></asp:Label></td>                                   
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="width:20%;">
                                            <asp:Button ID="btnBuscar" runat="server" CssClass="botonnew" Text="FILTRAR" />
                                        </td>
                                    </tr>    
                                </table>
                                                                        
                                </td>
                            </tr>
                            <tr style="color: #000000" id="fila_filtro_2" runat="server">
                                <td align="right" colspan="2" style="width: 1101px; height: 3px; text-align: left">
                                    &nbsp;<asp:Label ID="lbRegistros" runat="server" Font-Names="Arial Unicode MS" Font-Size="X-Small"
                                        ForeColor="Maroon" Width="537px"></asp:Label>
                                    <asp:DataGrid ID="GrillaAnalisisLect" runat="server" AutoGenerateColumns="False"
                                        BackColor="Control" BorderWidth="0px" CellPadding="1" CellSpacing="1" CssClass="GridAlternativeItems"
                                        Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" GridLines="Horizontal" Height="1px" OnEditCommand="MyDataGrid_Edit"
                                        Width="1544px">
                                        <HeaderStyle BackColor="Control" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="True" HorizontalAlign="Center" />
                                        <Columns>
                                            <asp:TemplateColumn HeaderText="Fotografia">
                                                <ItemTemplate>
                                                    <img id="btnDetalles" runat="server" src="fotos/camera_48.png" style="height: 24px" />
                                                    <asp:Image ID="img_error" runat="server" Height="24px" ImageUrl="fotos/cross_48.png" />
                                                    <img id="img_evaluado" runat="server" src="fotos/accepted_48.png" style="height: 24px" />
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:EditCommandColumn CancelText="Cancelar" EditText="◄ Evaluar" HeaderText="Evaluacion"
                                                UpdateText="Actualizar"></asp:EditCommandColumn>
                                            <asp:BoundColumn DataField="cod_localidad" HeaderText="C&#243;d Localidad"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="localidad" HeaderText="Localidad"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="lote" HeaderText="Lote" Visible="False"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="libro" HeaderText="Ruta"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="orden_ruta" HeaderText="Orden Ruta"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="id_servicio" HeaderText="Servicio"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="medidor" HeaderText="Medidor"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="lectura" HeaderText="Lectura"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="Lectura_ant" HeaderText="Lect Anterior"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="minimo" HeaderText="M&#237;nimo"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="maximo" HeaderText="M&#225;ximo"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="MENSAJE" HeaderText="Mensaje"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="hora_ejecucion" HeaderText="Hora"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="fecha_ejecucion" HeaderText="Fecha"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="cod_cortador" HeaderText="Operario"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="nombre" HeaderText="Cliente">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Left" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="id_grupoproceso" HeaderText="id_grupoproceso" Visible="False">
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="foto" HeaderText="Fotografia" Visible="False"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="id_evaluacion_fotografia" HeaderText="id_evaluacion_fotografia" Visible="False"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="DES_CLAVE_LECTURA" HeaderText="Clave Lectura"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="numero_orden" HeaderText="N&#250;mero Orden"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="id_clave_fotografia" HeaderText="id_clave_fotografia" Visible="False"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="id_tipo_orden" HeaderText="id_tipo_orden" Visible="False"></asp:BoundColumn>
                                            <asp:TemplateColumn HeaderText="Ubicacion foto" Visible="False">
                                                <ItemTemplate>
                                                    <asp:Label ID="lb_ubicacion_foto" runat="server"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:BoundColumn DataField="clave_efectiva" HeaderText="clave_efectiva"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="clave_improcedente" HeaderText="clave_improcedente"></asp:BoundColumn>
                                            <%--<asp:BoundColumn DataField="detalle_clave" HeaderText="detalle_clave"></asp:BoundColumn>--%>
                                        </Columns>
                                        <EditItemStyle BackColor="Honeydew" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" />
                                        <PagerStyle BackColor="Control" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Mode="NumericPages"
                                            NextPageText="Siguientes" PrevPageText="Anteriores" />
                                        <AlternatingItemStyle BackColor="White" />
                                        <ItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                    </asp:DataGrid>
                                    <asp:Label ID="lb_error_evaluacion" runat="server" Font-Names="Arial" ForeColor="Red" Width="1026px"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="left" colspan="2" style="width: 1101px; height: 4px">

                                    <table id="tbl_EvaluacionFoto" align="left" runat="server" border="0" style="width: 1144px;">                         
                         
                                        <tr>
                                            <td align="right" style="width: 203px; height: 1px; text-align: right">
                                                <h2>
                                                    <strong>Localidad:</strong>
                                                </h2>
                                            </td>
                                            <td align="right" style="width: 367px; height: 1px; text-align: left">
                                                <asp:Label ID="lb_localidad" runat="server" Font-Bold="True" Font-Names="Arial"
                                                    ForeColor="#0000C0" Width="216px"></asp:Label>
                                            </td>
                                            <td align="right" style="width: 158px; height: 1px; text-align: right">
                                                <h2>
                                                    <strong>Lote: </strong>
                                                </h2>
                                            </td>
                                            <td colspan="4" style="height: 1px; text-align: left; width: 272px;">
                                                <asp:Label ID="lb_lote" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0" Width="256px"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 203px; height: 4px; text-align: right">
                                                <h2>
                                                    <strong>Ruta:</strong>
                                                </h2>
                                            </td>
                                            <td align="right" style="width: 367px; height: 4px; text-align: left">
                                                <asp:Label ID="lb_ruta" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0" Width="216px"></asp:Label></td>
                                            <td align="right" style="width: 158px; height: 4px; text-align: right">
                                                <h2>
                                                    <strong>Número Orden:</strong>
                                                </h2>
                                            </td>
                                            <td colspan="4" style="height: 4px; text-align: left; width: 272px;">
                                                <asp:Label ID="lb_numero_orden" runat="server" Font-Bold="True" Font-Names="Arial"
                                                    ForeColor="#0000C0" Width="250px"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 203px; height: 4px">
                                                <h2>
                                                    <strong>Medidor:</strong>
                                                </h2>
                                            </td>
                                            <td align="right" style="width: 367px; height: 4px; text-align: left">
                                                <asp:Label ID="lb_medidor" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0" Width="216px"></asp:Label></td>
                                            <td align="right" style="width: 158px; height: 4px">
                                                <h2>
                                                    <strong>Servicio:</strong>
                                                </h2>
                                            </td>
                                            <td colspan="4" style="height: 4px; text-align: left; width: 272px;">
                                                <asp:Label ID="lb_servicio" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0" Width="256px"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 203px; height: 4px">
                                                <h2>
                                                    <strong>Lectura: </strong>
                                                </h2>
                                            </td>
                                            <td align="right" style="width: 367px; height: 4px; text-align: left">
                                                <asp:Label ID="lb_lectura" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0" Width="216px"></asp:Label></td>
                                            <td align="right" style="width: 158px; height: 4px">
                                                <h2>
                                                    <strong>Cliente:</strong></h2>
                                            </td>
                                            <td colspan="4" style="height: 4px; text-align: left; width: 272px;">
                                                <asp:Label ID="lb_cliente" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0" Width="256px"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 203px; height: 4px">
                                                <h2>
                                                    <strong>Direccion:</strong>
                                                </h2>
                                            </td>
                                            <td align="right" style="width: 367px; height: 4px; text-align: left">
                                                <asp:Label ID="lb_direccion" runat="server" Font-Bold="True" Font-Names="Arial"
                                                    ForeColor="#0000C0" Width="328px"></asp:Label></td>
                                            <td align="right" style="width: 158px; height: 4px">
                                                <h2>
                                                    <strong>Lectura Anterior:</strong></h2>
                                            </td>
                                            <td colspan="4" style="height: 4px; text-align: left; width: 272px;">
                                                <asp:Label ID="lb_lect_anterior" runat="server" Font-Bold="True" Font-Names="Arial"
                                                    ForeColor="#0000C0" Width="216px"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 203px; height: 1px">
                                                <h2>
                                                    <strong></strong>&nbsp;</h2>
                                            </td>
                                            <td align="right" style="width: 367px; height: 1px; text-align: left">
                                                <asp:Label ID="lb_clave_lectura" runat="server" Font-Bold="True" Font-Names="Arial"
                                                    ForeColor="#0000C0" Width="216px"></asp:Label></td>
                                            <td align="right" style="width: 158px; height: 1px">
                                                <h2>
                                                    <strong>Usuario Evaluador:</strong>
                                                </h2>
                                            </td>
                                            <td colspan="4" style="height: 1px; text-align: left; width: 272px;">
                                                <asp:Label ID="lb_evaluador_inf" runat="server" Font-Bold="True" Font-Names="arial"
                                                    ForeColor="#0000C0" Width="248px"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 203px; height: 1px">
                                                <h2>
                                                    <strong>Clave Corte/Repo:</strong>
                                                </h2>
                                            </td>
                                            <td align="right" style="width: 367px; height: 1px; text-align: left">
                                                <asp:Label ID="lb_Clave_IMP_EFE" runat="server" Font-Bold="True" Font-Names="Arial"
                                                    ForeColor="#0000C0" Width="216px"></asp:Label></td>
                                            <td align="right" style="width: 158px; height: 1px">
                                                <h2>
                                                    <strong>Detalle Clave:</strong>
                                                </h2>
                                            </td>
                                            <td colspan="4" style="width: 272px; height: 1px; text-align: left">
                                                <asp:Label ID="lb_DetalleClave" runat="server" Font-Bold="True" Font-Names="arial"
                                                    ForeColor="#0000C0" Width="248px"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 203px; height: 1px">
                                                 <h2>
                                                    <strong>Tipo Orden:</strong>
                                                 </h2>
                                            </td>
                                            <td align="right" style="width: 367px; height: 1px; text-align: left">
                                                <asp:Label ID="lb_glosa_tipoorden" runat="server" Font-Bold="True" Font-Names="arial" ForeColor="#0000C0"
                                                    Width="248px"></asp:Label></td>
                                            <td align="right" style="width: 158px; height: 1px">
                                            </td>
                                            <td colspan="4" style="width: 272px; height: 1px; text-align: left">
                                            </td>
                                        </tr>
                                        <tr id="fila_duda" runat="server">
                                            <td align="right" style="width: 203px; height: 5px">
                                                <h2>
                                                    <strong>Historial: </strong>
                                                </h2>
                                            </td>
                                            <td align="right" style="width: 367px; height: 5px; text-align: left">
                                                <asp:ImageButton ID="img_historial" runat="server" ImageUrl="~/fotos/hoja.gif" />
                                                <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"></asp:Label></td>
                                            <td align="right" style="width: 158px; height: 5px">
                                                <h2>
                                                    <strong>Mensaje: </strong>
                                                </h2>
                                            </td>
                                            <td colspan="4" style="height: 5px; text-align: left; width: 272px;">
                                                <asp:Label ID="lb_mensaje" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0" Width="256px"></asp:Label><asp:Label ID="lb_id_cortador" runat="server" Font-Bold="True" Font-Names="Arial"
                                                    ForeColor="#0000C0" Width="256px"></asp:Label>
                                                <asp:Label ID="lb_codigo_localidad" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"
                                                    Width="256px"></asp:Label>
                                                <asp:Label ID="lb_id_tipoorden" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"
                                                    Width="256px"></asp:Label>
                                                <asp:Label ID="lb_ubicacion_real_foto" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#0000C0"
                                                    Width="256px"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 203px; height: 1px">
                                                <h2>
                                                    <strong> </strong>
                                                </h2>
                                            </td>
                                            <td align="right" style="width: 367px; height: 1px; text-align: left">
                                                </td>
                                            <td align="right" style="width: 158px; height: 1px">
                                                <h2>
                                                    <strong> </strong>&nbsp;</h2>
                                            </td>
                                            <td colspan="4" style="height: 1px; text-align: left; width: 272px;">
                                                </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 203px">
                                                <h2>
                                                    <strong>Evaluacion:</strong>
                                                </h2>
                                            </td>
                                            <td align="left" colspan="1" style="width: 367px">
                                                <asp:DropDownList ID="combo_evaluar" runat="server" CssClass="ComboBox" Width="304px">
                                                </asp:DropDownList></td>
                                            <td align="left" colspan="3" style="text-align: left">
                                                <asp:Button ID="btn_evaluar" runat="server" CssClass="Button" Text="Evaluar" Width="120px" />
                                                <asp:Button ID="Btn_Cancelar" runat="server" CausesValidation="False" CssClass="Button"
                                                    Text="Volver" Width="120px" />
                                                <asp:Button ID="btn_editar" runat="server" CssClass="Button" Text="Volver a Editar"
                                                    Width="120px" />
                                                </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 203px">
                                                <h2>
                                                    <strong>Clave Fotografia:</strong></h2>
                                            </td>
                                            <td align="left" colspan="1" style="width: 367px">
                                                <asp:DropDownList ID="combo_clave_fotografia" runat="server" CssClass="ComboBox"
                                                    Width="304px">
                                                </asp:DropDownList></td>
                                            <td style="width: 158px">
                                            </td>
                                            <td align="left" colspan="2" style="width: 670px">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5">
                                                <asp:Label ID="lb_error" runat="server" Font-Names="Arial" ForeColor="Red" Width="272px"></asp:Label>
                                                <img id="img_ok" runat="server" src="fotos/ok.bmp" style="height: 16px" visible="false" />
                                                <asp:Label ID="lb_mensaje_confirmacion" runat="server" Font-Bold="True" Font-Names="Arial Unicode MS" ForeColor="Blue"
                                                    Width="592px"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td align="right" colspan="5" style="height: 17px; text-align: right">
                                                &nbsp; &nbsp; &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" colspan="5" style="height: 17px; text-align: left">
                                                <table align="center" border="0" cellspacing="4" style="width: 86%">
                                                    <tr>
                                                        <td style="width: 1%; text-align: left">
                                                            &nbsp;<asp:ImageButton ID="image1" runat="server" BorderStyle="Solid" Height="280px"
                                                                Visible="False" Width="368px" />
                                                            <asp:Label ID="lb_pie_imagen1" runat="server" Visible="False" Font-Names="Arial Unicode MS"></asp:Label></td>
                                                        <td style="width: 1%">
                                                            <asp:ImageButton ID="image2" runat="server" BorderStyle="Solid" Height="280px" Visible="False"
                                                                Width="368px" />
                                                            <asp:Label ID="lb_pie_imagen2" runat="server" Visible="False" Font-Names="Arial Unicode MS"></asp:Label></td>
                                                        <td width="1%">
                                                            &nbsp;<asp:ImageButton ID="image3" runat="server" BorderStyle="Solid" Height="280px"
                                                                Visible="False" Width="368px" /><br />
                                                            <asp:Label ID="lb_pie_imagen3" runat="server" Visible="False" Font-Names="Arial Unicode MS"></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 1%; text-align: left">
                                                            &nbsp;<asp:ImageButton ID="image4" runat="server" BorderStyle="Solid" Height="280px"
                                                                Visible="False" Width="368px" />
                                                            <asp:Label ID="lb_pie_imagen4" runat="server" Visible="False" Font-Names="Arial Unicode MS"></asp:Label></td>
                                                        <td style="width: 1%">
                                                            <asp:ImageButton ID="image5" runat="server" BorderStyle="Solid" Height="280px" Visible="False"
                                                                Width="368px" />
                                                            <asp:Label ID="lb_pie_imagen5" runat="server" Visible="False" Font-Names="Arial Unicode MS"></asp:Label></td>
                                                        <td width="1%">
                                                            &nbsp;<asp:ImageButton ID="image6" runat="server" BorderStyle="Solid" Height="280px"
                                                                Visible="False" Width="368px" /><br />
                                                            <asp:Label ID="lb_pie_imagen6" runat="server" Visible="False" Font-Names="Arial Unicode MS"></asp:Label></td>
                                                    </tr>                                                    
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                        
                                    
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="width: 1101px; height: 4px">
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
