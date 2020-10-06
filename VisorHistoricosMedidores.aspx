<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="VisorHistoricosMedidores.aspx.cs" Inherits="VisorHistoricosMedidores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src = " https://unpkg.com/sweetalert/dist/sweetalert.min.js "></script> 
    
    <style type="text/css">
        .auto-style7
        {
            height: 43px;
        }
        .auto-style4
        {
            width: 20px;
        }
        .auto-style40
        {
            height: 20px;
        }
        #IMG3
        {
            height: 38px;
            width: 42px;
        }
        #IMG4
        {
            height: 21px;
            width: 22px;
        }
        #IMG5
    {
        height: 21px;
        width: 22px;
    }
        #IMG6
        {
            height: 21px;
            width: 22px;
        }
        #IMG8
        {
            margin-top: 0px;
        }
        #IMG10
        {
            margin-top: 0px;
        }
        .auto-style80
        {
            margin-bottom: 0px;
        }
        .modal
        {
            position: fixed;
            top: 0;
            left: 0;
            background-color: black;
            z-index: 99;
            opacity: 0.8;
            filter: alpha(opacity=80);
            -moz-opacity: 0.8;
            min-height: 100%;
            width: 100%;
        }
        .loading
        {
            font-family: Arial;
            font-size: 10pt;
            width: 200px;
            height: 100px;
            display: none;
            position: fixed;
            z-index: 999;
        }
        .titulo_filtro {
            width:100px;
            height:20px;
            text-align:right;
        }
        .filtros_combo1 {
            width:220px;
            height:20px;
            text-align:left;
        }
         .filtros_combo2 {
            width:250px;
            height:20px;
            text-align:left;
        }


        </style>

    <script type="text/javascript">

        function popOperador(obj) {
            var url = 'popOperador.aspx?textbox=' + obj;
            window.open(url, 'cal', 'width=820,height=320,left=200,top=50,resizable=0,scrollbars=yes');
        }

        function openCalendar(obj) {
            var url = 'calendario2.aspx?textbox=' + obj;
            window.open(url, 'cal', 'width=260,height=210,left=410 410,top=330,resizable=0,scrollbars=0');
        }

        function alertaNoAmeritaFoto(numero) {
            alert('LA ORDEN NO AMERITA FOTOS!');
        }

        function alertaNoExisteFoto(numero) {
            alert('LA ORDEN NO TIENE FOTOS! (POSIBLE ERROR DE DESCARGA)');
        }

        function ShowProgress() {
            setTimeout(function () {
                var modal = $('<div />');
                modal.addClass("modal");
                $('body').append(modal);
                var loading = $(".loading");
                loading.show();
                var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
                var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
                loading.css({ top: top, left: left });

                //var millisecondsToWait = 200;
                //setTimeout(function () {
                   modal.remove();
                //}, millisecondsToWait);

            }, 100);
            
            return;
        }

        function mensaje_ok(title, msg) {
            swal(title, msg, "success");
        }

        function mensaje_ok2(msg) {
            swal("ÉXITO!", msg, "success");
        }

        function mensaje_error(msg) {
            swal("¡ERROR! ", msg, "warning");
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1 class="WebPartTitle">Visor Historico de medidores<asp:Label ID="lb_rut_empresa" runat="server" Visible="False"></asp:Label>
            
            <asp:Label ID="lb_id_perfil" runat="server" Visible="False"></asp:Label>
            
            <asp:Label ID="lb_id_usuario" runat="server" Visible="False"></asp:Label>
            
            </h1>

        <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
             <div class="loading" align="center">           
                <img src="Imagenes/loading.gif" alt="" style="vertical-align:middle" />
            </div>
            <table id="filtros" style="width: 100%;">
                 <tr>
                    <td class="titulo_filtro">
                        <asp:Label ID="Label3" runat="server" Text="Región:"></asp:Label>
                    </td>
                    <td class="filtros_combo1">
                    <asp:DropDownList ID="ddRegion" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddRegion_SelectedIndexChanged" style="height: 17px" Width="200px">
                         </asp:DropDownList>     
                    </td>
                    <td class="titulo_filtro">

            
                        <asp:Label ID="Label8" runat="server" Text="Estado medidor:"></asp:Label>

            
                    <td class="filtros_combo1">

                      
                        <asp:DropDownList ID="ddestado" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddestado_SelectedIndexChanged" Width="200px">
                        </asp:DropDownList>

                      
                    </td>
                     <td class="titulo_filtro">


                         <asp:Label ID="Label12" runat="server" Text="Fecha desde:"></asp:Label>


                    </td>
                    <td class="filtros_combo2">


                        <asp:TextBox ID="txtDesde" runat="server" AutoPostBack="True" CssClass="TextBox3" Width="100px"></asp:TextBox>
                        <img src="Imagenes/calendario.gif" onclick="openCalendar('ctl00_ContentPlaceHolder1_txtDesde');"  id="IMG7" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtDesde" ErrorMessage="Error formato." SetFocusOnError="True" ValidationExpression="(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d"></asp:RegularExpressionValidator>


                    </td>
                    <td class="auto-style107">

                        &nbsp;</td>
                    <td>

                    </td>
                    <td>

                    </td>
                </tr>
                 <tr>
                    <td class="titulo_filtro">
                        <asp:Label ID="Label14" runat="server" Text="Bodega:"></asp:Label>
                    </td>
                    <td class="auto-style100">
                       
                        <asp:DropDownList ID="ddbodegas" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddbodegas_SelectedIndexChanged" Width="200px">
                        </asp:DropDownList>
                       
                    </td>
                    <td class="titulo_filtro">
                        
                        <asp:Label ID="Label13" runat="server" Text="Nro. Guia:"></asp:Label>
                        
                    </td>
                    <td class="auto-style102">
                       
                        <asp:DropDownList ID="ddguia" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddguia_SelectedIndexChanged" Width="200px">
                        </asp:DropDownList>
                       
                    </td>
                    <td class="titulo_filtro">
                     
                        <asp:Label ID="Label18" runat="server" Text="Fecha hasta:"></asp:Label>
                     
                    </td>
                    <td class="filtros_combo2">
                      
                        <asp:TextBox ID="txtHasta" runat="server" AutoPostBack="True" CssClass="TextBox3" OnTextChanged="txtHasta_TextChanged" Width="100px"></asp:TextBox>
                        <img src="Imagenes/calendario.gif" onclick="openCalendar('ctl00_ContentPlaceHolder1_txtHasta');"  id="IMG8" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtHasta" ErrorMessage="Error formato." ValidationExpression="(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d"></asp:RegularExpressionValidator>
                      
                    </td>
                    <td class="auto-style107">
                    
                        &nbsp;</td>
                    <td>

                    </td>
                    <td>

                    </td>
                </tr>
                <tr>
                    <td class="titulo_filtro">

                        <asp:Label ID="Label16" runat="server" Text="Contratista:"></asp:Label>

                    </td>
                      
                    <td class="auto-style40">
                       
                        <asp:DropDownList ID="ddContratista" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddContratista_SelectedIndexChanged" Width="200px">
                        </asp:DropDownList>
                       
                    </td>
                    <td class="titulo_filtro">
                    
                        <asp:Label ID="Label5" runat="server" Text="Tipo proceso:"></asp:Label>
                    
                    </td>
                    <td class="auto-style40">
                   
                        <asp:DropDownList ID="ddTipoProceso" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddOrigenOrden_SelectedIndexChanged" Width="200px" Height="20px">
                        </asp:DropDownList>
                   
                    </td>
                    <td class="titulo_filtro">
                       
                        <asp:Label ID="Label4" runat="server" Text="Serie desde:"></asp:Label>
                       
                    </td>
                    <td class="filtros_combo2">                        

                        <asp:TextBox ID="serie_desde" runat="server" AutoPostBack="true" CssClass="ComboBox" OnTextChanged="serie_desde_TextChanged" Width="100px"></asp:TextBox>
                        <asp:CheckBox ID="check_rango" runat="server" AutoPostBack="true" OnCheckedChanged="check_rango_CheckedChanged" Text="Rango" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="serie_desde" ErrorMessage="Solo numeros" ForeColor="Red" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>

                    </td>
                    <td class="auto-style40">
                      
                    </td>
                    <td class="auto-style40"></td>
                    <td class="auto-style40"></td>
                </tr>
                <tr>
                    <td class="titulo_filtro">
                        <asp:Label ID="Label6" runat="server" Text="Servicio:"></asp:Label>
                        <br />
                    </td>
                    <td class="auto-style100">
                     
                        &nbsp;<asp:TextBox ID="txtServ" runat="server" AutoPostBack="True" CssClass="TextBox" OnTextChanged="txtServ_TextChanged" Width="100px"></asp:TextBox>
                        <br />
                     
                    </td>
                    <td class="titulo_filtro">
                 
                        <asp:Label ID="Label17" runat="server" Text="Instalador:"></asp:Label>
                 
                    </td>
                    <td class="auto-style102">
                     
                        <asp:DropDownList ID="ddOperador" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddSincro_SelectedIndexChanged" Width="200px">
                        </asp:DropDownList>
                     
                    </td>
                    <td class="titulo_filtro">
                  
                        <asp:Label ID="serie_hasta_rango" runat="server" Text="Serie hasta:" Visible="False"></asp:Label>
                  
                    </td>
                    <td class="filtros_combo2">
                       
                        <asp:TextBox ID="serie_hasta" runat="server" AutoPostBack="true" CssClass="ComboBox" OnTextChanged="serie_hasta_TextChanged" Visible="False" Width="100px"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="serie_hasta" Enabled="False" ErrorMessage="Solo numeros" ForeColor="Red" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
                       
                    </td>
                    <td class="auto-style107">
                       
                    </td>
                    <td>

                    </td>
                    <td>

                    </td>
                </tr>

                 <tr>
                     <td class="titulo_filtro">
                         <asp:Label ID="Label15" runat="server" Text="Orden servicio:"></asp:Label>
                     </td>
                     <td class="auto-style100">&nbsp;<asp:TextBox ID="txtOrden" runat="server" AutoPostBack="True" CssClass="TextBox" OnTextChanged="txtServ_TextChanged" Width="100px"></asp:TextBox>
                     </td>
                     <td class="titulo_filtro">
                         <asp:Label ID="Label11" runat="server" Text="Diametro:"></asp:Label>
                     </td>
                     <td class="auto-style102">
                         <asp:DropDownList ID="dddiametro" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="dddiametro_SelectedIndexChanged" Width="110px">
                         </asp:DropDownList>
                     </td>
                     <td class="titulo_filtro">&nbsp;</td>
                     <td class="filtros_combo2">&nbsp;</td>
                     <td class="auto-style107">&nbsp;</td>
                     <td>&nbsp;</td>
                     <td>&nbsp;</td>
                 </tr>

                 <tr>
                     <td class="auto-style99">&nbsp;</td>
                     <td class="auto-style100">&nbsp;</td>
                     <td class="auto-style101">&nbsp;</td>
                     <td class="auto-style102">&nbsp;</td>
                     <td class="auto-style116">&nbsp;</td>
                     <td class="auto-style117">
                         <asp:Button ID="Button1" runat="server" CssClass="botonnew" Height="20px" OnClick="Button1_Click1" OnClientClick="return ShowProgress();" Text="Filtrar/Refrescar" Width="175px" />
                     </td>
                     <td class="auto-style107">&nbsp;</td>
                     <td>&nbsp;</td>
                     <td>&nbsp;</td>
                 </tr>
                 <tr>
                     <td class="auto-style99" colspan="4" rowspan="3">
                         <img id="IMG4" runat="server" src="/SGM/Imagenes/caution.png" />
                         <img id="IMG2" runat="server" src="/SGM/Imagenes/correct.png" />
                         <asp:Label ID="lbTxtIn" runat="server"></asp:Label>
                     </td>
                     <td class="auto-style116">&nbsp;</td>
                     <td class="auto-style117">
                         <asp:Button ID="btn_exportar" runat="server" CssClass="botonnew" Height="20px" OnClick="btn_exportar_Click" Text="Exportar Excel" Width="175px" />
                     </td>
                     <td class="auto-style107">&nbsp;</td>
                     <td>&nbsp;</td>
                     <td>&nbsp;</td>
                 </tr>
                 <tr>
                     <td class="auto-style116">&nbsp;</td>
                     <td class="auto-style117">&nbsp;</td>
                     <td class="auto-style107">&nbsp;</td>
                     <td>&nbsp;</td>
                     <td>&nbsp;</td>
                 </tr>
                 <tr>
                     <td class="auto-style116">&nbsp;</td>
                     <td class="auto-style117">
                         &nbsp;</td>
                     <td class="auto-style107">&nbsp;</td>
                     <td>&nbsp;</td>
                     <td>&nbsp;</td>
                 </tr>

            </table>
            <table id="tablaAsig" style="width: 100%; height: 122px;">
                <tr>
                    <td colspan="8">
                        <asp:Label ID="lbTotal" runat="server"></asp:Label>
                        &nbsp;<asp:DropDownList ID="ddPageSize" runat="server" AutoPostBack="True" Visible="false" CssClass="ComboBox" OnSelectedIndexChanged="ddPageSize_SelectedIndexChanged" Width="50px">
                            <asp:ListItem>100</asp:ListItem>
                            <asp:ListItem>50</asp:ListItem>
                            <asp:ListItem>25</asp:ListItem>
                            <asp:ListItem>10</asp:ListItem>
                        </asp:DropDownList>
                        &nbsp;&nbsp;<asp:Label ID="lbErrorGrilla" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style7">
                        <asp:Panel ID="panGrid" runat="server" CssClass="auto-style80" Height="375px" HorizontalAlign="Center" ScrollBars="Auto" Width="1250px">
                            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="gridOrden" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="CODIGO_UNICO,NUMERO_ORDEN,ID_SERVICIO" CellPadding="4" CssClass="GridAlternativeItems" EnableModelValidation="True" ForeColor="#333333" Height="125px" OnPageIndexChanging="gridOrden_PageIndexChanging" OnRowCommand="gridOrden_RowCommand" PageSize="100" Width="1250px">
                                        <AlternatingRowStyle BackColor="White" />
                                        <Columns>
                                            <%--CAMPOS NO VISIBLES --%>
                                            <asp:BoundField DataField="CODIGO_UNICO" HeaderText="CODIGO UNICO" Visible="False">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="USUARIO" HeaderText="USUARIO" Visible="False">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" />
                                            </asp:BoundField>
                                           
                                                                                                                                                                                
                                            <%--CAMPOS VISIBLES --%>                                            
                                            <asp:BoundField DataField="SERIE" HeaderText="SERIE">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="5%" />
                                            <ItemStyle Font-Size="XX-Small" ForeColor="Black" Width="5%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="DEN_TECNICA" HeaderText="DEN. TECNICA">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="5%" />
                                            <ItemStyle Font-Size="XX-Small" ForeColor="Black" Width="5%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="INSTALADOR" HeaderText="INSTALADOR">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="5%" />
                                            <ItemStyle Font-Size="XX-Small" ForeColor="Black" Width="5%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ESTADO_MEDIDOR" HeaderText="ESTADO MEDIDOR">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="5%" />
                                            <ItemStyle Font-Size="XX-Small" ForeColor="Black" Width="5%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="NUMERO_GUIA" HeaderText="NRO. GUIA">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="5%" />
                                            <ItemStyle Font-Size="XX-Small" ForeColor="Black" Width="5%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="NOMBRE_BODEGA" HeaderText="BODEGA">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="5%" />
                                            <ItemStyle Font-Size="XX-Small" ForeColor="Black" Width="5%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="CONTRATISTA" HeaderText="CONTRATISTA">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="5%" />
                                            <ItemStyle Font-Size="XX-Small" ForeColor="Black" Width="5%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="FECHA" HeaderText="FECHA">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="5%" />
                                            <ItemStyle Font-Size="XX-Small" ForeColor="Black" Width="5%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="DETALLE" HeaderText="DETALLE">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="5%" />
                                            <ItemStyle Font-Size="XX-Small" ForeColor="Black" Width="5%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="TIPO_PROCESO" HeaderText="TIPO PROCESO">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="5%" />
                                            <ItemStyle Font-Size="XX-Small" ForeColor="Black" Width="5%" />
                                            </asp:BoundField>          
                                            <asp:BoundField DataField="VISITA" HeaderText="VISITA">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="3%" />
                                            <ItemStyle Font-Size="XX-Small" ForeColor="Black" Width="3%" />
                                            </asp:BoundField>
                                             <asp:TemplateField HeaderText="NRO. ORDEN">
                                                 <EditItemTemplate>
                                                     <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("NUMERO_ORDEN") %>'></asp:TextBox>
                                                 </EditItemTemplate>
                                                 <ItemTemplate>                                                                                                      
                                                     <asp:LinkButton ID="lkbget_orden" runat="server" CommandArgument="<%# Container.DataItemIndex%>" CommandName="get_orden" Text='<%# Bind("NUMERO_ORDEN") %>'> </asp:LinkButton>   
                                                 </ItemTemplate>
                                                 <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="5%" />
                                                 <ItemStyle Font-Size="XX-Small" ForeColor="Black" Width="5%" />
                                            </asp:TemplateField>
                                             <asp:TemplateField HeaderText="SERVICIO">
                                                 <EditItemTemplate>
                                                     <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("ID_SERVICIO") %>'></asp:TextBox>
                                                 </EditItemTemplate>
                                                 <ItemTemplate>                                                                                                      
                                                     <asp:LinkButton ID="lkbget_serv" runat="server" CommandArgument="<%# Container.DataItemIndex%>" CommandName="get_serv" Text='<%# Bind("ID_SERVICIO") %>'> </asp:LinkButton>   
                                                 </ItemTemplate>
                                                 <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="5%" />
                                                 <ItemStyle Font-Size="XX-Small" ForeColor="Black" Width="5%" />
                                            </asp:TemplateField>

                                            
                                            <%--CAMPOS ACCIONABLES --%>
                                          
                                                                              
                                        </Columns>
                                        <EditRowStyle BackColor="#2461BF" />
                                        <FooterStyle BackColor="#1B3550" Font-Bold="True" ForeColor="White" />
                                        <HeaderStyle BackColor="#1B3550" Font-Bold="True" ForeColor="White" Width="150px" />
                                        <PagerStyle BackColor="#1B3550" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                                        <RowStyle BackColor="#EFF3FB" Font-Bold="True" Font-Italic="False" ForeColor="White" />
                                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="False" ForeColor="#333333" />
                                    </asp:GridView>
                                    <asp:GridView ID="grdExcel" runat="server" Visible="False">
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
