<%@ page import="basesita.Base" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Objects" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Catálogo de Productos</title>
    <link rel="stylesheet" href="Estilos/Catalogo.css" />
  </head>
  <body>
    <!-- Encabezado -->
    <div id="EncabezadoId"></div>
    <script src="scripts/Encabezado.js"></script>
    <main id="product-container" class="product-container">
      <div class="fullfe">
        <h2>Buscar Regalos</h2>
        <form id="form-buscar" method="post" action="Catalogo_A.jsp">
          <label for="categoria">Categoría:</label>
          <select id="categoria" name="categoria">
            <option value="">-- Seleccionar --</option>
            <option value="boda">Boda</option>
            <option value="xv">XV Años</option>
            <option value="bautizo">Bautizo</option>
            <option value="infantil">Infantil</option>
            <option value="para_el">Para Él</option>
            <option value="para_ella">Para Ella</option>
          </select>

          <label for="nombre">Nombre del regalo:</label>
          <input
                  type="text"
                  id="nombre"
                  name="nombre"
                  placeholder="Buscar por nombre"
          />

          <button type="submit">Buscar</button>
        </form>
      </div>

      <!-- Los productos se agregarán dinámicamente aquí -->

      <%

        Base bd = new Base();

        try {
          bd.conectar();
          String strQry = "select imagen, nombre, categoria, descripcion, precio, existencias, id_regalo from producto;";

          ResultSet rs = null;

          rs = bd.consulta(strQry);

          int ex;
          while (rs.next()) {

            ex = Integer.parseInt(rs.getString(6));
      %>

      <div class="product-card">
        <img src="<%=rs.getString(1)%>" alt="Producto 1" class="product-image">
        <h2 class="product-name"><%=rs.getString(2)%></h2>
        <p class="product-category"><strong>Categoría:</strong> <%=rs.getString(3)%></p>
        <p class="product-description"><%=rs.getString(4)%></p>
        <p class="product-price"><strong>Precio:</strong> $<%=rs.getString(5)%></p>
        <%if (ex >= 1) { %>
        <button class="add-to-cart-btn" data-id="<%=rs.getString(7)%>">Disponible</button>
        <%} else {%>
        <button class="add-to-cart-btn" data-id="<%=rs.getString(7)%>" disabled>No disponible</button>
        <%}%>
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
