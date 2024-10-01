<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles.css">
    <title>Add Employee</title>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Handle form submission
            document.querySelector("form").addEventListener("submit", function (event) {
                event.preventDefault(); // Prevent the default form submission

                // Create a new FormData object from the form
                var formData = new FormData(this);

                // Create a new XMLHttpRequest object
                var xhr = new XMLHttpRequest();
                xhr.open("POST", this.action, true); // Set the request method and URL

                // Set up a callback for when the request is complete
                xhr.onload = function () {
                    if (xhr.status === 200) {
                        // Handle success response (e.g., show a message or clear the form)
                        alert("Employee added successfully!");
                        // Optionally, clear the form fields
                        document.querySelector("form").reset();
                    } else {
                        // Handle error response
                        alert("Error: " + xhr.responseText);
                    }
                };

                // Send the request with the form data
                xhr.send(formData);
            });
        });
    </script>
</head>
<body>
<div class="form">
    <div class="title">Welcome</div>
    <div class="subtitle">Let's add an employee</div>
    <form action="addEmployee" method="post" enctype="multipart/form-data">
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
        <button type="submit" class="submit">Submit</button>
    </form>
</div>
</body>
</html>
