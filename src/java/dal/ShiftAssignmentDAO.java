package dal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.ShiftAssignment;
import model.Shift;
import model.User;

public class ShiftAssignmentDAO extends DBContext {

    public List<ShiftAssignment> getAllAssignments() {
        List<ShiftAssignment> list = new ArrayList<>();
        String sql = "SELECT sa.*, s.name as shift_name, s.start_time, s.end_time, u.name as user_name, u.role " +
                     "FROM ShiftAssignment sa " +
                     "JOIN Shift s ON sa.shift_id = s.id " +
                     "JOIN Users u ON sa.username = u.username " +
                     "ORDER BY sa.assign_date DESC, sa.shift_id, sa.floor";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                ShiftAssignment sa = new ShiftAssignment(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getInt("shift_id"),
                        rs.getInt("floor"),
                        rs.getDate("assign_date")
                );
                
                Shift shift = new Shift(rs.getInt("shift_id"), rs.getString("shift_name"), rs.getTime("start_time"), rs.getTime("end_time"));
                sa.setShift(shift);
                
                User user = new User();
                user.setUsername(rs.getString("username"));
                user.setName(rs.getString("user_name"));
                user.setRole(rs.getString("role"));
                sa.setUser(user);
                
                list.add(sa);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addAssignment(ShiftAssignment sa) {
        String sql = "INSERT INTO ShiftAssignment (username, shift_id, floor, assign_date) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, sa.getUsername());
            st.setInt(2, sa.getShiftId());
            st.setInt(3, sa.getFloor());
            st.setDate(4, sa.getAssignDate());
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateAssignment(ShiftAssignment sa) {
        String sql = "UPDATE ShiftAssignment SET username = ?, shift_id = ?, floor = ?, assign_date = ? WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, sa.getUsername());
            st.setInt(2, sa.getShiftId());
            st.setInt(3, sa.getFloor());
            st.setDate(4, sa.getAssignDate());
            st.setInt(5, sa.getId());
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteAssignment(int id) {
        String sql = "DELETE FROM ShiftAssignment WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy danh sách nhân viên dọn phòng trực tại 1 tầng, trong 1 ca, vào 1 ngày cụ thể
    public List<ShiftAssignment> getHousekeepersOnDuty(int floor, int shiftId, Date date) {
        List<ShiftAssignment> list = new ArrayList<>();
        String sql = "SELECT sa.*, u.name as user_name FROM ShiftAssignment sa " +
                     "JOIN Users u ON sa.username = u.username " +
                     "WHERE sa.floor = ? AND sa.shift_id = ? AND sa.assign_date = ? AND u.role = 'housekeeper'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, floor);
            st.setInt(2, shiftId);
            st.setDate(3, date);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                ShiftAssignment sa = new ShiftAssignment(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getInt("shift_id"),
                        rs.getInt("floor"),
                        rs.getDate("assign_date")
                );
                User user = new User();
                user.setUsername(rs.getString("username"));
                user.setName(rs.getString("user_name"));
                user.setRole("housekeeper");
                sa.setUser(user);
                list.add(sa);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
