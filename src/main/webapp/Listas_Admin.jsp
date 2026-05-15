<%@ page import="basesita.Base" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Objects" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="Estilos/Admin_Listas.css" />
    <title>Administración de Listas de Regalos</title>
  </head>
  <body>
    <!-- Encabezado -->
    <div id="EncabezadoId"></div>
    <script src="scripts/Encabezado.js"></script>

    <main>
      <section class="list-section">
        <h2>Listas de Regalos</h2>
        <!-- Ejemplo para revisar los estilos -->
        <%

          Base bd = new Base();

          try {
            bd.conectar();
            String strQry = "SELECT u.nombre, l.id_lista, l.id_usuario, COUNT(pl.id_regalo) AS cantidad_regalos " +
                "FROM lista l " +
                "INNER JOIN usuario u ON l.id_usuario = u.id_usuario " +
                "LEFT JOIN producto_lista pl ON l.id_lista = pl.id_lista " +
                "GROUP BY l.id_lista, l.id_usuario, u.nombre " +
                "HAVING COUNT(pl.id_regalo) > 0;";

            ResultSet rs = null;

            rs = bd.consulta(strQry);

            while (rs.next()) {
        %>

        <div class="list-card">
            <h3>Lista de: <%=rs.getString("nombre")%></h3>
            <p>Cantidad de regalos: <%=rs.getString("cantidad_regalos")%></p>

            <a href="Admin_listas.jsp?id=<%=rs.getString("id_usuario")%>&idlista=<%=rs.getString("id_lista")%>&name=<%=rs.getString("nombre")%>">
              <button class="btn view-btn">Ver Detalles</button>
            </a>
          </div>

        <%
            }
            bd.cierraConexion();

          } catch (Exception ex) {
            System.out.println(ex.getMessage());
            //out.print(ex.getMessage());
          }
        %>
      </section>
    </main>
  </body>
</html>
