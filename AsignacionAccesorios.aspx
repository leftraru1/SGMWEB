<%@ Page Title="Asignación de Accesorios" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="AsignacionAccesorios.aspx.cs" Inherits="AsignacionAccesorios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

        <script src = " https://unpkg.com/sweetalert/dist/sweetalert.min.js "></script> 

        <script type="text/javascript">

            function popInstalador(obj){
                var url = 'popInstalador.aspx?textbox=' + obj;
                window.open(url, 'cal', 'width=820,height=320,left=200,top=50,resizable=0,scrollbars=yes');
            }
            function openCalendar(obj) {
                var url = 'calendario2.aspx?textbox=' + obj;
                window.open(url, 'cal', 'width=260,height=210,left=410 410,top=330,resizable=0,scrollbars=0');
            }
            function cambio_ordenes(ordenes, total) {
                swal("Cambios efectuados ", "Se asignaron " + ordenes + " de un total de " + total, "success");
            }
            function cambio_ordenes_error(ordenes, total) {
                swal("Cambios efectuados ", "Se asignaron " + ordenes + " de un total de " + total, "warning");
            }

            function cambio_ordenes_desasigna(ordenes) {
                swal("Cambios efectuados ", "Se desasignaron : " + ordenes + "", "success");
            }

            function Seleccione() {
                swal("¡ERROR! ", "No seleccionó accesorios", "warning");
            }
            function Selecione_instalador() {
                swal("¡ERROR! ", "No seleccionó instalador", "warning");
            }
            function instalador_no_valido() {
                swal("¡ERROR! ", "El instalador no existe", "warning");
            }
            function error() {
                swal("¡ERROR! ", "Algun campo es no numerico o no ha ingresado cantidades", "warning");
            }
            function correcto() {
                swal("¡CORRECTO! ", "SE ASIGNARON ACCESORIOS", "success");
            }

            function error_plantilla(mensaje) {
                swal("¡ERROR! ", ""+mensaje+"", "warning");
            }
    </script>
    <style>
        body {
            zoom: 90%;
        }
       
        </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1 class="WebPartTitle">Asignación de Accesorios</h1>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
                <table id="filtros_accesorio">
                    <tr>
                            <td style="width:50px; text-align:left;">
                                <asp:Label ID="lb_bodega" runat="server" Text="Bodega"></asp:Label>
                            </td>
                            <td style="width:200px; text-align:left;">
                               :<asp:DropDownList ID="ddBodegas" runat="server" AutoPostBack="true" Width="180px" OnSelectedIndexChanged="cambio_bodega" CssClass="ComboBox"> </asp:DropDownList>                      
                            </td>
                            <td style="width:50px; text-align:left;">
                                <asp:Label ID="lb_diametro" runat="server" Text="Diametro"></asp:Label>
                            </td>
                            <td style="width:120px; text-align:left;">
                               :<asp:DropDownList ID="ddDiametros" runat="server" AutoPostBack="true" Width="100px" OnSelectedIndexChanged="cambio_diametro" CssClass="ComboBox"> 
                                  
                                </asp:DropDownList>                      
                            </td>
                        <td style="width:50px; text-align:left;">
                                <asp:Label ID="lb_accesorio" runat="server" Text="Accesorio"></asp:Label>
                            </td>
                            <td style="width:200px; text-align:left;">
                               :<asp:DropDownList ID="ddAccesorios" runat="server" AutoPostBack="true" Width="180px" OnSelectedIndexChanged="cambio_accesorio" CssClass="ComboBox"> </asp:DropDownList>                      
                            </td>
                            <td style="width:auto;"></td>
                        </tr>

                    <tr>
                        <td colspan="7" style="text-align:left;">
                            <asp:Label ID="lb_bodega0" runat="server" Height="17px" Text="Nivel stock mínimo: "></asp:Label>
                            &nbsp;<asp:TextBox ID="txt_stock_minimo_NORMAL" runat="server" BorderColor="White" CssClass="TextBox" Font-Bold="True" ReadOnly="true" Width="100px">NORMAL</asp:TextBox>
                            <asp:TextBox ID="txt_stock_minimo_ADVERTENCIA" runat="server" BackColor="Orange" BorderColor="White" CssClass="TextBox" Font-Bold="True" ForeColor="White" ReadOnly="true" Width="100px">ADVERTENCIA</asp:TextBox>
                            <asp:TextBox ID="txt_stock_minimo_CRITICO" runat="server" BackColor="IndianRed" BorderColor="White" CssClass="TextBox" Font-Bold="True" ForeColor="White" ReadOnly="true" Width="100px">CRITICO</asp:TextBox>
                            &nbsp;<br /> <asp:Label ID="lbResultado" runat="server"></asp:Label>
                            <asp:Label ID="lbErrorGrilla" runat="server"></asp:Label>
                        </td>
                    </tr>

                </table>
                <table id="panel" runat="server" style="width:68%;">                    
                        <tr>
                        <td id="accesorio_bodega" style="width:40%;">
                            <fieldset><legend><div style="text-align:center"><h3 style="color:darkblue">ACCESORIOS EN BODEGA</h3></div></legend>
                            <table id="tabla_accesorio_bodega">
                            <tr>
                                <td style="width:50px; text-align:left;">
                               
                                </td>
                                <td style="width:200px; text-align:left;">
                                </td>
                                <td style="width:50px; text-align:left;">
                               
                                </td>
                                <td style="width:200px; text-align:left;">
                                          
                                </td>
                          
                                <td style="width:auto;"></td>
                        </tr>
                                <tr>
                              <td style="width:50px; text-align:left;">
                                <asp:Label ID="Label3" runat="server" Text="Stock"></asp:Label>
                            </td>
                            <td style="width:200px; text-align:left;">
                               :<asp:DropDownList ID="ddStock" runat="server" AutoPostBack="true" Width="180px" CssClass="ComboBox" OnSelectedIndexChanged="ddStock_SelectedIndexChanged"> 
                                    <asp:ListItem Value="1">CON STOCK</asp:ListItem>
                                    <asp:ListItem Value="2">SIN STOCK</asp:ListItem>
                                </asp:DropDownList>                      
                            </td>
                                <td style="width:50px; text-align:left;">
                               
                                </td>
                                <td style="width:200px; text-align:left;">
                                          
                                </td>
                          
                                <td style="width:auto;"></td>
                        </tr>
                               <tr>
                                   <td colspan="5">
                                       <tr>
                                           <td colspan="2">Cód. Instalador:
                                               <asp:TextBox ID="txtInstalador" runat="server" CssClass="TextBox2"></asp:TextBox>
                                               <img src="Imagenes/lupa.bmp" onclick="popInstalador('ctl00_ContentPlaceHolder1_txtInstalador');"  id="IMG1" />
                                               &nbsp;&nbsp; </td>
                                           <td colspan="3" style="text-align:right;">
                                               <asp:Button ID="btn_asignar" runat="server" CssClass="botonnew" Height="20px" OnClick="btnAsignar_Click" Text="Asignar Accesorio(s)" />
                                           </td>
                                       </tr>
                                       <tr>
                                           <td colspan="5"><%--<img src="/ESSBIO_MED/Imagenes/warning.bmp" runat="server"  id="IMG4" />&nbsp;--%>
                                               <asp:Label ID="lbTxtIn" runat="server"></asp:Label>
                                               <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtInstalador" ErrorMessage="Solo números para código de instalador." ValidationExpression="^([0-9]{1,10})$"></asp:RegularExpressionValidator>
                                               <br />
                                           </td>
                                       </tr>
                                       <tr>
                                           <td colspan="5">
                                               <asp:Label ID="lbTotal" runat="server" Visible="false"></asp:Label>
                                           </td>
                                       </tr>
                                       <tr>
                                           <td colspan="5" style="text-align:left;">
                                               <asp:Panel ID="panel1" runat="server" Height="450px" HorizontalAlign="Center" ScrollBars="auto" Width="100%">
                                                   <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                       <ContentTemplate>
                                                           <asp:GridView ID="Accesorios" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" CssClass="GridAlternativeItems" EnableModelValidation="True" ForeColor="#333333" Height="50px" OnPageIndexChanging="Accesorios_PageIndexChanging" OnRowDataBound="Accesorios_RowDataBound" PageSize="1000" Width="95%">
                                                               <AlternatingRowStyle BackColor="White" />
                                                               <Columns>
                                                                   <asp:BoundField DataField="ID_ACCESORIO" HeaderText="ACCESORIO">
                                                                   <HeaderStyle ForeColor="White" />
                                                                   </asp:BoundField>
                                                                   <asp:BoundField DataField="ID_BODEGA" HeaderText="ID_BODEGA">
                                                                   <HeaderStyle ForeColor="White" />
                                                                   <ItemStyle Font-Size="Smaller" />
                                                                   </asp:BoundField>
                                                                   <asp:BoundField DataField="BODEGA" HeaderText="BODEGA">
                                                                   <HeaderStyle ForeColor="White" Width="20%" />
                                                                   <ItemStyle Font-Size="Smaller" Font-Bold="true" />
                                                                   </asp:BoundField>
                                                                   <asp:BoundField DataField="CODIGO_PROVEEDOR" HeaderText="CODIGO">
                                                                   <HeaderStyle ForeColor="White" Width="35%"  />
                                                                   <ItemStyle Font-Size="Smaller" Font-Bold="true" />
                                                                   </asp:BoundField>
                                                                   <asp:BoundField DataField="STOCK_TOTAL" HeaderText="STOCK TOTAL">
                                                                   <HeaderStyle ForeColor="White" Width="10%" />
                                                                   <ItemStyle Font-Size="Smaller" Font-Bold="true"/>
                                                                   </asp:BoundField>
                                                                   <asp:BoundField DataField="STOCK" HeaderText="STOCK DISP.">
                                                                   <HeaderStyle ForeColor="White" Width="10%"  />
                                                                   <ItemStyle Font-Size="Smaller" Font-Bold="true" />
                                                                   </asp:BoundField>
                                                                   <asp:BoundField DataField="STOCK_MINIMO" HeaderText="STOCK MIN.">
                                                                   <HeaderStyle ForeColor="White" Width="10%" />
                                                                   <ItemStyle Font-Size="Smaller" />
                                                                   </asp:BoundField>
                                                                   <asp:TemplateField HeaderText="CANTIDAD A ASIGNAR">
                                                                       <ItemTemplate>
                                                                           <asp:TextBox ID="cant_recibida" runat="server" CssClass="TextBox" Font-Size="Small" ImageAlign="Middle" MaxLength="4" Width="40px"></asp:TextBox>
                                                                       </ItemTemplate>
                                                                       <ItemStyle HorizontalAlign="Center" Width="20px" />
                                                                       <HeaderStyle ForeColor="White" Width="15%" />
                                                                   </asp:TemplateField>
                                                               </Columns>
                                                               <EditRowStyle BackColor="#2461BF" />
                                                               <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                               <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                               <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                                               <RowStyle BackColor="#EFF3FB" />
                                                               <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                                           </asp:GridView>
                                                       </ContentTemplate>
                                                   </asp:UpdatePanel>
                                               </asp:Panel>
                                           </td>
                                       </tr>
                                   </td>
                          </tr>
                    </table>
                           </fieldset>
                        </td>
                        
                        <td id="accesorio_uso"  style="width:50%;">
                            <fieldset><legend><div style="text-align:center"><h3 style="color:darkblue">ACCESORIOS EN USO</h3></div></legend>
                            
                             <table id="tabla_accesorio_uso">
                                  <tr>
                                <td style="width:50px; text-align:left;">
                               
                                </td>
                                <td style="width:200px; text-align:left;">
                                </td>
                                <td style="width:50px; text-align:left;">
                               
                                </td>
                                <td style="width:200px; text-align:left;">
                                          
                                </td>
                          
                                <td style="width:auto;"></td>
                        </tr>
                               <tr>
                              <td style="width:50px; text-align:left;">
                                <asp:Label ID="Label2" runat="server" Text="Instalador"></asp:Label>
                            </td>
                            <td style="width:200px; text-align:left;">
                               :<asp:DropDownList ID="ddInstalador" runat="server" AutoPostBack="true" Width="180px" CssClass="ComboBox" OnSelectedIndexChanged="ddInstalador_SelectedIndexChanged"> 
                                  
                                </asp:DropDownList>                      
                            </td>
                                <td style="width:50px; text-align:left;">
                               
                                </td>
                                <td style="width:200px; text-align:left;">
                                          
                                </td>
                          
                                <td style="width:auto;"></td>
                        </tr>
                               <tr>
                                   <td colspan="5">
                                       <tr>
                                           <td colspan="5" style="text-align:right;">
                                               <asp:Button ID="btn_desasignar" runat="server" CssClass="botonnew" Height="20px" OnClick="btnDesAsignar_Click" Text="Desasignar Accesorio(s)" Width="150px" />
                                           </td>
                                       </tr>
                                       <tr>
                                           <td colspan="5">
                                               <label style="visibility:hidden;">Desasignar</label>
                                               <br />
                                           </td>
                                       </tr>
                                       <tr>
                                           <td colspan="5">
                                               <asp:Label ID="lbTotal0" runat="server" Visible="false"></asp:Label>
                                           </td>
                                       </tr>
                                       <tr>
                                           <td colspan="5">
                                               <asp:Panel ID="Panel2" runat="server" Height="450px" HorizontalAlign="Center" ScrollBars="auto" Width="100%">
                                                   <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                       <ContentTemplate>
                                                           <asp:GridView ID="accesoriosxoperador" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" CssClass="GridAlternativeItems" EnableModelValidation="True" ForeColor="#333333" Height="50px" OnPageIndexChanging="accesoriosxoperador_PageIndexChanging" OnRowCommand="accesoriosxoperador_RowCommand" OnRowDataBound="accesoriosxoperador_RowDataBound" PageSize="1000" Width="95%">
                                                               <AlternatingRowStyle BackColor="White" />
                                                               <Columns>
                                                                   <asp:BoundField DataField="ID_ACCESORIOXOPERADOR" HeaderText="CODIGO">
                                                                   <HeaderStyle ForeColor="White" Width="0%" />
                                                                   <ItemStyle Font-Size="Smaller" />
                                                                   </asp:BoundField>
                                                                   <asp:BoundField DataField="ID_ACCESORIO" HeaderText="ACCESORIO">
                                                                   <HeaderStyle ForeColor="White" Width="30%" />
                                                                   <ItemStyle Font-Size="Smaller" Font-Bold="true" />
                                                                   </asp:BoundField>
                                                                   <asp:BoundField DataField="ID_BODEGA" HeaderText="ID_BODEGA">
                                                                   <HeaderStyle ForeColor="White" Width="0%"/>
                                                                   <ItemStyle Font-Size="Smaller" />
                                                                   </asp:BoundField>
                                                                   <asp:BoundField DataField="BODEGA" HeaderText="BODEGA">
                                                                   <HeaderStyle ForeColor="White" Width="20%" />
                                                                   <ItemStyle Font-Size="Smaller" Font-Bold="true" />
                                                                   </asp:BoundField>
                                                                   <asp:BoundField DataField="INSTALADOR" HeaderText="INSTALADOR">
                                                                   <HeaderStyle ForeColor="White" Width="20%" />
                                                                   <ItemStyle Font-Size="Smaller" Font-Bold="true"/>
                                                                   </asp:BoundField>
                                                                   <asp:BoundField DataField="STOCK_ASIGNADO" HeaderText="STOCK TOTAL">
                                                                   <HeaderStyle ForeColor="White" Width="10%" />
                                                                   <ItemStyle Font-Size="Smaller" Font-Bold="true" />
                                                                   </asp:BoundField>
                                                                   <asp:BoundField DataField="ID_ESTADO" HeaderText="ID_ESTADO">
                                                                   <HeaderStyle ForeColor="White" Width="0%" />
                                                                   <ItemStyle Font-Size="Smaller" />
                                                                   </asp:BoundField>
                                                                   <asp:BoundField DataField="ESTADO" HeaderText="ESTADO">
                                                                   <HeaderStyle ForeColor="White" Width="10%" />
                                                                   <ItemStyle Font-Size="Smaller" Font-Bold="true"/>
                                                                   </asp:BoundField>
                                                                   <asp:TemplateField HeaderText="Desasignar">
                                                                       <HeaderTemplate>
                                                                           <asp:LinkButton ID="desasignar" runat="server" CommandName="desasignar">CHECK TODO</asp:LinkButton>
                                                                       </HeaderTemplate>
                                                                       <ItemTemplate>
                                                                           <asp:CheckBox ID="check_desasignar" runat="server" />
                                                                       </ItemTemplate>
                                                                       <HeaderStyle ForeColor="White" Width="10%" />
                                                                       <ItemStyle HorizontalAlign="Center" Width="10px" />
                                                                   </asp:TemplateField>
                                                               </Columns>
                                                               <EditRowStyle BackColor="#2461BF" />
                                                               <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                               <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                               <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                                               <RowStyle BackColor="#EFF3FB" />
                                                               <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                                           </asp:GridView>
                                                       </ContentTemplate>
                                                   </asp:UpdatePanel>
                                               </asp:Panel>
                                           </td>
                                       </tr>
                                   </td>
                        </tr>
                    </table>
                                </fieldset>
                        </td>
                    </tr>
                </table>
           
            <table id="Table2" style="width: 126%; height: 122px;" runat="server">

             <tr>
                    <td style="width: 601px">
                       
                    </td>
             </tr>
             <tr>
                    <td style="width: 601px">&nbsp;</td>
                    <td>&nbsp;&nbsp;&nbsp; </td>
             </tr>

                <tr>
                    <td>&nbsp;</td>
                </tr>

                <tr>
                    <td>
                        
                     
                    </td>
                    <td></td>
                    <td class="auto-style7">&nbsp;</td>
             </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>

    </asp:Content>

