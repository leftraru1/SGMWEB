<%@ Page Title="Carga Medidores" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="CargaMedidores.aspx.cs" Inherits="CargaMedidores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
  
   <script src = " https://unpkg.com/sweetalert/dist/sweetalert.min.js "></script> 
   
    <style type="text/css">
        .auto-style49
        {
            height: 37px;
            text-align: center;
            width: 157px;
        }

        .auto-style51
        {
            height: 39px;
            text-align: right;
            width: 128px;
        }

        .auto-style58
        {
            height: 39px;
        }

        .auto-style71 {
            width: 157px;
            height: 6px;
        }

        .fiel {
            width: 1090px;
        }

        </style>
    <script type="text/javascript">

        if (history.forward(1)) {
            history.replace(history.forward(1));
        }

        function openCalendar(obj) {
            var url = 'calendario2.aspx?textbox=' + obj;
            window.open(url, 'cal', 'width=260,height=210,left=410 410,top=330,resizable=0,scrollbars=0');
        }

       function carga_realizada(cont,no_cont) {
              swal("CARGA REALIZADA EXITOSAMENTE: ","REGISTROS CARGADOS :" + cont + "\nREGISTROS NO CARGADOS: "+no_cont+ "", "success");
       }

       function carga_con_error(errores,total) {
           var variable = errores.split(".");
           var texto = "";
           var index;
           for (index = 0; index < variable.length; index++) {
               console.log(variable[index]);
               texto = texto + "\n" + variable[index];
           }
           swal("CARGA REALIZADA CON ERRORES",texto + "\n\n Total errores: " + total,"warning");
       }

       function error(mensaje) {
          swal("¡ERROR! ", "" + mensaje + "", "warning");
       }

       function correcto(mensaje) {
           swal("¡CORRECTO! ", "" + mensaje + "", "warning");
       }

        function errorCarga() {
        
            swal("¡ERROR! ", "Error al realizar carga de medidores.", "warning");
        }
        
        function cerro() {
            swal("¡CORRECTO!", "Se cerró la guía correctamente", "success");
        }

        function creo_guia() {
            swal("Se creó correctamente la guía ", "", "success");
        }

        function repiteCarga() {
        
            swal("¡ERROR! ", "Este archivo ya fue cargado.", "warning");
        }

        function se_elimino() {

            swal("¡Se eliminaron los medidores! ", "", "success");
        }

        function Error(mensaje) {
            swal("¡ERROR! ", ""+mensaje+" ", "warning");
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

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div id="panel3" runat="server" >
    <fieldset class="fiel">
    <legend id="Legend1" class="WebPartTitle" runat="server" >Carga de archivo<asp:Label ID="lb_rut_empresa" runat="server" Visible="False"></asp:Label></legend>
     <table style="height: 20px; width: 1086px;"  >
         
        <!-- SUBIDA DE ARCHIVO -->
        <tr>
            <td class="auto-style71">
                <asp:Label ID="Label14" runat="server" Text="Numero Guía :"></asp:Label>
                <asp:DropDownList ID="ddguia" runat="server" Width="200px" CssClass="ComboBox" AutoPostBack="true" OnLoad="ddguia_SelectedIndexChanged" OnSelectedIndexChanged="ddguia_SelectedIndexChanged" ></asp:DropDownList>
            </td>
            <td class="auto-style71">
                <asp:Label ID="Label3" runat="server" Text="Tipo proceso :"></asp:Label>
                <asp:DropDownList ID="ddtipoproceso" runat="server" Width="200px" CssClass="ComboBox" ></asp:DropDownList>
            </td>
            <td class="auto-style51">    
                <asp:Label ID="Label2" runat="server" Text="Archivo Medidores:"></asp:Label>
            </td>
            <td class="auto-style58" colspan="2">
                <asp:FileUpload ID="fuArchivo" runat="server" BorderStyle="None" Width="280px" CssClass="Button" />
                <br />
            </td>
            <td >
                <asp:Button ID="Button2" runat="server" CssClass="botonnew" OnClick="Button2_Click" Text="Cargar archivo medidores" ValidationGroup="btCargar" Height="24px" />
                 <asp:label ID="lbcont" runat="server" visible="false" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"></asp:label>
                <asp:Label ID="lb_mensaje" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="Navy"></asp:Label>
                <asp:Label ID="lb_mensaje_error" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" ForeColor="Red"></asp:Label>
                <img id="img_ok" runat="server" visible="False" /><br />
            </td>
            <td class="auto-style58">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="fuArchivo" ErrorMessage="No se ha seleccionado ningún archivo." ValidationGroup="btCargar"></asp:RequiredFieldValidator>
                <br />
<%--                <asp:RegularExpressionValidator ID="FileUpLoadValidator" runat="server" ErrorMessage="Solo archivos TXT." ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))(.txt|.TXT)$" ControlToValidate="fuArchivo" ValidationGroup="btCargar"></asp:RegularExpressionValidator>--%>
            </td>
        </tr>
        <tr>
            <td class="auto-style49" rowspan="3">&nbsp;</td>
            <td colspan="3">
                <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="X-Small" Visible="False"></asp:Label>
            </td>
            <td>&nbsp;</td>
        </tr>
         </table>
        <div style="padding-top:10px;padding-bottom:10px;text-align:center;">
                <asp:Button ID="finalizar_carga" Text="Terminar carga y cerrar guía" OnClick="finalizar_carga_Click" runat="server" Width="204px" CssClass="botonnew" Height="20px" ></asp:Button>
                &nbsp;&nbsp;
                <asp:Button runat="server"  ID="eliminar" Text="Limpiar carga" OnClick="eliminar_Click" Width="120px" BackColor="red" CssClass="botonnew" Height="20px"/>
        </div>

        <table style="height: 20px; width: 1092px;">
        <tr>
            <td>
                <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DETALLE GUIA</label>
            <asp:GridView ID="detalle_guia" runat="server" AllowPaging="True" ScrollBars="auto" OnRowCommand="detalle_guia_RowCommand"  OnSelectedIndexChanged="detalle_guia_SelectedIndexChanged" OnRowCreated="detalle_guia_RowCreated" DataKeyNames="CODIGO_ARTICULO" OnPageIndexChanging="detalle_guia_PageIndexChanging" AutoGenerateColumns="False" CellPadding="4" CssClass="GridAlternativeItems" EnableModelValidation="True" ForeColor="#333333"  PageSize="10" Width="200px" Height="16px" >
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="CODIGO_ARTICULO" HeaderText="CODIGO" Visible="false" >
                            <HeaderStyle ForeColor="White" />
                        </asp:BoundField>
                         <asp:BoundField DataField="COD_MARCA_MAP" HeaderText="CODIGO" >
                            <HeaderStyle ForeColor="White" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NOMBRE_ARTICULO" HeaderText="NOMBRE" >
                            <HeaderStyle ForeColor="White" Width="100px" />
                        </asp:BoundField>
                        <%--<asp:BoundField DataField="DIAMETRO" HeaderText="DIAMETRO" >
                            <HeaderStyle ForeColor="White" Width="50px" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>--%>
                        <asp:BoundField DataField="CANTIDAD" HeaderText="CANTIDAD DETALLE">
                            <HeaderStyle ForeColor="White"   />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                    </Columns>
                    <EditRowStyle BackColor="#2461BF" />
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                </asp:GridView>
            </td>
            <td>
            <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RESUMEN MEDIDORES</label>
            <asp:GridView ID="cant_medidores" runat="server" AllowPaging="True" ScrollBars="auto"  AutoGenerateColumns="False" CellPadding="4" CssClass="GridAlternativeItems" EnableModelValidation="True" ForeColor="#333333"  PageSize="10" Width="250px" Height="16px" >
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="ID_TIPO_MEDIDOR" HeaderText=" TIPO" Visible="false" >
                            <HeaderStyle ForeColor="White" />
                        </asp:BoundField>
                         <asp:BoundField DataField="COD_MARCA_MAP" HeaderText="CODIGO" >
                            <HeaderStyle ForeColor="White" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NOMBRE_MODELO" HeaderText="NOMBRE" >
                            <HeaderStyle ForeColor="White" Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CANTIDAD" HeaderText="CANTIDAD">
                            <HeaderStyle ForeColor="White"   />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                    </Columns>
                    <EditRowStyle BackColor="#2461BF" />
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                </asp:GridView>
            </td>
            <td>
                <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MEDIDORES INGRESADOS</label>
                <asp:GridView ID="medidores" runat="server" AllowPaging="True" ScrollBars="auto"   OnSelectedIndexChanged="medidores_SelectedIndexChanged" OnRowCreated="medidores_RowCreated" OnPageIndexChanging="medidores_PageIndexChanging" AutoGenerateColumns="False" CellPadding="4" CssClass="GridAlternativeItems" EnableModelValidation="True" ForeColor="#333333"  PageSize="10" Width="544px" Height="16px" >
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
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="REGION" HeaderText="REGION">
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
                </td>
        </tr>
          
    </table>
    </fieldset>
    </div>
</asp:Content>

