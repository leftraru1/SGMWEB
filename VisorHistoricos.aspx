<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="VisorHistoricos.aspx.cs" Inherits="VisorHistoricos" %>

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
    <h1 class="WebPartTitle">Visor Historico de ordenes<asp:Label ID="lb_rut_empresa" runat="server" Visible="False"></asp:Label>
            
            <asp:Label ID="lb_id_perfil" runat="server" Visible="False"></asp:Label>
            
            <asp:Label ID="lb_id_usuario" runat="server" Visible="False"></asp:Label>
            
            </h1>

        <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div  class="loading" align="center">           
                        <img src="Imagenes/loading.gif" alt="" style="vertical-align:middle;width:200px;height:140px;" />
              </div>
            <table id="filtros" style="width: 100%;">
                 <tr>
                    <td class="titulo_filtro">
                        <asp:Label ID="Label3" runat="server" Text="Tipo proceso:"></asp:Label>
                    </td>
                    <td class="filtros_combo1">
                         <asp:DropDownList ID="ddTipoProceso" runat="server" AutoPostBack="True" CssClass="ComboBox" Height="20px" Width="200px" OnSelectedIndexChanged="ddOrigenOrden_SelectedIndexChanged">
                        </asp:DropDownList>                    
                    </td>
                    <td class="titulo_filtro">

            
                        <asp:Label ID="Label8" runat="server" Text="Improcedencia:"></asp:Label>

            
                    <td class="filtros_combo1">

                      
                        <asp:DropDownList ID="ddProcedencia" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddTipoIn_SelectedIndexChanged" Width="200px">
                            
                        </asp:DropDownList>

                      
                    </td>
                     <td class="titulo_filtro">


                         <asp:Label ID="Label12" runat="server" Text="Desde:"></asp:Label>


                    </td>
                    <td class="filtros_combo2">


                        <asp:TextBox ID="txtDesde" runat="server" AutoPostBack="True" CssClass="TextBox3" Width="120px"></asp:TextBox>
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
                        <asp:Label ID="Label14" runat="server" Text="Región:"></asp:Label>
                    </td>
                    <td class="auto-style100">
                       
                        <asp:DropDownList ID="ddRegion" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddRegion_SelectedIndexChanged" style="height: 17px" Width="200px">
                        </asp:DropDownList>
                       
                    </td>
                    <td class="titulo_filtro">
                        
                        <asp:Label ID="Label13" runat="server" Text="Operador:"></asp:Label>
                        
                    </td>
                    <td class="auto-style102">
                       
                        <asp:DropDownList ID="ddOperador" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddSincro_SelectedIndexChanged" Width="200px">
                        </asp:DropDownList>
                       
                    </td>
                    <td class="titulo_filtro">
                     
                        <asp:Label ID="Label11" runat="server" Text="Hasta:"></asp:Label>
                     
                    </td>
                    <td class="filtros_combo2">
                      
                        <asp:TextBox ID="txtHasta" runat="server" AutoPostBack="True" CssClass="TextBox3" OnTextChanged="txtHasta_TextChanged" Width="120px"></asp:TextBox>
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

                        <asp:Label ID="Label16" runat="server" Text="Zona:"></asp:Label>

                    </td>
                      
                    <td class="auto-style40">
                       
                        <asp:DropDownList ID="ddZona" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddZona_SelectedIndexChanged" style="height: 17px" Width="200px">
                        </asp:DropDownList>
                       
                    </td>
                    <td class="titulo_filtro">
                    
                        <asp:Label ID="Label5" runat="server" Text="Lote:"></asp:Label>
                    
                    </td>
                    <td class="auto-style40">
                   
                        <asp:DropDownList ID="ddRuta" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddRuta_SelectedIndexChanged" Width="200px">
                        </asp:DropDownList>
                   
                    </td>
                    <td class="titulo_filtro">
                       
                        <asp:Label ID="Label6" runat="server" Text="Servicio:"></asp:Label>
                       
                    </td>
                    <td class="filtros_combo2">                        

                        <asp:TextBox ID="txtServ" runat="server" AutoPostBack="True" CssClass="TextBox" OnTextChanged="txtServ_TextChanged" Width="120px"></asp:TextBox>

                    </td>
                    <td class="auto-style40">
                      
                    </td>
                    <td class="auto-style40"></td>
                    <td class="auto-style40"></td>
                </tr>
                <tr>
                    <td class="titulo_filtro">
                        <asp:Label ID="Label4" runat="server" Text="Localidad:"></asp:Label>
                    </td>
                    <td class="auto-style100">
                     
                        <asp:DropDownList ID="ddLocalidad" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddLocalidad_SelectedIndexChanged" Width="200px">
                        </asp:DropDownList>
                     
                    </td>
                    <td class="titulo_filtro">
                 
                        <asp:Label ID="Label17" runat="server" Text="Contratista:"></asp:Label>
                 
                    </td>
                    <td class="auto-style102">
                     
                        <asp:DropDownList ID="ddContratista" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddContratista_SelectedIndexChanged" Width="200px">
                        </asp:DropDownList>
                     
                    </td>
                    <td class="titulo_filtro">
                  
                        <asp:Label ID="Label15" runat="server" Text="Orden servicio:"></asp:Label>
                  
                    </td>
                    <td class="filtros_combo2">
                       
                        <asp:TextBox ID="txtOrden" runat="server" AutoPostBack="True" CssClass="TextBox" OnTextChanged="txtServ_TextChanged" Width="120px"></asp:TextBox>
                       
                    </td>
                    <td class="auto-style107">
                       
                    </td>
                    <td>

                    </td>
                    <td>

                    </td>
                </tr>

                 <tr>
                     <td class="auto-style99">&nbsp;</td>
                     <td class="auto-style100">&nbsp;</td>
                     <td class="auto-style101">&nbsp;</td>
                     <td class="auto-style102">&nbsp;</td>
                     <td class="auto-style116">&nbsp;</td>
                     <td class="auto-style117">
                         <asp:Button ID="Button1" runat="server" CssClass="botonnew" Height="20px" OnClick="Button1_Click1" Text="Filtrar/Refrescar" Width="175px" OnClientClick="return ShowProgress();" />
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
                        &nbsp;<asp:DropDownList ID="ddPageSize" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddPageSize_SelectedIndexChanged" Width="50px" Visible="False">
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
                                    <asp:GridView ID="gridOrden" runat="server" AllowPaging="true" AutoGenerateColumns="False" DataKeyNames="ID_ORDEN,GRUPO_PROCESO,ID_PROCESO,COD_INSTALADOR,ATENDIDO,NUMERO_MN" CellPadding="4" CssClass="GridAlternativeItems" EnableModelValidation="True" ForeColor="#333333" Height="125px" OnPageIndexChanging="gridOrden_PageIndexChanging" OnRowCommand="gridOrden_RowCommand" OnRowCreated="gridOrden_RowCreated" PageSize="100" Width="1250px">
                                        <AlternatingRowStyle BackColor="White" />
                                        <Columns>
                                            <%--CAMPOS NO VISIBLES --%>
                                            <asp:BoundField DataField="ID_ORDEN" HeaderText="ID ORDEN" Visible="False">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="GRUPO_PROCESO" HeaderText="GRUPO" Visible="False">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ID_PROCESO" HeaderText="ID_PROCESO" Visible="False">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="COD_INSTALADOR" HeaderText="COD_INSTALADOR" Visible="False">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ATENDIDO" HeaderText="ATENDIDO" Visible="False">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" />
                                            </asp:BoundField>
                                                                                                                                                                                
                                            <%--CAMPOS VISIBLES --%>
                                            <asp:BoundField DataField="VISITA" HeaderText="VISITA">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="3%" />
                                            <ItemStyle Font-Size="XX-Small" ForeColor="Black" Width="3%" />
                                            </asp:BoundField>
                                             <asp:BoundField DataField="NUMERO_ORDEN" HeaderText="NRO. ORDEN">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="5%" />
                                            <ItemStyle Font-Size="XX-Small" ForeColor="Black" Width="5%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ID_SERVICIO" HeaderText="SERVICIO">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="5%" />
                                            <ItemStyle Font-Size="XX-Small" ForeColor="Black" Width="5%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="LOCALIDAD" HeaderText="LOCALIDAD">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="5%" />
                                            <ItemStyle Font-Size="XX-Small" ForeColor="Black" Width="5%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="SERIE_MEDIDOR_RET" HeaderText="SERE RET.">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="5%" />
                                            <ItemStyle Font-Size="XX-Small" ForeColor="Black" Width="5%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="CAUSA" HeaderText="CAUSA">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="5%" />
                                            <ItemStyle Font-Size="XX-Small" ForeColor="Black" Width="5%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="TIPO_PROCESO" HeaderText="TIPO PROCESO">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="5%" />
                                            <ItemStyle Font-Size="XX-Small" ForeColor="Black" Width="5%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="CONTRATISTA" HeaderText="CONTRATISTA">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="5%" />
                                            <ItemStyle Font-Size="XX-Small" ForeColor="Black" Width="5%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="INSTALADOR" HeaderText="INSTALADOR">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="5%" />
                                            <ItemStyle Font-Size="XX-Small" ForeColor="Black" Width="5%" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="MEDIDOR INSTALADO">
                                                 <EditItemTemplate>
                                                     <asp:TextBox ID="TextBox11" runat="server" Text='<%# Bind("NUMERO_MN") %>'></asp:TextBox>
                                                 </EditItemTemplate>
                                                 <ItemTemplate>                                                                                                      
                                                     <asp:LinkButton ID="lkb_medidor" runat="server" CommandArgument="<%# Container.DataItemIndex%>" CommandName="get_medidor" Text='<%# Bind("NUMERO_MN") %>'> </asp:LinkButton>   
                                                 </ItemTemplate>
                                                 <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="5%" />
                                                 <ItemStyle Font-Size="XX-Small" ForeColor="Black" Width="5%" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="IMPROCEDENCIA" HeaderText="IMPROCEDENCIA">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="5%" />
                                            <ItemStyle Font-Size="XX-Small" ForeColor="Black" Width="5%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ESTADO_MR" HeaderText="ESTADO MEDIDOR RET.">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="5%" />
                                            <ItemStyle Font-Size="XX-Small" ForeColor="Black" Width="5%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="FECHA_INST" HeaderText="FECHA EJECUCION">
                                            <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="5%" />
                                            <ItemStyle Font-Size="XX-Small" ForeColor="Black" Width="5%" />
                                            </asp:BoundField>          
                                            
                                            <%--CAMPOS ACCIONABLES --%>
                                            <asp:TemplateField HeaderText="INFORME">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="btn_informe" runat="server" CommandArgument="<%# Container.DataItemIndex%>" CommandName="informe" ImageUrl="~/Imagenes/informe_pdf.png" />
                                                </ItemTemplate>
                                                <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="3%" />
                                                <ItemStyle Font-Size="XX-Small" ForeColor="White" Width="3%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="CON FOTOS">
                                                <ItemTemplate>
                                                    <asp:Image ID="imgOk" runat="server" ImageUrl="~/Imagenes/correct.png" Visible="False" />
                                                    <asp:Image ID="imgCru" runat="server" ImageUrl="~/Imagenes/error_visor.png" Visible="True" />
                                                    <asp:Image ID="imgneutro" runat="server" ImageUrl="~/Imagenes/nofotos.png" Visible="False" />
                                                </ItemTemplate>
                                                <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="3%" />
                                                <ItemStyle HorizontalAlign="Center" Font-Size="XX-Small" ForeColor="White" Width="3%"/>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="VER FOTOS">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="btn_ver_fotos" runat="server" CommandArgument="<%# Container.DataItemIndex%>" CommandName="ver_fotos" ImageUrl="~/Imagenes/ver_fotos.png" />
                                                </ItemTemplate>
                                                <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="3%" />
                                                <ItemStyle Font-Size="XX-Small" ForeColor="White" Width="3%" />
                                            </asp:TemplateField>
                                                                              
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
