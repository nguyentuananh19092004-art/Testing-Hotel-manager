package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.RoomCategory;

public class RoomCategoryDAO extends DBContext {

    public List<RoomCategory> getAllCategories() {
        List<RoomCategory> list = new ArrayList<>();
        String sql = "SELECT * FROM RoomCategory";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new RoomCategory(rs.getInt("id"), rs.getString("name"), rs.getInt("price"), rs.getInt("capacity"), rs.getString("description")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public RoomCategory getCategoryById(int id) {
        String sql = "SELECT * FROM RoomCategory WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new RoomCategory(rs.getInt("id"), rs.getString("name"), rs.getInt("price"), rs.getInt("capacity"), rs.getString("description"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
