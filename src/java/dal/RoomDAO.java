package dal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Room;

public class RoomDAO extends DBContext {

    public List<Room> getAvailableRooms(int categoryId, Date checkIn, Date checkOut) {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT r.* FROM Room r "
                   + "WHERE r.category_id = ? AND r.status != 'Maintenance' "
                   + "AND r.id NOT IN ("
                   + "    SELECT o.room_id FROM Orders o "
                   + "    WHERE o.status IN (N'Chờ Check-in', N'Đang ở') "
                   + "    AND (o.check_in_date < ? AND o.check_out_date > ?) "
                   + ")";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, categoryId);
            st.setDate(2, checkOut); // order check_in < desired check_out
            st.setDate(3, checkIn);  // order check_out > desired check_in
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Room(rs.getString("id"), rs.getInt("category_id"), rs.getInt("floor"), rs.getString("status")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Room> getRoomsByFloor(int floor) {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT * FROM Room WHERE floor = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, floor);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Room(rs.getString("id"), rs.getInt("category_id"), rs.getInt("floor"), rs.getString("status")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void updateRoomStatus(String roomId, String status) {
        String sql = "UPDATE Room SET status = ? WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, status);
            st.setString(2, roomId);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Room> getAllRooms() {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT * FROM Room";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Room(rs.getString("id"), rs.getInt("category_id"), rs.getInt("floor"), rs.getString("status")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
