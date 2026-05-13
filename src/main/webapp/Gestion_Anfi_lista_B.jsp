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
    System.out.println("usuario: "+iduser);
    System.out.println("producto: "+idprod);
    System.out.println("opcion: "+opc);

    Base bd = new Base();
    try {
        bd.conectar();

        if (Objects.equals(opc, "eliminar")){

            String strQry = "delete from producto_lista where id_regalo = "+idprod+" and id_usuario = "+iduser+";";

            bd.borrar(strQry);

            bd.cierraConexion();

            if (Objects.equals(busqueda, "mensajesecretoquetemandaalapaginainicial"))
                response.sendRedirect("Gestion_Anfi_lista.jsp?id="+iduser);
            else
                response.sendRedirect("Gestion_Anfi_lista_A.jsp?nombre="+busqueda+"&id="+iduser+"&cat="+cat);

        } else {

            String strQry = "insert into producto_lista (id_regalo, id_usuario)"
                    + "values('" + idprod + "', '" + iduser + "');";

            int resultadoInsert = bd.insertar(strQry);

            bd.cierraConexion();

            response.sendRedirect("Gestion_Anfi_lista_A.jsp?busqueda="+busqueda+"&id="+iduser+"&cat="+cat);
        }

    } catch (Exception ex) {
        System.out.println(ex.getMessage());
    }

%>

</body>
</html>
