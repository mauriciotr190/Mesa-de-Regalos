// Script para ingresar el Encabezado dinámicamente
fetch("Encabezado.html")
  .then((Response) => {
    if (!Response.ok) {
      throw new Error("No se pudo cargar el Encabezado.");
    }
    return Response.text();
  })
  .then((data) => {
    document.getElementById("EncabezadoId").innerHTML = data;

    // Una vez que se cargue el encabezado, definimos qué menú mostrar
    mostrarMenuPorRol();
  })
  .catch((error) => {
    console.error("Error al cargar el Encabezado:", error);
  });

// Función para mostrar el menú dinámico según el rol del usuario
function mostrarMenuPorRol() {
  // Leer el rol del usuario desde el almacenamiento local
  const rolUsuario = localStorage.getItem("rol") || "usuario"; // Por defecto, usuario normal

  // Seleccionar los elementos del menú
  const menuUsuario = document.querySelector("#menuUsuario");
  const menuAdmin = document.querySelector("#menuAdmin");
  const menuAnfi = document.querySelector("#menuAnfi");

  // Mostrar el menú correspondiente al rol

  menuUsuario.style.display = "flex";

  if (rolUsuario === "admin") {
    // if (menuAdmin) menuAdmin.style.display = "flex";
    // if (menuUsuario) menuUsuario.style.display = "none";
    menuAdmin.style.display = "flex";
    menuUsuario.style.display = "none";
  } else if (rolUsuario === "anfitrion" || rolUsuario === "invitado") {
    // if (menuUsuario) menuUsuario.style.display = "flex";
    // if (menuAdmin) menuAdmin.style.display = "none";
    menuAnfi.style.display = "flex";
    menuUsuario.style.display = "none";
  }
}
