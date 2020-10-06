<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="ModificaEstatusMedidorRetirado.aspx.cs" Inherits="ModificaEstatusMedidorRetirado" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <table runat="server" id="tablaEstatusMedidrorR" style="border: 1px solid #808080; font-family: Arial; font-size: medium; font-weight: bold; width: 947px; background-color: #CCCCCC;" align="center" >
     <tr>
             <td class="auto-style19" style="width: 273px">
                 </td>
                 <td class="auto-style11" style="width: 241px"></td><td class="auto-style11" style="width: 207px"></td><td class="auto-style11"></td>
         </tr>
     <tr >
            <td  colspan="1" style="font-size: medium; font-weight: bold; font-family: Arial, Helvetica, sans-serif; text-decoration: underline; color: #000000; width: 273px;" class="auto-style20"  >&nbsp;Editar Estatus Medidor Retirado</td>
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
                
                 <asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label>&nbsp;- <asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label>
                
            </td>
        <td style="width: 241px"></td><td style="width: 207px"></td><td></td>
        </tr>  
         <tr>
            <td class="auto-style21" style="width: 273px"  >
                &nbsp;&nbsp;
                Descripción :</td>
        <td style="width: 241px">
            <asp:TextBox ID="txtDescripcionMedidorE" runat="server" Width="94%" MaxLength="50" required></asp:TextBox>
             </td><td style="width: 207px">&nbsp;&nbsp; Empresa:</td><td>
                <asp:DropDownList ID="combo_empresasE" runat="server" style="text-align: center" Width="80%">
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
            <asp:TextBox ID="txtCodigoMedidorE" runat="server" Width="94%" MaxLength="50" required></asp:TextBox>
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
                                                    <asp:Button ID="btn_editaEstatusMedE" runat="server" CssClass="botonnew" Text="Edita Estatus Medidor Retirado" Width="98%" Height="23px" OnClick="btn_editaEstatusMedE_Click" />
                                                </strong></td>
        <td align="right" class="auto-style14">
            <STRONG>
                                                    <asp:Button ID="btoVolver" runat="server" CssClass="botonnew" Text="Volver" Width="95%" Height="23px" formnovalidate OnClick="btoVolver_Click"  />
                                                </strong>&nbsp;

</td>


    </tr>
         <tr><td class="auto-style21" style="width: 273px; height: 19px;"><STRONG>
                                                    <asp:Label ID="lb_id_usuario" runat="server"></asp:Label>
                                                    <asp:Label ID="LOG_ID_USUARIO" runat="server"></asp:Label></td>
             <td style="width: 241px; height: 19px;">
                 </td><td style="width: 207px; height: 19px;"></td><td style="height: 19px"></td></tr>
         <tr><td class="auto-style21" style="width: 273px">
                                                    <asp:Label ID="LB_RUT_EMPRESA0" runat="server"></asp:Label></td><td style="width: 241px">
                 <STRONG>
                                                    <asp:Label ID="lb_perfil_usuario" runat="server"></asp:Label>
                                                    <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label>
                                                    </td><td style="width: 207px">
                                        <asp:Button ID="btnok_agregar" runat="server" CssClass="botonnew" Text="Aceptar" Width="120px" CausesValidation="False" Visible="False" />
                                        </td><td></td></tr>
    </table>
    
</asp:Content>

