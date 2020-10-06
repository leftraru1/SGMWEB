<%@ Page Title="Genera Guía" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="Genera_guia.aspx.cs" Inherits="Genera_guia" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
  
   <script src = " https://unpkg.com/sweetalert/dist/sweetalert.min.js "></script> 

    <style type="text/css">
        
        .auto-style67 {
            width: 163px;
        }

        .auto-style69 {
            width: 257px;
            height: 6px;
            padding-bottom:15px;
        }

        .auto-style70 {
            width: 134px;
            height: 6px;
        }
        
        .auto-style72 {
            height: 39px;
            text-align: right;
            width: 70px;
        }

        .field {
            width:1151px;
            padding-top:10px;
            margin-right: 35px;
        }

        .field1 {
            width:465px;
            padding-top:10px;
            margin-right: 35px;
        }
        .auto-style78 {
            width: 195px;
        }

        .auto-style79 {
            width: 124px;
        }
        .auto-style80 {
            width: 124px;
            height: 21px;
        }
        .auto-style82 {
            width: 173px;
        }
        .auto-style83 {
            width: 106px;
            height: 21px;
        }

        .img {
            
        }
        img.zoom {
        width: 365px;
        height: 386px;
        -webkit-transition: all .2s ease-in-out;
        -moz-transition: all .2s ease-in-out;
        -o-transition: all .2s ease-in-out;
        -ms-transition: all .2s ease-in-out;
        float:right;
        position:absolute;top:150px;left:957px;
        }
 
        .transition {
            -webkit-transform: scale(1.8); 
            -moz-transform: scale(1.8);
            -o-transform: scale(1.8);
            transform: scale(1.8);
        }

        .auto-style84 {
            width: 111px;
        }

        .fiel {
            width: 612px;
        }

        .auto-style85 {
            width: 134px;
        }

        .auto-style89 {
            width: 112px;
        }
        
        .auto-style91 {
            width: 129px;
        }

        .auto-style92 {
            width: 75px;
        }
        .auto-style93 {
            width: 83px;
        }
        .auto-style94 {
            width: 70px;
        }

        </style>
    <script type="text/javascript">

        if (history.forward(1)) {
            history.replace(history.forward(1));
        }

        function previewFile() {
            var preview = document.querySelector('#<%=foto.ClientID %>');
            var file = document.querySelector('#<%=file.ClientID %>').files[0];
            var reader = new FileReader();

            reader.onloadend = function () {
                preview.src = reader.result;
            }

            if (file) {
                reader.readAsDataURL(file);
            } else {
                preview.src = "";
            }
        }

        $(document).ready(function () {
            $('.zoom').hover(function () {
                $(this).addClass('transition');
            }, function () {
                $(this).removeClass('transition');
            });
        });

        function openCalendar(obj) {
            var url = 'calendario2.aspx?textbox=' + obj;
            window.open(url, 'cal', 'width=260,height=210,left=410 410,top=330,resizable=0,scrollbars=0');
        }

       function carga_realizada(cont) {
              swal("CARGA REALIZADA EXITOSAMENTE: ","" + cont + " REGISTROS CARGADOS", "success");
       }

       function error(mensaje) {
          swal("¡ERROR! ", "" + mensaje + "", "warning");
       }

        function errorCarga() {
        
            swal("¡ERROR! ", "Error al realizar carga de medidores.", "warning");
        }
        
        function creo() {
            swal("Se agregó item al detalle ", "", "success");
        }

        function creo_guia() {
            swal("Se creó correctamente la guía ", "", "success");
        }
        function repiteCarga() {
        
            swal("¡ERROR! ", "Este archivo ya fue cargado.", "warning");
        }

        function se_elimino() {

            swal("¡Se elimino detalle! ", "", "success");
        }

        function Error() {
            swal("¡ERROR! ", "Error ", "warning");
        }

        function busque() {
            swal("¡ERROR! ", "No seleccionó archivo", "warning");
        }
        function Error_tipo() {
            swal("¡ERROR! ", "El archivo que intento subir no es del tipo que el sistema permite", "warning");
        }
        function ok(nombre) {
            swal("¡SE SUBIO CORRECTAMENTE EL ARCHIVO! ", "", "success");
        }

        function correcto() {
            swal("¡SE CERRÓ GUÍA CORRECTAMENTE! ", "La guía y su detalle se cerraron", "success");
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <div id="panel1" runat="server" class="field1">
    <fieldset class="fiel">
        <legend class="WebPartTitle" runat="server" >Guía de despacho<asp:Label ID="lb_rut_empresa" runat="server" Visible="False"></asp:Label></legend>
    <table id="1" style="height: 20px; width: 445px; padding-bottom:10px;">
        
        <tr>
            <td class="auto-style84">
               <asp:Label ID="Label3" runat="server" Text="Numero guía :"></asp:Label>
            </td>
            <td class="" >
                <asp:TextBox ID="numero_guia" runat="server" Width="200px" CssClass="TextBox" ></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td class="auto-style84">
               <asp:Label ID="reserva_lb" runat="server" Text="Numero reserva :"></asp:Label>
            </td>
            <td class="" >
                <asp:TextBox ID="reserva" runat="server" Width="200px" AutoPostBack="true" CssClass="TextBox" OnTextChanged="reserva_TextChanged" ></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td class="auto-style84">
                <asp:Label ID="Label12" runat="server" Text="Fecha despacho :"></asp:Label>
            </td>
            <td class="" >
                <asp:TextBox ID="fecha_despacho" runat="server" Width="100px" CssClass="TextBox" ></asp:TextBox>
                <img src="Imagenes/calendario.gif" onclick="openCalendar('ctl00_ContentPlaceHolder1_fecha_despacho');"  id="IMG7" />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="fecha_despacho" ErrorMessage="Error formato fecha." ValidationExpression="(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d"></asp:RegularExpressionValidator>   
            </td>
        </tr>
        </table>

        <asp:Image runat="server" ID="foto"  CssClass="zoom" BorderStyle="Solid"/>
        <label style="position:absolute;top:539px; left:1086px; width:159px;">FOTO GUÍA DESPACHO</label>


        <div style="padding-top:10px;padding-bottom:10px;" >
                <asp:Label ID="Label13" runat="server" Text="Foto guía despacho:"></asp:Label>
                <input id="file" type="file"  name="file" onchange="previewFile()"  runat="server"  /> 
        </div>
        </fieldset>
        </div>
        

        <div id="Div1" runat="server" class="field">
        <fieldset class="fiel">
            <legend id="Legend2" class="WebPartTitle" runat="server" >Datos despachador<asp:Label ID="Label1" runat="server" Visible="False"></asp:Label></legend>
        <table style="height: 20px; width: 611px; padding-bottom:10px;">

        <tr>
            <td class="auto-style80">
                <asp:Label ID="Label7" runat="server" Text="Despachado por :"></asp:Label>
            </td>
            <td class="auto-style82" >
                <asp:TextBox ID="despachado_por" runat="server" Width="100px" CssClass="TextBox" ></asp:TextBox>
                </td>
            <td class="auto-style83">
                <asp:Label ID="Label9" runat="server" Text="Rut despacho :"></asp:Label>
            </td>
            <td class="" >
                <asp:TextBox ID="rut_despacho" runat="server" Width="100px" CssClass="TextBox" ></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td class="">
                <asp:Label ID="Label8" runat="server" Text="Rut entidad a la que pertenece :"></asp:Label>
            </td>
            <td class="" >
                <asp:TextBox ID="rut_entidad" runat="server" Width="100px" CssClass="TextBox" ></asp:TextBox>
            </td>
        </tr>
        </table>
        </fieldset>
        </div>

        <div id="Div2" runat="server" class="field">
        <fieldset class="fiel">
            <legend id="Legend3" class="WebPartTitle" runat="server" >Datos quien retira<asp:Label ID="Label2" runat="server" Visible="False"></asp:Label></legend>
        <table style="height: 20px; width: 611px; padding-bottom:10px;">

        <tr>
             <td class="auto-style85">
                <asp:Label ID="Label4" runat="server" Text="Retirado por :"></asp:Label>
            </td>
            <td class="auto-style78">
                <asp:TextBox ID="retirado_por" runat="server" Width="100px" CssClass="TextBox" ></asp:TextBox>
            </td>
            <td class="auto-style67">
                <asp:Label ID="Label6" runat="server" Text="Rut de quien retira :"></asp:Label>
            </td>
            <td class="">
                <asp:TextBox ID="rut_retiro" runat="server" Width="100px" CssClass="TextBox" ></asp:TextBox>
            </td>
            
        </tr>
        <tr>
            <td class="auto-style85">
                <asp:Label ID="Label10" runat="server" Text="Tipo Vehiculo :"></asp:Label>
            </td>
            <td class="auto-style78">
                <asp:TextBox ID="vehiculo" runat="server" Width="100px" CssClass="TextBox" ></asp:TextBox>
            </td>
            <td class="auto-style67">
                <asp:Label ID="Label5" runat="server" Text="Patente :"></asp:Label>
            </td>
            <td class="">
                <asp:TextBox ID="patente" runat="server" Width="100px" CssClass="TextBox" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            
            <td class="">
                <asp:Label ID="Label11" runat="server" Text="Fono contratista :"></asp:Label>
            </td>
            <td class="" >
                <asp:TextBox ID="fono" runat="server" Width="100px" CssClass="TextBox" ></asp:TextBox>
            </td>
            <td class="auto-style70">
                <asp:Label ID="Label18" runat="server" Text="Contratista :"></asp:Label>
            </td>
            <td class="auto-style78">
                <asp:DropDownList ID="ddcontratista" runat="server"   Width="100px" CssClass="ComboBox" AutoPostBack="True" OnSelectedIndexChanged="ddcontratista_SelectedIndexChanged" ></asp:DropDownList>
            </td>
            
        </tr>
        
        <tr>
            <td class="auto-style79">
                <asp:Label ID="Label14" runat="server" Text="Region destino:"></asp:Label>
            </td><td class="auto-style82">
                <asp:DropDownList ID="ddregion" runat="server" Width="100px" CssClass="ComboBox" AutoPostBack="True" OnSelectedIndexChanged="ddregion_SelectedIndexChanged" ></asp:DropDownList>
            </td>
            <td class="auto-style85">
                <asp:Label ID="Label20" runat="server" Text="Bodega contratista:"></asp:Label>
            </td>
            <td class="auto-style78">
                 <asp:DropDownList ID="ddbodegas" runat="server" Width="180px" CssClass="ComboBox" ></asp:DropDownList>
            </td>
            
        </tr>

        </table>
        <div style="padding-top:10px;padding-bottom:10px;text-align:center;">
                <asp:Button ID="Button1" Text="Generar guía" OnClick="genera_guia_Click"  runat="server" Width="114px" CssClass="botonnew" Height="16px" ></asp:Button>
        </div>
        </fieldset>
        </div>
    
        <div id="panel2" runat="server" visible="false" class="field">
        <fieldset class="fiel">
        <legend id="Legend1" class="WebPartTitle" runat="server" >Detalle guía</legend>
        <table style="height: 20px;width:900px;" >
            
        <tr>
            <td class="auto-style94">
            <%--    <asp:Label ID="Label15" runat="server" Text="Tipo :" Visible="false"></asp:Label>--%>
                <asp:DropDownList ID="tipo" runat="server" Width="10px" OnSelectedIndexChanged="tipo_SelectedIndexChanged" CssClass="ComboBox" Visible="false" >
                </asp:DropDownList>
            </td>
            <td class="auto-style89" >
                <%--<asp:Label ID="Label16" runat="server" Text="Codigo :" Visible="false"></asp:Label>--%>
                <asp:DropDownList ID="codigo" runat="server" Width="10px" CssClass="ComboBox" OnSelectedIndexChanged="codigo_SelectedIndexChanged" Visible="false" ></asp:DropDownList>
            </td>
            <td class="auto-style91">
                <asp:Label ID="descripcion" runat="server" Text="Descripcion :"></asp:Label>
                <asp:DropDownList ID="ddescripcion" runat="server" Width="300px" CssClass="ComboBox" ></asp:DropDownList>
            </td>
<%--            <td class="auto-style92">
                <asp:Label ID="Label21" runat="server" Text="Diametro :"></asp:Label>
                <asp:DropDownList ID="dddiametro" runat="server" Width="100px" CssClass="ComboBox" ></asp:DropDownList>
            </td>--%>
            <td class="auto-style93">
                <asp:Label ID="Label17" runat="server" Text="Cantidad :"></asp:Label>
                <asp:TextBox ID="cantidad" runat="server" Width="100px" CssClass="TextBox" ></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="cantidad" ErrorMessage="Solo numeros" ForeColor="Red" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
            </td>
            <td class="auto-style69" >
                <asp:ImageButton ID="agregar"  OnClick="agregar_detalle" runat="server" src="Imagenes/check.ico"  Width="25px" /> 
            </td>
            </tr>
        </table>
            <div style="padding-top:10px;padding-bottom:10px;text-align:center;">
            
                <asp:Label ID="carga" runat="server" Text="Carga detalle :"></asp:Label>
                <asp:FileUpload ID="fuArchivo" runat="server" BorderStyle="None" Width="280px" CssClass="Button" />
                <asp:Button ID="cargar" runat="server" OnClick="carga_detalle" Height="20px" CssClass="botonnew"  Text="cargar archivo detalle" />
           
            </div>

        <table style="height: 20px;width:900px;" >
        <tr>        
            <td colspan="5">
                <asp:GridView ID="articulos" runat="server" AllowPaging="True"  OnSelectedIndexChanged="articulos_SelectedIndexChanged" OnRowCommand="articulos_RowCommand"  OnPageIndexChanging="articulos_PageIndexChanging" OnRowCreated="articulos_RowCreated"  ScrollBars="Auto" AutoGenerateColumns="False"  CellPadding="4" CssClass="GridAlternativeItems" EnableModelValidation="True" ForeColor="#333333"  PageSize="5" Width="1000px" Height="36px" >
                    
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="ID_DETALLE_GUIA" HeaderText="ID_DETALLE">
                            <HeaderStyle ForeColor="White" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ID_GUIA" HeaderText="ID_GUIA">
                            <HeaderStyle ForeColor="White" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NUMERO_GUIA" HeaderText="GUIA">
                            <HeaderStyle ForeColor="White" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CODIGO_ARTICULO" HeaderText="CODIGO PROVEEDOR">
                            <HeaderStyle ForeColor="White" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NOMBRE_ARTICULO"  HeaderText="ARTICULO">
                            <HeaderStyle ForeColor="White" Width="500px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DIAMETRO" HeaderText="DIAMETRO">
                            <HeaderStyle ForeColor="White" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CANTIDAD" HeaderText="CANTIDAD">
                            <HeaderStyle ForeColor="White" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="ELIMINAR">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="eliminar" ImageAlign="Middle" runat="server" CommandArgument="<%# Container.DataItemIndex%>" OnClientClick="return ShowProgress();" CommandName="eliminar" src="Imagenes/delete.png" Width="20px" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="20px" />
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
            </td>
        </tr>
         <tr>
            <td class="auto-style72">
<%--                <asp:Button ID="guardar_detale" Text="Guardar detalle" runat="server" Width="114px" CssClass="botonnew" Height="16px" ></asp:Button>--%>
            </td>
        </tr>



        </table>
        
        <div style="padding-top:10px;padding-bottom:10px;text-align:center;">
            
                <asp:Button ID="Button3" Text="Finalizar" OnClick="finalizar" OnClientClick="confirm('¿Seguro que desea cerrar la guía?');" runat="server" Width="114px" CssClass="botonnew" Height="16px" ></asp:Button>
        </div>
        </fieldset>
    </div>
</asp:Content>

