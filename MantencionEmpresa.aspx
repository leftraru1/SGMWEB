<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="MantencionEmpresa.aspx.cs" Inherits="MantencionEmpresa" %>

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
        }
        .auto-style10
        {
            height: 23px;
        }
        .auto-style11
        {
            height: 37px;
        }
        .auto-style12
        {
            height: 24px;
        }
        .auto-style13
        {
            height: 26px;
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
        }
        .auto-style17
        {
            height: 33px;
        }
        .auto-style18
        {
            height: 28px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
     <script type="text/javascript">
         $(function () {
             $("[id*=GrillaEmpresas] td").hover(function () {
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
            setTimeout("parpadeo()", 1000); //500 = medio segundo 
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
            <td align="center" colspan="4" style="font-size: medium; font-weight: bold; font-family: Arial, Helvetica, sans-serif; text-decoration: underline; color: #000000;" class="auto-style5"  >Mantenedor de Empresas</td>
        </tr>
 <tr>    
            <td align="center">    &nbsp;</td><td align="center">
                                 <asp:Label ID="lb_cantidad_registros" runat="server" Text="coincidencia(s) encontrada(s)" Width="153px"></asp:Label>
      
                             </td>
     

 </tr>
          <tr>    
            <td align="center">    &nbsp;</td><td align="right">
                                                        <asp:Button ID="btnok_agregar0" runat="server" CausesValidation="False" CssClass="botonnew" Text="Nueva Empresa" Width="20%" Height="22px" OnClick="btnok_agregar0_Click"  />

      
                             </td>
     

 </tr>

      
                                                   
         <tr><td></td>
             
                             <td align="right" colspan="1">&nbsp;&nbsp;<asp:DataGrid ID="GrillaEmpresas" runat="server" AutoGenerateColumns="False" BorderWidth="1px" CellPadding="1" CellSpacing="1" CssClass="GridActiveItem" Height="1px" Width="699px" BorderStyle="Ridge" Font-Bold="True" AllowPaging="True" OnPageIndexChanged="GrillaCausaCambio_PageIndexChanged" PageSize="20" OnEditCommand="GrillaCausaCambio_EditCommand">
                                     <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                 <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="White" HorizontalAlign="Center" />
                                 <Columns>
                                     <asp:BoundColumn DataField="id_empresa" HeaderText="ID_EMPRESA" Visible="False"></asp:BoundColumn>
                                     <asp:BoundColumn DataField="rut_empresa" HeaderText="RUT EMPRESA">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                     </asp:BoundColumn>
                                     <asp:BoundColumn DataField="nombre" HeaderText="NOMBRE">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                     </asp:BoundColumn>
                                     <asp:BoundColumn DataField="mail" HeaderText="E-MAIL">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                     </asp:BoundColumn>
                                     <asp:BoundColumn DataField="cod_contratista" HeaderText="COD-CONTRATISTA">
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
     
     <table runat="server" id="tablaEmpresas" style="border: 1px solid #808080; font-family: Arial; font-size: medium; font-weight: bold; width: 947px; background-color: #CCCCCC;" align="center" >
     <tr>
             <td class="auto-style11" style="width: 161px; height: 19px;">
                 </td>
                 <td class="auto-style11" style="width: 275px; height: 19px;"></td><td class="auto-style11" style="width: 207px; height: 19px;"></td><td class="auto-style11" style="height: 19px"></td>
         </tr>
     <tr >
            <td  colspan="1" style="font-size: medium; font-weight: bold; font-family: Arial, Helvetica, sans-serif; text-decoration: underline; color: #000000; width: 161px;" class="auto-style5"  >&nbsp;Agregar Empresa</td>
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
            <td style="width: 161px" >
                
            </td>
        <td style="width: 275px"></td><td style="width: 207px"></td><td></td>
        </tr>  
         <tr>
            <td style="width: 161px"  >
                &nbsp;&nbsp; Nombre-Empresa:</td>
        <td style="width: 275px">
            <asp:TextBox ID="txtNombreEmpresa" runat="server" Width="94%" MaxLength="50" required></asp:TextBox>
             </td><td style="width: 207px">&nbsp;&nbsp; E-Mail:</td><td>
            <asp:TextBox ID="txtEmailEmpresa" runat="server" Width="94%" MaxLength="50" required></asp:TextBox>
             </td>
        </tr> 
         <tr><td style="width: 161px"></td><td style="width: 275px">
             &nbsp;</td>

         </tr> 
          
        <tr>
            <td class="auto-style9" style="width: 161px"  >
                &nbsp;&nbsp; Rut-Empresa:</td>
            <td class="auto-style10" style="width: 275px" >
            <asp:TextBox ID="txtRutEmpresa" runat="server" Width="94%" MaxLength="50" required></asp:TextBox>
           </td>
             <td class="auto-style13" style="width: 207px"  >
                &nbsp;&nbsp;
                 Cod-Contratista:
            </td>
           <td class="auto-style12" >
                <asp:DropDownList ID="comboCodContratista" runat="server" width="95%">
                </asp:DropDownList>
            </td>
        </tr>

      
        <tr>
            <td class="auto-style15" style="width: 161px"></td>            <td class="auto-style16" style="width: 275px">
                 
            &nbsp;</td>
            <td class="auto-style17" style="width: 207px"></td>
            <td class="auto-style15"></td>

        </tr>
             
    <tr>
<td class="auto-style14" style="width: 161px">

</td>
        <td class="auto-style14" style="width: 275px">

          
</td>
        <td align="center" class="auto-style14" style="width: 207px">
            <STRONG>
                                                    <asp:Button ID="btoAgregaEmpresa" runat="server" CssClass="botonnew" Text="Agregar Empresa" Width="87%" Height="23px" OnClick="btoAgregaEmpresa_Click" />
                                                </strong></td>
        <td align="left" class="auto-style14">
            <STRONG>
                                                    <asp:Button ID="btoVolver" runat="server" CssClass="botonnew" Text="Volver" Width="70%" Height="23px" formnovalidate CausesValidation="False" OnClick="btoVolver_Click"  />
                                                </strong>&nbsp;

</td>


    </tr>
         <tr><td style="width: 161px"><STRONG>
                                                    <asp:Label ID="lb_id_usuario" runat="server"></asp:Label>
                                                    <asp:Label ID="LOG_ID_USUARIO" runat="server"></asp:Label></td>
             <td style="width: 275px">
                 &nbsp;</td><td style="width: 207px">&nbsp;</td><td></td></tr>
         <tr><td style="width: 161px"></td><td style="width: 275px">
                 <STRONG>
                                                    <asp:Label ID="lb_perfil_usuario" runat="server"></asp:Label>
                                                    <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label>
                                                    </td><td style="width: 207px">
                                        <asp:Button ID="btnok_agregar" runat="server" CssClass="botonnew" Text="Aceptar" Width="120px" CausesValidation="False" Visible="False" />
                                        </td><td></td></tr>
    </table>

  
</asp:Content>

