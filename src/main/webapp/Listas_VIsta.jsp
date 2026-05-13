<%-- 
    Document   : A_borrar_ensamblaje
    Created on : 22 may. 2022, 18:04:57
    Author     : Mauricio
--%>
<%@ page import="basesita.Base" %>
<%@ page import="java.sql.ResultSet" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%

            Base bd = new Base();

            try {
                bd.conectar();
                String strQry = "select nombre from lista;";

                ResultSet rs = null;

                rs = bd.consulta(strQry);

                while (rs.next()) {
        %>

        Textito
        <%=rs.getString(1)%>

        <hr/>


        <%
                }
                bd.cierraConexion();

            } catch (Exception ex) {
                System.out.println(ex.getMessage());
                //out.print(ex.getMessage());
            }
        %>

        <hr/>

    </body>
</html>
