package controller;

import dal.RoomDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "HousekeeperServlet", urlPatterns = {"/housekeeper"})
public class HousekeeperServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");
        
        if (user == null || !user.getRole().equals("housekeeper")) {
            response.sendRedirect("login.jsp");
            return;
        }

        RoomDAO roomDAO = new RoomDAO();
        request.setAttribute("rooms", roomDAO.getAllRooms());

        request.getRequestDispatcher("pages/housekeeper.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        String action = request.getParameter("action");
        if ("clean".equals(action)) {
            String roomId = request.getParameter("roomId");
            RoomDAO roomDAO = new RoomDAO();
            roomDAO.updateRoomStatus(roomId, "Available");
        }
        
        response.sendRedirect("housekeeper");
    }
}
