<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="ModificarContratista.aspx.cs" Inherits="ModificarContratista" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
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
    <table runat="server" id="tablaEditaContratista" style="border: 1px solid #808080; font-family: Arial; font-size: medium; font-weight: bold; width: 947px; background-color: #CCCCCC;" align="center" >
     <tr>
             <td style="width: 205px" >
                 <asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_session_user0" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label>
                 </td>
                 <td style="width: 256px" ></td><td style="width: 228px"  ></td><td >&nbsp;</td>
         </tr>
     <tr >
            <td  colspan="1" style="font-size: medium; font-weight: bold; font-family: Arial, Helvetica, sans-serif; text-decoration: underline; color: #000000;" class="auto-style5"  >&nbsp;Editar Contratista</td>
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
            <td style="width: 205px"  >
                
            </td>
        <td style="width: 256px" ></td><td style="width: 228px"  ></td><td></td>
        </tr>  
         <tr>
            <td  >
                &nbsp;&nbsp;
                Nombre :</td>
        <td style="width: 256px" >
            <asp:TextBox ID="txtNombreContratistaE" runat="server"  MaxLength="30" required></asp:TextBox>
             </td><td align="center" class="auto-style31" style="width: 228px" >Rut:</td><td>
            <asp:TextBox ID="txtRutE" runat="server" MaxLength="50" required style="margin-left: 0px"></asp:TextBox>
             -<asp:TextBox ID="txt_dvE" runat="server"  MaxLength="50" required Width="25px"></asp:TextBox>
             </td>
        </tr> 
         <tr><td  ></td><td style="width: 256px" ></td><td align="center" style="width: 228px" >&nbsp;&nbsp;&nbsp;</td>
             <td>
                 &nbsp;</td>
             

         </tr> 
         <tr><td  >&nbsp;&nbsp;&nbsp;Código Contratista:</td><td style="width: 256px" >
            <asp:TextBox ID="txtCodigoContratistaE" runat="server"  MaxLength="10" required></asp:TextBox>
             </td><td align="center" style="width: 228px" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Empresa:</td>
             <td>
                <asp:DropDownList ID="combo_empresasE" runat="server" style="text-align: center" width="73%" >
                </asp:DropDownList>
             </td>
             

         </tr> 
           <tr><td  ></td><td style="width: 256px" ></td><td align="left" style="width: 228px" >&nbsp;&nbsp;&nbsp;</td>
             <td>
                 &nbsp;</td>
             

         </tr> 
          
        <tr>
            <td  >
                &nbsp;&nbsp; Fecha Creación:</td>
            <td  align="left" style="width: 256px" >
                <asp:TextBox ID="txtFechaCreacionE" runat="server" BackColor="#FFFFCC" Font-Bold="True" ForeColor="Black" MaxLength="10" required="" style="text-align: center"></asp:TextBox>
                <asp:ImageButton ID="imgBtoFechaCreacion" runat="server" CausesValidation="False" Height="16px" ImageUrl="~/Imagenes/calendario.gif" OnClick="imgBtoFechaCreacion_Click"  formnovalidate/>
                <asp:Calendar ID="CalenFechCreacion" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black"  OnSelectionChanged="CalenFechCreacion_SelectionChanged" Width="200px" VisibleDate="2016-06-17">
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
             <td align="center" style="width: 228px"   >
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                Estado:
            </td>
           <td  >
                <asp:CheckBox ID="CheckEstadoE" runat="server" AutoPostBack="True" OnCheckedChanged="CheckEstado_CheckedChanged" Checked="True" />
            </td>
        </tr>

      
        <tr>
            <td  ></td>            <td style="width: 256px" >
                 
            &nbsp;</td>
            <td style="width: 228px"  ></td>
            <td></td>

        </tr>
             
    <tr>
<td  >

</td>
        <td style="width: 256px" >

          
</td>
        <td  align="right"  >
            <STRONG>
             <asp:Button ID="btoEditarContratista" runat="server"  CssClass="botonnew" Text="Editar Contratista"  Height="23px" OnClick="btoEditarContratista_Click"  />
                                                </strong></td>
        <td align="left" class="auto-style14">
            <STRONG>
                                                    <asp:Button ID="btoVolver" runat="server" CssClass="botonnew" Text="Volver" width="58%" Height="23px" formnovalidate CausesValidation="False" OnClick="btoVolver_Click"  />
                                                </strong>&nbsp;

</td>


    </tr>
         <tr><td style="width: 205px" ><STRONG>
                                                    <asp:Label ID="lb_id_usuario" runat="server" Visible="False"></asp:Label>
                                                    <asp:Label ID="LOG_ID_USUARIO" runat="server" Visible="False"></asp:Label></td>
             <td style="width: 256px" >
                                                    <asp:Label ID="LB_RUT_EMPRESA0" runat="server" Visible="False"></asp:Label></td><td style="width: 228px" >&nbsp;</td><td></td></tr>
         <tr><td style="width: 205px" ></td><td style="width: 256px" >
                 <STRONG>
                                                    <asp:Label ID="lb_perfil_usuario" runat="server" Visible="False"></asp:Label>
                                                    <asp:Label ID="lb_rut_empresa" runat="server" Visible="False"></asp:Label>
                                                    </td><td class="auto-style31" style="width: 228px">
                                        <asp:Button ID="btnok_agregar" runat="server" CssClass="botonnew" Text="Aceptar" Width="120px" CausesValidation="False" OnClick="btnok_agregar_Click" Visible="False" />
                                        </td><td></td></tr>
    </table>
</asp:Content>

