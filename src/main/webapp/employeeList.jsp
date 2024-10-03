<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section class="Container">
  <div class="Column">
    <h2 class="ColumnName">Name</h2>
    <div class="RowsContainer">
      <!-- Iterate over the employees and display their names -->
      <c:forEach var="employee" items="${employees}">
        <input class="SingleRow">${employee.name}</input>
      </c:forEach>
    </div>
  </div>

  <div class="Column">
    <h2 class="ColumnName">Email</h2>
    <div class="RowsContainer">
      <!-- Display employee emails -->
      <c:forEach var="employee" items="${employees}">
        <div class="SingleRow">${employee.email}</div>
      </c:forEach>
    </div>
  </div>

  <div class="Column">
    <h2 class="ColumnName">Phone Number</h2>
    <div class="RowsContainer">
      <!-- Display employee phone numbers -->
      <c:forEach var="employee" items="${employees}">
        <div class="SingleRow">${employee.phone}</div>
      </c:forEach>
    </div>
  </div>

  <div class="Column">
    <h2 class="ColumnName">Position</h2>
    <div class="RowsContainer">
      <!-- Display employee positions -->
      <c:forEach var="employee" items="${employees}">
        <div class="SingleRow">${employee.position}</div>
      </c:forEach>
    </div>
  </div>

  <div class="Column">
    <h2 class="ColumnName">Department</h2>
    <div class="RowsContainer">
      <!-- Display employee departments -->
      <c:forEach var="employee" items="${employees}">
        <div class="SingleRow">${employee.department}</div>
      </c:forEach>
    </div>
  </div>

  <div class="Column">
    <h2 class="ColumnName">Actions</h2>
    <div class="RowsActionsr">
      <div style="background-color: rgba(26, 116, 34, 0.241);" class="ActionColumn">
        <c:forEach var="employee" items="${employees} " varStatus="status">
            <div class="SingleRow">${status.index}</div>
        </c:forEach>
      </div>
      <div style="background-color: rgba(253, 0, 0, 0.241);" class="ActionColumn">
        <c:forEach var="employee" items="${employees}">
          <div class="SingleRow">${0}</div>
        </c:forEach>
      </div>
    </div>
  </div>
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