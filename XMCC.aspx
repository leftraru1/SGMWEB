<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="XMCC.aspx.cs" Inherits="MantencionCausaCambio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style5
        {
            width: 130px;
            height: 49px;
        }
        .auto-style6
        {
            width: 150px;
            height: 26px;
        }
        .auto-style8
        {
            width: 35%;
            height: 49px;
        }
        .auto-style9
        {
            width: 12%;
            height: 25px;
        }
        .auto-style10
        {
            height: 48px;
        }
        .auto-style11
        {
            width: 35%;
            height: 26px;
        }
        .auto-style12
        {
            height: 26px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div aria-expanded="undefined" aria-multiline="False" aria-orientation="horizontal">
 <script type="text/javascript">
     $(function () {
         $("[id*=GrillaUsuarios] td").hover(function () {
             $("td", $(this).closest("tr")).addClass("hover_row");
         }, function () {
             $("td", $(this).closest("tr")).removeClass("hover_row");
         });
     });
     </script>  


   <table style="WIDTH: 758px; HEIGHT: 152px" cellSpacing="0" cellPadding="0" width="758"
				align="center" border="0">
       <tr>
             <td style="width: 732px">
                 <br />
                 <%--<asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">
                     Sesión</asp:Label>--%>
                 <asp:Label ID="lb_session_user" runat="server" Font-Names="Arial" Font-Size="X-Small">
                 </asp:Label>
                 <%--<asp:Label ID="lb_empresa" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">
                     Empresa</asp:Label>--%>
                 <asp:Label ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small">
                 </asp:Label>
                 <br />
                 <div id="titulo_mod" runat="server" class="WebPartTitle">
                     Mantenedor de Causa Cambio<br />
                     <table align="center" border="0" cellspacing="0" style="WIDTH: 747px; HEIGHT: 1px">
                         <tr>
                             <td align="left" colspan="2" nowrap>
                                 <h2>
                                     <asp:Label ID="lb_minihead" runat="server" Text="Por favor, seleccione la acción a realizar:"></asp:Label>
                                 </h2>
                             </td>
                         </tr>
                         <tr>
                             <td align="right" colspan="2" nowrap="nowrap" class="auto-style15">
                                 <asp:LinkButton ID="lkb_Agregar" runat="server" OnClick="lkb_Agregar_Click" >Agregar Causa</asp:LinkButton>
                             </td>
                         </tr>
                         <tr>
                             <td align="left" colspan="2">
                                 <asp:Label ID="lb_cantidad_registros" runat="server" Text="coincidencia(s) encontrada(s)" Width="153px"></asp:Label>
                             </td>
                         </tr>
                         <tr>
                             <td align="center" colspan="2">&nbsp;
                                 <asp:DataGrid ID="GrillaCausaCambio" runat="server" AutoGenerateColumns="False" BorderWidth="1px" CellPadding="1" CellSpacing="1" CssClass="GridActiveItem" Height="1px" Width="699px" BorderStyle="Ridge" Font-Bold="True" AllowPaging="True">
                                     <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                 <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="White" HorizontalAlign="Center" />
                                 <Columns>
                                     <asp:BoundColumn DataField="ID_CAUSACMABIO" HeaderText="CODIGO">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                     </asp:BoundColumn>
                                     <asp:BoundColumn DataField="usuario" HeaderText="DESCRIPCION">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                     </asp:BoundColumn>
                                     <asp:BoundColumn DataField="nombre" HeaderText="EMPRESA">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                     </asp:BoundColumn>
                                     <asp:BoundColumn DataField="empresa" HeaderText="ESTADO">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                     </asp:BoundColumn>
                                     <asp:EditCommandColumn CancelText="Cancel" EditText="Editar" HeaderText="MODIFICAR" UpdateText="Update">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="#3300CC" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                     </asp:EditCommandColumn>
                                     <asp:ButtonColumn CommandName="Delete" HeaderText="Habilitar/Deshabilitar" Text="Habilitar/Deshabilitar" Visible="False">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="#3300CC" HorizontalAlign="Center" />
                                         <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" />
                                     </asp:ButtonColumn>
                                 </Columns>
                                <PagerStyle BackColor="CornflowerBlue" ForeColor="White" HorizontalAlign="Center" Mode="NumericPages" PageButtonCount="5" />
                        <ItemStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
                        <AlternatingItemStyle BackColor="White" />
                        <SelectedItemStyle BackColor="#66FF99" Font-Bold="True" ForeColor="#333333" BorderStyle="Ridge" BorderColor="#66FF33" />
                                 </asp:DataGrid>
                                 &nbsp;</td>
                         </tr>
                                 <tr>
                                    <td align="center" colspan="2" class="auto-style5">
                                        </td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="2">
                                    </td>                                        
                                </tr>
								<TR>
									<TD colSpan="2" align="center"><STRONG>
                                        </div>
                                        <div id="titulo_tabla">






                                        <table id="tbl_NuevaCausa" style="width: 100%; table-layout: auto; border-collapse: collapse; empty-cells: hide; caption-side: top; background-color: #C0C0C0;"  runat="server">
                                            <tr>
                                                <td align="left" colspan="2" class="auto-style9">
                                                    <h3>(*) Campos Obligatorios</h3>
                                                </td>                                             
                                            </tr>
                                            <tr>
                                                <td align="center" colSpan="1"  >Descripción:</td>

                                                <td colspan="1">

                                                    <strong>
                                                        <input id="txtDescripcionCausa" type="text" class="TextBox" runat="server" /></strong><br />
                                                    &nbsp;</td>
                                                <td colSpan="1" >
                                                    </td>
                                                <td colSpan="1" align="center" >
                                                    Código Causa:</td>
                                                <td align="center" >
                                                    
                                                    <asp:TextBox ID="txtCodigoCausa" runat="server" CssClass="TextBox"
                                                        Width="90%" ForeColor="ControlText" MaxLength="8"></asp:TextBox> </td>
                                            </tr>
                                            
                                            <tr style="font-weight: bold">
                                                <td align="right" style="width: 130px; height: 12px">
                                                    <h4>
                                                        <strong>Estado:</strong></h4>
                                                    </td>
                                                     
                                                <td style="width: 253px; height: 12px;" align="left">
                                                    <asp:CheckBox ID="CheckEstado" runat="server" BorderStyle="None" Checked="True" />
                                                    <br />

                                                    </td>
                                                <td >
                                                </td>
                                                <td align="right" >
                                                     
                                                        <strong>Empresa:</strong>&nbsp;
                                                   </td>
                                                <td  align="left">
                                                    <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:DropDownList ID="combo_empresas" runat="server" CssClass="ComboBox" Height="16px">
                                                    </asp:DropDownList>
                                            </tr>
                                            
                                            <tr>
                                                <td align="left" colspan="5" style="height: 2px">
                                                    <asp:Label ID="VALIDACION_RUT_USUARIO" runat="server" Font-Bold="False" Font-Names="Arial"
                                                        ForeColor="Red"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" style="height: 17px" align="left">
                                                    <table id="TABLE1" border="0" cellpadding="0" cellspacing="0" style="width: 310px">
                                                        <tr>
                                                            <td style="width: 310px">
                                                                <asp:RegularExpressionValidator ID="ER_nom" runat="server" ControlToValidate="txtDescripcionCausa"
                                                                    Display="Dynamic" ErrorMessage="Error Nombre Usuario: Se aceptan sólo letras!"
                                                                    ValidationExpression="[a-zA-Z]{3,50}([\s]{0,1}[a-zA-Z]{0,50})([\s]{0,1}[a-zA-Z]{0,50})([\s]{0,1}[a-zA-Z]{0,50})([\s]{0,1}[a-zA-Z]{0,50})" Font-Bold="False"></asp:RegularExpressionValidator></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 310px">
                                                                </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 310px; height: 15px;">
                                                                &nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 310px">
                                                                &nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:310px; height:15px">
                                                                &nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 310px">
                                                                </td>
                                                        </tr>
                                                    </table>
                                                </td>                                        
                                                <td class="auto-style10">
                                                </td>
                                                <td style="width: 670px; height: 17px">
                                                    <asp:Label ID="lb_id_usuario" runat="server"></asp:Label>
                                                    <asp:Label ID="LOG_ID_USUARIO" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>                                            
                                                <td align="right" colspan="5" style="height: 17px">
                                                    <asp:Label ID="lb_perfil_usuario" runat="server"></asp:Label>
                                                    <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label>
                                                    <asp:Button ID="btoAgregaCausaC" runat="server" CssClass="botonnew" Text="Agregar Causa" Width="120px"  />
                                                    <asp:Button ID="btoVolver" runat="server" CssClass="botonnew" Text="Volver" Width="120px" CausesValidation="False" OnClick="Btn_Cancelar_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                            <table>
                                                <tr>
                                                    <td style="display:inline-block; text-align:center">

                                                        </STRONG>&nbsp;&nbsp;<img src="FOTOS/ok.bmp" runat="server" id="img_ok"/>
                                                        <asp:Label ID="lb_mensaje_ingreso" runat="server" Width="175px" Font-Names="Arial" CssClass="Label" ForeColor="#0000C0"></asp:Label></td>
                                                    </td>

                                                </tr>
                                    
                                           
                                    </table>
								</TR>
                                <tr id="row_aceptar_ok" runat="server">
                                    <td align="center" colspan="2" style="height: 22px">
                                        <asp:Button ID="btnok_agregar" runat="server" CssClass="botonnew" Text="Aceptar" Width="120px" CausesValidation="False" OnClick="btnok_agregar_Click" />
                                        </td>
                                </tr>

							</table>
        </div>
</asp:Content>

