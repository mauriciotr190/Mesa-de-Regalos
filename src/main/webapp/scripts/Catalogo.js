document.addEventListener("DOMContentLoaded", function () {
  const productContainer = document.getElementById("product-container");

  // Función para obtener los datos del archivo JSON
  async function fetchProducts() {
    try {
      const response = await fetch("Basesita_temporal.json");
      if (!response.ok) {
        throw new Error("Error al cargar el archivo JSON");
      }
      const products = await response.json();
      renderProducts(products);
    } catch (error) {
      console.error("Error al cargar los productos:", error);
      productContainer.innerHTML = `<p>Error al cargar los productos. Por favor, intenta de nuevo más tarde.</p>`;
    }
  }

  // Función para renderizar los productos
  function renderProducts(products) {
    productContainer.innerHTML = ""; // Limpiar contenedor antes de renderizar
    products.forEach((product) => {
      const productCard = document.createElement("div");
      productCard.classList.add("product-card");

      productCard.innerHTML = `
          <img src="${product.imagen}" alt="${
        product.nombre
      }" class="product-image">
          <h2 class="product-name">${product.nombre}</h2>
          <p class="product-category"><strong>Categoría:</strong> ${
            product.categoria
          }</p>
          <p class="product-description">${product.descripcion}</p>
          <p class="product-price"><strong>Precio:</strong> $${
            product.precio
          }</p>
          <button 
            class="add-to-cart-btn" 
            data-id="${product.id}" 
            ${product.disponible ? "" : "disabled"} 
          >
            ${product.disponible ? "Agregar al carrito" : "No disponible"}
          </button>
        `;

      productContainer.appendChild(productCard);
    });
  }

  // Evento para manejar el clic en los botones "Agregar al carrito"
  productContainer.addEventListener("click", function (e) {
    if (e.target.classList.contains("add-to-cart-btn") && !e.target.disabled) {
      const productId = e.target.getAttribute("data-id");
      alert(`Agregado al carrito: Producto ID ${productId}`);
      // Aquí puedes añadir lógica para manejar el carrito de compras
    }
  });

  // Llamar a la función para obtener y mostrar los productos
  fetchProducts();
});
