<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/menu.master" CodeFile="SustitucionMedidor.aspx.cs" Inherits="SustitucionMedidor" %>


<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

       <script type="text/javascript">

           function alerta(numero) {
               alert('Debe Seleccionar al menos un registro');
           }
           function alertaCortador(numero) {
               alert('Debe generar listado de informes');
           }
           function validaFiltro(numero) {
               alert('Debe seleccionar al menos un Instalador');
           }
           function CheckAllEmp(Checkbox) {
               var GridOrden = document.getElementById("<%=GridOrden.ClientID %>");
               for (i = 1; i < GridOrden.rows.length; i++) {
                    GridOrden.rows[i].cells[3].getElementsByTagName("INPUT")[0].checked = Checkbox.checked;
                }
            }
    </script> 

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   
    <h1 class="WebPartTitle">Orden Sustitucion Medidor</h1>

        <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>

            <table id="tablaAsig" style="width: 50%; height: 122px;">
                  <tr>                 
                      <td class="auto-style74">Region:&nbsp;
                      <asp:DropDownList ID="ddZona" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddZona_SelectedIndexChanged" Width="230px">
                        </asp:DropDownList>
                           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          <asp:Button ID="Button1" runat="server" CssClass="botonnew"  Text="Generar Reportes" OnClick="Button1_Click" />
                    </td>                   
                    <td class="auto-style67">&nbsp;&nbsp;</td>
                    <td class="auto-style56"></td>
                </tr> 
                <tr>
                    <td class="auto-style88" style="width: 818px">Estado Ordenes:    
                        &nbsp; <asp:DropDownList ID="ddlEstadoOrd" runat="server" AutoPostBack="True" CssClass="ComboBox" Width="230px" OnSelectedIndexChanged="ddlEstadoOrd_SelectedIndexChanged">
                            <asp:ListItem Value="0">seleccionar</asp:ListItem>
                            <asp:ListItem Value="1">Cargado en PDA</asp:ListItem>
                            <asp:ListItem Value="2">Pendiente</asp:ListItem>
                            <asp:ListItem Value="3">Improcedentes</asp:ListItem>
                        </asp:DropDownList></td>
                       
                </tr>
                    <tr>
                    <td class="auto-style88" style="width: 818px">Estado Impresion: 
                     <asp:DropDownList ID="ddlEstadoImp" runat="server" AutoPostBack="True" CssClass="ComboBox"  Width="230px" OnSelectedIndexChanged="ddlEstadoImp_SelectedIndexChanged">
                         <asp:ListItem Value="0">seleccionar</asp:ListItem>
                            <asp:ListItem Value="1">No Impresa</asp:ListItem>
                            <asp:ListItem Value="2">Re-Imprimir</asp:ListItem>                        
                        </asp:DropDownList></td>   
                </tr> 
                  <tr>
                
                    <td class="auto-style88" style="width: 818px">&nbsp;</td>
                    <td class="auto-style24">
                                    
                    </td>
                    <td class="auto-style24">&nbsp;</td>
                </tr>                
                <tr>
                    <td class="auto-style43" colspan="5" style="height: 380px" >                    
                        <asp:Panel ID="Panel1" runat="server" Height="385px" HorizontalAlign="Center" ScrollBars="Vertical" Width="849px" >
                        <asp:GridView ID="GrdInstalador" runat="server" AllowPaging="false" AutoGenerateColumns="false" CellPadding="1" CssClass="GridAlternativeItems"  EnableModelValidation="True" ForeColor="#333333" Height="25px"  PageSize="5" Width="830px"  >
                                <AlternatingRowStyle BackColor="White" />                              
                            <Columns>
                             <asp:BoundField DataField="INSTALADOR" HeaderText="CODIGO INSTALADOR">
                                <HeaderStyle ForeColor="White" />  </asp:BoundField>    
                                <asp:BoundField DataField="NOMBRE" HeaderText="NOMBRE">
                                <HeaderStyle ForeColor="White" /> </asp:BoundField>
                                <asp:BoundField DataField="APELLIDO" HeaderText="APELLIDO">
                                <HeaderStyle ForeColor="White" /> </asp:BoundField>                                
                                <asp:TemplateField HeaderText="Seleccion">
                                               <ItemTemplate>
                                                    <asp:CheckBox ID="check_impr1" runat="server" />
                                                </ItemTemplate>
                                                <HeaderStyle ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                                            </asp:TemplateField>
                              </Columns>                         
                                <EditRowStyle BackColor="#2461BF" />
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <RowStyle BackColor="#EFF3FB" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            </asp:GridView>
                    </asp:Panel>
                    </td>
                </tr>                 
                  <tr>
                    <td class="auto-style88" style="width: 818px">&nbsp;</td>
                    <td class="auto-style24">                                
                    </td>
                    <td class="auto-style24">&nbsp;</td>
                </tr>
                       <tr>                   
                    <td class="auto-style40" style="width: 818px; height: 404px;">
                         <asp:Panel ID="Panel2" runat="server" Height="404px" HorizontalAlign="Center" ScrollBars="Vertical" Width="1046px" >
                        <asp:GridView ID="GridOrden" runat="server" AllowPaging="false" AutoGenerateColumns="false" CellPadding="1" CssClass="GridAlternativeItems"  EnableModelValidation="True" ForeColor="#333333" Height="25px"  PageSize="5" Width="1028px"  >
                                <AlternatingRowStyle BackColor="White" />                              
                            <Columns>
                             <asp:BoundField DataField="NUMERO_ORDEN" HeaderText="NUMERO ORDEN">
                                <HeaderStyle ForeColor="White" />  </asp:BoundField>    
                                <asp:BoundField DataField="FECHA_CREACION" HeaderText="FECHA CREACION">
                                <HeaderStyle ForeColor="White" /> </asp:BoundField>                               
                                <asp:BoundField DataField="ID_SERVICIO" HeaderText="SERVICIO">
                                <HeaderStyle ForeColor="White" /> </asp:BoundField>
                                <asp:BoundField DataField="RUTA" HeaderText="RUTA">
                                <HeaderStyle ForeColor="White" /> </asp:BoundField>
                                <asp:BoundField DataField="LOCALIDAD" HeaderText="LOCALIDAD">
                                <HeaderStyle ForeColor="White" />  </asp:BoundField>                                
                                <asp:BoundField DataField="CLIENTE" HeaderText="CLIENTE">
                                <HeaderStyle ForeColor="White" /> </asp:BoundField>
                                <asp:BoundField DataField="DIRECCION" HeaderText="DIRECCION">
                                <HeaderStyle ForeColor="White" /> </asp:BoundField>
                                <asp:BoundField DataField="COD_INSTALADOR" HeaderText="CODIGO OPERADOR">
                                <HeaderStyle ForeColor="White" /> </asp:BoundField>
                                 <asp:BoundField DataField="DESCRIPCION" HeaderText="IMPROCEDENCIA">
                                <HeaderStyle ForeColor="White" /> </asp:BoundField>
                                
                                <asp:TemplateField HeaderText="Seleccion">
                                      <HeaderTemplate >
                                        Sel. Todos<asp:CheckBox ID="chkboxSelectAll" runat="server"  AutoPostBack="true" OnCheckedChanged="chkboxSelectAll_CheckedChanged" />
                                      </HeaderTemplate>
                                               <ItemTemplate>
                                                    <asp:CheckBox ID="check_impr2" runat="server" />
                                                </ItemTemplate>
                                                <HeaderStyle ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                                            </asp:TemplateField>
                              </Columns>                         
                                <EditRowStyle BackColor="#2461BF" />
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <RowStyle BackColor="#EFF3FB" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            </asp:GridView>
                    </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style7" colspan="6" style="height: 19px">
                       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;          
                     <asp:Button ID="Button2" runat="server" CssClass="botonnew2" OnClick="Button1_Click1" Text="Imprimir Documento" />
                         <asp:GridView ID="GridSeloper" runat="server" Visible="false"></asp:GridView>  
                         <asp:GridView ID="GridSelEnvia" runat="server" Visible="false"></asp:GridView>  
                    </td>
                    <td class="auto-style7" style="width: 268px; height: 19px;">&nbsp; </td>
                </tr>
                <tr>
                    <td class="auto-style88" style="width: 818px">&nbsp;</td>
                    <td class="auto-style24">                                    
                    </td>
                    <td class="auto-style24">&nbsp;</td>
                </tr>
            </table>
    </asp:Content>

