<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="VisorGuia.aspx.cs" Inherits="VisorGuia" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
       
    <script src = " https://unpkg.com/sweetalert/dist/sweetalert.min.js "></script> 

    <style type="text/css">
        .auto-style7
        {
            height: 43px;
        }
        .auto-style24
        {
            height: 7px;
            text-align:right;
        }
        .auto-style1
        {
            height: 7px;
            width: 120px;
        }
        .auto-style4
        {
            width: 20px;
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
        .auto-style43 {
            height: 12px;
        }
        #IMG8
        {
            margin-top: 0px;
        }
        #IMG10
        {
            margin-top: 0px;
        }
        .auto-style77
        {
            height: 7px;
            text-align: left;
        }
        .auto-style78
        {
            height: 7px;
            text-align: left;
            width: 260px;
        }
        .auto-style79
        {
            height: 7px;
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
            border: 5px solid #67CFF5;
            width: 200px;
            height: 100px;
            display: none;
            position: fixed;
            background-color: White;
            z-index: 999;
        }

        .auto-style81 {
            height: 7px;
            width: 69px;
        }
        .styletd{
             text-align:left ;
             width: 320px;
             padding-bottom:10px;
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
            alert('EL RECLAMO NO AMERITA FOTOS!');
        }

        function alertaNoExisteFoto(numero) {
            alert('EL RECLAMO NO TIENE FOTOS! (POSIBLE ERROR DE DESCARGA)');
        }

        //function cambio_ordenes(ordenes_as, ordenes_des) {
        //    swal("Cambios efectuados ", "Se asignaron : " + ordenes_as + " orden(es)\nSe desasignaron: " + ordenes_des + " orden(es)", "success");
        //}
        function error_carga(msg) {
            swal("¡ERROR! ", msg, "warning");
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

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1 class="WebPartTitle">Visor Guias de despacho / traspaso<asp:Label ID="lb_rut_empresa" runat="server" Visible="False"></asp:Label>
            <asp:Label ID="lb_contratista" runat="server" Visible="False"></asp:Label>
            <asp:Label ID="lb_id_perfil" runat="server" Visible="False"></asp:Label>
            
            <asp:Label ID="lb_id_usuario" runat="server" Visible="False"></asp:Label>
            
            </h1>

        <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
             <div class="loading" align="center">           
                <img src="Imagenes/procesando3.gif" alt="" style="vertical-align:middle" />
            </div>
            <table id="tablaAsig" style="width: 100%; height: 122px;">
                <tr>
                    <td class="styletd" >
                        <asp:Label ID="lbregion"   runat="server" class="label" Text="REGION:"></asp:Label>
                        <asp:DropDownList ID="ddregion" runat="server" AutoPostBack="True" CssClass="ComboBox"  Width="195px" ></asp:DropDownList>
                    </td>
                    
                    <td class="styletd" >
                        <asp:Label ID="Lbfechadesde" runat="server" class="label" Text="DESDE"></asp:Label>
                        <asp:TextBox ID="txtDesde" runat="server" CssClass="TextBox3" Width="134px"></asp:TextBox>
                        <img src="Imagenes/calendario.gif" onclick="openCalendar('ctl00_ContentPlaceHolder1_txtDesde');"  id="IMG7" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtDesde" ErrorMessage="Error formato fecha." ValidationExpression="(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d"></asp:RegularExpressionValidator>
                        
                    </td>
                    <%--<td class="styletd" ><asp:Label ID="Label1" runat="server" class="label" Text="CONTRATISTA:" ></asp:Label>
                        <asp:DropDownList ID="ddContratista" runat="server" AutoPostBack="True" CssClass="ComboBox"  Width="195px">
                        </asp:DropDownList>
                    </td>--%>
                </tr>
                <tr>
                    <td class="styletd" ><asp:Label ID="Lbbodega" runat="server" class="label" Text="BODEGA:"></asp:Label>
                        <asp:DropDownList ID="ddbodega" runat="server" AutoPostBack="True" CssClass="ComboBox"  Width="195px">
                        </asp:DropDownList>
                    </td>
                    
                    <td class="styletd" ><asp:Label ID="Lbhasta" runat="server" class="label" Text="HASTA"></asp:Label>
                        <asp:TextBox ID="txtHasta" runat="server" CssClass="TextBox3" Width="134px"></asp:TextBox>
                        <img src="Imagenes/calendario.gif" onclick="openCalendar('ctl00_ContentPlaceHolder1_txtHasta');"  id="IMG9" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtHasta" ErrorMessage="Error formato fecha." ValidationExpression="(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d"></asp:RegularExpressionValidator>
                      
                    </td>
                    
                </tr>
                <tr>
                        <td class="styletd" >
                        <asp:Label   ID="lbnroguia" runat="server" Text="N° GUIA: " ></asp:Label>
                        <asp:TextBox ID="txtguia" runat="server" AutoPostBack="True" CssClass="TextBox"  OnTextChanged="txtServ_TextChanged" Width="120px"></asp:TextBox>
                     </td>
                </tr>
                <tr><td></td></tr>
                <tr>

                    <td class="auto-style81" style="text-align: right">
                        
                    </td>
                    
                    <td class="auto-style1">
                        <asp:Button ID="btn_buscar" runat="server" CssClass="botonnew" Height="20px" OnClick="btn_buscar_Click" Text="BUSCAR" Width="175px" />
                        </td>
                    <td class="auto-style78" colspan="2">
                       <asp:Button ID="btn_limpiar" runat="server" CssClass="botonnew" Height="20px" OnClick="btn_limpiar_Click" Text="LIMPIAR" Width="175px" />
                        </td>
                    <td class="auto-style1" colspan="1">
                        &nbsp;</td>
                    <td class="auto-style77" colspan="2">&nbsp;</td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="auto-style79" colspan="3">
                        <img src="~/Imagenes/caution.png" runat="server"  id="IMG4" />
                        <img src="~/Imagenes/correct.png" runat="server" id="IMG2" />
                        <asp:Label ID="lbTxtIn" runat="server"></asp:Label>
                        <asp:Table ID="tbl_link" runat="server" CssClass="auto-style24" Font-Bold="True" Height="21px" style="margin-bottom: 7px" Width="300px">
                        </asp:Table>
                    </td>
                    <td class="auto-style24" colspan="3">
                        &nbsp;</td>
                    <td class="auto-style77" colspan="2">
                    </td>
                    <td class="auto-style79">
                        &nbsp;</td>
                    
                    
                    <td class="auto-style79">
                        </td>
                    
                    
                </tr>
                <tr>
                    <td class="auto-style79" colspan="9">
                        <asp:Label ID="lbTotal" runat="server"></asp:Label>
                        &nbsp;<asp:DropDownList ID="ddPageSize" runat="server" Visible="false" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddPageSize_SelectedIndexChanged" Width="50px">
                            <asp:ListItem>100</asp:ListItem>
                            <asp:ListItem>50</asp:ListItem>
                            <asp:ListItem>25</asp:ListItem>
                            <asp:ListItem>10</asp:ListItem>
                        </asp:DropDownList>
                        &nbsp; <asp:Label ID="lbErrorGrilla" runat="server"></asp:Label>
                    </td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="auto-style7" colspan="9">
                         <asp:Panel ID="panGridHistorico" runat="server" Height="600px" HorizontalAlign="Center" ScrollBars="Auto" Width="1420px" CssClass="auto-style80">
                            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="gridOrdenHistorico" runat="server" AutoGenerateColumns="False" CellPadding="4" CssClass="GridAlternativeItems" EnableModelValidation="True" ForeColor="#333333" Height="125px" OnPageIndexChanging="gridOrden_PageIndexChanging" OnRowCommand="gridOrden_RowCommand" OnRowCreated="gridOrden_RowCreated" OnSelectedIndexChanged="gridOrden_SelectedIndexChanged" AllowPaging="true" PageSize="100" Width="1350px">
                                        <AlternatingRowStyle BackColor="White" />
                                        <Columns>
                                                                                              
                                            <asp:BoundField DataField="ID_GUIA" HeaderText=" ID_GUIA" Visible="False">
                                            <HeaderStyle ForeColor="White" Font-Size="XX-Small" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="NUMERO_GUIA" HeaderText=" NUMERO GUIA" Visible="true">
                                            <HeaderStyle ForeColor="White" Font-Size="XX-Small" />
                                            </asp:BoundField>
                                            <%--<asp:TemplateField HeaderText="NUMERO GUIA"  >
                                                <HeaderTemplate>
                                                    <asp:LinkButton ID="NUMERO_GUIA" runat="server" OnClick="NUMERO_GUIA_Click" OnClientClick="return ShowProgress();" ForeColor="White">NUMERO GUIA</asp:LinkButton>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lb_nroguia" runat="server" Text='<%# Eval("NUMERO_GUIA")%>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle ForeColor="White" Font-Size="XX-Small" />
                                            </asp:TemplateField>--%>

                                            <asp:BoundField DataField="ID_TIPO_GUIA" HeaderText=" TIPO GUIA" Visible="true">
                                            <HeaderStyle ForeColor="White" Font-Size="XX-Small" />
                                            </asp:BoundField>
                                         
                                            <%--<asp:TemplateField HeaderText="TIPO GUIA"  >
                                                <HeaderTemplate>
                                                    <asp:LinkButton ID="ID_TIPO_GUIA" runat="server" OnClick="ID_TIPO_GUIA_Click" OnClientClick="return ShowProgress();" ForeColor="White">TIPO GUIA</asp:LinkButton>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lb_tipoguia" runat="server" Text='<%# Eval("ID_TIPO_GUIA")%>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle ForeColor="White" Font-Size="XX-Small" />
                                            </asp:TemplateField>--%>

                                            <asp:TemplateField HeaderText="ESTADO GUIA"  >
                                                <HeaderTemplate>
                                                    <asp:LinkButton ID="ESTADO_GUIA" runat="server" OnClick="ESTADO_GUIA_Click" OnClientClick="return ShowProgress();" ForeColor="White">ESTADO GUIA </asp:LinkButton>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lb_estadoguia" runat="server" Text='<%# Eval("ESTADO_GUIA")%>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle ForeColor="White" Font-Size="XX-Small" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="BODEGA_ORIGEN"  >
                                                <HeaderTemplate>
                                                    <asp:LinkButton ID="BODEGA_ORIGEN" runat="server" OnClick="BODEGA_ORIGEN_Click" OnClientClick="return ShowProgress();" ForeColor="White">BODEGA ORIGEN</asp:LinkButton>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lb_borigen" runat="server" Text='<%# Eval("BODEGA_ORIGEN")%>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle ForeColor="White" Font-Size="XX-Small" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="BODEGA_DESTINO"  >
                                                <HeaderTemplate>
                                                    <asp:LinkButton ID="DESTINO" runat="server" OnClick="DESTINO_Click" OnClientClick="return ShowProgress();" ForeColor="White">BODEGA DESTINO</asp:LinkButton>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lb_direccion" runat="server" Text='<%# Eval("BODEGA_DESTINO")%>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle ForeColor="White" Font-Size="XX-Small" />
                                            </asp:TemplateField>

                                            <asp:BoundField DataField="FECHA_DESPACHO" HeaderText="FECHA DESPACHO">
                                            <HeaderStyle ForeColor="White" Font-Size="XX-Small" />
                                            <ItemStyle Font-Size="XX-Small" />
                                            </asp:BoundField>

                                        <%--    <asp:BoundField DataField="CONCATENARCB" HeaderText="TOTAL DEUDA">
                                           <HeaderStyle ForeColor="White" Font-Size="XX-Small" />
                                            <ItemStyle Font-Size="XX-Small" />
                                            </asp:BoundField>
                                                               --%>                     
                                            <asp:TemplateField HeaderText="DETALLE GUIA">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="btn_informe" runat="server" CommandArgument="<%# Container.DataItemIndex%>" CommandName="informe_guia" ImageUrl="~/Imagenes/informe_pdf.png" Visible="true" />
                                                   <%-- <asp:ImageButton ID="btn_informe_no" runat="server" CommandArgument="<%# Container.DataItemIndex%>" CommandName="informe_no" ImageUrl="~/Imagenes/nofotos.png" Visible="false" />                                                    --%>
                                                </ItemTemplate>
                                               <HeaderStyle ForeColor="White" Font-Size="XX-Small" />
                                            </asp:TemplateField>
                                             <asp:TemplateField HeaderText="RESPALDO GUIA">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="btn_respaldoguia" runat="server" CommandArgument="<%# Container.DataItemIndex%>" CommandName="respaldo_guia" ImageUrl="~/Imagenes/confoto.png" Visible="true" OnClientClick="aspnetForm.target ='_blank';" />
                                                    <asp:ImageButton ID="btn_respaldoguiano" runat="server" CommandArgument="<%# Container.DataItemIndex%>" CommandName="respaldo_guiano" ImageUrl="~/Imagenes/sinfoto.png" Visible="false" />                                                    
                                                </ItemTemplate>
                                               <HeaderStyle ForeColor="White" Font-Size="XX-Small" />
                                            </asp:TemplateField>
                                           <%--<asp:TemplateField HeaderText="ORDENAR_ASISTENTE"  >
                                                <HeaderTemplate>
                                                    <asp:LinkButton ID="ORDENAR_ASISTENTE" runat="server" OnClick="ORDENAR_ASISTENTE_Click" OnClientClick="return ShowProgress();" ForeColor="White">ASISTENTE DESIGNADO</asp:LinkButton>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lb_asistente" runat="server" Font-Size="XX-Small" Text='<%# Eval("ASISTENTE")%>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle ForeColor="White" Font-Size="XX-Small" />
                                            </asp:TemplateField>--%>
                                            <%-- <asp:TemplateField HeaderText="INFORME SOCIAL">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="btn_social" runat="server" CommandArgument="<%# Container.DataItemIndex%>" CommandName="social" ImageUrl="~/Imagenes/informe_pdf.png" Visible="true" />
                                                    <asp:ImageButton ID="btn_social_no" runat="server" CommandArgument="<%# Container.DataItemIndex%>" CommandName="social_no" ImageUrl="~/Imagenes/nofotos.png" Visible="false" />
                                                
                                                </ItemTemplate>
                                                <HeaderStyle ForeColor="White" Font-Size="XX-Small" />
                                            </asp:TemplateField>--%>
                                            <%--<asp:TemplateField HeaderText="FECHA_EJECUCION"  >
                                                <HeaderTemplate>
                                                    <asp:LinkButton ID="FECHA_EJECUCION" runat="server" OnClick="FECHA_EJECUCION_Click" OnClientClick="return ShowProgress();" ForeColor="White">FECHA EJECUCION</asp:LinkButton>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lb_fecha" runat="server" Font-Size="XX-Small" Text='<%# Eval("FECHA_EJECUCION")%>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle ForeColor="White" Font-Size="XX-Small" />
                                            </asp:TemplateField>   --%>        
                                           <%--  <asp:BoundField DataField="CLAVE_GESTION" HeaderText="CLAVE GESTION">
                                            <HeaderStyle ForeColor="White" Font-Size="XX-Small" />
                                            <ItemStyle Font-Size="XX-Small" />
                                            </asp:BoundField> --%>                    
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
                    </td>
                    <td colspan="2" class="auto-style7">
                       
                    <td class="auto-style7"></td>
                </tr>
                <tr>
                    <td class="auto-style43" colspan="9">
                        &nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>

    </asp:Content>
