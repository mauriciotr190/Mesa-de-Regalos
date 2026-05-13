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

                String strQry = "delete from producto where id_regalo = '" + idregalo + "';";

                bd.borrar(strQry);

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
