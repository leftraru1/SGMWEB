<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FormularioORDENHistorico.aspx.cs" Inherits="FormularioORDENHistorico" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>

    <link href="estilos/texto.css" rel="stylesheet" />
    <link href="estilos/tabla.css" rel="stylesheet" />
    <link href="estilos/grid.css" rel="stylesheet" />
    <link href="estilos/webpart.css" rel="stylesheet" />
    <link href="estilos/calendario.css" rel="stylesheet" />
    <link href="estilos/controls.css" rel="stylesheet" />    
    <link href="estilos/formulario.css" rel="stylesheet" />
    
    <script src = " https://unpkg.com/sweetalert/dist/sweetalert.min.js "></script> 
    <style type="text/css">
        #form1 {
            width: auto;
        }

        .auto-style7 {
            height: 18px;
        }

        .auto-style11 {
            width: 1000px;
        }

        .auto-style24 {
            text-align: right;
            height: 19px;
        }

        .auto-style28 {
            height: 30px;
            text-align: center;
        }

        .auto-style59 {
            height: 19px;
            width: 143px;
        }

        .auto-style73 {
            padding: 15px;
            border-right: 2px solid #9aaabb;
            border-top: 1px solid #cccccc;
            MARGIN-TOP: 8px;
            FONT-SIZE: 11px;
            BORDER-LEFT: #cccccc 1px solid;
            LINE-HEIGHT: 15px;
            BORDER-BOTTOM: #9aaabb 2px solid;
            BACKGROUND-COLOR: #f5f5f5;
            width: 999px;
            margin-right: 467px;
            height: 709px;
        }

        .auto-style95 {
            padding: 15px;
            border-right: 2px solid #9aaabb;
            border-top: 1px solid #cccccc;
            MARGIN-TOP: 8px;
            FONT-SIZE: 11px;
            BORDER-LEFT: #cccccc 1px solid;
            LINE-HEIGHT: 15px;
            BORDER-BOTTOM: #9aaabb 2px solid;
            BACKGROUND-COLOR: #f5f5f5;
            width: 1000px;
            margin-right: 467px;
            height: 801px;
        }

        .auto-style96 {
            width: 100%;
            height: 48px;
        }
        .auto-style961 {
            width: 100%;
            height: 48px;
        }
        
        .auto-style101 {
            text-align: right;
            height: 5px;
            width: 100px;
        }

        .auto-style109 {
            padding: 15px;
            border-right: 2px solid #9aaabb;
            border-top: 1px solid #cccccc;
            MARGIN-TOP: 8px;
            FONT-SIZE: 11px;
            BORDER-LEFT: #cccccc 1px solid;
            LINE-HEIGHT: 15px;
            BORDER-BOTTOM: #9aaabb 2px solid;
            BACKGROUND-COLOR: #f5f5f5;
            width: 999px;
            margin-right: 467px;
            height: 230px;
        }

        .auto-style125 {
            text-align: right;
            height: 19px;
            width: 271px;
        }

        .auto-style126 {
            height: 30px;
            text-align: center;
            width: 400px;
        }

        .auto-style135 {
            text-align: right;
            height: 15px;
        }

        .auto-style160 {
            width: 19px;
            height: 19px;
        }

        .auto-style209 {
            height: 39px;
            text-align: center;
        }

        .auto-style223 {
            width: 150px;
        }

        .auto-style236 {
            height: 20px;
        }

        .auto-style271 {
            height: 18px;
            width: 143px;
        }
        .auto-style272 {
            text-align: right;
            height: 18px;
            width: 100px;
        }
        .auto-style278 {
            height: 19px;
        }
        .auto-style280 {
            text-align: right;
            height: 18px;
            }
        .auto-style281 {
            text-align: right;
            height: 19px;
            width: 200px;
        }
        .auto-style282 {
            text-align: right;
            height: 19px;
            width: 100px;
        }
        .auto-style283 {
            width: 100px;
        }
        .auto-style284 {
            text-align: right;
            height: 19px;
            width: 150px;
        }
        .auto-style286 {
            height: 19px;
            width: 100px;
        }
        .auto-style291 {
            text-align: right;
            height: 5px;
        }
        .auto-style292 {
            height: 19px;
            width: 200px;
        }
        .auto-style293 {
            height: 10px;
            text-align: center;
        }
        .auto-style295 {
            height: 19px;
            width: 150px;
        }
        .auto-style970 {
            width: 15%;
            text-align: left;
            color: black;
            height: 20px;
        }
        .auto-style971 {
            width: 22%;
            text-align: left;
            color: darkslategray;
            height: 20px;
        }
        .auto-style972 {
            width: 143px;
        }
        .auto-style973 {
            text-align: right;
            height: 30px;
        }
        .auto-style974 {
            height: 26px;
        }
        </style>

    <script type="text/javascript">

        function mensaje_ok(title, msg) {
            swal(title, msg, "success");
        }

        function mensaje_ok2(msg) {
            swal("ÉXITO!", msg, "success");
        }

        function mensaje_error(msg) {
            swal("¡ERROR! ", msg, "warning");
        }
        
    </script>

