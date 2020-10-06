<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="CalendarioFacturacion.aspx.cs" Inherits="CalendarioFacturacion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    
   <script src = " https://unpkg.com/sweetalert/dist/sweetalert.min.js "></script> 

    <style type="text/css">
        .GridAlternativeItems
        {}
        .auto-style9
        {
            height: auto;
            width: 1000px;
        }
        .auto-style1
        {
            height: 20px;
            text-align:right;
        }
        .auto-style2
        {
            height: 20px;
            text-align:left;
        }
        .auto-style18
        {
            FONT-WEIGHT: bold;
            FONT-SIZE: 15px;
            MARGIN-BOTTOM: 6px;
            COLOR: #003366;
            BORDER-BOTTOM: #999 1px dotted;
            FONT-FAMILY: "trebuchet ms", trebuchet, arial, sans-serif;
            background-position: left;
            height: 30px;
        }
        #IMG6
    {
        margin-left: 0px;
    }
        .auto-style19
        {
            height: 20px;
            text-align: right;
            width: 200px;
        }
         .auto-styl20
        {
            height: 20px;
            text-align: center;
            width: 200px;
        }
        .auto-style20
        {
        }
        .auto-style21
        {
            height: 20px;
            text-align: right;
            width: 120px;
        }
        .auto-style22
        {
        }
        .auto-style23
        {
            height: 20px;
            text-align: left;
            width: 70px;
        }
        .auto-style24
        {
            height: 501px;
            text-align: center;
        }
        .auto-style25
        {
            height: 19px;
            text-align: right;
            }
        .auto-style26
        {
            width: 400px;
            height: 19px;
        }
        .auto-style27
        {
            height: 19px;
            text-align: right;
            width: 120px;
        }
        .auto-style28
        {
            height: 19px;
            text-align: left;
            width: 70px;
        }
        .auto-style29
        {
            height: 19px;
            text-align: right;
        }
        .auto-style30
        {
            height: 19px;
            text-align: left;
        }
         .auto-style33
        {
            font-family: "trebuchet ms", verdana, tahoma, arial;
            font-size: 11px;
            color: #333333;
            margin-top: 0px;
            background-color: #000000;
        }
        ImageButton {
            width: 30px;
        }
        .auto-style34 {
            height: 34px;
        }
        .custom {
            height:20px;
            margin: auto;
            vertical-align:middle;
        }
        .auto-style35 {
            width: 179px;
        }
        .auto-style36 {
            width: 179px;
            height: 19px;
        }
        .auto-style37 {
            width: 179px;
            height: 20px;
        }
        .auto-style38 {
            height: 20px;
        }
        </style>

    <script type="text/javascript">

        function error(mensaje) {
            swal("¡ERROR! ", "" + mensaje + "", "warning");
        }

        function correcto(mensaje) {
            swal("¡CORRECTO! ", "" + mensaje + "", "success");
        }
    </script>
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <div id="main" runat="server">
        <table class="auto-style9">
        <tr>
            <td  colspan=7 class="auto-style18">CALENDARIO DE FACTURACIÓN<asp:Label ID="lb_id_usuario" runat="server" Visible="False"></asp:Label>
                <asp:Label ID="lb_id_perfil" runat="server" Visible="False"></asp:Label>
                <asp:Label ID="lb_id_contratista" runat="server" Visible="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style19"></td>
            <td class="auto-style37"></td>
            <td class="auto-style38"></td>
            <td class="auto-style21"></td>
            <td class="auto-style23"></td>
            <td class="auto-style1"></td>
            <td class="auto-style2"></td>
        </tr>
        <tr>
            <td class="auto-style19" style="text-align: left">
                AÑO:<br />
                <asp:DropDownList ID="cb_agno" runat="server" AutoPostBack="true" Width="200px" OnSelectedIndexChanged="cb_agno_SelectedIndexChanged">
                  
                </asp:DropDownList>
            </td>
            <td style="text-align: center" class="auto-style35">
                &nbsp;</td>
            <td style="text-align: left" class="auto-style35">
                MES<br />
                <asp:DropDownList ID="cb_periodo" runat="server" AutoPostBack="true" Width="200px" OnSelectedIndexChanged="cb_periodo_SelectedIndexChanged">
                    <asp:ListItem Value="0">TODOS</asp:ListItem>
                    <asp:ListItem Value="01">ENERO</asp:ListItem>
                    <asp:ListItem Value="02">FEBRERO</asp:ListItem>
                    <asp:ListItem Value="02">FEBRERO</asp:ListItem>
                    <asp:ListItem Value="03">MARZO</asp:ListItem>
                    <asp:ListItem Value="04">ABRIL</asp:ListItem>
                    <asp:ListItem Value="05">MAYO</asp:ListItem>
                    <asp:ListItem Value="06">JUNIO</asp:ListItem>
                    <asp:ListItem Value="07">JULIO</asp:ListItem>
                    <asp:ListItem Value="08">AGOSTO</asp:ListItem>
                    <asp:ListItem Value="09">SEPTIEMBRE</asp:ListItem>
                    <asp:ListItem Value="10">OCTUBRE</asp:ListItem>
                    <asp:ListItem Value="11">NOVIEMBRE</asp:ListItem>
                    <asp:ListItem Value="12">DICIEMBRE</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="auto-style22" style="text-align: left">
                &nbsp;</td>
            <td class="auto-style23">&nbsp;</td>
            <td class="auto-style1" colspan="2" style="text-align: center">
                <asp:Button ID="btn_nuevo" runat="server" BackColor="#336699" Font-Bold="True" Font-Names="Calibri" ForeColor="White" Text="NUEVO CALENDARIO" OnClick="btn_nuevo_Click" />
            </td>
        </tr>
        <tr>
            <td class="auto-style25"></td>
            <td class="auto-style36">&nbsp;</td>
            <td class="auto-style26"></td>
            <td class="auto-style27"></td>
            <td class="auto-style28"></td>
            <td class="auto-style29"></td>
            <td class="auto-style30"></td>
        </tr>
        <tr>
            <td class="auto-style29" colspan="7" style="text-align: center">
                <asp:Label ID="lb_mensaje" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style1" colspan="3" style="text-align: left">&nbsp;
                <asp:Label ID="lb_contador" runat="server"></asp:Label>
            </td>
            <td class="auto-style21"></td>
            <td class="auto-style23"></td>
            <td class="auto-style1"></td>
            <td class="auto-style2"></td>
        </tr>
        <tr>
            <td class="auto-style24" colspan="7" style="vertical-align: middle; text-align: center">
                <asp:Panel ID="panel_grilla" runat="server" Height="100%" Width="100%" HorizontalAlign="Center" ScrollBars="Auto">
                    <asp:GridView ID="migrilla" runat="server" AutoGenerateColumns="False" CellPadding="4" CssClass="auto-style33" DataKeyNames="ID_CALENDARIO" EnableModelValidation="True" ForeColor="#333333" Height="125px" OnSelectedIndexChanged="gridOrden_SelectedIndexChanged" OnRowCommand="gridOrden_RowCommand" PageSize="40" Width="100%">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="ID_CALENDARIO" HeaderText="ID_CALENDARIO" ItemStyle-CssClass="ColumnaOculta" HeaderStyle-CssClass="ColumnaOculta">
                             <HeaderStyle CssClass="ColumnaOculta" />
                             <ItemStyle CssClass="ColumnaOculta" />
                            </asp:Boundfield>
                            <asp:BoundField DataField="PERIODO" HeaderText="PERIODO">
                            <HeaderStyle Width="20%" ForeColor="White"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="AGNO" HeaderText="AÑO">
                            <HeaderStyle Width="10%" ForeColor="White"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="MES" HeaderText="MES">
                            <HeaderStyle Width="13%" ForeColor="White"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="FECHA_CREACION" HeaderText="FECHA CREACIÓN">
                            <HeaderStyle Width="13%" ForeColor="White"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="USUARIO" HeaderText="CREADO POR">
                                <HeaderStyle Width="13%" ForeColor="White"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="ESTADO" HeaderText="ESTADO">
                                <HeaderStyle Width="13%" ForeColor="White"/>
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="VER FECHAS">
                                                <ItemTemplate>
                                                    <asp:ImageButton  ID="btn_ver_fechas" runat="server" CommandArgument="<%# Container.DataItemIndex%>" CommandName="ver_calendario" ImageUrl="~/Imagenes/look.png" />
                                                </ItemTemplate>
                                                <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="13%" /> 
                                                <ItemStyle Font-Size="8pt" Width="40px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ELIMINAR">
                                                <ItemTemplate>
                                                    <asp:ImageButton  ID="btn_eliminar_calendario" runat="server" CommandArgument="<%# Container.DataItemIndex%>" CommandName="eliminar_calendario" ImageUrl="~/Imagenes/trash.png" />
                                                </ItemTemplate>
                                                <HeaderStyle Font-Size="XX-Small" ForeColor="White" Width="13%" /> 
                                                <ItemStyle Font-Size="8pt" Width="40px" />
                            </asp:TemplateField>

                        </Columns>
                        <EditRowStyle BackColor="#2461BF" />
                        <FooterStyle BackColor="#1B3550" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#1B3550" Font-Bold="True" ForeColor="White" Width="150px" />
                        <PagerStyle BackColor="#1B3550" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EFF3FB" Font-Bold="True" Font-Italic="False" ForeColor="White" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="False" ForeColor="#333333" />
                    </asp:GridView>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td class="auto-style19">&nbsp;</td>
            <td class="auto-style35">&nbsp;</td>
            <td class="auto-style20">&nbsp;</td>
            <td class="auto-style21">&nbsp;</td>
            <td class="auto-style23">&nbsp;</td>
            <td class="auto-style1">&nbsp;</td>
            <td class="auto-style2">&nbsp;</td>
        </tr>
        </table>
   </div>
     <div id="agregar" runat="server" Visible="false">
         
   </div>
        <div id="calendario" runat="server" visible="false">
            <table>
                <tr>
                     <td class="auto-style18" colspan="8"><h2 id="titulo_edit" runat="server">Nuevo Calendario</h2></td>
                 </tr>
            </table>
            
             <table class="auto-style9" id="botones_carga" runat="server">
                 
                 <tr>
                     <td class="auto-style19" colspan="2"></td>
                     <td class="auto-style20"></td>
                     <td class="auto-style21" colspan="2"></td>
                     <td class="auto-style23"></td>
                     <td class="auto-style1"></td>
                     <td class="auto-style2">&nbsp;</td>
                 </tr>
                 <tr>
                     <td class="auto-style34" style="text-align:left;">
                         AÑO<br />
                <asp:DropDownList ID="cb_agno_nuevo" runat="server" Width="200px">
                  
                </asp:DropDownList>
                         <br />
                     </td>
                     <td class="auto-style34" style="text-align:left;">
                         MES<br />
                <asp:DropDownList ID="cb_periodo_nuevo" runat="server" Width="200px">
                    <asp:ListItem Value="01">ENERO</asp:ListItem>
                    <asp:ListItem Value="02">FEBRERO</asp:ListItem>
                    <asp:ListItem Value="02">FEBRERO</asp:ListItem>
                    <asp:ListItem Value="03">MARZO</asp:ListItem>
                    <asp:ListItem Value="04">ABRIL</asp:ListItem>
                    <asp:ListItem Value="05">MAYO</asp:ListItem>
                    <asp:ListItem Value="06">JUNIO</asp:ListItem>
                    <asp:ListItem Value="07">JULIO</asp:ListItem>
                    <asp:ListItem Value="08">AGOSTO</asp:ListItem>
                    <asp:ListItem Value="09">SEPTIEMBRE</asp:ListItem>
                    <asp:ListItem Value="10">OCTUBRE</asp:ListItem>
                    <asp:ListItem Value="11">NOVIEMBRE</asp:ListItem>
                    <asp:ListItem Value="12">DICIEMBRE</asp:ListItem>
                </asp:DropDownList>
                         <br />
                     </td>
                     <td class="auto-style34" style="text-align:left;">
                         &nbsp;</td>
                     <td class="auto-style34" style="text-align: center" colspan="2">
                         &nbsp;</td>
                     <td class="auto-style34">&nbsp;</td>
                     <td class="auto-style34">&nbsp;</td>
                     <td class="auto-style34" style="text-align: center">
                         &nbsp;</td>
                 </tr>
                 <tr>
                     <td class="auto-style34" style="text-align:left;" colspan="3">
                <asp:Label ID="lb_perfil0" runat="server" CssClass="custom" Height="20px">SELECCIONE ARCHIVO:</asp:Label>
                         &nbsp;<asp:FileUpload ID="fuArchivo" runat="server" BorderStyle="Solid" CssClass="Button" Width="400px" Height="30px" />
                     </td>
                     <td class="auto-style34" style="text-align: center" colspan="2">
                <asp:Button ID="btn_cargar" runat="server" BackColor="#336699" Font-Bold="True" Font-Names="Calibri" ForeColor="White" Text="CARGAR CALENDARIO" OnClick="btn_cargar_click" Height="30px" />
                     </td>
                     <td class="auto-style34"></td>
                     <td class="auto-style34"></td>
                     <td class="auto-style34" style="text-align: center">
                         &nbsp;</td>
                 </tr>
                 <tr>
                     <td class="auto-style25" colspan="3" style="text-align: center">
                         <asp:Label ID="lb_mensaje_fechas0" runat="server">Formato CSV, Campos: Lote,Mes inicio periodo anterior, Mes fin periodo anterior,Dias anterior, Lectura mes,Mes inicio periodo actual,Mes fin periodo actual, Dias actual.</asp:Label>
                     </td>
                     <td class="auto-style27" colspan="2"></td>
                     <td class="auto-style28"></td>
                     <td class="auto-style29"></td>
                     <td class="auto-style30"></td>
                 </tr>
                 </table>
                <table class="auto-style9">
                 <tr>
                     <td class="nueva_fecha" colspan="3">&nbsp;</td>
                     <td class="auto-style27" colspan="2">&nbsp;</td>
                     <td class="auto-style28">&nbsp;</td>
                     <td class="auto-style29">&nbsp;</td>
                     <td class="auto-style30">&nbsp;</td>
                 </tr>
                 <tr>
                     <td class="auto-style25" colspan="4" style="text-align: center">
                         <asp:Label ID="lb_mensaje_fechas" runat="server"></asp:Label>
                     </td>
                     <td class="auto-style25" colspan="4" style="text-align: right">
                <asp:Button ID="btn_volver_bodegas" runat="server" BackColor="#336699" Font-Bold="True" Font-Names="Calibri" ForeColor="White" Text="VOLVER" OnClientClick="return confirm('Se descartarán todos los cambios realizados, ¿Está seguro de continuar?');" Height="30px" OnClick="btn_volver_bodegas_Click" />
                     </td>
                 </tr>
                 <tr>
                     <td class="auto-style1" colspan="3" style="text-align: left">&nbsp;
                         <asp:Label ID="lb_contador_fechas" runat="server"></asp:Label>
                     </td>
                     <td class="auto-style21" colspan="2"></td>
                     <td class="auto-style23"></td>
                     <td class="auto-style1"></td>
                     <td class="auto-style2"></td>
                 </tr>
                 <tr>
                     <td class="auto-style24" colspan="8" style="vertical-align: middle; text-align: center">
                         <asp:Panel ID="panel_grilla_bodega" runat="server" Height="100%" HorizontalAlign="Center" ScrollBars="Auto" Width="100%">
                             <asp:GridView ID="migrilla_fechas" runat="server" AutoGenerateColumns="False" CellPadding="4" CssClass="auto-style33" DataKeyNames="ID_FECHAS_CALENDARIO,FECHA_LECTURA" EnableModelValidation="True" ForeColor="#333333" Height="125px" OnSelectedIndexChanged="gridOrden_SelectedIndexChanged" PageSize="40" Width="100%">
                                 <AlternatingRowStyle BackColor="White" />
                                 <Columns>
                                     <asp:BoundField DataField="ID_FECHAS_CALENDARIO" Visible="false" HeaderStyle-CssClass="ColumnaOculta" HeaderText="ID_FECHAS_CALENDARIO" ItemStyle-CssClass="ColumnaOculta">
                                     <HeaderStyle CssClass="ColumnaOculta" />
                                     <ItemStyle CssClass="ColumnaOculta" />
                                     </asp:BoundField>
                                      <asp:BoundField DataField="PERIODO" HeaderText="PERIODO">
                                     <HeaderStyle ForeColor="White" Width="25%" />
                                     </asp:BoundField>
                                     <asp:BoundField DataField="FECHA_LECTURA" Visible="false" HeaderText="FECHA_LECTURA" HeaderStyle-CssClass="ColumnaOcuta" ItemStyle-CssClass="ColumnaOculta">
                                     <HeaderStyle ForeColor="White" Width="25%" />
                                     </asp:BoundField>
                                     <asp:BoundField DataField="LOTE" HeaderText="LOTE">
                                     <HeaderStyle ForeColor="White" Width="25%" />
                                     </asp:BoundField>
                                     <asp:BoundField DataField="FECHA_INICIO" HeaderText="FECHA INICIO">
                                     <HeaderStyle ForeColor="White" Width="25%" />
                                     </asp:BoundField>
                                     <asp:BoundField DataField="FECHA_FIN" HeaderText="FECHA TERMINO">
                                     <HeaderStyle ForeColor="White" Width="2250%" />
                                     </asp:BoundField>
                                      <asp:BoundField DataField="ESTADO" HeaderText="ESTADO" Visible="false">
                                     <HeaderStyle ForeColor="White" Width="5%" />
                                     </asp:BoundField>
                                  
                                 </Columns>
                                 <EditRowStyle BackColor="#2461BF" />
                                 <FooterStyle BackColor="#1B3550" Font-Bold="True" ForeColor="White" />
                                 <HeaderStyle BackColor="#1B3550" Font-Bold="True" ForeColor="White" Width="150px" />
                                 <PagerStyle BackColor="#1B3550" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                                 <RowStyle BackColor="#EFF3FB" Font-Bold="True" Font-Italic="False" ForeColor="White" />
                                 <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="False" ForeColor="#333333" />
                             </asp:GridView>
                         </asp:Panel>
                     </td>
                 </tr>
                 <tr>
                     <td class="auto-style19" colspan="2">&nbsp;</td>
                     <td class="auto-style20">&nbsp;</td>
                     <td class="auto-style21" colspan="2">&nbsp;</td>
                     <td class="auto-style23">&nbsp;</td>
                     <td class="auto-style1">&nbsp;</td>
                     <td class="auto-style2">&nbsp;</td>
                 </tr>
             </tabl>
         </div>
</asp:Content>
