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
            String strQry = "select nombre, count(producto_lista.id_usuario), producto_lista.id_usuario from producto_lista " +
                    "natural join usuario " +
                    "group by producto_lista.id_usuario;";

            ResultSet rs = null;

            rs = bd.consulta(strQry);

            while (rs.next()) {
        %>

        <div class="list-card">
          <h3>Lista de: <%=rs.getString(1)%></h3>
          <p>Cantidad de regalos: <%=rs.getString(2)%></p>
          <a href="Admin_listas.jsp?id=<%=rs.getString(3)%>&name=<%=rs.getString(1)%>">
            <button class="btn view-btn">Ver Detalles</button>
          </a>

<%--          <button class="btn delete-btn">Eliminar Lista</button>--%>
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
