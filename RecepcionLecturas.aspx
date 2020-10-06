<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="RecepcionLecturas.aspx.cs" Inherits="RecepcionLecturas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style5
        {
        }
        .auto-style8
        {
            vertical-align: top;
            height: 25px;
        }
        .auto-style14
        {
            height: 12px;
            text-align: right;
            width: 139px;
        }
        .auto-style17
        {
            height: 9px;
        }
        .auto-style22
        {
            width: 139px;
            height: 23px;
        }
                
        .auto-style31
        {
            text-align: right;
            height: 25px;
            width: 139px;
        }
        .auto-style35
        {
            height: 7px;
            text-align: right;
            width: 139px;
        }
        .auto-style36
        {
            height: 7px;
        }
        .auto-style37
        {
            height: 9px;
            text-align: right;
        }
        .auto-style40
        {
            height: 12px;
            vertical-align: top;
        }
        .auto-style42
        {
            width: 139px;
            height: 5px;
        }
        .auto-style43
        {
            height: 5px;
        }
        
        .auto-style45
        {
            height: 19px;
            text-align: right;
            width: 139px;
        }
        .auto-style46
        {
            height: 19px;
        }
        .auto-style47
        {
            height: 23px;
        }
        
        .auto-style48
        {
            height: 9px;
            text-align: right;
            width: 139px;
        }
        
        .auto-style49
        {
            border: 1px solid #7f9db9;
            font-weight: normal;
            font-size: 11px;
            color: black;
            font-family: Verdana, Arial, Helvetica, sans-serif;
            background-color: white;
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
            <h1 class="WebPartTitle">Recepción de Archivo</h1>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            
        <table style="width:89%; height: 308px;">
            <tr>
                <td class="auto-style14">Cargar Archivo:
                    </td>
                <td class="auto-style40">&nbsp;<asp:FileUpload ID="fuArchivo" runat="server" BorderStyle="None" Width="327px" CssClass="Button" />
                    <asp:TextBox ID="nuArchivo" runat="server" Width="38px" Visible="False" OnTextChanged="nuArchivo_TextChanged" ></asp:TextBox>
                    <br />
                    </td>
                <td class="auto-style40" colspan="2"></td>
            </tr>
            <tr>
                <td class="auto-style35">Periodo:</td>
                <td class="auto-style36" colspan="2">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <asp:TextBox ID="grupo_proceso" runat="server" Width="122px" CssClass="TextBox" Enabled="False"></asp:TextBox>
                            &nbsp;&nbsp;<asp:DropDownList ID="mePeriodo" runat="server" AutoPostBack="True" OnSelectedIndexChanged="mePeriodo_SelectedIndexChanged" CssClass="ComboBox2">
                            </asp:DropDownList>
                            &nbsp;&nbsp;<asp:DropDownList ID="cb_agno" runat="server" AutoPostBack="True" CssClass="auto-style49" Height="19px" OnSelectedIndexChanged="mePeriodo_SelectedIndexChanged" Width="78px">
                            </asp:DropDownList>
                            &nbsp;&nbsp;
                            <asp:Label runat="server" Text="Tipo Proceso"></asp:Label>
                             <asp:DropDownList ID="ddTproceso" runat="server" Height="16px" Width="250px" CssClass="ComboBox2">
                    </asp:DropDownList>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                <td class="auto-style36"></td>
            </tr>
            
            <tr>
                <td class="auto-style31">Fecha Proceso:</td>
                <td class="auto-style8">
                     <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                         <ContentTemplate>
                             <asp:TextBox ID="fechaPro" runat="server" ReadOnly="false" CssClass="TextBox3" Enabled="False"></asp:TextBox>
                             &nbsp;<asp:Image ID="Image1" runat="server" onclick="openCalendar('ctl00_ContentPlaceHolder1_fechaPro');" ImageUrl="~/Imagenes/calendario.gif" />
                             &nbsp;&nbsp;<asp:RequiredFieldValidator ID="rfvFecha" runat="server" ControlToValidate="fechaPro" ErrorMessage="*"></asp:RequiredFieldValidator>
                         </ContentTemplate>
                     </asp:UpdatePanel>
                </td>
                <td class="auto-style8" colspan="2">
                </td>
            </tr>
            <tr>
                <td class="auto-style45">Nombre Archivo:</td>
                <td class="auto-style46">
                    <asp:TextBox ID="nomArch" runat="server" Width="252px" CssClass="TextBox4"></asp:TextBox>
                    &nbsp;
                    </td>
                <td colspan="2" class="auto-style46">
                </td>
            </tr>
            <tr>
                <td class="auto-style22"></td>
                <td colspan="2" class="auto-style47">
                    <asp:Button ID="Button1" runat="server" Text="Recepcionar" OnClick="recepcionar_archivo" CssClass="botonnew" />
                &nbsp;</td>
                <td class="auto-style47"></td>
            </tr>
            <tr>
                <td class="auto-style42"></td>
                <td colspan="2" class="auto-style43">
                    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    </asp:UpdateProgress>
                </td>
                <td class="auto-style43"></td>
            </tr>
            <tr>
                <td class="auto-style14">Detalle Recepción:</td>
                <td class="auto-style5">
                    <asp:Button ID="btn_mostrar_detalle" runat="server" Text="Mostrar/Ocultar Detalle" OnClick="mostrar_detalle" CssClass="botonnew" style="vertical-align:bottom;"/>
                    &nbsp;
                    &nbsp;<asp:Label ID="error" runat="server" ForeColor="#990000"></asp:Label>
                    &nbsp;&nbsp;&nbsp;<asp:Label ID="txt_resultados" runat="server" Font-Names="Calibri"></asp:Label>
                    &nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <br />
                    <br />
                    <asp:Label ID="lb_proceso" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Overline="False" Font-Size="Medium" Font-Strikeout="False" Font-Underline="False" vertical-align="text-top" Height="25px" Visible="False">Proceso: </asp:Label>
                    <br />
                    <asp:GridView ID="gvProceso" runat="server" AutoGenerateColumns="False" CellPadding="4" CssClass="GridAlternativeItems" EnableModelValidation="True" ForeColor="#333333" Height="16px" OnPageIndexChanging="gvProceso_PageIndexChanging" OnRowCommand="gvProceso_RowCommand" Visible="False" Width="860px">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="NOMBRE_ARCHIVO" HeaderText="Archivo">
                            <ControlStyle Width="40%" />
                            <HeaderStyle ForeColor="White" Width="40%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DESCRIPCION" HeaderText="Descripción">
                            <ControlStyle Width="20%" />
                            <HeaderStyle ForeColor="White" Width="25%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DUPLICADOS" HeaderText="Duplicados">
                            <ControlStyle Width="10%" />
                            <HeaderStyle ForeColor="White" Width="8%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ERRORES" HeaderText="Errores">
                            <ControlStyle Width="10%" />
                            <HeaderStyle ForeColor="White" Width="6%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CARGADOS" HeaderText="Cargados">
                            <ControlStyle Width="10%" />
                            <HeaderStyle ForeColor="White" Width="6%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ESTADO" HeaderText="Estado">
                            <ControlStyle Width="10%" />
                            <HeaderStyle ForeColor="White" Width="15%" />
                            </asp:BoundField>
                        </Columns>
                        <EditRowStyle BackColor="#2461BF" />
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#2461BF" BorderStyle="Dotted" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EFF3FB" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    </asp:GridView>
                    <br />
                    <asp:Label ID="lb_proceso0" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Overline="False" Font-Size="Medium" Font-Strikeout="False" Font-Underline="False" vertical-align="text-top" Height="25px" Visible="False">Detalle:</asp:Label>
                    <br />
                    <asp:GridView ID="gvDetalle" runat="server" AutoGenerateColumns="False" CellPadding="4" CssClass="GridAlternativeItems" EnableModelValidation="True" ForeColor="#333333" Height="16px" OnPageIndexChanging="gvProceso_PageIndexChanging" OnRowCommand="gvProceso_RowCommand" Visible="False" Width="860px" PageSize="20">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="NRO" HeaderText="#">
                            <HeaderStyle Width="3%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NUM_ORDEN" HeaderText="NRO ORDEN">
                            <HeaderStyle ForeColor="White" Width="15%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SERVICIO" HeaderText="ID SERVICIO">
                            <HeaderStyle ForeColor="White" Width="15%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="MENSAJE_ERROR" HeaderText="MENSAJE DE ERROR">
                            <HeaderStyle ForeColor="White" Width="67%" />
                            </asp:BoundField>
                        </Columns>
                        <EditRowStyle BackColor="#2461BF" />
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#993333" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#2461BF" BorderStyle="Dotted" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EFF3FB" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    </asp:GridView>
                    <br />
                    <br />
                </td>
                <td class="auto-style5" colspan="2">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style37" colspan="4">
                    &nbsp;</td>
            </tr>
        </table>
    
</asp:Content>

