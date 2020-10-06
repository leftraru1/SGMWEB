<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="ReporteRecepcion.aspx.cs" Inherits="RecepcionLecturas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style5
        {
        }
        .auto-style14
        {
            height: 12px;
            text-align: right;
            width: 92px;
        }
        .auto-style17
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
                
        .auto-style48
        {
            height: 12px;
            vertical-align: top;
            width: 639px;
        }
        
        .auto-style49
        {
            height: 7px;
            text-align: right;
            width: 92px;
        }
        
        .auto-style50
        {
            height: 12px;
        }
        .auto-style51
        {
            height: 14px;
            text-align: right;
            width: 92px;
        }
        .auto-style52
        {
            height: 14px;
        }
        
        .auto-style53
        {
            height: 12px;
            width: 425px;
        }
        .auto-style55
        {
            height: 12px;
            width: 1402px;
        }
        .auto-style57
        {
            height: 12px;
            width: 1160px;
        }
        .auto-style58
        {
            height: 14px;
            width: 1160px;
        }
                
        .auto-style62
        {
            height: 21px;
            text-align: right;
            width: 92px;
        }
        .auto-style63
        {
            height: 21px;
        }
        
        .auto-style64
        {
            height: 12px;
            width: 10px;
        }
        .auto-style65
        {
            height: 14px;
            width: 10px;
        }
        
        .auto-style66 {
            height: 12px;
            vertical-align: top;
            width: 312px;
        }
        
        .auto-style67 {
            width: 92px;
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
            <h1 class="WebPartTitle">Reporte - Registro de Recepción</h1>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            
        <table style="width:89%; height: auto;">
            <tr>
               
                <td class="auto-style67"></td>
               
                <td class="auto-style66">Fecha desde:</td>
               
                <td>Fecha hasta:</td>
                <td class="auto-style48">&nbsp;</td>
                <td class="auto-style40" colspan="2">&nbsp;</td>
                <td class="auto-style40" colspan="2">&nbsp;</td>
                <td></td>
                <td></td>
            </tr>
            <tr>
            
                <td class="auto-style67"></td>
            
                <td class="auto-style66"><asp:TextBox ID="txt_fecha_desde" runat="server" ReadOnly="false" CssClass="TextBox3" Width="100px"></asp:TextBox>
                             &nbsp;<asp:Image ID="Image1" runat="server" onclick="openCalendar('ctl00_ContentPlaceHolder1_txt_fecha_desde');" ImageUrl="~/Imagenes/calendario.gif" />
                             &nbsp;<asp:RequiredFieldValidator ID="rfvFecha" runat="server" ControlToValidate="txt_fecha_desde" ErrorMessage="*"></asp:RequiredFieldValidator>
                    <br />
                    </td>
               
                <td class="auto-style40">
                             <asp:TextBox ID="txt_fecha_hasta" runat="server" ReadOnly="false" CssClass="TextBox3" Width="100px"></asp:TextBox>
                             &nbsp;<asp:Image ID="Image2" runat="server" onclick="openCalendar('ctl00_ContentPlaceHolder1_txt_fecha_hasta');" ImageUrl="~/Imagenes/calendario.gif" />
                             &nbsp;<asp:RequiredFieldValidator ID="rfvFecha0" runat="server" ControlToValidate="txt_fecha_hasta" ErrorMessage="*"></asp:RequiredFieldValidator>
                             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btn_buscar" runat="server" Text="Buscar" OnClick="buscar_procesos" CssClass="botonnew" Width="100px" />
                    </td>
                <td class="auto-style48">
                    &nbsp;</td>
                <td class="auto-style40" colspan="2">
                             &nbsp;&nbsp;</td>
                <td class="auto-style40" colspan="2">
                    </td>
                <td class="auto-style50"></td>
                <td class="auto-style50"></td>
            </tr>
            <tr>
                <td class="auto-style49"></td>
                <td class="auto-style17" colspan="8"> 
                    <asp:Label ID="lb_error" runat="server" ForeColor="#CC0000"></asp:Label>
                </td>
                <td class="auto-style17"></td>
            </tr>
            <tr>
                <td class="auto-style14"></td>
                <td class="auto-style53" >
                    <asp:Label ID="lb1" runat="server" Width="60px">Proceso: </asp:Label>
                &nbsp; <asp:Label ID="txt_proceso" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium"></asp:Label>
                </td>
                <td class="auto-style55" >
                    <asp:Label ID="lb2" runat="server" Width="60px">Grupo:</asp:Label>
                    <asp:Label ID="txt_grupo" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium"></asp:Label>
                    </td>
                <td class="auto-style57" >
                    <asp:Label ID="lb4" runat="server" Width="60px">Fecha: </asp:Label>
                    <asp:Label ID="txt_fecha" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium"></asp:Label>
                    </td>
                <td class="auto-style50" >
                    </td>
                <td class="auto-style64">
                    </td>
                <td class="auto-style50">
                    </td>
                <td class="auto-style50" colspan="2">
                    </td>
            </tr>
            <tr>
                <td class="auto-style51"></td>
                <td class="auto-style52" colspan="2" >
                    <asp:Label ID="lb3" runat="server" Width="60px">Tipo: </asp:Label>
                    &nbsp; <asp:Label ID="txt_tipo" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium"></asp:Label>
                </td>
                <td class="auto-style58">
                </td>
                <td class="auto-style52" >
                    </td>
                <td class="auto-style65">
                    </td>
                <td class="auto-style52">
                    </td>
                <td class="auto-style52" colspan="2">
                    </td>
            </tr>
            <tr>
                <td class="auto-style14"></td>
                <td class="auto-style50" colspan="7">
                    </td>
                <td class="auto-style50" colspan="2">
                    </td>
            </tr>
            <tr>
                <td class="auto-style14">&nbsp;</td>
                <td class="auto-style50" colspan="7">
                    <asp:Panel ID="Panel5" runat="server" Height="800px" ScrollBars="Auto" Width="1000px">
                        <asp:Label ID="lb_registros" runat="server" Font-Names="Calibri"></asp:Label>
                        <br />
                        <asp:Label ID="lb_procesos" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" Text="PROCESOS: "></asp:Label>
                        <br />
                        <asp:GridView ID="gvProceso" runat="server" AutoGenerateColumns="False" CellPadding="4" CssClass="GridAlternativeItems" EnableModelValidation="True" ForeColor="#333333" Height="16px" OnPageIndexChanging="gvProceso_PageIndexChanging" OnRowCommand="gvProceso_RowCommand" OnSelectedIndexChanged="gvProceso_SelectedIndexChanged" Visible="False" Width="970px">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="#" HeaderText="#">
                                <HeaderStyle ForeColor="White" Width="3%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ID_PROCESO" HeaderText="PROCESO">
                                <ControlStyle Width="5%" />
                                <HeaderStyle ForeColor="White" Width="7%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="NOM_ARCHIVO" HeaderText="ARCHIVO">
                                <ControlStyle Width="35%" />
                                <HeaderStyle ForeColor="White" Width="27%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="REGION" HeaderText="REGION" >
                                <ControlStyle Width="10%" />
                                <HeaderStyle ForeColor="White" Width="18%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="FECHA" HeaderText="FECHA"  >
                                <ControlStyle Width="10%" />
                                <HeaderStyle ForeColor="White" Width="10%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="DUPLICADOS" HeaderText="DUPLICADOS">
                                <ControlStyle Width="10%" />
                                <HeaderStyle ForeColor="White" Width="10%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ERRORES" HeaderText="ERRORES">
                                <ControlStyle Width="10%" />
                                <HeaderStyle ForeColor="White" Width="8%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="CARGADOS" HeaderText="CARGADOS">
                                <ControlStyle Width="10%" />
                                <HeaderStyle ForeColor="White" Width="8%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ESTADO" HeaderText="ESTADO">
                                <ControlStyle Width="7%" />
                                <HeaderStyle ForeColor="White" Width="8%" />
                                </asp:BoundField>
                                <asp:CommandField ButtonType="Image" HeaderText="VER DETALLE" SelectImageUrl="~/Imagenes/lupa.bmp" ShowSelectButton="True">
                                <HeaderStyle ForeColor="White" Width="6%" />
                                <ItemStyle HorizontalAlign="Center" />
                                </asp:CommandField>
                            </Columns>
                            <EditRowStyle BackColor="#2461BF" />
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#2461BF" BorderStyle="Dotted" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#EFF3FB" />
                            <SelectedRowStyle BackColor="#CCFFFF" Font-Bold="True" ForeColor="#000066" />
                        </asp:GridView>
                        <br />
                        <br />
                        <asp:Label ID="lb_registros2" runat="server" Font-Names="Calibri"></asp:Label>
                        <br />
                        <asp:Label ID="lb_detalle" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" Text="DETALLE:"></asp:Label>
                        <br />
                        <asp:GridView ID="gvDetalle" runat="server" AutoGenerateColumns="False" CellPadding="4" CssClass="GridAlternativeItems" EnableModelValidation="True" ForeColor="#333333" Height="81px" OnPageIndexChanging="gvProceso_PageIndexChanging" OnRowCommand="gvProceso_RowCommand" OnSelectedIndexChanged="gvProceso_SelectedIndexChanged" Visible="False" Width="970px">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="#" HeaderText="#">
                                <HeaderStyle ForeColor="White" Width="5%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="NRO_ORDEN" HeaderText="NRO ORDEN">
                                <ControlStyle Width="40%" />
                                <HeaderStyle ForeColor="White" Width="10%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="SERVICIO" HeaderText="SERVICIO">
                                <ControlStyle Width="20%" />
                                <HeaderStyle ForeColor="White" Width="10%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="MENSAJE_ERROR" HeaderText="MENSAJE DE ERROR">
                                <ControlStyle Width="10%" />
                                <HeaderStyle ForeColor="White" Width="75%" />
                                </asp:BoundField>
                            </Columns>
                            <EditRowStyle BackColor="#2461BF" />
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#993333" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#2461BF" BorderStyle="Dotted" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#EFF3FB" />
                            <SelectedRowStyle BackColor="#CCFFFF" Font-Bold="True" ForeColor="#000066" />
                        </asp:GridView>
                    </asp:Panel>
                    </td>
                <td class="auto-style50" colspan="2">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style14">&nbsp;</td>
                <td class="auto-style5" colspan="7">
                            &nbsp;</td>
                <td class="auto-style5" colspan="2">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style62"></td>
                <td class="auto-style63" colspan="2">
                    </td>
            </tr>
            <tr>
                <td class="auto-style37" colspan="10">
                    &nbsp;</td>
            </tr>
        </table>
    
</asp:Content>

