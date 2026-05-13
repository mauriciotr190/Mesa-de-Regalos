<%@ page import="basesita.Base" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Objects" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Gestión de Catálogo de Regalos</title>
      <link rel="stylesheet" href="Estilos/Catalogo.css" />
    <link rel="stylesheet" href="Estilos/Cat_Admin_Modi.css" />
  </head>
  <body>
  <%
      String busqueda = request.getParameter("busqueda");
  %>
    <!-- Encabezado -->
    <div id="EncabezadoId"></div>
    <script src="scripts/Encabezado.js"></script>
    <main id="product-container" class="product-container2">
    <header>
      <h1>Gestión de Catálogo de Regalos para Eventos</h1>
    </header>

    <div class="Container_form">
        <!-- Formulario -->
        <section class="form-section">
        <h2>Formulario de Administración</h2>
        <form id="catalog-form" action="Catalogo_Admin_Modif_B.jsp?busqueda=<%=busqueda%>" method="POST">
            <input
                    type="text"
                    id="product-id"
                    hidden="hidden"
                    name="idregalo"
            />
            <button type="button" id="limpiarFormulario">Limpiar</button>
            <div class="form-group">
            <label for="product-name">Nombre del producto:</label>
            <input
                type="text"
                id="product-name"
                placeholder="Escribe el nombre del producto"
                name="nombre"
                required
            />
            </div>
            <div class="form-group">
            <label for="product-description">Descripción:</label>
            <textarea
                id="product-description"
                placeholder="Escribe una breve descripción"
                name="descripcion"
                required
            ></textarea>
            </div>
            <div class="form-group">
            <label for="product-price">Precio:</label>
            <input
                type="number"
                id="product-price"
                placeholder="Ej. 199.99"
                step="0.01"
                name="precio"
                required
            />
            </div>
            <div class="form-group">
                <label for="product-quantity">Existencias:</label>
                <input
                        type="number"
                        id="product-quantity"
                        placeholder="Ej. 5"
                        step="0.01"
                        name="hay"
                        required
                />
            </div>
            <div class="form-group">
            <label for="product-category">Categoría:</label>
            <select id="product-category" name="categoria" required>
                <option value="">Selecciona una categoría</option>
                <option value="Boda">Boda</option>
                <option value="XV">XV Años</option>
                <option value="Bautizo">Bautizos</option>
                <option value="Infantil">Infantiles</option>
                <option value="Para_el">Para él</option>
                <option value="Para_ella">Para ella</option>
            </select>
            </div>
            <div class="form-group">
            <label for="product-image">Imagen del producto (URL):</label>
            <input
                type="url"
                id="product-image"
                placeholder="https://example.com/imagen.jpg"
                name="imagen"
                required
            />
            </div>
            <div class="form-actions">
                <button type="submit" name="botons" id="subir" disabled>Llena todos los campos para crear</button>
                <button type="submit" name="botons" value="eliminar" id="delete-btn" disabled>Selecciona un producto para modificar o eliminar</button>
            </div>
        </form>
        </section>
    </div>

    <section class="catalog-section">
      <h2>Catálogo de Productos</h2>
        <form method="post" action="Catalogo_Admin_Modif_A.jsp">
            <div class="search-bar">
                <input type="text" name="busqueda" id="search-bar" placeholder="Buscar producto..." />
            </div>
        </form>
      <div id="product-catalog" class="product-catalog">
          <!-- Los productos se agregarán dinámicamente aquí -->

          <%

              Base bd = new Base();

              try {
                  bd.conectar();
                  String strQry = "select imagen, nombre, categoria, descripcion, precio, existencias, id_regalo from producto where nombre like '%"+busqueda+"%';";

                  ResultSet rs = null;

                  rs = bd.consulta(strQry);

                  while (rs.next()) {

          %>

          <div class="product-card">
              <img src="<%=rs.getString(1)%>" alt="Producto 1" class="product-image">
              <h2 class="product-name"><%=rs.getString(2)%></h2>
              <p class="product-category"><strong>Categoría:</strong> <%=rs.getString(3)%></p>
              <p class="product-description"><%=rs.getString(4)%></p>
              <p class="product-description"><strong>Existencias:</strong><%=rs.getString(6)%></p>
              <p class="product-price"><strong>Precio:</strong> $<%=rs.getString(5)%></p>
              <button class="add-to-cart-btn" id="button<%=rs.getString(7)%>" onclick="fillForm<%=rs.getString(7)%>(this);verificarCampos()">Seleccionar</button>
          </div>

          <script>
              function fillForm<%=rs.getString(7)%>(button) {

                  // Llenar el formulario con los datos del producto
                  document.getElementById('product-id').value = '<%=rs.getString(7)%>';
                  document.getElementById('product-name').value = '<%=rs.getString(2)%>';
                  document.getElementById('product-description').value = '<%=rs.getString(4)%>';
                  document.getElementById('product-price').value = '<%=rs.getString(5)%>';
                  document.getElementById('product-quantity').value = '<%=rs.getString(6)%>';
                  document.getElementById('product-category').value = '<%=rs.getString(3)%>';
                  document.getElementById('product-image').value = '<%=rs.getString(1)%>';
              }
          </script>

          <%
                  }
                  bd.cierraConexion();

              } catch (Exception ex) {
                  System.out.println(ex.getMessage());
                  //out.print(ex.getMessage());
              }
          %>
          <script>
              // Variable para rastrear el último botón presionado
              let ultimoBotonPresionado = null;

              document.getElementById('search-bar').value = '<%=busqueda%>';

              // Agregar evento a cada botón
              document.querySelectorAll('button[id^="button"]').forEach(button => {
                  button.addEventListener('click', function() {
                      // Habilitar el botón previamente deshabilitado (si existe)
                      if (ultimoBotonPresionado) {
                          ultimoBotonPresionado.disabled = false;
                          ultimoBotonPresionado.innerText = "Seleccionar";
                      }

                      // Deshabilitar el botón presionado
                      this.disabled = true;
                      this.innerText = "Seleccionado";

                      // Actualizar el rastreador del último botón
                      ultimoBotonPresionado = this;
                  });
              });


              // Seleccionar el botón y el formulario
              const botonLimpiar = document.getElementById('limpiarFormulario');
              const formulario = document.getElementById('catalog-form');

              // Añadir el event listener al botón
              botonLimpiar.addEventListener('click', function() {
                  // Limpiar todos los inputs dentro del formulario
                  formulario.reset();
                  verificarCampos()
                  ultimoBotonPresionado.disabled = false;
                  ultimoBotonPresionado.innerText = "Seleccionar";
              });


              // Seleccionar los campos requeridos y el botón
              const botonEnviar = document.getElementById('subir');
              const botonEliminar = document.getElementById('delete-btn');
              const camposRequeridos = [
                  document.getElementById('product-name'),
                  document.getElementById('product-description'),
                  document.getElementById('product-price'),
                  document.getElementById('product-quantity'),
                  document.getElementById('product-category'),
                  document.getElementById('product-image')
              ];
              const idproducto = document.getElementById('product-id');

              // Función para verificar si todos los campos requeridos están llenos
              function verificarCampos() {
                  let todosLlenos = true;

                  camposRequeridos.forEach(campo => {
                      if (campo.tagName === 'SELECT') {
                          // Comprobar si el select tiene un valor seleccionado
                          if (campo.value === '') {
                              todosLlenos = false;
                          }
                      } else if (campo.tagName === 'TEXTAREA' || campo.tagName === 'INPUT') {
                          // Comprobar si el input o textarea está vacío
                          if (campo.value.trim() === '') {
                              todosLlenos = false;
                          }
                      }
                  });

                  // Habilitar o deshabilitar el botón
                  if (idproducto.value.trim() === '') {
                      if (!todosLlenos === true){
                          botonEnviar.disabled = true;
                          botonEnviar.innerText = "Llena todos los campos para crear";
                          botonEliminar.disabled = true;
                          botonEliminar.innerText = "Selecciona un producto para modificar o eliminar";
                      } else {
                          botonEnviar.disabled = false;
                          botonEnviar.innerText = "Crear";
                          botonEnviar.value = "crear";
                          botonEliminar.disabled = true;
                          botonEliminar.innerText = "Selecciona un producto para modificar o eliminar";
                      }
                  } else {
                      if (!todosLlenos === true){
                          botonEnviar.disabled = true;
                          botonEnviar.innerText = "Llena todos los campos para modificar";
                          botonEliminar.disabled = false;
                          botonEliminar.innerText = "Eliminar";
                      } else {
                          botonEnviar.disabled = false;
                          botonEnviar.innerText = "Modificar";
                          botonEnviar.value = "modificar";
                          botonEliminar.disabled = false;
                          botonEliminar.innerText = "Eliminar";
                      }
                  }

              }

              // Añadir event listeners a cada campo requerido
              camposRequeridos.forEach(campo => {
                  campo.addEventListener('input', verificarCampos); // Para inputs y textareas
                  if (campo.tagName === 'SELECT') {
                      campo.addEventListener('change', verificarCampos); // Para selects
                  }
              });

              idproducto.addEventListener('input', verificarCampos);


          </script>
      </div>
    </section>

    <script src="scripts.js"></script>
    </main>
  </body>
</html>
