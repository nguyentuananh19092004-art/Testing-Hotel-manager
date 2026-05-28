package controller;

import dal.OrderDAO;
import dal.RoomDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Order;
import model.Room;
import model.User;

//
//12345
@WebServlet(name = "CustomerServlet", urlPatterns = { "/customer" })
public class CustomerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");

        if (user == null || !user.getRole().equals("customer")) {
            response.sendRedirect("login.jsp");
            return;
        }

        RoomDAO roomDAO = new RoomDAO();
        OrderDAO orderDAO = new OrderDAO();

        List<Room> allRooms = roomDAO.getAllRooms();
        List<Order> allOrders = orderDAO.getAllOrders();

        // Lọc hiển thị
        request.setAttribute("rooms", allRooms);
        request.setAttribute("orders", allOrders);

        request.getRequestDispatcher("pages/customer.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");

        String action = request.getParameter("action");
        if ("book".equals(action)) {
            String roomId = request.getParameter("roomId");
            int price = Integer.parseInt(request.getParameter("price"));

            RoomDAO roomDAO = new RoomDAO();
            OrderDAO orderDAO = new OrderDAO();

            roomDAO.updateRoomStatus(roomId, "Reserved");
            orderDAO.insertOrder(roomId, user.getUsername(), price, "Chờ Check-in");
        }

        response.sendRedirect("customer");
    }
}
