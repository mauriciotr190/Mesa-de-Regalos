// Este script gestiona los productos desde el JSON y adapta el funcionamiento al contexto.

// Carga el JSON al iniciar el panel de administrador
let productos = [];
fetch("Basesita_temporal.json") // Asegúrate de que el JSON esté en la misma carpeta que los HTML
  .then((response) => {
    if (!response.ok) {
      throw new Error("No se pudo cargar el JSON.");
    }
    return response.json();
  })
  .then((data) => {
    productos = data;
    renderizarTabla(productos);
  })
  .catch((error) => {
    console.error("Error al cargar los productos:", error);
  });

// Renderiza los productos en la tabla del panel de administración
function renderizarTabla(productos) {
  const tabla = document.getElementById("tabla-productos");
  tabla.innerHTML = ""; // Limpia la tabla
  productos.forEach((producto) => {
    const fila = document.createElement("tr");
    fila.innerHTML = `
      <td>${producto.id}</td>
      <td>${producto.nombre}</td>
      <td>${producto.categoria}</td>
      <td>${producto.precio}</td>
      <td>${producto.descripcion}</td>
      <td>${producto.disponible ? "Sí" : "No"}</td>
      <td><img src="${producto.imagen}" alt="${
      producto.nombre
    }" width="50"></td>
      <td>
        <button onclick="editarProducto(${producto.id})">Editar</button>
        <button onclick="eliminarProducto(${producto.id})">Eliminar</button>
      </td>
    `;
    tabla.appendChild(fila);
  });
}

// Agrega un nuevo producto
function agregarProducto() {
  const nuevoProducto = {
    id: productos.length ? productos[productos.length - 1].id + 1 : 1, // Genera un nuevo ID único
    nombre: document.getElementById("nombre").value,
    categoria: document.getElementById("categoria").value,
    precio: parseFloat(document.getElementById("precio").value),
    descripcion: document.getElementById("descripcion").value,
    disponible: document.getElementById("disponible").checked,
    imagen: document.getElementById("imagen").value,
  };

  productos.push(nuevoProducto);
  renderizarTabla(productos);
  guardarJSON();
}

// Edita un producto existente
function editarProducto(id) {
  const producto = productos.find((p) => p.id === id);
  if (!producto) return;

  document.getElementById("nombre").value = producto.nombre;
  document.getElementById("categoria").value = producto.categoria;
  document.getElementById("precio").value = producto.precio;
  document.getElementById("descripcion").value = producto.descripcion;
  document.getElementById("disponible").checked = producto.disponible;
  document.getElementById("imagen").value = producto.imagen;

  // Cambia el botón de guardar para actualizar el producto
  const btnGuardar = document.getElementById("guardar-cambios");
  btnGuardar.onclick = () => {
    producto.nombre = document.getElementById("nombre").value;
    producto.categoria = document.getElementById("categoria").value;
    producto.precio = parseFloat(document.getElementById("precio").value);
    producto.descripcion = document.getElementById("descripcion").value;
    producto.disponible = document.getElementById("disponible").checked;
    producto.imagen = document.getElementById("imagen").value;

    renderizarTabla(productos);
    guardarJSON();
    btnGuardar.onclick = agregarProducto; // Vuelve al estado original
  };
}

// Elimina un producto por su ID
function eliminarProducto(id) {
  productos = productos.filter((p) => p.id !== id);
  renderizarTabla(productos);
  guardarJSON();
}

// Guarda los cambios en el JSON (simulado)
function guardarJSON() {
  console.log("Productos guardados:", JSON.stringify(productos, null, 2));
  // Aquí se podría implementar una funcionalidad para guardar el JSON en un servidor.
}
