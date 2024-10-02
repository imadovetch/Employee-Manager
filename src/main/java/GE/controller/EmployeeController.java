package GE.controller;

import GE.DAO.EmployeeDAO;
import GE.model.Employee;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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
            Gson gson = new Gson();
            String employeeJson = gson.toJson(employees);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.setStatus(HttpServletResponse.SC_OK); // 200 OK
            response.getWriter().write(employeeJson);
        } else {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND); // 404 Not Found
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

        String idString = request.getParameter("id");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone_number = request.getParameter("phone");
        String position = request.getParameter("position");
        String department = request.getParameter("department");

        if (idString != null && name != null && email != null && phone_number != null && position != null && department != null) {
            int id = Integer.parseInt(idString);
            Employee employee = new Employee(name, email, phone_number, position, department);
            employee.setId(id);

            boolean updated = employeeDAO.update(employee);

            if (updated) {
                response.setStatus(HttpServletResponse.SC_OK); // 200 OK
                response.getWriter().write("Employee updated successfully.");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND); // 404 Not Found
                response.getWriter().write("Employee not found.");
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400 Bad Request
            response.getWriter().write("Missing or invalid employee details.");
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
