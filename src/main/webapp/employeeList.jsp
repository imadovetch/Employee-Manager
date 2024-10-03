<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
  body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 20px;
    background-color: #f4f4f4;
  }

  .Container {
    max-width: 800px;
    margin: 0 auto;
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    padding: 20px;
  }

  .flash-message {
    padding: 10px;
    background-color: #dff0d8;
    color: #3c763d;
    border: 1px solid #d6e9c6;
    border-radius: 4px;
    margin-bottom: 20px;
  }

  .Column {
    margin-bottom: 20px;
  }

  .ColumnName {
    font-size: 24px;
    margin-bottom: 10px;
    color: #333;
  }

  .RowsContainer {
    background-color: #f9f9f9;
    border-radius: 4px;
    padding: 10px;
    border: 1px solid #e0e0e0;
  }

  .SingleRow {
    padding: 8px;
    border-bottom: 1px solid #e0e0e0;
    color: #555;
  }

  .SingleRow:last-child {
    border-bottom: none;
  }

  form {
    display: flex;
    flex-direction: column;
  }

  input {
    padding: 10px;
    margin: 5px 0;
    border: 1px solid #ccc;
    border-radius: 4px;
  }

  button {
    padding: 10px;
    margin-top: 10px;
    background-color: #28a745;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s;
  }

  button:hover {
    background-color: #218838;
  }
</style>

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
