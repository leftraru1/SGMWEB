<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="ModificarLocalidad.aspx.cs" Inherits="ModificarLocalidad" %>

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
    <table runat="server" id="tablaEditarLocalidad" style="border: 1px solid #808080; font-family: Arial; font-size: medium; font-weight: bold; width: 947px; background-color: #CCCCCC;" align="center" >
     <tr>
             <td class="auto-style19">
                 <asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label>
                 </td>
                 <td class="auto-style24"></td><td class="auto-style27"></td><td class="auto-style11"></td>
         </tr>
     <tr >
            <td  colspan="1" style="font-size: medium; font-weight: bold; font-family: Arial, Helvetica, sans-serif; text-decoration: underline; color: #000000; " class="auto-style20"  >&nbsp;Modificar Localidad</td>
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
            <asp:TextBox ID="txtNombreLocalidadE" runat="server" Width="90%" MaxLength="50" required></asp:TextBox>
             </td><td class="auto-style28">&nbsp;&nbsp; Empresa:</td><td>
                <asp:DropDownList ID="combo_empresasE" runat="server" style="text-align: center" Width="80%">
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
            <asp:TextBox ID="txtCodigoLocalidadE" runat="server" Width="88%" MaxLength="50" required></asp:TextBox>
           </td>
             <td class="auto-style13"  >
                &nbsp;&nbsp;
                 Zona:
            </td>
           <td class="auto-style12" >
                <asp:DropDownList ID="combo_zonaE" runat="server" style="text-align: center" Width="80%">
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
                                                    <asp:Button ID="btoEditarLocaclidad" runat="server" CssClass="botonnew" Text="Editar Localidad" Width="90%" Height="23px" formnovalidate CausesValidation="False" OnClick="btoEditarLocaclidad_Click"  />
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
         <tr><td class="auto-style21">
                                                    <asp:Label ID="LB_RUT_EMPRESA0" runat="server"></asp:Label></td><td class="auto-style25">
                 <STRONG>
                                                    <asp:Label ID="lb_perfil_usuario" runat="server"></asp:Label>
                                                    <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label>
                                                    </td><td class="auto-style28">
                                        &nbsp;</td><td></td></tr>
    </table>


</asp:Content>

