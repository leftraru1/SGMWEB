<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/menu.master" CodeFile="SustitucionMedidor.aspx.cs" Inherits="SustitucionMedidor" %>


<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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

           function abrir(numero) {
               window.open('InformeSustitucionMedidor.aspx', 'Dates', 'scrollbars=yes, resizable=yes, height=800, width=1200,top=0,left=0');
           }


    </script>


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     
    <h1 class="WebPartTitle">Orden Sustitucion Medidor</h1>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <table id="tablaAsig" style="width: 50%; height: 122px;">

        <tr>
            <td class="auto-style88" style="width: 818px">Region:    
                        &nbsp; &nbsp;  &nbsp;
                <asp:DropDownList ID="ddregion" runat="server" AutoPostBack="True" CssClass="ComboBox" Width="230px" OnSelectedIndexChanged="ddregion_SelectedIndexChanged">
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td class="auto-style88" style="width: 818px">Zona: 
                     &nbsp; &nbsp; &nbsp; &nbsp;
                <asp:DropDownList ID="ddzona" runat="server" AutoPostBack="True" CssClass="ComboBox" Width="230px" OnSelectedIndexChanged="ddzona_SelectedIndexChanged">
                </asp:DropDownList>

            </td>
        </tr>
         <tr>
            <td class="auto-style88" style="width: 818px">Localidad: 
                     &nbsp;
                <asp:DropDownList ID="ddlocalidad" runat="server" AutoPostBack="True" CssClass="ComboBox" Width="230px" OnSelectedIndexChanged="ddlocalidad_SelectedIndexChanged">
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td class="auto-style88" style="width: 818px">Contratista: 
                     
                <asp:DropDownList ID="ddcontratista" runat="server" AutoPostBack="True" CssClass="ComboBox" Width="230px" OnSelectedIndexChanged="ddcontratista_SelectedIndexChanged" >
                </asp:DropDownList></td>
        </tr>
       
        <tr>
            <td class="auto-style74">Instalador:&nbsp;
                      <asp:DropDownList ID="ddinstalador" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddinstalador_SelectedIndexChanged" Width="230px">
                      </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="Button3" runat="server" CssClass="botonnew" Text="Filtrar" OnClick="Button3_Click" />
            </td>
            <td class="auto-style88" style="width: 818px">&nbsp;</td>
            <td class="auto-style24"></td>
            <td class="auto-style24">&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lb_mje" runat="server" Font-Size="Small"  Visible="false" ></asp:Label>
            </td>
             <td>
                <asp:Label ID="lb_mje2" runat="server" Font-Size="Small"  Visible="false" ></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style88" style="width: 818px; height: 19px;"></td>
            <td class="auto-style24" style="height: 19px"></td>
            <td class="auto-style24" style="height: 19px"></td>
        </tr>

        <tr>
            <td class="auto-style40" style="width: 818px; height: 404px;">
                <%--<asp:Panel ID="Panel2" runat="server" Height="404px" HorizontalAlign="Center" ScrollBars="Vertical" Width="1546px" >--%>
                <asp:GridView ID="GridOrden" runat="server" AllowPaging="True" AutoGenerateColumns="false" CellPadding="1" CssClass="GridAlternativeItems" OnRowCommand="GridOrden_RowCommand" OnRowCreated="GridOrden_RowCreated" OnPageIndexChanging="GridOrden_PageIndexChanging" EnableModelValidation="True" ForeColor="#333333" Height="25px" Width="1128px" PageSize="100">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="NUMERO_ORDEN" HeaderText="NUMERO ORDEN">
                            <HeaderStyle ForeColor="White" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FECHA_CREACION" HeaderText="FECHA CREACION">
                            <HeaderStyle ForeColor="White" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ID_SERVICIO" HeaderText="SERVICIO">
                            <HeaderStyle ForeColor="White" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NOMBRE_CONTRATISTA" HeaderText="CONTRATISTA">
                            <HeaderStyle ForeColor="White" />
                        </asp:BoundField>
                        <asp:BoundField DataField="RUTA" HeaderText="RUTA">
                            <HeaderStyle ForeColor="White" />
                        </asp:BoundField>
                        <asp:BoundField DataField="LOCALIDAD" HeaderText="LOCALIDAD">
                            <HeaderStyle ForeColor="White" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CLIENTE" HeaderText="CLIENTE">
                            <HeaderStyle ForeColor="White" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DIRECCION" HeaderText="DIRECCION">
                            <HeaderStyle ForeColor="White" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NOMBRE_INSTALADOR" HeaderText="NOMBRE INSTALADOR">
                            <HeaderStyle ForeColor="White" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CAUSA_CAMBIO" HeaderText="CAUSA CAMBIO">
                            <HeaderStyle ForeColor="White" />
                        </asp:BoundField>
                            <asp:TemplateField HeaderText="SELECCIONAR">
                                                <HeaderTemplate>
                                                    <asp:LinkButton ID="lkbAsignar" runat="server" CommandName="asignar" ForeColor="White">SELECCIONAR</asp:LinkButton>
                                                    
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="check_asigna" runat="server" />
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="60px" />
                                            </asp:TemplateField>
                        <%--<asp:TemplateField HeaderText="Seleccion">
                            <HeaderTemplate>
                                Sel. Todos<asp:CheckBox ID="chkboxSelectAll" runat="server" AutoPostBack="true" OnCheckedChanged="chkboxSelectAll_CheckedChanged" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="check_impr2" runat="server" />
                            </ItemTemplate>
                            <HeaderStyle ForeColor="White" />
                            <ItemStyle HorizontalAlign="Center" Width="50px" />
                        </asp:TemplateField>--%>
                    </Columns>
                    <EditRowStyle BackColor="#2461BF" />
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                </asp:GridView>
                <%--<asp:TemplateField HeaderText="Seleccion">
                            <HeaderTemplate>
                                Sel. Todos<asp:CheckBox ID="chkboxSelectAll" runat="server" AutoPostBack="true" OnCheckedChanged="chkboxSelectAll_CheckedChanged" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="check_impr2" runat="server" />
                            </ItemTemplate>
                            <HeaderStyle ForeColor="White" />
                            <ItemStyle HorizontalAlign="Center" Width="50px" />
                        </asp:TemplateField>--%>
            </td>
        </tr>
        <tr>
            <td class="auto-style88" colspan="6" style="height: 19px"   >
                           
                     <asp:Button ID="btnimprime" runat="server"   OnClick="btnimprime_Click"  Text="Imprimir Documento"  />
            </td>
            
        </tr>
        <tr>
            <td class="auto-style88" style="width: 818px">&nbsp;</td>
            <td class="auto-style24"></td>
            <td class="auto-style24">&nbsp;</td>
        </tr>
    </table>
</asp:Content>

