<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Informes.aspx.cs" Inherits="Informes" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

           <script src="<%=Page.ResolveUrl("~/jquery-1.7.1.min.js") %>" type="text/javascript"></script>

    <script type="text/javascript">
        var urlImg = '<%=Page.ResolveUrl("~/Imagenes/imprimir.gif") %>';

        // Función que se ejecuta una vez se ha terminado de cargar el DOM de la página web en el navegador
        $(document).ready(function () {
            colocarBtnImprimir();    // Colocar el botón de imprimir en la barra de herramientas del ReportViewer
            $("#BtnImprimir").click(imprimirDiv);  // Asignando la función "imprimirDiv" al evento click del botón de impresión
        });

        // Esta función coloca el botón de imprimir en la barra de herramientas del ReportViewer
        function colocarBtnImprimir() {
            var jqoBarraRpt = $('div#ReportViewer1_ctl05>div:first-child');    // Buscando el div que contiene la barra de herramientas del RportViewer

            if (jqoBarraRpt && jqoBarraRpt.length > 0    // Verificando que el DIV barra de herramientas fue encontrado,
                && jqoBarraRpt.find('#BtnImprimir').length <= 0) {    // y verificando que el botón de imprimir no existe ya

                // Colocando el botón de impresión, con una estructura similar a la que tiene el botón original en el ReportViewer
                jqoBarraRpt.append('<table cellpadding="0" cellspacing="0" ToolbarSpacer="true" style="display:inline;width:10px;"><tr><td></td></tr></table><div style="display:inline;font-family:Verdana;font-size:8pt;vertical-align:top;"><table cellpadding="0" cellspacing="0" style="display:inline;"><tr><td height="28px"><div"><div id="BtnImprimir"><table title="Print"><tr><td><img title="Print" src="' + urlImg + '" alt="Print" style="border-style:None;height:16px;width:16px;" /></td></tr></table></div><div disabled="disabled" style="display:none;border:1px transparent Solid;"><table title="Print"><tr><td><input type="image" disabled="disabled" title="Print" src="' + urlImg + '" alt="Print" style="border-style:None;height:16px;width:16px;cursor:default;" /></td></tr></table></div></div></td></tr></table></div>');
            }
        }

        function imprimirDiv() {
            var divImprimir = $("div[id$='ReportDiv']").parent();        //Obteniendo el padre del DIV que contiene al reporte
            var estilos = $("head style[id$='ReportControl_styles']");    //Obteniendo los estilos del reporte
            newWin = window.open("");        //Abriendo una nueva ventana

            //Construyendo el HTML de la nueva ventana, con los estilos del reporte y el div que contiene el reporte
            newWin.document.write('<html xmlns="http://www.w3.org/1999/xhtml"><head><style type="text/css">' + estilos.html() + '</style></head><body>' + divImprimir.html() + '</body>');
            newWin.document.close();        //Finalizando la escritura
            newWin.print();        //Imprimir contenido de nueva ventana
            newWin.close();        //Cerrar nueva ventana
        }
</script>

</head>
<body>
    <form id="form1" runat="server" >
    <div>
    
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Height="1100px" Width="800px" ConsumeContainerWhitespace = "false" ExportContentDisposition="AlwaysAttachment" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
            <LocalReport ReportPath="InformeManifiesto.rdlc">
                <DataSources>
                    <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" Name="DataManifiesto" />
                </DataSources>
            </LocalReport>
        </rsweb:ReportViewer>
    
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" TypeName="DataSetComercialTableAdapters."></asp:ObjectDataSource>
    
    </div>
    </form>
    <p>
        </p>
</body>
</html>
