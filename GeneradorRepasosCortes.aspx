<%@ Page Language="VB" AutoEventWireup="false" CodeFile="GeneradorRepasosCortes.aspx.vb" Inherits="GeneradorRepasosCortes" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Generador de Repasos Cortes - Sistema CYR</title>
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
        window.open(url,'cal','width=260,height=210,left=410 410,top=330,resizable=0,scrollbars=0');
      }   
      
      </script>     
      
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table id="tbl_inicio" runat="server" align="center" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 732px">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True" CssClass="Label">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small" CssClass="Label"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True" CssClass="Label">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small" CssClass="Label"></asp:Label>
                                    <asp:Label ID="lb_id_usuario" runat="server" CssClass="Label"></asp:Label>
                                    <asp:Label ID="lb_rut_empresa" runat="server" CssClass="Label"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 732px">
                    <div class="WebPartShadow">
                        <div id="Div2" runat="server" class="WebPartTitle">
                            Generador de Repasos de Cortes...</div>
                            
                        <table align="center" border="0" cellspacing="0">
                            <tr id="Tr1" runat="server">
                                <td align="left" colspan="3" nowrap="nowrap" style="width: 100%; height: 15px">
                                    <h2>
                                        Introduzca los valores deseados y oprima "Filtrar"</h2>
                                </td>
                              
                            </tr>

                            <tr id="Tr2" runat="server">
                                <td align="right" nowrap="nowrap" style="width: 25%; height: 15px">
                                    <h2>
                                        Proceso: &nbsp;</h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 25%; height: 15px">
                                    <asp:DropDownList ID="combo_lotes" runat="server" CssClass="ComboBox2" AutoPostBack="True">
                                    </asp:DropDownList>&nbsp;
                                </td>
                                <td align="right" style="width:18%;">                                   
                                    <h2>
                                        Desde: &nbsp;
                                    </h2>
                                </td>
                                <td style="width: 32%;">
                                    <asp:TextBox ID="txtDate1" runat="server" CssClass="TextBox2" ReadOnly="false"></asp:TextBox>
                                    <img
                                        id="Img2" runat="server" alt="calendario2" onclick="openCalendar('txtDate1');"
                                        src="fotos/calendario.gif" /></td>  
                            </tr>
                            
                            <tr id="Tr4" runat="server">
                                <td align="right" nowrap="nowrap" style="height: 15px">
                                    <h2>
                                        Zona: &nbsp;
                                    </h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="height: 15px">
                                    <asp:DropDownList ID="Combozonas" runat="server" CssClass="ComboBox2" AutoPostBack="True">
                                    </asp:DropDownList>&nbsp;
                                </td>
                                <td align="right">
                                    <h2>
                                        Hasta: &nbsp;
                                    </h2>
                                </td>                                                                  
                                <td>
                                    <asp:TextBox ID="txtDate2" runat="server" CssClass="TextBox2" ReadOnly="false"></asp:TextBox>
                                    <img
                                        id="Img4" runat="server" alt="Calendario2" onclick="openCalendar('txtDate2');"
                                        src="fotos/calendario.gif" /></td>                                  
                            </tr>
                            
                            <tr id="Tr5" runat="server">
                                <td align="right" nowrap="nowrap" style="height: 15px">
                                    <h2>
                                        Localidad: &nbsp;</h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="height: 15px">
                                    <asp:DropDownList ID="combo_localidades" runat="server" CssClass="ComboBox2" AutoPostBack="True">
                                    </asp:DropDownList>&nbsp;
                                 </td>
                                <td align="right">
                                    <h2>
                                        Nro Cliente: &nbsp;
                                    </h2>
                                </td>             
                                <td>
                                    <asp:TextBox ID="txt_id_servicio" runat="server" CssClass="TextBox2" MaxLength="10"
                                        ReadOnly="false" Width="100px"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="ER_id_servicio" runat="server" ControlToValidate="txt_id_servicio"
                                        CssClass="ErrorMessage" Display="Dynamic" ErrorMessage="Sólo números!" Font-Bold="False"
                                        ValidationExpression="^([0-9]{1,50})$" Width="69px"></asp:RegularExpressionValidator></td>                                                                                         
                            </tr>
                            
                            <tr id="Tr3" runat="server">
                                <td align="right" nowrap="nowrap" style="height: 9px">
                                    <h2>
                                        Clave Improcedente: &nbsp;
                                    </h2> 
                                </td>
                                <td align="left" nowrap="nowrap" style="height: 9px">
                                    <asp:DropDownList ID="ComboClavesImprocedentes" runat="server" CssClass="ComboBox2" AutoPostBack="True">
                                    </asp:DropDownList></td>
                                <td align="right">
                                    <h2>
                                        Nro Orden: &nbsp;
                                    </h2>
                                    </td>                                  
                                <td>
                                    <asp:TextBox ID="txt_num_orden" runat="server" CssClass="TextBox2" MaxLength="10" ReadOnly="false"
                                        Width="100px"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txt_num_orden"
                                        CssClass="ErrorMessage" Display="Dynamic" ErrorMessage="Sólo números!" Font-Bold="False"
                                        ValidationExpression="^([0-9]{1,50})$" Width="69px"></asp:RegularExpressionValidator></td>                                                                   
                            </tr>
                            
                            <tr id="Tr6" runat="server">
                                <td align="right" nowrap="nowrap" style="height: 9px">
                                    <h2>
                                        &nbsp;&nbsp;</h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="height: 9px">
                                    <asp:DropDownList ID="DropDownList1" runat="server" CssClass="ComboBox2">
                                        <asp:ListItem Value="0">Todos...</asp:ListItem>
                                    </asp:DropDownList>&nbsp;
                                </td>
                                <td>
                                    <asp:DropDownList ID="combo_rutas" runat="server" CssClass="ComboBox2">
                                        <asp:ListItem Value="0">Todos...</asp:ListItem>
                                    </asp:DropDownList></td>                                  
                                <td>
                                </td>                                                                  
                            </tr>
                            <tr runat="server">
                                <td align="right" nowrap="nowrap" style="height: 9px">
                                </td>
                                <td align="left" nowrap="nowrap" style="height: 9px">
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:Button ID="btnFiltra" runat="server" CssClass="botonnew" Text="Filtrar" /></td>
                            </tr>
                            
                            
                            <tr>
                                <td align="right" colspan="3" style="height: 3px">
                                    &nbsp;<asp:Label ID="lb_cantidad_contratistas" runat="server"></asp:Label>
                                    &nbsp;<asp:Label ID="lb_codigos_contratistas" runat="server"></asp:Label>
                                    &nbsp;<asp:Label ID="lb_lote" runat="server"></asp:Label>
                                    &nbsp;<asp:Label ID="lb_id_tipoproceso" runat="server"></asp:Label>
                                    &nbsp;<asp:Label ID="Label3" runat="server"></asp:Label>
                                    &nbsp;<asp:Label ID="Label2" runat="server"></asp:Label>
                                    &nbsp;<asp:Label ID="lb_grupoproceso" runat="server"></asp:Label>&nbsp;&nbsp;
                                </td>                                
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 758px;
            height: 143px" width="758">
            <tr style="font-size: 12pt; font-family: Times New Roman">
                <td>
                    <div class="WebPartShadow">
                        <table align="center" border="0" cellspacing="0" id="TABLE1">
                            <tr>
                                <td align="left" class="WebPartTitle" colspan="2" nowrap="nowrap">
                            Resultados</td>
                            </tr>
                            <tr style="color: #000000">
                                <td align="center" colspan="2" style="text-align: left">
                                    &nbsp;
                                    <asp:Label ID="lb_ContReg" runat="server" Text="" Font-Names="Arial Unicode MS" ForeColor="Maroon" Width="15px"></asp:Label>
                                    <asp:Label ID="Label1" runat="server" Text="  coincidencia(s) encontrada(s)" Font-Names="Arial Unicode MS" ForeColor="Maroon" Width="262px"></asp:Label>
                                    
                                    <asp:DataGrid ID="GrillaGeneraRepasos" runat="server" AllowSorting="True"
                                        AutoGenerateColumns="False" BorderWidth="0px" CellPadding="1" CellSpacing="1"
                                        CssClass="GridAlternativeItems" GridLines="Horizontal" Height="1px" PageSize="6"
                                        Width="852px">
                                        <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="True" ForeColor="White" HorizontalAlign="Center" Wrap="False" />
                                        <Columns>
                                            <asp:BoundColumn DataField="NOM_LOCALIDAD" HeaderText="Localidad"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="NUMERO_ORDEN" HeaderText="N&#250;mero Orden">
                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" Wrap="False" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="ID_SERVICIO" FooterText="sfgdgf" HeaderText="Nro Cliente">
                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" Wrap="False" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="DESCRIPCION_IMPROCEDENCIA" HeaderText="Clave Improcedente">
                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" Wrap="False" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn HeaderText="Fecha Generaci&#243;n" DataField="FECHA_GENERACION">
                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" Wrap="False" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:BoundColumn>
                                            <%--<asp:BoundColumn HeaderText="D&#237;as Cierre" DataField="DIAS_CIERRE" Visible="False">
                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" Wrap="False" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="DIAS_COMPLETADOS" HeaderText="D&#237;as Completados" Visible="False">
                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" Wrap="False" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="DIAS_RESTANTES" HeaderText="D&#237;as Restantes" Visible="False">
                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" Wrap="False" />
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:BoundColumn>--%>
                                            <asp:TemplateColumn HeaderText="Repasar">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="check_repaso" runat="server" Checked="True"/>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                        </Columns>
                                        <EditItemStyle BackColor="Honeydew" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                        <PagerStyle BackColor="Control" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Mode="NumericPages"
                                            NextPageText="Siguientes" PrevPageText="Anteriores" Wrap="False" />
                                        <AlternatingItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                        <ItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
                                        <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <SelectedItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:DataGrid>
                                    
                                    
                                    <asp:Image ID="img_ok" runat="server" ImageUrl="fotos/ok.bmp" /><asp:Label ID="lb_mensaje"
                                        runat="server" Font-Names="Arial Unicode MS" ForeColor="#0000C0" CssClass="Label" Font-Size="Small" Width="587px"></asp:Label><asp:Label
                                            ID="lb_error" runat="server" CssClass="Label" Font-Names="Arial Unicode MS" Font-Size="Small"
                                            ForeColor="Red" Height="18px"></asp:Label></td>
                            </tr>
                            <tr style="color: #000000">
                                <td align="center" colspan="2" style="text-align: left">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <table>
                                        <tr>
                                            <td style="text-align: right">
                                               <h2>Total Improcedentes:</h2> </td>
                                            <td>
                                                <asp:TextBox ID="txt_cont_improcedentes" runat="server" CssClass="TextBox_totalizador"
                                                    ReadOnly="True"></asp:TextBox></td>
                                            <td>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="2">
                                    </td>
                            </tr>
                            <tr>
                                <td  colspan="2" align="right" style="height: 21px">
                                    <asp:Button ID="btnGeneraRepaso" runat="server" Text="Generar Repaso" CssClass="botonnew" Width="120px" />
                    <asp:Button ID="btnVolver" runat="server" CssClass="botonnew" Text="<< Volver" Width="120px" />
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
