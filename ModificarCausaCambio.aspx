<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="ModificarCausaCambio.aspx.cs" Inherits="ModificarCausaCambio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style5
        {
            height: 26px;
        }
        .auto-style6
        {
            width: 234px;
        }
        .auto-style7
        {
            width: 250px;
        }
        .auto-style8
        {
            width: 159px;
        }
        .auto-style9
        {
            height: 26px;
            width: 234px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
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
     <table runat="server" id="tablaCausaCambio" style="border: 1px solid #808080; font-family: Arial; font-size: medium; font-weight: bold; width: 947px; background-color: #CCCCCC;" align="center" >
     <tr>
             <td class="auto-style6">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label>
                 </td>
                 <td class="auto-style7"></td><td class="auto-style8"></td><td class="auto-style11"></td>
         </tr>
     </tr>
     <tr >
            <td  colspan="1" style="font-size: medium; font-weight: bold; font-family: Arial, Helvetica, sans-serif; text-decoration: underline; color: #000000; " class="auto-style9"  >&nbsp;Modificar Causa de Cambio</td>
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
            <td class="auto-style6" >
                
            </td>
            <td colspan="3" class="auto-style18" >
            </td>
           
           
        </tr>
    <tr>
            <td class="auto-style6" >
                
            </td>
        <td class="auto-style7"></td><td class="auto-style8"></td><td></td>
        </tr>  
         <tr>
            <td class="auto-style6" >
                &nbsp;&nbsp;&nbsp;&nbsp;
                Descripción :</td>
        <td class="auto-style7" >
            <asp:TextBox ID="txtDescripcionCausaE" runat="server" Width="94%" MaxLength="50" required></asp:TextBox>
             </td><td class="auto-style8" >&nbsp;&nbsp; Empresa:</td><td class="auto-style5">
                <asp:DropDownList ID="combo_empresasE" runat="server" style="text-align: center" Width="80%">
                </asp:DropDownList>
             </td>
        </tr> 
         <tr><td class="auto-style6"></td><td class="auto-style7">
             &nbsp;</td>

         </tr> 
          
        <tr>
            <td class="auto-style6"   >
                &nbsp;&nbsp;&nbsp; Código Causa:</td>
            <td class="auto-style7"  >
            <asp:TextBox ID="txtCodigoCausaE" runat="server" Width="94%" MaxLength="50" required></asp:TextBox>
           </td>
             <td class="auto-style8"   >
                &nbsp;&nbsp;
                Estado:
            </td>
           <td  >
                <asp:CheckBox ID="CheckEstadoE" runat="server" AutoPostBack="True" OnCheckedChanged="CheckEstado_CheckedChanged" Checked="True" />
            </td>
        </tr>

      
        <tr>
            <td class="auto-style6" ></td>            <td class="auto-style7" >
                 
            &nbsp;</td>
            <td class="auto-style8"></td>
            <td class="auto-style15"></td>

        </tr>
             
    <tr>
<td class="auto-style6">

</td>
        <td class="auto-style7">

          
</td>
        <td align="center" class="auto-style8">
            <STRONG>
                                                    <asp:Button ID="btnEditarCausaC" runat="server" CssClass="botonnew" Text="Editar Causa Cambio" Width="85%" Height="23px"  BorderStyle="Solid" OnClick="btnEditarCausaC_Click" />
                                                </strong></td>
        <td align="center" class="auto-style14">
            <STRONG>
                                                    <asp:Button ID="btoVolver" runat="server" CssClass="botonnew" align="center" Text="Volver" Width="55%" CausesValidation="False" formnovalidate Height="23px" BorderStyle="Solid" OnClick="btoVolver_Click"  />
                                                </strong>&nbsp;

</td>


    </tr>
         <tr><td class="auto-style6"><STRONG>
                                                    <asp:Label ID="lb_id_usuario" runat="server" Visible="False"></asp:Label>
                                                    <asp:Label ID="LOG_ID_USUARIO" runat="server"></asp:Label></td>
             <td class="auto-style7">
                                                    <asp:Label ID="LB_RUT_EMPRESA0" runat="server"></asp:Label></td><td class="auto-style8">&nbsp;</td><td></td></tr>
         <tr><td class="auto-style6"></td><td class="auto-style7">
                 <STRONG>
                                                    <asp:Label ID="lb_perfil_usuario" runat="server"></asp:Label>
                                                    <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label>
                                                    </td><td class="auto-style8">
                                        <asp:Button ID="btnok_agregar" runat="server" CssClass="botonnew" Text="Aceptar" Width="120px" CausesValidation="False"  Visible="False" />
                                        </td><td>&nbsp;</td></tr>
    </table>
</asp:Content>

