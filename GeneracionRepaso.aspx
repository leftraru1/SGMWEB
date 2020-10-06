<%@ Page Title="Generador de repasos" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="GeneracionRepaso.aspx.cs" Inherits="GeneracionRepaso" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <script src = " https://unpkg.com/sweetalert/dist/sweetalert.min.js "></script> 

        <script type="text/javascript">

            function popInstalador(obj){
                var url = 'popInstalador.aspx?textbox=' + obj;
                window.open(url, 'cal', 'width=820,height=320,left=200,top=50,resizable=0,scrollbars=yes');
            }

            function openCalendar(obj) {
                var url = 'calendario2.aspx?textbox=' + obj;
                window.open(url, 'cal', 'width=260,height=210,left=410 410,top=330,resizable=0,scrollbars=0');
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
    <style>
        body {
            zoom: 90%;
        }
       
        </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h1 class="WebPartTitle">Generación de Repasos</h1>

        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
            

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="loading" align="center">           
                <img src="Imagenes/procesando3.gif" alt="" style="vertical-align:middle" />
            </div>
            <table id="filtros"style="width:100%">
              <tr>
                   <td style="width:5%; height:20px; text-align: right;">Región:</td>
                   <td style="width:15%">
                       <asp:DropDownList ID="cb_region" runat="server" AutoPostBack="True" CssClass="ComboBox" Width="90%" OnSelectedIndexChanged="cb_region_SelectedIndexChanged">
                       </asp:DropDownList>
                   </td>
                   <td style="width:15%" rowspan="7">
                        <asp:LinkButton ID="check_tipo_proceso" runat="server" OnClick="check_tipo_proceso_Click" CssClass="cabecera" >TIPO PROCESO</asp:LinkButton>
                        <div style="OVERFLOW-y:scroll;border: solid 1px black; WIDTH:250px; HEIGHT:120px ;float:left;background-color: white; padding-right:20px;">
                            <asp:CheckBoxList ID="cb_tipo_proceso"  runat="server" RepeatDirection="Vertical" CssClass="check" >
                                <asp:ListItem Selected="True"></asp:ListItem>
                            </asp:CheckBoxList>
                        </div>
                   </td>
                   <td style="width:15%" rowspan="7">
                       <asp:LinkButton ID="check_improcedencia" runat="server" OnClick="check_improcedencia_Click" CssClass="cabecera" >IMPROCEDENCIA</asp:LinkButton>
                        <div style="OVERFLOW-y:scroll;border: solid 1px black; WIDTH:250px; HEIGHT:120px ;float:left;background-color: white; padding-right:20px;">
                            <asp:CheckBoxList ID="cb_improcedencia"  runat="server" RepeatDirection="Vertical" CssClass="check" >
                                <asp:ListItem Selected="True"></asp:ListItem>
                            </asp:CheckBoxList>
                        </div>
                   </td>
                   <td style="width:5%; height:20px ; text-align: right">Desde:</td>
                   <td style="width:30%; height:20px">
                       <asp:TextBox ID="txtDesde" runat="server" CssClass="TextBox3" Width="134px"></asp:TextBox>
                       <img id="IMG7" onclick="openCalendar('ctl00_ContentPlaceHolder1_txtDesde');" src="Imagenes/calendario.gif" />
                       <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtDesde" ErrorMessage="Error formato fecha." ValidationExpression="(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d"></asp:RegularExpressionValidator>
                   </td>
                   <td style="width:15%"></td>
              </tr>
              <tr>
                   <td style="width:5%; height:20px; text-align: right;">Zona:</td>
                   <td>
                       <asp:DropDownList ID="cb_zona" runat="server" AutoPostBack="True" CssClass="ComboBox" Width="90%" OnSelectedIndexChanged="cb_zona_SelectedIndexChanged">
                       </asp:DropDownList>
                   </td>
                   <td style="width:5%; height:20px; text-align: right">Hasta:</td>
                   <td style="height:20px">
                       <asp:TextBox ID="txtHasta" runat="server" CssClass="TextBox3" Width="134px"></asp:TextBox>
                        <img src="Imagenes/calendario.gif" onclick="openCalendar('ctl00_ContentPlaceHolder1_txtHasta');"  id="IMG9" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtHasta" ErrorMessage="Error formato fecha." ValidationExpression="(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d"></asp:RegularExpressionValidator>
                  
                   </td>
                   <td></td>
              </tr>
              <tr>
                   <td style="width:5%; height:20px; text-align: right;">Localidad:</td>
                   <td>
                       <asp:DropDownList ID="cb_localidad" runat="server" AutoPostBack="True" CssClass="ComboBox" Width="90%" OnSelectedIndexChanged="cb_localidad_SelectedIndexChanged">
                       </asp:DropDownList>
                   </td>
                   <td id="label_contratista" runat="server" style="width:5%; height:20px; text-align: right">Contratista:</td>
                   <td style="height:20px">
                       <asp:DropDownList ID="cb_contratista" runat="server" AutoPostBack="True" CssClass="ComboBox" Width="30%" OnSelectedIndexChanged="cb_contratista_SelectedIndexChanged">
                       </asp:DropDownList>
                   </td>
                   <td></td>
              </tr>
              <tr>
                   <td style="width:5%; height:20px; text-align: right;">Lote:</td>
                   <td>
                       <asp:DropDownList ID="cb_lote" runat="server" AutoPostBack="True" CssClass="ComboBox" Width="50%" OnSelectedIndexChanged="cb_lote_SelectedIndexChanged">
                       </asp:DropDownList>
                   </td>
                   <td style="width:5%; height:20px; text-align: right">Servicio:</td>
                   <td style="height:20px">  
                       <asp:TextBox ID="txtServ" runat="server" AutoPostBack="True" CssClass="TextBox3"  Width="30%" ></asp:TextBox>
                       <asp:RegularExpressionValidator ID="valida_serv" runat="server" ControlToValidate="txtServ" ErrorMessage="No es valido el formato" SetFocusOnError="true"  ValidationExpression="\d+"></asp:RegularExpressionValidator>
                    </td>
                   <td></td>
              </tr>
              <tr>
                   <td style="width:5%; height:20px ;text-align: right;">Libreta:</td>
                   <td>
                       <asp:DropDownList ID="cb_libreta" runat="server" AutoPostBack="True" CssClass="ComboBox" Width="50%" OnSelectedIndexChanged="cb_libreta_SelectedIndexChanged">
                       </asp:DropDownList>
                   </td>
                   <td style="width:5%; height:20px; text-align: right">Nro. Orden:</td>
                   <td style="height:20px">
                        <asp:TextBox ID="TextboxNumOrden" runat="server" AutoPostBack="True" CssClass="TextBox3" Width="30%"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="valida_num_ord" runat="server" ControlToValidate="TextboxNumOrden" ErrorMessage="No es valido el formato" SetFocusOnError="true"  ValidationExpression="\d+"></asp:RegularExpressionValidator>
                   </td>
                   <td></td>
              </tr>
              <tr>
                  <td style="width:5%; height:20px ;text-align: right;">N° Visita:</td>
                  <td>
                      <asp:DropDownList ID="cb_visita" runat="server" AutoPostBack="True" CssClass="ComboBox" Width="50%" OnSelectedIndexChanged="cb_visita_SelectedIndexChanged">
                          <asp:ListItem Value="0">Todas</asp:ListItem>
                          <asp:ListItem>1</asp:ListItem>
                          <asp:ListItem>2</asp:ListItem>
                      </asp:DropDownList>
                  </td>
                  <td></td>
                  <td style="vertical-align:middle">
                      <asp:Button ID="Button2" runat="server" CssClass="botonnew" OnClick="Button1_Click1" Text="FILTRAR" Width="30%" />
                  </td>
                  <td></td>
              </tr>
                <tr style="height:40px">
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td style="vertical-align:middle">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
            
            <table id="Table2" runat="server" style="width: 126%; height: 122px;">
                <tr>
                    <td style="height: 29px">
                        <img src="Imagenes/ok.bmp" runat="server" id="IMG2" />&nbsp;
                        <asp:Label ID="lbResultado" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td >Cód. Instalador:
                        <asp:TextBox ID="txtInstalador" runat="server" CssClass="TextBox2"></asp:TextBox>
                        <img src="Imagenes/lupa.bmp" onclick="popInstalador('ctl00_ContentPlaceHolder1_txtInstalador');"  id="IMG1" runat="server"/>
                        <asp:CheckBox ID="check_mismo_operador" runat="server" AutoPostBack="true" Text="Mismo instalador" OnCheckedChanged="check_mismo_operador_CheckedChanged" />
                         &nbsp;<asp:Button ID="btn_generar_repaso" runat="server" CssClass="botonnew" Text="GENERAR REPASO" Width="150px" OnClick="btn_generar_repaso_Click" />
                        <br />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtInstalador" ErrorMessage="Solo números para código de instalador." ValidationExpression="^([0-9]{1,10})$"></asp:RegularExpressionValidator>
                    </td>
                    <td >
                        &nbsp;&nbsp;&nbsp;
                        </td>
                </tr>

                <tr>
                    <td style="width:900px;" >
                        <asp:Label ID="lbTotal" runat="server"></asp:Label>
                        <asp:Label ID="lbErrorGrilla" runat="server"></asp:Label>
                    </td>
                </tr>

                <tr>
                    <td class="auto-style7" colspan="6">
                        <asp:Panel ID="panGrid" runat="server" Height="326px" HorizontalAlign="Center" ScrollBars="auto"  Width="1650px">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="gridOrden" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" CssClass="GridAlternativeItems" EnableModelValidation="True" ForeColor="#333333" Height="100px" OnPageIndexChanging="gridOrden_PageIndexChanging" OnRowCommand="gridOrden_RowCommand" OnRowDataBound="gridOrden_RowDataBound" PageSize="40" Width="1600px">
                                        <AlternatingRowStyle BackColor="White" />
                                        <Columns>
                                            <asp:BoundField DataField="ID_ORDEN" HeaderText="idOrden">
                                            <HeaderStyle ForeColor="White" />
                                            </asp:BoundField>

                                            <asp:TemplateField HeaderText="Marcar">
                                                <HeaderTemplate>
                                                    <asp:LinkButton ID="lkbMarcar" runat="server" CommandName="marcar">Marcar</asp:LinkButton>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="check_marca" runat="server" />
                                                </ItemTemplate>
                                                <HeaderStyle ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                                            </asp:TemplateField>

                                             <asp:BoundField DataField="VISITA" HeaderText="Visita">
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="NUMERO_ORDEN" HeaderText="Número orden">
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="ID_SERVICIO" HeaderText="Servicio">
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>                                          

                                           <asp:BoundField DataField="FECHA_CREACION" HeaderText="Fecha creación" >
                                                <HeaderStyle ForeColor="White" />
                                                <ItemStyle Font-Size="Smaller" Width="60px" />
                                            </asp:BoundField>
                                           
                                            <asp:BoundField DataField="FECHA_INTEGRACION" HeaderText="Fecha ingreso SGM" >
                                                <HeaderStyle ForeColor="White" />
                                                <ItemStyle Font-Size="Smaller" Width="70px" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="DIAS_TRANSCURRIDOS" HeaderText="Días transcurridos" >
                                                <HeaderStyle ForeColor="White" />
                                                <ItemStyle Font-Size="Smaller" width="50px"  />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="RUTA" HeaderText="Ruta">
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
                                            <asp:BoundField DataField="TIPO_PROCESO" HeaderText="Tipo Proceso"> 
                                            <HeaderStyle ForeColor="White" Width="200px" />
                                            <ItemStyle Font-Size="Smaller" Width="200px" />
                                            </asp:BoundField>
                                           
                                            <asp:BoundField DataField="ID_SINCRONIZACION" HeaderText="id_sincronizacion">
                                            </asp:BoundField>

                                            <asp:BoundField DataField="INSTALADOR" HeaderText="Instalador">
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>                        
                                                                                      
                                            <asp:BoundField DataField="DIAS_SLA" HeaderText="DIAS_SLA">
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>
                                            
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

