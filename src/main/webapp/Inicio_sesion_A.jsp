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
  <%
    String correo = request.getParameter("Correo");
    String contra = request.getParameter("pass");

      Base bd = new Base();

      try {
        bd.conectar();
        String strQry = "select * from administrador where correo = '" + correo + "' and pass = '" + contra + "' ;";
        ResultSet rs = null;
        rs = bd.consulta(strQry);

        if (rs.next()) {
          String id = rs.getString(1);
          bd.cierraConexion();
          //aqui va el set del local admin
          %>

          <script>
            localStorage.setItem("rol", "admin");
            localStorage.setItem("id", "<%=id%>");
            // console.log("Sesión iniciada con rol:", rol);
            window.location.href = "menu.jsp";
          </script>

          <%
        } else {

          String strQry2 = "select * from usuario where correo = '" + correo + "' and pass = '" + contra + "' ;";
          ResultSet rs2 = null;
          rs2 = bd.consulta(strQry2);

          if (rs2.next()) {
            String id = rs2.getString(1);
            String opc = rs2.getString(5);
            bd.cierraConexion();
            //aqui va el set del local usuario o anfitrion
          %>

          <script>
            if ("<%=opc%>" === "1"){
              localStorage.setItem("rol", "anfitrion");
              localStorage.setItem("id", "<%=id%>");
              window.location.href = "menu.jsp";
            }else{
              localStorage.setItem("rol", "invitado");
              localStorage.setItem("id", "<%=id%>");
              window.location.href = "menu.jsp";
            }
          </script>

          <%
          } else {
              bd.cierraConexion();

            %>

  <script>
    alert("Usuario o contraseña no validos");
  </script>

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

  <%
          }
        }
      } catch (Exception ex) {
                System.out.println(ex.getMessage());
                //out.print(ex.getMessage());
      }
  %>


  </body>
</html>
