﻿<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="MantencionLocalidad.aspx.cs" Inherits="MantencionLocalidad"  EnableEventValidation="false" %>

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
            width: 207px;
        }
        .auto-style10
        {
            height: 23px;
            width: 262px;
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
            width: 226px;
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
            width: 262px;
        }
        .auto-style17
        {
            height: 33px;
            width: 226px;
        }
        .auto-style19
        {
            height: 37px;
            width: 207px;
        }
        .auto-style20
        {
            height: 19px;
            width: 207px;
        }
        .auto-style21
        {
            width: 207px;
        }
        .auto-style22
        {
            height: 35px;
            width: 207px;
        }
        .auto-style23
        {
            height: 36px;
            width: 207px;
        }
        .auto-style24
        {
            height: 37px;
            width: 262px;
        }
        .auto-style25
        {
            width: 262px;
        }
        .auto-style26
        {
            height: 36px;
            width: 262px;
        }
        .auto-style27
        {
            height: 37px;
            width: 226px;
        }
        .auto-style28
        {
            width: 226px;
        }
        .auto-style29
        {
            height: 36px;
            width: 226px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <script type="text/javascript">
          $(function () {
              $("[id*=GrillaLocalidades] td").hover(function () {
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
            <td align="center" colspan="4" style="font-size: medium; font-weight: bold; font-family: Arial, Helvetica, sans-serif; text-decoration: underline; color: #000000;" class="auto-style5"  >Mantenedor de Localidades</td>
        </tr>
 <tr>    
            <td align="center">    &nbsp;</td><td align="center">
                                 <asp:Label ID="lb_cantidad_registros" runat="server" Text="coincidencia(s) encontrada(s)" Width="153px"></asp:Label>
      
                             </td>
     

 </tr>
          <tr>    
            <td align="center">    &nbsp;</td><td align="right">
                                                        <asp:Button ID="btnok_agregar0" runat="server" CausesValidation="False" CssClass="botonnew" Text="Nueva Localidad" Width="20%" Height="22px" OnClick="btnok_agregar0_Click" />

      
                             </td>
     

 </tr>

      
                                                   
         <tr><td></td>
             
                             <td align="right" colspan="1">&nbsp;&nbsp;<asp:DataGrid ID="GrillaLocalidades" runat="server" AutoGenerateColumns="False" BorderWidth="1px" CellPadding="1" CellSpacing="1" CssClass="GridActiveItem" Height="1px" Width="699px" BorderStyle="Ridge" Font-Bold="True" AllowPaging="True" PageSize="30" OnEditCommand="GrillaLocalidades_EditCommand" OnPageIndexChanged="GrillaLocalidades_PageIndexChanged" >
                                     <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                 <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="White" HorizontalAlign="Center" />
                                 <Columns>
                                     <asp:BoundColumn DataField="id_localidad" HeaderText="id localidad">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                     </asp:BoundColumn>
                                     <asp:BoundColumn DataField="nombre" HeaderText="NOMBRE ">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                     </asp:BoundColumn>
                                     <asp:BoundColumn DataField="id_zona" HeaderText="ID ZONA">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                     </asp:BoundColumn>
                                     <asp:BoundColumn DataField="rut_empresa" HeaderText="EMPRESA">
                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                     </asp:BoundColumn>
                                     <asp:BoundColumn DataField="cod_localidad" HeaderText="CODIGO LOCALIDAD">
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
     
     <table runat="server" id="tablaLocalidades" style="border: 1px solid #808080; font-family: Arial; font-size: medium; font-weight: bold; width: 947px; background-color: #CCCCCC;" align="center" >
     <tr>
             <td class="auto-style19">
                 </td>
                 <td class="auto-style24"></td><td class="auto-style27"></td><td class="auto-style11"></td>
         </tr>
     <tr >
            <td  colspan="1" style="font-size: medium; font-weight: bold; font-family: Arial, Helvetica, sans-serif; text-decoration: underline; color: #000000; " class="auto-style20"  >&nbsp;Agregar Localidad</td>
         <td class="auto-style25"></td>
         <td class="auto-style28"> <span id="txtAscii" style="font-size:large"
                <asp:Label ID="lbAsci" runat="server" font-bold="False" style="text-align: left; margin-top: 6px; font-size: medium;" height="30px" ></asp:Label></span> 
                 </td>
        </tr>
        <tr>
           
      <td colspan="4"  >
               
               <asp:label id="lbInformacion0" runat="server" font-bold="False" width="100%" style="text-align: center; margin-top: 6px; font-size: medium;" height="30px"></asp:label> 

            </td>
           
           
        </tr>
    <tr>
            <td class="auto-style21" >
                
            </td>
        <td class="auto-style25"></td><td class="auto-style28"></td><td></td>
        </tr>  
         <tr>
            <td class="auto-style21"  >
                &nbsp;&nbsp; Nombre de localidad:</td>
        <td class="auto-style25">
            <asp:TextBox ID="txtNombreLocalidad" runat="server" Width="90%" MaxLength="50" required></asp:TextBox>
             <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtNombreLocalidad" ErrorMessage="*" ValidationExpression="^[A-Za-z a-ñ 1-9]*$"></asp:RegularExpressionValidator>
             </td><td class="auto-style28">&nbsp;&nbsp; Empresa:</td><td>
                <asp:DropDownList ID="combo_empresas" runat="server" style="text-align: center" Width="80%">
                </asp:DropDownList>
             </td>
        </tr> 
         <tr><td class="auto-style21"></td><td class="auto-style25">
             &nbsp;</td>

         </tr> 
          
        <tr>
            <td class="auto-style9"  >
                &nbsp;&nbsp;
                Código Localidad:</td>
            <td class="auto-style10" >
            <asp:TextBox ID="txtCodigoLocalidad" runat="server" Width="88%" MaxLength="50" required></asp:TextBox>
           </td>
             <td class="auto-style13"  >
                &nbsp;&nbsp;
                 Zona:
            </td>
           <td class="auto-style12" >
                <asp:DropDownList ID="combo_zona" runat="server" style="text-align: center" Width="80%">
                </asp:DropDownList>
            </td>
        </tr>

      
        <tr>
            <td class="auto-style22"></td>            <td class="auto-style16">
                 
            &nbsp;</td>
            <td class="auto-style17"></td>
            <td class="auto-style15"></td>

        </tr>
             
    <tr>
<td class="auto-style23">

</td>
        <td class="auto-style26">

          
</td>
        <td align="center" class="auto-style29">
            <STRONG>
                                                    <asp:Button ID="btoAgregarLocaclidad" runat="server" CssClass="botonnew" Text="Agregar Localidad" Width="90%" Height="23px" formnovalidate CausesValidation="False" OnClick="btoAgregarLocaclidad_Click"  />
                                                </strong></td>
        <td align="right" class="auto-style14">
            <STRONG>
                                                    <asp:Button ID="btoVolver" runat="server" CssClass="botonnew" Text="Volver" Width="90%" Height="23px" formnovalidate CausesValidation="False" OnClick="btoVolver_Click"  />
                                                </strong>&nbsp;

</td>


    </tr>
         <tr><td class="auto-style21"><STRONG>
                                                    <asp:Label ID="lb_id_usuario" runat="server" Visible="False"></asp:Label>
                                                    <asp:Label ID="LOG_ID_USUARIO" runat="server" Visible="False"></asp:Label></td>
             <td class="auto-style25">
                 &nbsp;</td><td class="auto-style28">&nbsp;</td><td></td></tr>
         <tr><td class="auto-style21"></td><td class="auto-style25">
                 <STRONG>
                                                    <asp:Label ID="lb_perfil_usuario" runat="server"></asp:Label>
                                                    <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label>
                                                    </td><td class="auto-style28">
                                        &nbsp;</td><td></td></tr>
    </table>

</asp:Content>

