<%@ page import="basesita.Base" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Objects" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Vista de Lista</title>
    <link rel="stylesheet" href="Estilos/Catalogo.css" />
  </head>
  <body>
  <%
    String idlista = request.getParameter("idlista");
    String nombre = request.getParameter("name");
    String idusuario = request.getParameter("idusuario");
  %>

    <div id="EncabezadoId"></div>
    <script src="scripts/Encabezado.js"></script>

    <main id="product-container" class="product-container">
      <h2 class="fullfe">Lista de <%=nombre%></h2>

      <%
        Base bd = new Base();
        boolean hayProductos = false;

        try {
          bd.conectar();

         String strQry = "SELECT p.id_regalo, p.imagen, p.nombre, p.categoria, p.descripcion, p.precio, p.existencias, pl.estado, " +
                "cp.id_regalo AS en_carrito " +
                "FROM producto_lista pl " +
                "INNER JOIN producto p ON pl.id_regalo = p.id_regalo " +
                "LEFT JOIN carrito c ON c.id_usuario = " + idusuario + " " +
                "LEFT JOIN carrito_producto cp ON c.id_carrito = cp.id_carrito " +
                "AND cp.id_lista = pl.id_lista " +
                "AND cp.id_regalo = pl.id_regalo " +
                "WHERE pl.id_lista = '" + idlista + "';";

          ResultSet rs = bd.consulta(strQry);

          while (rs.next()) {
            hayProductos = true;
      %>

      <div class="product-card">
        <img src="<%=rs.getString("imagen")%>" alt="<%=rs.getString("nombre")%>" class="product-image">
        <h2 class="product-name"><%=rs.getString("nombre")%></h2>
        <p class="product-category"><strong>Categoría:</strong> <%=rs.getString("categoria")%></p>
        <p class="product-description"><%=rs.getString("descripcion")%></p>
        <p class="product-price"><strong>Precio:</strong> $<%=rs.getString("precio")%></p>

      
         <%
        String estado = rs.getString("estado");
        int existencias = rs.getInt("existencias");
        String enCarrito = rs.getString("en_carrito");

        if (existencias <= 0) {
        %>

        <button class="add-to-cart-btn" disabled>No disponible</button>

        <%
        } else if ("comprado".equals(estado)) {
        %>

        <button class="add-to-cart-btn" disabled>Comprado</button>

        <%
        } else if (enCarrito != null) {
        %>

        <button class="add-to-cart-btn" disabled>Ya está en tu carrito</button>

        <%
        } else {
        %>

        <a href="Carrito_A.jsp?op=agregar&idusuario=<%=idusuario%>&idlista=<%=idlista%>&idregalo=<%=rs.getString("id_regalo")%>&name=<%=nombre%>">
          <button class="add-to-cart-btn">Agregar al carrito</button>
        </a>

        <%
        }
        %>
      </div>

      <%
          }

          if (!hayProductos) {
      %>

      <p class="fullfe">Esta lista no tiene productos agregados.</p>

      <%
          }

          bd.cierraConexion();

        } catch (Exception ex) {
          System.out.println(ex.getMessage());
      %>

      <p class="fullfe">Ocurrió un error al cargar la lista.</p>

      <%
        }
      %>

    </main>

    <div id="footer"></div>
    <script src="scripts/Pie.js"></script>
  </body>
</html>