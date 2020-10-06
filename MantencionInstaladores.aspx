<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeFile="MantencionInstaladores.aspx.cs" Inherits="MantencionOperador" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .auto-style5 {
            height: 17px;
            width: 1701px;
        }

        .auto-style7 {
            height: 1px;
            width: 1701px;
        }

        .auto-style8 {
            width: 119px;
            height: 21px;
        }

        .auto-style9 {
            height: 21px;
        }

        .auto-style10 {
            width: 120px;
            height: 21px;
        }

        .auto-style11 {
            width: 1701px;
        }

        .auto-style12 {
            width: 225px;
        }

        .auto-style13 {
            height: 15px;
            width: 225px;
        }

        .auto-style14 {
            height: 16px;
            width: 225px;
        }

        .auto-style15 {
            height: 13px;
            width: 225px;
        }
        .auto-style16
        {
            width: 732px;
            height: 13px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


    <title>Mantenedor de Instaladores - Sistema CYR</title>
    <link type="text/css" rel="stylesheet" href="estilos/page.css" />
    <link type="text/css" rel="stylesheet" href="estilos/controls.css" />
    <link type="text/css" rel="stylesheet" href="estilos/grid.css" />
    <link type="text/css" rel="stylesheet" href="estilos/webpart.css" />
    <link type="text/css" rel="stylesheet" href="estilos/menu.css" />
    <link type="text/css" rel="stylesheet" href="estilos/others.css" />
    <link type="text/css" rel="stylesheet" href="estilos/style.css" />


    <script type="text/javascript" language="javascript">
        function datoSTR(obj) {
            return obj;
        }
    </script>


    <div>
        <table align="center" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td class="auto-style16">
                    <asp:Label ID="Lb_user" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                        Font-Underline="True">Sesión</asp:Label><asp:Label ID="lb_session_user" runat="server"
                            Font-Names="Arial" Font-Size="X-Small"></asp:Label><asp:Label ID="lb_empresa" runat="server"
                                Font-Bold="True" Font-Names="Arial" Font-Size="X-Small" Font-Underline="True">Empresa</asp:Label><asp:Label
                                    ID="lb_session_empresa" runat="server" Font-Names="Arial" Font-Size="X-Small"></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <div class="">
                        <div class="WebPartTitle" id="titulo_mod" runat="server">
                            Mantenedor de Instaladores
                        </div>
                        <table align="center" border="0" cellspacing="0" style="margin-right: 0px">
                            <tr id="tr_btn_agrega" runat="server">
                                <td align="right" colspan="2" style="text-align: center;" class="auto-style5">&nbsp;</td>
                            </tr>
                            <tr id="Tr1" runat="server">
                                <td align="right" colspan="2" style="text-align: left" class="auto-style11">
                                    <asp:LinkButton ID="btnAgregaLector" runat="server" Font-Bold="True" Font-Names="Arial"
                                        ForeColor="#0000C0"  >Agregar Instalador</asp:LinkButton>
                                    <asp:DropDownList ID="comboExcel" runat="server" CssClass="ComboBox"
                                        Width="141px">
                                        <asp:ListItem>Excel 97 - 2000</asp:ListItem>
                                        <asp:ListItem>Excel 2003 - 2007</asp:ListItem>
                                    </asp:DropDownList>&nbsp;<asp:Button ID="btnExportExcel" runat="server" CssClass="botonnew"
                                        Text="Exportar Excel" OnClick="btnExportExcel_Click" />
                                    <asp:Button ID="btn_volver2" runat="server" CssClass="botonnew" Text="<< Volver" CausesValidation="False" OnClick="btnVolver_Click" Visible="False" /></td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" class="auto-style11">
                                    <div class="WebPartShadow" style="text-align: justify" id="div_grilla" runat="server">
                                        <asp:Label ID="lb_cantidad_registros" runat="server" Text="coincidencia(s) encontrada(s)" Width="284px" Font-Names="Arial Unicode MS" ForeColor="Maroon"></asp:Label>
             <asp:DataGrid ID="GrillaCortadores" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" CssClass="GridActiveItem" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                            Font-Strikeout="False" Font-Underline="False" ForeColor="#333333" Height="16px" OnDeleteCommand="cmDelete" OnEditCommand="MyDataGrid_Edit" OnItemDataBound="GrillaCortadores_ItemDataBound" Width="854px" BorderStyle="Ridge" AllowPaging="True" BorderWidth="1px" OnPageIndexChanged="GrillaCortadores_PageIndexChanged">
                                            <PagerStyle BackColor="#2461BF" BorderColor="Transparent" VerticalAlign="Middle"
                                                Wrap="False" ForeColor="White" HorizontalAlign="Center" Mode="NumericPages" />
                                            <AlternatingItemStyle BackColor="White" Wrap="False" />
                                            <ItemStyle BackColor="#EFF3FB" Wrap="False" />
                                            <Columns>
                                                <asp:BoundColumn DataField="id_instalador" HeaderText="IDinstalador" Visible="False">
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
                                                <asp:BoundColumn DataField="cod_instalador" HeaderText="CODIGO INSTALADOR">
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                                    <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="apellido" HeaderText="APELLIDO(S)">
                                                   <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="nombre" HeaderText="NOMBRE(S)">
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="nom_empresa" HeaderText="EMPRESA">
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="clave_admin" HeaderText="CLAVE ADMIN.">
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="clave_instalador" HeaderText="CLAVE INSTALADOR">
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="estado" HeaderText="ESTADO">
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="cantidad" HeaderText="DESCARGAR">
                                                   <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="version" HeaderText="VERSION">
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="fotografia" HeaderText="FOTOGRAFIA">
                                                   <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="numero_telefono" HeaderText="FONO">
                                                   <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="serie_maquina" HeaderText="SERIE MAQUINA">
                                                   <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="id_modelo" HeaderText="MODELO">
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="id_contratista" HeaderText="id_contratista" Visible="False"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="descripcion" HeaderText="CONTRATISTA">
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
                                                </asp:BoundColumn>
                                                <asp:EditCommandColumn CancelText="Cancel" EditText="Editar" HeaderText="MODIFICAR"
                                                    UpdateText="Update">
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                                <HeaderStyle Font-Bold="True" Width="20%" ForeColor="White"/>
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
                                            <HeaderStyle BackColor="#507CD1" BorderColor="Black" Font-Bold="True" Font-Underline="True" ForeColor="White"
                                                Wrap="False" />
                                            <FooterStyle Font-Bold="True" Wrap="False" BackColor="#507CD1" ForeColor="White" />
                                            <EditItemStyle Wrap="False" BackColor="#2461BF" />
                                            <SelectedItemStyle Font-Bold="True" Wrap="False" BackColor="#D1DDF1" ForeColor="#333333" />
                                        </asp:DataGrid>
                                    </div>
                                    <asp:Label ID="valida_borra_lector" runat="server" Font-Names="Arial" ForeColor="Red"></asp:Label></td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" class="auto-style7">
                                    <div style="text-align: center" id="div_nuevo_lector" runat="server">
                                        <table id="tbl_ingreso_lector" runat="server">
                                            <tr>
                                                <td colspan="2" style="height: 21px; text-align: left;">
                                                    <h2>Complete la información asociada al Instalador:</h2>
                                                </td>
                                                <td style="height: 21px"></td>
                                                <td align="right" style="width: 120px; height: 21px"></td>
                                                <td style="height: 21px; text-align: left">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td align="right" class="auto-style8">
                                                    <h2 style="text-align: right">Código Instalador:&nbsp;
                                                    </h2>
                                                </td>
                                                <td style="text-align: left;" class="auto-style9">
                                                    <asp:TextBox ID="txt_codLector" runat="server" CssClass="TextBox" MaxLength="6"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_codLector"
                                                        ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                                <td class="auto-style9"></td>
                                                <td align="right" class="auto-style10">
                                                    <h2 style="text-align: right">Empresa:&nbsp;</h2>
                                                </td>
                                                <td style="text-align: left;" class="auto-style9">&nbsp;<asp:Label ID="lbEmpresaLector" runat="server" Font-Names="Arial"></asp:Label><asp:Label ID="lbRutEmpresa" runat="server" Font-Names="Arial"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right; width: 119px; height: 21px;">
                                                    <h2>Nombre:&nbsp;
                                                    </h2>
                                                </td>
                                                <td style="text-align: left; height: 21px;">
                                                    <asp:TextBox ID="txt_nomLector" runat="server" CssClass="TextBox" MaxLength="50"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txt_nomLector"
                                                        ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                                <td style="height: 21px"></td>
                                                <td style="width: 120px; height: 21px">
                                                    <h2 style="text-align: right">Región:&nbsp;</h2>
                                                </td>
                                                <td style="text-align: left; height: 21px;">
                                                    <asp:DropDownList ID="combo_regiones" runat="server" CssClass="ComboBox" AutoPostBack="True">
                                                    </asp:DropDownList></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right; width: 119px; height: 21px;">
                                                    <h2>Rut:&nbsp;</h2>
                                                </td>
                                                <td style="text-align: left; height: 21px;">
                                                    <asp:TextBox ID="txt_rut" runat="server" CssClass="TextBox" MaxLength="8">

                                                    </asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txt_rut" ErrorMessage="*" CssClass="ErrorMessage">

                                                    </asp:RequiredFieldValidator>
                                                    <asp:TextBox ID="txt_dv" runat="server" CssClass="TextBox" MaxLength="1" Width="17px"></asp:TextBox>

                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txt_dv" ErrorMessage="*">

                                                    </asp:RequiredFieldValidator>
                                                </td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right; width: 119px; height: 21px;">
                                                    <h2>Apellido:&nbsp;
                                                    </h2>
                                                </td>
                                                <td style="text-align: left; height: 21px;">
                                                    <asp:TextBox ID="txt_apeLector" runat="server" CssClass="TextBox" MaxLength="50"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txt_apeLector"
                                                        ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                                <td style="height: 21px"></td>
                                                <td style="width: 120px; height: 21px; text-align: right;">
                                                    <h2>Zona:&nbsp;
                                                    </h2>
                                                </td>
                                                <td style="text-align: left; height: 21px;">
                                                    <asp:DropDownList ID="combo_zonaLector" runat="server" CssClass="ComboBox">
                                                    </asp:DropDownList></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 119px; text-align: right;">
                                                    <h2>Clave Administrador:&nbsp;
                                                    </h2>
                                                </td>
                                                <td style="text-align: left">
                                                    <asp:TextBox ID="txt_claveAdmin" runat="server" CssClass="TextBox" MaxLength="8"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txt_claveAdmin"
                                                        ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                                <td></td>
                                                <td style="width: 120px; text-align: right;">
                                                    <h2>Clave Instalador:&nbsp;
                                                    </h2>
                                                </td>
                                                <td style="text-align: left">
                                                    <asp:TextBox ID="txt_ClaveLector" runat="server" CssClass="TextBox" MaxLength="6"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txt_ClaveLector"
                                                        ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 119px; height: 21px; text-align: right;">
                                                    <h2>Correo electrónico:&nbsp;
                                                    </h2>
                                                </td>
                                                <td style="text-align: left; height: 21px;">
                                                    <asp:TextBox ID="txt_email" runat="server" CssClass="TextBox" MaxLength="40"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RFV_email" runat="server" ControlToValidate="txt_email"
                                                        CssClass="ErrorMessage" ErrorMessage="*"></asp:RequiredFieldValidator></td>
                                                <td style="height: 21px"></td>
                                                <td style="width: 120px; height: 21px; text-align: right;">
                                                    <h2>Forma Gestión:&nbsp;
                                                    </h2>
                                                </td>
                                                <td style="text-align: left; height: 21px;">
                                                    <asp:DropDownList ID="cmb_formagestion" runat="server" CssClass="ComboBox" Width="200px">
                                                        <asp:ListItem Selected="True" Value="1">PDA</asp:ListItem>
                                                        <asp:ListItem Value="2">Papel</asp:ListItem>
                                                    </asp:DropDownList></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 119px; text-align: right;">
                                                    <h2>Contratista:&nbsp;
                                                    </h2>
                                                </td>
                                                <td style="text-align: left;">
                                                    <asp:DropDownList ID="combo_contratista" runat="server" CssClass="ComboBox" Width="192px">
                                                    </asp:DropDownList></td>
                                                <td></td>
                                                <td style="width: 120px">
                                                    <h2 style="text-align: right">Solicitud Fotografía:&nbsp;</h2>
                                                </td>
                                                <td style="text-align: left;">
                                                    <asp:DropDownList ID="combo_fotografia" runat="server" CssClass="ComboBox">
                                                        <asp:ListItem>Sin Fotograf&#237;a</asp:ListItem>
                                                        <asp:ListItem>Con Fotograf&#237;a</asp:ListItem>
                                                    </asp:DropDownList></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 119px; text-align: right;">
                                                    <h2>Número Celular:&nbsp;
                                                    </h2>
                                                </td>
                                                <td style="text-align: left;">
                                                    <asp:TextBox ID="txt_num_celular" runat="server" CssClass="TextBox" MaxLength="11"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator7"
                                                        runat="server" ControlToValidate="txt_num_celular" ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                                <td></td>
                                                <td style="text-align: right; width: 120px;">
                                                    <h2>Serie Máquina:&nbsp;
                                                    </h2>
                                                </td>
                                                <td style="text-align: left;">
                                                    <asp:TextBox ID="txt_serie_maquina" runat="server" CssClass="TextBox" MaxLength="35"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="txt_serie_maquina" ErrorMessage="*" CssClass="ErrorMessage">

                                                    </asp:RequiredFieldValidator>

                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 119px; text-align: right;">
                                                    <h2>Modelo Máquina:&nbsp;
                                                    </h2>
                                                </td>
                                                <td style="text-align: left;">
                                                    <asp:DropDownList ID="combo_modelo" runat="server" CssClass="ComboBox">
                                                    </asp:DropDownList></td>
                                                <td></td>
                                                <td style="width: 120px; text-align: right;">
                                                    <h2>Cantidad:&nbsp;
                                                    </h2>
                                                </td>
                                                <td style="text-align: left;">
                                                    <asp:TextBox ID="txt_cantidad" runat="server" CssClass="TextBox" MaxLength="35"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txt_cantidad" ErrorMessage="*" CssClass="ErrorMessage"></asp:RequiredFieldValidator></td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="2">&nbsp;<table id="TABLE1" border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td align="left" colspan="5" style="height: 12px">
                                                            <asp:Label ID="VALIDACION_RUT_USUARIO" runat="server" Font-Bold="False" Font-Names="Arial"
                                                                ForeColor="Red"></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="auto-style12">
                                                            <asp:RegularExpressionValidator ID="ER_nom" runat="server" ControlToValidate="txt_nomLector"
                                                                Display="Dynamic" ValidationExpression="[a-zA-Z]{3,50}([\s]{0,1}[a-zA-Z]{0,50})([\s]{0,1}[a-zA-Z]{0,50})([\s]{0,1}[a-zA-Z]{0,50})([\s]{0,1}[a-zA-Z]{0,50})" ErrorMessage="Error Nombre Instalador: Se aceptan sólo letras!" Font-Names="Arial" CssClass="ErrorMessage"></asp:RegularExpressionValidator></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="auto-style12">
                                                            <asp:RegularExpressionValidator ID="ER_ape" runat="server" ControlToValidate="txt_apeLector"
                                                                Display="Dynamic" ErrorMessage="Error Apellido Instalador: Se aceptan sólo letras!"
                                                                ValidationExpression="[a-zA-Z]{3,50}([\s]{0,1}[a-zA-Z]{0,50})([\s]{0,1}[a-zA-Z]{0,50})([\s]{0,1}[a-zA-Z]{0,50})" Font-Names="Arial" CssClass="ErrorMessage"></asp:RegularExpressionValidator></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="auto-style13">
                                                            <asp:RegularExpressionValidator ID="ER_codLector" runat="server" ControlToValidate="txt_codLector"
                                                                Display="Dynamic" ErrorMessage="Error Código Instalador: se aceptan sólo numéricos!"
                                                                ValidationExpression="^([0-9]{1,6})$" Font-Names="Arial" CssClass="ErrorMessage"></asp:RegularExpressionValidator></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="auto-style13">
                                                            <asp:RegularExpressionValidator ID="ER_Claveadmin" runat="server" ControlToValidate="txt_claveAdmin"
                                                                Display="Dynamic" ErrorMessage="Error Clave Administrador: se aceptan sólo alfanuméricos!"
                                                                ValidationExpression="^([0-9a-zA-Z]{1,8})$" Font-Names="Arial" CssClass="ErrorMessage"></asp:RegularExpressionValidator></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="auto-style12">
                                                            <asp:RegularExpressionValidator ID="ER_ClaveLector" runat="server" ControlToValidate="txt_ClaveLector"
                                                                Display="Dynamic" ErrorMessage="Error Clave Instalador: se aceptan sólo alfanuméricos!"
                                                                ValidationExpression="^([0-9a-zA-Z]{1,6})$" Font-Names="Arial" CssClass="ErrorMessage"></asp:RegularExpressionValidator></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="auto-style14">
                                                            <asp:Label ID="lb_valida_claves" runat="server" ForeColor="Red" Font-Names="Arial" CssClass="ErrorMessage"></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="auto-style12">
                                                            <asp:RegularExpressionValidator ID="ER_fono1" runat="server" ControlToValidate="txt_num_celular"
                                                                Display="Dynamic" ErrorMessage="Error Numero Celular: se aceptan sólo números!"
                                                                Font-Bold="False" ValidationExpression="^([0-9]{1,50})$" Width="264px" CssClass="ErrorMessage"></asp:RegularExpressionValidator></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="auto-style15">
                                                            <asp:RegularExpressionValidator ID="ER_email" runat="server" ControlToValidate="txt_email"
                                                                ErrorMessage="Error email: Email inválido!" Font-Names="Arial" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"></asp:RegularExpressionValidator></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="auto-style15">
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txt_cantidad"
                                                                Display="Dynamic" ErrorMessage="Error Cantidad: se aceptan sólo numéricos!"
                                                                ValidationExpression="^([0-9]{1,6})$" Font-Names="Arial" CssClass="ErrorMessage"></asp:RegularExpressionValidator>

                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td class="auto-style15">
                                                            <asp:RegularExpressionValidator ID="ER_RUT" runat="server" ControlToValidate="txt_rut"
                                                                Display="Dynamic" ErrorMessage="Error RUT Usuario: Formato incorrecto!" Font-Bold="False"
                                                                ValidationExpression="[0-9]{7,8}" Font-Names="Arial" CssClass="ErrorMessage"></asp:RegularExpressionValidator>

                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="auto-style15">
                                                            <asp:RegularExpressionValidator ID="ER_RUT_DV" runat="server" ControlToValidate="txt_dv"
                                                                Display="Dynamic" ErrorMessage="Error RUT(Dígito Verificador): Sólo números o letra k!"
                                                                Font-Bold="False" ValidationExpression="[0-9kK]{1}" Font-Names="Arial" CssClass="ErrorMessage"></asp:RegularExpressionValidator></td>
                                                    </tr>
                                                </table>
                                                </td>
                                                <td></td>
                                                <td align="right" style="width: 120px"></td>
                                                <td>&nbsp;<asp:Label ID="lb_id_usuario" runat="server" CssClass="Label"></asp:Label></td>
                                            </tr>
                                            <tr>

                                                <td align="right" colspan="5">&nbsp;<asp:Button ID="btnInsertaLector" runat="server" CssClass="botonnew" Text="Agregar Instalador" Width="120px" OnClick="btnInsertaLector_Click" />
                                                    <asp:Button ID="btnCancelar" runat="server" CssClass="botonnew" Text="Cancelar" CausesValidation="False" />
                                                    <asp:Button ID="btnVolver" runat="server" CssClass="botonnew" Text="<< Volver" CausesValidation="False" OnClick="btnVolver_Click" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="5">&nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" class="auto-style11">
                                    <asp:Button ID="btn_aceptar" runat="server" CssClass="botonnew" Text="Aceptar" CausesValidation="False" />
                                </td>
                            </tr>
                        </table>
                        <asp:DataGrid
                            ID="GrillaCortadores_temp" runat="server"  SelectionMode="FullColumnSelect" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4"
                            CssClass="GridAlternativeItems" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" ForeColor="#333333" GridLines="None"
                            Height="1px" OnDeleteCommand="cmDelete" OnEditCommand="MyDataGrid_Edit" Visible="False">
                            <FooterStyle Font-Bold="True" Wrap="False" BackColor="#5D7B9D" ForeColor="White" />
                            <EditItemStyle Wrap="False" BackColor="#999999" />
                            <SelectedItemStyle Font-Bold="True" Wrap="False" BackColor="#E2DED6" ForeColor="#333333" />
                            <PagerStyle BackColor="#284775" BorderColor="Transparent" VerticalAlign="Middle"
                                Wrap="False" ForeColor="White" HorizontalAlign="Center" />
                            <AlternatingItemStyle BackColor="White" Wrap="False" ForeColor="#284775" />
                            <ItemStyle BackColor="#F7F6F3" Wrap="False" ForeColor="#333333" />
                            <Columns>
                                <asp:BoundColumn DataField="id_instalador" HeaderText="IDinstalador" Visible="False">
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
                                <asp:BoundColumn DataField="cod_instalador" HeaderText="CODIGO INSTALADOR">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="apellido" HeaderText="APELLIDOS(S)">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="nombre" HeaderText="NOMBRE(S)">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="nom_empresa" HeaderText="EMPRESA">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="clave_admin" HeaderText="CLAVE ADMIN.">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="clave_instalador" HeaderText="CLAVE INSTALADOR">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="estado" HeaderText="ESTADO">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="cantidad" HeaderText="DESCARGAR">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="version" HeaderText="VERSION">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="fotografia" HeaderText="FOTOGRAFIA">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="numero_telefono" HeaderText="FONO">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="serie_maquina" HeaderText="SERIE MAQUINA">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="id_modelo" HeaderText="MODELO">
                                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="True" Wrap="False" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                </asp:BoundColumn>
                            </Columns>
                            <HeaderStyle BackColor="#5D7B9D" BorderColor="Black" Font-Bold="True" Font-Underline="True" ForeColor="White"
                                Wrap="False" />
                        </asp:DataGrid>

                        <img id="img_ok" runat="server" src="~/FOTOS/ok.bmp" />
                        <asp:Label ID="lb_mensaje_ingreso"
                            runat="server" Font-Names="Arial Unicode MS" CssClass="Label" Font-Size="Small" ForeColor="#0000C0" Height="18px" Width="457px"></asp:Label>
                        <asp:Label ID="lb_error" runat="server" CssClass="ErrorMessage" Font-Names="Arial Unicode MS"
                            Font-Size="Small" ForeColor="Red" Height="18px"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    </div>

</asp:Content>

