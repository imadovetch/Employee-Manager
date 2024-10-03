<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Employee List</title>
</head>
<body>
<h1>Hello World!</h1>
<br/>

<section class="FullPage">
    <h2>Employee List</h2>
    <table border="1">
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Position</th>
            <th>Department</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="employee" items="${employees}">
            <tr>
                <td>${employee.id}</td>
                <td>${employee.name}</td>
                <td>${employee.email}</td>
                <td>${employee.phone}</td>
                <td>${employee.position}</td>
                <td>${employee.department}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <c:if test="${empty employees}">
        <p>No employees found.</p>
    </c:if>
</section>
</body>
</html>
