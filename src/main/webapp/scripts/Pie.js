// Script para ingresar el pie de página dinamicamente
fetch("Pie.html")
  .then((Response) => {
    if (!Response.ok) {
      throw new Error("No se pudo cargar el pie de página.");
    }
    return Response.text();
  })
  .then((data) => {
    document.getElementById("footer").innerHTML = data;
  })
  .catch((error) => {
    console.error("Error al cargar el pie de página:", error);
  });
