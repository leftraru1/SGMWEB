<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="MantencionContratista.aspx.cs" Inherits="MantencionContratista" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">  
         body {  
             font-family: Arial;  
             font-size: 10pt;  
         }  
      
         td {  
             cursor: pointer;   
         }  
      
         .hover_row {  
             background-color: #A1DCF2;  
         }  </style>
    <style type="text/css">
        .auto-style5
        {
            height: 19px;
        }
        .auto-style9
        {
            height: 22px;
            width: 231px;
        }
        .auto-style10
        {
            height: 23px;
            width: 339px;
        }
        .auto-style13
        {
            height: 26px;
            width: 149px;
        }
        .auto-style14
        {
            height: 36px;
        }
        .auto-style15
        {
            height: 35px;
        }
        .auto-style16
        {
            height: 34px;
            width: 339px;
        }
        .auto-style17
        {
            height: 33px;
            width: 149px;
        }
        .auto-style21
        {
            height: 36px;
            width: 149px;
        }
        .auto-style23
        {
            height: 37px;
            width: 231px;
        }
        .auto-style25
        {
            width: 231px;
        }
        .auto-style27
        {
            height: 36px;
            width: 231px;
        }
        .auto-style29
        {
            width: 339px;
        }
        .auto-style30
        {
            height: 36px;
            width: 339px;
        }
        .auto-style31
        {
            width: 149px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <script type="text/javascript">
         $(function () {
             $("[id*=GrillaContratistas] td").hover(function () {
                 $("td", $(this).closest("tr")).addClass("hover_row");
             }, function () {
                 $("td", $(this).closest("tr")).removeClass("hover_row");
             });
         });
     </script>
    
    <script>
        var par = false;
        function parpadeo() {
            col = par ? 'green' : 'black';
            document.getElementById('txtAscii').style.color = col;
            par = !par;
            setTimeout("parpadeo()", 500); //500 = medio segundo 
        }
        window.onload = parpadeo;
</script>  
      <table style="WIDTH: 758px; HEIGHT: 152px; background-color: #FFFFFF;" cellSpacing="0" cellPadding="0" width="758"
				align="center" border="0">
          <tr>
              <td> </td>
              <td> 
                 <asp:Label ID="lb_session_user" runat="server" Font-Names="Arial" Font-Size="X-Small">
                 </asp:Label>
                 &nbsp;<asp:Label ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small">
                 </asp:Label> </td>
              <td></td>  </tr>
           <tr >
            <td align="center" colspan="4" style="font-size: medium; font-weight: bold; font-family: Arial, Helvetica, sans-serif; text-decoration: underline; color: #000000;" class="auto-style5"  >Mantenedor de Contratista</td>
        </tr>
 <tr>    
            <td align="center">    &nbsp;</td><td align="center">
                                 <asp:Label ID="lb_cantidad_registros" runat="server" Text="coincidencia(s) encontrada(s)" Width="153px"></asp:Label>
      
                             </td>
     

 </tr>
          <tr>    
            <td align="center">    &nbsp;</td><td align="right">
                                                        <asp:Button ID="btoNuevoContratista" runat="server" CausesValidation="False" CssClass="botonnew" Text="Nuevo Contratista" Width="20%" Height="22px" OnClick="btnok_agregar0_Click" />

      
                             </td>
     

 </tr>

      
                                                   
         <tr><td></td>
             
                             <td align="right" colspan="1">&nbsp;&nbsp;<asp:DataGrid ID="GrillaContratistas" runat="server" AutoGenerateColumns="False" BorderWidth="1px" CellPadding="4" CssClass="GridActiveItem" Height="1px" Width="699px" BorderStyle="None" Font-Bold="True" AllowPaging="True" BackColor="White" BorderColor="#DEDFDE" ForeColor="Black" GridLines="Vertical" OnPageIndexChanged="GrillaContratistas_PageIndexChanged" OnEditCommand="GrillaContratistas_EditCommand">
                                     <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" BackColor="#CCCC99" />
                                 <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                                 <Columns>
                                     <asp:BoundColumn DataField="id_contratista" HeaderText="id_contratista" Visible="False">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                     </asp:BoundColumn>
                                     <asp:BoundColumn DataField="nombre" HeaderText="NOMBRE">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                     </asp:BoundColumn>
                                     <asp:BoundColumn DataField="rut" HeaderText="RUT">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                     </asp:BoundColumn>
                                     <asp:BoundColumn DataField="rut_empresa" HeaderText="EMPRESA">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                     </asp:BoundColumn>
                                     <asp:BoundColumn DataField="estado" HeaderText="ESTADO">
                                                                         <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>

                                     </asp:BoundColumn>
                                     <asp:BoundColumn DataField="cod_contratista" HeaderText="COD. CONTRATISTA">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                     </asp:BoundColumn>
                                     <asp:BoundColumn DataField="fecha_creacion" HeaderText="FECHA CREACION" >
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                     </asp:BoundColumn>
                                     <asp:EditCommandColumn CancelText="Cancel" EditText="Editar" HeaderText="MODIFICAR" UpdateText="Update">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="#3300CC" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                     </asp:EditCommandColumn>
                                     <asp:ButtonColumn CommandName="Delete" HeaderText="Habilitar/Deshabilitar" Text="Habilitar/Deshabilitar" Visible="False">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="#3300CC" HorizontalAlign="Center" />
                                         <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" />
                                     </asp:ButtonColumn>
                                 </Columns>
                                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Center" Mode="NumericPages" PageButtonCount="5" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                        <ItemStyle BackColor="#F7F7DE" HorizontalAlign="Center" BorderStyle="Solid" />
                        <AlternatingItemStyle BackColor="White" />
                        <SelectedItemStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" BorderStyle="Ridge" BorderColor="#66FF33" />
                                 </asp:DataGrid> &nbsp;</td> <td></td>
                         </tr>
         <tr>
                             <td align="center" colspan="2">&nbsp;</td>
                         </tr></table>
     
     <table runat="server" id="tablaAgregaContratista" style="border: 1px solid #808080; font-family: Arial; font-size: medium; font-weight: bold; width: 947px; background-color: #CCCCCC;" align="center" >
     <tr>
             <td class="auto-style23">
                 </td>
                 <td ></td><td class="auto-style31" ></td><td >&nbsp;</td>
         </tr>
    <tr >
            <td  colspan="1" style="font-size: medium; font-weight: bold; font-family: Arial, Helvetica, sans-serif; text-decoration: underline; color: #000000; width: 161px;" class="auto-style5"  >&nbsp;Agregar Contartista</td>
         <td></td>
         <td> <span id="txtAscii" style="font-size:large"
                <asp:Label ID="lbAsci" runat="server" font-bold="False" width="50%" style="text-align: left; margin-top: 6px; font-size: medium;" height="30px" ></asp:Label></span> 
                 </td>
        </tr>
        <tr>
           
      <td colspan="4"  >
               
               <asp:label id="lbInformacion0" runat="server" font-bold="False" width="100%" style="text-align: center; margin-top: 6px; font-size: medium;" height="30px"></asp:label> 

            </td>
           
           
        </tr>
    <tr>
            <td  >
                
            </td>
        <td ></td><td class="auto-style31" ></td><td></td>
        </tr>  
         <tr>
            <td class="auto-style25"  >
                &nbsp;&nbsp;
                Nombre :</td>
        <td class="auto-style29">
            <asp:TextBox ID="txtNombreContratista" runat="server" Width="80%" MaxLength="30" required></asp:TextBox>
             </td><td align="left" class="auto-style31">&nbsp;&nbsp; Rut:</td><td>
            <asp:TextBox ID="txtRut" runat="server" Width="67%" MaxLength="9" required></asp:TextBox>
             -<asp:TextBox ID="txt_dv" runat="server" Width="12%" MaxLength="1" required></asp:TextBox>
             </td>
        </tr> 
         <tr><td class="auto-style25"></td><td class="auto-style29"></td><td align="left" class="auto-style31">&nbsp;&nbsp;&nbsp;</td>
             <td>
                 &nbsp;</td>
             

         </tr> 
         <tr><td >&nbsp;&nbsp;&nbsp; Código Contratista:</td><td class="auto-style29">
            <asp:TextBox ID="txtCodigoContratista" runat="server" Width="80%" MaxLength="10" required></asp:TextBox>
             </td><td align="left" class="auto-style31" >&nbsp;&nbsp;&nbsp;Empresa:</td>
             <td>
                <asp:DropDownList ID="combo_empresas" runat="server" style="text-align: center" Width="80%">
                </asp:DropDownList>
             </td>
             

         </tr> 
           <tr><td ></td><td ></td><td align="left" class="auto-style31" >&nbsp;&nbsp;&nbsp;</td>
             <td>
                 &nbsp;</td>
             

         </tr> 
          
        <tr>
            <td class="auto-style9"  >
                &nbsp;&nbsp; Fecha Creación:</td>
            <td class="auto-style10" align="left" >
                <asp:TextBox ID="txtFechaCreacion" runat="server" BackColor="#FFFFCC" Font-Bold="True" ForeColor="Black" MaxLength="10" required="" style="text-align: center" Width="30%"></asp:TextBox>
                <asp:ImageButton ID="imgBtoFechaCreacion" runat="server" CausesValidation="False" Height="16px" ImageUrl="~/Imagenes/calendario.gif" OnClick="imgBtoFechaCreacion_Click" Width="7%" formnovalidate/>
                <asp:Calendar ID="CalenFechCreacion" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" OnSelectionChanged="CalenFechCreacion_SelectionChanged" Width="200px" VisibleDate="2016-06-17">
                    <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                    <NextPrevStyle VerticalAlign="Bottom" />
                    <OtherMonthDayStyle ForeColor="#808080" />
                    <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                    <SelectorStyle BackColor="#CCCCCC" />
                    <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                    <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <WeekendDayStyle BackColor="#FFFFCC" />
                </asp:Calendar>
           </td>
             <td class="auto-style13"  >
                &nbsp;&nbsp;
                Estado:
            </td>
           <td  >
                <asp:CheckBox ID="CheckEstado" runat="server" AutoPostBack="True" OnCheckedChanged="CheckEstado_CheckedChanged" Checked="True" />
            </td>
        </tr>

      
        <tr>
            <td ></td>            <td class="auto-style16">
                 
            &nbsp;</td>
            <td class="auto-style17"></td>
            <td class="auto-style15"></td>

        </tr>
             
    <tr>
<td class="auto-style27">

</td>
        <td class="auto-style30">

          
</td>
        <td align="center" class="auto-style21">
            <STRONG>
                                                    <asp:Button ID="btoAgregarContratista" runat="server" CssClass="botonnew" Text="Agregar Contratista" Width="97%" Height="23px" OnClick="btoAgregarContratista_Click" />
                                                </strong></td>
        <td align="right" class="auto-style14">
            <STRONG>
                                                    <asp:Button ID="btoVolver" runat="server" CssClass="botonnew" Text="Volver" Width="90%" Height="23px" formnovalidate CausesValidation="False" OnClick="btoVolver_Click"  />
                                                </strong>&nbsp;

</td>

</tr>
         <tr><td class="auto-style25"><STRONG>
                                                    <asp:Label ID="lb_id_usuario" Visible="false" runat="server"></asp:Label>
                                                    <asp:Label ID="LOG_ID_USUARIO" Visible="false" runat="server"></asp:Label></td>
             <td class="auto-style29">
                 &nbsp;</td><td class="auto-style31">&nbsp;</td><td></td></tr>
         <tr><td class="auto-style25"></td><td class="auto-style29">
                 <STRONG>
                                                    <asp:Label ID="lb_perfil_usuario" Visible="false" runat="server"></asp:Label>
                                                    <asp:Label ID="lb_rut_empresa" Visible="false" runat="server"></asp:Label>
                                                    </td><td class="auto-style31">
                                        <asp:Button ID="btnok_agregar" runat="server" CssClass="botonnew" Text="Aceptar" Width="120px" CausesValidation="False" OnClick="btnok_agregar_Click" Visible="False" />
                                        </td><td></td></tr>
    </table>
</asp:Content>
