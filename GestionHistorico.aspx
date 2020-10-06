<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="GestionHistorico.aspx.cs" Inherits="GestionHistorico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
    <style type="text/css">
        .button {
            border-style: none;
            border-color: #000000;
            border-width: medium;
            background: #BDBDBD;
            color: #FFFFFF;
            padding: 10px;
            font-size: 12px;
            border-radius: 5px;
            position: relative;
            box-sizing: border-box;
            transition: all 500ms ease;
            text-align: center;
            top: 0px;
            left: 0px;
            height: 30px;
            
        }
            .TextBoxServicio{
                padding: 12px 20px;
                margin: 2px 0;
                display: inline-block;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                height: 4px;
            }

        .TextBox{
                padding: 6px 6px;
                display: inline-block;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                height: 20px;
         }
        .auto-style11 {
            text-align: left;
            height: 23px;
            width: 95px;
        }
        .auto-style19 {
            height: 2px;

        }
        .auto-style23 {
            width: 95px;
        }
        .auto-style24 {
            width: 28px;
        }
        .modal
        {
            position: fixed;
            top: 0;
            left: 0;
            background-color: black;
            z-index: 99;
            opacity: 0.8;
            filter: alpha(opacity=80);
            -moz-opacity: 0.8;
            min-height: 100%;
            width: 100%;
        }
        .loading
        {
            font-family: Arial;
            font-size: 10pt;
            width: 200px;
            height: 100px;
            display: none;
            position: fixed;
            z-index: 999;
        }
    </style>
    
    <script lang="javascript">
        function PopMapa(LAT,LON){
            var url = 'http://maps.googleapis.com/maps/api/staticmap?c&zoom=17&size=600x600&maptype=roadmap&markers=color:blue%7Clabel:S%7C' + LAT + "," + LON;
            open(url, 'Mapa', 'top=30,left=10,width=700,height=700,status=no,resizable=yes');

        }

        function ShowProgress() {
            setTimeout(function () {
                var modal = $('<div />');
                modal.addClass("modal");
                $('body').append(modal);
                var loading = $(".loading");
                loading.show();
                var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
                var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
                loading.css({ top: top, left: left });

                //var millisecondsToWait = 200;
                //setTimeout(function () {
                modal.remove();
                //}, millisecondsToWait);

            }, 100);

            return;
        }
      </script> 

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server" >
    
      <h1 class="WebPartTitle">Gestión Historicos </h1>
          
          <asp:ScriptManager ID="ScriptManager1" runat="server">
          </asp:ScriptManager>
                           
      <asp:UpdatePanel ID="UpdatePanel2" runat="server">
          <ContentTemplate>
              <div  class="loading" align="center">           
                        <img src="Imagenes/loading.gif" alt="" style="vertical-align:middle;width:200px;height:140px;" />
              </div>
              <table style="width:auto;">
                  <tr>
                      <td class="auto-style11">
                          <asp:RadioButton ID="RadioButton1" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="RadioButton1_CheckedChanged" Text="SERVICIO" />
                       </td>
                      <td>   
                          <asp:RadioButton ID="RadioButton2" runat="server" AutoPostBack="True" OnCheckedChanged="RadioButton2_CheckedChanged" Text="NUMERO ORDEN" />
                      </td>
                 </tr>
                  <tr>
                      <td colspan="3" class="auto-style9">

                          <asp:TextBox ID="txtServ" runat="server" CssClass="TextBox"></asp:TextBox>
                          <asp:LinkButton ID="LinkButton1" CssClass="button" OnClientClick="return ShowProgress();" runat="server" OnClick="LinkButton1_Click">Ver Servicio</asp:LinkButton>
                      </td>
                  </tr>
                  </tr>

                  <tr>
                      <td  colspan="4">&nbsp;</td>
                  </tr>

                  <tr>
                      <td  colspan="4">
                          <asp:Label ID="Label11" class="WebPartTitle" runat="server" Text="Información del Cliente"></asp:Label>
                      </td>
                  </tr>

                  <tr>
                      <td class="auto-style23">
                          <asp:Label ID="Label2" runat="server" Text="Nombre Cliente:"></asp:Label>
                      </td>
                      <td class="auto-style19">
                          <asp:TextBox ID="txtCliente" runat="server" Width="328px" CssClass="TextBox"></asp:TextBox>
                          <asp:Label ID="Label3" runat="server" Text="Dirección:"></asp:Label>&nbsp;&nbsp;
                          <asp:TextBox ID="txtDireccion" runat="server" Width="328px" CssClass="TextBox"></asp:TextBox>
                      </td>
                  </tr>
                  <tr>
                      <td class="auto-style23">
                          <asp:Label ID="Label4" runat="server" Text="Medidor:"></asp:Label>
                      </td>
                      <td>
                          <asp:TextBox ID="txtMedidor" runat="server" Width="328px" CssClass="TextBox"></asp:TextBox>
                          <asp:Label ID="Label8" runat="server" Text="Marca:"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          <asp:TextBox ID="txtMarca" runat="server" Width="328px" CssClass="TextBox"></asp:TextBox>
                      </td>

                  </tr>
                  <tr>
                      <td class="auto-style23">
                          <asp:Label ID="Label5" runat="server" Text="Diametro Medidor:"></asp:Label>
                      </td>
                      <td>
                          <asp:TextBox ID="txtDiametro" runat="server" Width="328px" CssClass="TextBox"></asp:TextBox>
                          <asp:Label ID="Label9" runat="server" Text="Localidad:"></asp:Label>&nbsp;&nbsp;
                          <asp:TextBox ID="txtLocalidad" runat="server" Width="328px" CssClass="TextBox"></asp:TextBox>
                      </td>
                  </tr>
                  <tr>
                      <td class="auto-style23">
                          <asp:Label ID="Label10" runat="server" Text="Ruta:"></asp:Label>
                      </td>
                      <td>
                          <asp:TextBox ID="txtRuta" runat="server" Width="328px" CssClass="TextBox"></asp:TextBox>
                          <asp:Label ID="Label12" runat="server" Text="Contratista:"></asp:Label>
                          <asp:TextBox ID="txtContratista" runat="server" CssClass="TextBox" Width="328px"></asp:TextBox>
                      </td>
                      <td class="auto-style5">&nbsp;</td>
                      <td class="auto-style24">&nbsp;</td>
                  </tr>

                  <tr>
                      <td colspan="4">
                          <asp:Label ID="lbTotal" runat="server"></asp:Label>
                      </td>
                  </tr>
              </table>
              <asp:Panel ID="panGrid" runat="server" Height="230px" HorizontalAlign="Center"  Width="1749px" ScrollBars="Auto">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="gridOrden" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" CssClass="GridAlternativeItems" DataKeyNames="ID_SERVICIO" EnableModelValidation="True" ForeColor="#333333" Height="100px" OnPageIndexChanging="gridOrden_PageIndexChanging" OnSelectedIndexChanged="gridOrden_SelectedIndexChanged" PageSize="40" Width="2082px" OnRowDeleting="gridOrden_RowDeleting" OnRowDataBound="gridOrden_RowDataBound">
                                <AlternatingRowStyle BackColor="White" />
                                <Columns>

                                    <asp:BoundField DataField="VISITA" HeaderText="Visita">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>

                                    <asp:BoundField DataField="NUMERO_ORDEN" HeaderText="N° Orden">
                                    <HeaderStyle ForeColor="White" Width="50px" />
                                    <ItemStyle Width="10px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="GRUPO_PROCESO" HeaderText="Grupo Proceso">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>

                                    <asp:CommandField ButtonType="Image" DeleteImageUrl="~/Imagenes/hoja.gif" HeaderText="Detalle" ShowDeleteButton="True">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:CommandField>

                                    <asp:TemplateField HeaderText="Mapa">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btMapa" runat="server" Height="29px" ImageUrl="~/Imagenes/mapa.png" Width="29px" />
                                        </ItemTemplate>
                                        <HeaderStyle ForeColor="White" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Fotografía">
                                        <ItemTemplate>
                                            <asp:Image ID="imgOk" runat="server" ImageUrl="~/Imagenes/ok.bmp" Visible="False" />
                                            <asp:Image ID="imgCru" runat="server" ImageUrl="~/Imagenes/cross2.bmp" Visible="False" />
                                        </ItemTemplate>
                                        <HeaderStyle ForeColor="White" />
                                        <ItemStyle HorizontalAlign="Center" Width="50px" />
                                    </asp:TemplateField>

                                    <asp:CommandField ButtonType="Image" HeaderText="Ver Fotos" SelectImageUrl="~/Imagenes/lupa.bmp" ShowSelectButton="True">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:CommandField>
                                    
                                    <asp:BoundField DataField="ORDEN_ESTATUS" HeaderText="Estatus Orden">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CAMBIO_CAUSA" HeaderText="Causa">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="OBSERVACION_IN" HeaderText="Observación" ItemStyle-Width="200px">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ESTATUS_MEDIDOR" HeaderText="Estatus Medidor">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="MARCA" HeaderText="Marca" Visible="false" >
                                        <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="LECTURA_RET" HeaderText="Lectura Retiro">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="DIAMETRO_RET" HeaderText="Diametro Retiro" Visible="false">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ANO_MN" HeaderText="Año Med. Nu." Visible="false">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="LECTURA_MN" HeaderText="Lectura Nuevo">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="MATERIAL_VARAL" HeaderText="Material Varal">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="TIPO_LLAVE_PASO" HeaderText="Tipo Llave">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="NUM_SELLO" HeaderText="Num. Sello">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="COLOR_SELLO" HeaderText="Color Sello">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="DETALLE" HeaderText="Tipo Proceso">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="NOMBRE" HeaderText="Operador">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="VARAL_ESTATUS" HeaderText="Estatus Varal" Visible="false" >
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="LLAVE_ESTATUS" HeaderText="Estatus Llave" Visible="false">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="FECHA_CREACION" HeaderText="Fecha Generación" DataFormatString="{0:d}">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="FECHA_INST" HeaderText="Fecha Ejecución" DataFormatString="{0:d}">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="COD_INSTALADOR" HeaderText="codInstalador" />
                                    <asp:BoundField DataField="ID_ORDEN" HeaderText="idOrden">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ID_PROCESO" HeaderText="idProceso">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ID_SERVICIO" HeaderText="idServicio" />
                                    <asp:BoundField DataField="ID_TIPO_PROCESO" HeaderText="idTipoProceso">
                                    <HeaderStyle ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField ControlStyle-Width="0px" DataField="X" HeaderText="X">
                                    <ControlStyle Width="0px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Y" HeaderText="Y" />
                                    <asp:BoundField DataField="ID_SINCRONIZACION" HeaderText="idSincronizacion" />
                                </Columns>
                                <EditRowStyle BackColor="#2461BF" />
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center"/>
                                <RowStyle BackColor="#EFF3FB" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </asp:Panel>
          </ContentTemplate>
      </asp:UpdatePanel>
</asp:Content>

