<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="ModificarEmpresa.aspx.cs" Inherits="ModificarEmpresa" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <table runat="server" id="tablaEmpresas" style="border: 1px solid #808080; font-family: Arial; font-size: medium; font-weight: bold; width: 947px; background-color: #CCCCCC;" align="center" >
     <tr>
             <td class="auto-style11" style="width: 161px; height: 19px;">
                 </td>
                 <td class="auto-style11" style="width: 275px; height: 19px;"></td><td class="auto-style11" style="width: 207px; height: 19px;"></td><td class="auto-style11" style="height: 19px"></td>
         </tr>
     <tr >
            <td  colspan="1" style="font-size: medium; font-weight: bold; font-family: Arial, Helvetica, sans-serif; text-decoration: underline; color: #000000; width: 161px;" class="auto-style5"  >&nbsp;Modificar Empresa</td>
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
                
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True" Visible="False">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label>
                
            </td>
        <td style="width: 275px"></td><td style="width: 207px"></td><td></td>
        </tr>  
         <tr>
            <td style="width: 161px"  >
                &nbsp;&nbsp; Nombre-Empresa:</td>
        <td style="width: 275px">
            <asp:TextBox ID="txtNombreEmpresaE" runat="server" Width="94%" MaxLength="50" required></asp:TextBox>
             </td><td style="width: 207px">&nbsp;&nbsp; E-Mail:</td><td>
            <asp:TextBox ID="txtEmailEmpresaE" runat="server" Width="94%" MaxLength="50" required></asp:TextBox>
             </td>
        </tr> 
         <tr><td style="width: 161px"></td><td style="width: 275px">
             &nbsp;</td>

         </tr> 
          
        <tr>
            <td class="auto-style9" style="width: 161px"  >
                &nbsp;&nbsp; Rut-Empresa:</td>
            <td class="auto-style10" style="width: 275px" >
            <asp:TextBox ID="txtRutEmpresaE" runat="server" Width="94%" MaxLength="50" required></asp:TextBox>
           </td>
             <td class="auto-style13" style="width: 207px"  >
                &nbsp;&nbsp;
                 Cod-Contratista:
            </td>
           <td class="auto-style12" >
                <asp:DropDownList ID="comboCodContratistaE" runat="server" width="95%">
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

                                                    <asp:Label ID="LB_RUT_EMPRESA0" runat="server"></asp:Label>

</td>
        <td class="auto-style14" style="width: 275px">

          
</td>
        <td align="center" class="auto-style14" style="width: 207px">
            <STRONG>
                                                    <asp:Button ID="btoEditaEmpresa" runat="server" CssClass="botonnew" Text="Editar Empresa" Width="87%" Height="23px" OnClick="btoEditaEmpresa_Click" />
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

