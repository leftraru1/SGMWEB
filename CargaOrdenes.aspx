<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="CargaOrdenes.aspx.cs" Inherits="CargaOrdenes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    <script src = " https://unpkg.com/sweetalert/dist/sweetalert.min.js "></script> 
    <style type="text/css">
        
        .auto-style50
        {
            width: 780px;
            margin-left: 40px;
        }

        .auto-style59
        {
            height: 18px;
            text-align: right;
            width: 40px;
        }

        .auto-style61
        {
            width: 265px;
            height: 18px;
            text-align: center;
        }

        .auto-style63
        {
            width: 147px;
            height: 18px;
            text-align: left;
        }

        .auto-style64
        {
            height: 18px;
        }

        .auto-style65
        {
            width: 109px;
            height: 18px;
            text-align: left;
        }

        .auto-style67
    {
        width: 780px;
        height: 19px;
    }
    .auto-style68
    {
        height: 19px;
    }
        .auto-style69
        {
            height: auto;
            width: 1250px;
        }
        .auto-style70
        {
            width: 780px;
            height: 23px;
        }
        .auto-style71
        {
            height: 23px;
            text-align: right;
            width: 40px;
        }
        .auto-style72
        {
            height: 23px;
        }
        .auto-style77
        {
            height: 18px;
            text-align: center;
        }
        .auto-style78
        {
            height: 37px;
            text-align: center;
            width: 40px;
        }
        .auto-style82
        {
            height: 26px;
            text-align: center;
        }
        .auto-style88
        {
            height: 18px;
            text-align: center;
            width: 40px;
        }
        .auto-style89
        {
            height: 26px;
            text-align: center;
            width: 40px;
        }
        .auto-style91
        {
            width: 265px;
            text-align: center;
            height: 26px;
        }
        .auto-style92
        {
            width: 109px;
            text-align: left;
            height: 26px;
        }
        .auto-style93
        {
            width: 147px;
            text-align: left;
            height: 26px;
        }
        .auto-style96
        {
            height: 33px;
            text-align: center;
            width: 40px;
        }
        .auto-style97
        {
            width: 780px;
            height: 33px;
        }
        .auto-style98
        {
            height: 33px;
        }
        .auto-style100
        {
            text-align: center;
            width: 40px;
        }
        .auto-style101
        {
            height: 24px;
        }
    .auto-style102
    {
        width: 24px;
        height: 24px;
    }
        .auto-style103 {
            height: 19px;
        }
        .auto-style104 {
            width: 159px;
            height: 18px;
            text-align: center;
        }
        .auto-style105 {
            height: 19px;
            width: 159px;
        }
        .auto-style106 {
            height: 19px;
            text-align: right;
            width: 40px;
        }
        .auto-style107 {
            width: 159px;
        }
    </style>
    <script type="text/javascript">

        function openCalendar(obj) {
            var url = 'calendario2.aspx?textbox=' + obj;
            window.open(url, 'cal', 'width=260,height=210,left=410 410,top=330,resizable=0,scrollbars=0');
        }   

        function mensaje_ok(msg) {
            swal("CARGA REALIZADA!", msg, "success");
        }

        function mensaje_ok2(msg) {
            swal("ÉXITO!", msg, "success");
        }

        function mensaje_error(msg) {
            swal("¡ERROR! ", msg, "warning");
        }

        function confirmBeforePostback(obj) {
            var res = $(obj).attr('onclick').split(';');

            if (res.length > 1) {
                swal({
                    title: "Are you sure?",
                    text: "The will delete your record, are you sure?",
                    showCancelButton: true,
                    closeOnConfirm: true,
                    closeOnCancel: true
                },
                    function (isConfirm) {
                        if (isConfirm) {
                            eval(res[1]);
                        }
                    });
            }
            return false;
        }
        

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1 class="WebPartTitle">Cargar Ordenes de cambio de medidor

        <asp:Label ID="lb_rut_empresa" runat="server" Visible="False"></asp:Label>

        &nbsp;<asp:Label ID="lb_id_usuario" runat="server" Visible="False"></asp:Label>

        <asp:Label ID="lb_id_perfil" runat="server" Visible="False"></asp:Label>

    </h1>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <table class="auto-style69">
        <tr>
            <td class="auto-style59"></td>
            <td class="auto-style104">
                </td>
            <td class="auto-style61"></td>
            <td class="auto-style65">
                </td>
            <td class="auto-style63">
                </td>
            <td class="auto-style64"></td>
        </tr>
        <tr>
            <td class="auto-style59"></td>
            <td class="auto-style4" colspan="2">
                <asp:Label ID="Label8" runat="server" Font-Bold="True" Text="SELECCIONE EL ARCHIVO DE CARGA" Width="250px"></asp:Label>
            </td>
            <td class="auto-style65">
                &nbsp;</td>
            <td class="auto-style63">
                &nbsp;</td>
            <td class="auto-style64"></td>
        </tr>
        <tr>
            <td class="auto-style71">
                &nbsp;</td>
            <td class="auto-style70" colspan="4">
                <asp:FileUpload ID="fuArchivo" runat="server" BorderStyle="None" Width="810px" CssClass="Button" BackColor="#CCCCCC" Font-Bold="True" />
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="fuArchivo" ErrorMessage="No se ha seleccionado ningún archivo." ValidationGroup="btCargar"></asp:RequiredFieldValidator>
                <br />
                <asp:RegularExpressionValidator ID="FileUpLoadValidator" runat="server" ErrorMessage="Solo archivos .xls/.xlsx" ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))(.xls|.xlsx)$" ControlToValidate="fuArchivo" ValidationGroup="btCargar"></asp:RegularExpressionValidator>
                <br />
            </td>
            <td class="auto-style72">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style89">&nbsp;</td>
            <td class="auto-style105">

                        FECHA PROCESO:<asp:TextBox ID="fechaPro" runat="server" ReadOnly="false" CssClass="TextBox3" Enabled="False"></asp:TextBox>
                             &nbsp;<asp:Image ID="Image1" runat="server" onclick="openCalendar('ctl00_ContentPlaceHolder1_fechaPro');" ImageUrl="~/Imagenes/calendario.gif" />
                             &nbsp;<asp:RequiredFieldValidator ID="rfvFecha" runat="server" ControlToValidate="fechaPro" ErrorMessage="*"></asp:RequiredFieldValidator>
                         </td>
            <td class="auto-style91">
                &nbsp;</td>
            <td class="auto-style92">
                &nbsp;</td>
            <td class="auto-style93">
                &nbsp;</td>
            <td class="auto-style82">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style89">&nbsp;</td>
            <td class="auto-style105">

                        TIPO PROCESO:<asp:DropDownList ID="ddTproceso" runat="server" Height="16px" Width="250px" CssClass="ComboBox2">
                    </asp:DropDownList>
                        </td>
            <td class="auto-style91" style="text-align: left">
                CONTRATISTA:<asp:DropDownList ID="ddContratista" runat="server" Height="16px" Width="250px" CssClass="ComboBox2">
                    </asp:DropDownList>
            </td>
            <td class="auto-style92">
                &nbsp;</td>
            <td class="auto-style93">
                &nbsp;</td>
            <td class="auto-style82">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style89"></td>
            <td class="auto-style105">

                        &nbsp;</td>
            <td class="auto-style91">
            </td>
            <td class="auto-style92">
            </td>
            <td class="auto-style93">
            </td>
            <td class="auto-style82"></td>
        </tr>
        <tr>
            <td class="auto-style106"></td>
            <td class="auto-style107">
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btn_cargar" runat="server" CssClass="botonnew" OnClick="Button2_Click" Text="CARGAR ORDENES" ValidationGroup="btn_cargar" Height="20px" Width="134px" />
            </td>
            <td class="auto-style103" colspan="3">
                    <asp:Label ID="lb_causa_error" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" ForeColor="Red" Visible="False"></asp:Label>
                    </td>
            <td class="auto-style68"></td>
        </tr>
        <tr>
            <td class="auto-style88"></td>
            <td class="auto-style77" colspan="4">
                <hr style="color: #006699" />
            </td>
            <td class="auto-style77"></td>
        </tr>
        <tr>
            <td class="auto-style96">&nbsp;</td>
            <td class="auto-style97" colspan="4">
                <asp:RadioButtonList ID="rbCargados" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" OnSelectedIndexChanged="rbCargados_SelectedIndexChanged">
                    <asp:ListItem Value="0">RESULTADOS</asp:ListItem>
                    <asp:ListItem Value="1">DETALLE</asp:ListItem>
                </asp:RadioButtonList>
            &nbsp;&nbsp;
                <asp:Button ID="btn_otro" runat="server" CssClass="botonnew" OnClick="btn_otro_Click" Text="CARGAR OTRO" ValidationGroup="btn_cargar_otro" Height="20px" Width="104px" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btn_descartar" runat="server" CssClass="botonnew" Text="DESCARTAR CARGA" ValidationGroup="btn_descartar" Height="20px" Width="134px" OnClick="btn_descartar_Click" OnClientClick= "return confirm('¿Está seguro de descartar lo procesado?, se limpiará toda carga y su proceso.');"/>
            &nbsp; </td>
            <td class="auto-style98"></td>
        </tr>
        <tr>
            <td class="auto-style78">&nbsp;</td>
            <td class="auto-style50" colspan="4" style="vertical-align: middle">
                <asp:Label ID="lb_mensaje" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#009933"></asp:Label>
                <asp:Label ID="lb_mensaje_error" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" ForeColor="Red"></asp:Label>
                <img id="img_ok" runat="server" visible="False" src="~/Imagenes/correct.png" class="auto-style101" /><img id="img_parcial" runat="server" visible="False" src="~/Imagenes/caution.png" class="auto-style102" /><img id="img_error" runat="server" visible="False" src="~/Imagenes/cross2.bmp" class="auto-style101" /></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style100"></td>
            <td class="auto-style50" colspan="4">
                <asp:Panel ID="panel" runat="server" Height="384px" ScrollBars="Both" Width="854px">
                    <asp:Label ID="lb_resultados" runat="server" Font-Bold="True" Text="RESULTADOS" Width="250px"></asp:Label>
                    <br />
                    <asp:GridView ID="GrillaResultados" runat="server" AutoGenerateColumns="False" CellPadding="4" CssClass="GridActiveItem" EnableModelValidation="True" ForeColor="#333333" Width="818px" Height="93px" PageSize="2">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="nombre_archivo" HeaderText="NOMBRE ARCHIVO">
                            <HeaderStyle ForeColor="White" />
                            </asp:BoundField>
                            <asp:BoundField DataField="duplicados" HeaderText="DUPLICADOS">
                            <HeaderStyle ForeColor="White" />
                            </asp:BoundField>
                            <asp:BoundField DataField="errores" HeaderText="ERRORES">
                            <HeaderStyle ForeColor="White" />
                            </asp:BoundField>
                            <asp:BoundField DataField="cargados" HeaderText="CARGADOS">
                            <HeaderStyle ForeColor="White" />
                            </asp:BoundField>
                            <asp:BoundField DataField="total" HeaderText="TOTAL" >
                            <HeaderStyle ForeColor="White" />
                            </asp:BoundField>
                        </Columns>
                        <EditRowStyle BackColor="#2461BF" />
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                       <HeaderStyle BackColor="#1B3550" Font-Bold="True" ForeColor="White" Width="150px" />
                        <PagerStyle BackColor="#2461BF" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EFF3FB" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    </asp:GridView>
                    <br />
                    <asp:Label ID="lb_resumen" runat="server" Font-Bold="True" Text="RESUMEN DUPLICADOS/ERRORES" Width="250px"></asp:Label>
                    <br />
                    <asp:GridView ID="GrillaDetalle" runat="server" AutoGenerateColumns="False" CellPadding="4" CssClass="GridActiveItem" EnableModelValidation="True" ForeColor="#333333" Height="184px" Width="818px">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="#" HeaderText="#">
                            <HeaderStyle ForeColor="White" Width="5%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NUMERO_CLIENTE" HeaderText="NUMERO CLIENTE">
                            <HeaderStyle ForeColor="White" Width="15%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="mensaje_error" HeaderText="MENSAJE ERROR">
                            <HeaderStyle ForeColor="White" Width="80%" />
                            </asp:BoundField>
                        </Columns>
                        <EditRowStyle BackColor="#2461BF" />
                        <FooterStyle BackColor="#1B3550" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#1B3550" Font-Bold="True" ForeColor="White" Width="150px" />
                        <PagerStyle BackColor="#1B3550" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EFF3FB" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    </asp:GridView>
                    <br />
                </asp:Panel>
            </td>
            <td></td>
        </tr>
        <tr>
            <td class="auto-style78" rowspan="2">&nbsp;</td>
            <td class="auto-style67" colspan="4">
                </td>
            <td class="auto-style68"></td>
        </tr>
        <tr>
            <td colspan="5" class="auto-style68">
                </td>
        </tr>
    </table>

</asp:Content>

