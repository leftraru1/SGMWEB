<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="GeneradorRepaso.aspx.cs" Inherits="GeneradorRepaso" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <style type="text/css">

           .auto-styleTD
        {
           
            text-align: left;
            height: 19px;
        }

        .auto-style5 {
            text-align: left;
            height: 19px;
            width: 91px;
        }
        .auto-style7 {
            height: 20px;
            width: 91px;
        }
        .auto-style8 {
            width: 91px;
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h1 class="WebPartTitle">Generador de Repaso<asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    </h1>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table >
                <tr>
                   
                    <td class="auto-style5">
                        &nbsp;Región:</td>
                    <td colspan="3">
                        <asp:DropDownList ID="ddRegion" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddRegion_SelectedIndexChanged" Width="300px">
                        </asp:DropDownList>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    
                    <td class="auto-style5">
                        <asp:Label ID="Label1" runat="server" Text="Zona:"></asp:Label>
                    </td>
                    <td class="auto-style20" colspan="3">
                        <asp:DropDownList ID="ddZona" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddZona_SelectedIndexChanged" Width="300px">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style20"></td>
                </tr>
                <tr>
                   
                    <td class="auto-style5">
                        <asp:Label ID="Label4" runat="server" Text="Localidad:"></asp:Label>
                    </td>
                    <td colspan="3" class="auto-style20">
                        <asp:DropDownList ID="ddLocalidad" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddLocalidad_SelectedIndexChanged" Width="300px">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style20"></td>
                </tr>
                <tr>
                    
                    <td class="auto-style5">
                        <asp:Label ID="Label5" runat="server" Text="Grupo:"></asp:Label>
                    </td>
                    <td class="auto-style20" colspan="3">
                        <asp:DropDownList ID="ddGrupo" runat="server" AutoPostBack="True" CssClass="ComboBox" Width="300px" OnSelectedIndexChanged="ddGrupo_SelectedIndexChanged">
                        </asp:DropDownList>
                        <asp:Button ID="Button1" runat="server" CssClass="botonnew" Text="Generar Repaso" OnClick="Button1_Click" />
                        <img src="Imagenes/ok.bmp" runat="server" id="IMG7" visible="False" />
                        <img src="~/Imagenes/cross2.bmp" runat="server" id="IMG8" visible="False" />
                        <img src="~/Imagenes/warning.bmp" runat="server"  id="IMG9" visible="False" />
                        &nbsp;
                        <asp:Label ID="lbResultado" runat="server"></asp:Label>
                    </td>
                    <td class="auto-style20"></td>
                </tr>
                <tr>
                    <td class="auto-style8">&nbsp;</td>
                    <td colspan="4">
                        &nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style8">&nbsp;</td>
                    <td colspan="4">
                        <asp:Label ID="lbTotal" runat="server"></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style8">&nbsp;</td>
                    <td colspan="4">
                        <asp:Panel ID="panGrid" runat="server" ScrollBars="Vertical" Width="1084px" Height="460px">
                            <asp:GridView ID="gridRepaso" runat="server" AutoGenerateColumns="False" CellPadding="4" CssClass="GridActiveItem" EnableModelValidation="True" ForeColor="#333333" Width="1065px" OnRowCommand="gridRepaso_RowCommand">
                                <AlternatingRowStyle BackColor="White" />
                                <Columns>
                                    <asp:BoundField DataField="ID_SERVICIO" HeaderText="IC">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="DESCRIPCION" HeaderText="Estatus Orden">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="INSTALADOR" HeaderText="Intalador">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="FECHA_IN_MN" HeaderText="Fecha Instalación">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="HORA_EJECUCION" HeaderText="Hora Instalación">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CLIENTE" HeaderText="Cliente">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="DIRECCION" HeaderText="Dirección">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="OBSERVACION_OUT" HeaderText="Observación">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Marcar">
                                        <HeaderTemplate>
                                            <asp:LinkButton ID="lkbMarcar" runat="server" CommandName="marcar">Marcar</asp:LinkButton>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="check_marcar" runat="server" />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                </Columns>
                                <EditRowStyle BackColor="#2461BF" />
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <RowStyle BackColor="#EFF3FB" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            </asp:GridView>
                        </asp:Panel>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style8">&nbsp;</td>
                    <td class="auto-style21" colspan="4">

                        &nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style8">&nbsp;</td>
                    <td class="auto-style21">&nbsp;</td>
                    <td colspan="3">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style8">&nbsp;</td>
                    <td class="auto-style11">
                        &nbsp;</td>
                    <td colspan="3">
                        &nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style7"></td>
                    <td class="auto-style11" style="height: 20px">
                    </td>
                    <td colspan="3" style="height: 20px">
                    </td>
                    <td style="height: 20px"></td>
                </tr>
                <tr>
                    <td class="auto-style8">&nbsp;</td>
                    <td class="auto-style11">
                        &nbsp;</td>
                    <td colspan="3">
                        &nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style8">&nbsp;</td>
                    <td class="auto-style11">
                        &nbsp;</td>
                    <td colspan="3">
                        &nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style8">&nbsp;</td>
                    <td class="auto-style11">
                        &nbsp;</td>
                    <td colspan="3">
                        &nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style8">&nbsp;</td>
                    <td class="auto-style21">&nbsp;</td>
                    <td class="auto-style13">
                       
                       

                        &nbsp;<td class="auto-style15">
                            &nbsp;</td>
                    <td class="auto-style14">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style8">&nbsp;</td>
                    <td class="auto-style21">&nbsp;</td>
                    <td  runat="server" id="tdSalida" class="auto-style13">&nbsp;</td>
                    <td class="auto-style15">
                        &nbsp;</td>
                    <td class="auto-style14">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </ContentTemplate>

    </asp:UpdatePanel>
</asp:Content>

