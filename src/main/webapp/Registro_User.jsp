<%@ page import="basesita.Base" %> <%@ page import="java.sql.ResultSet" %> <%@
page import="java.util.Objects" %> <%@ page
contentType="text/html;charset=UTF-8" language="java" %>
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
        <h1>Crea una cuenta</h1>
        <form action="Registro_User_A.jsp" method="POST">
          <input
            class="inSect"
            type="text"
            name="Nombre"
            id="nombre"
            placeholder="Nombre"
            required
          />
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
            name="contraseña"
            id="pass"
            placeholder="Contraseña"
            required
          />
          <div class="radio-group">
            <input type="radio" id="Anfitrion" name="user" value="1" />
            <label for="Anfitrion"
              >Anfitrion crea listas y envia a invitados</label
            >
          </div>

          <div class="radio-group">
            <input type="radio" id="Invitado" name="user" value="2" />
            <label for="Invitado">Invitado compra regalos de listas</label>
          </div>

          <button class="btn" id="subir" type="submit" disabled>
            Llena todos los campos para registrarte
          </button>
        </form>

        <script>
          // Seleccionar los campos requeridos y el botón
          const botonEnviar = document.getElementById("subir");
          const camposRequeridos = [
            document.getElementById("nombre"),
            document.getElementById("correo"),
            document.getElementById("pass"),
          ];

          // Función para comprobar si algún radio button está seleccionado
          function isRadioGroupSelected(groupName) {
            const radios = document.getElementsByName(groupName);
            for (let radio of radios) {
              if (radio.checked) {
                return true;
              }
            }
            return false;
          }

          // Función para verificar si todos los campos requeridos están llenos
          function verificarCampos() {
            let todosLlenos = true;

            camposRequeridos.forEach((campo) => {
              // Comprobar si el input o textarea está vacío
              if (campo.value.trim() === "") {
                todosLlenos = false;
              }
            });

            if (isRadioGroupSelected("user") === false) {
              todosLlenos = false;
            }

            // Habilitar o deshabilitar el botón
            if (!todosLlenos === true) {
              botonEnviar.disabled = true;
              botonEnviar.innerText = "Llena todos los campos para registrarte";
            } else {
              botonEnviar.disabled = false;
              botonEnviar.innerText = "Registrarse";
            }
          }

          // Añadir event listeners a cada campo requerido
          camposRequeridos.forEach((campo) => {
            campo.addEventListener("input", verificarCampos); // Para inputs y textareas
          });

          // Añadir event listeners a cada radio
          const radios = document.getElementsByName("user");
          for (let radio of radios) {
            radio.addEventListener("change", verificarCampos);
          }
        </script>

        <div class="registro">
          <a href="Inicio_sesion.jsp">¿Ya posees una cuenta?</a>
        </div>
      </div>
    </main>
  </body>
</html>
