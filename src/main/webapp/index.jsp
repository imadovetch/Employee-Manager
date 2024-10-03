<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles.css">
    <title>Modify and Delete Employee</title>

    <!-- Include jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Handle modify form submission
            document.querySelector("#modifyForm").addEventListener("submit", function (event) {
                event.preventDefault(); // Prevent default form submission

                var formData = $(this).serialize(); // Serialize form data

                $.ajax({
                    type: 'PUT',
                    url: 'ModifyEmployee/1',
                    data: formData,
                    success: function (response) {

                    },
                    error: function (xhr) {
                        alert("Error: " + xhr.responseText);
                    }
                });
            });

        });
    </script>
</head>
<body>
<div class="form">
    <div class="title">Modify Employee</div>
    <form id="modifyForm" action="modifyEmployee" method="post">
        <div class="input-container ic1">
            <input id="employeeId" name="employeeId" class="input" type="text" placeholder=" " required/>
            <div class="cut cut-short"></div>
            <label for="employeeId" class="placeholder">Employee ID</label>
        </div>
        <div class="input-container ic1">
            <input id="name" name="name" class="input" type="text" placeholder=" " required/>
            <div class="cut cut-short"></div>
            <label for="name" class="placeholder">Name</label>
        </div>
        <div class="input-container ic2">
            <input id="email" name="email" class="input" type="email" placeholder=" " required/>
            <div class="cut cut-short"></div>
            <label for="email" class="placeholder">Email</label>
        </div>
        <div class="input-container ic2">
            <input id="phone" name="phone" class="input" type="text" placeholder=" " required/>
            <div class="cut cut-short"></div>
            <label for="phone" class="placeholder">Phone</label>
        </div>
        <div class="input-container ic2">
            <input id="department" name="department" class="input" type="text" placeholder=" " required/>
            <div class="cut"></div>
            <label for="department" class="placeholder">Department</label>
        </div>
        <div class="input-container ic2">
            <input id="position" name="position" class="input" type="text" placeholder=" " required/>
            <div class="cut"></div>
            <label for="position" class="placeholder">Position</label>
        </div>
        <button type="submit" class="submit">Modify Employee</button>
    </form>

    <div class="title">Delete Employee</div>
    <form id="deleteForm" action="deleteEmployee" method="post">
        <div class="input-container ic1">
            <input id="employeeIdToDelete" name="employeeIdToDelete" class="input" type="text" placeholder=" " required/>
            <div class="cut cut-short"></div>
            <label for="employeeIdToDelete" class="placeholder">Employee ID</label>
        </div>
        <button type="submit" class="submit">Delete Employee</button>
    </form>
</div>
</body>
</html>
