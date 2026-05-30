package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.CleaningTask;
import model.User;

public class CleaningTaskDAO extends DBContext {

    public boolean addCleaningTask(CleaningTask task) {
        String sql = "INSERT INTO CleaningTask (room_id, assigned_to) VALUES (?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, task.getRoomId());
            st.setString(2, task.getAssignedTo());
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<CleaningTask> getTasksByHousekeeper(String username) {
        List<CleaningTask> list = new ArrayList<>();
        String sql = "SELECT * FROM CleaningTask WHERE assigned_to = ? ORDER BY created_at DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new CleaningTask(
                        rs.getInt("id"),
                        rs.getString("room_id"),
                        rs.getString("assigned_to"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("completed_at")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateTaskStatus(int taskId, String status) {
        String sql = "UPDATE CleaningTask SET status = ?, completed_at = CASE WHEN ? = 'Completed' THEN GETDATE() ELSE completed_at END WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, status);
            st.setString(2, status);
            st.setInt(3, taskId);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
