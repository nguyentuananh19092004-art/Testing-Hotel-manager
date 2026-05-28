package controller;

import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        UserDAO dao = new UserDAO();
        User account = dao.login(user, pass);

        if (account != null) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", account);
            
            // Redirect based on role
            switch (account.getRole()) {
                case "customer":
                    response.sendRedirect("customer");
                    break;
                case "receptionist":
                    response.sendRedirect("receptionist");
                    break;
                case "housekeeper":
                    response.sendRedirect("housekeeper");
                    break;
                case "manager":
                    response.sendRedirect("manager");
                    break;
                default:
                    response.sendRedirect("index.jsp");
            }
        } else {
            request.setAttribute("error", "Sai tài khoản hoặc mật khẩu!");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}
