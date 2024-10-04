package GE;


import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class Middleware implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization logic, if any
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String method = httpRequest.getMethod(); // Get the HTTP method (GET, POST, etc.)
        String servletPath = httpRequest.getServletPath(); // Get the request URL path

        // Log the incoming request for debugging purposes
        System.out.println("Method: " + method + ", Path: " + servletPath);


        // Validate POST for /addEmployee
        if ("POST".equalsIgnoreCase(method)) {
            if (!"/addEmployee".equals(servletPath)) {
                httpResponse.setStatus(HttpServletResponse.SC_FORBIDDEN); // 403 Forbidden
                httpResponse.getWriter().write("{\"error\": \"Invalid route for POST request.\"}");
                return;
            }
        }


        if ("GET".equalsIgnoreCase(method)) {
            if (!("/GetEmployee".equals(servletPath) || "/".equals(servletPath))) {
                httpResponse.setStatus(HttpServletResponse.SC_FORBIDDEN); // 403 Forbidden
                httpResponse.getWriter().write("{\"error\": \"Invalid route for GET request.\"}");
                return;
            }
        }


        if ("DELETE".equalsIgnoreCase(method)) {
            if (!servletPath.startsWith("/DelEmployee")) {
                httpResponse.setStatus(HttpServletResponse.SC_FORBIDDEN);
                httpResponse.getWriter().write("{\"error\": \"Invalid route for DELETE request.\"}");
                return;
            }

        }

        if ("PUT".equalsIgnoreCase(method)) {
            if (!servletPath.startsWith("/ModifyEmployee")) {
                httpResponse.setStatus(HttpServletResponse.SC_FORBIDDEN);
                httpResponse.getWriter().write("{\"error\": \"Invalid route for PUT request.\"}");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup code, if any
    }
}
