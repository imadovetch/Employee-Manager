package GE.controller;

import GE.DAO.EmployeeDAO;
import GE.model.Employee;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URLDecoder; // Import URLDecoder
import java.nio.charset.StandardCharsets; // Import StandardCharsets for encoding

public class EmployeeController extends HttpServlet {
    private final EmployeeDAO employeeDAO = new EmployeeDAO();



    @Override
    public void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set character encoding to handle UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        // Read the input data
        BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
        StringBuilder sb = new StringBuilder();
        String line;

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
            employeeDAO.update(employee,3); // Call the update method
            response.setStatus(HttpServletResponse.SC_OK); // 200 OK
            response.getWriter().write("Employee updated successfully.");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500 Internal Server Error
            response.getWriter().write("Error updating employee: " + e.getMessage());
        }
    }
}
