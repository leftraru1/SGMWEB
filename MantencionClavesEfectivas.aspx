<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MantencionClavesEfectivas.aspx.vb" Inherits="MantencionClavesEfectivas" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Mantenedor de Claves de Lectura - Sistema CYR</title>
     <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/others.css"/> 
      
      
<%--      <script language="JavaScript1.2">
window.moveTo(0,0);
top.window.resizeTo(screen.availWidth,screen.availHeight);
</script>   --%>

<%--       <script type="text/javascript" language="javascript">    
    
    var cabecera=window.screenTop

if (navigator.appName == 'Microsoft Internet Explorer')
{
   window.moveTo(-6,-cabecera)
   window.resizeTo(screen.width+9,screen.height+cabecera+25)
}
</script>--%>
      
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 1159px">
            <tr>
                <td style="width: 1176px; height: 13px;">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 1176px;">
                    <div class="WebPartShadow">
                        <div id="titulo_mod" runat="server" class="WebPartTitle">
                            Mantención de Claves Efectivas</div>
                        <table align="center" border="0" cellspacing="4" style="width: 1103px;">
                            <tr>
                                <td align="left" colspan="2" nowrap="nowrap">
                                    <asp:RadioButtonList ID="Tipo_lecturas" runat="server" AutoPostBack="True" Font-Names="Arial"
                                        Height="17px" RepeatDirection="Horizontal" Width="151px">
                                        <asp:ListItem Selected="True" Value="Corte">Corte</asp:ListItem>
                                        <asp:ListItem Value="Reposici&#243;n">Reposici&#243;n</asp:ListItem>
                                    </asp:RadioButtonList></td>
                            </tr>
                            <tr>
                                <td align="left" colspan="2" nowrap="nowrap" style="height: 15px;">
                                    <asp:LinkButton ID="clv_Agregar" runat="server">Agregar Clave</asp:LinkButton>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="2" nowrap="nowrap" style="height: 15px; text-align: right">
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;</td>
                            </tr>
                            <tr style="color: #000000; font-family: Times New Roman;">
                                <td align="center" id="panel1" runat="server" colspan="2" style="height: 133px; text-align: center;">
                                   
                                 
                                  <div  ID="id_div_style" runat="server" style="overflow:auto;  width:1060px; height:200px;">
                                    <asp:DataGrid OnPageIndexChanged="GrillaClavesLectura_PageIndexChanged1" ID="GrillaClavesLectura" runat="server" OnDeleteCommand="Siguientes" OnEditCommand="Editar" AutoGenerateColumns="False"
                                        CssClass="GridAlternativeItems" Height="76px" Width="2834px" PageSize="6" AllowSorting="True" BackColor="Black" BorderWidth="0px" CellPadding="1" CellSpacing="1" GridLines="Horizontal" HorizontalAlign="Center">
                                        <HeaderStyle BackColor="CornflowerBlue" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="True" ForeColor="White" HorizontalAlign="Center" Font-Size="13px" />
                                        <Columns>
                                            <asp:EditCommandColumn CancelText="Cancel" EditText="Editar" UpdateText="Update" HeaderText="Modificar">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" ForeColor="#3300CC" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" />
                                            </asp:EditCommandColumn>
                                            <asp:ButtonColumn CommandName="Delete" Text="Eliminar" HeaderText="Eliminar">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" ForeColor="#3300CC" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" />
                                            </asp:ButtonColumn>
                                            <asp:BoundColumn DataField="id_claveefectivo" HeaderText="id_claveefectivo" Visible="False">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="cod_clavecortepda" HeaderText="C&#243;digo Clave Pda">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="cod_clavecortesap" HeaderText="C&#243;digo Clave Dos Pda">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="descripcion" HeaderText="Descripci&#243;n">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="estado" HeaderText="Estado">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                    Font-Strikeout="False" Font-Underline="False" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="True" />
                                            </asp:BoundColumn>
                                            <asp:BoundColumn DataField="atendido" HeaderText="Atendido"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="rut_empresa" HeaderText="Rut Empresa"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="id_tipoorden" HeaderText="Tipo Orden"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="tipo_corte" HeaderText="Tipo Corte"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="foto_fachada" HeaderText="Foto fachada"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="foto_precorte" HeaderText="Foto Precorte"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="foto_medidor" HeaderText="Foto Medidor"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="foto_corte" HeaderText="Foto Corte"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="foto_sello" HeaderText="Foto Sello"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="foto_lectura" HeaderText="Foto Lectura"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="foto_num_casa" HeaderText="Foto N&#250;mero Casa"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="foto_documento" HeaderText="Foto Documento"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="foto_reposicion" HeaderText="Foto Reposici&#243;n"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="foto_filtracion" HeaderText="Foto Filtraci&#243;n"></asp:BoundColumn>
                                        </Columns>
                                        <EditItemStyle Font-Bold="False" />
                                        <PagerStyle NextPageText="Siguientes" PrevPageText="Anteriores" Mode="NumericPages" BackColor="Control" Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                        <AlternatingItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                        <ItemStyle BackColor="White" />
                                         </asp:DataGrid>
                                         </div>
                                    
                          
                          
                                 
                                    </td>
                            </tr>
                            <tr style="color: #000000; font-family: Times New Roman">
                                <td runat="server" align="center" colspan="2" style="text-align: right"><asp:Button ID="lk_CerrarLote" runat="server" CssClass="botonnew" Text="<< Volver" ValidationGroup="cancelar" />
                                    </td>
                            </tr>
                            <tr style="font-family: Times New Roman">
                                <td align="center" colspan="2" style="text-align: center">
                                    <strong><table id="tbl_NuevaClave" runat="server" style="width: 1061px">
                                        <tr>
                                            <td style="width: 12%; height: 4px; text-align: right;">
                                                Tipo orden:</td>
                                            <td align="left" style="width: 35%; height: 4px; text-align: center">
                                            <asp:DropDownList ID="cbo_id_tipoorden" runat="server" CssClass="ComboBox" Width="205px" BackColor="LightGoldenrodYellow" Enabled="False">
                                                <asp:ListItem>CORTE</asp:ListItem>
                                                <asp:ListItem>REPOSICION</asp:ListItem>
                                            </asp:DropDownList></td>
                                            <td style="width: 3%; height: 4px">
                                            </td>
                                            <td style="width: 15%; height: 4px">
                                            </td>
                                            <td align="left" style="width: 35%; height: 4px; text-align: center">
                                            </td>
                                        </tr>
                                            <tr>
                                                <td style="width: 12%; height: 4px">
                                                    </td>
                                                <td align="left" style="width: 35%; height: 4px; text-align: center;">
                                                    &nbsp;
                                                </td>
                                                <td style="width: 3%; height: 4px">
                                                    &nbsp;</td>
                                                <td style="width: 15%; height: 4px">
                                                    </td>
                                                <td align="left" style="width: 35%; height: 4px; text-align: center;">
                                                </td>
                                            </tr>
                                        <tr>
                                            <td style="width: 214px; text-align: right;">
                                                Cod clavecortepda:</td>
                                            <td align="left" style="text-align: center">
                                                    <asp:TextBox ID="txt_cod_clavecortepda" runat="server" CssClass="TextBox" ForeColor="ControlText"
                                                        Width="199px" MaxLength="3"></asp:TextBox><asp:RequiredFieldValidator
                                                            ID="rq_claverq" runat="server" ControlToValidate="txt_cod_clavecortepda" Display="Dynamic"
                                                            ErrorMessage="*"></asp:RequiredFieldValidator></td>
                                            <td style="width: 130px">
                                            </td>
                                            <td style="width: 247px; text-align: right;">
                                                Cod clavecortesap:</td>
                                            <td align="left" style="text-align: center">
                                                    <asp:TextBox ID="txt_cod_clavecortesap" runat="server" CssClass="TextBox" Width="199px" MaxLength="6" TabIndex="1"></asp:TextBox><asp:RequiredFieldValidator
                                                        ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_cod_clavecortesap"
                                                        Display="Dynamic" ErrorMessage="*"></asp:RequiredFieldValidator></td>
                                        </tr>
                                            <tr>                                           
                                                <td style="width: 214px; text-align: right;">
                                                    Descripcion:</td>
                                                <td  align="left" style="text-align: center" >
                                                    <asp:TextBox ID="txt_descripcion" runat="server" CssClass="TextBox" Width="199px" MaxLength="50" TabIndex="2"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txt_descripcion"
                                                        Display="Dynamic" ErrorMessage="*" Height="1px" Width="1px"></asp:RequiredFieldValidator></td>
                                                <td style="width: 130px">
                                                </td>
                                                <td style="width: 247px; text-align: right;">
                                                    Tipo corte (instancia)</td>
                                                <td align="left" style="text-align: center">
                                                <asp:TextBox ID="txt_tipo_corte" runat="server" CssClass="TextBox" Width="199px" MaxLength="2" TabIndex="3" ToolTip="Tipo de Instancia 1,2,3,4"></asp:TextBox><asp:RequiredFieldValidator
                                                        ID="RequiredFieldValidator2" runat="server" ControlToValidate="txt_tipo_corte"
                                                        Display="Dynamic" ErrorMessage="*" Width="1px"></asp:RequiredFieldValidator><br />
                                                    <asp:RegularExpressionValidator ID="rqexp_LECTURA" runat="server" ControlToValidate="txt_tipo_corte"
                                                        Display="Dynamic" ErrorMessage="Sólo números" Font-Size="XX-Small" ValidationExpression="^([0-9]{1,12})$"></asp:RegularExpressionValidator></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 214px; height: 12px; text-align: right;">
                                                    Foto Fachada:</td>
                                                <td style="width: 926px; height: 12px">
                                                    &nbsp;<asp:DropDownList ID="cbo_foto_fachada" runat="server" CssClass="ComboBox" Width="199px" TabIndex="4">
                                                <asp:ListItem>DESHABILITADO</asp:ListItem>
                                                <asp:ListItem>HABILITADO</asp:ListItem>
                                            </asp:DropDownList></td>
                                                <td style="width: 130px; height: 12px">
                                                </td>
                                                <td style="width: 247px; height: 12px; text-align: right;">
                                                    Foto Precorte:</td>
                                                <td style="width: 670px; height: 12px; text-align: center;">
                                                <asp:DropDownList ID="cbo_foto_precorte" runat="server" CssClass="ComboBox" Width="199px" TabIndex="5">
                                                    <asp:ListItem>DESHABILITADO</asp:ListItem>
                                                    <asp:ListItem>HABILITADO</asp:ListItem>
                                                </asp:DropDownList></td>
                                            </tr>
                                        <tr>
                                            <td style="width: 214px; height: 12px; text-align: right;">
                                                Foto Medidor:</td>
                                            <td style="width: 926px; height: 12px"><asp:DropDownList ID="cbo_foto_medidor" runat="server" CssClass="ComboBox" Width="199px" TabIndex="6">
                                                <asp:ListItem>DESHABILITADO</asp:ListItem>
                                                <asp:ListItem>HABILITADO</asp:ListItem>
                                            </asp:DropDownList></td>
                                            <td style="width: 130px; height: 12px">
                                            </td>
                                            <td style="width: 247px; height: 12px; text-align: right;">
                                                Foto Corte:</td>
                                            <td style="width: 670px; height: 12px">
                                                <asp:DropDownList ID="cbo_foto_corte" runat="server" CssClass="ComboBox" Width="199px" TabIndex="7">
                                                <asp:ListItem>DESHABILITADO</asp:ListItem>
                                                <asp:ListItem>HABILITADO</asp:ListItem>
                                            </asp:DropDownList></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 214px; height: 12px; text-align: right;">
                                                Foto Sello:</td>
                                            <td style="width: 926px; height: 12px"><asp:DropDownList ID="cbo_foto_sello" runat="server" CssClass="ComboBox" Width="199px" TabIndex="8">
                                                <asp:ListItem>DESHABILITADO</asp:ListItem>
                                                <asp:ListItem>HABILITADO</asp:ListItem>
                                            </asp:DropDownList></td>
                                            <td style="width: 130px; height: 12px">
                                            </td>
                                            <td style="width: 247px; height: 12px; text-align: right;">
                                                Foto Lectura:</td>
                                            <td style="width: 670px; height: 12px">
                                                <asp:DropDownList ID="cbo_foto_lectura" runat="server" CssClass="ComboBox" Width="199px" TabIndex="9">
                                                <asp:ListItem>DESHABILITADO</asp:ListItem>
                                                <asp:ListItem>HABILITADO</asp:ListItem>
                                            </asp:DropDownList></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 214px; height: 12px; text-align: right;">
                                                Foto Num Casa:</td>
                                            <td style="width: 926px; height: 12px"><asp:DropDownList ID="cbo_foto_num_casa" runat="server" CssClass="ComboBox" Width="199px" TabIndex="10">
                                                <asp:ListItem>DESHABILITADO</asp:ListItem>
                                                <asp:ListItem>HABILITADO</asp:ListItem>
                                            </asp:DropDownList></td>
                                            <td style="width: 130px; height: 12px">
                                            </td>
                                            <td style="width: 247px; height: 12px; text-align: right;">
                                                Foto Documento:</td>
                                            <td style="width: 670px; height: 12px"><asp:DropDownList ID="cbo_foto_documento" runat="server" CssClass="ComboBox" Width="199px" TabIndex="11">
                                                <asp:ListItem>DESHABILITADO</asp:ListItem>
                                                <asp:ListItem>HABILITADO</asp:ListItem>
                                            </asp:DropDownList></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 214px; height: 12px; text-align: right;">
                                                Foto Reposicion:</td>
                                            <td style="width: 926px; height: 12px"><asp:DropDownList ID="cbo_foto_reposicion" runat="server" CssClass="ComboBox" Width="199px" TabIndex="16">
                                                <asp:ListItem>DESHABILITADO</asp:ListItem>
                                                <asp:ListItem>HABILITADO</asp:ListItem>
                                            </asp:DropDownList></td>
                                            <td style="width: 130px; height: 12px">
                                            </td>
                                            <td style="width: 247px; height: 12px; text-align: right;">
                                                Foto Filtracion:</td>
                                            <td style="width: 670px; height: 12px"><asp:DropDownList ID="cbo_foto_filtracion" runat="server" CssClass="ComboBox" Width="199px" TabIndex="13">
                                                <asp:ListItem>DESHABILITADO</asp:ListItem>
                                                <asp:ListItem>HABILITADO</asp:ListItem>
                                            </asp:DropDownList></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 214px; height: 12px; text-align: right;">
                                                    Estado:</td>
                                            <td style="width: 926px; height: 12px"><asp:DropDownList ID="cbo_estado" runat="server" CssClass="ComboBox" Width="199px" TabIndex="12">
                                                    <asp:ListItem>DESHABILITADO</asp:ListItem>
                                                    <asp:ListItem>HABILITADO</asp:ListItem>
                                                </asp:DropDownList></td>
                                            <td style="width: 130px; height: 12px">
                                            </td>
                                            <td style="width: 247px; height: 12px; text-align: right;">
                                                </td>
                                            <td style="width: 670px; height: 12px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 214px; height: 12px; text-align: right;">
                                                </td>
                                            <td style="width: 926px; height: 12px"></td>
                                            <td style="width: 130px; height: 12px">
                                            </td>
                                            <td style="width: 247px; height: 12px; text-align: right;">
                                                </td>
                                            <td style="width: 670px; height: 12px"></td>
                                        </tr>
                                            <tr>
                                                <td style="width: 214px; height: 17px">
                                                </td>
                                                <td style="width: 926px; height: 17px">
                                                </td>
                                                <td style="width: 130px; height: 17px">
                                                </td>
                                                <td style="width: 247px; height: 17px">
                                                </td>
                                                <td style="width: 670px; height: 17px" align="right">
                                                    <asp:Button ID="btn_actualizar" runat="server" CssClass="botonnew" Text="Actualizar" />
                                                    <asp:Button ID="btn_agregaCLV" runat="server" CssClass="botonnew" Text="Ingresar" />
                                                    <asp:Button ID="Btn_Cancelar" runat="server" CssClass="botonnew" Text="<< Volver" ValidationGroup="cancelar" /></td>
                                            </tr>
                                        <tr>
                                            <td align="right" colspan="5" style="height: 17px; text-align: center">
                                                <img id="img_ok" runat="server" src="fotos/ok.bmp" /><asp:Label ID="lb_mensaje" runat="server"
                                                    Font-Bold="True" Font-Names="Arial" ForeColor="Navy" Width="433px"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 214px; height: 17px">
                                                    <asp:Label ID="Label2" runat="server" Text="Rut Empresa:" Visible="False" Width="89px"></asp:Label></td>
                                            <td style="width: 926px; height: 17px; text-align: left">
                                                <asp:TextBox ID="txt_rut_empresa" runat="server" CssClass="TextBox" Width="200px" Visible="False"></asp:TextBox></td>
                                            <td style="width: 130px; height: 17px">
                                            </td>
                                            <td style="width: 247px; height: 17px">
                                                    <asp:Label ID="Label1" runat="server" Text="txt_id_claveefectivo" Visible="False"></asp:Label></td>
                                            <td align="right" style="width: 670px; height: 17px; text-align: left">
                                                <asp:TextBox ID="txt_id_claveefectivo" runat="server" CssClass="TextBox" Width="200px" Visible="False"></asp:TextBox></td>
                                        </tr>
                                        </table>
                                    </strong>
                                    <asp:Label ID="lb_rut_empresa" runat="server" Visible="False"></asp:Label>
                                    <asp:Label ID="lb_id_usuario" runat="server" Visible="False"></asp:Label></td>
                            </tr>
                            <tr style="font-family: Times New Roman">
                                <td align="right" colspan="2">
                                    &nbsp;&nbsp;</td>
                            </tr>
                        </table>
                    </div>
                    </td>
            </tr>
        </table>
    
    </div>
                                        &nbsp;&nbsp;
    </form>
</body>
</html>
