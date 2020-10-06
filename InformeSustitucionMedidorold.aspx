﻿<%@ Page Language="C#" AutoEventWireup="true"   CodeFile="InformeSustitucionMedidor.aspx.cs" Inherits="InformeSustitucionMedidor" %>



<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

           <script src="<%=Page.ResolveUrl("~/jquery-1.7.1.min.js") %>" type="text/javascript"></script>

    <script type="text/javascript">
        // Guardando la URL de la imagen del botón imprimir. Esta imagen es una copia de la imagen mostrada en el ReportViewer, guardada en la carpeta de imágenes de la aplicación web.
        var urlImg = '<%=Page.ResolveUrl("~/Imagenes/print_printer.png") %>';

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

        // Función que se encarga de imprimir el reporte
        function imprimirDiv() {
            var divImprimir = $("div[id$='ReportDiv']").parent();    // Obteniendo el DIV que contiene el reporte a imprimir
            var newWin = window.open();    // Abriendo una nueva ventana del navegador
            newWin.document.open();    // Abriendo el documento de la nueva ventana, para escribir su contenido
            newWin.document.write('<html><head><style type="text/css">' + getAllStyleSheetsAsText() + '</style></head><body>' + divImprimir.html() + '</body>');
            newWin.document.close();
            newWin.print();
            newWin.close();
        }

        function getAllStyleSheetsAsText() {
            var cssText = '';
            var sheets = document.styleSheets;
            for (var c = 0; c < sheets.length; c++) {
                var sheet = sheets[c];
                if ((sheet.ownerNode || sheet.owningElement).id.endsWith('_ReportControl_styles')) {
                    var rules = sheet.rules || sheet.cssRules;
                    for (var r = 0; r < rules.length; r++) {
                        var cssRule = rules[r];
                        if ($.browser.msie) {
                            var cssText = cssText + cssRule.selectorText + '{' + cssRule.style.cssText.toLowerCase() + '}';
                        } else {
                            var cssText = cssText + cssRule.cssText;
                        }
                    }
                }
            }
            return cssText;
        }
        
        
</script>

</head>
<body >
    <form id="form1" runat="server" >
                   <asp:GridView ID="GridView1" runat="server" Visible="false"></asp:GridView>
    
    <div id="ReportDiv">      
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Height="1100px" Width="800px" ConsumeContainerWhitespace = "false" ExportContentDisposition="AlwaysAttachment" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
            <LocalReport ReportPath="ReporteSustitucionMed.rdlc">
                <DataSources>
                    <rsweb:ReportDataSource DataSourceId="DataTableSustitucion" Name="DataSetSustitucion" />
                </DataSources>
            </LocalReport>
        </rsweb:ReportViewer>       
    </div>
       
    </form>   
</body>
</html>