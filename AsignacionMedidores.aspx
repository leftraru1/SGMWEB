<%@ Page Title="Asignación de Medidores" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="AsignacionMedidores.aspx.cs" Inherits="AsignacionMedidores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

        <script src = " https://unpkg.com/sweetalert/dist/sweetalert.min.js "></script> 

        <script type="text/javascript">

            function popInstalador(obj) {
                var url = 'popInstalador.aspx?textbox=' + obj;
                window.open(url, 'cal', 'width=820,height=320,left=200,top=50,resizable=0,scrollbars=yes');
            }
            function openCalendar(obj) {
                var url = 'calendario2.aspx?textbox=' + obj;
                window.open(url, 'cal', 'width=260,height=210,left=410 410,top=330,resizable=0,scrollbars=0');
            }
            function cambio_ordenes(medidores) {
                swal("Cambios efectuados ", "Se asignaron : " + medidores + "", "success");
            }
            function cambio_ordenes_desasigna(medidores) {
                swal("Cambios efectuados ", "Se desasignaron : " + medidores + "", "success");
            }
            function Seleccione() {
                swal("¡ERROR! ", "No seleccionó medidores", "warning");
            }
            function Selecione_instalador() {
                swal("¡ERROR! ", "No seleccionó instalador", "warning");
            }
            function instalador_no_valido() {
                swal("¡ERROR! ", "El inspector no existe", "warning");
            }

            function Error(mensaje) {
                swal("¡ERROR! ", ""+mensaje+"", "warning");
            }

            function advertencia(mensaje) {
                swal("¡ADVERTENCIA! ", "" + mensaje + "", "warning");
            }
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1 class="WebPartTitle">Asignación de Medidores</h1>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            
            <table id="tablaAsig" style="padding-bottom:10px;" >
                
                <tr>
                    
                    <td class="td">
                        <asp:Label ID="Label14" runat="server" Text="Region destino:"></asp:Label>
                    </td>
                    <td class="">
                        <asp:DropDownList ID="ddregion" runat="server" Width="100px" CssClass="ComboBox" AutoPostBack="True" OnSelectedIndexChanged="ddregion_SelectedIndexChanged" ></asp:DropDownList>
                    </td>
                    <td class="">
                        <asp:Label ID="Label20" runat="server" Text="Bodega contratista:"></asp:Label>
                    </td>
                    <td class="">
                        <asp:DropDownList ID="ddbodegas" runat="server" Width="180px" CssClass="ComboBox" AutoPostBack="True" OnSelectedIndexChanged="ddbodegas_SelectedIndexChanged" ></asp:DropDownList>
                    </td>
                    <td class="">
                        <asp:Label ID="Label18" runat="server" Text="Contratista :"></asp:Label>
                    </td>
                    <td class="">
                        <asp:DropDownList ID="ddcontratista" runat="server"   Width="100px" CssClass="ComboBox" AutoPostBack="True" OnSelectedIndexChanged="ddcontratista_SelectedIndexChanged" ></asp:DropDownList>
                    </td>
                    <td class="auto-style92">
                        <asp:Label ID="Label21" runat="server" Text="Diametro :"></asp:Label>
                        <asp:DropDownList ID="dddiametro" runat="server" Width="100px" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="dddiametro_SelectedIndexChanged" ></asp:DropDownList>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                          <asp:Label ID="Label1" runat="server" Text="Estado medidor:"></asp:Label>    
                    </td>
                    <td>
                        <asp:DropDownList ID="ddestado" runat="server" Width="100px" CssClass="ComboBox" AutoPostBack="True" OnSelectedIndexChanged="ddestado_SelectedIndexChanged" ></asp:DropDownList>
                    </td>
                    <td>
                          <asp:Label ID="Label2" runat="server" Text="N° Guía:"></asp:Label>    
                    </td>
                    <td>
                        <asp:DropDownList ID="ddguia" runat="server" Width="100px" CssClass="ComboBox" AutoPostBack="True" OnSelectedIndexChanged="ddguia_SelectedIndexChanged" ></asp:DropDownList>
                    </td>
                    <td>
                          <asp:Label ID="Label3" runat="server" Text="Serie desde:"></asp:Label>    
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="serie_desde" AutoPostBack="true" CssClass="ComboBox" OnTextChanged="serie_desde_TextChanged" Width="100px"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="serie_desde" ErrorMessage="Solo numeros" ForeColor="Red" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
                    </td>
                    <td>
                        <asp:Label ID="Label4" runat="server" Text="Serie hasta:"></asp:Label>    
                        <asp:TextBox runat="server" ID="serie_hasta" AutoPostBack="true" CssClass="ComboBox"  OnTextChanged="serie_hasta_TextChanged" Width="100px"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="serie_hasta" ErrorMessage="Solo numeros" ForeColor="Red" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                </tr>
                <tr>
                    <td>Instalador:</td>
                    <td colspan="3">
                        <asp:DropDownList ID="ddInstalador" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddInstalador_SelectedIndexChanged" Width="300px">
                        </asp:DropDownList>
                    </td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
                        <table id="Table2" runat="server" >
                            <tr>
                                <td style="width: 462px" colspan="2">
                                    <asp:Label ID="lbResultado" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td style="width: 462px" colspan="2">Cód. Instalador:
                                    <asp:TextBox ID="txtInstalador" runat="server" CssClass="TextBox2"></asp:TextBox>
                                    <img src="Imagenes/lupa.bmp" onclick="popInstalador('ctl00_ContentPlaceHolder1_txtInstalador');"  id="IMG1" />
                                    &nbsp;&nbsp; <%--<img src="/ESSBIO_MED/Imagenes/warning.bmp" runat="server"  id="IMG4" />&nbsp;--%>
                                    <asp:Label ID="lbTxtIn" runat="server"></asp:Label>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtInstalador" ErrorMessage="Solo números para código de instalador." ValidationExpression="^([0-9]{1,10})$"></asp:RegularExpressionValidator>
                                    <asp:Button ID="btnAsignar" runat="server" CssClass="botonnew" Height="20px" OnClick="btnAsignar_Click" Text="Asignar Medidor(es)" />
                                    &nbsp;&nbsp;&nbsp;
                                    <asp:Button ID="btnDesAsignar" runat="server" CssClass="botonnew" Height="20px" OnClick="btnDesAsignar_Click" Text="Desasignar Medidor(es)" Width="141px" />
                                
                                </td>
                                <td style="height:50px">

                                    </td>
                            </tr>
                            <tr>
                                <td style="width:462px;">
                                    <asp:Label ID="lbTotal" runat="server"></asp:Label>
                                    <asp:Label ID="lbErrorGrilla" runat="server"></asp:Label>
                                </td>
                                <td style="width:462px;">
                                    <asp:TextBox ID="txt_stock_minimo" Visible="false" runat="server" BackColor="#FF6600" BorderColor="White" Width="250px" ReadOnly="true" CssClass="TextBox" Font-Bold="True" ForeColor="White">STOCK EN ESTADO ADVERTENCIA</asp:TextBox>
                                </td>
                            </tr>
                    </td>
                </tr>   
                <tr>    
                    <td style="width: 462px" colspan="2">
                        <asp:Panel ID="panGrid" runat="server" Height="326px" HorizontalAlign="Center" ScrollBars="auto"  Width="1050px">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="gridOrden" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" CssClass="GridAlternativeItems" EnableModelValidation="True" ForeColor="#333333" Height="100px" OnPageIndexChanging="gridOrden_PageIndexChanging" OnRowCommand="gridOrden_RowCommand" OnRowDataBound="gridOrden_RowDataBound" PageSize="1000" Width="1000px">
                                        <AlternatingRowStyle BackColor="White" />
                                        <Columns>

                                            <asp:BoundField DataField="ID_MEDIDOR" HeaderText="id_medidor" Visible = "false">
                                            <HeaderStyle ForeColor="White" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="ID_GUIA" HeaderText="id_guia"  Visible = "false">
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="ID_ESTADO_MEDIDOR" HeaderText=" id_estado"  Visible = "false">
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="ID_CONTRATISTA" HeaderText="id_contratista"  Visible = "false" >
                                                <HeaderStyle ForeColor="White" />
                                                <ItemStyle Font-Size="Smaller"  />
                                            </asp:BoundField>

                                           <asp:BoundField DataField="ID_ORDEN" HeaderText="id_orden"  Visible = "false" >
                                                <HeaderStyle ForeColor="White" />
                                                <ItemStyle Font-Size="Smaller" Width="60px" />
                                            </asp:BoundField>
                                           
                                            <asp:BoundField DataField="ID_INSPECTOR" HeaderText="id_inspector"  Visible = "false" >
                                                <HeaderStyle ForeColor="White" />
                                                <ItemStyle Font-Size="Smaller" Width="70px" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="ID_REGION" HeaderText="id_region"  Visible = "false">
                                                <HeaderStyle ForeColor="White" />
                                                <ItemStyle Font-Size="Smaller" width="50px"  />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="NUMERO_GUIA" HeaderText="Numero guía"  >
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" width="50px"  />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="CONTRATISTA" HeaderText="Contratista" >
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" width="50px"  />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="MODELO" HeaderText="Modelo">
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="CODIGO" HeaderText="Codigo">
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="SERIE" HeaderText="Serie">
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="ANO" HeaderText="Año" >
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle  Font-Size="Smaller"   />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="DIAMETRO" HeaderText="Diametro" >
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="INSTALADOR" HeaderText="Instalador" >
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="ESTADO" HeaderText="Estado" >
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:TemplateField HeaderText="ASIGNAR TODO">
                                                <HeaderTemplate>
                                                    <asp:LinkButton ID="lkbAsignar" runat="server" CommandName="asignar" OnClick="lkbAsignar_Click">ASIGNAR TODO</asp:LinkButton>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="check_asigna" runat="server" />
                                                </ItemTemplate>
                                                <HeaderStyle ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="DESASIGNAR TODO">
                                                <HeaderTemplate>
                                                    <asp:LinkButton ID="lkbDesasignar" runat="server" CommandName="desasignar">DESASIGNAR TODO</asp:LinkButton>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chk_des" runat="server" />
                                                </ItemTemplate>
                                                <HeaderStyle ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                                            </asp:TemplateField>
                                            
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
                    </table>
        </ContentTemplate>
    </asp:UpdatePanel>

    </asp:Content>

