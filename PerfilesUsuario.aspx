<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="PerfilesUsuario.aspx.cs" Inherits="Imagenes_PerfilesUsuario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .GridAlternativeItems
        {}
        .auto-style9
        {
            text-align: right;
            vertical-align:central;
            width: 659px;
        }
        .auto-style11
        {
            height: 19px;
            text-align:right;
            }
        .auto-style12
    {
        vertical-align: central;
        height: 83px;
    }
    .auto-style15
    {
        vertical-align: central;
        height: 7px;
    }
        .auto-style17
        {
            vertical-align: central;
            width: 2071px;
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
            height: 2px;
        }
        .auto-style20
        {
            height: 14px;
        }
        #IMG6
    {
        margin-left: 0px;
    }
        .auto-style21 {
            vertical-align: central;
            width: 2071px;
            height: 27px;
        }
        .auto-style22 {
            text-align: right;
            vertical-align: central;
            width: 659px;
            height: 27px;
        }
        </style>
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
        <table style="height: 712px; width: 1029px;">
        <tr>
            <td class="auto-style18" colspan="2">Perfil de Usuario </td>
        </tr>
        <tr>
            <td  colspan="2" class="auto-style20">
                </td>
        </tr>
        <tr>
            <td class="auto-style15" colspan="2">Perfil :
                <asp:DropDownList ID="comboPerfil" runat="server" AutoPostBack="True" OnSelectedIndexChanged="comboPerfil_SelectedIndexChanged" style="margin-left: 0px" CssClass="ComboBox">
                </asp:DropDownList>
                </td>
        </tr>
        <tr>
            <td class="auto-style11" colspan="2">
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label1" runat="server"></asp:Label>
            </td>
            <td class="auto-style11">
        <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl="~/AgregarPerfil.aspx">Nuevo Perfil</asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td class="auto-style12" colspan="2">
               <asp:Panel ID="pnPerfil" runat="server" Height="506px" HorizontalAlign="Center" ScrollBars="Auto" Width="1074px">
                    <asp:DataGrid ID="GrillaPermisos" runat="server" AutoGenerateColumns="False" CellPadding="4" CssClass="GridAlternativeItems" ForeColor="#333333" Height="30px" Width="1049px">
                        <EditItemStyle BackColor="#2461BF" />
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" Font-Underline="True" ForeColor="White" HorizontalAlign="Center" />
                        <Columns>
                            <asp:BoundColumn DataField="id_submenu" HeaderText="IDSUBMENU" Visible="False">
                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="menu" HeaderText="Modulo (Submenu)">
                                <HeaderStyle Font-Bold="True" ForeColor="White" Width="38%" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                            </asp:BoundColumn>
                            <asp:TemplateColumn HeaderText="Acceso al módulo">
                                <HeaderStyle Font-Bold="True" ForeColor="White" Width="24%" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <ItemTemplate>
                                    &nbsp;
                                    <asp:CheckBox ID="checkPermiso" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:BoundColumn DataField="menup" HeaderText="Menu Padre (Principal)">
                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" ForeColor="White" Width="38%" />
                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                            </asp:BoundColumn>
                            <asp:BoundColumn DataField="id_perfil" HeaderText="IDPERFIL" Visible="False"></asp:BoundColumn>
                        </Columns>
                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                        <ItemStyle BackColor="#EFF3FB" />
                        <AlternatingItemStyle BackColor="White" />
                        <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    </asp:DataGrid>
                </asp:Panel>
                <br />
            </td>
        </tr>
            <asp:Panel ID="Mantenedor" runat="server">


            </asp:Panel>
        <tr>
            <td class="auto-style21">

                <img src="Imagenes/ok.bmp" runat="server" id="IMG2" /><img src="~/Imagenes/cross2.bmp" runat="server" id="IMG5" />&nbsp; <asp:Label ID="lbResultado" runat="server"></asp:Label>
            </td>
            <td class="auto-style22">
                <asp:Button ID="Button1" runat="server" Text="Guardar Cambios" OnClick="Button1_Click" CssClass="botonnew" />
            </td>
        </tr>

        <tr>
            <td class="auto-style17">
                &nbsp;</td>
            <td class="auto-style9">
                &nbsp;</td>
        </tr>
        </table>
        <%--<asp:GridView ID="GridView1" runat="server" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" Width="1051px">
            <Columns>
                <asp:BoundField HeaderText="Nombre" DataField="" />
            </Columns>
        </asp:GridView>--%>
    
        
</asp:Content>

