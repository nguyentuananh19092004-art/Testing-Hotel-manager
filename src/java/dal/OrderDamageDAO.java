package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.OrderDamage;

public class OrderDamageDAO extends DBContext {

    public void addDamage(OrderDamage d) {
        String sql = "INSERT INTO OrderDamage (order_id, item_id, quantity, total_cost) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, d.getOrderId());
            st.setInt(2, d.getItemId());
            st.setInt(3, d.getQuantity());
            st.setInt(4, d.getTotalCost());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public List<OrderDamage> getDamagesByOrderId(int orderId) {
        List<OrderDamage> list = new ArrayList<>();
        String sql = "SELECT * FROM OrderDamage WHERE order_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new OrderDamage(rs.getInt("id"), rs.getInt("order_id"), rs.getInt("item_id"), rs.getInt("quantity"), rs.getInt("total_cost")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