</head>
<body style="height: 100%; width:100%">
    <form id="form1" runat="server" class="auto-style11" enctype="multipart/form-data">

        <div class="auto-style109" id="datos" runat="server" visible="True">
            <asp:Panel ID="header" runat="server" Height="230px" ScrollBars="Auto">
                
                <table class="auto-style96">
                    <tr style="width:100%;">
                        <td class="td_title" colspan="8">
                            ~FORMULARIO WEB - ORDEN SUSTITUCIÓN DE MEDIDOR~</td>
                    </tr>
                    <tr>
                        <td class="margen_izq">&nbsp;</td>
                        <td class="td_label">
                            &nbsp;</td>
                        <td class="puntos">&nbsp;</td>
                        <td class="td_field">
                            &nbsp;</td>
                        <td class="td_label">
                            &nbsp;</td>
                        <td class="puntos">&nbsp;</td>
                        <td class="td_field">
                            &nbsp;</td>
                        <td class="margen_der">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="margen_izq"></td>
                        <td class="td_label">
                            <asp:Label ID="lbl_servicio" runat="server" Font-Bold="True" Text="Servicio"></asp:Label>
                        </td>
                        <td class="puntos">:</td>
                        <td class="td_field">
                            <asp:Label ID="lb_servicio" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" ForeColor="#336699"></asp:Label>
                            &nbsp;</td>
                        <td class="td_label">
                            <asp:Label ID="lbl_fecha_ODS" runat="server" Font-Bold="True" Text="Fecha Ceacion ODS"></asp:Label>
                        </td>
                        <td class="puntos">:</td>
                        <td class="td_field">
                            <asp:Label ID="lb_fecha" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" ForeColor="#336699"></asp:Label>
                        </td>
                        <td class="margen_der"></td>
                    </tr>
                    <tr>
                        <td class="auto-style236"></td>
                        <td class="auto-style970">
                            <asp:Label ID="lbl_nro_orden" runat="server" Font-Bold="True" Text="Orden"></asp:Label>
                        </td>
                        <td class="auto-style236">:</td>
                        <td class="auto-style971">
                            <asp:Label ID="lb_nro_orden" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" ForeColor="#336699"></asp:Label>
                        </td>
                        <td class="auto-style970">
                            <asp:Label ID="lbl_ruta_lectura" runat="server" Font-Bold="True" Text="Ruta Lectura"></asp:Label>
                        </td>
                        <td class="auto-style236">:</td>
                        <td class="td_field">
                            <asp:Label ID="lb_ruta_lectura" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" ForeColor="#336699"></asp:Label>
                        </td>
                        <td class="auto-style236"></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td class="td_label">
                            <asp:Label ID="lbl_nombre_cliente" runat="server" Font-Bold="True" Text="Nombre Cliente"></asp:Label>
                        </td>
                        <td>:</td>
                        <td class="td_field">
                            <asp:Label ID="lb_nombre_cliente" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" ForeColor="#336699"></asp:Label>
                        </td>
                        <td class="td_label">
                            <asp:Label ID="lbl_visita" runat="server" Font-Bold="True" Text="Visita"></asp:Label>
                        </td>
                        <td>:</td>
                        <td class="td_field">
                            <asp:Label ID="lb_visita" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" ForeColor="#336699"></asp:Label>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td></td>
                        <td class="td_label">
                            <asp:Label ID="lbl_causa_cambio" runat="server" Font-Bold="True" Text="Causa Cambio"></asp:Label>
                        </td>
                        <td>:</td>
                        <td class="td_field">
                            <asp:Label ID="lb_causa_cambio" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" ForeColor="#336699"></asp:Label>
                        </td>
                        <td class="td_label">
                            <asp:Label ID="lbl_localidad" runat="server" Font-Bold="True" Text="Localidad"></asp:Label>
                        </td>
                        <td>:</td>
                        <td class="td_field">
                            <asp:Label ID="lb_localidad" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" ForeColor="#336699"></asp:Label>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td class="td_label">
                            <asp:Label ID="lbl_fonos" runat="server" Font-Bold="True" Text="Dirección"></asp:Label>
                        </td>
                        <td>:</td>
                        <td class="td_field" colspan="4">
                            <asp:Label ID="lb_direccion" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" ForeColor="#336699"></asp:Label>
                            
                           
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td colspan="5" rowspan="2">
                            <asp:Label ID="lb_cod_inspector" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" ForeColor="#336699" Visible="False"></asp:Label>
                            <asp:Label ID="lb_hoy" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" ForeColor="#336699" Visible="False"></asp:Label>
                            <asp:Label ID="lb_id_usuario" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" ForeColor="#336699" Visible="False"></asp:Label>
                            <asp:Label ID="lb_id_perfil" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" ForeColor="#336699" Visible="False"></asp:Label>
                            <asp:Label ID="lb_id_proceso" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" ForeColor="#336699" Visible="False"></asp:Label>
                            <asp:Label ID="lb_avance" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                        </td>
                        <td colspan="2" rowspan="2" style="text-align: right">
                            <asp:Button ID="btn_enviar_otro" runat="server" CssClass="button1" Font-Bold="True" ForeColor="White"  Text="TRASPASAR INFORMACIÓN" Width="210px" OnClick="btn_enviar_otro_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style974"></td>
                    </tr>
                   
                </table>
            </asp:Panel>
        </div>
        
        <div class="auto-style109" id="traspaso_info" runat="server" visible="False">
            <asp:Panel ID="Panel1" runat="server" Height="200px" ScrollBars="Auto">
                
                <table class="auto-style961">
                    <tr>
                        <td class="td_subtitle" colspan="3">
                            ~TRASPASO DE INFORMACIÓN ENTRE REGISTROS~</td>
                    </tr>
                    <tr>
                        <td class="td_subtitle_mid">
                            INGRESE EL NÚMERO DE ORDEN DE DESTINO</td>
                        <td class="td_subtitle_mid" colspan="2">
                            INGRESE EL ID SERVICIO DE DESTINO</td>
                    </tr>
                    <tr>
                        <td class="td_subtitle_mid">
                            <asp:TextBox ID="tb_nueva_orden" runat="server" Height="20px" MaxLength="12" Width="145px"></asp:TextBox>
                        </td>
                        <td class="td_subtitle_mid" colspan="2">
                            <asp:TextBox ID="tb_nuevo_servicio" runat="server" Height="20px" MaxLength="12" Width="145px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_subtitle_mid" colspan="3">&nbsp;</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td style="width:25%; text-align:center;">
                            <asp:Button ID="btn_traspasar_informacion" runat="server"  Font-Bold="True" ForeColor="White" Height="40px" OnClientClick="return confirm('¿Está seguro de continuar?');" Text="REALIZAR TRASPASO" Width="210px" CssClass="button1" OnClick="btn_traspasar_informacion_Click" />
                        </td>
                        <td style="width:25%; text-align:right;">
                            <asp:Button ID="btn_volver_formulario" runat="server"  Font-Bold="True" ForeColor="White" Height="40px" Text="VOLVER" Width="100px" CssClass="button1" OnClick="btn_volver_formulario_Click" />
                        </td>
                    </tr>
                   
                </table>
            </asp:Panel>
        </div>

        <div class="auto-style95" id="formulario" runat="server">
            <asp:Panel ID="mi_formulario" runat="server" Height="800px" ScrollBars="Auto">
                <table class="auto-style96">
                    <tr>
                        <td class="td_subtitle" colspan="9">
                            ~ANTECEDENTES MEDIDOR RETIRADO~</td>
                    </tr>
                    <tr runat="server">
                        <td class="auto-style281">
                            &nbsp;</td>
                        <td class="auto-style292">
                            &nbsp;</td>
                        <td class="auto-style282">&nbsp;</td>
                            
                        <td class="auto-style284">
                            &nbsp;</td>
                        
                        <td class="auto-style59">
                            &nbsp;</td>
                        <td class="auto-style278">&nbsp;</td>
                        <td class="auto-style282">
                            &nbsp;</td>
                        <td class="auto-style295">
                            &nbsp;</td>
                        <td class="auto-style278">&nbsp;</td>
                    </tr>
                    <tr id="tr1" runat="server">
                        <td class="auto-style281">&nbsp;</td>
                        <td class="auto-style292">&nbsp;</td>
                        <td class="auto-style282"></td>
                        <td class="auto-style284">
                            <asp:Label runat="server">Serie MAP:</asp:Label>
                        </td>
                        <td class="auto-style59">
                            <asp:TextBox ID="tb_serie_ret" runat="server" Height="20px" MaxLength="12" Width="145px"></asp:TextBox>
                        </td>
                        <td class="auto-style278"></td>
                        <td class="auto-style282">
                            <asp:Label ID="Label5" runat="server">Año:</asp:Label>
                        </td>
                        <td class="auto-style295">
                            <asp:TextBox ID="tb_año_ret" runat="server" Height="20px" MaxLength="4" Width="100px"></asp:TextBox>
                        </td>
                        <td class="auto-style278"></td>
                    </tr>
                    <tr>
                        <td class="auto-style281">
                            <asp:Label ID="Label6" runat="server">Marca:</asp:Label>
                        </td>
                        <td class="auto-style292">
                            <asp:DropDownList ID="cb_marca_ret" runat="server" Height="30px" Width="250px">
                            </asp:DropDownList>
                        </td>
                        <td class="auto-style24">
                            </td>
                        <td class="auto-style284">
                            <asp:Label ID="Label26" runat="server">Diametro:</asp:Label>
                        </td>
                        <td class="auto-style59">
                            <asp:DropDownList ID="cb_diametro_ret" runat="server" Height="30px" Width="150px">
                            </asp:DropDownList>
                        </td>
                        
                        
                        <td class="auto-style59">&nbsp;</td>
                        
                        
                        <td class="auto-style272">
                            <asp:Label ID="Label7" runat="server">Lectura:</asp:Label>
                        </td>
                        <td class="auto-style223">
                            <asp:TextBox ID="tb_lectura_ret" runat="server" Height="20px" MaxLength="10" Width="100px"></asp:TextBox>
                        </td>
                        <td class="auto-style59">&nbsp;</td>
                        
                        
                    </tr>
                </table>
                <table class="auto-style96">

                    <tr>
                        <td class="auto-style101" colspan="8"></td>
                        <td class="auto-style101">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="td_subtitle" colspan="9">
                            ~ANTECEDENTES MEDIDOR INSTALADO~</td>
                    </tr>                   
                    <tr runat="server">
                        <td class="auto-style281">
                            &nbsp;</td>
                        <td class="auto-style271">
                            &nbsp;</td>
                        <td class="auto-style272">&nbsp;</td>
                        <td class="auto-style284">
                            &nbsp;</td>
                        <td class="auto-style7" colspan="1">
                            &nbsp;</td>
                        <td class="auto-style283">&nbsp;</td>
                        <td class="auto-style272">
                            &nbsp;</td>
                        <td class="auto-style223">
                            &nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr id="tr_si_aplica1" runat="server">
                        <td class="auto-style281">
                            <asp:Label ID="Label12" runat="server">Marca:</asp:Label>
                        </td>
                        <td class="auto-style271">
                            <asp:DropDownList ID="cb_marca_nuevo" runat="server" Height="30px" Width="250px">
                            </asp:DropDownList>
                        </td>
                        <td class="auto-style272"></td>
                        <td class="auto-style284">
                            <asp:Label ID="Label25" runat="server" Text="Diametro:"></asp:Label>
                        </td>
                        <td class="auto-style7" colspan="1">
                            <asp:DropDownList ID="cb_diametro_nuevo" runat="server" Height="30px" style="margin-bottom: 1px" Width="150px">
                            </asp:DropDownList>
                        </td>
                        <td class="auto-style283"></td>
                        <td class="auto-style272">
                            <asp:Label ID="Label14" runat="server">Año: </asp:Label>
                        </td>
                        <td class="auto-style223">
                            <asp:TextBox ID="tb_año_nuevo" runat="server" Height="20px" MaxLength="4" Width="100px"></asp:TextBox>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr id="tr_si_aplica2" runat="server">
                        <td class="auto-style281">
                            <asp:Label ID="instvaral" runat="server">Instalacion Varal:</asp:Label>
                            &nbsp;</td>
                        <td class="auto-style59">
                            <asp:DropDownList ID="cb_instalacion_varal_nuevo" runat="server" Height="30px" Width="250px">
                            </asp:DropDownList>
                        </td>
                        <td class="auto-style282"></td>
                        <td class="auto-style284">
                            <asp:Label ID="lblvaral" runat="server">Material Varal:</asp:Label>
                        </td>
                        <td class="auto-style278">
                            <asp:DropDownList ID="cb_material_nuevo" runat="server" Height="30px" Width="150px">
                            </asp:DropDownList>
                        </td>
                        <td class="auto-style286"></td>
                        <td class="auto-style272">
                            <asp:Label ID="Label2" runat="server">Lectura: </asp:Label>
                        </td>
                        <td class="auto-style223">
                            <asp:TextBox ID="tb_lectura_nuevo" runat="server" Width="100px" Height="20px" MaxLength="10"></asp:TextBox>
                        </td>
                        <td class="auto-style278">&nbsp;</td>
                    </tr>
                    <tr id="tr_si_aplica3" runat="server">
                        <td class="auto-style281">
                            <asp:Label ID="instllave" runat="server"> Instalacion Llave:</asp:Label>
                            &nbsp;
                        </td>
                        <td class="auto-style59">
                            <asp:DropDownList ID="cb_instalacion_llave_nuevo" runat="server" Height="30px" Width="250px">
                            </asp:DropDownList>
                        </td>
                        <td class="auto-style282"></td>
                        <td class="auto-style284">
                            <asp:Label ID="lbltpllave" runat="server"> Tipo LLave:</asp:Label>
                        </td>
                        <td class="auto-style59">
                            <asp:DropDownList ID="cb_tipo_llave_nuevo" runat="server" Height="30px" Width="150px">
                            </asp:DropDownList>
                        </td>

                        <td class="auto-style286">&nbsp;</td>
                        <td class="auto-style272">
                            <asp:Label ID="Label1" runat="server" Text="Serie MAP:"></asp:Label>
                        </td>

                        <td class="auto-style223">
                            <asp:TextBox ID="tb_serie_nuevo" runat="server" Width="100px" Height="20px" MaxLength="12"></asp:TextBox>
                        </td>

                        <td>&nbsp;</td>

                    </tr>
                    <tr id="tr_si_aplica4" runat="server">
                  <td class="auto-style281">
                      <asp:Label ID="lbltiposello" runat="server"> Tipo Sello:</asp:Label>
                      &nbsp;
                            </td>
                        <td class="auto-style59">
                            <asp:DropDownList ID="cb_tipo_sello_nuevo" runat="server" Height="30px" Width="250px">
                            </asp:DropDownList>
                        </td>      
                         <td class="auto-style282"></td>
                        <td class="auto-style284">
                            <asp:Label ID="Lblcolorsello" runat="server"> Color Sello:</asp:Label>
                        </td>
                        <td class="auto-style59">
                            <asp:DropDownList ID="cb_color_sello_nuevo" runat="server" Height="30px" Width="150px">
                            </asp:DropDownList>
                      </td>
                        <td class="auto-style286">&nbsp;</td>
                        <td class="auto-style272">
                            <asp:Label ID="lblnrosello" runat="server"> Nro. Sello:</asp:Label>
                        </td>
                        <td class="auto-style223">
                            <asp:TextBox ID="tb_numero_sello_nuevo" runat="server" Width="100px" Height="20px" MaxLength="10"></asp:TextBox>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    
                    <tr id="tr_no_aplica" runat="server">
                        <td class="auto-style209" id="no_aplica" colspan="9">
                            <br />
                            <asp:Label ID="titulo_formulario7" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Medium" ForeColor="#339933">NO APLICA LA GESTIÓN DE LOS DATOS MAP INSTALADO</asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td &nbsp;="" class="auto-style291">&nbsp;</td>
                        <td class="auto-style59">&nbsp;</td>
                        <td class="auto-style283">&nbsp;</td>
                        <td class="auto-style223">&nbsp;</td>
                        <td>&nbsp;</td>
                        <td class="auto-style283">&nbsp;</td>
                        <td class="auto-style283">&nbsp;</td>
                        <td class="auto-style223">&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
                <table class="auto-style96">
                    <tr>
                        <td class="auto-style135" colspan="6"></td>
                        <td class="auto-style135">&nbsp;</td>
                        <td class="auto-style135">&nbsp;</td>
                        <td class="auto-style135">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="td_subtitle" colspan="9">
                            ~ANTECEDENTES CLIENTE~<br /> 
                        </td>
                    </tr>
                    <tr runat="server">
                        <td class="auto-style280" colspan="9" style="text-align: center">
                            <asp:CheckBox ID="check_con_firma" runat="server" AutoPostBack="true" Font-Bold="True" ForeColor="Black" OnCheckedChanged="check_con_firma_CheckedChanged1" Text="EFECTIVA CON FIRMA DE CLIENTE" />
                        </td>
                    </tr>
                    <tr runat="server">
                        <td class="auto-style280">&nbsp;</td>
                        <td class="auto-style160">&nbsp;</td>
                        <td class="auto-style282">&nbsp;</td>
                        <td class="auto-style284">&nbsp;</td>
                        <td class="auto-style292">&nbsp;</td>
                        <td class="auto-style972">&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr id="tr_no_aplica5" runat="server">
                        <td class="auto-style280">
                            <asp:Label ID="Label23" runat="server">Nombre Cliente:</asp:Label>
                        </td>
                        <td class="auto-style160">
                            <asp:TextBox ID="tb_nombre_cliente" runat="server" Height="20px" MaxLength="100" Width="245px"></asp:TextBox>
                        </td>
                        <td class="auto-style282">&nbsp;</td>
                        <td class="auto-style284">
                            <asp:Label ID="lbl11" runat="server">Rut Cliente:</asp:Label>
                            <br />
                            (12345678-9)</td>
                        <td class="auto-style292">
                            <asp:TextBox ID="tb_rut_cliente" runat="server" Height="20px" MaxLength="12" Width="100px"></asp:TextBox>
                            &nbsp;</td>
                        <td class="auto-style972">&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style280">
                            <asp:Label ID="lb_nombre_contacto" runat="server">Instalador:</asp:Label>
                        </td>
                        <td class="auto-style160">
                            <asp:DropDownList ID="cb_instalador" runat="server" Height="30px" Width="250px">
                            </asp:DropDownList>
                        </td>
                        <td class="auto-style24">
                            </td>
                        <td class="auto-style284">
                            <asp:Label ID="lb_respuesta" runat="server">Fecha Ejecucion:</asp:Label>

                            <br />
                            (DD-MM-YYYY)</td>
                        <td class="auto-style292">
                            <asp:TextBox ID="tb_fecha" runat="server" Height="20px" MaxLength="10" Width="100px"></asp:TextBox>
                        </td>
                        
                        
                        <td class="auto-style59">&nbsp;</td>
                        
                        
                        <td class="auto-style59">&nbsp;</td>
                        <td class="auto-style59">&nbsp;</td>
                        <td class="auto-style59">&nbsp;</td>
                        
                        
                    </tr>
                    <tr>
                        <td class="auto-style281">
                            <asp:Label ID="lblcodinst" runat="server">Contratista:</asp:Label>
                        </td>
                        <td class="auto-style160">
                            <asp:DropDownList ID="cb_contratista" runat="server" Height="30px" Width="250px">
                            </asp:DropDownList>
                        </td>
                        <td class="auto-style24"></td>
                        <td class="auto-style284">
                            <asp:Label ID="lblrutcli" runat="server">Hora Ejecución:</asp:Label>
                            <br />
                            (HH:MI:SS)</td>
                        <td class="auto-style292">
                            <asp:TextBox ID="tb_hora" runat="server" Height="20px" MaxLength="8" Width="100px"></asp:TextBox>
                        </td>
                        <td class="auto-style59"></td>
                        <td class="auto-style278"></td>
                        <td class="auto-style278"></td>
                        <td class="auto-style278"></td>
                    </tr>
                </table>
                <table class="auto-style96">
                    <tr>
                        <td class="auto-style293" colspan="3">
                        </td>
                    </tr>
                    <tr>
                        <td class="td_subtitle" colspan="3">
                            ~OBSERVACIÓN ADICIONAL~</td>
                    </tr>
                    <tr>
                        <td class="auto-style125">
                            &nbsp;</td>
                        <td class="auto-style59">
                            &nbsp;</td>
                        <td class="auto-style24">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style125">
                            <asp:Label ID="lbl4" runat="server">Observación adicional: </asp:Label>
                        </td>
                        <td class="auto-style59">
                            <asp:TextBox ID="tb_observacion" runat="server" Height="50px" MaxLength="250" Style="resize: none;" TextMode="MultiLine" Width="500px"></asp:TextBox>
                        </td>
                        <td class="auto-style24"></td>
                    </tr>
                    <tr>
                        <td class="auto-style125">&nbsp;</td>
                        <td class="auto-style59">&nbsp;</td>
                        <td class="auto-style24">&nbsp;</td>
                    </tr>
                </table>
                <table class="auto-style96">

                    <tr>
                        <td class="auto-style126" style="background-position: center center">
                            <asp:Label ID="lb_cargadas" runat="server" Font-Bold="True" ForeColor="#336699"></asp:Label>
                            &nbsp;<asp:Button ID="btn_fotos" runat="server"  Font-Bold="True" ForeColor="White" Height="40px" OnClick="btn_fotos_Click" Text="SUBIR FOTOS" Width="120px" CssClass="button1" />
                            &nbsp;</td>
                        <td class="auto-style973">
                            <asp:Button ID="btn_guardar" runat="server" Font-Bold="True" Height="40px" Text="GUARDAR ORDEN" OnClick="btn_guardar_Click" OnClientClick="return confirm('Está cambiando valores de una orden cerrada,¿Está seguro de continuar?');" CssClass="button1" />
                        </td>
                        <td class="auto-style973">
                            <asp:Button ID="btn_volver" runat="server"  Font-Bold="True" ForeColor="White" Height="40px" Text="VOLVER" Width="100px" OnClick="btn_volver_Click" OnClientClick="return confirm('Se descartará todo avance realizado,¿Está seguro de continuar?');" CssClass="button1" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </div>


        <div class="auto-style73" id="subir_fotos"  runat="server">
    
                  <table class="auto-style96">
            <tr>
                <td class="td_subtitle" colspan="5" style="vertical-align: middle">
                        SUBIR FOTOS (FORMATO JP/JPEG)
                        <asp:Button ID="btn_confirmar" runat="server" Font-Bold="True" Text="LISTO!" Width="100px" OnClick="btn_confirmar_Click" CssClass="button1"/>
                        <br />
                    </td>
            </tr>
                      </table>
            <table id="Table1" runat="server" align="center" border="1" cellspacing="4" style="border-collapse: collapse" class="auto-style96">                  
            <tr>
                <td id="title1" class="td_title_foto" runat="server">
                        <asp:Label ID="title_1" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Small" ForeColor="Black"></asp:Label>
                    </td>
                <td id="title2" class="td_title_foto" runat="server">
                        <asp:Label ID="title_2" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Small" ForeColor="Black"></asp:Label>
                    </td>
                <td class="td_title_foto" id="title3" runat="server">
                        <asp:Label ID="title_3" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Small" ForeColor="Black"></asp:Label>
                    </td>
            </tr>
            <tr>
                <td class="auto-style200" id="slot1" runat="server">
                        <asp:ImageButton ID="image1" runat="server" BorderStyle="Solid" Height="250px" Width="250px" ImageUrl="~/Imagenes/sin_foto.png" />
                        <asp:FileUpload ID="FUI_1" runat="server" Width="180px" />
                                <asp:Button ID="UBI_1" runat="server" text="SUBIR" OnClick="UploadImage1" />
                                <br />
                                <asp:RegularExpressionValidator ID="FUV_1" runat="server" ControlToValidate="FUI_1" ErrorMessage="Solo archivos JPEG/JPEG" ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))(.jpeg|.JPEG|.jpg|.JPEG)$" ValidationGroup="UBI_1"></asp:RegularExpressionValidator>
                    </td>
                <td class="auto-style200" id="slot2" runat="server">
                        <asp:ImageButton ID="image2" runat="server" BorderStyle="Solid" Height="250px" Width="250px" ImageUrl="~/Imagenes/sin_foto.png" />
                                <asp:FileUpload ID="FUI_2" runat="server" Width="250px" />
                                <asp:Button ID="UBI_2" runat="server"  text="SUBIR" OnClick="UploadImage2" />
                                <br />
                                <asp:RegularExpressionValidator ID="FUV_2" runat="server" ControlToValidate="FUI_2" ErrorMessage="Solo archivos JPEG/JPG" ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))(.jpeg|.JPEG|.jpg|.JPEG)$" ValidationGroup="UBI_2"></asp:RegularExpressionValidator>
                                </td>
                <td class="auto-style200" id="slot3" runat="server">
                        <asp:ImageButton ID="image3" runat="server" BorderStyle="Solid" Height="250px" Width="250px" ImageUrl="~/Imagenes/sin_foto.png" />
                                <asp:FileUpload ID="FUI_3" runat="server" Width="250px" />
                                <asp:Button ID="UBI_3" runat="server" text="SUBIR" OnClick="UploadImage3" />
                                <br />
                                <asp:RegularExpressionValidator ID="FUV_3" runat="server" ControlToValidate="FUI_3" ErrorMessage="Solo archivos JPEG/JPG" ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))(.jpeg|.JPEG|.jpg|.JPEG)$" ValidationGroup="UBI_3"></asp:RegularExpressionValidator>
                                </td>
            </tr>
                <tr>
                <td id="title4" class="td_title_foto" runat="server">
                        <asp:Label ID="title_4" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Small" ForeColor="Black"></asp:Label>
                    </td>
                <td id="title5" class="td_title_foto" runat="server">
                        <asp:Label ID="title_5" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Small" ForeColor="Black"></asp:Label>
                    </td>
                <td class="td_title_foto" id="title6" runat="server">
                        <asp:Label ID="title_6" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="Small" ForeColor="Black"></asp:Label>
                    </td>
            </tr>
            <tr>
                <td class="auto-style200" id="slot4" runat="server">
                        <asp:ImageButton ID="image4" runat="server" BorderStyle="Solid" Height="250px" Width="250px" ImageUrl="~/Imagenes/sin_foto.png" />
                        <asp:FileUpload ID="FUI_4" runat="server" Width="250px" />
                                <asp:Button ID="UBI_4" runat="server" text="SUBIR" OnClick="UploadImage4" />
                                <br />
                                <asp:RegularExpressionValidator ID="FUV_4" runat="server" ControlToValidate="FUI_4" ErrorMessage="Solo archivos JPEG/JPEG" ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))(.jpeg|.JPEG|.jpg|.JPEG)$" ValidationGroup="UBI_4"></asp:RegularExpressionValidator>
                    </td>
                <td class="auto-style200" id="slot5" runat="server">
                        <asp:ImageButton ID="image5" runat="server" BorderStyle="Solid" Height="250px" Width="250px" ImageUrl="~/Imagenes/sin_foto.png" />
                                <asp:FileUpload ID="FUI_5" runat="server" Width="250px" />
                                <asp:Button ID="UBI_5" runat="server"  text="SUBIR" OnClick="UploadImage5" />
                                <br />
                                <asp:RegularExpressionValidator ID="FUV_5" runat="server" ControlToValidate="FUI_5" ErrorMessage="Solo archivos JPEG/JPG" ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))(.jpeg|.JPEG|.jpg|.JPEG)$" ValidationGroup="UBI_5"></asp:RegularExpressionValidator>
                                </td>
                <td class="auto-style200" id="slot6" runat="server">
                        <asp:ImageButton ID="image6" runat="server" BorderStyle="Solid" Height="250px" Width="250px" ImageUrl="~/Imagenes/sin_foto.png" />
                                <asp:FileUpload ID="FUI_6" runat="server" Width="250px" />
                                <asp:Button ID="UBI_6" runat="server" text="SUBIR" OnClick="UploadImage6" />
                                <br />
                                <asp:RegularExpressionValidator ID="FUV_6" runat="server" ControlToValidate="FUI_6" ErrorMessage="Solo archivos JPEG/JPG" ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))(.jpeg|.JPEG|.jpg|.JPEG)$" ValidationGroup="UBI_6"></asp:RegularExpressionValidator>
                                </td>
            </tr>
            </table>
                      <table class="auto-style96">
            <tr>
                <td class="auto-style28" colspan="5">
                        &nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style103" colspan="5">
                </td>
            </tr>
                      </table>
    
    </div>

    </form>


</body>
</html>
