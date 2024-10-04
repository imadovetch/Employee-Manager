<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body class="FullPage">
<nav class="Navbar ">
    <h1 class="title">Gestionnaire D'employés</h1>
    <div style="width: 60% ; height: fit-content; display: flex; justify-content: space-between; ">
        <label style="position: relative;" class="label">
            <div class="iconsContainer Hidden" style="position: absolute; z-index: 999; width: 20%; min-height: fit-content; display: flex; flex-direction: column; justify-content: center; gap:5px; padding: 10px 0; align-items: center;  background-color: rgba(133, 134, 133, 0.144); right: 0; top: 100%;">
                <img onclick="SetFilter(this,'Email')"  width="30" height="30"  src="https://img.icons8.com/ios/30/email.png" alt="email"/>
                <img onclick="SetFilter(this,'Phone')" width="30" height="30" src="https://img.icons8.com/ios/30/apple-phone.png" alt="apple-phone"/>
                <img onclick="SetFilter(this,'Department')" width="30" height="30" src="https://img.icons8.com/ios/30/department.png" alt="department"/>
                <img onclick="SetFilter(this,'Position')" width="30" height="30" src="https://img.icons8.com/ios/30/visit--v1.png" alt="visit--v1"/>
                <img onclick="SetFilter(this,'Name')" width="30" height="30" src="https://img.icons8.com/ios/30/collaborator-male.png" alt="collaborator-male"/>
            </div>
            <span onclick="toggleIcons()" class="icon">
            <img width="30" height="30" src="https://img.icons8.com/ios/30/collaborator-male.png" alt="collaborator-male"/>
        </span>
            <input
                    type="text"
                    class="inputSearch"
                    placeholder="Enter name"
                    autocomplete="off"
            />
        </label>

        <button  style="width: 30%; height: 100%;  float: right;" onclick="ToggleHiddness()">
            Toggle
        </button>
    </div>



</nav>

<jsp:include page="employeeList.jsp" />
</body>
<style>
    .FullPage{
        padding: 0;
        margin: 0;
        height: 100vh;
        max-width: 100%;
        overflow: hidden;
        display: flex;
        flex-direction: column;
    }
    .Navbar{
        display: flex;
        height: 15%;
        width: 100%;
        border: 1px solid;
        justify-content: center;
        align-items: center;
        flex-direction: column;
    }
    .Container{
        margin: 10px;
        border: 1px solid;
        flex-grow: 1;
        max-height:95% ;
        display: grid;
        grid-template-columns: repeat(6, 1fr);
        overflow-y: auto;
    }
    .Column{
        flex-grow: 1;
        border: 1px solid black;
        display: flex;
        flex-direction: column;

    }
    .ColumnName{
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 70px;
        padding: 0;
        margin: 0;
        border-bottom: 2px solid;
        font-family:sans-serif;
        font-size:large;
        font-weight: 500;
    }
    .RowsContainer, .RowsActionsr{
        width: 100%;
        height: fit-content;
    }
    .RowsActionsr{
        display: flex;
    }
    .ActionColumn{
        width: 50%;
    }
    .SingleRow{
        width: 100%;
        height: 45px;
        border-bottom: 1px solid black;
        justify-content: center;
        align-items: center;
        display: flex;
        overflow: hidden;
    }
    input {
        border: none;
        margin: 0;
        display: flex;
        text-align: center;
        height: 100%;
        background: none;
        width: 100%;
        max-height: 100%;
        max-width: 100%;
    }
    input:focus{
        border: none;


    }
    input::placeholder {
        text-align: center;
    }
    .highlight{
        transform: scale(1.1);
        fill: green;
    }


    /* Search*/


    .label {
        position: relative;
        display: block;
        width: 250px;
        display: flex;
        border-radius: 6px;
        border: 2px solid #373737;
        padding: 15px 8px 15px 10px;
        text-align: left;

        .icon {
            position: absolute;
            top: 53%;
            right: 0;
            transform: translate(-50%, -50%);
            transition: all 0.3s ease;
            color: #c5c5c5;
        }

        .inputSearch {
            background-color: transparent;
            outline: none;
            border: none;
            color: #c5c5c5;
            font-size: 16px;
        }
    }
    .Hidden{
        display: none !important;
    }


</style>
</html>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    var GlobalFilter = 'Name'
    function toggleIcons() {
        console.log("hi")
        $('.iconsContainer').toggleClass("Hidden");
    }

    function SetFilter(e,filterType) {
        const imgHtml = e.outerHTML;
        const searchInput = document.getElementsByClassName('inputSearch');
        searchInput.placeholder = `Enter ${filterType}`;
        $('.icon').html(imgHtml);
        $('.iconsContainer').addClass("Hidden");
        GlobalFilter = filterType
    }

    function InputChange(id,status) {
        let string = ".Update-" + id;
        console.log(string);
        var target = document.querySelector(string);

        if (target) {
            if(status){
                target.classList.add("highlight");

            }else{
                target.classList.remove("highlight");

            }
        }
    }

    // update logic

    function update(id) {

        var Rowsinput = document.querySelectorAll(".Rowinput-" + id);

        // Create a data object
        var data = {
            "name": Rowsinput[0].value,
            "email": Rowsinput[1].value,
            "phone": Rowsinput[2].value,
            "position": Rowsinput[3].value,
            "department": Rowsinput[4].value
        };


        $.ajax({
            type: 'PUT',
            url: 'ModifyEmployee/' + id,
            data: JSON.stringify(data),
            processData: false, // No processing for data
            contentType: 'application/json', // Set content type to JSON
            success: function (response) {
                console.log("Success:", response);
                InputChange(id,false)
            },
            error: function (xhr) {
                alert("Error: " + xhr.responseText);
            }
        });
    }

    // Delete Logic
    function deleteEmp(id) {
        $.ajax({
            type: 'DELETE',
            url: 'DelEmployee/' + id,
            processData: false,
            contentType: 'application/json',
            success: function (response) {
                console.log("Success:", response);

                let query = ".SingleRow-" + id;
                console.log($(query));
                $(query).remove();
            },
            error: function (xhr) {
                alert("Error: " + xhr.responseText);
            }
        });
    }


    // add logic

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

    //ToggleLogic

    function ToggleHiddness(){
        console.log("jaja")
        $('#AddForm').toggleClass("Hidden");
    }

    $('.inputSearch').on('input', function(event) {

        const searchValue = event.target.value.toLowerCase();

        console.log(document.querySelectorAll("#" + GlobalFilter + "Rows"))

            console.log("#" + GlobalFilter + "Rows")
        document.querySelectorAll("#" + GlobalFilter + "Rows").forEach(function(row) {
            const inputValue = row.querySelector('input').value.toLowerCase();
            console.log("Input Value: ", inputValue);

            let tmpid = row.getAttribute('data-id');

            console.log(inputValue.includes(searchValue))
            if(searchValue ==""){
                $(`.SingleRow-` + tmpid).removeClass('Highlights');
            }else{
                if (inputValue.includes(searchValue)) {
                    $(`.SingleRow-` + tmpid).addClass('Highlights');
                } else {
                    console.log("unhighlit" + tmpid)
                    $(`.SingleRow-` + tmpid).removeClass('Highlights');
                }
            }


        });
    });








</script>
<style>
    .Highlights{
        background-color: green !important;
    }
</style>