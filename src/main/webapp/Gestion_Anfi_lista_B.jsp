<%--
  Created by IntelliJ IDEA.
  User: Jorge
  Date: 05/01/2025
  Time: 09:19 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="basesita.Base" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Objects" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>a</title>
</head>
<body>
Si ves esto, hubo un error

<%
String iduser = request.getParameter("id");
String busqueda = request.getParameter("busqueda");
String idprod = request.getParameter("idprod");
String opc = request.getParameter("opc");
String cat = request.getParameter("cat");

Base bd = new Base();

try {
    bd.conectar();

    String idLista = "";

    String qryLista = "SELECT id_lista FROM lista WHERE id_usuario = " + iduser;
    ResultSet rsLista = bd.consulta(qryLista);

    if (rsLista.next()) {
        idLista = rsLista.getString("id_lista");
    } else {
        String insertLista = "INSERT INTO lista(nombre, id_usuario) " +
                             "VALUES('Lista de regalos', " + iduser + ")";
        bd.insertar(insertLista);

        rsLista = bd.consulta(qryLista);
        if (rsLista.next()) {
            idLista = rsLista.getString("id_lista");
        }
    }

    if (Objects.equals(opc, "eliminar")) {

        String strQry = "DELETE FROM producto_lista " +
                        "WHERE id_regalo = " + idprod +
                        " AND id_lista = " + idLista;

        bd.borrar(strQry);

        bd.cierraConexion();

        if (Objects.equals(busqueda, "mensajesecretoquetemandaalapaginainicial")) {
            response.sendRedirect("Gestion_Anfi_lista.jsp?id=" + iduser);
        } else {
            String busquedaUrl = URLEncoder.encode(busqueda, "UTF-8");
            String catUrl = URLEncoder.encode(cat, "UTF-8");

            response.sendRedirect("Gestion_Anfi_lista_A.jsp?nombre=" + busquedaUrl + "&categoria=" + catUrl + "&id=" + iduser);
        }

    } else {

        String strQry = "INSERT INTO producto_lista(id_regalo, id_lista) " +
                        "VALUES(" + idprod + ", " + idLista + ")";

        bd.insertar(strQry);

        bd.cierraConexion();

        String busquedaUrl = URLEncoder.encode(busqueda, "UTF-8");
        String catUrl = URLEncoder.encode(cat, "UTF-8");

        response.sendRedirect("Gestion_Anfi_lista_A.jsp?nombre=" + busquedaUrl + "&categoria=" + catUrl + "&id=" + iduser);
    }

} catch (Exception ex) {
    System.out.println(ex.getMessage());
}
%>

</body>
</html>
