<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section class="Container">
    <!-- Flash Message -->
    <c:if test="${not empty sessionScope.flashMessage}">
        <div class="flash-message">
                ${sessionScope.flashMessage}
        </div>
        <!-- Remove flash message after displaying -->
        <c:remove var="flashMessage" scope="session" />
    </c:if>

    <div class="Column">
    <h2 class="ColumnName">Email</h2>
    <div class="RowsContainer">
      <!-- Display employee emails -->
      <c:forEach var="employee" items="${employees}">
        <div class="SingleRow">${employee.email}</div>
      </c:forEach>
    </div>
  </div>

  <form id="employeeForm" action="addEmployee" method="post">
      <input type="text" name="name" placeholder="Name">
      <input type="email" name="email" placeholder="Email">
      <input type="text" name="phone" placeholder="Phone">
      <input type="text" name="department" placeholder="Department">
      <input type="text" name="position" placeholder="Position">
      <button type="submit">Submit</button>
  </form>
</section>


<%--<c:forEach var="employee" items="${employees}">--%>
<%--  <tr>--%>
<%--    <td>${employee.id}</td>--%>
<%--    <td>${employee.name}</td>--%>
<%--    <td>${employee.email}</td>--%>
<%--    <td>${employee.phone}</td>--%>
<%--    <td>${employee.position}</td>--%>
<%--    <td>${employee.department}</td>--%>
<%--  </tr>--%>
<%--</c:forEach>--%>