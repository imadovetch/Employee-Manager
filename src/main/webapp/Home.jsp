<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body class="FullPage patern">
<nav class="Navbar ">
    <h1 class="title">Gestionnaire D'employés</h1>
    <div style="width: 60% ; height: fit-content; display: flex; justify-content: space-between; ">
        <label style="position: relative; box-shadow: rgba(0, 0, 0, 0.19) 0px 10px 20px, rgba(0, 0, 0, 0.23) 0px 6px 6px; background-color: #e1e1e1ab;" class="label" >
            <div class="iconsContainer Hidden" style="position: absolute; z-index: 999; width: 20%; min-height: fit-content; display: flex; flex-direction: column; justify-content: center; gap:5px; padding: 10px 0; align-items: center;  background-color: rgb(255, 255, 255); border-radius: 15px;  right: 0; top: 100%;">
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
                    placeholder="Enter querry"
                    autocomplete="off"
            />
        </label>


        <button class="cssbuttons-io-button AddHover" style="box-shadow: rgba(0, 0, 0, 0.16) 0px 3px 6px, rgba(0, 0, 0, 0.23) 0px 3px 6px;" onclick="ToggleHiddness()">
            <svg
                    height="24"
                    width="24"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
            >
                <path d="M0 0h24v24H0z" fill="none"></path>
                <path d="M11 11V5h2v6h6v2h-6v6h-2v-6H5v-2z" fill="currentColor"></path>
            </svg>
            <span>Add</span>
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
        margin: 30px;
        margin-top: 10px;
        justify-content: center;
        align-items: center;
        flex-direction: column;
    }
    .title{
        float: left;
        align-self: start;
    }
    .Container{
        margin: 10px 50px;
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
            color: black;
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
        console.log(filterType)
        console.log(searchInput)
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

                console.log(response)
               NewData(response)
                ToggleHiddness();

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


    function NewData(data) {
        console.log("appending");
        let Containerrows = document.querySelectorAll(".RowsContainer");
        console.log(Containerrows);
        console.log(data);

        // Adding data to the "NameRows" container
        Containerrows[0].innerHTML += (
            '<div id="NameRows" data-id="' + data.id + '" class="SingleRow SingleRow-' + data.id + '">'
            + '<input oninput="InputChange(' + data.id + ', true)" class="Rowinput-' + data.id + '" value="' + data.name + '" />'
            + '</div>'
        );

        // Adding data to the "EmailRows" container
        Containerrows[1].innerHTML += (
            '<div id="EmailRows" data-id="' + data.id + '" class="SingleRow SingleRow-' + data.id + '">'
            + '<input oninput="InputChange(' + data.id + ', true)" class="Rowinput-' + data.id + '" value="' + data.email + '" />'
            + '</div>'
        );

        // Adding data to the "PhoneRows" container
        Containerrows[2].innerHTML += (
            '<div id="PhoneRows" data-id="' + data.id + '" class="SingleRow SingleRow-' + data.id + '">'
            + '<input oninput="InputChange(' + data.id + ', true)" class="Rowinput-' + data.id + '" value="' + data.phone + '" />'
            + '</div>'
        );

        // Adding data to the "PositionRows" container
        Containerrows[3].innerHTML += (
            '<div id="PositionRows" data-id="' + data.id + '" class="SingleRow SingleRow-' + data.id + '">'
            + '<input oninput="InputChange(' + data.id + ', true)" class="Rowinput-' + data.id + '" value="' + data.position + '" />'
            + '</div>'
        );

        // Adding data to the "DepartmentRows" container
        Containerrows[4].innerHTML += (
            '<div id="DepartmentRows" data-id="' + data.id + '" class="SingleRow SingleRow-' + data.id + '">'
            + '<input oninput="InputChange(' + data.id + ', true)" class="Rowinput-' + data.id + '" value="' + data.department + '" />'
            + '</div>'
        );

        // Handling action rows (Update and Delete buttons)
        let ActionRows = document.querySelectorAll(".ActionColumn");

        // Adding update button
        ActionRows[0].innerHTML += (
            '<div id="UpdateRows-' + data.id + '" data-id="' + data.id + '" class="SingleRow SingleRow-' + data.id + '">'
            + '<svg onClick="update(' + data.id + ')" style="height: 30px" class="Update-' + data.id + '" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">'
            + '<path d="M471.6 21.7c-21.9-21.9-57.3-21.9-79.2 0L362.3 51.7l97.9 97.9 30.1-30.1c21.9-21.9 21.9-57.3 0-79.2L471.6 21.7zm-299.2 220c-6.1 6.1-10.8 13.6-13.5 21.9l-29.6 88.8c-2.9 8.6-.6 18.1 5.8 24.6s15.9 8.7 24.6 5.8l88.8-29.6c8.2-2.7 15.7-7.4 21.9-13.5L437.7 172.3 339.7 74.3 172.4 241.7zM96 64C43 64 0 107 0 160L0 416c0 53 43 96 96 96l256 0c53 0 96-43 96-96l0-96c0-17.7-14.3-32-32-32s-32 14.3-32 32l0 96c0 17.7-14.3 32-32 32L96 448c-17.7 0-32-14.3-32-32l0-256c0-17.7 14.3-32 32-32l96 0c17.7 0 32-14.3 32-32s-14.3-32-32-32L96 64z"/>'
            + '</svg></div>'
        );

        // Adding delete button
        ActionRows[1].innerHTML += (
            '<div id="DeleteRows-' + data.id + '" onClick="deleteEmp(' + data.id + ')" data-id="' + data.id + '" class="SingleRow SingleRow-' + data.id + '">'
            + '<svg style="fill: red; height: 30px" class="Delete-' + data.id + '" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">'
            + '<path d="M135.2 17.7C140.6 6.8 151.7 0 163.8 0L284.2 0c12.1 0 23.2 6.8 28.6 17.7L320 32l96 0c17.7 0 32 14.3 32 32s-14.3 32-32 32L32 96C14.3 96 0 81.7 0 64S14.3 32 32 32l96 0 7.2-14.3zM32 128l384 0v320c0 35.3-28.7 64-64 64H96c-35.3 0-64-28.7-64-64V128zM96 192c-8.8 0-16 7.2-16 16v224c0 8.8 7.2 16 16 16s16-7.2 16-16V208c0-8.8-7.2-16-16-16zm96 0c-8.8 0-16 7.2-16 16v224c0 8.8 7.2 16 16 16s16-7.2 16-16V208c0-8.8-7.2-16-16-16zm96 0c-8.8 0-16 7.2-16 16v224c0 8.8 7.2 16 16 16s16-7.2 16-16V208c0-8.8-7.2-16-16-16z"/>'
            + '</svg></div>'
        );
    }



</script>
<style>
    .Highlights {
        background-color: green !important;
    }
    /*//patern*/
    .patern {
        width: 100%;
        height: 100%;
        --color: rgb(185 185 185 / 30%);
        background-color: #b2b2b238;
        background-image: linear-gradient(46deg, transparent 24%, var(--color) 25%, var(--color) 26%, transparent 27%, transparent 74%, var(--color) 75%, var(--color) 76%, transparent 77%, transparent), linear-gradient(90deg, transparent 24%, var(--color) 25%, var(--color) 26%, transparent 27%, transparent 74%, var(--color) 75%, var(--color) 76%, transparent 77%, transparent);
        background-size: 30px 40px;
    }
    /* From Uiverse.io by adamgiebl */
    .cssbuttons-io-button {
        display: flex;
        align-items: center;
        font-family: inherit;
        cursor: pointer;
        font-weight: 500;
        font-size: 16px;
        padding: 0.7em 1.4em 0.7em 1.1em;
        color: white;
        background: #ad5389;
        background: linear-gradient(
                0deg,
                rgba(20, 167, 62, 1) 0%,
                rgba(102, 247, 113, 1) 100%
        );
        border: none;
        box-shadow: 0 0.7em 1.5em -0.5em #14a73e98;
        letter-spacing: 0.05em;
        border-radius: 20em;
    }

    .cssbuttons-io-button svg {
        margin-right: 6px;
    }

    .cssbuttons-io-button:hover {
        box-shadow: 0 0.5em 1.5em -0.5em #14a73e98;
    }

    .cssbuttons-io-button:active {
        box-shadow: 0 0.3em 1em -0.5em #14a73e98;
    }

    .AddHover:hover{
        transform: scale(1.05);
        opacity: 0.85;
    }
</style>