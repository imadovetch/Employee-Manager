package GE.controller;

import GE.DAO.EmployeeDAO;
import GE.model.Employee;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;

import java.io.IOException;
import java.util.List;

public class EmployeeController extends HttpServlet {
    private final EmployeeDAO employeeDAO = new EmployeeDAO();

    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        // Fetch all employees from the database
//        List<Employee> employees = employeeDAO.fetchAllEmployees();
//
//        if (employees != null) {
//            Gson gson = new Gson();
//            String employeeJson = gson.toJson(employees);
//
//            response.setContentType("application/json");
//            response.setCharacterEncoding("UTF-8");
//            response.setStatus(HttpServletResponse.SC_OK); // 200 OK
//            response.getWriter().write(employeeJson);
//        } else {
//            response.setStatus(HttpServletResponse.SC_NOT_FOUND); // 404 Not Found
//            response.getWriter().write("No employees found.");
//        }
//    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Fetch all employees from the database
        List<Employee> employees = employeeDAO.fetchAllEmployees();

        if (employees != null) {
            // Set the employee list as a request attribute
            request.setAttribute("employees", employees);


            request.getRequestDispatcher("Home.jsp").forward(request, response);
        } else {
            // Handle case where no employees are found
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write("No employees found.");
        }
    }



    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone_number = request.getParameter("phone");
        String position = request.getParameter("position");
        String department = request.getParameter("department");

        if (name != null && email != null && phone_number != null && position != null && department != null) {
            Employee employee = new Employee(name, email, phone_number, position, department);
            employeeDAO.save(employee);

            response.setStatus(HttpServletResponse.SC_CREATED); // 201 Created
            response.getWriter().write("Employee added successfully.");
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400 Bad Request
            response.getWriter().write("Missing employee details.");
        }
    }

    @Override
    public void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        String pathInfo = request.getPathInfo();

        if (pathInfo != null && pathInfo.length() > 1) {
            // Read the input data
            BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
            StringBuilder sb = new StringBuilder();
            String line;

            String idString = pathInfo.substring(1);
            int employeeId = Integer.parseInt(idString);

            while ((line = br.readLine()) != null) {
                sb.append(line);
            }

            String data = sb.toString(); // Get the complete request body
            System.out.println("Received data: " + data); // Optional: log the received data

            // Assuming the data is URL-encoded, parse it
            String[] params = data.split("&");
            String name = null, email = null, phone = null, position = null, department = null;

            for (String param : params) {
                String[] keyValue = param.split("=");
                if (keyValue.length == 2) {
                    String key = URLDecoder.decode(keyValue[0], StandardCharsets.UTF_8.name());
                    String value = URLDecoder.decode(keyValue[1], StandardCharsets.UTF_8.name());

                    switch (key) {
                        case "name":
                            name = value;
                            break;
                        case "email":
                            email = value;
                            break;
                        case "phone":
                            phone = value;
                            break;
                        case "position":
                            position = value;
                            break;
                        case "department":
                            department = value;
                            break;
                    }
                }
            }

            // Call the DAO update method
            try {
                Employee employee = new Employee(name, email, phone, position, department);
                employeeDAO.update(employee,employeeId);
                response.setStatus(HttpServletResponse.SC_OK); // 200 OK
                response.getWriter().write("Employee updated successfully.");
            } catch (Exception e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500 Internal Server Error
                response.getWriter().write("Error updating employee: " + e.getMessage());
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400 Bad Request
            response.getWriter().write("Invalid employee ID.");
        }

    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo(); // e.g., "/1"

        if (pathInfo != null && pathInfo.length() > 1) {
            String idString = pathInfo.substring(1);
            int employeeId = Integer.parseInt(idString);

            boolean deleted = employeeDAO.delete(employeeId);

            if (deleted) {
                response.setStatus(HttpServletResponse.SC_NO_CONTENT); // 204 No Content
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND); // 404 Not Found
                response.getWriter().write("Employee not found.");
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400 Bad Request
            response.getWriter().write("Invalid employee ID.");
        }
    }
}
