<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/menu.master" CodeFile="InformeEfectividad.aspx.cs" Inherits="EstadoPagoGSM" %>

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
    <h1 class="WebPartTitle">INFORME EFECTIVIDAD</h1>

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
                               <tr>
                    <td class="auto-styleTD">
                        Región:</td>
                    <td colspan="3">
                        <asp:DropDownList ID="ddRegion" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddRegion_SelectedIndexChanged" Width="300px">
                        </asp:DropDownList>
                    </td>
                    <td></td>
                </tr>           
             
                     <tr>
                    <td class="auto-styleTD">
                        <asp:Label ID="Label1" runat="server" Text="Zona:"></asp:Label>
                    </td>
                    <td class="auto-style20" colspan="3">
                        <asp:DropDownList ID="ddZona" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddZona_SelectedIndexChanged" Width="300px">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style20"></td>
                </tr>
                     <tr>
                    <td class="auto-styleTD">
                        <asp:Label ID="Label4" runat="server" Text="Localidad:"></asp:Label>
                    </td>
                    <td colspan="3" class="auto-style20">
                        <asp:DropDownList ID="ddLocalidad" runat="server" AutoPostBack="True" CssClass="ComboBox" OnSelectedIndexChanged="ddLocalidad_SelectedIndexChanged" Width="300px">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style20"></td>
                </tr>
                    <tr>
                    <td class="auto-styleTD">
                        <asp:Label ID="Label2" runat="server" Text="Trabajador:"></asp:Label>
                    </td>
                    <td colspan="3" class="auto-style20">
                        <asp:DropDownList ID="ddlTrabajador" runat="server"  CssClass="ComboBox"  Width="300px">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style20"></td>
                </tr>
                 <tr>
                                                <td class="auto-styleTD">
                        <asp:Label ID="Label3" runat="server" Text="Contratista:"></asp:Label>
                    </td>
                   <td style="text-align: left;">
                  <asp:DropDownList ID="combo_contratista" runat="server" CssClass="ComboBox" Width="300px">
                    </asp:DropDownList></td>
                   <td></td>                                            
                                             
             </tr>
             <tr>
               <td class="auto-style10">
                        <asp:Label ID="Label5" runat="server" Text="Tipo de Proceso:"></asp:Label>
                    </td>
                   <td style="text-align: left;" class="auto-style10">
                  <asp:DropDownList ID="ddlProceso" runat="server" CssClass="ComboBox" Width="300px">
                    </asp:DropDownList></td>
                   <td class="auto-style10"></td>                                            
                                             
             </tr>
          

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
                                    <asp:GridView ID="gridEstadoPago" runat="server" AutoGenerateColumns="False" CellPadding="10"   Height="100px"   CssClass="GridAlternativeItems"    ForeColor="#333333" Width="1319px">
                                        <AlternatingRowStyle BackColor="White" />                                 
                                        <Columns>
                                         <asp:BoundField HeaderText="N° ORDEN"	        DataField="NUMERO_ORDEN" />
                                         <asp:BoundField HeaderText="SERVICIO"	        DataField="ID_SERVICIO"/>
                                         <asp:BoundField HeaderText="FECHA CREACION"    DataField="FECHA_CREACION"/>	
                                         <asp:BoundField HeaderText="RUTA"              DataField="RUTA" />
                                         <asp:BoundField HeaderText="REGION"	        DataField="REGION"/>
                                         <asp:BoundField HeaderText="LOCALIDAD"         DataField="LOCALIDAD"/>
                                         <asp:BoundField HeaderText="ZONA"	            DataField="ZONA"/>
                                         <asp:BoundField HeaderText="CODIGO RESULTADO"  DataField="CODIGO_RESULTADO" ItemStyle-Width="12%"/>
                                         <asp:BoundField HeaderText="LECTURA RETIRO"   	DataField="LECTURA_RETIRO"/>
                                         <asp:BoundField HeaderText="DIAMETRO MEDIDOR RETIRADO"  	DataField="DIAMETRO_MEDIDOR_RETIRADO"/>
                                         <asp:BoundField HeaderText="MARCA MEDIDOR NUEVO"        	DataField="MARCA_MEDIDOR_NUEVO">
                                         <HeaderStyle  Width="30%" HorizontalAlign="Left" />
                                         <ItemStyle Width="20%" />
                                        </asp:BoundField> 	
                                         <asp:BoundField HeaderText="AÑO MEDIDOR NUEVO"     	DataField="ANO_MEDIDOR_NUEVO"/>	
                                         <asp:BoundField HeaderText="SERIE MEDIDOR NUEVO"   	DataField="SERIE_MEDIDOR_NUEVO"/>
                                         <asp:BoundField HeaderText="DIAMETRO MEDIDOR NUEVO"    	DataField="DIAMETRO_MEDIDOR_NUEVO"/>	
                                         <asp:BoundField HeaderText="LECTURA MEDIDOR NUEVO"	DataField="LECTURA_MEDIDOR_NUEVO"/>	
                                         <asp:BoundField HeaderText="FECHA EJECUCION"	DataField="FECHA_EJECUCION"/>
                                         <asp:BoundField HeaderText="HORA EJECUCION"     	DataField="HORA_EJECUCIOn"/>	
                                         <asp:BoundField HeaderText="CODIGO CONTRATISTA"   	DataField="CODIGO_CONTRATISTA"/>
                                         <asp:BoundField HeaderText="CAUSA CAMBIO"   	DataField="CAUSA_CAMBIO"/>
                                         <asp:BoundField HeaderText="RESULTADO"	        DataField="RESULTADO"/>
                                         <asp:BoundField HeaderText="CODIGO VARAL"	    DataField="CODIGO_VARAL"/>	
                                         <asp:BoundField HeaderText="MATERIAL_VARAL"    DataField="MATERIAL_VARAL"/>                                       
                                         <asp:BoundField HeaderText="DESCRIPCION"	    DataField="DESCRIPCION"/>
                                         <asp:BoundField HeaderText="DETALLE"	        DataField="DETALLE"/>	
                                         <asp:BoundField HeaderText="RUT CLIENTE"	    DataField="RUT_CLIENTE"/>	
                                         <asp:BoundField HeaderText="OBSERVACION"	    DataField="OBSERVACION"/>	
                                         <asp:BoundField HeaderText="CODIGO INSTALADOR"	DataField="CODIGO_INSTALADOR"/>
                                         <asp:BoundField HeaderText="TIPO DE PROCESO"	            DataField="TIPO_PROCESO"/>	
                                         <asp:BoundField HeaderText="NOMBRE CONTRATISTA"	    DataField="NOMBRE_CONTRA"/>
                                         <asp:BoundField HeaderText="MOTIVO CAMBIO MEDIDOR"	    DataField="MOTIVO_CAMBIO"/>
                                       	
                                        <%--  <asp:BoundField HeaderText="LLAVE ESTATUS"	    DataField="LLAVE_ESTATUS"/>	
                                         <asp:BoundField HeaderText="CAMBIO CAUSA"	    DataField="CAMBIO_CAUSA"/>
                                         <asp:BoundField HeaderText="TIPO EVENTO"	    DataField="TIPO_EVENTO"/>	
                                         <asp:BoundField HeaderText="NOMBRE"	        DataField="NOMBRE"/>
                                         <asp:BoundField HeaderText="PROCESO"	        DataField="ID_PROCESO"/>	
                                         <asp:BoundField HeaderText="GRUPO PROCESO"	    DataField="GRUPO_PROCESO"/>	
                                         <asp:BoundField HeaderText="TIPO PROCESO"	    DataField="ID_TIPO_PROCESO"/>
                                         <asp:BoundField HeaderText="DETALLE"	        DataField="DETALLE"/>
                                         <asp:BoundField HeaderText="OBSERVACION 1"	    DataField="OBSERVACION_IN"/>	
                                         <asp:BoundField HeaderText="OBSERVACION 2"	    DataField="OBSERVACION_OUT"/>                                       	
                                         <asp:BoundField HeaderText="SERIE MEDIDOR"	    DataField="SERIE_MEDIDOR"/>	
                                         <asp:BoundField HeaderText="IMPROCEDENCIA"	    DataField="COD_IMPROCEDENCIA"/>	
                                         <asp:BoundField HeaderText="DIAMETRO MEDIDOR"  DataField="DIAMETRO_MEDIDOR"/>
                                         <asp:BoundField HeaderText="FABRICANTE"        DataField="FABRICANTE"/>	
                                         <asp:BoundField HeaderText="SINCRONIZACION"	DataField="ID_SINCRONIZACION"/>	
                                         <asp:BoundField HeaderText="VISITA"	        DataField="VISITA"/>                   --%>                 
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

