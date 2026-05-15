<%-- 
    Document   : Carrito
    Created on : May 15, 2026, 11:24:36 AM
    Author     : maurisio
--%>

<%@ page import="basesita.Base" %>
<%@ page import="java.sql.ResultSet" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String idusuario = request.getParameter("id");
    String mensaje = "";
    String compra = request.getParameter("compra");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carrito</title>
    <link rel="stylesheet" href="Estilos/Catalogo.css">
</head>
<body>



<div id="EncabezadoId"></div>
<script src="scripts/Encabezado.js"></script>

<main id="product-container" class="product-container">
    <h2 class="fullfe">Mi carrito</h2>
    
    <%
if ("ok".equals(compra)) {
%>

<p class="success-message">
    ¡Compra realizada correctamente!
</p>

<%
}
%>
    

<%
    Base bd = new Base();
    boolean hayProductos = false;
    double total = 0;

    try {
        bd.conectar();
        
        String validarDisponibles =
            "SELECT COUNT(*) AS eliminados " +
            "FROM carrito c " +
            "INNER JOIN carrito_producto cp ON c.id_carrito = cp.id_carrito " +
            "INNER JOIN producto p ON cp.id_regalo = p.id_regalo " +
            "INNER JOIN producto_lista pl ON cp.id_lista = pl.id_lista AND cp.id_regalo = pl.id_regalo " +
            "WHERE c.id_usuario = " + idusuario + " " +
            "AND (p.existencias <= 0 OR pl.estado = 'comprado');";

        ResultSet rsEliminados = bd.consulta(validarDisponibles);

        int eliminados = 0;

        if (rsEliminados.next()) {
            eliminados = rsEliminados.getInt("eliminados");
        }

        if (eliminados > 0) {
            String quitarNoDisponibles =
                "DELETE cp FROM carrito_producto cp " +
                "INNER JOIN carrito c ON cp.id_carrito = c.id_carrito " +
                "INNER JOIN producto p ON cp.id_regalo = p.id_regalo " +
                "INNER JOIN producto_lista pl ON cp.id_lista = pl.id_lista AND cp.id_regalo = pl.id_regalo " +
                "WHERE c.id_usuario = " + idusuario + " " +
                "AND (p.existencias <= 0 OR pl.estado = 'comprado');";

            bd.insertar(quitarNoDisponibles);

            mensaje = "Se quitaron productos del carrito porque ya no están disponibles.";
        }
 if (!mensaje.equals("")) { %>
 
        <p class="fullfe"><%=mensaje%></p>
    <% } 
    
        String strQry = "SELECT p.id_regalo, p.imagen, p.nombre, p.categoria, p.descripcion, p.precio, " +
                        "cp.id_lista, u.nombre AS anfitrion " +
                        "FROM carrito c " +
                        "INNER JOIN carrito_producto cp ON c.id_carrito = cp.id_carrito " +
                        "INNER JOIN producto p ON cp.id_regalo = p.id_regalo " +
                        "INNER JOIN lista l ON cp.id_lista = l.id_lista " +
                        "INNER JOIN usuario u ON l.id_usuario = u.id_usuario " +
                        "WHERE c.id_usuario = " + idusuario + ";";

        ResultSet rs = bd.consulta(strQry);

        while (rs.next()) {
            hayProductos = true;
            total += rs.getDouble("precio");
%>

    <div class="product-card">
        <img src="<%=rs.getString("imagen")%>" alt="<%=rs.getString("nombre")%>" class="product-image">
        <h2 class="product-name"><%=rs.getString("nombre")%></h2>

        <p class="product-category">
            <strong>Categoría:</strong> <%=rs.getString("categoria")%>
        </p>

        <p class="product-description"><%=rs.getString("descripcion")%></p>

        <p class="product-price">
            <strong>Precio:</strong> $<%=rs.getString("precio")%>
        </p>

        <p>
            <strong>Lista de:</strong> <%=rs.getString("anfitrion")%>
        </p>

        <a href="Carrito_A.jsp?op=quitar&idusuario=<%=idusuario%>&idlista=<%=rs.getString("id_lista")%>&idregalo=<%=rs.getString("id_regalo")%>">
            <button class="add-to-cart-btn">Quitar del carrito</button>
          </a>
    </div>

<%
        }

        if (!hayProductos) {
%>

    <p class="fullfe">Tu carrito está vacío.</p>

<%
        } else {
%>

    <div class="cart-summary">
        <h2>Total: $<%=total%></h2>

        <a href="Carrito_A.jsp?op=comprar&idusuario=<%=idusuario%>">
            <button class="add-to-cart-btn">Confirmar compra</button>
        </a>
    </div>

<%
        }

        bd.cierraConexion();

    } catch (Exception ex) {
        System.out.println(ex.getMessage());
%>

    <p class="fullfe">Ocurrió un error al cargar el carrito.</p>

<%
    }
%>

</main>

<div id="footer"></div>
<script src="scripts/Pie.js"></script>

</body>
</html>