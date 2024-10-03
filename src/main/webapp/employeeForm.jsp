<%--<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>--%>

<%--<form id="employeeForm">--%>
<%--    <input type="text" name="name" placeholder="Name">--%>
<%--    <input type="email" name="email" placeholder="Email">--%>
<%--    <input type="text" name="phone" placeholder="Phone">--%>
<%--    <input type="text" name="department" placeholder="Department">--%>
<%--    <input type="text" name="position" placeholder="Position">--%>
<%--    <button type="submit">Submit</button>--%>
<%--</form>--%>

<%--<script>--%>
<%--    $('#employeeForm').submit(function(event) {--%>
<%--        event.preventDefault();--%>

<%--        var serializedData = $(this).serialize();--%>

<%--        $.ajax({--%>
<%--            url: 'addEmployee',--%>
<%--            type: 'POST',--%>
<%--            data: serializedData,--%>
<%--            success: function(response) {--%>
<%--                alert(response);--%>
<%--            },--%>
<%--            error: function(xhr, status, error) {--%>
<%--                console.error('Error:', error);--%>
<%--            }--%>
<%--        });--%>
<%--    });--%>
<%--</script>--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Employee List</title>
</head>
<body>
<h1>Hello from listformmmm</h1>
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
