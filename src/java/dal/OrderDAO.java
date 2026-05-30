package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Order;

public class OrderDAO extends DBContext {

    public boolean createOrder(Order order) {
        String sql = "INSERT INTO Orders (room_id, customer_username, total, check_in_date, check_out_date, status, payment_status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, order.getRoomId());
            st.setString(2, order.getCustomerUsername());
            st.setInt(3, order.getTotal());
            st.setDate(4, order.getCheckInDate());
            st.setDate(5, order.getCheckOutDate());
            st.setString(6, order.getStatus()); // 'Chờ Check-in'
            st.setString(7, order.getPaymentStatus()); // 'Unpaid'
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void updatePaymentStatus(int orderId, String paymentStatus) {
        String sql = "UPDATE Orders SET payment_status = ? WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, paymentStatus);
            st.setInt(2, orderId);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
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
            e.printStackTrace();
        }
    }

    public List<Order> getOrdersByUsername(String username) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE customer_username = ? ORDER BY id DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Order(rs.getInt("id"), rs.getString("room_id"), rs.getString("customer_username"), rs.getInt("total"), rs.getDate("check_in_date"), rs.getDate("check_out_date"), rs.getString("status"), rs.getString("payment_status")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM Orders ORDER BY id DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Order(rs.getInt("id"), rs.getString("room_id"), rs.getString("customer_username"), rs.getInt("total"), rs.getDate("check_in_date"), rs.getDate("check_out_date"), rs.getString("status"), rs.getString("payment_status")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
