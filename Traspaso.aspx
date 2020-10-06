<%@ Page Title="Traspaso" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="Traspaso.aspx.cs" Inherits="Traspaso" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
  
   <script src = " https://unpkg.com/sweetalert/dist/sweetalert.min.js "></script> 

    <style type="text/css">
        
        .auto-style67 {
            width: 163px;
        }

        .auto-style70 {
            width: 134px;
            height: 6px;
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
        .filtro asp{
            padding: 0 50px;
        }
        
                
        .auto-style86 {
            width: 140px;
            height: 21px;
        }
        .auto-style87 {
            height: 21px;
        }
        
                
        .auto-style88 {
        }
        .serie_rango:first-child {
            padding-right: 20px;
        }
                
        .auto-style89 {
            height: 19px;
        }
                
        .auto-style91 {
            height: 38px;
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

       function atencion(mensaje) {
           swal("¡ATENCIÓN! ", "" + mensaje + "", "warning");
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

        function sucess() {
            swal("¡AGREGÓ CORRECTAMENTE! ", "Se agregaron items a la guía", "success");
        }

        function cancelar_todo() {
            swal("¡GUIA DE TRASPASO CANCELADA! ", "Se ha eliminado la guia de traspaso con su foto y traspasos realizados", "success");
        }

        function error_plantilla(mensaje) {
            swal("¡ERROR! ", "" + mensaje + "", "warning");
        }

        function cambio_ordenes(ordenes, total) {
            swal("Cambios efectuados ", "Se traspasaron " + ordenes + " de un total de " + total, "success");
        }
        function cambio_ordenes_error(ordenes, total) {
            swal("Cambios efectuados ", "Se traspasaron " + ordenes + " de un total de " + total, "warning");
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <div id="panel1" runat="server" class="field1">
    <fieldset class="fiel">
        <legend class="WebPartTitle" runat="server" >Guía de traspaso<asp:Label ID="lb_rut_empresa" runat="server" Visible="False"></asp:Label></legend>
    <table id="1" style="height: 20px; width: 445px; padding-bottom:10px;">
        
        <tr>
            <td class="auto-style84">
               <asp:Label ID="Label3" runat="server" Text="Numero guía :"></asp:Label>
            </td>
            <td class="" >
                <asp:TextBox ID="numero_guia" runat="server" Width="200px" CssClass="TextBox" AutoPostBack="true" OnTextChanged="numero_guia_TextChanged" MaxLength="18" ></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td class="auto-style84">
               <asp:Label ID="reserva_lb" runat="server" Text="Numero reserva :"></asp:Label>
            </td>
            <td class="" >
                <asp:TextBox ID="reserva" runat="server" Width="200px" CssClass="TextBox" MaxLength="30"></asp:TextBox>
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
        <label style="position:absolute;top:539px; left:1086px; width:159px;">FOTO GUÍA TRASPASO</label>


        <div style="padding-top:10px;padding-bottom:10px;" >
                &nbsp;</div>
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
                <asp:TextBox ID="despachado_por" runat="server" Width="100px" CssClass="TextBox" MaxLength="40" ></asp:TextBox>
                </td>
            <td class="auto-style83">
                <asp:Label ID="Label9" runat="server" Text="Rut despacho :"></asp:Label>
            </td>
            <td class="" >
                <asp:TextBox ID="rut_despacho" runat="server" Width="100px" CssClass="TextBox" MaxLength="13" ></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td class="">
                <asp:Label ID="Label8" runat="server" Text="Rut entidad a la que pertenece :"></asp:Label>
            </td>
            <td class="" >
                <asp:TextBox ID="rut_entidad" runat="server" Width="100px" CssClass="TextBox" MaxLength="13" ></asp:TextBox>
            </td>
            <td class="auto-style85">
                <asp:Label ID="Label15" runat="server" Text="Bodega origen:"></asp:Label>
            </td>
            <td class="auto-style78">
                 <asp:DropDownList ID="ddbodegas_origen" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddbodega_origen_change" Width="180px" CssClass="ComboBox" ></asp:DropDownList>
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
                <asp:TextBox ID="retirado_por" runat="server" Width="100px" CssClass="TextBox" MaxLength="40" ></asp:TextBox>
            </td>
            <td class="auto-style67">
                <asp:Label ID="Label6" runat="server" Text="Rut de quien retira :"></asp:Label>
            </td>
            <td class="">
                <asp:TextBox ID="rut_retiro" runat="server" Width="100px" CssClass="TextBox" MaxLength="13" ></asp:TextBox>
            </td>
            
        </tr>
        <tr>
            <td class="auto-style85">
                <asp:Label ID="Label10" runat="server" Text="Tipo Vehiculo :"></asp:Label>
            </td>
            <td class="auto-style78">
                <asp:TextBox ID="vehiculo" runat="server" Width="100px" CssClass="TextBox" MaxLength="20" ></asp:TextBox>
            </td>
            <td class="auto-style67">
                <asp:Label ID="Label5" runat="server" Text="Patente :"></asp:Label>
            </td>
            <td class="">
                <asp:TextBox ID="patente" runat="server" Width="100px" CssClass="TextBox" MaxLength="10" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            
            <td class="">
                <asp:Label ID="Label11" runat="server" Text="Fono contratista :"></asp:Label>
            </td>
            <td class="" >
                <asp:TextBox ID="fono" runat="server" Width="100px" CssClass="TextBox" MaxLength="9" ></asp:TextBox>
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
                <asp:Label ID="Label20" runat="server" Text="Bodega destino:"></asp:Label>
            </td>
            <td class="auto-style78">
                 <asp:DropDownList ID="ddbodegas" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddbodegas_SelectedIndexChanged" Width="180px" CssClass="ComboBox" ></asp:DropDownList>
            </td>
            
        </tr>

        </table>
        <div style="padding-top:10px;padding-bottom:10px;text-align:center;display:grid;">
            <div style="text-align:left;float:left;">
                <asp:Label ID="Label13" runat="server" Text="Foto guía traspaso:"></asp:Label>
                <input id="file" type="file"  name="file" onchange="previewFile()"  runat="server"  />
            </div>
            <div style="text-align:right;">
                 <asp:Button ID="Button1" Text="Generar guía" OnClick="genera_guia_Click"  runat="server" Width="114px" CssClass="botonnew" Height="16px" ></asp:Button>
      
            </div>
        </div>
        </fieldset>
        </div>
    
        <div id="panel2" runat="server" visible="false" class="field">
        <fieldset class="fiel">
        <legend id="Legend1" class="WebPartTitle" runat="server" >Detalle guía de traspaso a destino</legend>
        <table style="height: 20px;width:1000px;" >
            
        </table>

        <table style="height: 20px;width:1000px;" >
       
        <tr>
            <td>
                <div class="set_filtro"> 
                  <table id="filtromed" class="filtro" style="height: 20px; width: 95%; margin:10px;">
        
                    <tr>
                        <td class="auto-style86">
                           <asp:Label ID="Label_diametro_med" runat="server" Text="Diametro medidor"></asp:Label>
                        </td>
                        <td class="auto-style87" >
                              :
                              <asp:DropDownList ID="ddDiametroMed" runat="server" AutoPostBack="true" Width="180px" CssClass="ComboBox" OnSelectedIndexChanged="ddDiametroMed_SelectedIndexChanged" ></asp:DropDownList>
                        </td>
                        <td class="auto-style87" >
                              &nbsp;</td>
                    </tr>

                    <tr>
                        <td class="auto-style87">
                            <asp:Label ID="Label_marca_med" runat="server" Text="Marca medidor"></asp:Label>
                        </td>
                        <td class="auto-style87" >
                            :
                            <asp:DropDownList ID="ddMarcaMed" runat="server" AutoPostBack="true" Width="180px" CssClass="ComboBox" OnSelectedIndexChanged="ddMarcaMed_SelectedIndexChanged" ></asp:DropDownList>
                        
                        </td>
                        <td class="auto-style87" >
                            </td>
                    </tr>

                    <tr>
                        <td class="auto-style91">
                           <asp:Label ID="Label_serie_rango" runat="server" Text="N° serie desde hasta"></asp:Label>
                        </td>
                        <td class="auto-style91" >
                            :
                            <asp:TextBox ID="ddSerieDesde" runat="server" Width="80px" AutoPostBack="true" CssClass="TextBox" OnTextChanged="ddSerieDesde_TextChanged" ></asp:TextBox>
                            &nbsp;
                            <asp:TextBox ID="ddSerieHasta" runat="server" Width="80px" AutoPostBack="true" CssClass="TextBox" OnTextChanged="ddSerieHasta_TextChanged" ></asp:TextBox>
                        
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="ddSerieDesde" ErrorMessage="Solo numeros" ForeColor="Red" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="ddSerieHasta" ErrorMessage="Solo numeros" ForeColor="Red" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
                        
                        </td>
                        <td class="auto-style91" >
                            </td>
                    </tr>

                    <tr>
                        <td class="auto-style88" style="text-align:right;" colspan="3">
                
                <asp:Button ID="btn_traspasar_medidores" Text="Traspasar medidores" OnClientClick="confirm('Confirme el traspaso, ¿Está seguro?');" runat="server" Width="150px" CssClass="botonnew" BackColor="Green" Height="16px" OnClick="btn_traspasar_medidores_Click" ></asp:Button>
                        </td>
                    </tr>
                </table>
                </div>
                <fieldset><legend><div style="text-align:center"><h3 style="color:darkblue">MEDIDORES</h3></div></legend>
                <asp:GridView ID="medidores" runat="server" AllowPaging="True" ScrollBars="auto"   OnSelectedIndexChanged="medidores_SelectedIndexChanged" OnRowCommand="medidores_RowCommand" OnRowCreated="medidores_RowCreated" OnPageIndexChanging="medidores_PageIndexChanging" AutoGenerateColumns="False" CellPadding="4" CssClass="GridAlternativeItems" EnableModelValidation="True" ForeColor="#333333"  PageSize="10" Width="95%" Height="16px" >
                    <%-- OnRowCommand=""--%>
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="ID_GUIA" HeaderText="GUIA" >
                            <HeaderStyle ForeColor="White" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ID_MEDIDOR" HeaderText="ID_MEDIDOR" >
                            <HeaderStyle ForeColor="White" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SERIE" HeaderText="SERIE">
                            <HeaderStyle ForeColor="White" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ANO" HeaderText="AÑO">
                            <HeaderStyle ForeColor="White" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DIAMETRO" HeaderText="DIAMETRO">
                            <HeaderStyle ForeColor="White" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CONTRATISTA" HeaderText="CONTRATISTA">
                            <HeaderStyle ForeColor="White" />
                            <ItemStyle HorizontalAlign="Center" Width="100px" />
                        </asp:BoundField>
                         <asp:BoundField DataField="DESCRIPCION" HeaderText="DESCRIPCION">
                            <HeaderStyle ForeColor="White" Width="120px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="REGION" HeaderText="REGION">
                            <HeaderStyle ForeColor="White" Width="120px" />
                        </asp:BoundField>

                         <asp:TemplateField HeaderText="cambiar">
                                                <HeaderTemplate>
                                                    <asp:LinkButton ID="cambiar_todo" runat="server" CommandName="cambiar_todo" >MARCAR TODO</asp:LinkButton>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="cambiar" runat="server" />
                                                </ItemTemplate>
                                                <HeaderStyle ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" Width="10px" />
                         </asp:TemplateField>
                         <asp:BoundField DataField="CODIGO" HeaderText="CODIGO">
                            <HeaderStyle ForeColor="White" />
                        </asp:BoundField>
                    </Columns>
                    <EditRowStyle BackColor="#2461BF" />
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                </asp:GridView>
                </fieldset>
            </td>        
            
            <td>
                <div class="set_filtro"> 
                  <table id="Table1" class="filtro" style="height: 20px; width: 95%; margin:10px;">
        
                    <tr>
                        <td class="auto-style86">
                           <asp:Label ID="Label16" runat="server" Text="Diametro accesorio"></asp:Label>
                        </td>
                        <td class="auto-style87" >
                              :
                              <asp:DropDownList ID="ddDiametroAcc" runat="server" AutoPostBack="true" Width="180px" CssClass="ComboBox" OnSelectedIndexChanged="ddDiametroAcc_SelectedIndexChanged" ></asp:DropDownList>
                        </td>
                        <td class="auto-style87" >
                              &nbsp;</td>
                    </tr>

                  
                    <tr>
                        <td class="auto-style87">
                            <asp:Label ID="Label19" runat="server" Text="Tipo material"></asp:Label>
                        </td>
                        <td class="auto-style87" >
                            :
                           <asp:DropDownList ID="ddTipoMaterialAcc" runat="server" AutoPostBack="true" Width="180px" CssClass="ComboBox" OnSelectedIndexChanged="ddTipoMaterialAcc_SelectedIndexChanged" ></asp:DropDownList>
                        </td>
                        <td class="auto-style87" >
                            </td>
                    </tr>

                    <tr>
                      <td class="auto-style91" >
                            <asp:Label ID="Label21" runat="server"></asp:Label>
                        </td>  
                        <td class="auto-style91">
                            </td>
                        <td class="auto-style91">
                            </td>
                    </tr>

                    <tr>
                      <td class="auto-style88" style="text-align:right;" colspan="3">
                
                <asp:Button ID="btn_traspasar_acc" Text="Traspasar accesorios" OnClientClick="confirm('Confirme el traspaso, ¿Está seguro?');" runat="server" Width="150px" CssClass="botonnew" BackColor="Green" Height="16px" OnClick="btn_traspasar_acc_Click" ></asp:Button>
                      </td>  
                    </tr>
                </table>
                </div>

                <fieldset><legend><div style="text-align:center"><h3 style="color:darkblue">ACCESORIOS</h3></div></legend>
                
                <asp:GridView ID="Accesorios" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" CssClass="GridAlternativeItems" EnableModelValidation="True" ForeColor="#333333"   OnPageIndexChanging="Accesorios_PageIndexChanging" OnRowDataBound="Accesorios_RowDataBound"  PageSize="10" Width="95%" Height="16px" >
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="ID_ACCESORIO" HeaderText="ACCESORIO">
                            <HeaderStyle ForeColor="White" />
                        </asp:BoundField>

                        <asp:BoundField DataField="ID_BODEGA" HeaderText="ID_BODEGA">
                            <HeaderStyle ForeColor="White" />
                            <ItemStyle Font-Size="Smaller" />
                        </asp:BoundField>

                        <asp:BoundField DataField="BODEGA" HeaderText="BODEGA">
                            <HeaderStyle ForeColor="White" />
                            <ItemStyle Font-Size="Smaller" Width="100px" />
                        </asp:BoundField>

                        <asp:BoundField DataField="CODIGO_PROVEEDOR" HeaderText="CODIGO ACCESORIO">
                            <HeaderStyle ForeColor="White" />
                            <ItemStyle Font-Size="Smaller" />
                        </asp:BoundField>

                        <asp:BoundField DataField="DIAMETRO" HeaderText="DIAMETRO">
                            <HeaderStyle ForeColor="White" />
                            <ItemStyle Font-Size="Smaller" Width="20px" />
                        </asp:BoundField>

                        <asp:BoundField DataField="STOCK_TOTAL" HeaderText="STOCK TOTAL">
                            <HeaderStyle ForeColor="White" />
                            <ItemStyle Font-Size="Smaller" Width="20px" />
                        </asp:BoundField>

                        <asp:BoundField DataField="STOCK" HeaderText="STOCK DISP.">
                            <HeaderStyle ForeColor="White" />
                            <ItemStyle Font-Size="Smaller" Width="20px" />
                        </asp:BoundField>


                        <asp:TemplateField HeaderText="CANTIDAD">
                            <ItemTemplate>
                                <asp:TextBox ID="cant_cambio" ImageAlign="Middle" MaxLength="4" CssClass="TextBox" runat="server" Width="30px" Font-Size="Small"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="20px" />
                            <HeaderStyle ForeColor="White" />
                        </asp:TemplateField>


                    </Columns>
                    <EditRowStyle BackColor="#2461BF" />
                    <FooterStyle BackColor="Red" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="Red" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="Red" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                </asp:GridView>
                    </fieldset>
            </td>
        </tr>

        </table>
        <div style="text-align:center;">
            <fieldset style="width:60%; left:0; right:0; margin-left:auto; margin-right:auto;" ><legend ><div style="text-align:center"><h3 style="color:darkblue">DETALLE GUÍA</h3></div></legend>
                
                    <asp:GridView ID="articulos"  runat="server" AllowPaging="True"  OnSelectedIndexChanged="articulos_SelectedIndexChanged" OnRowCommand="articulos_RowCommand"  OnPageIndexChanging="articulos_PageIndexChanging" OnRowCreated="articulos_RowCreated"  ScrollBars="Auto" AutoGenerateColumns="False"  CellPadding="4" CssClass="GridAlternativeItems" EnableModelValidation="True" ForeColor="#333333"  PageSize="10" Width="95%" Height="36px" >
                    
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
                   
               </fieldset>
            <div style="left:0; right:0; margin-left:auto; margin-right:auto; padding-top:10px;padding-bottom:10px;text-align:center; width: 60%; display:inline-flexbox;">
                <div style="float:left;">
                    <asp:Button ID="Button4" Text="Cancelar todo" OnClientClick="confirm('Se descartará todo, ¿Seguro que desea cancelar el traspaso?');" runat="server" Width="120px" CssClass="botonnew" BackColor="Red" Height="16px" OnClick="Button4_Click" ></asp:Button>
                </div>
                <div style="float:right;">
                    <asp:Button ID="Button3" Text="Finalizar" OnClick="finalizar" OnClientClick="confirm('¿Seguro que desea cerrar la guía?');" runat="server" Width="150px" CssClass="botonnew" BackColor="DarkBlue" Height="16px" ></asp:Button>
 
                </div>
             </div>
        </div>
        
        </fieldset>
    </div>
</asp:Content>

