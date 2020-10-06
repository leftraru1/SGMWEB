<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="Anexar_Ordenes.aspx.cs" Inherits="Anexar_Ordenes" %>

<%--<script runat="server">

    protected void recepcionar_archivo(object sender, EventArgs e)
    {

    }
</script>--%>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style5
        {
        }
        .auto-style14
        {
            
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
                
        .auto-style37
        {
            height: 9px;
            text-align: right;
        }
        .auto-style40
        {
            height: 12px;
            vertical-align: top;
            padding-bottom: 10px;
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
        
        .auto-style47
        {
            height: 23px;
        }
        
        .td {
            height: 12px;
            text-align: left;
            width: 139px;
            

        }
        .label {
            text-align:left;

        }

        
        .auto-style49 {
            height: 21px;
        }

        
        </style>
    <script type="text/javascript">

        function openCalendar(obj) {
            var url = 'calendario2.aspx?textbox=' + obj;
            window.open(url, 'cal', 'width=260,height=210,left=410 410,top=330,resizable=0,scrollbars=0');
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
            <h1 class="WebPartTitle">Anexar Ordenes a Proceso</h1>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            
        <table style="width:89%; height: 308px;">
           
          <tr>
             <td> <asp:Label ID="Label2" runat="server" Text="TipoProceso:"></asp:Label></td>
             <td><asp:DropDownList ID="ddTproceso" runat="server" Height="16px" Width="250px"  CssClass="ComboBox2"  AutoPostBack="True" OnSelectedIndexChanged="ddTproceso_SelectedIndexChanged"  >
                            </asp:DropDownList></td>
                            &nbsp;&nbsp;&nbsp;&nbsp;
            </tr> 
            <tr>
               <td class="auto-style49"><asp:Label ID="idproceso" runat="server" Text="Proceso:" CssClass="Label" Visible="false" ></asp:Label></td>
                <td class="auto-style49"><asp:DropDownList ID="ddprocesos" runat="server"  Width="250px" Height="16px" CssClass="ComboBox2" Visible="false" >             
                    </asp:DropDownList></td> 
                        
                </tr>
            <tr>
                <td>  <asp:Label ID="lbcargaarchivo" runat="server" Text="Cargar Archivo:" Visible="false"></asp:Label>
                    </td>
                <td class="auto-style40">&nbsp;<asp:FileUpload ID="fuArchivo" runat="server" BorderStyle="None" Width="327px" CssClass="Button" Visible="false" />
                    <asp:TextBox ID="nuArchivo" runat="server" Width="38px" Visible="False" OnTextChanged="nuArchivo_TextChanged" ></asp:TextBox>
                    <br />
                    </td>
            </tr>
            <tr>
                <td class="auto-style17" colspan="2">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            &nbsp;&nbsp;
                        </ContentTemplate>
                    </asp:UpdatePanel>
              
               
                </td>
                <td class="auto-style17"></td>
            </tr>
            <tr>
                <td class="auto-style17">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style22"></td>
                <td colspan="2" class="auto-style47">
                    <asp:Button ID="Btnanexar" runat="server" Text="Anexar" OnClick="anexar_archivo" CssClass="botonnew" />
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
                    &nbsp;<asp:Label ID="error" runat="server" ForeColor="#990000" font-size='16px'  ></asp:Label>
                    &nbsp;<asp:Label ID="anexar" runat="server" ForeColor="#419E52" font-size='16px'></asp:Label>
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

