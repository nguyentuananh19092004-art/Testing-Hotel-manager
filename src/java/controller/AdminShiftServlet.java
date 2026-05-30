package controller;

import dal.ShiftAssignmentDAO;
import dal.ShiftDAO;
import dal.UserDAO;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Shift;
import model.ShiftAssignment;
import model.User;

@WebServlet(name = "AdminShiftServlet", urlPatterns = {"/admin/shifts"})
public class AdminShiftServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        ShiftAssignmentDAO saDAO = new ShiftAssignmentDAO();
        ShiftDAO shiftDAO = new ShiftDAO();
        UserDAO userDAO = new UserDAO();
        
        if ("add".equals(action)) {
            String username = request.getParameter("username");
            int shiftId = Integer.parseInt(request.getParameter("shift_id"));
            int floor = Integer.parseInt(request.getParameter("floor"));
            String dateStr = request.getParameter("assign_date");
            
            ShiftAssignment sa = new ShiftAssignment();
            sa.setUsername(username);
            sa.setShiftId(shiftId);
            sa.setFloor(floor);
            sa.setAssignDate(Date.valueOf(dateStr));
            
            saDAO.addAssignment(sa);
            response.sendRedirect(request.getContextPath() + "/admin/shifts");
            return;
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            saDAO.deleteAssignment(id);
            response.sendRedirect(request.getContextPath() + "/admin/shifts");
            return;
        }
        
        List<ShiftAssignment> assignments = saDAO.getAllAssignments();
        List<Shift> shifts = shiftDAO.getAllShifts();
        List<User> employees = userDAO.getAllEmployees(); // Hoặc lọc riêng housekeeper nếu muốn
        
        request.setAttribute("assignments", assignments);
        request.setAttribute("shifts", shifts);
        request.setAttribute("employees", employees);
        
        request.getRequestDispatcher("/admin_shifts.jsp").forward(request, response);
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
