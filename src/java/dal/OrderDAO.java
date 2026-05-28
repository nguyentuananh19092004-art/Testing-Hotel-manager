package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Order;

public class OrderDAO extends DBContext {
    
    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM Orders";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Order(
                    rs.getInt("id"),
                    rs.getString("roomId"),
                    rs.getString("customerUsername"),
                    rs.getInt("total"),
                    rs.getString("status")
                ));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public void insertOrder(String roomId, String username, int total, String status) {
        String sql = "INSERT INTO Orders (roomId, customerUsername, total, status) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, roomId);
            st.setString(2, username);
            st.setInt(3, total);
            st.setString(4, status);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE Orders SET status = ? WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, status);
            st.setInt(2, orderId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}
