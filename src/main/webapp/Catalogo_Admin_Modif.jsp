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
        <form id="catalog-form" action="Catalogo_Admin_Modif_B.jsp?busqueda=mensajesecretoquetemandaalapaginainicial" method="POST">
            <input
                    type="text"
                    id="product-id"
                    hidden="hidden"
                    name="idregalo"
            />
            <button type="button" id="limpiarFormulario" onclick="verificarCampos()">Limpiar</button>
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
            <button type="submit" id="subir" name="botons" value="crear" disabled>Llena todos los campos para crear</button>
            <button type="button" id="delete-btn" disabled>Selecciona un producto para modificar o eliminar</button>
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
          Realiza una busqueda en el catalogo
          <script>
              // Seleccionar el botón y el formulario
              const botonLimpiar = document.getElementById('limpiarFormulario');
              const formulario = document.getElementById('catalog-form');

              // Añadir el event listener al botón
              botonLimpiar.addEventListener('click', function() {
                  // Limpiar todos los inputs dentro del formulario
                  formulario.reset();
              });



              // Seleccionar los campos requeridos y el botón
              const botonEnviar = document.getElementById('subir');
              const camposRequeridos = [
                  document.getElementById('product-name'),
                  document.getElementById('product-description'),
                  document.getElementById('product-price'),
                  document.getElementById('product-quantity'),
                  document.getElementById('product-category'),
                  document.getElementById('product-image')
              ];

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
                  if (!todosLlenos === true){
                      botonEnviar.disabled = true;
                      botonEnviar.innerText = "Llena todos los campos para crear";
                  } else {
                      botonEnviar.disabled = false;
                      botonEnviar.innerText = "Crear";
                  }
              }

              // Añadir event listeners a cada campo requerido
              camposRequeridos.forEach(campo => {
                  campo.addEventListener('input', verificarCampos); // Para inputs y textareas
                  if (campo.tagName === 'SELECT') {
                      campo.addEventListener('change', verificarCampos); // Para selects
                  }
              });


          </script>
      </div>
    </section>

    <script src="scripts.js"></script>
    </main>
  </body>
</html>
