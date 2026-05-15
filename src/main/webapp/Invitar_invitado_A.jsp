<%-- 
    Document   : Invitar_invitado_A
    Created on : May 15, 2026, 2:11:54 PM
    Author     : maurisio
--%>

<%@ page import="basesita.Base" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Objects" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
String idusuario = request.getParameter("id");
String idlista = request.getParameter("idlista");
String correoInvitado = request.getParameter("correoInvitado");

Base bd = new Base();

try {
    bd.conectar();

    String buscarInvitado =
        "SELECT id_usuario FROM usuario " +
        "WHERE correo = '" + correoInvitado + "' " +
        "AND tipo = 2;";

    ResultSet rs = bd.consulta(buscarInvitado);

    if (rs.next()) {

        String idInvitado = rs.getString("id_usuario");

        String validar =
            "SELECT * FROM invitado_lista " +
            "WHERE id_usuario = " + idInvitado + " " +
            "AND id_lista = " + idlista + ";";

        ResultSet rsValidar = bd.consulta(validar);

        if (!rsValidar.next()) {
            String insertar =
                "INSERT INTO invitado_lista(id_usuario, id_lista) " +
                "VALUES(" + idInvitado + ", " + idlista + ");";

            bd.insertar(insertar);

            bd.cierraConexion();
            response.sendRedirect("Gestion_Anfi_lista.jsp?id=" + idusuario + "&msg=invitado");
        } else {
            bd.cierraConexion();
            response.sendRedirect("Gestion_Anfi_lista.jsp?id=" + idusuario + "&msg=repetido");
        }

        bd.cierraConexion();
        response.sendRedirect("Gestion_Anfi_lista.jsp?id=" + idusuario);

    } else {
        bd.cierraConexion();
        response.sendRedirect("Gestion_Anfi_lista.jsp?id=" + idusuario + "&msg=noexiste");
    }

} catch(Exception ex) {
    System.out.println(ex.getMessage());
    out.print("Error al invitar usuario.");
}
%>
