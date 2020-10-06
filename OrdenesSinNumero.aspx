<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="OrdenesSinNumero.aspx.cs" Inherits="OrdenesSinNumero" %>

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
            width: 400px;
        }
        .auto-style21
        {
            height: 20px;
            text-align: right;
            width: 120px;
        }
        .auto-style22
        {
            width: 120px;
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
            width: 200px;
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
        .auto-style52 {
            width: 400px;
            height: 20px;
        }
        </style>

    <script type="text/javascript">

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
        <div id="main" runat="server">
        <table class="auto-style9">
        <tr>
            <td  colspan=10 class="auto-style18">MANTENEDOR DE ORDENES SIN NÚMERO<asp:Label ID="lb_id_usuario" runat="server" Visible="False"></asp:Label>
                <asp:Label ID="lb_id_perfil" runat="server" Visible="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style19">
                <asp:Label ID="Label3" runat="server" Text="Región:"></asp:Label>
            </td>
            <td class="auto-style20">
                <asp:DropDownList ID="ddRegion" runat="server" AutoPostBack="True" CssClass="ComboBox" Height="20px"  Width="200px" OnSelectedIndexChanged="ddRegion_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
            <td class="auto-style20" style="text-align: right">
                <asp:Label ID="Label8" runat="server" Text="Servicio:"></asp:Label>
            </td>
            <td class="auto-style20">&nbsp;<asp:TextBox ID="txtServ" runat="server" AutoPostBack="True" CssClass="TextBox3" OnTextChanged="txtServ_TextChanged" Width="130px"></asp:TextBox>
                        <br />
                        </td>
            <td class="auto-style20" style="text-align: right">
                <asp:Button ID="btn_carga" runat="server" class="button_form"  Text="CARGA MASIVA" Height="24px" OnClick="btn_carga_Click" Width="160px" />
            </td>
            <td class="auto-style20">
                        &nbsp;</td>
            <td class="auto-style21"></td>
            <td class="auto-style23"></td>
            <td class="auto-style1"></td>
            <td class="auto-style2"></td>
        </tr>
        <tr>
            <td class="auto-style19">
                <asp:Label ID="Label4" runat="server" Text="Zona:"></asp:Label>
            </td>
            <td class="auto-style20">
                <asp:DropDownList ID="ddZona" runat="server" AutoPostBack="True" CssClass="ComboBox" Height="20px"  Width="200px" OnSelectedIndexChanged="ddZona_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
            <td style="text-align: right" class="auto-style20">
                <asp:Label ID="Label9" runat="server" Text="Nro. Orden:"></asp:Label>
            </td>
            <td class="auto-style20">
                &nbsp;<asp:TextBox ID="txtOrden" runat="server" AutoPostBack="True" CssClass="TextBox3" OnTextChanged="txtOrden_TextChanged" Width="130px"></asp:TextBox>
                        <br />
            </td>
            <td style="text-align: right" class="auto-style20">
                <asp:Button ID="btn_excel" runat="server" class="button_form" Text="DESCARGAR EXCEL" OnClick="btn_excel_Click" Height="24px" Width="160px"  />
            </td>
            <td class="auto-style20">
                        &nbsp;</td>
            <td class="auto-style22" style="text-align: left">
                &nbsp;</td>
            <td class="auto-style23">&nbsp;</td>
            <td class="auto-style1" colspan="2" style="text-align: center">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style25">
                <asp:Label ID="Label5" runat="server" Text="Localidad:"></asp:Label>
            </td>
            <td class="auto-style26">
                <asp:DropDownList ID="ddLocalidad" runat="server" AutoPostBack="True" CssClass="ComboBox" Height="20px"   Width="200px" OnSelectedIndexChanged="ddLocalidad_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
            <td class="auto-style26" style="text-align: right">
                &nbsp;</td>
            <td class="auto-style20" style="text-align: left">
                &nbsp;
                <asp:Button ID="btn_filtrar" runat="server" class="button_form"  Text="FILTRAR" Height="24px" OnClick="btn_filtrar_Click" Width="130px" />
            </td>
            <td class="auto-style26">
                &nbsp;</td>
            <td class="auto-style26" style="text-align: center">
                &nbsp;</td>
            <td class="auto-style27"></td>
            <td class="auto-style28"></td>
            <td class="auto-style29"></td>
            <td class="auto-style30"></td>
        </tr>
        <tr>
            <td class="auto-style25"></td>
            <td class="auto-style26"></td>
            <td class="auto-style26"></td>
            <td class="auto-style26"></td>
            <td class="auto-style26"></td>
            <td class="auto-style26"></td>
            <td class="auto-style27"></td>
            <td class="auto-style28"></td>
            <td class="auto-style29"></td>
            <td class="auto-style30"></td>
        </tr>
        <tr>
            <td class="auto-style29" colspan="10" style="text-align: center">
                <asp:Label ID="lb_mensaje" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style1" colspan="6" style="text-align: left">&nbsp;
                <asp:Label ID="lb_contador" runat="server"></asp:Label>
            </td>
            <td class="auto-style21"></td>
            <td class="auto-style23"></td>
            <td class="auto-style1"></td>
            <td class="auto-style2"></td>
        </tr>
        <tr>
            <td class="auto-style24" colspan="10" style="vertical-align: middle; text-align: center">
                <asp:Panel ID="panel_grilla" runat="server" Height="100%" Width="100%" HorizontalAlign="Center" ScrollBars="Auto">
                    <asp:GridView ID="migrilla" runat="server" AutoGenerateColumns="False" CellPadding="4" CssClass="auto-style33" DataKeyNames="ID_ORDEN" EnableModelValidation="True" ForeColor="#333333" Height="125px" OnSelectedIndexChanged="gridOrden_SelectedIndexChanged" OnRowCommand="gridOrden_RowCommand" PageSize="40" Width="100%">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="ID_ORDEN" HeaderText="ID_ORDEN" ItemStyle-CssClass="ColumnaOculta" HeaderStyle-CssClass="ColumnaOculta">
                             <HeaderStyle CssClass="ColumnaOculta" />
                             <ItemStyle CssClass="ColumnaOculta" />
                            </asp:Boundfield>
                            <asp:BoundField DataField="ID_SERVICIO" HeaderText="SERVICIO">
                            <HeaderStyle Width="8%" ForeColor="White"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="NUMERO_ORDEN" HeaderText="NUMERO ORDEN">
                            <HeaderStyle Width="8%" ForeColor="White"/>
                            </asp:BoundField>
                            
                            <asp:BoundField DataField="CAUSA" HeaderText="CAUSA">
                            <HeaderStyle Width="13%" ForeColor="White"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="LOCALIDAD" HeaderText="LOCALIDAD">
                            <HeaderStyle Width="15%" ForeColor="White"/>
                            </asp:BoundField>
                             <asp:BoundField DataField="OPERADOR" HeaderText="OPERADOR">
                            <HeaderStyle Width="15%" ForeColor="White"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="CONTRATISTA" HeaderText="CONTRATISTA">
                                <HeaderStyle Width="12%" ForeColor="White"/>
                            </asp:BoundField>                          
                            <asp:BoundField DataField="FECHA_EJECUCION" HeaderText="FECHA EJECUCIÓN">
                                <HeaderStyle Width="8%" ForeColor="White"/>
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="NUEVA ORDEN">
                                <HeaderStyle ForeColor="White" Width="8%" Font-Size="8pt" />
                                <ItemStyle Font-Size="8pt" Width="8%" />
                                <ItemTemplate>
                                    <asp:TextBox ID="DDORDEN" Width="100px"  Font-Size="8pt" Font-Bold="true" runat="server" MaxLength="15"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>     
                             <asp:TemplateField HeaderText="VALIDAR">
                                          <HeaderStyle ForeColor="White" Width="50px" Font-Size="8pt" />
                                   <ItemStyle Font-Size="8pt" Width="50px" /> 
                                                <ItemTemplate>
                                            <asp:Button ID="AddButton" runat="server" CssClass="button_form" BackColor="#8B0000" ForeColor="White"
                                              CommandName="VALIDAR" 
                                              CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                              Text="VALIDAR"  OnClientClick="return confirm('¿ESTA SEGURO DE CONTINUAR?');" />
                                            </ItemTemplate> 
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
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td class="auto-style19"></td>
            <td class="auto-style52" colspan="5"></td>
            <td class="auto-style21"></td>
            <td class="auto-style23"></td>
            <td class="auto-style1"></td>
            <td class="auto-style2"></td>
        </tr>
        </table>
   </div>

<br />            
<div id="carga_archivo" runat="server" class="container" visible="false"> 
    <div class="row">
    <h2>CARGAR ARCHIVO ORDENES SIN NÚMERO</h2> 
    <button id="btn_volver_main" runat="server" class="button_form" onServerClick="btn_volver_click">VOLVER</button>
    </div>
    <div class="row">
      <div class="col-25">
        <label>Seleccione archivo: </label>
      </div>
      <div class="col-75">
        <asp:FileUpload ID="fuArchivo" runat="server" BorderStyle="None" CssClass="button_form" />
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <button id="btn_cargar" runat="server" class="button_form" onServerClick="btn_cargar_click" >CARGAR ARCHIVO</button>
      </div>
      <div class="col-75">
       <button id="btn_cargar_otro" runat="server" class="button_form" onServerClick="btn_otro_click">LIMPIAR RESULTADO</button>
      </div>
    </div>
    <br />
    <div id="resultados" runat="server" class="row" visible="false">
      <div class="col-25">
        <label>RESULTADOS: </label>
      </div>
      <div class="col-75">
        <!--table aqui -->
        <asp:GridView ID="grid_resultado" runat="server" AutoGenerateColumns="False" CellPadding="4" CssClass="GridAlternativeItems" EnableModelValidation="True" ForeColor="#333333" Height="16px" Visible="False" Width="100%">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="NOMBRE_ARCHIVO" HeaderText="Archivo">
                            <ControlStyle Width="60%" />
                            <HeaderStyle ForeColor="White" Width="60%" />
                            </asp:BoundField>                           
                            <asp:BoundField DataField="DUPLICADOS" HeaderText="Duplicados">
                            <ControlStyle Width="10%" />
                            <HeaderStyle ForeColor="White" Width="10%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ERRORES" HeaderText="Errores">
                            <ControlStyle Width="10%" />
                            <HeaderStyle ForeColor="White" Width="10%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CARGADOS" HeaderText="Actualizados">
                            <ControlStyle Width="10%" />
                            <HeaderStyle ForeColor="White" Width="10%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TOTAL" HeaderText="Total">
                            <ControlStyle Width="10%" />
                            <HeaderStyle ForeColor="White" Width="10%" />
                            </asp:BoundField>
                        </Columns>
                        <EditRowStyle BackColor="#2461BF" />
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#2461BF" BorderStyle="Dotted" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EFF3FB" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    </asp:GridView>
          <br />

          <button id="btn_showhide" runat="server" class="button_form" onServerClick="btn_showhide_click">VER/OCULTAR</button>

          <br /> <br />

          <asp:GridView ID="grid_detalle" runat="server" AutoGenerateColumns="False" CellPadding="4" CssClass="GridAlternativeItems" EnableModelValidation="True" ForeColor="#333333" Height="16px"  Visible="False" Width="100%" PageSize="20">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="NRO" HeaderText="#">
                            <HeaderStyle Width="4%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NUM_ORDEN" HeaderText="NRO ORDEN">
                            <HeaderStyle ForeColor="White" Width="18%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SERVICIO" HeaderText="ID SERVICIO">
                            <HeaderStyle ForeColor="White" Width="18%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="MENSAJE_ERROR" HeaderText="MENSAJE DE ERROR">
                            <HeaderStyle ForeColor="White" Width="60%" />
                            </asp:BoundField>
                        </Columns>
                        <EditRowStyle BackColor="#2461BF" />
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#993333" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#2461BF" BorderStyle="Dotted" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EFF3FB" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    </asp:GridView>
      </div>
    </div>
    
</div>
</asp:Content>
