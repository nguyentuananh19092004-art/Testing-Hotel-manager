package controller;

import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        String name = request.getParameter("name");

        User newUser = new User(user, pass, "customer", name);
        UserDAO dao = new UserDAO();
        
        if (dao.register(newUser)) {
            response.sendRedirect("login.jsp?msg=registered");
        } else {
            request.setAttribute("error", "Tên đăng nhập đã tồn tại hoặc có lỗi xảy ra!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
