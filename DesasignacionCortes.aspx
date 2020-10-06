<%@ Page Language="VB" AutoEventWireup="false" CodeFile="DesasignacionCortes.aspx.vb" Inherits="DesasignacionCortes" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Eliminación de Asignaciones - Sistema CYR</title>
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

      
<%--<script language="JavaScript1.2">
window.moveTo(0,0);
top.window.resizeTo(screen.availWidth,screen.availHeight);
</script>   --%>    
       
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div>
        &nbsp;</div>
        <table id="tbl_inicio" runat="server" align="center" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 732px">
                    <asp:Label ID="Lb_user" runat="server" CssClass="Label" Font-Bold="False" Font-Underline="True">Sesión</asp:Label><asp:Label
                        ID="lb_session_user" runat="server" CssClass="Label"></asp:Label><asp:Label ID="lb_empresa"
                            runat="server" CssClass="Label" Font-Bold="False" Font-Underline="True">Empresa</asp:Label><asp:Label
                                ID="lb_session_empresa" runat="server" CssClass="Label"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 732px">
                    <div class="WebPartShadow">
                        <table align="center" border="0" cellspacing="0">
                            <tr runat="server">
                                <td align="left" class="WebPartTitle" colspan="2" nowrap="nowrap" style="width: 41%;
                                    height: 15px">
                                    Eliminación de Asignaciones (Desasignación de Cortes):</td>
                            </tr>
                            <tr id="Tr1" runat="server">
                                <td align="left" colspan="2" nowrap="nowrap" style="width: 41%; height: 15px">
                                    <h2>
                                        Seleccione valores deseados en los filtros siguientes:</h2>
                                </td>
                            </tr>
                            <tr id="Tr2" runat="server">
                                <td align="right" nowrap="nowrap" style="width: 219px; height: 15px">
                                    <h2>
                                        Operador:&nbsp;
                                    </h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 418px; height: 15px">
                                    <asp:DropDownList ID="combo_lectores" runat="server" CssClass="ComboBox" Width="274px" AutoPostBack="True">
                                    </asp:DropDownList>
                                    </td>
                            </tr>
                            <tr runat="server">
                                <td align="right" nowrap="nowrap" style="width: 219px; height: 15px">
                                   <h2> Proceso:&nbsp;</h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 418px; height: 15px"><asp:DropDownList ID="combo_lotes" runat="server" CssClass="ComboBox" Width="170px" AutoPostBack="True">
                                </asp:DropDownList>
                                    <asp:Label ID="lb_codigos_contratistas" runat="server"></asp:Label></td>
                            </tr>
                            <tr id="Tr8" runat="server">
                                <td align="right" nowrap="nowrap" style="width: 219px; height: 15px">
                                    <h2>
                                        Localidad:&nbsp;</h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 418px; height: 15px">
                                    <asp:DropDownList ID="combo_localidades" runat="server" CssClass="ComboBox" Width="170px" AutoPostBack="True">
                                    </asp:DropDownList>
                                    <asp:Label ID="lb_cantidad_contratistas" runat="server"></asp:Label></td>
                            </tr>
                            <tr runat="server">
                                <td align="right" nowrap="nowrap" style="width: 219px; height: 15px">
                                   <h2> 
                                        Ruta:&nbsp;
                                   </h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 418px; height: 15px">
                                    <asp:DropDownList ID="combo_ruta" runat="server" CssClass="ComboBox" Width="170px" AutoPostBack="True">
                                    </asp:DropDownList></td>
                            </tr>
                            <tr id="Tr4" runat="server">
                                <td align="right" nowrap="nowrap" style="width: 219px; height: 9px">
                                    <h2>
                                        Estado de Asignación:&nbsp;
                                    </h2>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 418px; height: 9px">
                                    <asp:DropDownList ID="combo_estados" runat="server" CssClass="ComboBox" Width="170px" AutoPostBack="True">
                                        <asp:ListItem Value="0">Todas...</asp:ListItem>
                                    <asp:ListItem Value="2">En Proceso Asignaci&#243;n</asp:ListItem>
                                    <asp:ListItem Value="3">Asignaci&#243;n Liberada </asp:ListItem>
                                    <asp:ListItem Value="4">Cargado en PDA</asp:ListItem>
                                </asp:DropDownList></td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="height: 3px">
                                    <asp:Label ID="LB_ID_USUARIO" runat="server" CssClass="Label"></asp:Label>
                                    <asp:Label ID="LB_RUT_EMPRESA" runat="server" CssClass="Label"></asp:Label>
                                    <asp:Button ID="btnFiltra" runat="server" CssClass="botonnew" Text="Filtrar" /></td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
    
    </div>
        <table id="tbl_principal" runat="server" align="center" border="0" cellpadding="0"
            cellspacing="0">
            <tr>
                <td style="height: 364px">
                    <div class="WebPartShadow">
                        <div id="titulo_mod" runat="server" class="WebPartTitle">
                            Resultados...</div>
                        <table align="center" border="0" cellspacing="0">
                            <tr>
                                <td align="left" colspan="2">
                                    <div id="div_grilla" runat="server" class="WebPartShadow" style="text-align: justify">
                                        <table id="Table2" align="center" border="0" cellspacing="0">
                                            <tr style="color: #000000">
                                                <td align="right" colspan="2" style="width: 760px; height: 3px;">
                                                    <asp:LinkButton ID="lk_Desmarca_checks" runat="server" CausesValidation="False" ForeColor="Blue" CssClass="Label">Desmarcar Todos</asp:LinkButton>
                                                    &nbsp; &nbsp;<asp:LinkButton
                                                        ID="lk_Marca_checks" runat="server" CausesValidation="False" ForeColor="Blue" CssClass="Label">Marcar Todos</asp:LinkButton></td>
                                            </tr>
                                            <tr style="color: #000000">
                                                <td align="center" colspan="2" style="width: 760px; height: 2px; text-align: left">
                                                    &nbsp;<asp:Label ID="Label1" runat="server" Text="0 coincidencia(s) encontrada(s)"
                                                        Width="464px" CssClass="Label"></asp:Label>
                                                    <asp:DataGrid ID="GrillaPrincipal" runat="server" AutoGenerateColumns="False"
                                                        BorderColor="#003366" BorderStyle="Solid" BorderWidth="0px" CellPadding="1" CellSpacing="1"
                                                        CssClass="GridAlternativeItems" ForeColor="Black" GridLines="Horizontal"
                                                        Width="757px">
                                                        <PagerStyle BackColor="Control" BorderColor="Transparent" Font-Bold="True" Font-Italic="False"
                                                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center"
                                                            VerticalAlign="Middle" />
                                                        <AlternatingItemStyle BackColor="White" />
                                                        <ItemStyle BackColor="White" HorizontalAlign="Center" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                        <HeaderStyle BackColor="CornflowerBlue" BorderColor="Black" Font-Bold="True" Font-Underline="True"
                                                            ForeColor="White" HorizontalAlign="Center" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" />
                                                        <Columns>
                                                            <asp:BoundColumn DataField="id_grupoproceso" HeaderText="IDGrupo Proceso" Visible="False">
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="id_lector" HeaderText="IDLector" Visible="False"></asp:BoundColumn>
                                                            <asp:BoundColumn DataField="id_sincronizacion" HeaderText="ID Sincroniza" Visible="False">
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="id_localidad" HeaderText="IDLocalidad" Visible="False"></asp:BoundColumn>
                                                            <asp:BoundColumn DataField="cod_localidad" HeaderText="C&#243;digo Localidad">
                                                                <HeaderStyle Width="15%" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="nom_localidad" HeaderText="Localidad">
                                                                <HeaderStyle Width="25%" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="libreta" HeaderText="Ruta">
                                                                <HeaderStyle Width="10%" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="asignadas" HeaderText="Asignadas">
                                                                <HeaderStyle Width="20%" />
                                                            </asp:BoundColumn>
                                                            <asp:BoundColumn DataField="tipo_asignacion" HeaderText="Tipo Asignaci&#243;n"></asp:BoundColumn>
                                                            <asp:TemplateColumn HeaderText="Des-Asignar Cortes">
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="check_desasigna" runat="server" />
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="15%" />
                                                            </asp:TemplateColumn>
                                                        </Columns>
                                                    </asp:DataGrid></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <img id="img_ok" runat="server" src="fotos/ok.bmp" /><asp:Label ID="lb_mensaje_ok"
                                        runat="server" BackColor="Transparent" Font-Names="Arial Unicode MS" Font-Size="Small"
                                        ForeColor="#0000C0" Width="524px">Los Cortes fueron desasignados exitosamente!</asp:Label></td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="height: 1px">
                                    <table cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td align="left" style="height: 20px;" colspan="2">
                                                <h2>
                                                    &nbsp;
                                                </h2>
                                                &nbsp;<asp:Button ID="btnDesasignaTramo" runat="server" CssClass="botonnew" Text="Des-Asignar Tramo"
                                                    Width="124px" />
                                                <asp:Button ID="btnVolver" runat="server" CssClass="botonnew" Text="<< Volver " /></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
