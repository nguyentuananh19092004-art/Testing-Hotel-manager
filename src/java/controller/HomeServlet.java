package controller;

import dal.RoomCategoryDAO;
import dal.RoomDAO;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Room;
import model.RoomCategory;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        RoomCategoryDAO categoryDAO = new RoomCategoryDAO();
        List<RoomCategory> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        
        request.getRequestDispatcher("landing.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        // Get form parameters
        String checkInStr = request.getParameter("checkIn");
        String checkOutStr = request.getParameter("checkOut");
        String categoryIdStr = request.getParameter("categoryId");
        
        RoomCategoryDAO categoryDAO = new RoomCategoryDAO();
        request.setAttribute("categories", categoryDAO.getAllCategories()); // Keep dropdown populated
        
        try {
            Date checkIn = Date.valueOf(checkInStr);
            Date checkOut = Date.valueOf(checkOutStr);
            int categoryId = Integer.parseInt(categoryIdStr);
            
            RoomDAO roomDAO = new RoomDAO();
            List<Room> availableRooms = roomDAO.getAvailableRooms(categoryId, checkIn, checkOut);
            
            request.setAttribute("rooms", availableRooms);
            request.setAttribute("selectedCheckIn", checkInStr);
            request.setAttribute("selectedCheckOut", checkOutStr);
            request.setAttribute("selectedCategory", categoryId);
            
        } catch (Exception e) {
            request.setAttribute("error", "Vui lòng chọn ngày hợp lệ!");
        }
        request.getRequestDispatcher("search_results.jsp").forward(request, response);
    }
}
