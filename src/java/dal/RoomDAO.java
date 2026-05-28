package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Room;

public class RoomDAO extends DBContext {
    
    public List<Room> getAllRooms() {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT * FROM Rooms";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Room(
                    rs.getString("id"),
                    rs.getString("type"),
                    rs.getString("status"),
                    rs.getInt("price"),
                    rs.getString("features")
                ));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public void updateRoomStatus(String roomId, String status) {
        String sql = "UPDATE Rooms SET status = ? WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, status);
            st.setString(2, roomId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}
