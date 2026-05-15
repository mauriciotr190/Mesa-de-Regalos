<%@ page import="basesita.Base" %>
<%@ page import="java.sql.ResultSet" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
String idInvitado = request.getParameter("id");
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="Estilos/Admin_Listas.css" />
  <title>Mis invitaciones</title>
</head>
<body>

<div id="EncabezadoId"></div>
<script src="scripts/Encabezado.js"></script>

<% if (idInvitado == null) { %>
<script>
  const id = localStorage.getItem("id");
  window.location.href = "Listas_invitado.jsp?id=" + id;
</script>
<% } %>

<main>
  <section class="list-section">
    <h2>Listas a las que estás invitado</h2>

    <%
      Base bd = new Base();

      
      
      try {
        bd.conectar();

        String strQry =
          "SELECT u.nombre, l.id_lista, l.id_usuario, COUNT(pl.id_regalo) AS cantidad_regalos " +
          "FROM invitado_lista il " +
          "INNER JOIN lista l ON il.id_lista = l.id_lista " +
          "INNER JOIN usuario u ON l.id_usuario = u.id_usuario " +
          "INNER JOIN producto_lista pl ON l.id_lista = pl.id_lista " +
          "WHERE il.id_usuario = " + idInvitado + " " +
          "GROUP BY l.id_lista, l.id_usuario, u.nombre " +
          "HAVING COUNT(pl.id_regalo) > 0;";

        ResultSet rs = bd.consulta(strQry);

        boolean hayListas = false;
        
        while (rs.next()) {
            hayListas = true;
    %>

    <div class="list-card">
      <h3>Lista de: <%=rs.getString("nombre")%></h3>
      <p>Cantidad de regalos: <%=rs.getString("cantidad_regalos")%></p>

      <a href="Invitado_listas.jsp?idusuario=<%=idInvitado%>&idlista=<%=rs.getString("id_lista")%>&name=<%=rs.getString("nombre")%>">
        <button class="btn view-btn">Ver Detalles</button>
      </a>
    </div>

    <%
        }

        if (!hayListas) {
%>

<p class="empty-message">No te han invitado a ninguna lista.</p>

<%
}

        bd.cierraConexion();

      } catch (Exception ex) {
        System.out.println(ex.getMessage());
      }
    %>
  </section>
</main>

</body>
</html>