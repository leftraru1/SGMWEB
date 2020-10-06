﻿<%@ Page Title="Mantención de Ordenes Gestionadas" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="visorordenes.aspx.cs" Inherits="visorordenes" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
        <script type="text/javascript">

            function popInstalador(obj){
                var url = 'popInstalador.aspx?textbox=' + obj;
                window.open(url, 'cal', 'width=820,height=320,left=200,top=50,resizable=0,scrollbars=yes');
            }

            function openCalendar(obj) {
                var url = 'calendario2.aspx?textbox=' + obj;
                window.open(url, 'cal', 'width=260,height=210,left=410 410,top=330,resizable=0,scrollbars=0');
            }

    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1 class="WebPartTitle">Mantenedor de Ordenes Gestionadas</h1>

        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
            

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        
        <ContentTemplate>

            
            <table id="tablaAsig" style="width: 126%; height: 122px;">
                <tr>
                    <td class="auto-style70" style="width: 70px"></td>
                    <td class="auto-style89" style="width: 260px"></td>
                    <td class="auto-style82" style="width: 110px">
                        <asp:Label ID="Label1" runat="server"></asp:Label>
                    </td>
                </tr>

                <tr>
                    <td class="auto-style71" style="width: 70px">Región:
                        </td>
                    <td class="auto-style74" style="width: 260px">
                        <asp:DropDownList ID="ddRegion" runat="server" AutoPostBack="True" CssClass="ComboBox" Width="230px" OnSelectedIndexChanged="ddRegion_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style81" style="width: 110px">Tipo Proceso:</td>
                    <td style="width: 280px">
                        <asp:DropDownList ID="ddTipoPro" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddTipoPro_SelectedIndexChanged" Width="230px">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style60">
                       Desde:<asp:TextBox ID="txtDesde" runat="server" CssClass="TextBox3" Width="134px"></asp:TextBox>
                        <img src="Imagenes/calendario.gif" onclick="openCalendar('ctl00_ContentPlaceHolder1_txtDesde');"  id="IMG7" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtDesde" ErrorMessage="Error formato fecha." ValidationExpression="(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d"></asp:RegularExpressionValidator></td>
                    <td class="auto-style56">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style72" style="width: 70px">Zona: </td>
                    <td class="auto-style74" style="width: 260px">
                        <asp:DropDownList ID="ddZona" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddZona_SelectedIndexChanged" Width="230px">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style82" style="width: 110px">Estatus orden: </td>
                    <td style="width: 280px">
                        <asp:DropDownList ID="ddProcedencia" runat="server" AutoPostBack="True" CssClass="ComboBox" Width="230px" OnSelectedIndexChanged="ddProcedencia_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style67">Hasta:&nbsp;<asp:TextBox ID="txtHasta" runat="server" CssClass="TextBox3" Width="134px"></asp:TextBox>
                        <img src="Imagenes/calendario.gif" onclick="openCalendar('ctl00_ContentPlaceHolder1_txtHasta');"  id="IMG9" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtHasta" ErrorMessage="Error formato fecha." ValidationExpression="(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d"></asp:RegularExpressionValidator>
                    </td>
                    <td class="auto-style56"></td>
                </tr>
                <tr>
                    <td class="auto-style72" style="width: 70px">Localidad:
                        </td>
                    <td class="auto-style89" style="width: 260px">
                        <asp:DropDownList ID="ddLocalidad" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddLocalidad_SelectedIndexChanged" Width="230px">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style82" style="width: 110px">Tipo Instalación:
                        </td>
                    <td style="width: 280px">
                        <asp:DropDownList ID="ddTipoIn" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddTipoIn_SelectedIndexChanged" Width="230px">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style67">
                    </td>
                    <td class="auto-style69"></td>
                </tr>
                <tr>
                    <td class="auto-style72" style="width: 70px; height: 21px;">Ruta: </td>
                    <td class="auto-style89" style="width: 260px; height: 21px;">
                        <asp:DropDownList ID="ddRuta" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddRuta_SelectedIndexChanged" Width="230px">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style72" style="width: 70px; height: 21px;">Contratista: </td>
                    <td class="auto-style89" style="width: 260px; height: 21px;">
                        <asp:DropDownList ID="ddContratista" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddContratista_SelectedIndexChanged" Width="230px">
                        </asp:DropDownList>
                    </td>

                    <td class="auto-style24" style="height: 21px">
                        <asp:Button ID="Button1" runat="server" CssClass="button2" OnClick="Button1_Click1" Text="FILTRAR" />
                    </td>
                    <td class="auto-style69" style="height: 21px"></td>
                </tr>
                <tr>
                    <td class="auto-style72" style="width: 70px; height: 21px;">N° Orden: </td>
                    <td class="auto-style89" style="width: 260px; height: 21px;">
                        <asp:TextBox ID="TextboxNumOrden" runat="server" AutoPostBack="True" CssClass="TextBox3" OnTextChanged="txtNumOrden_TextChanged" Width="230px"></asp:TextBox>
                    </td>
                    <td class="auto-style82" style="width: 110px; height: 21px;">Servicio:</td>
                    <td style="height: 21px; width: 280px">
                        <asp:TextBox ID="txtServ" runat="server" AutoPostBack="True" CssClass="TextBox3" OnTextChanged="txtServ_TextChanged" Width="230px"></asp:TextBox>
                    </td>
                </tr>
                </table>

            <table id="Table2" runat="server" style="width: 126%; height: 122px;">
                <tr>
                    <td>
                        &nbsp;
                        </td>
                </tr>
                <tr>
                    <td style="height: 19px" >&nbsp;</td>
                    <td style="height: 19px" >
                        &nbsp;</td>
                </tr>

                <tr>
                    <td style="width:900px;" >
                        <asp:Label ID="lbTotal" runat="server"></asp:Label>
                        <asp:Label ID="lbErrorGrilla" runat="server"></asp:Label>
                    </td>
                </tr>

                <tr>
                    <td class="auto-style7" colspan="6">
                        <asp:Panel ID="panGrid" runat="server" Height="326px" HorizontalAlign="Center" ScrollBars="auto"  Width="1650px" >
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="gridOrden" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" CssClass="GridAlternativeItems" EnableModelValidation="True" ForeColor="#333333" Height="100px" OnPageIndexChanging="gridOrden_PageIndexChanging" OnRowCommand="gridOrden_RowCommand" OnRowDataBound="gridOrden_RowDataBound" PageSize="40" Width="1600px">
                                        <AlternatingRowStyle BackColor="White" />
                                        <Columns>

                                            <asp:BoundField DataField="ID_ORDEN" HeaderText="idOrden">
                                            <HeaderStyle ForeColor="White" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="NUMERO_ORDEN" HeaderText="Número">
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="ID_SERVICIO" HeaderText="Servicio">
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="CONTRATISTA" HeaderText="Contratista" >
                                                <HeaderStyle ForeColor="White" />
                                                <ItemStyle Font-Size="Smaller"  />
                                            </asp:BoundField>

                                           <asp:BoundField DataField="FECHA_CREACION" HeaderText="Fecha creación" >
                                                <HeaderStyle ForeColor="White" />
                                                <ItemStyle Font-Size="Smaller" Width="60px" />
                                            </asp:BoundField>
                                           
                                            <asp:BoundField DataField="FECHA_INTEGRACION" HeaderText="Fecha ingreso SGM" >
                                                <HeaderStyle ForeColor="White" />
                                                <ItemStyle Font-Size="Smaller" Width="70px" />
                                            </asp:BoundField>

                                             <asp:BoundField DataField="FECHA_INST" HeaderText="Fecha Ejecución" >
                                                <HeaderStyle ForeColor="White" />
                                                <ItemStyle Font-Size="Smaller" Width="70px" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="dias_transcurridos" HeaderText="Días transcurridos" >
                                                <HeaderStyle ForeColor="White" />
                                                <ItemStyle Font-Size="Smaller" width="50px"  />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="RUTA" HeaderText="Ruta">
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="TIPO_MARCA_DI" HeaderText="Tipo/Marca/Dim." Visible="false">
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="SERIE_MEDIDOR" HeaderText="Serie Med." Visible="false">
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="DIRECCION" HeaderText="Dirección" >
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Width="250px" Font-Size="Smaller" HorizontalAlign="Left"  />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="LOCALIDAD" HeaderText="Localidad" >
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ID_PROCESO" HeaderText="idProceso" >
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle ForeColor="White" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="GRUPO_PROCESO" HeaderText="Grupo Proceso" visible="false">
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ID_TIPO_PROCESO" HeaderText="idTipoProceso" >
                                            <HeaderStyle ForeColor="White" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="DETALLE" HeaderText="Tipo Proceso"> 
                                            <HeaderStyle ForeColor="White" Width="200px" />
                                            <ItemStyle Font-Size="Smaller" Width="200px" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ESTADO" HeaderText="Estado">
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>
                                            
                                            <asp:BoundField DataField="NOMBRE" HeaderText="Instalador">
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>
                                                                                       
                                            <asp:BoundField DataField="VISITA" HeaderText="Visita" >
                                            <HeaderStyle ForeColor="White" />
                                            </asp:BoundField>

                                            <asp:TemplateField HeaderText="GESTION">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="btn_gestion" runat="server" CommandArgument="<%# Container.DataItemIndex%>" CommandName="gestion" ImageUrl="~/Imagenes/edit.png" />
                                                </ItemTemplate>
                                                <HeaderStyle ForeColor="White" Font-Size="XX-Small" />
                                            </asp:TemplateField>
                                            <%--<asp:CommandField  ButtonType="Image" HeaderText="Gestion" SelectImageUrl="/imagenes/edit.png" ShowSelectButton="true">
                                               <HeaderStyle ForeColor="White" Font-Size="XX-Small" />
                                                <ItemStyle Font-Size="8pt" Width="50px" />
                                             </asp:CommandField>--%>
                                        
                                            
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
                    <td class="auto-style7">&nbsp;</td>
                </tr>

            </table>
        </ContentTemplate>
    </asp:UpdatePanel>

    </asp:Content>

