<%@ page import="basesita.Base" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Inicio Sesión</title>
    <link href="Estilos/sesion.css" rel="stylesheet" />
  </head>
  <body>
    <main>
      <div class="container">
        <h1>inicio de sesión</h1>
        <form action="Inicio_sesion_A.jsp" method="POST">
          <input
                  class="inSect"
                  type="email"
                  name="Correo"
                  id="correo"
                  placeholder="Correo electronico"
                  required
          />
          <input
                  class="inSect"
                  type="password"
                  name="pass"
                  id="pass"
                  placeholder="Contraseña"
                  required
          />
          <button class="btn" id="subir" type="submit" disabled>Llena todos los campos para iniciar sesion</button>
        </form>

        <script>
          // Seleccionar los campos requeridos y el botón
          const botonEnviar = document.getElementById('subir');
          const camposRequeridos = [
            document.getElementById('correo'),
            document.getElementById('pass')
          ];

          // Función para verificar si todos los campos requeridos están llenos
          function verificarCampos() {
            let todosLlenos = true;

            camposRequeridos.forEach(campo => {
                // Comprobar si el input o textarea está vacío
                if (campo.value.trim() === '') {
                  todosLlenos = false;
                }
            });

            // Habilitar o deshabilitar el botón
            if (!todosLlenos === true){
              botonEnviar.disabled = true;
              botonEnviar.innerText = "Llena todos los campos para iniciar sesion";
            } else {
              botonEnviar.disabled = false;
              botonEnviar.innerText = "Iniciar Sesion";
            }
          }

          // Añadir event listeners a cada campo requerido
          camposRequeridos.forEach(campo => {
            campo.addEventListener('input', verificarCampos); // Para inputs y textareas
          });
        </script>


        <div class="registro">
          <a href="Registro_User.jsp">¿Aun no poses una cuenta?</a>
        </div>
      </div>
    </main>
  </body>
</html>
