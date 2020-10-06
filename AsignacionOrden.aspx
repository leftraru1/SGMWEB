<%@ Page Title="Asignación de Ordenes" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true"   CodeFile="AsignacionOrden.aspx.cs" Inherits="AsignacionLecturas"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server" enableEventValidation="false">
    
       <%--<script src = " https://unpkg.com/sweetalert/dist/sweetalert.min.js "></script>--%> 
        <link href="js/main.js" rel="stylesheet" />
        <script type="text/javascript">

            function popInstalador(obj){
                var url = 'popInstalador.aspx?textbox=' + obj;
                window.open(url, 'cal', 'width=820,height=320,left=200,top=50,resizable=0,scrollbars=yes');
            }

            function openCalendar(obj) {
                var url = 'calendario2.aspx?textbox=' + obj;
                window.open(url, 'cal', 'width=260,height=210,left=410 410,top=330,resizable=0,scrollbars=0');
            }

            //function correcto(mensaje) {
            //    swal("¡ACCION REALIZADA! ", "" + mensaje + "", "success");
            //}


            //function Error(mensaje) {
            //    swal("¡ERROR! ", "" + mensaje + "", "warning");
            //}

            //function cancelar_orden(num) {
            //    swal("ORDEN CANCELADA!", "Se ha cancelado exitosamente la orden con número: " + num + "", "success");
            //}
            

    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1 class="WebPartTitle">Asignación de Ordenes</h1>

        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
            

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table id="tablaAsig" style="width: 126%; height: 122px;">
                <tr>
                    <td class="auto-style70" style="width: 70px"></td>
                    <td class="auto-style89" style="width: 260px"></td>
                    <td class="auto-style82" style="width: 110px">
                        <asp:Label ID="Label1" runat="server"></asp:Label>
                    </td>

                </tr>

                <tr>
                    <td class="auto-style71" style="width: 70px">Región:
                        </td>
                    <td class="auto-style74" style="width: 260px">
                        <asp:DropDownList ID="ddRegion" runat="server" AutoPostBack="True" CssClass="ComboBox"  Width="230px" OnSelectedIndexChanged="ddRegion_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style81" style="width: 110px">Tipo Proceso:</td>
                    <td style="width: 280px">
                        <asp:DropDownList ID="ddTipoPro" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddTipoPro_SelectedIndexChanged" Width="230px">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style60">
                       Desde:<asp:TextBox ID="txtDesde" runat="server" CssClass="TextBox3" Width="134px"></asp:TextBox>
                        <img src="Imagenes/calendario.gif" onclick="openCalendar('ctl00_ContentPlaceHolder1_txtDesde');"  id="IMG7" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtDesde" ErrorMessage="Error formato fecha." ValidationExpression="(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d"></asp:RegularExpressionValidator></td>
                    <td class="auto-style56">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style72" style="width: 70px">Zona: </td>
                    <td class="auto-style74" style="width: 260px">
                        <asp:DropDownList ID="ddZona" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddZona_SelectedIndexChanged" Width="230px">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style81" style="width: 110px">Estado:</td>
                    <td style="width: 280px">
                        <asp:DropDownList ID="ddSincro" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddSincro_SelectedIndexChanged" Width="230px">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style67">Hasta:&nbsp;<asp:TextBox ID="txtHasta" runat="server" CssClass="TextBox3" Width="134px"></asp:TextBox>
                        <img src="Imagenes/calendario.gif" onclick="openCalendar('ctl00_ContentPlaceHolder1_txtHasta');"  id="IMG9" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtHasta" ErrorMessage="Error formato fecha." ValidationExpression="(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d"></asp:RegularExpressionValidator>
                    </td>
                    <td class="auto-style56"></td>
                </tr>
                <tr>
                    <td class="auto-style72" style="width: 70px">Localidad:
                        </td>
                    <td class="auto-style89" style="width: 260px">
                        <asp:DropDownList ID="ddLocalidad" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddLocalidad_SelectedIndexChanged" Width="230px">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style82" style="width: 110px">Tipo Instalación:
                        </td>
                    <td style="width: 280px">
                        <asp:DropDownList ID="ddTipoIn" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddTipoIn_SelectedIndexChanged" Width="230px">
                        </asp:DropDownList>
                    </td>

                    <td class="auto-style67">
                    </td>
                    <td class="auto-style69"></td>
                </tr>

                <tr>
                    <td class="auto-style72" style="width: 70px; height: 21px;">Ruta: </td>
                    <td class="auto-style89" style="width: 260px; height: 21px;">
                        <asp:DropDownList ID="ddRuta" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddRuta_SelectedIndexChanged" Width="230px">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style72" style="width: 70px; height: 21px;">Contratista: </td>
                    <td class="auto-style89" style="width: 260px; height: 21px;">
                        <asp:DropDownList ID="ddContratista" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddContratista_SelectedIndexChanged" Width="230px">
                        </asp:DropDownList>
                    </td>

                    <td class="auto-style24" style="height: 21px">
                        <asp:Button ID="Button1" runat="server" CssClass="botonnew" OnClick="Button1_Click1"  Text="FILTRAR" Width="120px" />
                    </td>

                    <td class="auto-style69" style="height: 21px"></td>
                </tr>
                <tr>
                    <td class="auto-style72" style="width: 70px">Instalador:
                        </td>
                    <td class="auto-style89" style="width: 260px">
                        <asp:DropDownList ID="ddinstalador" runat="server"  AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddinstalador_SelectedIndexChanged" Width="230px">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style82" style="width: 110px; height: 21px;">Diámetro:</td>
                    <td style="height: 21px; width: 280px">
                        <asp:DropDownList ID="ddDiametro" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddDiametro_SelectedIndexChanged" Width="230px">
                        </asp:DropDownList>
                    </td>

                    <td class="auto-style67">
                        <asp:Button ID="btnexportar" runat="server" CssClass="botonnew" OnClick="btnexportar_Click" Text="EXPORTAR A EXCEL" Width="120px" />
                    </td>
                    <td class="auto-style69"></td>
                </tr>
                <tr>
                    <td class="auto-style72" style="width: 70px; height: 21px;">N° Orden: </td>
                    <td class="auto-style89" style="width: 260px; height: 21px;">
                        <asp:TextBox ID="TextboxNumOrden" runat="server" AutoPostBack="True" CssClass="TextBox3" Width="230px"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="valida_num_ord" runat="server" ControlToValidate="TextboxNumOrden" ErrorMessage="No es valido el formato" SetFocusOnError="true"  ValidationExpression="\d+"></asp:RegularExpressionValidator>
                    </td>
                    <td class="auto-style82">Servicio:</td>
                    <td style="height: 21px; width: 280px">
                     
                        <asp:TextBox ID="txtServ" runat="server" AutoPostBack="True" CssClass="TextBox3" Width="230px"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtServ" ErrorMessage="No es valido el formato" SetFocusOnError="true" ValidationExpression="\d+"></asp:RegularExpressionValidator>
                     
                    </td>
                    <td>
                         
                    </td>
                </tr>
                </table>
            <table id="Table2" runat="server" style="width: 126%; height: 122px;">
                <tr>
                    <td>
                        <img src="Imagenes/ok.bmp" style="width: 30px;" runat="server" id="IMG2"/><img src="Imagenes/error_visor.png" style="width: 30px;" runat="server" id="IMG5" /><img src="Imagenes/warning.bmp" style="width: 30px;" runat="server"  id="IMG6" />&nbsp;
                        <asp:Label ID="lbResultado" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td >Cód. Instalador:
                        <asp:TextBox ID="txtInstalador" runat="server" CssClass="TextBox2"></asp:TextBox>
                        <img src="Imagenes/lupa.bmp" onclick="popInstalador('ctl00_ContentPlaceHolder1_txtInstalador');"  id="IMG1" />&nbsp;&nbsp;
                        <img src="/ESSBIO_MED/Imagenes/warning.bmp" runat="server"  id="IMG4" />&nbsp;
                        <asp:Label ID="lbTxtIn" runat="server"></asp:Label>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtInstalador" ErrorMessage="Solo números para código de instalador." ValidationExpression="^([0-9]{1,10})$"></asp:RegularExpressionValidator>
                    </td>
                    <td >
                        <asp:Button ID="btnAsignar" runat="server" CssClass="botonnew" OnClick="btnAsignar_Click" Text="Asignar Orden(s)" Height="20px"/>
                        &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnDesAsignar" runat="server" CssClass="botonnew" OnClick="btnDesAsignar_Click" Text="Desasignar Orden(s)" Width="129px" Height="20px"/>
                    </td>
                </tr>

                <tr>
                    <td style="width:900px;" >
                        <asp:Label ID="lbTotal" runat="server"></asp:Label>
                        <asp:Label ID="lbErrorGrilla" runat="server"></asp:Label>
                    </td>
                </tr>

                <tr>
                    <td class="auto-style7" colspan="6">
                        <asp:Panel ID="panGrid" runat="server" Height="326px" HorizontalAlign="Center" ScrollBars="auto"  Width="1650px">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="gridOrden" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" CssClass="GridAlternativeItems" EnableModelValidation="True" ForeColor="#333333" Height="100px" OnPageIndexChanging="gridOrden_PageIndexChanging" OnRowCommand="gridOrden_RowCommand" OnRowDataBound="gridOrden_RowDataBound" PageSize="40" Width="1600px">
                                         
                                         <AlternatingRowStyle BackColor="White" />
                                        <Columns>

                                            <asp:BoundField DataField="ID_ORDEN" HeaderText="idOrden">
                                            <HeaderStyle ForeColor="White" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="NUMERO_ORDEN" HeaderText="Número">
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="ID_SERVICIO" HeaderText="Servicio">
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="CAUSA_CAMBIO" HeaderText="Causa Cambio">
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="CONTRATISTA" HeaderText="Contratista" >
                                                <HeaderStyle ForeColor="White" />
                                                <ItemStyle Font-Size="Smaller"  />
                                            </asp:BoundField>

                                           <asp:BoundField DataField="FECHA_CREACION" HeaderText="Fecha creación" >
                                                <HeaderStyle ForeColor="White" />
                                                <ItemStyle Font-Size="Smaller" Width="60px" />
                                            </asp:BoundField>
                                           
                                            <asp:BoundField DataField="FECHA_INTEGRACION" HeaderText="Fecha ingreso SGM" >
                                                <HeaderStyle ForeColor="White" />
                                                <ItemStyle Font-Size="Smaller" Width="70px" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="dias_transcurridos" HeaderText="Días transcurridos" >
                                                <HeaderStyle ForeColor="White" />
                                                <ItemStyle Font-Size="Smaller" width="50px"  />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="RUTA" HeaderText="Ruta">
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="TIPO_MARCA_DI" HeaderText="Tipo/Marca/Dim." Visible="false">
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="SERIE_MEDIDOR" HeaderText="Serie Med." Visible="false">
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="DIRECCION" HeaderText="Dirección" >
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Width="250px" Font-Size="Smaller" HorizontalAlign="Left"  />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="LOCALIDAD" HeaderText="Localidad" >
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="ID_PROCESO" HeaderText="idProceso" >
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle ForeColor="White" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="GRUPO_PROCESO" HeaderText="Grupo Proceso" visible="false">
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="ID_TIPO_PROCESO" HeaderText="idTipoProceso" >
                                            <HeaderStyle ForeColor="White" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="DETALLE" HeaderText="Tipo Proceso"> 
                                            <HeaderStyle ForeColor="White" Width="200px" />
                                            <ItemStyle Font-Size="Smaller" Width="200px" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="ESTADO" HeaderText="Estado">
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="ID_SINCRONIZACION" HeaderText="id_sincronizacion">
                                            </asp:BoundField>

                                            <asp:BoundField DataField="NOMBRE" HeaderText="Instalador">
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>
                                            
                                            <asp:TemplateField HeaderText="Asignar">
                                                <HeaderTemplate>
                                                    <asp:LinkButton ID="lkbAsignar" runat="server" CommandName="asignar" OnClick="lkbAsignar_Click">Asignar</asp:LinkButton>
                                                </HeaderTemplate>
                                                  <ItemTemplate>
                                                    <asp:CheckBox ID="check_asigna" runat="server" />
                                                </ItemTemplate>
                                                <HeaderStyle ForeColor="White" />
                                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Desasignar">
                                                <HeaderTemplate>
                                                    <asp:LinkButton ID="lkbDesasignar" runat="server" CommandName="desasignar">Desasignar</asp:LinkButton>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chk_des" runat="server" />
                                                </ItemTemplate>
                                                <HeaderStyle ForeColor="White" />
                                            </asp:TemplateField>

                                            <asp:BoundField DataField="DIAS_SLA" HeaderText="DIAS_SLA">
                                            <HeaderStyle ForeColor="White" />
                                            <ItemStyle Font-Size="Smaller" />
                                            </asp:BoundField>
                                            
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
                    <td class="auto-style7">&nbsp;</td>

                </tr>

            </table>
            
            
            
        </ContentTemplate>
    </asp:UpdatePanel>
    
   
    </asp:Content>

