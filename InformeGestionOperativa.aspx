<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="InformeGestionOperativa.aspx.cs" Inherits="InformeGestionOperativa" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style5
        {
            width: 32px;
        }
        .auto-style6
        {
        }
        .auto-style7
        {
            width: 220px;
        }
        .auto-style8
        {
            width: 102px;
        }
        .auto-style9
        {
            width: 206px;
        }
        .auto-style10
        {
            width: 68px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width: 100%;">
        <tr>
            <td class="auto-style5">&nbsp;</td>
            <td class="auto-style6">&nbsp;</td>
            <td class="auto-style7">
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
            <td class="auto-style8">&nbsp;</td>
            <td class="auto-style9">&nbsp;</td>
            <td class="auto-style10">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style5">&nbsp;</td>
            <td class="auto-style6">Tipo Proceso:</td>
            <td class="auto-style7">
                <asp:DropDownList ID="ddTipoProceso" runat="server" CssClass="ComboBox">
                </asp:DropDownList>
            </td>
            <td class="auto-style8">Grupo:</td>
            <td class="auto-style9">
                <asp:DropDownList ID="ddGrupo" runat="server" CssClass="ComboBox">
                </asp:DropDownList>
            </td>
            <td class="auto-style10">Desde:&nbsp;</td>
            <td>
                        <asp:TextBox ID="txtDesde" runat="server" CssClass="TextBox3" Width="175px"></asp:TextBox>
                        <img src="Imagenes/calendario.gif" onclick="openCalendar('ctl00_ContentPlaceHolder1_txtDesde');"  id="IMG7" __designer:mapid="2e" />
                        </td>
        </tr>
        <tr>
            <td class="auto-style5">&nbsp;</td>
            <td class="auto-style6">&nbsp;</td>
            <td class="auto-style7">&nbsp;</td>
            <td class="auto-style8">&nbsp;</td>
            <td class="auto-style9">&nbsp;</td>
            <td class="auto-style10">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style5">&nbsp;</td>
            <td class="auto-style6">Zona:</td>
            <td class="auto-style7">
                <asp:DropDownList ID="ddZona" runat="server" CssClass="ComboBox">
                </asp:DropDownList>
            </td>
            <td class="auto-style8">Ruta:</td>
            <td class="auto-style9">
                <asp:DropDownList ID="ddRuta" runat="server" CssClass="ComboBox">
                </asp:DropDownList>
            </td>
            <td class="auto-style10">Hasta:</td>
            <td>
                        <asp:TextBox ID="txtHasta" runat="server" CssClass="TextBox3" Width="175px"></asp:TextBox>
                        <img src="Imagenes/calendario.gif" onclick="openCalendar('ctl00_ContentPlaceHolder1_txtHasta');"  id="IMG8" __designer:mapid="33" />
                        </td>
        </tr>
        <tr>
            <td class="auto-style5">&nbsp;</td>
            <td class="auto-style6">&nbsp;</td>
            <td class="auto-style7">&nbsp;</td>
            <td class="auto-style8">&nbsp;</td>
            <td class="auto-style9">&nbsp;</td>
            <td class="auto-style10">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style5">&nbsp;</td>
            <td class="auto-style6">Localidad:</td>
            <td class="auto-style7">
                <asp:DropDownList ID="ddLocalidad" runat="server" CssClass="ComboBox">
                </asp:DropDownList>
            </td>
            <td class="auto-style8">Operador:</td>
            <td class="auto-style9">
                <asp:DropDownList ID="ddOperador" runat="server" CssClass="ComboBox">
                </asp:DropDownList>
            </td>
            <td class="auto-style10">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style5">&nbsp;</td>
            <td class="auto-style6">&nbsp;</td>
            <td class="auto-style7">&nbsp;</td>
            <td class="auto-style8">&nbsp;</td>
            <td class="auto-style9">&nbsp;</td>
            <td class="auto-style10">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style5">&nbsp;</td>
            <td class="auto-style6" colspan="6">
                                    <asp:Panel ID="Panel2" runat="server">
                                    </asp:Panel>
                        <asp:Panel ID="panGrid" runat="server" Height="326px" HorizontalAlign="Center" ScrollBars="Auto" Width="1100px">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="gvOperativo" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" CssClass="GridAlternativeItems" EnableModelValidation="True" ForeColor="#333333" OnPageIndexChanging="gridOrden_PageIndexChanging" OnRowCommand="gridOrden_RowCommand" PageSize="40" Width="1034px">
                                        <AlternatingRowStyle BackColor="White" />
                                        <Columns>
                                            <asp:BoundField DataField="NOMBRE" HeaderText="Nombre">
                                            <HeaderStyle ForeColor="White" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="PROCEDENTE" HeaderText="Procedente">
                                            <HeaderStyle ForeColor="White" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="IMPROCEDENTE" HeaderText="Improcedente">
                                            <HeaderStyle ForeColor="White" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="TOTAL" HeaderText="Total">
                                            <HeaderStyle ForeColor="White" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="PORCENTAJE" HeaderText="Porcentaje">
                                            <HeaderStyle ForeColor="White" />
                                            </asp:BoundField>
                                        </Columns>
                                        <EditRowStyle BackColor="#2461BF" />
                                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                        <RowStyle BackColor="#EFF3FB" />
                                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                    </asp:GridView>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>
                                </td>
        </tr>
        <tr>
            <td class="auto-style5">&nbsp;</td>
            <td class="auto-style6">&nbsp;</td>
            <td class="auto-style7">&nbsp;</td>
            <td class="auto-style8">&nbsp;</td>
            <td class="auto-style9">&nbsp;</td>
            <td class="auto-style10">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>

     </asp:Content>

