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
<nav class="Navbar">
  <h1 class="title">Gestionnaire D'employés</h1>
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
  }
  .Container{
    margin: 10px;
    border: 1px solid;
    flex-grow: 1;
    display: grid;
    grid-template-columns: repeat(6, 1fr);
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
    height: 10%;
    padding: 0;
    margin: 0;
    border-bottom: 2px solid;
    font-family:sans-serif;
    font-size:large;
    font-weight: 500;
  }
  .RowsContainer, .RowsActionsr{
    width: 100%;
    height: 90%;
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
  }
</style>
</html>

