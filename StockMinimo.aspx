<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="StockMinimo.aspx.cs" Inherits="StockMinimo" %>


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
      
        function cambio_realizado(mensaje) {
            swal("CAMBIOS EFECTUADOS", mensaje, "success");
        }

        function Error(mensaje) {
            swal("¡ERROR! ", "" + mensaje + "", "warning");
        }
    </script>

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
            text-align: left;
            width: 200px;
            padding-top: 10px;
            padding-left: 10px;
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
        .auto-style23
        {
            height: 20px;
            text-align: left;
            }
        .auto-style24
        {
            height: 501px;
            text-align: center;
        }
        .auto-style25
        {
            height: 20px;
            text-align: right;
            width: 200px;
        }
        .auto-style28
        {
            height: 20px;
            text-align: left;
            width: 70px;
        }
        .auto-style29
        {
            height: 19px;
            text-align: right;
        }
         .auto-style31
        {
            width: 170px;
            height: 30px;
        }
        .auto-style33
        {
            font-family: "trebuchet ms", verdana, tahoma, arial;
            font-size: 11px;
            color: #333333;
            margin-top: 0px;
            background-color: #000000;
        }
        .auto-style40
        {
            height: 20px;
            text-align: right;
            width: 230px;
        }
        .auto-style42
        {
            height: 20px;
            text-align: left;
            width: 85px;
        }
        .auto-style43
        {
            width: 100px;
        }
        .auto-style45
        {
            width: 100px;
            height: 30px;
        }
        .auto-style46
        {
            height: 20px;
        }
        .auto-style47
        {
            height: 30px;
        }
        .auto-style49
        {
            width: 100px;
            height: 10px;
        }
        .auto-style51
        {
            height: 10px;
            text-align: left;
        }
        .auto-style52 {
            width: 230px;
            height: 30px;
        }
        .auto-style53 {
            width: 230px;
            height: 10px;
        }
        </style>
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <div id="main" runat="server">
        <table class="auto-style9">
        <tr>
            <td  colspan=9 class="auto-style18">CONTROL DEL STOCK MÍNIMO<asp:Label ID="lb_id_usuario" runat="server" Visible="False"></asp:Label>
                <asp:Label ID="lb_id_perfil" runat="server" Visible="False"></asp:Label>
                <asp:Label ID="lb_id_contratista" runat="server" Visible="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style19">
                <asp:Label ID="lb1" runat="server" Text="Contratista:"></asp:Label>
            </td>
            <td class="auto-style19">
                              <asp:DropDownList ID="ddContratista" runat="server" AutoPostBack="true" Width="180px" CssClass="ComboBox" OnSelectedIndexChanged="ddContratista_SelectedIndexChanged" ></asp:DropDownList>
            </td>
            <td class="auto-style19">
                <asp:Label ID="lb2" runat="server" Text="Región:"></asp:Label>
            </td>
            <td class="auto-style19">
                              <asp:DropDownList ID="ddRegion" runat="server" AutoPostBack="true" Width="180px" CssClass="ComboBox" OnSelectedIndexChanged="ddRegion_SelectedIndexChanged" ></asp:DropDownList>
            </td>
            <td class="auto-style19">
                &nbsp;</td>
            <td class="auto-style21">
                &nbsp;</td>
            <td class="auto-style23"></td>
            <td class="auto-style1"></td>
            <td class="auto-style2"></td>
        </tr>
        <tr>
            <td class="auto-style19">
                <asp:Label ID="lb3" runat="server" Text="Bodega:"></asp:Label>
            </td>
            <td class="auto-style19">
                              <asp:DropDownList ID="ddBodega" runat="server" AutoPostBack="true" Width="180px" CssClass="ComboBox" OnSelectedIndexChanged="ddBodega_SelectedIndexChanged" ></asp:DropDownList>
            </td>
            <td class="auto-style19">
                <asp:Label ID="lb4" runat="server" Text="Categoria:"></asp:Label>
            </td>
            <td class="auto-style19">
                              <asp:DropDownList ID="ddTipoMaterial" runat="server" AutoPostBack="true" Width="180px" CssClass="ComboBox" OnSelectedIndexChanged="ddTipoMaterial_SelectedIndexChanged" >
                                    <asp:ListItem Value="0">TODOS...</asp:ListItem>
                                    <asp:ListItem Value="1">MEDIDORES</asp:ListItem>
                                    <asp:ListItem Value="2">ACCESORIOS</asp:ListItem>
                              </asp:DropDownList>
            </td>
            <td class="auto-style19" style="text-align:center;">
                <asp:Button ID="btn_buscar" runat="server" BackColor="#336699" Font-Bold="True" Font-Names="Calibri" ForeColor="White" Text="BUSCAR" style="height: 25px; text-align:center;" OnClick="btn_buscar_Click" />
            </td>
            <td class="auto-style21"></td>
            <td class="auto-style19" colspan="3">
                <asp:Button ID="btn_nuevo" runat="server" BackColor="#336699" Font-Bold="True" Font-Names="Calibri" ForeColor="White" Text="NUEVO STOCK MINIMO" OnClick="btn_nuevo_Click" />
            </td>
        </tr>
        <tr>
            <td class="auto-style25"></td>
            <td class="auto-style25"></td>
            <td class="auto-style25"></td>
            <td class="auto-style19"></td>
            <td class="auto-style19"></td>
            <td class="auto-style21"></td>
            <td class="auto-style28"></td>
            <td class="auto-style1"></td>
            <td class="auto-style2"></td>
        </tr>
        <tr>
            <td class="auto-style29" colspan="9" style="text-align: center">
                <asp:Label ID="lb_mensaje" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style1" colspan="4" style="text-align: left">&nbsp;
                <asp:Label ID="lb_contador" runat="server"></asp:Label>
            </td>
            <td class="auto-style1" style="text-align: left">&nbsp;</td>
            <td class="auto-style21">&nbsp;</td>
            <td class="auto-style23">&nbsp;</td>
            <td class="auto-style1">&nbsp;</td>
            <td class="auto-style2">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style24" colspan="9" style="vertical-align: middle; text-align: center">
                <asp:Panel ID="panel_grilla" runat="server" Height="100%" Width="100%" HorizontalAlign="Center" ScrollBars="Auto">
                    <asp:GridView ID="gridOrden" runat="server" AutoGenerateColumns="False" CellPadding="4" CssClass="auto-style33" DataKeyNames="ID_STOCK_MINIMO,ID_BODEGA" EnableModelValidation="True" ForeColor="#333333" Height="125px" OnSelectedIndexChanged="gridOrden_SelectedIndexChanged" OnRowCommand="gridOrden_RowCommand" PageSize="40" Width="100%">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="ID_STOCK_MINIMO" HeaderText="STOCK_MINIMO" ItemStyle-CssClass="ColumnaOculta" HeaderStyle-CssClass="ColumnaOculta">
                             <HeaderStyle CssClass="ColumnaOculta" />
                             <ItemStyle CssClass="ColumnaOculta" />
                            </asp:Boundfield>
                            <asp:BoundField DataField="ID_BODEGA" HeaderText="ID_BODEGA" ItemStyle-CssClass="ColumnaOculta" HeaderStyle-CssClass="ColumnaOculta">
                             <HeaderStyle CssClass="ColumnaOculta" />
                             <ItemStyle CssClass="ColumnaOculta" />
                            </asp:Boundfield>                            
                            <asp:BoundField DataField="CONTRATISTA" HeaderText="CONTRATISTA">
                            <HeaderStyle Width="10%" ForeColor="White"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="REGION" HeaderText="REGION">
                            <HeaderStyle Width="10%" ForeColor="White"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="BODEGA" HeaderText="BODEGA">
                            <HeaderStyle Width="10%" ForeColor="White"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="CATEGORIA" HeaderText="CATEGORIA">
                            <HeaderStyle Width="10%" ForeColor="White"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="DIAMETRO" HeaderText="DIAMETRO">
                            <HeaderStyle Width="10%" ForeColor="White"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="STOCK_DISPONIBLE" HeaderText="STOCK DISPONIBLE">
                            <HeaderStyle Width="10%" ForeColor="White"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="STOCK_MINIMO" HeaderText="STOCK MINIMO">
                            <HeaderStyle Width="10%" ForeColor="White"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="ESTADO" HeaderText="ESTADO">
                            <HeaderStyle Width="10%" ForeColor="White"/>
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="STOCK MINIMO">
                                <HeaderStyle ForeColor="White" Width="8%" Font-Size="8pt" />
                                <ItemStyle Font-Size="8pt" Width="10%" />
                                <ItemTemplate>
                                    <asp:TextBox ID="STOCK_MINIMO" Width="50px"  Font-Size="8pt" Font-Bold="true" runat="server" MaxLength="4"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>     
                             <asp:TemplateField HeaderText="VALIDAR">
                                          <HeaderStyle ForeColor="White" Width="50px" Font-Size="8pt" />
                                   <ItemStyle Font-Size="8pt" Width="20%" /> 
                                                <ItemTemplate>
                                            <asp:Button ID="AddButton" runat="server" CssClass="TextBox" BackColor="#8B0000" ForeColor="White"
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
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td class="auto-style19">&nbsp;</td>
            <td class="auto-style19">&nbsp;</td>
            <td class="auto-style19">&nbsp;</td>
            <td class="auto-style20">&nbsp;</td>
            <td class="auto-style20">&nbsp;</td>
            <td class="auto-style21">&nbsp;</td>
            <td class="auto-style23">&nbsp;</td>
            <td class="auto-style1">&nbsp;</td>
            <td class="auto-style2">&nbsp;</td>
        </tr>
        </table>
   </div>
     <div id="agregar" runat="server" Visible="false">
        <table class="auto-style9">
        <tr>
            <td  colspan=6 class="auto-style18" style="text-align: center">INGRESO DE DATOS - NUEVO STOCK MINIMO</td>
        </tr>
        <tr>
            <td class="auto-style43"></td>
            <td class="auto-style40"></td>
            <td class="auto-style42"></td>
            <td class="auto-style40"></td>
            <td class="auto-style42"></td>
            <td class="auto-style2">&nbsp;</td>
        </tr>
        <tr>
            <td style="text-align: right" class="auto-style45">
                <asp:Label ID="lbcontratista" runat="server">CONTRATISTA:</asp:Label>
            </td>
            <td class="auto-style52" style="text-align: center">
                <asp:DropDownList ID="cb_contratistas" runat="server" AutoPostBack="true" Height="20px" Width="200px" OnSelectedIndexChanged="cb_contratistas_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
            <td class="auto-style45" style="text-align: right">
                <asp:Label ID="lbregion" runat="server">REGIÓN:</asp:Label>
            </td>
            <td class="auto-style52" style="text-align: center">
                <asp:DropDownList ID="cb_regiones" runat="server" Height="20px" Width="200px" AutoPostBack="true" OnSelectedIndexChanged="cb_regiones_SelectedIndexChanged">
                 
                </asp:DropDownList>
            </td>
            <td class="auto-style45" style="text-align: right">
                <asp:Label ID="lb_bodega" runat="server">BODEGA:</asp:Label>
            </td>
            <td class="auto-style31" style="text-align: left">
                <asp:DropDownList ID="cb_bodegas" runat="server" Height="20px" Width="200px" OnSelectedIndexChanged="cb_bodegas_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="auto-style45" style="text-align: right">
                <asp:Label ID="lbcategoria" runat="server">CATEGORIA:</asp:Label>
            </td>
            <td class="auto-style52" style="text-align: center">
                <asp:DropDownList ID="cb_categorias" runat="server" Height="20px" Width="200px">
                </asp:DropDownList>
            </td>
            <td class="auto-style45" style="text-align: right">
                <asp:Label ID="lb_contrasena" runat="server">DIAMETRO:</asp:Label>
            </td>
            <td class="auto-style52" style="text-align: center">
                <asp:DropDownList ID="cb_diametros" runat="server" Height="20px" Width="200px">
                </asp:DropDownList>
            </td>
            <td class="auto-style45" style="text-align: right">
                <asp:Label ID="lb_estado" runat="server">STOCK MÍNIMO:</asp:Label>
            </td>
            <td class="auto-style31">
                <asp:TextBox ID="tb_stock_minimo" runat="server" Width="100px" Height="20px" MaxLength="5"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style49" style="text-align: right">
            </td>
            <td class="auto-style53" style="text-align: center"></td>
            <td class="auto-style49" style="text-align: right">
            </td>
            <td class="auto-style53" style="text-align: center"></td>
            <td class="auto-style49" style="text-align: right"></td>
            <td class="auto-style51">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style45" style="text-align: right">
                &nbsp;</td>
            <td class="auto-style47" style="text-align: center" colspan="4">
                <asp:Label ID="lb_error" runat="server" ForeColor="Red"></asp:Label>
            </td>
            <td class="auto-style2">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style45" style="text-align: right">
                &nbsp;</td>
            <td class="auto-style46" colspan="4" style="text-align: center">
                <asp:Button ID="btn_guardar" runat="server" BackColor="#336699" Font-Bold="True" Font-Names="Calibri" ForeColor="White" Text="CREAR STOCK MÍNIMO" OnClick="btn_guardar_Click" Font-Size="Small" Height="50px" />
            &nbsp;</td>
            <td class="auto-style31" style="text-align: center">
                <asp:Button ID="btn_volver" runat="server" BackColor="#336699" Font-Bold="True" Font-Names="Calibri" ForeColor="White" Text="VOLVER" OnClick="btn_volver_Click" OnClientClick="return confirm('Se descartarán todos los cambios realizados, ¿Está seguro de continuar?');" Height="50px" />
            </td>
        </tr>
        <tr>
            <td class="auto-style29" colspan="5" style="text-align: center">
                </td>
            <td class="auto-style29" style="text-align: center">
                </td>
        </tr>
        <tr>
            <td class="auto-style43">&nbsp;</td>
            <td class="auto-style40">&nbsp;</td>
            <td class="auto-style42">&nbsp;</td>
            <td class="auto-style40">&nbsp;</td>
            <td class="auto-style42">&nbsp;</td>
            <td class="auto-style2">&nbsp;</td>
        </tr>
        </table>
   </div>
        
</asp:Content>
