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
    String iduser = request.getParameter("id");
    String nombre = request.getParameter("name");
  %>
    <!-- Encabezado -->
    <div id="EncabezadoId"></div>
    <script src="scripts/Encabezado.js"></script>
    <main id="product-container" class="product-container">
      <h2 class="fullfe">Lista de <%=nombre%></h2>
      <!-- Los productos se agregarán dinámicamente aquí -->

      <%

        Base bd = new Base();

        try {
          bd.conectar();
          String strQry = "select imagen, nombre, categoria, descripcion from producto " +
                  "natural join producto_lista " +
                  "where id_usuario = '"+iduser+"';";

          ResultSet rs = null;

          rs = bd.consulta(strQry);

          while (rs.next()) {
      %>

      <div class="product-card">
        <img src="<%=rs.getString(1)%>" alt="Producto 1" class="product-image">
        <h2 class="product-name"><%=rs.getString(2)%></h2>
        <p class="product-category"><strong>Categoría:</strong> <%=rs.getString(3)%></p>
        <p class="product-description"><%=rs.getString(4)%></p>
      </div>

      <%
          }
          bd.cierraConexion();

        } catch (Exception ex) {
          System.out.println(ex.getMessage());
          //out.print(ex.getMessage());
        }
      %>

    </main>
    <!--<script src="scripts/Catalogo.js"></script>-->
    <!-- Pie de página -->
    <div id="footer"></div>
    <script src="scripts/Pie.js"></script>
  </body>
</html>
