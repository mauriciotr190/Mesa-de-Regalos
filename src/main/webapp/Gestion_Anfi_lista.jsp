<%@ page import="basesita.Base" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Objects" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Gestión de Listas de Regalos</title>
    <link rel="stylesheet" href="Estilos/Gestion_Anfi_lista.css" />
    <link rel="stylesheet" href="Estilos/Catalogo.css" />
  </head>
  <body>
  <%
    String idusuario = request.getParameter("id");
  %>
    <!-- Encabezado -->
    <div id="EncabezadoId"></div>
    <script src="scripts/Encabezado.js"></script>
    <main>
      <!-- Sección para la lista de regalos seleccionados -->
      <section id="lista-regalos">
        <h2>Tu Lista de Regalos</h2>
        <div class="micontainer">
          <%

            Base bd = new Base();

            try {
              bd.conectar();
              String strQry = "select imagen, nombre, categoria, descripcion, precio, id_regalo from producto_lista " +
                      "natural join producto " +
                      "where id_usuario = '"+idusuario+"';";

              ResultSet rs = null;

              rs = bd.consulta(strQry);

              while (rs.next()) {

          %>
          <%--        <ul id="lista-seleccionados">--%>
          <%--          <!-- Aquí se mostrarán los regalos seleccionados -->--%>
          <%--        </ul>--%>
          <div class="product-card">
            <img src="<%=rs.getString(1)%>" alt="Producto 1" class="product-image">
            <h2 class="product-name"><%=rs.getString(2)%></h2>
            <p class="product-category"><strong>Categoría:</strong> <%=rs.getString(3)%></p>
            <p class="product-description"><%=rs.getString(4)%></p>
            <p class="product-price"><strong>Precio:</strong> $<%=rs.getString(5)%></p>
            <button class="add-to-cart-btn2" name="eliminar" id="button<%=rs.getString(6)%>" value="<%=rs.getString(6)%>">Eliminar</button>
          </div>

          <%
              }
              bd.cierraConexion();
            } catch (Exception ex) {
              System.out.println(ex.getMessage());
              //out.print(ex.getMessage());
            }
            System.out.println("usuario primera pagina: "+idusuario);
          %>
        </div>

      </section>

      <script>

        // Agregar evento a cada botón
        document.querySelectorAll('button[id^="button"]').forEach(button => {
          button.addEventListener('click', function() {

            const opc = this.name;
            const idprod = this.value;

            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'Gestion_Anfi_lista_B.jsp?busqueda=mensajesecretoquetemandaalapaginainicial&id=<%=idusuario%>';

            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'opc';
            input.value = opc;

            const input3 = document.createElement('input');
            input3.type = 'hidden';
            input3.name = 'idprod';
            input3.value = idprod;

            form.appendChild(input);
            form.appendChild(input3);
            document.body.appendChild(form);
            form.submit();
          });
        });



      </script>

      <!-- Sección para buscar regalos -->
      <section id="buscar-regalos">
        <h2>Buscar Regalos</h2>
        <form id="form-buscar" method="post" action="Gestion_Anfi_lista_A.jsp?id=<%=idusuario%>">
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

        <!-- Resultados de la búsqueda -->
        <div id="resultados-busqueda">
          <h3>Resultados:</h3>
          <ul id="lista-resultados">
            <!-- Aquí se cargarán los resultados dinámicamente -->
          </ul>
        </div>
      </section>
    </main>

    <!-- Pie de página -->
    <div id="footer"></div>
    <script src="scripts/Pie.js"></script>
  </body>
</html>
