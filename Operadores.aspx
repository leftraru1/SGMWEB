<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="Operadores.aspx.cs" Inherits="Operadores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .GridAlternativeItems
        {}
        .auto-style9
        {
            height: auto;
            width: 1000px;
        }
        .auto-style1
        {
            height: 20px;
            text-align:right;
        }
        .auto-style2
        {
            height: 20px;
            text-align:left;
        }
        .auto-style18
        {
            FONT-WEIGHT: bold;
            FONT-SIZE: 15px;
            MARGIN-BOTTOM: 6px;
            COLOR: #003366;
            BORDER-BOTTOM: #999 1px dotted;
            FONT-FAMILY: "trebuchet ms", trebuchet, arial, sans-serif;
            background-position: left;
            height: 30px;
        }
        #IMG6
    {
        margin-left: 0px;
    }
        .auto-style19
        {
            height: 20px;
            text-align: right;
            width: 200px;
        }
         .auto-styl20
        {
            height: 20px;
            text-align: center;
            width: 200px;
        }
        .auto-style20
        {
            width: 400px;
        }
        .auto-style21
        {
            height: 20px;
            text-align: right;
            width: 120px;
        }
        .auto-style22
        {
            width: 120px;
        }
        .auto-style23
        {
            height: 20px;
            text-align: left;
            width: 70px;
        }
        .auto-style24
        {
            height: 501px;
            text-align: center;
        }
        .auto-style25
        {
            height: 19px;
            text-align: right;
            width: 200px;
        }
        .auto-style26
        {
            width: 400px;
            height: 19px;
        }
        .auto-style27
        {
            height: 19px;
            text-align: right;
            width: 120px;
        }
        .auto-style28
        {
            height: 19px;
            text-align: left;
            width: 70px;
        }
        .auto-style29
        {
            height: 19px;
            text-align: right;
        }
        .auto-style30
        {
            height: 19px;
            text-align: left;
        }
         .auto-style31
        {
            width: 170px;
            height: 30px;
        }
        .auto-style32
        {
            width: 260px;
            height: 30px;
        }
        .auto-style33
        {
            font-family: "trebuchet ms", verdana, tahoma, arial;
            font-size: 11px;
            color: #333333;
            margin-top: 0px;
            background-color: #000000;
        }
        .auto-style40
        {
            height: 20px;
            text-align: right;
            }
        .auto-style42
        {
            height: 20px;
            text-align: left;
            width: 85px;
        }
        .auto-style43
        {
            width: 100px;
        }
        .auto-style45
        {
            width: 100px;
            height: 30px;
        }
        .auto-style46
        {
            height: 20px;
        }
        .auto-style47
        {
            height: 30px;
        }
        .auto-style49
        {
            width: 100px;
            height: 10px;
        }
        .auto-style50
        {
            width: 260px;
            height: 10px;
        }
        .auto-style51
        {
            height: 10px;
            text-align: left;
        }
        </style>
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <div id="main" runat="server">
        <table class="auto-style9">
        <tr>
            <td  colspan=6 class="auto-style18">MANTENEDOR DE OPERADORES<asp:Label ID="lb_id_usuario" runat="server" Visible="False"></asp:Label>
                <asp:Label ID="lb_id_perfil" runat="server" Visible="False"></asp:Label>
                <asp:Label ID="lb_id_contratista" runat="server" Visible="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style19"></td>
            <td class="auto-style20"></td>
            <td class="auto-style21"></td>
            <td class="auto-style23"></td>
            <td class="auto-style1"></td>
            <td class="auto-style2"></td>
        </tr>
        <tr>
            <td class="auto-style19">
                <asp:DropDownList ID="cb_filtro_busqueda" runat="server" Width="200px" OnSelectedIndexChanged="cb_filtro_busqueda_SelectedIndexChanged">
                    <asp:ListItem Value="1">NOMBRE DE OPERADOR</asp:ListItem>
                    <asp:ListItem Value="2">CODIGO OPERADOR</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td style="text-align: center" class="auto-style20">
                <asp:TextBox ID="tb_busqueda" runat="server" Width="300px" OnTextChanged="tb_busqueda_TextChanged"></asp:TextBox>
            </td>
            <td class="auto-style22" style="text-align: left">
                <asp:Button ID="btn_buscar" runat="server" BackColor="#336699" Font-Bold="True" Font-Names="Calibri" ForeColor="White" Text="BUSCAR" style="height: 25px" OnClick="btn_buscar_Click" />
            </td>
            <td class="auto-style23">&nbsp;</td>
            <td class="auto-style1" colspan="2" style="text-align: center">
                <asp:Button ID="btn_nuevo" runat="server" BackColor="#336699" Font-Bold="True" Font-Names="Calibri" ForeColor="White" Text="NUEVO OPERADOR" OnClick="btn_nuevo_Click" />
            </td>
        </tr>
        <tr>
            <td class="auto-style25"></td>
            <td class="auto-style26"></td>
            <td class="auto-style27"></td>
            <td class="auto-style28"></td>
            <td class="auto-style29"></td>
            <td class="auto-style30"></td>
        </tr>
        <tr>
            <td class="auto-style29" colspan="6" style="text-align: center">
                <asp:Label ID="lb_mensaje" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style1" colspan="2" style="text-align: left">&nbsp;
                <asp:Label ID="lb_contador" runat="server"></asp:Label>
            </td>
            <td class="auto-style21">&nbsp;</td>
            <td class="auto-style23">&nbsp;</td>
            <td class="auto-style1">&nbsp;</td>
            <td class="auto-style2">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style24" colspan="6" style="vertical-align: middle; text-align: center">
                <asp:Panel ID="panel_grilla" runat="server" Height="100%" Width="100%" HorizontalAlign="Center" ScrollBars="Auto">
                    <asp:GridView ID="gridOrden" runat="server" AutoGenerateColumns="False" CellPadding="4" CssClass="auto-style33" DataKeyNames="ID_OPERADOR" EnableModelValidation="True" ForeColor="#333333" Height="125px" OnSelectedIndexChanged="gridOrden_SelectedIndexChanged" PageSize="40" Width="100%">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="ID_OPERADOR" HeaderText="ID_OPERADOR" ItemStyle-CssClass="ColumnaOculta" HeaderStyle-CssClass="ColumnaOculta">
                             <HeaderStyle CssClass="ColumnaOculta" />
                             <ItemStyle CssClass="ColumnaOculta" />
                            </asp:Boundfield>
                            <asp:BoundField DataField="NOMBRE_COMPLETO" HeaderText="NOMBRE OPERADOR">
                            <HeaderStyle Width="20%" ForeColor="White"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="COD_OPERADOR" HeaderText="CODIGO">
                            <HeaderStyle Width="10%" ForeColor="White"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="CLAVE_OPERADOR" HeaderText="CLAVE OPERADOR">
                            <HeaderStyle Width="12%" ForeColor="White"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="CLAVE_ADMIN" HeaderText="CLAVE ADMIN">
                            <HeaderStyle Width="10%" ForeColor="White"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="ESTADO" HeaderText="ESTADO">
                            <HeaderStyle Width="12%" ForeColor="White"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="REGION" HeaderText="REGION">
                                <HeaderStyle Width="12%" ForeColor="White"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="CONTRATISTA" HeaderText="CONTRATISTA">
                                <HeaderStyle Width="12%" ForeColor="White"/>
                            </asp:BoundField>
                             <asp:BoundField DataField="BODEGA" HeaderText="BODEGA ASIGNADA">
                                <HeaderStyle Width="12%" ForeColor="White"/>
                            </asp:BoundField>
                            <asp:CommandField ButtonType="Image" HeaderText="EDITAR" SelectImageUrl="~/Imagenes/edit.png" ShowSelectButton="True">
                            <HeaderStyle Font-Size="8pt" ForeColor="White" Width="5%" />
                            <ItemStyle Font-Size="8pt" Width="50px" />
                            </asp:CommandField>
                        </Columns>
                        <EditRowStyle BackColor="#2461BF" />
                        <FooterStyle BackColor="#1B3550" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#1B3550" Font-Bold="True" ForeColor="White" Width="150px" />
                        <PagerStyle BackColor="#1B3550" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EFF3FB" Font-Bold="True" Font-Italic="False" ForeColor="White" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="False" ForeColor="#333333" />
                    </asp:GridView>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td class="auto-style19">&nbsp;</td>
            <td class="auto-style20">&nbsp;</td>
            <td class="auto-style21">&nbsp;</td>
            <td class="auto-style23">&nbsp;</td>
            <td class="auto-style1">&nbsp;</td>
            <td class="auto-style2">&nbsp;</td>
        </tr>
        </table>
   </div>
     <div id="agregar" runat="server" Visible="false">
        <table class="auto-style9">
        <tr>
            <td  colspan=6 class="auto-style18" style="text-align: center">INGRESO DE DATOS</td>
        </tr>
        <tr>
            <td class="auto-style43">&nbsp;</td>
            <td class="auto-style40" colspan="4" style="text-align: left">&nbsp;</td>
            <td class="auto-style2">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style43"></td>
            <td class="auto-style40"></td>
            <td class="auto-style42"></td>
            <td class="auto-style1"></td>
            <td class="auto-style42"></td>
            <td class="auto-style2">&nbsp;</td>
        </tr>
        <tr>
            <td style="text-align: right" class="auto-style45">
                <asp:Label ID="lb_nombres" runat="server">NOMBRES: </asp:Label>
            </td>
            <td class="auto-style32" style="text-align: center">
                <asp:TextBox ID="tb_nombres" runat="server" Width="225px" Height="20px" MaxLength="20"></asp:TextBox>
            </td>
            <td class="auto-style45" style="text-align: right">
                <asp:Label ID="lb_apellidos" runat="server">APELLIDOS:</asp:Label>
            </td>
            <td class="auto-style32" style="text-align: center">
                <asp:TextBox ID="tb_apellidos" runat="server" Width="225px" Height="20px" MaxLength="20"></asp:TextBox>
            </td>
            <td class="auto-style45" style="text-align: right">
                <asp:Label ID="lb_rut" runat="server">CODIGO:</asp:Label>
            </td>
            <td class="auto-style31" style="text-align: left">
                &nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="tb_codigo" runat="server" Width="125px" MaxLength="12" Height="20px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style45" style="text-align: right">
                <asp:Label ID="lb_username" runat="server">CLAVE:</asp:Label>
            </td>
            <td class="auto-style32" style="text-align: center">
                <asp:TextBox ID="tb_clave_operador" runat="server" Width="225px" Height="20px" MaxLength="20"></asp:TextBox>
            </td>
            <td class="auto-style45" style="text-align: right">
                <asp:Label ID="lb_contrasena" runat="server">CLAVE ADMIN:</asp:Label>
            </td>
            <td class="auto-style32" style="text-align: center">
                <asp:TextBox ID="tb_clave_admin" runat="server" Width="225px" Height="20px" MaxLength="12"></asp:TextBox>
            </td>
            <td class="auto-style45" style="text-align: right">
                <asp:Label ID="lb_estado" runat="server">ESTADO:</asp:Label>
            </td>
            <td class="auto-style31">&nbsp;&nbsp;&nbsp;
                <asp:DropDownList ID="cb_estados" runat="server" Height="20px" Width="130px">
                    <asp:ListItem Value="0">HABILITADO</asp:ListItem>
                    <asp:ListItem Value="1">DESHABILITADO</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="auto-style45" style="text-align: right">
                <asp:Label ID="lb_perfil" runat="server">CONTRATISTA:</asp:Label>
            </td>
            <td class="auto-style32" style="text-align: center">
                <asp:DropDownList ID="cb_contratistas" runat="server" Height="20px" Width="230px">
                </asp:DropDownList>
            </td>
            <td class="auto-style45" style="text-align: right">
                <asp:Label ID="lb_bodega" runat="server">BODEGA ASIGNADA:</asp:Label>
            </td>
            <td class="auto-style32" style="text-align: center">
                <asp:DropDownList ID="cb_bodegas" runat="server" Height="20px" Width="230px">
                </asp:DropDownList>
            </td>
            <td class="auto-style45" style="text-align: right">
                <asp:Label ID="lb_region" runat="server">REGION:</asp:Label>
            </td>
            <td class="auto-style31" style="text-align: center">
                <asp:DropDownList ID="cb_regiones" runat="server" Height="20px" Width="130px">
                 
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="auto-style49" style="text-align: right">
                <asp:Label ID="LBLL" runat="server">DEVOLUCIÓN ORDENES:</asp:Label>
            </td>
            <td class="auto-style50" style="text-align: left">&nbsp;&nbsp;
                <asp:CheckBox ID="rb_autoriza" runat="server" Text="AUTORIZADO" />
            </td>
            <td class="auto-style49" style="text-align: right">
            </td>
            <td class="auto-style50" style="text-align: center"></td>
            <td class="auto-style49" style="text-align: right"></td>
            <td class="auto-style51">
                <asp:Label ID="rescate_id_operador" runat="server" Visible="False"></asp:Label>
                <asp:Label ID="rescate_old_codigo" runat="server" Visible="False"></asp:Label>
                <asp:Label ID="lb_accion" runat="server" Visible="False"></asp:Label>
                <asp:Label ID="rescate_old_bodega" runat="server" Visible="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style45" style="text-align: right">
                &nbsp;</td>
            <td class="auto-style47" style="text-align: center" colspan="4">
                <asp:Label ID="lb_error" runat="server" ForeColor="Red"></asp:Label>
            </td>
            <td class="auto-style2">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style45" style="text-align: right">
                &nbsp;</td>
            <td class="auto-style46" colspan="4" style="text-align: center">
                <asp:Button ID="btn_guardar" runat="server" BackColor="#336699" Font-Bold="True" Font-Names="Calibri" ForeColor="White" Text="GUARDAR OPERADOR" OnClick="btn_guardar_Click" Font-Size="Small" Height="50px" />
            &nbsp;</td>
            <td class="auto-style31" style="text-align: center">
                <asp:Button ID="btn_volver" runat="server" BackColor="#336699" Font-Bold="True" Font-Names="Calibri" ForeColor="White" Text="VOLVER" OnClick="btn_volver_Click" OnClientClick="return confirm('Se descartarán todos los cambios realizados, ¿Está seguro de continuar?');" Height="50px" />
            </td>
        </tr>
        <tr>
            <td class="auto-style29" colspan="5" style="text-align: center">
                </td>
            <td class="auto-style29" style="text-align: center">
                </td>
        </tr>
        <tr>
            <td class="auto-style43">&nbsp;</td>
            <td class="auto-style40">&nbsp;</td>
            <td class="auto-style42">&nbsp;</td>
            <td class="auto-style1">&nbsp;</td>
            <td class="auto-style42">&nbsp;</td>
            <td class="auto-style2">&nbsp;</td>
        </tr>
        </table>
   </div>
        
</asp:Content>
