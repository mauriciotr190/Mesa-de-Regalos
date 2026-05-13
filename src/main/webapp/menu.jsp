<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Presentación de la Empresa</title>
    <link rel="stylesheet" href="Estilos/index.css" />
  </head>
  <body>
    <!-- Encabezado -->
    <div id="EncabezadoId"></div>
    <script src="scripts/Encabezado.js"></script>

    <!-- Contenido principal -->
    <main class="main">
      <!-- Información central -->
      <section class="info">
        <h2>Regalos y Eventos ALUMNOS UPIICSA</h2>
        <br />
        <h3>Descubre una Nueva Forma de Celebrar tus Momentos Especiales</h3>
        <p>
          En Regalos y Eventos ALUMNOS UPIICSA, nos enorgullece ofrecerte una
          experiencia única y personalizada con nuestro exclusivo servicio de
          "Mesa de Regalos". Diseñamos este concepto pensando en simplificar la
          forma en que tus invitados participan en la celebración de tus eventos
          más importantes, mientras tú disfrutas plenamente de cada momento.
        </p>
        <br />
        <h3 id="boda">Bodas: Creando Recuerdos Eternos</h3>
        <p>
          Una boda es el comienzo de un nuevo capítulo, y queremos que todo sea
          perfecto. Con nuestra Mesa de Regalos, los novios pueden seleccionar
          de una amplia lista de productos cuidadosamente clasificados según las
          últimas tendencias y necesidades. Los invitados podrán acceder
          fácilmente al catálogo desde cualquier lugar, elegir el regalo que
          deseen obsequiar y realizar su compra en un par de clics. Nuestra
          empresa se encarga del resto, asegurando que cada obsequio llegue al
          lugar acordado, listo para ser parte de tu gran día.
        </p>
        <img class="boda" src="imagenes/regalo_boda.jpg" />
        <br />
        <h3 id="15">XV Años: Celebraciones que Brillan</h3>
        <p>
          El festejo de los XV años es una ocasión inolvidable. En Regalos y
          Eventos ALUMNOS UPIICSA, hacemos que este momento sea aún más especial
          con nuestra selección de regalos únicos, pensados para reflejar la
          personalidad y los sueños de la quinceañera. Desde accesorios de moda
          hasta artículos decorativos para la fiesta, nuestros inventarios están
          diseñados para ofrecer a tus invitados una experiencia de compra
          rápida y cómoda, mientras tú te concentras en disfrutar del evento.
        </p>
        <img class="XV" src="imagenes/regalo_XV.jpg" />
        <br />
        <h3 id="bautizao">Bautizos: Bienvenidos a un Nuevo Comienzo</h3>
        <p>
          Los bautizos son celebraciones llenas de amor y significado. Gracias a
          nuestro servicio, los padres pueden proponer regalos prácticos y
          especiales que apoyen esta nueva etapa en la vida de su bebé. Además,
          tus invitados contarán con una plataforma fácil de usar, donde podrán
          hacer su selección y confirmar su compra sin complicaciones.
        </p>
        <img class="Bautizo" src="imagenes/regalo_bautizo.jpg" />
        <br />
        <h3 id="otro">Eventos Personalizados para Cada Estilo</h3>
        <p>
          Ya sea un cumpleaños, un aniversario, o una fiesta "Para Él" o "Para
          Ella", nuestro equipo se adapta a tus necesidades. Nos aseguramos de
          mantener un catálogo actualizado con productos relevantes y
          atractivos, organizados en categorías específicas para que siempre
          encuentres lo que buscas. Nos encargamos de todo el proceso logístico,
          desde la compra hasta la entrega final, para que disfrutes sin
          preocupaciones.
        </p>
        <br />
        <h3>Siempre a la Vanguardia</h3>
        <p>
          Nuestro compromiso es ofrecer un servicio impecable, por lo que
          realizamos actualizaciones periódicas en nuestros catálogos,
          incorporando las últimas tendencias y productos de los principales
          centros comerciales. Esto nos permite garantizar que siempre tengas
          acceso a lo mejor del mercado, adaptándonos a tus necesidades y a las
          de tus invitados.
        </p>
      </section>

      <!-- Menú flotante lateral -->
      <aside class="sidebar">
        <h3>Categorías</h3>
        <ul>
          <li><a href="#EncabezadoId">Inicio</a></li>
          <li><a href="#boda">Bodas</a></li>
          <li><a href="#15">XV Años</a></li>
          <li><a href="#bautizao">Bautizos</a></li>
          <li><a href="#otro">Otros Eventos</a></li>
        </ul>
      </aside>
    </main>

    <!-- Pie de página -->
    <div id="footer"></div>
    <script src="scripts/Pie.js"></script>
  </body>
</html>
