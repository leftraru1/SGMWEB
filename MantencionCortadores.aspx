<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MantencionCortadores.aspx.vb" Inherits="MantencionCortadores" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Mantenedor de Operadores - Sistema CYR</title>
      <link type="text/css" rel="stylesheet" href="estilos/page.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/controls.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/grid.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/webpart.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/menu.css"/>
      <link type="text/css" rel="stylesheet" href="estilos/others.css"/>
        <link type="text/css" rel="stylesheet" href="estilos/style.css"/>  


<%--<style type="text/css">
body {
margin:0;
width: 100%;
height: 100%;
}
</style>--%>

<%--<script type="text/javascript" language="JavaScript1.2">
window.moveTo(0,0);
top.window.resizeTo(screen.availWidth,screen.availHeight);

</script>  --%>   
      
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table align="center" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 732px; height: 13px;">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <div class="WebPartShadow">
                        <div class="WebPartTitle" id="titulo_mod" runat="server">
                            Mantenedor de Operadores</div>
                        <table align="center" border="0" cellspacing="0">
                            <tr id="tr_btn_agrega" runat="server">
                                <td align="right" colspan="2" style="text-align: center; height: 17px;">
                                    <asp:LinkButton ID="btnAgregaLector" runat="server" Font-Bold="True" Font-Names="Arial"
                                        ForeColor="#0000C0">Agregar Operador</asp:LinkButton></td>
                            </tr>
                            <tr runat="server">
                                <td align="right" colspan="2" style="text-align: right">
                                    <asp:DropDownList ID="comboExcel" runat="server" CssClass="ComboBox" Enabled="False"
                                        Width="141px">
                                        <asp:ListItem>Excel 97 - 2000</asp:ListItem>
                                        <asp:ListItem>Excel 2003 - 2007</asp:ListItem>
                                    </asp:DropDownList>&nbsp;<asp:Button ID="btnExportExcel" runat="server" CssClass="botonnew"
                                        Text="Exportar Excel" />
                                    <asp:Button ID="btn_volver2" runat="server" CssClass="botonnew" Text="<< Volver" CausesValidation="False" /></td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2">
                                    <div class="WebPartShadow" style="text-align: justify" id="div_grilla" runat="server">
                                        <asp:Label ID="lb_cantidad_registros" runat="server" Text="coincidencia(s) encontrada(s)" Width="255px" Font-Names="Arial Unicode MS" Font-Size="X-Small" ForeColor="Maroon"></asp:Label><asp:DataGrid
                                            ID="GrillaCortadores" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                            BorderColor="#003366" BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1"
                                            CssClass="GridAlternativeItems" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" ForeColor="Black" GridLines="Horizontal"
                                            Height="1px" OnDeleteCommand="cmDelete" OnEditCommand="MyDataGrid_Edit">
                                            <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                                                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" VerticalAlign="Middle"
                                                Wrap="False" />
                                            <AlternatingItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                            <ItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                            <Columns>
                                                <asp:BoundColumn DataField="id_cortador" HeaderText="IDoperador" Visible="False">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="id_region" HeaderText="IDRegion" Visible="False">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="id_zona" HeaderText="IDZona" Visible="False">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="rut_empresa" HeaderText="IDEmpresa" Visible="False">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="cod_cortador" HeaderText="C&#243;digo Operador">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="apellido" HeaderText="Apellido(s) ">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="nombre" HeaderText="Nombre(s) ">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="nom_empresa" HeaderText="Empresa">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="clave_admin" HeaderText="Clave admin.">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="clave_cortador" HeaderText="Clave Operador">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="estado" HeaderText="Estado">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="cantidad" HeaderText="Descargar">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="version" HeaderText="Versi&#243;n">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="fotografia" HeaderText="Fotograf&#237;a">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="numero_telefono" HeaderText="Fono">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="serie_maquina" HeaderText="Serie M&#225;quina">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="id_modelo" HeaderText="Modelo">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="id_contratista" HeaderText="id_contratista" Visible="False"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="descripcion" HeaderText="Contratista"></asp:BoundColumn>
                                                <asp:EditCommandColumn CancelText="Cancel" EditText="Editar" HeaderText="Modificar"
                                                    UpdateText="Update">
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" ForeColor="Green" Wrap="False" />
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" ForeColor="#0000CC" Wrap="False" HorizontalAlign="Center" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                </asp:EditCommandColumn>
                                                <asp:ButtonColumn CommandName="Delete" HeaderText="Desactivar" Text="Desactivar" Visible="False">
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" ForeColor="#0000CC" Wrap="False" HorizontalAlign="Center" />
                                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                                </asp:ButtonColumn>
                                            </Columns>
                                            <HeaderStyle BackColor="CornflowerBlue" BorderColor="Black" Font-Bold="True" Font-Italic="False"
                                                Font-Overline="False" Font-Strikeout="False" Font-Underline="True" ForeColor="White"
                                                Wrap="False" /><FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <EditItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <SelectedItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                        </asp:DataGrid>
                                     </div>
                                    <asp:Label ID="valida_borra_lector" runat="server" Font-Names="Arial" ForeColor="Red"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="height: 1px">
                                <div style="text-align: center" id="div_nuevo_lector" runat="server">
                                    <table id="tbl_ingreso_lector" runat="server">
                                        <tr>
                                            <td colspan="2" style="height: 21px; text-align: left;">
                                                <h2>
                                                    Complete la información asociada al Operador:</h2></td>
                                            <td style="height: 21px">
                                            </td>
                                            <td align="right" style="width: 120px; height: 21px">
                                            </td>
                                            <td style="height: 21px; text-align: left">
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 119px; height: 21px">
                                                <h2 style="text-align: right">Código Operador:&nbsp;
                                                </h2></td>                                                
                                            <td style="text-align: left; height: 21px;">
                                                <asp:TextBox ID="txt_codLector" runat="server" CssClass="TextBox" MaxLength="4"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_codLector"
                                                    ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>  
                                               <td style="height: 21px">
                                            </td>
                                            <td align="right" style="width: 120px; height: 21px">
                                                <h2 style="text-align: right">
                                                    Empresa:&nbsp;</h2></td>
                                            <td style="text-align: left; height: 21px;">
                                                &nbsp;<asp:Label ID="lbEmpresaLector" runat="server" Font-Names="Arial"></asp:Label><asp:Label ID="lbRutEmpresa" runat="server" Font-Names="Arial"></asp:Label></td>                                                                                  
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; width: 119px; height: 21px;">
                                                <h2>Nombre:&nbsp;
                                                </h2></td>
                                            <td style="text-align: left; height: 21px;">
                                                <asp:TextBox ID="txt_nomLector" runat="server" CssClass="TextBox" MaxLength="50"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txt_nomLector"
                                                    ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                            <td style="height: 21px">
                                            </td>
                                            <td style="width: 120px; height: 21px">
                                                <h2 style="text-align: right">Región:&nbsp;</h2></td>
                                            <td style="text-align: left; height: 21px;">
                                                <asp:DropDownList ID="combo_regiones" runat="server" CssClass="ComboBox" AutoPostBack="True">
                                            </asp:DropDownList></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right; width: 119px; height: 21px;">
                                                <h2>
                                                    Apellido:&nbsp;
                                                </h2></td>
                                            <td style="text-align: left; height: 21px;">
                                                <asp:TextBox ID="txt_apeLector" runat="server" CssClass="TextBox" MaxLength="50"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txt_apeLector"
                                                    ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                            <td style="height: 21px">
                                            </td>
                                            <td style="width: 120px; height: 21px; text-align:right;">
                                                <h2>Zona:&nbsp;
                                                </h2>
                                            </td>
                                            <td style="text-align: left; height: 21px;">
                                                <asp:DropDownList ID="combo_zonaLector" runat="server" CssClass="ComboBox">
                                                </asp:DropDownList></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 119px; text-align:right;">
                                                <h2>Clave Administrador:&nbsp;
                                                </h2></td>
                                            <td style="text-align: left">
                                                <asp:TextBox ID="txt_claveAdmin" runat="server" CssClass="TextBox" MaxLength="8"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txt_claveAdmin"
                                                    ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                            <td>
                                            </td>
                                            <td style="width: 120px; text-align:right;">
                                                <h2>Clave Operador:&nbsp;
                                                </h2>
                                            </td>
                                            <td style="text-align: left">
                                                <asp:TextBox ID="txt_ClaveLector" runat="server" CssClass="TextBox" MaxLength="6"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txt_ClaveLector"
                                                    ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 119px; height: 21px; text-align:right;">
                                                <h2>Correo electrónico:&nbsp;
                                                </h2></td>
                                            <td style="text-align: left; height: 21px;">
                                                <asp:TextBox ID="txt_email" runat="server" CssClass="TextBox" MaxLength="40"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RFV_email" runat="server" ControlToValidate="txt_email"
                                                    CssClass="ErrorMessage" ErrorMessage="*"></asp:RequiredFieldValidator></td>
                                            <td style="height: 21px">
                                            </td>
                                            <td style="width: 120px; height: 21px; text-align:right;">
                                                <h2>Forma Gestión:&nbsp;
                                                </h2>
                                            </td>
                                            <td style="text-align: left; height: 21px;"><asp:DropDownList ID="cmb_formagestion" runat="server" CssClass="ComboBox" Width="200px">
                                                <asp:ListItem Selected="True" Value="1">PDA</asp:ListItem>
                                                <asp:ListItem Value="2">Papel</asp:ListItem>
                                            </asp:DropDownList></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 119px; text-align:right;">                                            
                                                <h2>
                                                    Contratista:&nbsp;
                                                </h2>                                                
                                            </td>
                                            <td style="text-align: left;">
                                                <asp:DropDownList ID="combo_contratista" runat="server" CssClass="ComboBox" Width="192px">
                                                </asp:DropDownList></td>
                                            <td>
                                            </td>
                                            <td style="width: 120px">
                                                   <h2 style="text-align: right">
                                                Solicitud Fotografía:&nbsp;</h2></td>
                                            <td style="text-align: left;">
                                                <asp:DropDownList ID="combo_fotografia" runat="server" CssClass="ComboBox">
                                                    <asp:ListItem>Sin Fotograf&#237;a</asp:ListItem>
                                                    <asp:ListItem>Con Fotograf&#237;a</asp:ListItem>
                                                </asp:DropDownList></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 119px; text-align:right;">
                                                  <h2>Número Celular:&nbsp;
                                                  </h2>
                                            </td>
                                            <td style="text-align: left;">
                                                <asp:TextBox ID="txt_num_celular" runat="server" CssClass="TextBox" MaxLength="11"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator7"
                                                        runat="server" ControlToValidate="txt_num_celular" ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                            <td>
                                            </td>
                                            <td style="text-align: right; width: 120px;">
                                                <h2>Serie Máquina:&nbsp;
                                                </h2>
                                            </td>
                                            <td style="text-align: left;">
                                                <asp:TextBox ID="txt_serie_maquina" runat="server" CssClass="TextBox" MaxLength="35"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator8"
                                                        runat="server" ControlToValidate="txt_serie_maquina" ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 119px; text-align:right;">
                                               <h2>Modelo Máquina:&nbsp;
                                               </h2>
                                            </td>
                                            <td style="text-align: left;">
                                                <asp:DropDownList ID="combo_modelo" runat="server" CssClass="ComboBox">
                                                </asp:DropDownList></td>
                                            <td>
                                            </td>
                                            <td style="width: 120px; text-align:right;">
                                                <h2> &nbsp;
                                                </h2></td>
                                            <td style="text-align: left">
                                                <asp:TextBox ID="txt_cantidad_descarga" runat="server" CssClass="TextBox"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txt_cantidad_descarga"
                                                    ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr>
                                            <td align="left" colspan="2">
                                                &nbsp;<table id="TABLE1" border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td>
                                                <asp:RegularExpressionValidator ID="ER_nom" runat="server" ControlToValidate="txt_nomLector"
                                                    Display="Dynamic" ValidationExpression="[a-zA-Z]{3,50}([\s]{0,1}[a-zA-Z]{0,50})([\s]{0,1}[a-zA-Z]{0,50})([\s]{0,1}[a-zA-Z]{0,50})([\s]{0,1}[a-zA-Z]{0,50})" ErrorMessage="Error Nombre Operador: Se aceptan sólo letras!" Font-Names="Arial" CssClass="ErrorMessage"></asp:RegularExpressionValidator></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:RegularExpressionValidator ID="ER_ape" runat="server" ControlToValidate="txt_apeLector"
                                                                Display="Dynamic" ErrorMessage="Error Apellido Operador: Se aceptan sólo letras!"
                                                                ValidationExpression="[a-zA-Z]{3,50}([\s]{0,1}[a-zA-Z]{0,50})" Font-Names="Arial" CssClass="ErrorMessage"></asp:RegularExpressionValidator></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="height: 15px">
                                                            <asp:RegularExpressionValidator ID="ER_codLector" runat="server" ControlToValidate="txt_codLector"
                                                                Display="Dynamic" ErrorMessage="Error Código Operador: se aceptan sólo numéricos!"
                                                                ValidationExpression="^([0-9]{1,4})$" Font-Names="Arial" CssClass="ErrorMessage"></asp:RegularExpressionValidator></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="height: 15px">
                                                            <asp:RegularExpressionValidator ID="ER_Claveadmin" runat="server" ControlToValidate="txt_claveAdmin"
                                                                Display="Dynamic" ErrorMessage="Error Clave Administrador: se aceptan sólo alfanuméricos!"
                                                                ValidationExpression="^([0-9a-zA-Z]{1,8})$" Font-Names="Arial" CssClass="ErrorMessage"></asp:RegularExpressionValidator></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:RegularExpressionValidator ID="ER_ClaveLector" runat="server" ControlToValidate="txt_ClaveLector"
                                                                Display="Dynamic" ErrorMessage="Error Clave Operador: se aceptan sólo alfanuméricos!"
                                                                ValidationExpression="^([0-9a-zA-Z]{1,6})$" Font-Names="Arial" CssClass="ErrorMessage"></asp:RegularExpressionValidator></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="height: 16px">
                                                            <asp:Label ID="lb_valida_claves" runat="server" ForeColor="Red" Font-Names="Arial" CssClass="ErrorMessage"></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txt_codLector"
                                                                Display="Dynamic" ErrorMessage="Error Código Operador: se aceptan sólo numéricos!"
                                                                Font-Names="Arial" ValidationExpression="^([0-9]{1,4})$" CssClass="ErrorMessage"></asp:RegularExpressionValidator></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:RegularExpressionValidator ID="ER_fono1" runat="server" ControlToValidate="txt_num_celular"
                                                                Display="Dynamic" ErrorMessage="Error Numero Celular: se aceptan sólo números!"
                                                                Font-Bold="False" ValidationExpression="^([0-9]{1,50})$" Width="264px" CssClass="ErrorMessage"></asp:RegularExpressionValidator></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="height: 13px">
                                                            <asp:RegularExpressionValidator ID="ER_email" runat="server" ControlToValidate="txt_email"
                                                                ErrorMessage="Error email: Email inválido!" Font-Names="Arial" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"></asp:RegularExpressionValidator></td>
                                                    </tr>
                                                </table>
                                                </td>                                            
                                            <td>
                                            </td>
                                            <td align="right" style="width: 120px">
                                            </td>
                                            <td>
                                                &nbsp;<asp:Label ID="lb_id_usuario" runat="server" CssClass="Label"></asp:Label></td>
                                        </tr>
                                        <tr>
                                          
                                            <td align="right" colspan="5">
                                                &nbsp;<asp:Button ID="btnInsertaLector" runat="server" CssClass="botonnew" Text="Agregar Operador" Width="120px" />
                                                <asp:Button ID="btnCancelar" runat="server" CssClass="botonnew" Text="Cancelar" CausesValidation="False" />
                    <asp:Button ID="btnVolver" runat="server" CssClass="botonnew" Text="<< Volver" CausesValidation="False" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" colspan="5">
                                                &nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                    </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2">                                
                                    <asp:Button ID="btn_aceptar" runat="server" CssClass="botonnew" Text="Aceptar" CausesValidation="False" />
                                    </td>
                            </tr>
                        </table><asp:DataGrid
                                            ID="GrillaCortadores_temp" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                            BorderColor="#003366" BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1"
                                            CssClass="GridAlternativeItems" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" ForeColor="Black" GridLines="Horizontal"
                                            Height="1px" OnDeleteCommand="cmDelete" OnEditCommand="MyDataGrid_Edit" Visible="False">
                            <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                            <EditItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                            <SelectedItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                            <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                                                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" VerticalAlign="Middle"
                                                Wrap="False" />
                            <AlternatingItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                            <ItemStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                            <Columns>
                                <asp:BoundColumn DataField="id_cortador" HeaderText="IDoperador" Visible="False">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="id_region" HeaderText="IDRegion" Visible="False">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="id_zona" HeaderText="IDZona" Visible="False">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="rut_empresa" HeaderText="IDEmpresa" Visible="False">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="cod_cortador" HeaderText="C&#243;digo Operador">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="apellido" HeaderText="Apellido(s) ">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="nombre" HeaderText="Nombre(s) ">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="nom_empresa" HeaderText="Empresa">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="clave_admin" HeaderText="Clave admin.">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="clave_cortador" HeaderText="Clave Operador">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="estado" HeaderText="Estado">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="cantidad" HeaderText="Descargar">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="version" HeaderText="Versi&#243;n">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="fotografia" HeaderText="Fotograf&#237;a">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="numero_telefono" HeaderText="Fono">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="serie_maquina" HeaderText="Serie M&#225;quina">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="id_modelo" HeaderText="Modelo">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                            </Columns>
                            <HeaderStyle BackColor="CornflowerBlue" BorderColor="Black" Font-Bold="True" Font-Italic="False"
                                                Font-Overline="False" Font-Strikeout="False" Font-Underline="True" ForeColor="White"
                                                Wrap="False" />
                        </asp:DataGrid></div>
                                    <img id="img_ok" runat="server" src="fotos/img_ok2.bmp" />
                                    <asp:Label ID="lb_mensaje_ingreso"
                                        runat="server" Font-Names="Arial Unicode MS" CssClass="Label" Font-Size="Small" ForeColor="#0000C0" Height="18px" Width="457px"></asp:Label>
                    <asp:Label ID="lb_error" runat="server" CssClass="ErrorMessage" Font-Names="Arial Unicode MS"
                        Font-Size="Small" ForeColor="Red" Height="18px"></asp:Label></td>
            </tr>
        </table>
    
    </div>
        &nbsp;&nbsp;
    </form>
</body>
</html>
