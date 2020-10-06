﻿<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="MantencionUsuarios.aspx.cs" Inherits="MantencionUsuarios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

     <style type="text/css">  
         body {  
             font-family: Arial;  
             font-size: 10pt;  
         }  
      
         td {  
             cursor: pointer;  
         }  
      
         .hover_row {  
             background-color: #A1DCF2;  
         }  
     </style>  
    
    <style type="text/css">
        .auto-style5 {
            height: 2px;
        }

        .auto-style6 {
            width: 105px;
        }

        .auto-style7 {
            height: 21px;
            width: 105px;
        }

        .auto-style8 {
            height: 12px;
            width: 105px;
        }

        .auto-style10 {
            height: 17px;
            width: 105px;
        }

        .auto-style11 {
            width: 60px;
        }

        .auto-style12 {
            height: 21px;
            width: 60px;
        }

        .auto-style13 {
            height: 12px;
            width: 60px;
        }

        .auto-style14 {
            height: 2px;
            width: 60px;
        }
        .auto-style15
        {
            height: 17px;
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
                     Mantenedor de Usuarios<br />
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
                                 <asp:LinkButton ID="lkb_Agregar" runat="server" OnClick="lkb_Agregar_Click">Agregar Usuario</asp:LinkButton>
                             </td>
                         </tr>
                         <tr>
                             <td align="left" colspan="2" class="auto-style15">
                                 <asp:Label ID="lb_cantidad_registros" runat="server" Text="coincidencia(s) encontrada(s)" Width="153px"></asp:Label>
                             </td>
                         </tr>
                         <tr>
                             <td align="center" colspan="2">&nbsp;
                                 <asp:DataGrid ID="GrillaUsuarios" runat="server" AutoGenerateColumns="False" BorderWidth="1px" CellPadding="1" CellSpacing="1" CssClass="GridActiveItem" Height="1px" OnEditCommand="MyDataGrid_Edit" Width="699px" BorderStyle="Ridge" Font-Bold="True" AllowPaging="True" OnPageIndexChanged="GrillaUsuarios_PageIndexChanged">
                                     <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                 <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="White" HorizontalAlign="Center" />
                                 <Columns>
                                     <asp:BoundColumn DataField="id_usuario" HeaderText="CODIGO">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                     </asp:BoundColumn>
                                     <asp:BoundColumn DataField="usuario" HeaderText="NOMBRE USUARIO">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                     </asp:BoundColumn>
                                     <asp:BoundColumn DataField="nombre" HeaderText="NOMBRE">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                     </asp:BoundColumn>
                                     <asp:BoundColumn DataField="rut_empresa" HeaderText="ID Empresa" Visible="False">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                     </asp:BoundColumn>
                                     <asp:BoundColumn DataField="empresa" HeaderText="EMPRESA">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                     </asp:BoundColumn>
                                     <asp:BoundColumn DataField="id_perfil" HeaderText="ID Perfil" Visible="False">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                     </asp:BoundColumn>
                                     <asp:BoundColumn DataField="perfil" HeaderText="TIPO DE USUARIO">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                     </asp:BoundColumn>
                                     <asp:BoundColumn DataField="estado" HeaderText="ESTADO">
                                                                         <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />


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






                                        <table id="tbl_NuevoUser" style="width: 100%; table-layout: auto; border-collapse: collapse; empty-cells: hide; caption-side: top;"  runat="server">
                                            <tr>
                                                <td align="left" colspan="2" style="width: 12%; height: 4px">
                                                    <h3>(*) Campos Obligatorios</h3>
                                                </td>                                             
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 130px;" colSpan="1">      
                                                                                                  
                                                    <h4>&nbsp;Nombre</h4></td>

                                                <td style="width: 150px;" colSpan="1" align="left">

                                                    <br /><input id="txt_nombre" type="text" class="TextBox" runat="server"/>

                                                    <asp:RequiredFieldValidator ID="rq_nombre" runat="server" ErrorMessage="*" ControlToValidate="txt_nombre"></asp:RequiredFieldValidator>

                                                </td>
                                                <td colSpan="1" class="auto-style11">
                                                    &nbsp;</td>
                                                <td align="right" colSpan="1" class="auto-style6">
                                                    <h4>
                                                     <strong>RUT:</strong>&nbsp;
                                                    </h4></td>
                                                <td style="width: 35%;" align="left">
                                                    &nbsp;
                                                    <br /><asp:TextBox ID="txt_rut" runat="server" CssClass="TextBox"
                                                        Width="84px" ForeColor="ControlText" MaxLength="8"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txt_rut"
                                                        ErrorMessage=" *"></asp:RequiredFieldValidator>&nbsp;&nbsp; -
                                                    <asp:TextBox ID="txt_dv" runat="server" CssClass="TextBox" MaxLength="1" Width="17px"></asp:TextBox><asp:RequiredFieldValidator
                                                        ID="RequiredFieldValidator4" runat="server" ControlToValidate="txt_dv" ErrorMessage=" *"></asp:RequiredFieldValidator></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 130px">
                                                    <h4>
                                                        &nbsp;<strong>Apellido:</strong>
                                                    </h4>
                                                    </td>
                                                <td style="width: 253px;" colspan="1" align="left">
                                                    <br /><asp:TextBox ID="txt_apellido" runat="server" CssClass="TextBox" Width="120px"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txt_apellido"
                                                        ErrorMessage="*"></asp:RequiredFieldValidator>&nbsp;

                                                   </td>
                                                <td class="auto-style11">
                                                    </td>
                                                <td align="right" class="auto-style6">
                                                    <h4>
                                                        &nbsp;<strong>Usuario:</strong>
                                                    </h4>

                                                    </td>
                                                <td align="left" style="font-weight: bold">
                                                     <br /><asp:TextBox ID="txt_login" runat="server" CssClass="TextBox" Width="92px"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_login"
                                                        ErrorMessage="*"></asp:RequiredFieldValidator>&nbsp;
                                                    </td>
                                            </tr>
                                            <tr style="font-weight: bold">
                                                <td align="right" style="width: 130px; height: 21px">
                                                     <h4>
                                                        &nbsp;<strong>Password:</strong>&nbsp;
                                                    </h4>
                                                </td>
                                                <td align="left" colspan="1" style="font-weight: bold; width: 253px; height: 21px">
                                                    &nbsp;&nbsp;
                                                    <br /><asp:TextBox ID="txt_pass" runat="server" CssClass="TextBox" Width="142px"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txt_pass"
                                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                                    </td>
                                                <td style="font-weight: bold; " class="auto-style12">

                                                </td>
                                                <td align="right" style="font-weight: bold; " class="auto-style7">
                                                    <h4>
                                                        <strong>Dias Vencimiento</strong>:</h4>
                                                </td>
                                                <td align="left" style="font-weight: bold; height: 21px">
                                                    &nbsp;
                                                    <br /><asp:TextBox ID="txtDias" runat="server" CssClass="TextBox" Width="100px"></asp:TextBox>
                                                    </td>

                                            </tr>
                                            <tr style="font-weight: bold">
                                                <td align="right" style="width: 130px; height: 12px">
                                                    <h4>
                                                        <strong>Correo:</strong></h4>
                                                    </td>
                                                     
                                                <td style="width: 253px; height: 12px;" align="left">
                                                    <br /><asp:TextBox ID="txtCorreo" runat="server" CssClass="TextBox" Width="200px"></asp:TextBox>

                                                    </td>
                                                <td class="auto-style13">
                                                </td>
                                                <td align="right" class="auto-style8">
                                                     <h4>
                                                        &nbsp;<strong>Empresa:</strong>&nbsp;
                                                    </h4></td>
                                                <td style="width: 670px; height: 12px;" align="left">
                                                    <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:DropDownList ID="combo_empresas" runat="server" CssClass="ComboBox" OnSelectedIndexChanged="combo_empresas_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 130px; height: 2px">
                                                    <h4>
                                                        <strong>Tipo Usuario:</strong>&nbsp;
                                                    </h4></td>
                                                <td align="left" style="width: 253px; height: 2px">
                                                    &nbsp;
                                                    <br />
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <asp:DropDownList ID="combo_perfiles" runat="server" CssClass="ComboBox" Width="200px">
                                                    </asp:DropDownList></td>
                                                    
                                                <td class="auto-style14">
                                                </td>
                                                <td align="right" style="width: 130px; height: 2px"">
                                                    <h4>
                                                    &nbsp;<strong>Multiempresa:</strong>&nbsp;
                                                    </h4>
                                                </td>
                                                <td align="left" style="width: 670px; height: 2px">
                                                    <br />
                                                    <asp:RadioButtonList ID="rd_multiempresa" runat="server" Font-Bold="False" Font-Names="Arial"
                                                        Font-Size="X-Small" Height="1px" RepeatDirection="Horizontal" Width="181px" style="margin-left: 40px">
                                                        <asp:ListItem Value="2" Selected="True">SI</asp:ListItem>
                                                        <asp:ListItem Value="1">NO</asp:ListItem>
                                                    </asp:RadioButtonList></td>
                                                
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="5" class="auto-style5">
                                                    <asp:Label ID="VALIDACION_RUT_USUARIO" runat="server" Font-Bold="False" Font-Names="Arial"
                                                        ForeColor="Red"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" style="height: 17px" align="left">
                                                    <table id="TABLE1" border="0" cellpadding="0" cellspacing="0" style="width: 310px">
                                                        <tr>
                                                            <td style="width: 310px">
                                                                <asp:RegularExpressionValidator ID="ER_nom" runat="server" ControlToValidate="txt_nombre"
                                                                    Display="Dynamic" ErrorMessage="Error Nombre Usuario: Se aceptan sólo letras!"
                                                                    ValidationExpression="[a-zA-Z]{3,50}([\s]{0,1}[a-zA-Z]{0,50})([\s]{0,1}[a-zA-Z]{0,50})([\s]{0,1}[a-zA-Z]{0,50})([\s]{0,1}[a-zA-Z]{0,50})" Font-Bold="False"></asp:RegularExpressionValidator></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 310px">
                                                                <asp:RegularExpressionValidator ID="ER_RUT" runat="server" ControlToValidate="txt_rut"
                                                                    Display="Dynamic" ErrorMessage="Error RUT Usuario: Formato incorrecto!"
                                                                    ValidationExpression="[0-9]{7,8}" Font-Bold="False"></asp:RegularExpressionValidator></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 310px">
                                                                <asp:RegularExpressionValidator ID="ER_RUT_DV" runat="server" ControlToValidate="txt_dv"
                                                                    Display="Dynamic" ErrorMessage="Error RUT(Dígito Verificador): Sólo números o letra k!"
                                                                    ValidationExpression="[0-9kK]{1}" Font-Bold="False"></asp:RegularExpressionValidator></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 310px; height: 15px;">
                                                                <asp:RegularExpressionValidator ID="ER_login" runat="server" ControlToValidate="txt_login"
                                                                    Display="Dynamic" ErrorMessage="Error Login: se aceptan sólo alfanuméricos!"
                                                                    ValidationExpression="^([0-9a-zA-Z]{1,50})$" Font-Bold="False"></asp:RegularExpressionValidator></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 310px">
                                                                <asp:RegularExpressionValidator ID="ER_pass" runat="server" ControlToValidate="txt_pass"
                                                                    Display="Dynamic" ErrorMessage="Error Clave Acceso: se aceptan sólo alfanuméricos!"
                                                                    ValidationExpression="^([0-9a-zA-Z]{1,50})$" Font-Bold="False"></asp:RegularExpressionValidator></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:310px; height:15px">
                                                                <asp:RegularExpressionValidator ID="ER_CORREO" runat="server" ControlToValidate="txtCorreo" Display="Dynamic" ErrorMessage="Error correo: debe utilizar un formato válido."
                                                                    ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" Font-Bold="false" ></asp:RegularExpressionValidator>

                                                            </td>
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
                                                    <asp:Button ID="btn_agregaUser" runat="server" CssClass="botonnew" Text="Agregar Usuario" Width="120px" OnClick="btn_agregaUser_Click"/>
                                                    <asp:Button ID="Btn_Cancelar" runat="server" CssClass="botonnew" Text="Cancelar" Width="120px" CausesValidation="False" OnClick="Btn_Cancelar_Click" />
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

