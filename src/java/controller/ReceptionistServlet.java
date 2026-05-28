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

@WebServlet(name = "ReceptionistServlet", urlPatterns = {"/receptionist"})
public class ReceptionistServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");
        
        if (user == null || !user.getRole().equals("receptionist")) {
            response.sendRedirect("login.jsp");
            return;
        }

        RoomDAO roomDAO = new RoomDAO();
        OrderDAO orderDAO = new OrderDAO();

        request.setAttribute("rooms", roomDAO.getAllRooms());
        request.setAttribute("orders", orderDAO.getAllOrders());

        request.getRequestDispatcher("pages/receptionist.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        String action = request.getParameter("action");
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String roomId = request.getParameter("roomId");

        RoomDAO roomDAO = new RoomDAO();
        OrderDAO orderDAO = new OrderDAO();

        if ("checkin".equals(action)) {
            orderDAO.updateOrderStatus(orderId, "Đang ở");
            roomDAO.updateRoomStatus(roomId, "Occupied");
        } else if ("checkout".equals(action)) {
            orderDAO.updateOrderStatus(orderId, "Đã Check-out");
            roomDAO.updateRoomStatus(roomId, "Needs Cleaning");
        }
        
        response.sendRedirect("receptionist");
    }
}
