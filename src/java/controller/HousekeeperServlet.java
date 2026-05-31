package controller;

import dal.RoomDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.User;
import dal.CleaningTaskDAO;
import model.CleaningTask;

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
        dal.ShiftAssignmentDAO saDAO = new dal.ShiftAssignmentDAO();
        CleaningTaskDAO ctDAO = new CleaningTaskDAO();
        
        model.ShiftAssignment currentShift = saDAO.getCurrentShift(user.getUsername());
        
        if (currentShift != null) {
            request.setAttribute("hasShift", true);
            request.setAttribute("shiftFloor", currentShift.getFloor());
            request.setAttribute("rooms", roomDAO.getAllRooms());
            // Lấy tất cả các task chưa hoàn thành trên tầng được phân công, kể cả task chưa có người nhận
            List<CleaningTask> tasks = ctDAO.getPendingTasksByFloor(currentShift.getFloor());
            request.setAttribute("tasks", tasks);
        } else {
            request.setAttribute("hasShift", false);
            request.setAttribute("message", "Bạn không có ca trực dọn phòng vào thời điểm hiện tại.");
        }

        request.getRequestDispatcher("pages/housekeeper.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        String action = request.getParameter("action");
        if ("clean".equals(action)) {
            String roomId = request.getParameter("roomId");
            String taskIdStr = request.getParameter("taskId");
            
            RoomDAO roomDAO = new RoomDAO();
            roomDAO.updateRoomStatus(roomId, "Available");
            
            if (taskIdStr != null && !taskIdStr.isEmpty()) {
                CleaningTaskDAO ctDAO = new CleaningTaskDAO();
                ctDAO.updateTaskStatus(Integer.parseInt(taskIdStr), "Completed");
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/housekeeper");
    }
}
