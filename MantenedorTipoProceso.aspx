<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/menu.master" CodeFile="MantenedorTipoProceso.aspx.cs" Inherits="MantenedorTipoProceso" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server" >
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
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
        .auto-style11
        {
            height: 37px;
        }
        .auto-style14
        {
            height: 36px;
            width: 314px;
        }
        .auto-style20
        {
            height: 19px;
            width: 314px;
        }
        .auto-style27 {
            height: 37px;
            width: 177px;
        }
        .auto-style28 {
            width: 177px;
        }
        .auto-style29 {
            height: 36px;
            width: 177px;
        }
        .auto-style30 {
            height: 37px;
            width: 314px;
        }
        .auto-style31 {
            width: 314px;
        }
        .auto-style32 {
            height: 37px;
            width: 342px;
        }
        .auto-style33 {
            width: 342px;
        }
        .auto-style34 {
            height: 36px;
            width: 342px;
        }
        .auto-style35 {
            width: 19px;
        }
        .ColumnaOculta {display:none;}
    </style>
     <script type="text/javascript">

         function MensajeCorrecto(numero) {
             alert('Tipo Proceso ingresado correctamente!');
         }
         
         function alerta(numero) {
             alert('ERROR');
         }
         function Error_mod(numero) {
             alert('NO SE PUEDE MODIFICAR');
         }
         function alertaTest(numero) {
             alert('pasaste');
         }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <script type="text/javascript">
         
         $(function () {
             $("[id*=GrillaCausaCambio] td").hover(function () {
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
      <table id="tablaMant" runat="server" style="WIDTH: 758px; HEIGHT: 152px; background-color: #FFFFFF;" cellSpacing="0" cellPadding="0" width="758"
				align="center" border="0">
          <tr>
              <td> </td>
              <td> 
                 <asp:Label ID="lb_session_user" runat="server" Font-Names="Arial" Font-Size="X-Small">
                 </asp:Label>
                 &nbsp;<asp:Label ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small">
                 </asp:Label> </td>
              <td class="auto-style35"></td>  </tr>
           <tr >
            <td align="center" colspan="4" style="font-size: medium; font-weight: bold; font-family: Arial, Helvetica, sans-serif; text-decoration: underline; color: #000000;" class="auto-style5"  >Mantenedor Tipo Proceso</td>
        </tr>
 <tr>    
            <td align="center">&nbsp;</td><td align="center">
                                 
                             </td>
     

 </tr>
          <tr> 
            <td align="center">    </td><td align="right">
             <asp:Label ID="lb_cantidad_registros" runat="server" Text="coincidencia(s) encontrada(s)" Width="153px"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <asp:Button ID="btnok_agregar0" runat="server" CausesValidation="False" CssClass="botonnew" Text="Nueva Tipo Proceso" Width="20%" Height="22px" OnClick="btnok_agregar0_Click"  />

      
                             </td>
     

 </tr>

      
                                                   
         <tr><td></td>
             
                             <td align="right" colspan="1">&nbsp;&nbsp;<asp:GridView ID="GrillaTipo_proceso" runat="server" AutoGenerateColumns="False" BorderWidth="1px" DataKeyField="id_tipo_proceso" CellPadding="1" CellSpacing="1" CssClass="GridActiveItem" Height="1px" Width="699px" BorderStyle="Ridge" Font-Bold="True" AllowPaging="True"  PageSize="20" EnableModelValidation="True" OnRowCommand="GrillaTipo_proceso_RowCommand"   >
                                     <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                 <HeaderStyle BackColor="CornflowerBlue" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="White" HorizontalAlign="Center" />
                                 <Columns>
                                     <asp:BoundField DataField="id_tipo_proceso" HeaderText="id_causacambio" ItemStyle-CssClass="ColumnaOculta" HeaderStyle-CssClass="ColumnaOculta">                                        
                         
                                     </asp:BoundField>
                                     <asp:BoundField DataField="DETALLE" HeaderText="DESCRIPCION">
                                       <HeaderStyle Font-Bold="True" Width="50%" ForeColor="White"/>
                                     </asp:BoundField> 
                                             <asp:ButtonField HeaderText="MODIFICAR"  CommandName="modificar"   Text="EDITAR"  />

                                 </Columns>
                                <PagerStyle BackColor="CornflowerBlue" ForeColor="White" HorizontalAlign="Center"  />
                        <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
                        <AlternatingRowStyle BackColor="White" />
                        
                                 </asp:GridView> &nbsp;</td> <td class="auto-style35"></td>
                         </tr>
         <tr>
                             <td align="center" colspan="2">&nbsp;</td>
                         </tr></table>
     
     <table runat="server" id="tablaCausaCambio" style="border: 1px solid #808080; font-family: Arial; font-size: medium; font-weight: bold; width: 497px; background-color: #CCCCCC;" align="center" >
     <tr>
             <td class="auto-style27">
                 </td>
                 <td class="auto-style30"></td><td class="auto-style32"></td><td class="auto-style11"></td>
         </tr>
     <tr > 
         <td></td>
            <td  colspan="1" style="font-size: medium; font-weight: bold; font-family: Arial, Helvetica, sans-serif; text-decoration: underline; color: #000000; " class="auto-style20"  >&nbsp;Agregar Tipo Proceso</td>
        
         <td class="auto-style33"> <span id="txtAscii" style="font-size:large"
                <asp:Label ID="lbAsci" runat="server" font-bold="False" style="text-align: left; margin-top: 6px; font-size: medium;" height="30px" ></asp:Label></span> 
                 </td>
        </tr>
        <tr>
           
      <td  >
               
                

            </td>
           
           
        </tr>
    <tr>
            <td class="auto-style28" >
                
            </td>
        <td class="auto-style31"></td><td class="auto-style33"></td><td></td>
        </tr>  
         <tr>
            <td class="auto-style28"  >
                &nbsp;&nbsp;
                Tipo Proceso :</td>
        <td class="auto-style31">
            <asp:TextBox ID="txtDescripcionCausa" runat="server" Width="94%" MaxLength="50" required></asp:TextBox>
             </td>
        </tr> 
         <tr><td class="auto-style28"></td><td class="auto-style31">
             &nbsp;</td>

         </tr> 
    
             
    <tr>
<td class="auto-style29">

</td>
        <td class="auto-style14">

          
</td>
        <td align="left" class="auto-style34">
        
                                                    <asp:Button ID="btn_agregaCausaC" runat="server" CssClass="botonnew" Text="Agregar" Width="77%" Height="23px" OnClick="btn_agregaCausaC_Click" />
                                              </td>
 


    </tr>
         <tr><td class="auto-style28"><STRONG>
                                                    <asp:Label ID="lb_id_usuario" runat="server"></asp:Label>
                                                    <asp:Label ID="LOG_ID_USUARIO" runat="server"></asp:Label></td>
             <td class="auto-style31">
                 &nbsp;</td><td class="auto-style33">  <STRONG>
                                                    <asp:Button ID="btoVolver" runat="server" CssClass="botonnew" Text="Volver" Width="77%" Height="23px" formnovalidate OnClick="Btn_Cancelar_Click" CausesValidation="False"  />
                                                </strong>&nbsp;</td></tr>
         <tr><td class="auto-style28"></td><td class="auto-style31">
                 <STRONG>
                                                    <asp:Label ID="lb_perfil_usuario" runat="server"></asp:Label>
                                                    <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label>
                                                    </td><td class="auto-style33">
                                        &nbsp;</td><td></td></tr>
    </table>
                      
</asp:Content>

