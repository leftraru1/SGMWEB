﻿<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="MantenedorFeriados.aspx.cs" Inherits="Feriados" %>

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
            width: 82px;
        }
         .auto-styl20
        {
            height: 20px;
            text-align: center;
            width: 200px;
        }
        .auto-style20
        {
            width: 124px;
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
            height: 20px;
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
            width: 82px;
        }
        .auto-style26
        {
            width: 124px;
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
            width: 150px;
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
        .auto-style52 {
            width: 124px;
            height: 20px;
        }
        #IMG7 {
            height: 25px;
            width: 22px;
        }
        .auto-style53 {
            width: 150px;
            height: 30px;
        }
        .auto-style55 {
            width: 75px;
            height: 30px;
        }
        .auto-style56 {
            height: 20px;
            text-align: left;
            width: 75px;
        }
        #btn_eliminar {
            width: 10px;
        }
        </style>

    <script type="text/javascript">

        function openCalendar(obj) {
            var url = 'calendario2.aspx?textbox=' + obj;
            window.open(url, 'cal', 'width=260,height=210,left=410 410,top=330,resizable=0,scrollbars=0');
        }
    </script>
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <div id="main" runat="server">
        <table class="auto-style9">
        <tr>
            <td  colspan=6 class="auto-style18">MANTENEDOR DE FERIADOS<asp:Label ID="lb_id_usuario" runat="server" Visible="False"></asp:Label>
                <asp:Label ID="lb_id_perfil" runat="server" Visible="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style19">&nbsp;</td>
            <td class="auto-style20"></td>
            <td class="auto-style21"></td>
            <td class="auto-style23"></td>
            <td class="auto-style1"></td>
            <td class="auto-style2"></td>
        </tr>
        <tr>
            <td class="auto-style19" style="vertical-align: middle">
                Año:</td>
            <td style="text-align: left" class="auto-style52">
                &nbsp;
                        <asp:DropDownList ID="cb_agno" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddTipoPro_SelectedIndexChanged" Width="112px" Height="25px">
                        </asp:DropDownList>
            </td>
            <td class="auto-style22" style="text-align: left">
                <asp:Button ID="btn_buscar" runat="server" BackColor="#336699" Font-Bold="True" Font-Names="Calibri" ForeColor="White" Text="BUSCAR" style="height: 25px" OnClick="btn_buscar_Click" />
            </td>
            <td class="auto-style23"></td>
            <td class="auto-style1" colspan="2" style="text-align: left">
                <asp:Button ID="btn_nuevo" runat="server" BackColor="#336699" Font-Bold="True" Font-Names="Calibri" ForeColor="White" Text="NUEVO FERIADO" OnClick="btn_nuevo_Click" />
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
            <td class="auto-style21"></td>
            <td class="auto-style23"></td>
            <td class="auto-style1"></td>
            <td class="auto-style2"></td>
        </tr>
        <tr>
            <td class="auto-style24" colspan="6" style="vertical-align: middle; text-align: center">
                <asp:Panel ID="panel_grilla" runat="server" Height="100%" Width="100%" HorizontalAlign="Center" ScrollBars="Auto">
                    <asp:GridView ID="migrilla" runat="server" AutoGenerateColumns="False" CellPadding="4" CssClass="auto-style33" DataKeyNames="ID_FERIADO" EnableModelValidation="True" ForeColor="#333333" Height="125px" OnSelectedIndexChanged="gridOrden_SelectedIndexChanged" OnRowCommand="gridOrden_RowCommand" PageSize="40" Width="100%">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="ID_FERIADO" HeaderText="ID_FERIADO" ItemStyle-CssClass="ColumnaOculta" HeaderStyle-CssClass="ColumnaOculta">
                             <HeaderStyle CssClass="ColumnaOculta" />
                             <ItemStyle CssClass="ColumnaOculta" />
                            </asp:Boundfield>
                              <asp:BoundField DataField="FECHA" HeaderText="FECHA COMPLETA">
                            <HeaderStyle Width="25%" ForeColor="White"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="DESCRIPCION" HeaderText="DESCRIPCIÓN FERIADO">
                            <HeaderStyle Width="40%" ForeColor="White"/>
                            </asp:BoundField>                          
                            <asp:BoundField DataField="REGION" HeaderText="CATEGORIA">
                            <HeaderStyle Width="25%" ForeColor="White"/>
                            </asp:BoundField>                            
                            <asp:CommandField ButtonType="Image" HeaderText="EDITAR" SelectImageUrl="~/Imagenes/edit.png" ShowSelectButton="True">
                            <HeaderStyle Font-Size="8pt" ForeColor="White" Width="5%" />
                            <ItemStyle Font-Size="8pt" Width="50px" />
                            </asp:CommandField>
                              <asp:TemplateField HeaderText="ELIMINAR">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="btn_eliminar" runat="server" CommandArgument="<%# Container.DataItemIndex%>" OnClientClick="return confirm('¿Está seguro de eliminar el feriado?');" CommandName="eliminar" ImageUrl="~/Imagenes/delete.png" Width="30px" />
                                                </ItemTemplate>
                                               <HeaderStyle ForeColor="White" Font-Size="XX-Small" Width="5%"/>
                                                <ItemStyle Font-Size="8pt" Width="50px" />
                                            </asp:TemplateField>
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
            <td class="auto-style43"></td>
            <td class="auto-style40"></td>
            <td class="auto-style56"></td>
            <td class="auto-style1"></td>
            <td class="auto-style42"></td>
            <td class="auto-style2">&nbsp;</td>
        </tr>
        <tr>
            <td style="text-align: right; vertical-align: top;" class="auto-style45">
                <asp:Label ID="lb_nombres" runat="server">FECHA:</asp:Label>
            </td>
            <td class="auto-style53" style="text-align: left; vertical-align: top;">
                <asp:TextBox ID="txtDesde" runat="server" CssClass="TextBox3" Width="100px" Height="25px" CausesValidation="True"></asp:TextBox>
                        <img src="Imagenes/calendario.gif" onclick="openCalendar('ctl00_ContentPlaceHolder1_txtDesde');"  id="IMG7" __designer:mapid="4e" /><br />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtDesde" ErrorMessage="Error formato fecha." ValidationExpression="(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d"></asp:RegularExpressionValidator>
            </td>
            <td class="auto-style45" style="text-align: right; vertical-align: top;">
                <asp:Label ID="lb_region" runat="server">CATEGORIA:</asp:Label>
            </td>
            <td class="auto-style32" style="text-align: left; vertical-align: top;">
                <asp:DropDownList ID="cb_regiones" runat="server" Height="20px" Width="230px" OnSelectedIndexChanged="cb_regiones_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
            <td class="auto-style45" style="text-align: right">
                &nbsp;</td>
            <td class="auto-style31" style="text-align: left">
                &nbsp;&nbsp;&nbsp;
                </td>
        </tr>
        <tr>
            <td class="auto-style45" style="text-align: right">
                <asp:Label ID="lb_apellidos" runat="server">DESCRIPCIÓN:</asp:Label>
            </td>
            <td class="auto-style32" style="text-align: left" colspan="3">
                <asp:TextBox ID="tb_descripcion" runat="server" Width="490px" Height="20px" MaxLength="100"></asp:TextBox>
            </td>
            <td class="auto-style45" style="text-align: right">
                &nbsp;</td>
            <td class="auto-style31">&nbsp;&nbsp;&nbsp;
                <asp:Label ID="rescate_id_feriado" runat="server" Visible="False"></asp:Label>
                <asp:Label ID="lb_accion" runat="server" Visible="False"></asp:Label>
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
                <asp:Button ID="btn_guardar" runat="server" BackColor="#336699" Font-Bold="True" Font-Names="Calibri" ForeColor="White" Text="GUARDAR FERIADO" OnClick="btn_guardar_Click" Font-Size="Small" Height="50px" />
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
            <td class="auto-style56">&nbsp;</td>
            <td class="auto-style1">&nbsp;</td>
            <td class="auto-style42">&nbsp;</td>
            <td class="auto-style2">&nbsp;</td>
        </tr>
        </table>
   </div>
        
</asp:Content>
