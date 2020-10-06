<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AgregarContratista.aspx.vb" Inherits="AgregarContratista" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Agregar Contratista.</title>
    <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/others.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/style.css"/>    
      
       <script type="text/javascript" language="javascript">  
       function openCalendar(obj)
      {
        var url = 'calendario.aspx?textbox=' + obj;
        window.open(url,'cal','width=260,height=210,left=500,top=100,resizable=0,scrollbars=0');
      }      
      
      </script>  
        
        
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 1070px;">
            <tr>
                <td style="width: 1056px">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 1056px">
                    <div class="WebPartShadow_pago" style="width: 1025px">
                        <div id="titulo_mod" runat="server" class="WebPartTitle_pago">
                            Agregar Nuevo <strong>Contratista.</strong></div>
                        <table align="center" border="0" cellspacing="4" style="width: 1024px;">
                            <tr>
                                <td align="left" colspan="2" nowrap="nowrap">
                                    <h2>
                                        <asp:Label ID="lb_minihead" runat="server" Text="Por favor, seleccione los datos de Contratista:"></asp:Label></h2>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2">
                                    <strong>
                                        <table id="tbl_NuevoUser" runat="server" style="width: 1000px">
                                            <tr>
                                                <td align="left" colspan="5" style="width: 12%; height: 4px">
                                                    <h2>
                                                        (*) Campos Obligatorios
                                                     </h2>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" colspan="1" style="width: 222px; height: 4px">
                                                    <h2>
                                                        Nombre Contratista:
                                                    </h2>
                                                </td>
                                                <td align="left" colspan="1" style="width: 33%; height: 4px">
                                                     &nbsp;
                                                    <asp:TextBox ID="txt_nombre" runat="server" CssClass="TextBox2"
                                                        ReadOnly="false" Width="208px"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rq_nombre" runat="server" ControlToValidate="txt_nombre"
                                                        ErrorMessage="*" Width="32px"></asp:RequiredFieldValidator></td>
                                                <td colspan="1" style="width: 8px; height: 4px">
                                                    &nbsp;</td>
                                                <td align="right" colspan="1" style="width: 171px; height: 4px">
                                                    <h2>
                                                        Rut Contratista:
                                                    </h2>
                                                </td>
                                                <td align="left" style="width: 245px; height: 4px">
                                                    &nbsp;
                                                    <asp:TextBox ID="txt_rut" runat="server" CssClass="TextBox" ForeColor="ControlText"
                                                        MaxLength="8" Width="106px"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator2"
                                                            runat="server" ControlToValidate="txt_rut" ErrorMessage="*"></asp:RequiredFieldValidator>-
                                                    <asp:TextBox ID="txt_dv" runat="server" CssClass="TextBox" MaxLength="1" Width="23px"></asp:TextBox><asp:RequiredFieldValidator
                                                        ID="RequiredFieldValidator4" runat="server" ControlToValidate="txt_dv" ErrorMessage="*"></asp:RequiredFieldValidator></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 222px">
                                                    <h2>
                                                        Codigo Contratista SGC:
                                                    </h2>
                                                </td>
                                                <td align="left">
                                                    &nbsp; 
                                                    <asp:TextBox ID="TxtCodigoContratista" runat="server" CssClass="TextBox2"
                                                        ReadOnly="false" Width="140px" MaxLength="8"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rp_codcontratista" runat="server" ControlToValidate="TxtCodigoContratista"
                                                        ErrorMessage="*" Width="32px"></asp:RequiredFieldValidator></td>
                                                <td style="width: 8px">
                                                </td>
                                                <td align="right" style="width: 171px">
                                                    <h2>
                                                        Fecha Inicio Contrato:
                                                    </h2>
                                                </td>
                                                <td align="left" style="width: 245px">
                                                    &nbsp;
                                                    <asp:TextBox ID="txtFechaDesde" runat="server" AutoPostBack="True" CssClass="TextBox2"
                                                        ReadOnly="false" Width="88px"></asp:TextBox>
                                                    <img id="Img1" runat="server" onclick="openCalendar('txtFechaDesde');" src="fotos/calendario.gif" />
                                                    <asp:RegularExpressionValidator ID="validar_fecha_desde" runat="server" BackColor="Transparent"
                                                        ControlToValidate="txtFechaDesde" CssClass="ErrorMessage" ErrorMessage="RegularExpressionValidator"
                                                        Font-Bold="True" ValidationExpression="^[0-9]{2}-[0-9]{2}-[0-9]{4}$" ValidationGroup="fecha">Error</asp:RegularExpressionValidator></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 222px; height: 12px">
                                                    <h2>
                                                        Número Contrato:
                                                    </h2>
                                                </td>
                                                <td align="left" style="width: 926px; height: 12px; font-weight: bold;">
                                                    &nbsp;&nbsp;<asp:TextBox ID="txt_numero_contrato" runat="server" CssClass="TextBox2" MaxLength="19"
                                                        ReadOnly="false" Width="140px"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rq_num_contrato" runat="server" ControlToValidate="TxtCodigoContratista"
                                                        ErrorMessage="*" Width="32px"></asp:RequiredFieldValidator></td>
                                                <td style="width: 8px; height: 12px; font-weight: bold;">                                               
                                                </td>
                                                <td align="right" style="width: 171px; height: 12px; font-weight: bold;">
                                                    <h2>
                                                        Fecha Termino Contrato:
                                                    </h2>
                                                </td>
                                                <td align="left" style="width: 245px; height: 12px">
                                                    &nbsp;
                                                    <asp:TextBox ID="txtFechaHasta" runat="server" AutoPostBack="True" CssClass="TextBox2"
                                                        ReadOnly="false" Width="88px"></asp:TextBox>
                                                    <img id="Img2" runat="server" onclick="openCalendar('txtFechaHasta');" src="fotos/calendario.gif" />
                                                    <asp:RegularExpressionValidator ID="validar_fecha_hasta" runat="server" BackColor="Transparent"
                                                        ControlToValidate="txtFechaHasta" CssClass="ErrorMessage" ErrorMessage="RegularExpressionValidator"
                                                        Font-Bold="True" ValidationExpression="^[0-9]{2}-[0-9]{2}-[0-9]{4}$" ValidationGroup="fecha">Error</asp:RegularExpressionValidator></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 222px; height: 12px">
                                                   <h2>
                                                       &nbsp;</h2>
                                                </td>
                                                <td align="left" style="width: 926px; height: 12px">
                                                    &nbsp;
                                                    </td>
                                                <td style="width: 8px; height: 12px">
                                                </td>
                                                <td align="right" style="width: 171px; height: 12px">
                                                    <h2>
                                                        Empresa:</h2>
                                                    </td>
                                                <td align="left" style="width: 245px; height: 12px">
                                                   &nbsp; <asp:DropDownList ID="combo_empresas" runat="server" CssClass="ComboBox"
                                                        Width="168px">
                                                    </asp:DropDownList></td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="5" style="height: 12px">
                                                    </td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="3" style="height: 17px">
                                                    <table id="TABLE1" border="0" cellpadding="0" cellspacing="0" style="width: 310px">
                                                        <tr>
                                                            <td style="width: 310px">
                                                                <asp:RegularExpressionValidator ID="ER_nom" runat="server" ControlToValidate="txt_nombre"
                                                                    Display="Dynamic" ErrorMessage="Error Nombre Contratista: Se aceptan sólo letras!"
                                                                    Font-Bold="False" ValidationExpression="[a-zA-Z]{3,50}([\s]{0,1}[a-zA-Z]{0,50})([\s]{0,1}[a-zA-Z]{0,50})([\s]{0,1}[a-zA-Z]{0,50})([\s]{0,1}[a-zA-Z]{0,50})" Font-Names="Arial"></asp:RegularExpressionValidator></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 310px">
                                                                <asp:RegularExpressionValidator ID="ER_RUT" runat="server" ControlToValidate="txt_rut"
                                                                    Display="Dynamic" ErrorMessage="Error RUT Contratista: Formato incorrecto!" Font-Bold="False"
                                                                    ValidationExpression="[0-9]{7,8}" Font-Names="Arial"></asp:RegularExpressionValidator></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 310px">
                                                                </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="width: 171px; height: 17px">
                                                    &nbsp;
                                                </td>
                                                <td style="width: 245px; height: 17px">
                                                    <asp:Label ID="lb_id_usuario" runat="server"></asp:Label>
                                                    <asp:Label ID="LB_RUT_EMPRESA" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td align="right" colspan="5" style="height: 17px">
                                                    &nbsp; &nbsp;<asp:Button ID="btn_actualiza" runat="server" CssClass="botonnew" Text="Guardar Datos"
                                                        Width="120px" />
                                                    <asp:Button ID="btnVolver" runat="server" CausesValidation="False" CssClass="botonnew"
                                                        Text="<< Volver" Width="120px" />
                                                </td>
                                            </tr>
                                        </table>
                                    </strong>&nbsp; &nbsp;
                                                    <asp:Label ID="VALIDACION_RUT_CONTRATISTA" runat="server" Font-Bold="False" Font-Names="Arial"
                                                        ForeColor="Red" Width="344px"></asp:Label>
                                    </td>
                            </tr>
                        </table>
                    </div>
                                    <img id="img_ok" runat="server" src="fotos/ok.bmp" />
                                                    &nbsp;<asp:Label ID="lb_mensaje_edicion" runat="server" Font-Names="Arial Unicode MS"
                        Font-Size="Small" ForeColor="#0000C0" Height="18px" Width="578px"></asp:Label><asp:Label
                            ID="lb_error" runat="server" CssClass="ErrorMessage" Font-Names="Arial Unicode MS"
                            Font-Size="Small" ForeColor="Red" Height="18px"></asp:Label></td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
