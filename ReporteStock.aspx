<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/menu.master" CodeFile="ReporteStock.aspx.cs" Inherits="ReporteStock" %>

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

            function ShowProgress() {
                setTimeout(function () {
                    var modal = $('<div />');
                    modal.addClass("modal");
                    $('body').append(modal);
                    var loading = $(".loading");
                    loading.show();
                    var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
                    var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0) + 100;
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
       
        .auto-style5 {
            height: 29px;
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
        .auto-style7 {
            width: 15%;
            height: 20px;
        }
        .auto-style8 {
            height: 20px;
        }
        .auto-style10 {
            height: 20px;
            width: 1%;
        }
        .auto-style11 {
            width: 10%;
            height: 20px;
        }
        .auto-style15 {
            height: 20px;
        }
        .auto-style17 {
            width: 10%
        }
        .auto-style18 {
            width: 12%;
            height: 20px;
        }
        </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h1 class="WebPartTitle">Reporte de stock</h1>

        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
            

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div  class="loading" align="center">           
                        <img src="Imagenes/loading.gif" alt="" style="vertical-align:middle;width:200px;height:140px;" />
              </div>
            <table id="filtros"style="width:100%">
              <tr>
                   <td style="text-align: right;" class="auto-style10"></td>
                  <td style="text-align: left;" class="auto-style15" colspan="2">
                      Contratista:
                       <asp:DropDownList ID="cb_contratista" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="cb_contratista_SelectedIndexChanged" Width="50%">
                       </asp:DropDownList>
                       
                  </td>
                  
                   <td style="text-align: left; visibility:hidden;" class="auto-style15">Desde:
                       <asp:TextBox ID="txtDesde" runat="server" CssClass="TextBox3" Width="134px"></asp:TextBox>
                       <img id="IMG1" onclick="openCalendar('ctl00_ContentPlaceHolder1_txtDesde');" src="Imagenes/calendario.gif" />
                       <br />
                       <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="txtDesde" ErrorMessage="Error formato fecha." ValidationExpression="(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d"></asp:RegularExpressionValidator>
                   </td>
                   <td style="text-align: left; visibility:hidden;" class="auto-style18">Hasta:
                       <asp:TextBox ID="txtHasta" runat="server" CssClass="TextBox3" Width="134px"></asp:TextBox>
                       <img src="Imagenes/calendario.gif" onclick="openCalendar('ctl00_ContentPlaceHolder1_txtHasta');"  id="IMG11" />
                       <br />
                       <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="txtHasta" ErrorMessage="Error formato fecha." ValidationExpression="(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d"></asp:RegularExpressionValidator>
                   
                   </td>
                  <td class="auto-style11" style="text-align: left;">&nbsp;</td>
                                 
                   <td style="text-align: right;" class="auto-style11"></td>
                   <td style="text-align: right;" class="auto-style11"></td>
              </tr>
              <tr>
                   <td style="text-align: right;" class="auto-style10">&nbsp;</td>
                   <td rowspan="8" class="margen_izq">
                        <asp:LinkButton ID="check_region" runat="server" OnClick="check_region_Click" CssClass="cabecera" >REGION</asp:LinkButton>
                        <div style="OVERFLOW-y:scroll;border: solid 1px black; WIDTH:150px; HEIGHT:160px;float:left;background-color: white; padding-right:20px;">
                            <asp:CheckBoxList ID="cb_region"  runat="server" RepeatDirection="Vertical" AutoPostBack="true" CssClass="check" OnSelectedIndexChanged="cb_region_SelectedIndexChanged" >
                                <asp:ListItem Selected="True"></asp:ListItem>
                            </asp:CheckBoxList>
                        </div>

                   </td>
                   <td rowspan="8" class="margen_izq">
                        <asp:LinkButton ID="check_bodega" runat="server" OnClick="check_bodega_Click" CssClass="cabecera" >BODEGA</asp:LinkButton>
                        <div style="OVERFLOW-y:scroll;border: solid 1px black; WIDTH:160px; HEIGHT:160px;float:left;background-color: white; padding-right:20px;">
                            <asp:CheckBoxList ID="cb_bodega"  runat="server" RepeatDirection="Vertical" CssClass="check" >
                                <asp:ListItem Selected="True"></asp:ListItem>
                            </asp:CheckBoxList>
                        </div>
                   </td>
                   <td rowspan="8" class="margen_izq">
                       <asp:LinkButton ID="check_categoria" runat="server" OnClick="check_categoria_Click" CssClass="cabecera" >CATEGORIA</asp:LinkButton>
                        <div style="OVERFLOW-y:scroll;border: solid 1px black; WIDTH:150px; HEIGHT:160px;float:left;background-color: white; padding-right:20px;">
                            <asp:CheckBoxList ID="cb_categoria"  runat="server" RepeatDirection="Vertical" CssClass="check" >
                                <asp:ListItem Selected="True"></asp:ListItem>
                            </asp:CheckBoxList>
                        </div>
                   </td>
                   <td rowspan="8" class="margen_izq">
                       <asp:LinkButton ID="check_diametro" runat="server" OnClick="check_diametro_Click" CssClass="cabecera" >DIAMETRO</asp:LinkButton>
                        <div style="OVERFLOW-y:scroll;border: solid 1px black; WIDTH:150px; HEIGHT:160px;float:left;background-color: white; padding-right:20px;">
                            <asp:CheckBoxList ID="cb_diametro"  runat="server" RepeatDirection="Vertical" CssClass="check" >
                                <asp:ListItem Selected="True"></asp:ListItem>
                            </asp:CheckBoxList>
                        </div>
                       <br />
                   </td>
                   <td class="auto-style17" rowspan="8" style="text-align: center; vertical-align: middle">
                       <asp:Button ID="Button2" runat="server" CssClass="botonnew" OnClick="Button1_Click1"  Text="FILTRAR" Width="80%" />
                       <%--OnClientClick="return ShowProgress();"--%>
                       <br />
                       <br />
                       <asp:Button ID="btn_genera_excel" runat="server" CssClass="botonnew" OnClick="btn_genera_excel_Click" Text="DESCARGAR EXCEL" Width="80%" />
                   </td>
                   <td style="width:30%; height:20px">
                      </td>
                   <td style="width:15%"></td>
              </tr>
              <tr>
                   <td style="text-align: right;" class="auto-style10"></td>
                   <td class="auto-style8">
                       
                   </td>
                   <td class="auto-style8"></td>
              </tr>
              <tr>
                   <td style="text-align: right;" class="auto-style10">&nbsp;</td>
                   <td style="height:20px">
                       &nbsp;</td>
                   <td></td>
              </tr>
              <tr>
                   <td style="text-align: right;" class="auto-style10">&nbsp;</td>
                   <td style="height:20px">  
                       &nbsp;</td>
                   <td></td>
              </tr>
              <tr>
                   <td style="text-align: right;" class="auto-style10">&nbsp;</td>
                   <td style="height:20px">
                        &nbsp;</td>
                   <td></td>
              </tr>
              <tr>
                  <td style="text-align: right;" class="auto-style10">&nbsp;</td>
                  <td style="vertical-align:middle">
                      &nbsp;</td>
                  <td></td>
              </tr>
                <tr>
                    <td style="text-align: right;" class="auto-style10">&nbsp;</td>
                    <td style="vertical-align:middle">
                        &nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr style="height:40px">
                    <td class="puntos">&nbsp;</td>
                    <td>
                        &nbsp;</td>
                    <td style="vertical-align:middle">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
            
            <table id="Table2" runat="server" style="width: 126%; height: 122px;">
                <tr>
                    <td class="auto-style5">
                        <img src="Imagenes/ok.bmp" runat="server" id="IMG2" />&nbsp;
                        <asp:Label ID="lbResultado" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;" >
                        <br />
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
                                    <asp:GridView ID="gridOrden" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" CssClass="GridAlternativeItems" EnableModelValidation="True" ForeColor="#333333" Height="100px" OnPageIndexChanging="gridOrden_PageIndexChanging" OnRowDataBound="gridOrden_RowDataBound" PageSize="40" Width="60%">
                                        <AlternatingRowStyle BackColor="White" />
                                        <Columns>
                                            <asp:BoundField DataField="CATEGORIA" HeaderText="Categoria">
                                            <HeaderStyle ForeColor="White" />
                                            </asp:BoundField>
                                            
                                            <asp:BoundField DataField="DIAMETRO" HeaderText="Diametro">
                                            <HeaderStyle ForeColor="White" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="NO_DISPONIBLE" HeaderText="No disponible" Visible="false">
                                            <HeaderStyle ForeColor="White" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="POR_VALIDAR" HeaderText="Por validar">
                                            <HeaderStyle ForeColor="White" />
                                            </asp:BoundField>                                          

                                           <asp:BoundField DataField="DISPONIBLE" HeaderText="Disponible" >
                                                <HeaderStyle ForeColor="White" />
                                            </asp:BoundField>
                                           
                                            <asp:BoundField DataField="ASIGNADO" HeaderText="Asignado" >
                                                <HeaderStyle ForeColor="White" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="EN_TERRENO" HeaderText="En terreno" >
                                                <HeaderStyle ForeColor="White" />
                                            </asp:BoundField>                 
                                            
                                            <asp:BoundField DataField="INSTALADO" HeaderText="Instalado" >
                                                <HeaderStyle ForeColor="White" />
                                            </asp:BoundField>                
                                            
                                            <asp:BoundField DataField="DADO_BAJA" HeaderText="Dado de baja" Visible="false">
                                                <HeaderStyle ForeColor="White" />
                                            </asp:BoundField>     

                                            <asp:BoundField DataField="EXTRAVIADO" HeaderText="Extraviado" Visible="false">
                                                <HeaderStyle ForeColor="White" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="EN_DIFERENCIA" HeaderText="En diferencia">
                                                <HeaderStyle ForeColor="White" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="TOTAL" HeaderText="Total" >
                                                <HeaderStyle ForeColor="White" />
                                            </asp:BoundField>

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
                    <td class="auto-style7">&nbsp;</td>
                </tr>

            </table>
        </ContentTemplate>
    </asp:UpdatePanel>

    </asp:Content>

