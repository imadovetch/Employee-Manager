<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="Container">
  <div class="Column">
    <h2 class="ColumnName">Name</h2>
    <div class="RowsContainer">
      <!-- Iterate over the employees and display their names -->
      <c:forEach var="employee" items="${employees}">
        <div class="SingleRow">
          <input  oninput="InputChange(${employee.id})" class="Rowinput-${employee.id}" value="${employee.name}" />
        </div>
      </c:forEach>
    </div>
  </div>

  <div class="Column">
    <h2 class="ColumnName">Email</h2>
    <div class="RowsContainer">
      <!-- Display employee emails -->
      <c:forEach var="employee" items="${employees}">
        <div class="SingleRow">
          <input  oninput="InputChange(${employee.id})" class="Rowinput-${employee.id}" value="${employee.email}" />

        </div>
      </c:forEach>
    </div>
  </div>

  <div class="Column">
    <h2 class="ColumnName">Phone Number</h2>
    <div class="RowsContainer">
      <!-- Display employee phone numbers -->
      <c:forEach var="employee" items="${employees}">
        <div class="SingleRow">
          <input  oninput="InputChange(${employee.id})" class="Rowinput-${employee.id}" value="${employee.phone}" />

        </div>
      </c:forEach>
    </div>
  </div>

  <div class="Column">
    <h2 class="ColumnName">Position</h2>
    <div class="RowsContainer">
      <!-- Display employee positions -->
      <c:forEach var="employee" items="${employees}">
        <div class="SingleRow">
          <input  oninput="InputChange(${employee.id})" class="Rowinput-${employee.id}" value="${employee.position}" />

        </div>
      </c:forEach>
    </div>
  </div>

  <div class="Column">
    <h2 class="ColumnName">Department</h2>
    <div class="RowsContainer">
      <!-- Display employee departments -->
      <c:forEach var="employee" items="${employees}">
        <div class="SingleRow">
          <input  oninput="InputChange(${employee.id})" class="Rowinput-${employee.id}" value="${employee.department}" />

        </div>
      </c:forEach>
    </div>
  </div>

  <div class="Column">
    <h2 class="ColumnName">Actions</h2>
    <div class="RowsActionsr">
      <div style="background-color: rgba(26, 116, 34, 0.241);" class="ActionColumn">
        <c:forEach var="employee" items="${employees}">
          <div class="SingleRow">

            <div onclick="update(${employee.id})" class="Update-${employee.id}">
              jvnoeov
            </div>
          </div>
        </c:forEach>
      </div>
      <div style="background-color: rgba(253, 0, 0, 0.241);" class="ActionColumn">
        <c:forEach var="employee" items="${employees}">
          <div class="SingleRow">${employee.id}</div>
        </c:forEach>
      </div>
    </div>
  </div>
</section>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  function InputChange(id) {
    let string = ".Update-" + id;
    console.log(string);
    var target = document.querySelector(string);

    if (target) {
      target.classList.add("highlight");
    }
  }

  function update(id) {
    var Rowsinput = document.querySelectorAll(".Rowinput-" + id);

    var formData = new FormData();

    formData.append("name", Rowsinput[0].value);
    formData.append("email", Rowsinput[1].value);
    formData.append("phone", Rowsinput[2].value);
    formData.append("position", Rowsinput[3].value);
    formData.append("department", Rowsinput[4].value);

    console.log("Form Data:", formData);

    $.ajax({
      type: 'PUT',
      url: 'ModifyEmployee/' + id,
      data: formData,
      processData: false,
      contentType: false,
      success: function (response) {
        console.log("Success:", response);
      },
      error: function (xhr) {
        alert("Error: " + xhr.responseText);
      }
    });
  }
</script>

