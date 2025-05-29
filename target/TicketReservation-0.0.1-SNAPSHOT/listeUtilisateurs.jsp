<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link rel="stylesheet" href="css/style.css">
<title>Insert title here</title>
</head>
<body>
<table>
    <tr>
        <th>Nom</th>
        <th>Email</th>
        <th>Statut</th>
        <th>Action</th>
    </tr>
    <c:forEach var="user" items="${utilisateurs}">
        <tr>
            <td>${user.nom}</td>
            <td>${user.email}</td>
            <td>${user.active ? 'Actif' : 'Bloqué'}</td>
            <td>
                <form action="setUserStatus" method="post">
                    <input type="hidden" name="userId" value="${user.id}">
                    <input type="hidden" name="isActive" value="${!user.active}">
                    <input type="submit" value="${user.active ? 'Bloquer' : 'Débloquer'}">
                </form>
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>