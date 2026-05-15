<%-- 
    Document   : Estavaparaelcatalogo
    Created on : May 14, 2026, 10:18:38 PM
    Author     : maurisio
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>a</title>
</head>
<body>

<script>
    const Idusuario = localStorage.getItem("id");

    const form = document.createElement('form');
    form.method = 'POST';
    form.action = 'CatalogoAnfi.jsp';

    const input = document.createElement('input');
    input.type = 'hidden';
    input.name = 'id';
    input.value = Idusuario;

    form.appendChild(input);
    document.body.appendChild(form);
    form.submit();
</script>

</body>
</html>