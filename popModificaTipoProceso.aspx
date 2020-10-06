<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popModificaTipoProceso.aspx.cs" Inherits="popModificaTipoProceso" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

   
    <link href="estilos/texto.css" rel="stylesheet" />
    <link href="estilos/tabla.css" rel="stylesheet" />
    <link href="estilos/grid.css" rel="stylesheet" />
    <link href="estilos/webpart.css" rel="stylesheet" />
    <link href="estilos/calendario.css" rel="stylesheet" />
    <link href="estilos/controls.css" rel="stylesheet" />

    <style type="text/css">
        .auto-style1 {
            width: 111px;
        }
        .auto-style2 {
            width: 179px;
        }
        .auto-style3 {
            width: 144px;
        }
    </style>
     <script language="javascript">
         function MODIFICA_CORRECTO(numero) {
             alert('SE HA MODIFICADO CORRECTAMENTE');
             window.opener.location = window.opener.location;
             self.close();
         }
         function ERROR(numero) {
             alert('ERROR AL INGRESAR');
         }
       
      </script> 

</head>
<body>
    <form id="form1" runat="server">
    <div>
            <table runat="server" id="tablaCausaCambio" style="border: 1px solid #808080; font-family: Arial; font-size: medium; font-weight: bold; width: 497px; background-color: #CCCCCC;" align="center" >
     <tr>
             <td class="auto-style1" >
                 </td>
                 <td class="auto-style2"></td><td class="auto-style3"></td><td class="auto-style11"></td>
         </tr>
     <tr > 
         <td class="auto-style1"></td>
            <td  colspan="1" style="font-size: medium; font-weight: bold; font-family: Arial, Helvetica, sans-serif; text-decoration: underline; color: #000000; " class="auto-style2"  >Modifica Tipo Proceso</td>
        
         <td class="auto-style3"> <span id="txtAscii" style="font-size:large"
                <asp:Label ID="lbAsci" runat="server" font-bold="False" style="text-align: left; margin-top: 6px; font-size: medium;" height="30px" ></asp:Label></span> 
                 </td>
        </tr>
        <tr>
           
      <td class="auto-style1"  >
               
                

            </td>
           
           
        </tr>
    <tr>
            <td class="auto-style1" >
                
            </td>
        <td class="auto-style2"></td><td class="auto-style3"></td><td></td>
        </tr>  
         <tr>
            <td class="auto-style1"  >
                &nbsp;&nbsp;
                Tipo Proceso :</td>
        <td class="auto-style2">
            <asp:TextBox ID="txtDescripcionCausa" runat="server" Width="169%" MaxLength="50" required></asp:TextBox>
             </td>
        </tr> 
         <tr><td class="auto-style1"></td><td class="auto-style2">
             &nbsp;</td>

         </tr> 
    
             
    <tr>
<td class="auto-style1">

</td>
        <td class="auto-style2">

          
</td>
        <td align="left" class="auto-style3">
        
                                                    <asp:Button ID="btn_agregaCausaC" runat="server" CssClass="botonnew" Text="Modificar" Width="77%" Height="23px" OnClick="btn_agregaCausaC_Click"  />
                                              </td>
 


    </tr>
         <tr><td class="auto-style1">
                                                    <asp:Label ID="lb_id_usuario" runat="server"></asp:Label>
                                                    <asp:Label ID="LOG_ID_USUARIO" runat="server"></asp:Label></td>
             <td class="auto-style2">
                 <asp:Label ID="TXT_id_tipo_proceso" Visible="false" runat="server"></asp:Label></td></tr>
         <tr><td class="auto-style1"></td><td class="auto-style2">
               
                                                    <asp:Label ID="lb_perfil_usuario" runat="server"></asp:Label>
                                                    <asp:Label ID="lb_rut_empresa" runat="server"></asp:Label>
                                                    </td><td class="auto-style3">
                                        &nbsp;</td><td></td></tr>
    </table>
        
    
    </div>
    </form>
</body>
</html>