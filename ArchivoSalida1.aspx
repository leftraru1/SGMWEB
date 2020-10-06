<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="ArchivoSalida.aspx.cs" Inherits="ArchivoSalida" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style6
        {
            width: 200px;
            text-align: center;
            height: 20px;
        }
        .auto-style7
        {
            height: 19px;
        }
        .auto-style8
        {
            text-align: right;
            height: 20px;
            width: 16%;
        }
        .auto-style9
        {
            text-align: right;
            vertical-align:central
        }
        .auto-style21
        {
        }
        .auto-style23
        {
            margin-top: 0px;
        }
        .auto-style30
        {
            height: 19px;
            width: 1%;
        }
        .auto-style33
        {
            height: 21px;
            width: 1%;
        }
        .auto-style35
        {
            height: 22px;
            width: 1%;
        }
        .auto-style37
        {
            width: 1%;
        }
        .auto-style47
        {
            height: 20px;
            width: 1%;
        }
        .auto-style59
        {
            height: 22px;
            width: 25%;
        }
        .auto-style62
        {
            height: 22px;
            width: 2%;
        }
        .auto-style63
        {
            width: 313px;
            text-align: center;
            height: 20px;
        }
        .auto-style69
        {
            height: 21px;
            width: 25%;
        }
        .auto-style70
        {
            height: 19px;
            width: 25%;
        }
        .auto-style71
        {
            height: 21px;
            width: 2%;
        }
        .auto-style72
        {
            height: 20px;
            width: 2%;
        }
        .auto-style73
        {
            height: 19px;
            width: 2%;
        }
        .auto-style75
        {
            height: 20px;
            width: 25%;
        }
        .auto-style97
        {
            height: 21px;
            width: 6%;
        }
        .auto-style99
        {
            height: 20px;
            width: 6%;
        }
        .auto-style100
        {
            height: 19px;
            width: 6%;
        }
        .auto-style107
        {
            text-align: right;
            width: 6%;
        }
        .auto-style109
        {
            text-align: right;
            vertical-align: central;
            width: 6%;
        }
        .auto-style110
        {
            text-align: right;
            height: 20px;
            width: 6%;
        }
        .auto-style117
        {
            text-align: right;
            height: 21px;
            width: 16%;
        }
        .auto-style118
        {
            height: 21px;
        }
        .auto-style119
        {
            text-align: right;
            height: 21px;
            width: 5%;
        }
        .auto-style120
        {
            text-align: right;
            vertical-align: central;
            width: 6%;
            height: 21px;
        }
        .auto-style121
        {
            text-align: right;
            height: 20px;
            width: 5%;
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
    <h1 class="WebPartTitle">Generación Archivo Salida<asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    </h1>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table style="width:100%;">
                <tr>
                    <td class="auto-style7" colspan="12">&nbsp;</td>
                    <td class="auto-style30"></td>
                </tr>
                <tr>
                    <td class="auto-style8">
                        &nbsp;
                        <asp:Label ID="Label6" runat="server" Text="Región:"></asp:Label>
                    </td>
                    <td class="auto-style7" colspan="3" >
                        <asp:DropDownList ID="ddRegion" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddRegion_SelectedIndexChanged" Width="360px">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style9">
                        &nbsp;</td>
                    <td class="auto-style109">
                        &nbsp;</td>
                    <td class="auto-style69">
                        &nbsp;&nbsp;</td>
                    <td class="auto-style71">&nbsp;</td>
                    <td class="auto-style71">&nbsp;</td>
                    <td class="auto-style71">&nbsp;</td>
                    <td class="auto-style71">&nbsp;</td>
                    <td class="auto-style71">&nbsp;</td>
                    <td class="auto-style33">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style8">
                        <asp:Label ID="Label1" runat="server" Text="Zona:"></asp:Label>
                    </td>
                    <td class="auto-style7" colspan="3">
                        <asp:DropDownList ID="ddZona" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddZona_SelectedIndexChanged" Width="360px">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style9">&nbsp;</td>
                    <td class="auto-style109">
                        &nbsp;</td>
                    <td class="auto-style59">
                        &nbsp;&nbsp;</td>
                    <td class="auto-style62">&nbsp;</td>
                    <td class="auto-style62">&nbsp;</td>
                    <td class="auto-style62">&nbsp;</td>
                    <td class="auto-style62">&nbsp;</td>
                    <td class="auto-style62"></td>
                    <td class="auto-style35"></td>
                </tr>
                <tr>
                    <td class="auto-style8">
                        <asp:Label ID="Label4" runat="server" Text="Localidad:"></asp:Label>
                    </td>
                    <td class="auto-style7" colspan="3">
                        <asp:DropDownList ID="ddLocalidad" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddLocalidad_SelectedIndexChanged" Width="360px" Height="17px">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style9">&nbsp;</td>
                    <td class="auto-style107">
                        &nbsp;</td>
                    <td class="auto-style59">
                        &nbsp;</td>
                    <td class="auto-style62"></td>
                    <td class="auto-style62"></td>
                    <td class="auto-style62"></td>
                    <td class="auto-style62"></td>
                    <td class="auto-style62"></td>
                    <td class="auto-style35"></td>
                </tr>
                <tr>
                    <td class="auto-style117">
                        <asp:Label ID="Label5" runat="server" Text="Grupo:"></asp:Label>
                    </td>
                    <td class="auto-style118" colspan="3">
                        <asp:DropDownList ID="ddGrupo" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddGrupo_SelectedIndexChanged" Width="360px" Height="16px">
                        </asp:DropDownList>
                        &nbsp;</td>
                    <td class="auto-style97">
                        </td>
                    <td class="auto-style97">&nbsp;</td>
                    <td class="auto-style69"></td>
                    <td class="auto-style71"></td>
                    <td class="auto-style71"></td>
                    <td class="auto-style71"></td>
                    <td class="auto-style71"></td>
                    <td class="auto-style71"></td>
                    <td class="auto-style33"></td>
                </tr>
                <tr>
                    <td class="auto-style117">
                        <asp:Label ID="Label9" runat="server" Text="Fecha Desde:"></asp:Label>
                    </td>
                    <td class="auto-style118">
                        <asp:TextBox ID="txt_fecha_desde" runat="server" Width="100px" AutoPostBack="True" OnTextChanged="txt_fecha_desde_TextChanged"></asp:TextBox>
                        &nbsp;<asp:Image ID="Image1" runat="server" ImageUrl="~/Imagenes/calendario.gif" onclick="openCalendar('ctl00_ContentPlaceHolder1_txt_fecha_desde');" Visible="True" />
                        &nbsp;</td>
                    <td class="auto-style119">
                        <asp:Label ID="Label10" runat="server" Text="Hasta:"></asp:Label>
                    </td>
                    <td class="auto-style118">
                        <asp:TextBox ID="txt_fecha_hasta" runat="server" Width="100px" AutoPostBack="True" OnTextChanged="txt_fecha_hasta_TextChanged"></asp:TextBox>
                        &nbsp;<asp:Image ID="Image2" runat="server" ImageUrl="~/Imagenes/calendario.gif" onclick="openCalendar('ctl00_ContentPlaceHolder1_txt_fecha_hasta');" Visible="True" />
                        &nbsp;</td>
                    <td class="auto-style118" colspan="3">
                        <asp:CheckBox ID="rb_atendidas" runat="server" AutoPostBack="True" OnCheckedChanged="rb_generadas_CheckedChanged" Text="Con fecha de atención" Width="179px" />
                    </td>
                    <td class="auto-style118">&nbsp;</td>
                    <td class="auto-style118">&nbsp;</td>
                    <td class="auto-style71"></td>
                    <td class="auto-style71"></td>
                    <td class="auto-style71"></td>
                    <td class="auto-style71"></td>
                    <td class="auto-style71"></td>
                    <td class="auto-style33"></td>
                </tr>
                <tr>
                    <td class="auto-style117"></td>
                    <td class="auto-style118" colspan="3">&nbsp;
                        <asp:Label ID="lb_error_fechas" runat="server" Font-Bold="True" Font-Size="Smaller" ForeColor="Red"></asp:Label>
                    </td>
                    <td class="auto-style97"></td>
                    <td class="auto-style120"></td>
                    <td class="auto-style69"></td>
                    <td class="auto-style71"></td>
                    <td class="auto-style71"></td>
                    <td class="auto-style71"></td>
                    <td class="auto-style71"></td>
                    <td class="auto-style71"></td>
                    <td class="auto-style33"></td>
                </tr>
                <tr>
                    <td class="auto-style117">
                        <asp:CheckBox ID="rb_nro_orden" runat="server" AutoPostBack="True" OnCheckedChanged="rb_nro_orden_CheckedChanged" Text="Por orden" Width="100px" />
                    </td>
                    <td class="auto-style118">
                        <asp:TextBox ID="txt_nro_orden" runat="server" AutoPostBack="True" Enabled="False" Width="100px" OnTextChanged="txt_nro_orden_TextChanged"></asp:TextBox>
                    </td>
                    <td class="auto-style119">
                    </td>
                    <td class="auto-style118">
                        <asp:CheckBox ID="rb_generadas" runat="server" AutoPostBack="True" OnCheckedChanged="rb_generadas_CheckedChanged" Text="Generadas" Width="100px" />
                    </td>
                    <td class="auto-style97"></td>
                    <td class="auto-style120"></td>
                    <td class="auto-style69"></td>
                    <td class="auto-style71"></td>
                    <td class="auto-style71"></td>
                    <td class="auto-style71"></td>
                    <td class="auto-style71"></td>
                    <td class="auto-style71"></td>
                    <td class="auto-style33"></td>
                </tr>
                <tr>
                    <td class="auto-style8">&nbsp;</td>
                    <td class="auto-style7">
                        <asp:Label ID="lb_error_numero" runat="server" Font-Bold="True" Font-Size="Smaller" ForeColor="Red"></asp:Label>
                    </td>
                    <td class="auto-style121">&nbsp;</td>
                    <td class="auto-style7">&nbsp;</td>
                    <td class="auto-style97">&nbsp;</td>
                    <td class="auto-style109">&nbsp;</td>
                    <td class="auto-style69">&nbsp;</td>
                    <td class="auto-style71">&nbsp;</td>
                    <td class="auto-style71">&nbsp;</td>
                    <td class="auto-style71">&nbsp;</td>
                    <td class="auto-style71">&nbsp;</td>
                    <td class="auto-style71">&nbsp;</td>
                    <td class="auto-style33">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="12" class="auto-style7">
                        <asp:Label ID="lbTotal" runat="server"></asp:Label>
                    </td>
                    <td class="auto-style30"></td>
                </tr>
                <tr>
                    <td colspan="12">
                        <asp:Panel ID="panGrid" runat="server" ScrollBars="Vertical" Width="1084px" Height="460px">
                            <asp:GridView ID="gridSalida" runat="server" AutoGenerateColumns="False" CellPadding="4" CssClass="GridActiveItem" EnableModelValidation="True" ForeColor="#333333" Width="950px">
                                <AlternatingRowStyle BackColor="White" />
                                <Columns>
                                    <asp:BoundField DataField="ID_LOCALIDAD" HeaderText="idLocalidad">
                                    <HeaderStyle ForeColor="White" Width="80px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="COD_LOCALIDAD" HeaderText="Código">
                                    <HeaderStyle ForeColor="White" Width="80px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="NOMBRE" HeaderText="Localidad">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SIN_ASIGNAR" HeaderText="Sin asignar">
                                        <HeaderStyle ForeColor="White" Width="80px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ASIGNADAS_EN_PDA" HeaderText="Asignadas en PDA">
                                        <HeaderStyle ForeColor="White" Width="80px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ATENDIDAS" HeaderText="Atendidas">
                                    <HeaderStyle ForeColor="White" Width="80px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="GENERADAS_EN_TXT" HeaderText="Generadas en TXT">
                                    <HeaderStyle ForeColor="White" />
                                    <HeaderStyle ForeColor="White" />
                                    <HeaderStyle ForeColor="White" Width="80px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="TOTAL" HeaderText="Total órdenes">
                                    <HeaderStyle ForeColor="White" Width="80px" />
                                    </asp:BoundField>
                                </Columns>
                                <EditRowStyle BackColor="#2461BF" />
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <RowStyle BackColor="#EFF3FB" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            </asp:GridView>
                            <br />
                            <br />
                        </asp:Panel>
                    </td>
                    <td class="auto-style37">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style21" colspan="12">

                <img src="Imagenes/ok.bmp" runat="server" id="IMG2" /><img src="/SGM/SGM/Imagenes/cross2.bmp" runat="server" id="IMG5" /><img src="/SGM/SGM/Imagenes/warning.bmp" runat="server"  id="IMG6" />&nbsp;
                        </td>
                    <td class="auto-style37">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style7" colspan="12">
                        <asp:Label ID="lbResultado" runat="server"></asp:Label>
                    </td>
                    <td class="auto-style30"></td>
                </tr>
                <tr>
                    <td class="auto-style63" colspan="4">
                        <asp:Label ID="lb_terreno" runat="server" Text="RESUMEN ORDENES" Width="100%" Font-Bold="True" ForeColor="#336699"></asp:Label>
                    </td>
                    <td class="auto-style99">&nbsp;</td>
                    <td class="auto-style63" colspan="2">
                        &nbsp;</td>
                    <td class="auto-style72">&nbsp;</td>
                    <td class="auto-style72">&nbsp;</td>
                    <td class="auto-style72">&nbsp;</td>
                    <td class="auto-style72">&nbsp;</td>
                    <td class="auto-style72"></td>
                    <td class="auto-style47"></td>
                </tr>
                <tr>
                    <td class="auto-style8">
                        <asp:Label ID="lb_no_asignadas" runat="server" Text="Sin asignar:"></asp:Label>
                    </td>
                    <td class="auto-style7" colspan="3">
                        <asp:TextBox ID="txt_no_asignadas" runat="server" ReadOnly="True" Width="160px"></asp:TextBox>
                    </td>
                    <td class="auto-style99">&nbsp;</td>
                    <td class="auto-style110">
                        &nbsp;</td>
                    <td class="auto-style75">
                        &nbsp;</td>
                    <td class="auto-style72">&nbsp;</td>
                    <td class="auto-style72">&nbsp;</td>
                    <td class="auto-style72">&nbsp;</td>
                    <td class="auto-style72">&nbsp;</td>
                    <td class="auto-style72"></td>
                    <td class="auto-style47"></td>
                </tr>
                <tr>
                    <td class="auto-style8">
                        <asp:Label ID="lb_asignadas" runat="server" Text="Asignadas en PDA terreno:"></asp:Label>
                    </td>
                    <td class="auto-style7" colspan="3">
                        <asp:TextBox ID="txt_asignadas" runat="server" ReadOnly="True" Width="160px"></asp:TextBox>
                    </td>
                    <td class="auto-style100">&nbsp;</td>
                    <td class="auto-style110">
                        &nbsp;</td>
                    <td class="auto-style70">
                        &nbsp;</td>
                    <td class="auto-style73">&nbsp;</td>
                    <td class="auto-style73">&nbsp;</td>
                    <td class="auto-style73">&nbsp;</td>
                    <td class="auto-style73">&nbsp;</td>
                    <td class="auto-style73"></td>
                    <td class="auto-style30"></td>
                </tr>
                <tr>
                    <td class="auto-style8">
                        <asp:Label ID="lb_atendidas" runat="server" Text="Atendidas (Ejecutadas/Improcedentes):"></asp:Label>
                    </td>
                    <td class="auto-style7" colspan="3">
                        <asp:TextBox ID="txt_atendidas" runat="server" ReadOnly="True" Width="160px"></asp:TextBox>
                    </td>
                    <td class="auto-style10">
                        &nbsp;</td>
                    <td class="auto-style110">&nbsp;</td>
                    <td class="auto-style70">
                        &nbsp;</td>
                    <td class="auto-style73">&nbsp;</td>
                    <td class="auto-style73">&nbsp;</td>
                    <td class="auto-style73">&nbsp;</td>
                    <td class="auto-style73">&nbsp;</td>
                    <td class="auto-style73">&nbsp;</td>
                    <td class="auto-style30">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style8">
                        <asp:Label ID="lb_generadas" runat="server" Text="Generadas en TXT:"></asp:Label>
                    </td>
                    <td class="auto-style7" colspan="3">
                        <asp:TextBox ID="txt_generadas" runat="server" ReadOnly="True" Width="160px"></asp:TextBox>
                    </td>
                    <td class="auto-style100">&nbsp;</td>
                    <td class="auto-style110">
                        &nbsp;</td>
                    <td class="auto-style70">
                        &nbsp;</td>
                    <td class="auto-style73">&nbsp;</td>
                    <td class="auto-style73">&nbsp;</td>
                    <td class="auto-style73">&nbsp;</td>
                    <td class="auto-style73">&nbsp;</td>
                    <td class="auto-style73"></td>
                    <td class="auto-style30"></td>
                </tr>
                <tr>
                    <td class="auto-style8">
                        <asp:Label ID="lb_total" runat="server" Text="Total Ordenes:"></asp:Label>
                    </td>
                    <td class="auto-style7" colspan="3">
                        <asp:TextBox ID="txt_total" runat="server" Font-Bold="True" ReadOnly="True" Width="160px"></asp:TextBox>
                    </td>
                    <td class="auto-style100">
                        <asp:Button ID="btn_generartxt" runat="server" CssClass="botonnew" OnClick="Button1_Click" style="height: 16px" Text="Generar TXT" Width="127px" />
                    </td>
                    <td class="auto-style110">
                        &nbsp;</td>
                    <td class="auto-style70">
                        &nbsp;</td>
                    <td class="auto-style73">&nbsp;</td>
                    <td class="auto-style73">&nbsp;</td>
                    <td class="auto-style73">&nbsp;</td>
                    <td class="auto-style73">&nbsp;</td>
                    <td class="auto-style73">&nbsp;</td>
                    <td class="auto-style30">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style8"></td>
                    <td class="auto-style7" colspan="3">
                        <asp:Label ID="lb_nota" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                    </td>
                    <td class="auto-style99">
                        &nbsp;</td>
                    <td class="auto-style110"></td>
                    <td class="auto-style75">
                        &nbsp;</td>
                    <td class="auto-style72"></td>
                    <td class="auto-style72"></td>
                    <td class="auto-style72"></td>
                    <td class="auto-style72"></td>
                    <td class="auto-style72"></td>
                    <td class="auto-style47"></td>
                </tr>
                <tr>
                    <td id="tdSalida" runat="server" class="auto-style7" colspan="12">&nbsp;&nbsp;</td>
                    <td class="auto-style30"></td>
                </tr>
                <tr>
                    <td class="auto-style8" colspan="12">
                        <asp:Table ID="tbl_link" runat="server" CssClass="auto-style23" Height="21px" style="margin-bottom: 7px" Visible="False" Width="226px">
                        </asp:Table>
                    </td>
                    <td class="auto-style30">&nbsp;</td>
                </tr>
            </table>
        </ContentTemplate>

    </asp:UpdatePanel>

    </asp:Content>

