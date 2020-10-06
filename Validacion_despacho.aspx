<%@ Page Title="Valicación Recepción" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="Validacion_despacho.aspx.cs" Inherits="Validacion_despacho" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

        <script src = "https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> 

        <script type="text/javascript">

            if (history.forward(1)) {
                history.replace(history.forward(1));
            }

            function error(mensaje) {
                swal("¡ERROR! ", ""+mensaje+"", "warning");
            }

            function pendiente(mensaje) {
                swal("¡GUIA EN ESTADO PENDIENTE! ", "" + mensaje + "", "warning");
            }

            function correcto(mensaje) {
                swal("¡CORRECTO! ", "" + mensaje + "", "success");
            }

            function openCalendar(obj) {
                var url = 'calendario2.aspx?textbox=' + obj;
                window.open(url, 'cal', 'width=260,height=210,left=410 410,top=330,resizable=0,scrollbars=0');
            }

        </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1 class="WebPartTitle">Validación despachos</h1>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table id="filtrovalidacion" class="filtro" style="height: 20px; width: 60%; margin: 10px;">

                <tr>
                    <td class="auto-style86" style="width: 175px">
                        <asp:Label ID="lb_region" runat="server" Text="Región"></asp:Label>
                    </td>
                    <td class="auto-style87" style="width: 275px">:
                              <asp:DropDownList ID="ddRegion" runat="server" AutoPostBack="true" Width="180px" CssClass="ComboBox" OnSelectedIndexChanged="ddDiametroMed_SelectedIndexChanged"></asp:DropDownList>
                    </td>
                    <td class="auto-style87" style="width: 175px">
                        <asp:Label ID="lb_contratista" runat="server" Text="Contratista"></asp:Label>
                    </td>
                    <td class="auto-style87" style="width: 275px">:
                            <asp:DropDownList ID="ddContratista" runat="server" AutoPostBack="true" CssClass="ComboBox" OnSelectedIndexChanged="ddMarcaMed_SelectedIndexChanged" Width="180px">
                            </asp:DropDownList>
                    </td>
                    <td class="auto-style87" style="width: 175px">&nbsp;</td>
                    <td class="auto-style87" style="width: 329px">&nbsp;</td>
                </tr>

                <tr>
                    <td class="auto-style88" style="width: 175px">
                        <asp:Label ID="lb_desde" runat="server" Text="Fecha desde"></asp:Label>
                    </td>
                    <td class="" style="width: 275px">:&nbsp;<asp:TextBox ID="txtDesde" runat="server" CssClass="TextBox3" Width="134px"></asp:TextBox>
                        &nbsp;<img src="Imagenes/calendario.gif" onclick="openCalendar('ctl00_ContentPlaceHolder1_txtDesde');" id="IMG7" />
                        <br />
                        &nbsp;&nbsp;
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtDesde" ErrorMessage="Error formato fecha." ValidationExpression="(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d"></asp:RegularExpressionValidator>

                    </td>
                    <td class="" style="width: 175px">
                        <asp:Label ID="lb_hasta" runat="server" Text="Fecha hasta"></asp:Label>
                    </td>
                    <td class="" style="width: 275px">:&nbsp;<asp:TextBox ID="txtHasta" runat="server" CssClass="TextBox3" Width="134px"></asp:TextBox>
                        &nbsp;<img src="Imagenes/calendario.gif" onclick="openCalendar('ctl00_ContentPlaceHolder1_txtHasta');" id="IMG8" />
                        <br />
                        &nbsp;&nbsp;
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtHasta" ErrorMessage="Error formato fecha." ValidationExpression="(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d"></asp:RegularExpressionValidator>
                    </td>
                    <td class="" style="width: 175px">&nbsp;</td>
                    <td class="" style="width: 329px">
                        <asp:Button ID="Button1" runat="server" CssClass="botonnew" Height="24px" Text="Filtrar" Width="114px" OnClick="Button1_Click" />
                    </td>
                </tr>

                <tr>
                    <td class="auto-style88" style="width: 175px">
                        <asp:Label ID="lb_estado_guia" runat="server" Text="Estado guia"></asp:Label>
                    </td>
                    <td class="" style="width: 275px">:
                        <asp:DropDownList ID="ddEstadoGuia" runat="server" AutoPostBack="true" CssClass="ComboBox" Width="180px" OnSelectedIndexChanged="ddEstadoGuia_SelectedIndexChanged">
                            <asp:ListItem Value="0">TODOS...</asp:ListItem>
                            <asp:ListItem Value="1">PENDIENTE RECEPCIÓN</asp:ListItem>
                            <asp:ListItem Value="2">VALIDACIÓN PARCIAL</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="" style="width: 175px">
                        <asp:Label ID="lb_tipo_guia" runat="server" Text="Tipo guia"></asp:Label>
                    </td>
                    <td class="" style="width: 275px">:
                        <asp:DropDownList ID="ddTipoGuia" runat="server" AutoPostBack="true" CssClass="ComboBox"  Width="180px" OnSelectedIndexChanged="ddTipoGuia_SelectedIndexChanged">
                            <asp:ListItem Value="0">TODOS...</asp:ListItem>
                            <asp:ListItem Value="1">RECEPCIÓN</asp:ListItem>
                            <asp:ListItem Value="2">TRASPASO</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="" style="width: 175px">&nbsp;</td>
                    <td class="" style="width: 329px">&nbsp;</td>
                </tr>

                <tr>
                    <td class="auto-style88" colspan="6" style="text-align: center; color: red; font-weight: bold;">
                        <asp:Label ID="lb_resultlado_filtro" runat="server" ForeColor="Red"></asp:Label>
                    </td>
                </tr>

                <tr>
                    <td colspan="6">
                        <asp:Label ID="Label2" runat="server" Text="N° Guía a validar:"></asp:Label>
                        <br />
                        <asp:DropDownList ID="ddguia" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddguia_SelectedIndexChanged" Width="500px">
                        </asp:DropDownList>
                    </td>
                </tr>

            </table>

            <table id="Table2" runat="server">
                <tr>
                    <td colspan="2">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Label ID="lbResultado" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Label ID="lbTotal" runat="server"></asp:Label>
                        <asp:Label ID="lbErrorGrilla" runat="server"></asp:Label>
                    </td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Label ID="lb_detalle_medidores" runat="server"></asp:Label>
                    </td>
                </tr>
                              
                <tr>
                    <td style="width: 750px">
                        <asp:Panel ID="panGrid" runat="server" Height="326px" HorizontalAlign="Center" ScrollBars="auto" Width="700px">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="GrillaValidacion" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" CssClass="GridAlternativeItems" EnableModelValidation="True" ForeColor="#333333" Height="100px" OnPageIndexChanging="gridOrden_PageIndexChanging" OnRowCommand="gridOrden_RowCommand" OnRowDataBound="gridOrden_RowDataBound" PageSize="100" Width="600px">
                                        <AlternatingRowStyle BackColor="White" />
                                        <Columns>

                                            <asp:BoundField DataField="ID_DETALLE_GUIA" HeaderText="id_detalle">
                                                <HeaderStyle ForeColor="White" Width="0%"/>
                                            </asp:BoundField>

                                            <asp:BoundField DataField="ID_GUIA" HeaderText="id_guia">
                                                <HeaderStyle ForeColor="White" Width="0%"/>
                                                <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="CODIGO_ARTICULO" HeaderText="CODIGO">
                                                <HeaderStyle ForeColor="White" Width="0%"/>
                                                <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="" HeaderText="RESERVA" Visible="false">
                                                <HeaderStyle ForeColor="White" Width="10%"/>
                                                <ItemStyle Font-Size="Smaller"/>
                                            </asp:BoundField>

                                            <asp:BoundField DataField="CODIGO_PROVEEDOR" HeaderText="CODIGO PROVEEDOR">
                                                <HeaderStyle ForeColor="White" Width="10%"/>
                                                <ItemStyle Font-Size="Smaller"/>
                                            </asp:BoundField>

                                            <asp:BoundField DataField="TIPO" HeaderText="TIPO">
                                                <HeaderStyle ForeColor="White" Width="10%"/>

                                                <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="NOMBRE_ARTICULO" HeaderText="NOMBRE ARTICULO">
                                                <HeaderStyle ForeColor="White" Width="25%"/>
                                                <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="DIAMETRO" HeaderText="DIAMETRO">
                                                <HeaderStyle ForeColor="White" Width="9%"/>
                                                <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="CANTIDAD" HeaderText="CANTIDAD DETALLE">
                                                <HeaderStyle ForeColor="White" Width="10%"/>
                                                <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="CANTIDAD_PENDIENTE" HeaderText="CANTIDAD PENDIENTE">
                                                <HeaderStyle ForeColor="White" Width="10%"/>
                                                <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:TemplateField HeaderText="CANTIDAD RECIBIDA">
                                                <ItemTemplate>
                                                    <%--<asp:TextBox  ID="cant_recibida" ImageAlign="Middle" runat="server" CommandArgument="<%# Container.DataItemIndex%>" OnTextChanged="validar_cantidades" Width="30px" Font-Size="Small"  CommandName="cant_recibida" ></asp:TextBox>--%>
                                                    <asp:TextBox ID="cant_recibida" ImageAlign="Middle" CssClass="TextBox" runat="server" Width="35px" MaxLength="4" Font-Size="Small"></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="25px" />
                                                <HeaderStyle ForeColor="White" Width="8%"/>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="VALIDAR">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="Aceptar" ImageAlign="Middle" runat="server" CommandArgument="<%# Container.DataItemIndex%>" OnClientClick="return ShowProgress();" CommandName="aceptar" src="Imagenes/check.png" Width="23px" />
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="20px" />
                                                <HeaderStyle ForeColor="White" Width="8%"/>
                                            </asp:TemplateField>

                                            <asp:BoundField DataField="EN_DIFERENCIA" HeaderText="DIFERENCIA" Visible="false">
                                                <HeaderStyle ForeColor="White" Width="10%"/>
                                                <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                        </Columns>
                                        <EditRowStyle BackColor="#2461BF" />
                                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                        <RowStyle BackColor="White" />
                                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                    </asp:GridView>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>
                    </td>
                    <td>
                        <asp:GridView ID="medidores" runat="server" AllowPaging="True" ScrollBars="auto" OnRowCreated="medidores_RowDataBound" OnRowCommand="medidores_RowCommand" OnRowDataBound="medidores_RowDataBound" OnPageIndexChanging="medidores_PageIndexChanging" AutoGenerateColumns="False" CellPadding="4" CssClass="GridAlternativeItems" EnableModelValidation="True" ForeColor="#333333" PageSize="10" Width="200px" Height="16px">
                            <%-- OnRowCommand=""--%>
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="ID_GUIA" HeaderText="GUIA">
                                    <HeaderStyle ForeColor="White" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ID_MEDIDOR" HeaderText="ID_MEDIDOR">
                                    <HeaderStyle ForeColor="White" />
                                </asp:BoundField>
                                <asp:BoundField DataField="CODIGO" HeaderText="CODIGO">
                                    <HeaderStyle ForeColor="White" />
                                    <ItemStyle HorizontalAlign="Center" Width="70px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="SERIE" HeaderText="SERIE">
                                    <HeaderStyle ForeColor="White" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ANO" HeaderText="AÑO">
                                    <HeaderStyle ForeColor="White" />
                                </asp:BoundField>
                                <asp:BoundField DataField="DIAMETRO" HeaderText="DIAMETRO">
                                    <HeaderStyle ForeColor="White" />
                                    <ItemStyle HorizontalAlign="Center" Width="70px" />
                                </asp:BoundField>

                                <asp:BoundField DataField="CONTRATISTA" HeaderText="CONTRATISTA">
                                    <HeaderStyle ForeColor="White" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="REGION" HeaderText="REGION">
                                    <HeaderStyle ForeColor="White" />
                                </asp:BoundField>

                                <asp:TemplateField HeaderText="RECIBIDO">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="recepcionado" ImageAlign="Middle" runat="server" CommandArgument="<%# Container.DataItemIndex%>" CommandName="recepcionado" src="Imagenes/check.ico" Width="23px" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                                    <HeaderStyle ForeColor="White" />
                                </asp:TemplateField>

                                <asp:BoundField DataField="ID_TIPO_MEDIDOR" HeaderText="ID_TIPO_MEDIDOR">
                                    <HeaderStyle ForeColor="White" />
                                    <ItemStyle Font-Size="Smaller" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="NO RECIBIDO">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="no_recibido" ImageAlign="Middle" runat="server" CommandArgument="<%# Container.DataItemIndex%>" CommandName="no_recepcionado" src="Imagenes/x.png" Width="22px" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                                    <HeaderStyle ForeColor="White" />
                                </asp:TemplateField>
                                  <asp:BoundField DataField="ID_ESTADO_MEDIDOR" HeaderText="ESTADO">
                                    <HeaderStyle ForeColor="White" />
                                    <ItemStyle HorizontalAlign="Center" Width="10px" />
                                </asp:BoundField>
                            </Columns>
                            <EditRowStyle BackColor="#2461BF" />
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#ff0000" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#EFF3FB" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <table style="padding-top: 10px;">
                            <tr>
                                <td class="auto-style4" style="width: 131px">
                                    <asp:Label ID="Label1" runat="server" Text="Observacion :"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="observacion" CssClass="" Width="600px" TextMode="MultiLine" Rows="5" MaxLength="200"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Button runat="server" ID="ingresar_observacion" Text="Ingresar observación y terminar validación" OnClick="ingresar_observacion_Click" CssClass="botonnew" Width="300px" Height="24px" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

        </ContentTemplate>
    </asp:UpdatePanel>



</asp:Content>

