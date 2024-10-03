package GE.controller;

import GE.DAO.EmployeeDAO;
import GE.model.Employee;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import java.util.List;

public class EmployeeController extends HttpServlet {
    private final EmployeeDAO employeeDAO = new EmployeeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Employee> employees = employeeDAO.fetchAllEmployees();

        if (employees != null) {
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

        HttpSession session = request.getSession();

        if (name != null && email != null && phone_number != null && position != null && department != null) {
            Employee employee = new Employee(name, email, phone_number, position, department);

            employeeDAO.save(employee);  // Assuming `save` returns a boolean indicating success.



                session.setAttribute("flashMessage", "Employee added successfully!");

            response.sendRedirect(request.getContextPath() + "/");
        } else {
            session.setAttribute("flashMessage", "Please fill out all the fields.");
            response.sendRedirect("Home.jsp");
        }
    }


}
