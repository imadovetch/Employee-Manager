<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<form id="employeeForm">
    <input type="text" name="name" placeholder="Name">
    <input type="email" name="email" placeholder="Email">
    <input type="text" name="phone" placeholder="Phone">
    <input type="text" name="department" placeholder="Department">
    <input type="text" name="position" placeholder="Position">
    <button type="submit">Submit</button>
</form>

<script>
    $('#employeeForm').submit(function(event) {
        event.preventDefault();

        var serializedData = $(this).serialize();

        $.ajax({
            url: 'addEmployee',
            type: 'POST',
            data: serializedData,
            success: function(response) {
                alert(response);
            },
            error: function(xhr, status, error) {
                console.error('Error:', error);
            }
        });
    });
</script>
