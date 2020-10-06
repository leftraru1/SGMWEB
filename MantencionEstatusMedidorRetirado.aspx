<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="MantencionEstatusMedidorRetirado.aspx.cs" Inherits="MantencionEstatusMedidorRetirado" %>

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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <script type="text/javascript">
         $(function () {
             $("[id*=GrillaEstatusMedidorR] td").hover(function () {
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
            setTimeout("parpadeo()", 900); //500 = medio segundo 
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
            <td align="center" colspan="4" style="font-size: medium; font-weight: bold; font-family: Arial, Helvetica, sans-serif; text-decoration: underline; color: #000000;" class="auto-style5"  >Mantenedor de Estatus Medidor Retirado</td>
        </tr>
 <tr>    
            <td align="center">    &nbsp;</td><td align="center">
                                 <asp:Label ID="lb_cantidad_registros" runat="server" Text="coincidencia(s) encontrada(s)" Width="153px"></asp:Label>
      
                             </td>
     

 </tr>
          <tr>    
            <td align="center">    &nbsp;</td><td align="right">
                                                        <asp:Button ID="btnok_agregar0" runat="server" CausesValidation="False" CssClass="botonnew" Text="Nuevo Estatus Medidor" Width="20%" Height="22px" OnClick="btnok_agregar0_Click" />

      
                             </td>
     

 </tr>

      
                                                   
         <tr><td></td>
             
                             <td align="right" colspan="1">&nbsp;&nbsp;<asp:DataGrid ID="GrillaEstatusMedidorR" runat="server" AutoGenerateColumns="False" BorderWidth="1px" CellPadding="1" CellSpacing="1" CssClass="GridActiveItem" Height="1px" Width="699px" BorderStyle="Ridge" Font-Bold="True" AllowPaging="True" PageSize="20" OnEditCommand="GrillaEstatusMedidorR_EditCommand" >
                                     <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                 <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="White" HorizontalAlign="Center" />
                                 <Columns>
                                     <asp:BoundColumn DataField="id_estatus_mr" HeaderText="id_medidor_retirado" Visible="False">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                     </asp:BoundColumn>
                                     <asp:BoundColumn DataField="cod_estatus_mr" HeaderText="CODIGO MEDIDOR">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                     </asp:BoundColumn>
                                     <asp:BoundColumn DataField="descripcion" HeaderText="DESCRIPCION">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                     </asp:BoundColumn>
                                     <asp:BoundColumn DataField="rut_empresa" HeaderText="EMPRESA">
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
                                <PagerStyle BackColor="CornflowerBlue" ForeColor="White" HorizontalAlign="Center" Mode="NumericPages" PageButtonCount="5" />
                        <ItemStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
                        <AlternatingItemStyle BackColor="White" />
                        <SelectedItemStyle BackColor="#66FF99" Font-Bold="True" ForeColor="#333333" BorderStyle="Ridge" BorderColor="#66FF33" />
                                 </asp:DataGrid> &nbsp;</td> <td></td>
                         </tr>
         <tr>
                             <td align="center" colspan="2">&nbsp;</td>
                         </tr></table>
     
     <table runat="server" id="tablaEstatusMedidrorR" style="border: 1px solid #808080; font-family: Arial; font-size: medium; font-weight: bold; width: 947px; background-color: #CCCCCC;" align="center" >
     <tr>
             <td class="auto-style19" style="width: 273px">
                 </td>
                 <td class="auto-style11" style="width: 241px"></td><td class="auto-style11" style="width: 207px"></td><td class="auto-style11"></td>
         </tr>
     <tr >
            <td  colspan="1" style="font-size: medium; font-weight: bold; font-family: Arial, Helvetica, sans-serif; text-decoration: underline; color: #000000; width: 273px;" class="auto-style20"  >&nbsp;Agregar Estatus Medidor Retirado</td>
         <td style="width: 241px"></td>
         <td style="width: 207px"> <span id="txtAscii" style="font-size:large"
                <asp:Label ID="lbAsci" runat="server" font-bold="False" style="text-align: left; margin-top: 6px; font-size: medium;" height="30px" ></asp:Label></span> 
                 </td>
        </tr>
        <tr>
           
      <td colspan="4"  >
               
               <asp:label id="lbInformacion0" runat="server" font-bold="False" width="100%" style="text-align: center; margin-top: 6px; font-size: medium;" height="30px"></asp:label> 

            </td>
           
           
        </tr>
    <tr>
            <td class="auto-style21" style="width: 273px" >
                
            </td>
        <td style="width: 241px"></td><td style="width: 207px"></td><td></td>
        </tr>  
         <tr>
            <td class="auto-style21" style="width: 273px"  >
                &nbsp;&nbsp;
                Descripción :</td>
        <td style="width: 241px">
            <asp:TextBox ID="txtDescripcionMedidor" runat="server" Width="94%" MaxLength="50" required></asp:TextBox>
             </td><td style="width: 207px">&nbsp;&nbsp; Empresa:</td><td>
                <asp:DropDownList ID="combo_empresas" runat="server" style="text-align: center" Width="80%">
                </asp:DropDownList>
             </td>
        </tr> 
         <tr><td class="auto-style21" style="width: 273px"></td><td style="width: 241px">
             &nbsp;</td>

         </tr> 
          
        <tr>
            <td class="auto-style9" style="width: 273px"  >
                &nbsp;&nbsp; Código Medidor:</td>
            <td class="auto-style10" style="width: 241px" >
            <asp:TextBox ID="txtCodigoMedidor" runat="server" Width="94%" MaxLength="50" required></asp:TextBox>
           </td>
             <td class="auto-style13" style="width: 207px"  >
                 &nbsp;&nbsp;
            </td>
           <td class="auto-style12" >
                &nbsp;</td>
        </tr>

      
        <tr>
            <td class="auto-style22" style="width: 273px"></td>            <td class="auto-style16" style="width: 241px">
                 
            &nbsp;</td>
            <td class="auto-style17" style="width: 207px"></td>
            <td class="auto-style15"></td>

        </tr>
             
    <tr>
<td class="auto-style23" style="width: 273px">

</td>
        <td class="auto-style14" style="width: 241px">

          
</td>
        <td align="center" class="auto-style14" style="width: 207px">
            <STRONG>
                                                    <asp:Button ID="btn_agregaEstatusMedR" runat="server" CssClass="botonnew" Text="Agregar Estatus Medidor Retirado" Width="98%" Height="23px" OnClick="btn_agregaEstatusLlR_Click" />
                                                </strong></td>
        <td align="right" class="auto-style14">
            <STRONG>
                                                    <asp:Button ID="btoVolver" runat="server" CssClass="botonnew" Text="Volver" Width="95%" Height="23px" formnovalidate OnClick="btoVolver_Click"  />
                                                </strong>&nbsp;

</td>


    </tr>
         <tr><td class="auto-style21" style="width: 273px"><STRONG>
                                                    <asp:Label ID="lb_id_usuario" runat="server"></asp:Label>
                                                    <asp:Label ID="LOG_ID_USUARIO" runat="server"></asp:Label></td>
             <td style="width: 241px">
                 &nbsp;</td><td style="width: 207px">&nbsp;</td><td></td></tr>
         <tr><td class="auto-style21" style="width: 273px"></td><td style="width: 241px">
                 <STRONG>
                                                    <asp:Label ID="lb_perfil_usuario" runat="server"></asp:Label>
                                                    <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label>
                                                    </td><td style="width: 207px">
                                        <asp:Button ID="btnok_agregar" runat="server" CssClass="botonnew" Text="Aceptar" Width="120px" CausesValidation="False" Visible="False" />
                                        </td><td></td></tr>
    </table>

</asp:Content>

