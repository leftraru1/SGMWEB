<%@ Page Language="VB" AutoEventWireup="false" CodeFile="INSERTAR_SUBMENU.aspx.vb" Inherits="INSERTAR_SUBMENU" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ListBox ID="ListBox1" runat="server" Height="341px" Width="867px">
            <asp:ListItem>insert into SUBMENU(id_submenu,id_menu,menu,nombre,link,estado) values (1,1,'RECEPCION DE LECTURAS','XX','RecepcionLecturas.aspx',0);</asp:ListItem>
            <asp:ListItem>insert into SUBMENU(id_submenu,id_menu,menu,nombre,link,estado) values (2,1,'ASIGNACION DE LECTURAS','XX','AsignacionLecturas.aspx',0);</asp:ListItem>
            <asp:ListItem>insert into SUBMENU(id_submenu,id_menu,menu,nombre,link,estado) values (3,1,'GENERADOR DE REPASOS','XX','GeneradorRepasos.aspx',0);</asp:ListItem>
            <asp:ListItem>insert into SUBMENU(id_submenu,id_menu,menu,nombre,link,estado) values (4,1,'CARGA MANUAL ARCHIVO','XX','CargaManual.aspx',0);</asp:ListItem>
            <asp:ListItem>insert into SUBMENU(id_submenu,id_menu,menu,nombre,link,estado) values (5,1,'CARGA LECTURAS DESCARGADAS','XX','CargaLectDescargadas.aspx',0);</asp:ListItem>
            <asp:ListItem>insert into SUBMENU(id_submenu,id_menu,menu,nombre,link,estado) values (6,1,'GENERACION SALIDA LECTURAS','XX','GeneraSalidaLecturas.aspx',0);</asp:ListItem>
            <asp:ListItem>insert into SUBMENU(id_submenu,id_menu,menu,nombre,link,estado) values (7,1,'TRANSFERENCIA SGL a SGC','XX','TransferenciaSistemas.aspx',0);</asp:ListItem>
            <asp:ListItem>insert into SUBMENU(id_submenu,id_menu,menu,nombre,link,estado) values (8,2,'MANTENEDOR DE LECTURAS','XX','MantencionLecturas.aspx',0);</asp:ListItem>
            <asp:ListItem>insert into SUBMENU(id_submenu,id_menu,menu,nombre,link,estado) values (8,2,'MANTENEDOR DE LECTURAS','XX','MantencionLecturas.aspx',0);</asp:ListItem>
            <asp:ListItem>insert into SUBMENU(id_submenu,id_menu,menu,nombre,link,estado) values (9,2,'PERFILES DE USUARIO','XX','PerfilesUsuario.aspx',0);</asp:ListItem>
            <asp:ListItem>insert into SUBMENU(id_submenu,id_menu,menu,nombre,link,estado) values (10,2,'MANTENEDOR DE CATASTROS','XX','MantencionCatastros.aspx',0);</asp:ListItem>
            <asp:ListItem>insert into SUBMENU(id_submenu,id_menu,menu,nombre,link,estado) values (11,2,'MANTENEDOR DE USUARIOS','XX','MantencionUsuarios.aspx',0);</asp:ListItem>
            <asp:ListItem>insert into SUBMENU(id_submenu,id_menu,menu,nombre,link,estado) values (12,2,'MANTENEDOR DE LECTORES','XX','MantencionUsuarios.aspx',0);</asp:ListItem>
            <asp:ListItem>insert into SUBMENU(id_submenu,id_menu,menu,nombre,link,estado) values (13,2,'MANTENEDOR DE LOCALIDADES','XX','MantencionLocalidades.aspx',0);</asp:ListItem>
            <asp:ListItem>insert into SUBMENU(id_submenu,id_menu,menu,nombre,link,estado) values (14,3,'ANALIZADOR DE LECTURAS','XX','AnalizadorLecturas.aspx',0);</asp:ListItem>
            <asp:ListItem>insert into SUBMENU(id_submenu,id_menu,menu,nombre,link,estado) values (15,5,'GENERACION ARCHIVOS PDA','XX','GeneraXMLPDA.aspx',0);</asp:ListItem>
            <asp:ListItem>insert into SUBMENU(id_submenu,id_menu,menu,nombre,link,estado) values (16,3,'VISOR ESTADOS DE LECTURAS','XX','VisorEstadosLecturas.aspx',0);</asp:ListItem>
            <asp:ListItem>commit;</asp:ListItem>
        </asp:ListBox>
        <asp:Button ID="Button1" runat="server" Text="Insertar" /></div>
    </form>
</body>
</html>
