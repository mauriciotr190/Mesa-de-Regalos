<%--
  Created by IntelliJ IDEA.
  User: Jorge
  Date: 05/01/2025
  Time: 10:01 p. m.
  To change this template use File | Settings | File Templates.
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
    form.action = 'Gestion_Anfi_lista.jsp';
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
