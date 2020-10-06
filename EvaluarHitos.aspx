<%@ Page Title="Evaluación de hitos" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="EvaluarHitos.aspx.cs" Inherits="EvaluarHitos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src=" https://unpkg.com/sweetalert/dist/sweetalert.min.js "></script>

    <style type="text/css">
        .dropdown {
            border-radius: 15px;
        }

        .estiloTD {
            height: 12px;
        }

        .auto-style7 {
            height: 43px;
        }

        .auto-style15 {
        }

        .auto-style24 {
            height: 7px;
            text-align: right;
        }

        .auto-style39 {
            height: 12px;
        }

        .auto-style40 {
            height: 20px;
        }

        #IMG3 {
            height: 38px;
            width: 42px;
        }

        #IMG4 {
            height: 21px;
            width: 22px;
        }

        #IMG5 {
            height: 21px;
            width: 22px;
        }

        #IMG6 {
            height: 21px;
            width: 22px;
        }

        .auto-style43 {
            height: 12px;
        }

        #IMG8 {
            margin-top: 0px;
        }

        .styletd {
            text-align: right;
            width: 320px;
        }

        .label {
            font-size: 10px;
        }
        .auto-style84 {
            text-align: right;
        }
    </style>

    <script type="text/javascript">

        function popInspector(obj) {
            var url = 'popAsistente.aspx?textbox=' + obj;
            window.open(url, 'cal', 'width=820,height=320,left=200,top=50,resizable=0,scrollbars=yes');
        }

        function openCalendar(obj) {
            var url = 'calendario2.aspx?textbox=' + obj;
            window.open(url, 'cal', 'width=260,height=210,left=410 410,top=330,resizable=0,scrollbars=0');
        }

        function cambio_actividades(actividades_as, actividades_des) {
            swal("Cambios efectuados ", "Se evaluaron : " + actividades_as + " actividad(es)\nSe volvieron a no evaluadas: " + actividades_des + " actividad(es)", "success");
        }

        function Selecione() {
            swal("¡ERROR! ", "No seleccionó actividades", "warning");
        }

        function Error() {
            swal("¡ERROR! ", "Error BD", "warning");
        }

        function archivo() {
            swal("¡ERROR! ", "No hay archivo", "warning");
        }

    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1 class="WebPartTitle">EVALUAR HITOS<asp:Label ID="lb_rut_empresa" runat="server" Visible="False"></asp:Label></h1>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table>

                <!-- FILA NRO 1 -->
                <tr>
                    <!-- CAMPAÑA  -->
                    <td class="auto-style84">
                        <asp:Label ID="Label2" runat="server" class="label" Text="CAMPAÑA:"></asp:Label>
                        <asp:DropDownList ID="ddCampaña" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddCampaña_SelectedIndexChanged" Width="195px"></asp:DropDownList>
                        <td>
                         <asp:Button ID="Button1" runat="server" CssClass="botonnew" Height="20px" OnClick="Button1_Click1" Text="Filtrar" Width="100px" />
                        </td>
                    </td>
                    <td class="styletd">
                    </td>
                    <!-- -->

                    <tr>        
                        <td class="auto-style43" colspan="11">
                            <asp:Label ID="lbTotal" runat="server"></asp:Label>
                            <asp:Label ID="lbErrorGrilla" runat="server"></asp:Label>
                        </td>
                        <td class="auto-style39"></td>
                    </tr>
                    <!--  -->
                    <tr>
                        <td class="auto-style7" colspan="12">
                            <asp:Panel ID="panGrid" runat="server" Height="326px" HorizontalAlign="Center" ScrollBars="Auto" Width="1315px">
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                    <ContentTemplate>
                                        <asp:GridView ID="gridOrden" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" CssClass="GridAlternativeItems" EnableModelValidation="True" ForeColor="#333333" Height="100px" OnPageIndexChanging="gridOrden_PageIndexChanging" OnRowCommand="gridOrden_RowCommand" OnRowCreated="gridOrden_RowCreated" OnSelectedIndexChanged="gridOrden_SelectedIndexChanged" PageSize="40" Width="1200px">
                                            <AlternatingRowStyle BackColor="White" />
                                            <Columns>
                                                <asp:BoundField DataField="ID_HITO"  HeaderText="ID HITO">
                                                <HeaderStyle ForeColor="White"  />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="ID_ACTIVIDAD" HeaderText="ID ACTVIDAD">
                                                <HeaderStyle ForeColor="White" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="ESTADO" HeaderText="ESTADO">
                                                <HeaderStyle ForeColor="White" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="NOMBRE_HITO" HeaderText="NOMBRE HITO">
                                                <HeaderStyle ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Left" Width="150px" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="NOMBRE_ACTIVIDAD" HeaderText="NOMBRE ACTIVIDAD">
                                                <HeaderStyle ForeColor="White" Width="500px" />
                                                <ItemStyle HorizontalAlign="Left" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="FECHA_EVALUACION" HeaderText="FECHA DE EVALUACION">
                                                <HeaderStyle ForeColor="White" Width="100px" />
                                                <ItemStyle Width="10px" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="FECHA_CAMBIO" HeaderText="FECHA DE CAMBIO">
                                                <HeaderStyle ForeColor="White" Width="100px" />
                                                <ItemStyle Width="10px" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="ESTADO_EVALUACION" HeaderText="ESTADO DE EVALUACION">
                                                <HeaderStyle ForeColor="White" />
                                                <ItemStyle Width="10px" />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="Asignar">
                                                    <HeaderTemplate>
                                                        <asp:LinkButton ID="lkbAsignar" runat="server" CommandName="asignar" ForeColor="White">REALIZADO</asp:LinkButton>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="check_asigna" runat="server" />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" Width="50px" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Desasignar">
                                                    <HeaderTemplate>
                                                        <asp:LinkButton ID="lkbDesasignar" runat="server" CommandName="desasignar" ForeColor="White">NO REALIZADO</asp:LinkButton>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chk_des" runat="server" />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                                                    <HeaderStyle ForeColor="White" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="SUBIR ARCHIVOS">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="SUBIR" runat="server" CommandArgument="<%# Container.DataItemIndex%>" CommandName="subir" Height="20px" src="Imagenes/up.png" Width="20px" />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" Width="50px" />
                                                    <HeaderStyle ForeColor="White" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="INGRESAR OBSERVACION">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="text_obs" runat="server" CommandArgument="<%# Container.DataItemIndex%>" CommandName="text_obs" Height="20px" src="Imagenes/icono_obs.png" Width="20px" />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" Width="50px" />
                                                    <HeaderStyle ForeColor="White" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="DESCARGAR INFORME">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="informe" runat="server" CommandArgument="<%# Container.DataItemIndex%>" CommandName="informe" Height="20px" src="Imagenes/icono_pdf.png" Width="20px" />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" Width="50px" />
                                                    <HeaderStyle ForeColor="White" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="DOC 1 PDF">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="pdf1" runat="server" CommandArgument="<%# Container.DataItemIndex%>" CommandName="DOC1" Height="20px" src="Imagenes/icono_pdf.png" Width="20px" />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" Width="50px" />
                                                    <HeaderStyle ForeColor="White" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="DOC 2 PDF">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="pdf2" runat="server" CommandArgument="<%# Container.DataItemIndex%>" CommandName="DOC2" Height="20px" src="Imagenes/icono_pdf.png" Width="20px" />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" Width="50px" />
                                                    <HeaderStyle ForeColor="White" />
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="OBSERVACION" HeaderText="OBSERVACION">
                                                <HeaderStyle ForeColor="White" />
                                                <ItemStyle Width="200px" />
                                                </asp:BoundField>
                                                <%-- <asp:BoundField DataField="id_sincronizacion" HeaderText="id_sincronizacion" Visible="False" />
                                            <asp:BoundField DataField="id_sincronizacion_social_int" HeaderText="id_sincronizacion_social_int" Visible="true" />--%>
                                            </Columns>
                                            <EditRowStyle BackColor="#2461BF" />
                                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Width="150px" />
                                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                            <RowStyle BackColor="#EFF3FB" />
                                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="False" ForeColor="#333333" />
                                        </asp:GridView>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </asp:Panel>
                        </td>
                    </tr>
                    <!-- -->
                    <tr>
                        <td class="auto-style40" colspan="12">
                            <img src="Imagenes/ok.bmp" runat="server" id="IMG2" />
                            <img src="Imagenes/cross2.bmp" runat="server" id="IMG5" />
                            <img src="Imagenes/warning.bmp" runat="server" id="IMG6" />
                            &nbsp;
                            <asp:Label ID="lbResultado" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style15" colspan="10">
                            <asp:Button ID="btnAsignar" runat="server" CssClass="botonnew" Height="24px" OnClick="ACEPTAR" Text="ACEPTAR" />
                        </td>
                        <td class="auto-style24" colspan="2">&nbsp;</td>
                    </tr>
                </tr>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

