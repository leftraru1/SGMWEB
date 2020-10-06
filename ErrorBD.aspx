<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ErrorBD.aspx.vb" Inherits="ErrorBD" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Error de conexión...</title>
    <link type="text/css" rel="stylesheet" href="estilos/page.css">
    <link type="text/css" rel="stylesheet" href="estilos/controls.css">
    <link type="text/css" rel="stylesheet" href="estilos/grid.css">
    <link type="text/css" rel="stylesheet" href="estilos/webpart.css">
    <link type="text/css" rel="stylesheet" href="estilos/menu.css">
    <link type="text/css" rel="stylesheet" href="estilos/others.css">
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 758px;
            height: 23px" width="758">
            <tr>
                <td style="width: 732px">
                    <div class="WebPartShadow_ext">
                        <div class="WebPartTitle_ext">
                            Alerta Error de Conexion a la base de datos...!</div>
                        <table align="center" border="0" cellspacing="4" style="width: 709px; height: 66px"
                            width="709">
                            <tr>
                                <td align="left" colspan="2" nowrap="nowrap" style="height: 15px">
                                    <h2>
                                        Estimado Usuario se ha producido un error con la conexión a la base de datos, seleccione
                                        su opción:&nbsp;</h2>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="height: 3px">
                                    <a href="javascript:history.back(1)">VOLVER A INTENTAR</a>&nbsp;
                                    <a href="javascript:history.back(1)"><< VOLVER ATRAS</a>&nbsp;
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
