package controller;

import dal.OrderDAO;
import dal.RoomDAO;
import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "ManagerServlet", urlPatterns = { "/manager" })
public class ManagerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");

        if (user == null || !user.getRole().equals("manager")) {
            response.sendRedirect("login.jsp");
            return;
        }

        RoomDAO roomDAO = new RoomDAO();
        OrderDAO orderDAO = new OrderDAO();
        UserDAO userDAO = new UserDAO();

        request.setAttribute("rooms", roomDAO.getAllRooms());
        request.setAttribute("orders", orderDAO.getAllOrders());
        request.setAttribute("users", userDAO.getAllUsers());

        String action = request.getParameter("action");
        if ("reviews".equals(action)) {
            request.getRequestDispatcher("pages/review_management.jsp").forward(request, response);
            return;
        }

        request.getRequestDispatcher("pages/manager.jsp").forward(request, response);
    }
}
