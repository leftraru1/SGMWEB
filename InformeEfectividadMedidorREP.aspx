<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/menu.master" CodeFile="InformeEfectividadMedidor.aspx.cs" Inherits="InformeEfectividadMedidor" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    &nbsp;

        <script type="text/javascript">

            function popInstalador(obj) {
                var url = 'popInstalador.aspx?textbox=' + obj;
                window.open(url, 'cal', 'width=820,height=320,left=200,top=50,resizable=0,scrollbars=yes');
            }

            function openCalendar(obj) {
                var url = 'calendario2.aspx?textbox=' + obj;
                window.open(url, 'cal', 'width=260,height=210,left=410 410,top=330,resizable=0,scrollbars=0');
            }

    </script>
        <style type="text/css">
   .ColumnaOculta {display:none;}
            .auto-style8
            {
                width: 30%;
            }
            .auto-style9
            {
                width: 1161px;
            }
            .auto-style11 {
                height: 217px;
                width: 1%;
            }
            .auto-style12 {
                width: 25%;
            }
            </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1 class="WebPartTitle">REPORTE EFECTIVIDAD MEDIDOR</h1>

        <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>

                <table >
                                  <tr>
                    <td class="auto-style12">Fecha De Generacion Desde:
                        </td>
                    <td style="width: 441px">
                       <asp:TextBox ID="txtDesde" runat="server" CssClass="TextBox3" Width="134px"></asp:TextBox>
                        <img src="Imagenes/calendario.gif" onclick="openCalendar('ctl00_ContentPlaceHolder1_txtDesde');"  id="IMG3" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Debe Ingresar Una Fecha" ControlToValidate="txtDesde"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtDesde" ErrorMessage="Error formato fecha." ValidationExpression="(0[1-9]|[12][0-9]|3[01])[- -.](0[1-9]|1[012])[- -.](19|20)\d\d"></asp:RegularExpressionValidator>
                    </td>                 
                    
                    
                   
                </tr>
                <tr>
                    <td class="auto-style12">Fecha De Generacion Hasta: </td>
                    <td style="width: 441px">
                     <asp:TextBox ID="txtHasta" runat="server" CssClass="TextBox3" Width="134px"></asp:TextBox>
                        <img src="Imagenes/calendario.gif" onclick="openCalendar('ctl00_ContentPlaceHolder1_txtHasta');"  id="IMG9" />
                       <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Debe Ingresar Una Fecha" ControlToValidate="txtHasta"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtHasta" ErrorMessage="Error formato fecha." ValidationExpression="(0[1-9]|[12][0-9]|3[01])[- -.](0[1-9]|1[012])[- -.](19|20)\d\d"></asp:RegularExpressionValidator>
                    </td>
                  
                  
                </tr>
                               <tr>
                    <td class="auto-style12">
                        Región:</td>
                    <td colspan="0" style="width: 441px">
                        <asp:DropDownList ID="ddRegion" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddRegion_SelectedIndexChanged" Width="300px">
                        </asp:DropDownList>
                    </td>
                   
                </tr>           
             
                     <tr>
                    <td class="auto-style12">
                        <asp:Label ID="Label1" runat="server" Text="Zona:"></asp:Label>
                    </td>
                    <td  colspan="0" style="width: 441px">
                        <asp:DropDownList ID="ddZona" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddZona_SelectedIndexChanged" Width="300px">
                        </asp:DropDownList>
                    </td>
                   
                </tr>
                     <tr>
                    <td class="auto-style12">
                        <asp:Label ID="Label4" runat="server" Text="Localidad:"></asp:Label>
                    </td>
                    <td colspan="0" style="width: 441px" >
                        <asp:DropDownList ID="ddLocalidad" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddLocalidad_SelectedIndexChanged" Width="300px">
                        </asp:DropDownList>
                    </td>
               
                </tr>
                    <tr>
                    <td class="auto-style12">
                        <asp:Label ID="Label2" runat="server" Text="Trabajador:"></asp:Label>
                    </td>
                    <td colspan="0" style="width: 441px" >
                        <asp:DropDownList ID="ddlTrabajador" runat="server"  CssClass="ComboBox"  Width="300px">
                        </asp:DropDownList>
                    </td>
                    
                </tr>
                 <tr>
                                                <td class="auto-style12">
                        <asp:Label ID="Label3" runat="server" Text="Contratista:"></asp:Label>
                    </td>
                   <td style="text-align: left; width: 441px;">
                  <asp:DropDownList ID="combo_contratista" runat="server" CssClass="ComboBox" Width="300px">
                    </asp:DropDownList></td>
                                                           
                                             
             </tr>
             <tr>
               <td class="auto-style12">
                        <asp:Label ID="Label5" runat="server" Text="Proceso:"></asp:Label>
                    </td>
                   <td style="text-align: left; width: 441px;">
                  <asp:DropDownList ID="ddlProceso" runat="server" CssClass="ComboBox" Width="300px">
                    </asp:DropDownList></td>

             </tr>
                     <tr>
                    <td colspan="3" ><asp:Button ID="Button1" runat="server" CssClass="botonnew" Text="FILTRAR" OnClick="Button1_Click" style="height: 16px" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Button ID="Button2" runat="server" CssClass="botonnew" Text="Exportar Excel" OnClick="Button2_Click"  />    </td>
                </tr>    
                </table>
                <table>
                             <tr>
                                                <td rowspan="3" style="vertical-align:top; " class="auto-style11">        
                                               
                                                    &nbsp; <asp:Label ID="EFECTIVAS" visible="false" text="EFECTIVAS" runat="server"></asp:Label>
                                                     
                                        <asp:GridView ID="GrillaEfectividadLector" runat="server" AutoGenerateColumns="False"
                                            CssClass="GridAlternativeItems" Height="1px"
                                            Width="424px" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" CellPadding="4" ForeColor="#333333" GridLines="None"><FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                            <HeaderStyle BackColor="#2461BF" />
                                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                            <PagerStyle BorderColor="Transparent"
                                                VerticalAlign="Middle" BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                             <AlternatingRowStyle BackColor="White" />
                                             <PagerStyle HorizontalAlign="Center" BackColor="White" />
                                            <Columns>
                                                <asp:BoundField DataField="clave" HeaderText="Clave Efectiva"></asp:BoundField>
                                                <asp:BoundField DataField="descripcion" HeaderText="Descripci&#243;n"></asp:BoundField>
                                                <asp:BoundField DataField="cantidad" HeaderText="Cantidad"></asp:BoundField>
                                                <asp:BoundField DataField="porcentaje" HeaderText="%"></asp:BoundField>
                                              
                                            </Columns>
                                      
                                        </asp:GridView>
                                  
                                        </td>
                                        <td  rowspan="3" style="height: 217px; vertical-align:top; width: 23%;" >
                                        &nbsp;&nbsp;<asp:Label ID="IMPROCEDENTES" visible="false" text="IMPROCEDENTES" runat="server"></asp:Label>
                                                                             
                                         <asp:GridView ID="GrillaEfectividad_lector_impro" runat="server" AutoGenerateColumns="False"
                                            CssClass="GridAlternativeItems" Height="1px"
                                            Width="423px" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" CellPadding="4" ForeColor="#333333" GridLines="None">
                                              <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />                                             
                                              <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                              <PagerStyle BorderColor="Transparent"
                                                VerticalAlign="Middle" BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                              <AlternatingRowStyle BackColor="White" />
                                              <PagerStyle HorizontalAlign="Center" BackColor="White" />
                                              <Columns>
                                                  <asp:BoundField DataField="clave" HeaderText="Clave Improcedente"></asp:BoundField>
                                                  <asp:BoundField DataField="descripcion" HeaderText="Descripci&#243;n"></asp:BoundField>                                                  
                                                  <asp:BoundField DataField="CANTIDAD" HeaderText="Cantidad"></asp:BoundField>
                                                  <asp:BoundField DataField="porcentaje" HeaderText="%"></asp:BoundField>
                                                  
                                              </Columns>                                             
                                          </asp:GridView>&nbsp;
                                        
                                                    &nbsp;</td>
                                     <%--      <td  style="width: 441px; height: 217px; vertical-align:top;">
                                        &nbsp;&nbsp;<asp:Label ID="Label8" visible="false" text="IMPROCEDENTES CON REPASO" runat="server"></asp:Label>
                                                                             
                                         <asp:GridView Visible="false" ID="GridView1" runat="server" AutoGenerateColumns="False"
                                            CssClass="GridAlternativeItems" Height="1px"
                                            Width="423px" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" CellPadding="4" ForeColor="#333333" GridLines="None">
                                              <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />                                             
                                              <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                              <PagerStyle BorderColor="Transparent"
                                                VerticalAlign="Middle" BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                              <AlternatingRowStyle BackColor="White" />
                                              <PagerStyle HorizontalAlign="Center" BackColor="White" />
                                              <Columns>
                                                  <asp:BoundField DataField="clave" HeaderText="Clave Improcedente"></asp:BoundField>
                                                  <asp:BoundField DataField="descripcion" HeaderText="Descripci&#243;n"></asp:BoundField>                                                  
                                                  <asp:BoundField DataField="CANTIDAD" HeaderText="Cantidad"></asp:BoundField>
                                                  <asp:BoundField DataField="porcentaje" HeaderText="%"></asp:BoundField>
                                                  
                                              </Columns>                                             
                                          </asp:GridView>&nbsp;
                                        
                                                    &nbsp;</td>--%>
                                            </tr>
                </table>
           <table class="auto-style9">
            <tr>
                <td class="auto-style8" >
                    <asp:label runat="server" text="Total Ordenes de Cambio:" Font-Bold="True" Font-Size="Medium"></asp:label>                 
                </td>
                <td>
                    <asp:TextBox ID="txt_total" runat="server"  CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox> <asp:label id="lblTotales" runat="server" visible="false"></asp:label>
                &nbsp;</td>
             
            </tr>
            <tr>
                <td class="auto-style8" >
                     <asp:label runat="server" text="Total Ordenes de Cambio Visitadas:" Font-Bold="True" Font-Size="Medium"></asp:label>  
                </td>
                <td>
                    <asp:TextBox ID="txt_cant_leidas" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                    <asp:TextBox ID="txt_leidas" runat="server"  CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                    %</td>
                            
            </tr>
            <tr>
                <td class="auto-style8" >
                <asp:label runat="server" text="Total Ordenes de Cambio por Visitar:" Font-Bold="True" Font-Size="Medium"></asp:label>             
                </td>
                <td>
                    <asp:TextBox ID="txt_cant_pendientes" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                    <asp:TextBox ID="txt_pendientes" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                    %</td>
            </tr>
                <tr>
                <td class="auto-style8" >
                <asp:label ID="Label7" runat="server" text="Total Ordenes con Repaso:" Font-Bold="True" Font-Size="Medium"></asp:label>             
                </td>
                <td>
                    <asp:TextBox ID="TextBox3" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                   <%-- <asp:TextBox ID="TextBox4" runat="server" CssClass="TextBox_totalizador" ReadOnly="True" Visible="false"></asp:TextBox>
                    %--%>

                </td>
            </tr>
                    <tr>
                <td class="auto-style8"> 
                    <asp:label ID="Label6" runat="server" text="Total Ordenes de cambios en Repaso:" Font-Bold="True" Font-Size="Medium"></asp:label>         
                </td>
                <td>
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                   <%-- <asp:TextBox ID="TextBox2" runat="server" CssClass="TextBox_totalizador" ReadOnly="True" Visible="false">
                    </asp:TextBox>
                    %--%>
                    </td>
            </tr>
            <tr>
                <td class="auto-style8"> 
                    <asp:label runat="server" text="Total Cambios Efectivos:" Font-Bold="True" Font-Size="Medium"></asp:label>                                                            
                </td>
                <td>
                    <asp:TextBox ID="txt_cant_efectivas" runat="server" CssClass="TextBox_totalizador" ReadOnly="True" BackColor="#80FF80"></asp:TextBox>
                    <asp:TextBox ID="txt_efectivos" runat="server" CssClass="TextBox_totalizador" ReadOnly="True"></asp:TextBox>
                    %</td>
            </tr>
            <tr>
                <td class="auto-style8"> 
                    <asp:label runat="server" text="Total Cambios Improcedentes:" Font-Bold="True" Font-Size="Medium"></asp:label>         
                </td>
                <td>
                    <asp:TextBox ID="txt_cant_improcedentes" runat="server" CssClass="TextBox_totalizador" ReadOnly="True" BackColor="orange"></asp:TextBox>
                    <asp:TextBox ID="txt_sin_lecturas" runat="server" CssClass="TextBox_totalizador" ReadOnly="True">
                    </asp:TextBox>
                    %
                    </td>
            </tr>
             
       
            </table>
    </asp:Content>