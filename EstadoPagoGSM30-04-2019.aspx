<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/menu.master" CodeFile="EstadoPagoGSM.aspx.cs" Inherits="EstadoPagoGSM" %>

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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1 class="WebPartTitle">Estado Pago SGM</h1>

        <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>

            <table id="tablaAsig" style="width: 126%; height: 122px;">
                <tr>
                    <td class="auto-style70"></td>
                    <td class="auto-style89"></td>
                
                    <td class="auto-style86"></td>
                    <td class="auto-style67">&nbsp;</td>
                    <td class="auto-style94"></td>
                </tr>
                <tr>
                    <td class="auto-style71"></td>
                    <td class="auto-style74">
                        </td>
                    <td class="auto-style81">&nbsp;&nbsp;</td>
                    <td class="auto-style85">&nbsp;&nbsp;</td>
                    <td class="auto-style24">&nbsp;</td>
                    <td class="auto-style55"></td>
                </tr>
                <tr>                   
                  
                    <td class="auto-style67">&nbsp;&nbsp;</td>
                    <td class="auto-style56"></td>
                </tr>
                <tr>
                    <td class="auto-style72">Desde:
                        </td>
                    <td class="auto-style89">
                       <asp:TextBox ID="txtDesde" runat="server" CssClass="TextBox3" Width="134px"></asp:TextBox>
                        <img src="Imagenes/calendario.gif" onclick="openCalendar('ctl00_ContentPlaceHolder1_txtDesde');"  id="IMG3" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Debe Ingresar Una Fecha" ControlToValidate="txtDesde"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtDesde" ErrorMessage="Error formato fecha." ValidationExpression="(0[1-9]|[12][0-9]|3[01])[- -.](0[1-9]|1[012])[- -.](19|20)\d\d"></asp:RegularExpressionValidator>
                    </td>                 
                    
                    
                    <td class="auto-style69"></td>
                </tr>
                <tr>
                    <td class="auto-style72"> Hasta: </td>
                    <td class="auto-style89">
                     <asp:TextBox ID="txtHasta" runat="server" CssClass="TextBox3" Width="134px"></asp:TextBox>
                        <img src="Imagenes/calendario.gif" onclick="openCalendar('ctl00_ContentPlaceHolder1_txtHasta');"  id="IMG9" />
                       <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Debe Ingresar Una Fecha" ControlToValidate="txtHasta"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtHasta" ErrorMessage="Error formato fecha." ValidationExpression="(0[1-9]|[12][0-9]|3[01])[- -.](0[1-9]|1[012])[- -.](19|20)\d\d"></asp:RegularExpressionValidator>
                    </td>
                  
                    <td class="auto-style69"></td>
                </tr>
               <%--   <tr>
                    <td class="auto-style72"> Sin Procesar: <asp:checkbox id="chkSinPro" runat="server"></asp:checkbox> </td>
                    <td class="auto-style89">
                    
                    </td>
                  
                    <td class="auto-style69"></td>
                </tr>--%>

                <tr>
                    <td colspan="3" class="auto-style83"><asp:Button ID="Button1" runat="server" CssClass="botonnew" OnClick="Button1_Click1" Text="FILTRAR" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Button ID="Button2" runat="server" CssClass="botonnew" Text="Exportar Excel" OnClick="Button2_Click1" />    </td>
                </tr>              
                <tr>
                    <td class="auto-style43" colspan="5">
                        <asp:Label ID="lbTotal" runat="server"></asp:Label>
                        <%--<asp:Label ID="lbErrorGrilla" runat="server"></asp:Label>--%>
                    </td>
                    <td class="auto-style43"></td>
                    <td class="auto-style39" style="width: 268434960px">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style7" colspan="4">                       
                        <asp:Panel ID="panGrid" runat="server" Height="326px" HorizontalAlign="Center" ScrollBars="Auto" Width="1250px">            
                                    <asp:GridView ID="gridEstadoPago" runat="server" AllowPaging="false" AutoGenerateColumns="false" CellPadding="1"  EnableModelValidation="false"  Height="100px"   CssClass="GridAlternativeItems"    ForeColor="#333333"  PageSize="10" Width="1319px">
                                        <AlternatingRowStyle BackColor="White" />                                 
                                       <Columns>
                                         <asp:BoundField HeaderText="REGION"	        DataField="REGION"/>
                                         <asp:BoundField HeaderText="ZONA"	            DataField="ZONA"/>
                                         <asp:BoundField HeaderText="LOCALIDAD"     	DataField="LOCALIDAD"/>	
                                         <asp:BoundField HeaderText="DIRECCION"	        DataField="DIRECCION"/>	
                                         <asp:BoundField HeaderText="CLIENTE"	        DataField="CLIENTE"/>
                                         <asp:BoundField HeaderText="ORDEN"         	DataField="ID_ORDEN"/>
                                         <asp:BoundField HeaderText="NUMERO ORDEN"	    DataField="NUMERO_ORDEN"/>
                                         <asp:BoundField HeaderText="SERVICIO"      	DataField="ID_SERVICIO"/>
                                         <asp:BoundField HeaderText="LECTURA RET"   	DataField="LECTURA_RET"/>
                                         <asp:BoundField HeaderText="DIAMETRO RET"  	DataField="DIAMETRO_RET"/>
                                         <asp:BoundField HeaderText="ANO MN"        	DataField="ANO_MN"/>	
                                         <asp:BoundField HeaderText="NUMERO MN"     	DataField="NUMERO_MN"/>	
                                         <asp:BoundField HeaderText="DIAMETRO NU"   	DataField="DIAMETRO_NU"/>
                                         <asp:BoundField HeaderText="LECTURA MN"    	DataField="LECTURA_MN"/>	
                                         <asp:BoundField HeaderText="MATERIAL VARAL"	DataField="MATERIAL_VARAL"/>	
                                         <asp:BoundField HeaderText="TIPO LLAVE PASO"	DataField="TIPO_LLAVE_PASO"/>
                                         <asp:BoundField HeaderText="NUM SELLO"     	DataField="NUM_SELLO"/>	
                                         <asp:BoundField HeaderText="COLOR SELLO"   	DataField="COLOR_SELLO"/>
                                         <asp:BoundField HeaderText="RUT CLIENTE"   	DataField="RUT_CLIENTE"/>
                                         <asp:BoundField HeaderText="OBSERVACION OUT"	DataField="OBSERVACION_OUT"/>
                                         <asp:BoundField HeaderText="FECHA CREACION"	DataField="FECHA_CREACION"/>	
                                         <asp:BoundField HeaderText="FECHA INST"    	DataField="FECHA_INST"/>                                       
                                         <asp:BoundField HeaderText="RUTA"	            DataField="RUTA"/>
                                         <asp:BoundField HeaderText="COD INSTALADOR"	DataField="COD_INSTALADOR"/>	
                                         <asp:BoundField HeaderText="TIPO MARCA DI"	    DataField="TIPO_MARCA_DI"/>	
                                         <asp:BoundField HeaderText="ORDEN ESTATUS"	    DataField="ORDEN_ESTATUS"/>	
                                         <asp:BoundField HeaderText="ESTATUS MEDIDOR"	DataField="ESTATUS_MEDIDOR"/>
                                         <asp:BoundField HeaderText="MARCA"	            DataField="MARCA"/>	
                                         <asp:BoundField HeaderText="VARAL ESTATUS"	    DataField="VARAL_ESTATUS"/>		
                                         <asp:BoundField HeaderText="LLAVE ESTATUS"	    DataField="LLAVE_ESTATUS"/>	
                                         <asp:BoundField HeaderText="CAMBIO CAUSA"	    DataField="CAMBIO_CAUSA"/>
                                         <asp:BoundField HeaderText="TIPO EVENTO"	    DataField="TIPO_EVENTO"/>	
                                         <asp:BoundField HeaderText="NOMBRE"	        DataField="NOMBRE"/>
                                         <asp:BoundField HeaderText="PROCESO"	        DataField="ID_PROCESO"/>	
                                         <asp:BoundField HeaderText="GRUPO PROCESO"	    DataField="GRUPO_PROCESO"/>	
                                         <asp:BoundField HeaderText="TIPO PROCESO"	    DataField="ID_TIPO_PROCESO"/>
                                         <asp:BoundField HeaderText="DETALLE"	        DataField="DETALLE"/>
                                         <asp:BoundField HeaderText="OBSERVACION 1"	    DataField="OBSERVACION_IN"/>	
                                         <asp:BoundField HeaderText="OBSERVACION 2"	    DataField="OBSERVACION_OUT2"/>                                       	
                                         <asp:BoundField HeaderText="SERIE MEDIDOR"	    DataField="SERIE_MEDIDOR"/>	
                                         <asp:BoundField HeaderText="IMPROCEDENCIA"	    DataField="COD_IMPROCEDENCIA"/>	
                                         <asp:BoundField HeaderText="DIAMETRO MEDIDOR"  DataField="DIAMETRO_MEDIDOR"/>
                                         <asp:BoundField HeaderText="FABRICANTE"        DataField="FABRICANTE"/>	
                                         <asp:BoundField HeaderText="SINCRONIZACION"	DataField="ID_SINCRONIZACION"/>	
                                         <asp:BoundField HeaderText="VISITA"	        DataField="VISITA"/>                                    
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
                    <td class="auto-style7" style="width: 268434960px">&nbsp; </td>
                </tr>
                <tr>                   
                    <td class="auto-style40">&nbsp;</td>
                </tr>
                <tr>
                
                    <td class="auto-style88">&nbsp;</td>
                    <td class="auto-style24">
                        &nbsp;
                        
                    </td>
                    <td class="auto-style24">&nbsp;</td>
                </tr>
            </table>
    </asp:Content>

