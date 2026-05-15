<%--
  Created by IntelliJ IDEA.
  User: Jorge
  Date: 04/01/2025
  Time: 03:24 a. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="basesita.Base" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Title</title>
    </head>
    <body>
    Si wachas esto hubo un error JAJA

    <%

        String opc = request.getParameter("botons");
        String busqueda = request.getParameter("busqueda");
        String idregalo = request.getParameter("idregalo");

        Base bd = new Base();

        try {
            bd.conectar();

            if (Objects.equals(opc, "eliminar")){

                String guardarComprados =
                    "INSERT INTO producto_comprado_backup " +
                    "(id_regalo, id_lista, id_usuario_anfitrion, nombre, descripcion, precio, categoria, imagen) " +
                    "SELECT p.id_regalo, pl.id_lista, l.id_usuario, p.nombre, p.descripcion, p.precio, p.categoria, p.imagen " +
                    "FROM producto p " +
                    "INNER JOIN producto_lista pl ON p.id_regalo = pl.id_regalo " +
                    "INNER JOIN lista l ON pl.id_lista = l.id_lista " +
                    "WHERE p.id_regalo = '" + idregalo + "' " +
                    "AND pl.estado = 'comprado' " +
                    "AND NOT EXISTS ( " +
                    "   SELECT 1 FROM producto_comprado_backup pcb " +
                    "   WHERE pcb.id_regalo = p.id_regalo " +
                    "   AND pcb.id_lista = pl.id_lista " +
                    ");";

                bd.insertar(guardarComprados);

                String borrarCarrito =
                    "DELETE cp FROM carrito_producto cp " +
                    "WHERE cp.id_regalo = '" + idregalo + "';";

                bd.borrar(borrarCarrito);

                String borrarLista =
                    "DELETE FROM producto_lista " +
                    "WHERE id_regalo = '" + idregalo + "';";

                bd.borrar(borrarLista);

                String borrarProducto =
                    "DELETE FROM producto " +
                    "WHERE id_regalo = '" + idregalo + "';";

                bd.borrar(borrarProducto);

                bd.cierraConexion();
                response.sendRedirect("Catalogo_Admin_Modif_A.jsp?busqueda="+busqueda);

            } else {

                String nombre = request.getParameter("nombre");
                String descripcion = request.getParameter("descripcion");
                String precio = request.getParameter("precio");
                String categoria = request.getParameter("categoria");
                String existencias = request.getParameter("hay");
                String imagen = request.getParameter("imagen");

                if (Objects.equals(opc, "modificar")) {

                    String strQry = "update producto set nombre = '" + nombre + "', descripcion = '" + descripcion + "', precio = '" + precio + "', categoria = '" + categoria + "', existencias = '" + existencias + "', imagen = '" + imagen + "' where id_regalo = '" + idregalo + "';";

                    int resultadoInsert = bd.edita(strQry);

                    bd.cierraConexion();
                    response.sendRedirect("Catalogo_Admin_Modif_A.jsp?busqueda="+busqueda);

                } else {

                    String strQry = "insert into producto (nombre, descripcion, precio, categoria, existencias, imagen)"
                            + "values('" + nombre + "', '" + descripcion + "', '" + precio + "', '" + categoria + "', '" + existencias + "', '" + imagen + "');";

                    int resultadoInsert = bd.insertar(strQry);

                    bd.cierraConexion();
                    if (Objects.equals(busqueda, "mensajesecretoquetemandaalapaginainicial"))
                        response.sendRedirect("Catalogo_Admin_Modif.jsp");
                    else
                        response.sendRedirect("Catalogo_Admin_Modif_A.jsp?busqueda="+busqueda);

                }
            }

        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    %>


    </body>
</html>
