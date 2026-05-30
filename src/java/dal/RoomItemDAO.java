package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.RoomItem;

public class RoomItemDAO extends DBContext {

    public List<RoomItem> getAllItems() {
        List<RoomItem> list = new ArrayList<>();
        String sql = "SELECT * FROM RoomItem";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new RoomItem(rs.getInt("id"), rs.getString("name"), rs.getInt("compensation_price")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
