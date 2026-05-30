package controller;

import dal.UserDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

@WebServlet(name = "AdminEmployeeServlet", urlPatterns = {"/admin/employees"})
public class AdminEmployeeServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        UserDAO userDAO = new UserDAO();
        
        if ("add".equals(action)) {
            String username = request.getParameter("username");
            String name = request.getParameter("name");
            String password = request.getParameter("password");
            String role = request.getParameter("role");
            String phone = request.getParameter("phone");
            String gmail = request.getParameter("gmail");
            
            User user = new User(username, password, role, name, phone, gmail);
            userDAO.register(user);
            response.sendRedirect(request.getContextPath() + "/admin/employees");
            return;
        } else if ("delete".equals(action)) {
            String username = request.getParameter("username");
            userDAO.deleteUser(username);
            response.sendRedirect(request.getContextPath() + "/admin/employees");
            return;
        }
        
        // List employees
        List<User> employees = userDAO.getAllEmployees();
        request.setAttribute("employees", employees);
        request.getRequestDispatcher("/admin_employees.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
