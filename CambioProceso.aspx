<%@ Page Title="Mantenedor cambio de proceso"  Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="CambioProceso.aspx.cs" Inherits="CambioProceso" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    <style type="text/css">
        .styletd{
             text-align:right ;
             width: 320px;
        }
        .auto-style6 {
            width: 333px;
            height: 27px;
        }
        .auto-style7 {
            height: 27px;
        }
        .auto-style14 {
            width: 333px;
        }
        .auto-style15 {
            width: 244px;
        }
        .auto-style16 {
            height: 21px;
            width: 244px;
        }
        .auto-style17 {
            width: 242px;
        }
        .auto-style18 {
            height: 21px;
            width: 242px;
        }
    </style>

            <script type="text/javascript">

                function ventana(){
                    miVentana = window.open("Crear_proceso.aspx", "", "width=600, height=400", "resizable = no");
                }
                function openCalendar(obj) {
                    var url = 'calendario2.aspx?textbox=' + obj;
                    window.open(url, 'cal', 'width=260,height=210,left=410 410,top=330,resizable=0,scrollbars=0');
                }
           </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <asp:UpdatePanel ID="Panel_general" runat="server" >
        <ContentTemplate>
            
              <asp:Panel id="Panel_crear_campaña" runat="server" visible="true"> 

                <asp:UpdatePanel ID="panel_filtros" runat="server" >
                <ContentTemplate>
                <h1 class="WebPartTitle">CAMBIO DE PROCESO<asp:Label ID="Label1" runat="server" ></asp:Label></h1>
                   
                <table id="tablaAsig" style="width: 126%; height: 122px;">
                <tr>
                    <td class="auto-style70" style="width: 70px"></td>
                    <td class="auto-style15"></td>
                    <td class="auto-style82" style="width: 110px">
                        <asp:Label ID="Label2" runat="server"></asp:Label>
                    </td>
                </tr>

                <tr>
                    <td class="auto-style71" style="width: 70px">Grupo:
                        </td>
                    <td class="auto-style15">
                        <asp:DropDownList ID="ddGrupo" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddGrupo_SelectedIndexChanged" Width="230px">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style81" style="width: 110px">Tipo Proceso:</td>
                    <td class="auto-style17">
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
                    <td class="auto-style15">
                        <asp:DropDownList ID="ddZona" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddZona_SelectedIndexChanged" Width="230px">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style81" style="width: 110px">Estado:</td>
                    <td class="auto-style17">
                        <asp:DropDownList ID="ddSincro" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddSincro_SelectedIndexChanged" Width="230px">
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
                    <td class="auto-style15">
                        <asp:DropDownList ID="ddLocalidad" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddLocalidad_SelectedIndexChanged" Width="230px">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style82" style="width: 110px">Tipo Instalación:
                        </td>
                    <td class="auto-style17">
                        <asp:DropDownList ID="ddTipoIn" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddTipoIn_SelectedIndexChanged" Width="230px">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style67">
                    </td>
                    <td class="auto-style69"></td>
                </tr>
                <tr>
                    <td class="auto-style72" style="width: 70px; height: 21px;">Ruta: </td>
                    <td class="auto-style16">
                        <asp:DropDownList ID="ddRuta" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddRuta_SelectedIndexChanged" Width="230px">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style72" style="width: 70px; height: 21px;">Contratista: </td>
                    <td class="auto-style18">
                        <asp:DropDownList ID="ddContratista" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddContratista_SelectedIndexChanged" Width="230px">
                        </asp:DropDownList>
                    </td>

                    <td class="auto-style24" style="height: 21px">
                        <asp:Button ID="Button1" runat="server" CssClass="botonnew" OnClick="Button1_Click1" Text="FILTRAR" Width="120px" />
                    </td>
                    <td class="auto-style69" style="height: 21px"></td>
                </tr>
                <tr>
                    <td class="auto-style72" style="width: 70px; height: 21px;">N° Orden: </td>
                    <td class="auto-style16">
                        <asp:TextBox ID="TextboxNumOrden" runat="server" AutoPostBack="True" CssClass="TextBox3"  Width="230px"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="TextboxNumOrden" ErrorMessage="No es valido el formato" SetFocusOnError="true"  ValidationExpression="\d+"></asp:RegularExpressionValidator>
                    </td>
                    <td class="auto-style82" style="width: 110px; height: 21px;">Servicio:</td>
                    <td class="auto-style18">
                        <asp:TextBox ID="txtServ" runat="server" AutoPostBack="True" CssClass="TextBox3"  Width="230px"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator_serv" runat="server" ControlToValidate="txtServ" ErrorMessage="No es valido el formato" SetFocusOnError="true"  ValidationExpression="\d+"></asp:RegularExpressionValidator>

                    </td>
                </tr>
                </table>
                <hr size="5px" color="#507CD1" style="margin-bottom: 10px" />
                <h1 class="WebPartTitle">SELECCIONE :<asp:Label ID="LabelCambio" runat="server" ></asp:Label></h1>
                <table>

                    <!-- DROP PARA CAMBIAR DE PROCESO -->
                <tr>
                    <td class="auto-style6" >
                        <asp:Label ID="lbProceso" runat="server" style="font-size:small;"  Text="Proceso al que se cambiarán las ordenes:"></asp:Label>
                        </td><td class="auto-style7">
                        <asp:DropDownList ID="ddProcesoCambio" runat="server" AutoPostBack="True" CssClass="ComboBox" Width="200px">
                        </asp:DropDownList>
                         <td>
                               <button id="Button_crear" class="botonnew" onclick="ventana()" width="170">CREAR PROCESO</button>
                         </td>
                    </td>

                </tr>
                    <tr>
                        <td class="auto-style6">
                            </td>
                    <td class="auto-style7">
                    <asp:Button ID="cambio_proceso" runat="server" CssClass="botonnew" Height="20px" OnClick="btnCambio_Proceso_Click" Text="CAMBIAR" Width="170" />
                    </td>
                    </tr>
                        <tr>
                            <td class="auto-style14">
                                <img src="Imagenes/ok.bmp" runat="server" id="IMG2" />
                                <img src="/SGM/Imagenes/cross2.bmp" runat="server" id="IMG5" />
                                <img src="/SGM/Imagenes/warning.bmp" runat="server"  id="IMG6" />
                                &nbsp;
                                <asp:Label ID="lbResultado" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style14">
                                <asp:Label ID="lbTotal" runat="server"></asp:Label>
                                <asp:Label ID="lbErrorGrilla" runat="server"></asp:Label>
                                <br />
                            </td>
                        </tr>
                </table>
                    
                </ContentTemplate>
                </asp:UpdatePanel>
            </asp:Panel>

             <asp:Panel ID="panGrid" runat="server" Height="326px" HorizontalAlign="Center" ScrollBars="Vertical"  Width="1200px">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="gridOrden" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" CssClass="GridAlternativeItems" EnableModelValidation="True" ForeColor="#333333" Height="100px" OnPageIndexChanging="gridOrden_PageIndexChanging" OnRowCommand="gridOrden_RowCommand" OnRowDataBound="gridOrden_RowDataBound" PageSize="40" Width="1142px" OnSelectedIndexChanged="gridOrden_SelectedIndexChanged">
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

                                           <asp:BoundField DataField="FECHA_CREACION" HeaderText="Fecha creación" visible="false">
                                                <HeaderStyle ForeColor="White" />
                                                <ItemStyle Font-Size="Smaller" Width="60px" />
                                            </asp:BoundField>
                                           
                                            <asp:BoundField DataField="FECHA_INTEGRACION" HeaderText="Fecha ingreso SGM" visible="false">
                                                <HeaderStyle ForeColor="White" />
                                                <ItemStyle Font-Size="Smaller" Width="70px" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="dias_transcurridos" HeaderText="Días transcurridos" visible="false">
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

                                            <asp:BoundField DataField="SERIE_MEDIDOR" HeaderText="Serie Med." Visible="false" >
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

                                            <asp:BoundField DataField="ID_SINCRONIZACION" HeaderText="id_sincronizacion">
                                            </asp:BoundField>

                                            <asp:BoundField DataField="NOMBRE" HeaderText="Instalador">
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>
                                            
                                            <asp:TemplateField HeaderText="Cambio proceso">
                                                <HeaderTemplate>
                                                    <asp:LinkButton ID="lbk_cambio" runat="server" CommandName="check_cambio">Cambiar Proceso</asp:LinkButton>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="check_cambio" runat="server" />
                                                </ItemTemplate>
                                                <HeaderStyle ForeColor="White" />
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
                        </asp:Panel><!-- TERMINO PANEL DE GRILLA -->

        </ContentTemplate>
        </asp:UpdatePanel>
</asp:Content>
