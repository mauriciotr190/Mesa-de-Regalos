<%-- 
    Document   : Carrito_A
    Created on : May 15, 2026, 12:25:32 PM
    Author     : maurisio
--%>

<%@ page import="basesita.Base" %>
<%@ page import="java.sql.ResultSet" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        si les esto es por que algo salio mal xd
        
<%
String op = request.getParameter("op");
String idusuario = request.getParameter("idusuario");
String idlista = request.getParameter("idlista");
String idregalo = request.getParameter("idregalo");
String nombre = request.getParameter("name");

Base bd = new Base();

try {
    bd.conectar();

    if ("agregar".equals(op)) {

        String buscarCarrito = "SELECT id_carrito FROM carrito WHERE id_usuario = " + idusuario + ";";
        ResultSet rs = bd.consulta(buscarCarrito);

        String idcarrito = "";

        if (rs.next()) {
            idcarrito = rs.getString("id_carrito");
        } else {
            String crearCarrito = "INSERT INTO carrito(id_usuario) VALUES(" + idusuario + ");";
            bd.insertar(crearCarrito);

            ResultSet rsNuevo = bd.consulta(buscarCarrito);
            if (rsNuevo.next()) {
                idcarrito = rsNuevo.getString("id_carrito");
            }
        }

        String validar =
            "SELECT * FROM carrito_producto " +
            "WHERE id_carrito = " + idcarrito + " " +
            "AND id_lista = " + idlista + " " +
            "AND id_regalo = " + idregalo + ";";

        ResultSet rsVal = bd.consulta(validar);

        if (!rsVal.next()) {
            String insertar =
                "INSERT INTO carrito_producto(id_carrito, id_lista, id_regalo) " +
                "VALUES(" + idcarrito + ", " + idlista + ", " + idregalo + ");";

            bd.insertar(insertar);
        }

        bd.cierraConexion();
        response.sendRedirect("Invitado_listas.jsp?idusuario=" + idusuario + "&idlista=" + idlista + "&name=" + nombre);
    }

    else if ("quitar".equals(op)) {

        String quitar =
            "DELETE cp FROM carrito_producto cp " +
            "INNER JOIN carrito c ON cp.id_carrito = c.id_carrito " +
            "WHERE c.id_usuario = " + idusuario + " " +
            "AND cp.id_lista = " + idlista + " " +
            "AND cp.id_regalo = " + idregalo + ";";

        bd.insertar(quitar);

        bd.cierraConexion();
        response.sendRedirect("Carrito.jsp?id=" + idusuario);
    }

    else if ("comprar".equals(op)) {

        String productos =
            "SELECT cp.id_lista, cp.id_regalo " +
            "FROM carrito c " +
            "INNER JOIN carrito_producto cp ON c.id_carrito = cp.id_carrito " +
            "INNER JOIN producto p ON cp.id_regalo = p.id_regalo " +
            "INNER JOIN producto_lista pl ON cp.id_lista = pl.id_lista AND cp.id_regalo = pl.id_regalo " +
            "WHERE c.id_usuario = " + idusuario + " " +
            "AND p.existencias > 0 " +
            "AND pl.estado = 'pendiente';";

        ResultSet rsProductos = bd.consulta(productos);

        while (rsProductos.next()) {
            String idListaCompra = rsProductos.getString("id_lista");
            String idRegaloCompra = rsProductos.getString("id_regalo");

            String actualizarLista =
                "UPDATE producto_lista " +
                "SET estado = 'comprado' " +
                "WHERE id_lista = " + idListaCompra + " " +
                "AND id_regalo = " + idRegaloCompra + ";";

            bd.insertar(actualizarLista);

            String bajarStock =
                "UPDATE producto " +
                "SET existencias = existencias - 1 " +
                "WHERE id_regalo = " + idRegaloCompra + ";";

            bd.insertar(bajarStock);
        }

        String limpiar =
            "DELETE cp FROM carrito_producto cp " +
            "INNER JOIN carrito c ON cp.id_carrito = c.id_carrito " +
            "WHERE c.id_usuario = " + idusuario + ";";

        bd.insertar(limpiar);

        String borrarCarrito =
            "DELETE FROM carrito WHERE id_usuario = " + idusuario + ";";

        bd.insertar(borrarCarrito);

        bd.cierraConexion();
        response.sendRedirect("Carrito.jsp?id=" + idusuario + "&compra=ok");
    }

} catch (Exception ex) {
    System.out.println(ex.getMessage());
    out.print("Error en la operación del carrito.");
}
%>
    </body>
</html>
