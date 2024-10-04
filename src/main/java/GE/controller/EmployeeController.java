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

            // Return the newly created employee as JSON
            response.setStatus(HttpServletResponse.SC_CREATED); // 201 Created
            String jsonResponse = String.format("{\"id\": %d, \"name\": \"%s\", \"email\": \"%s\", \"phone\": \"%s\", \"position\": \"%s\", \"department\": \"%s\"}",
                    employee.getId(), employee.getName(), employee.getEmail(), employee.getPhone(), employee.getPosition(), employee.getDepartment());
            response.getWriter().write(jsonResponse);
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400 Bad Request
            response.getWriter().write("Missing employee details.");
        }
    }


    @Override
    public void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set character encoding to handle UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        String pathInfo = request.getPathInfo();

        if (pathInfo != null && pathInfo.length() > 1) {
            // Get the employee ID from the path
            String idString = pathInfo.substring(1);
            int employeeId = Integer.parseInt(idString);

            // Read the input data
            StringBuilder sb = new StringBuilder();
            String line;
            BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));

            while ((line = br.readLine()) != null) {
                sb.append(line);
            }

            String jsonData = sb.toString(); // Get the complete request body
            System.out.println("Received data: " + jsonData); // Log the received data

            // Parse the JSON data
            Gson gson = new Gson();
            Employee employee = gson.fromJson(jsonData, Employee.class);

            // Call the DAO update method
            try {
                employeeDAO.update(employee, employeeId);
                response.setStatus(HttpServletResponse.SC_OK); // 200 OK
                response.getWriter().write("{\"message\": \"Employee updated successfully.\"}");
            } catch (Exception e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500 Internal Server Error
                response.getWriter().write("{\"error\": \"Error updating employee: " + e.getMessage() + "\"}");
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400 Bad Request
            response.getWriter().write("{\"error\": \"Invalid employee ID.\"}");
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
                response.getWriter().write("Deleted successfly.");
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
