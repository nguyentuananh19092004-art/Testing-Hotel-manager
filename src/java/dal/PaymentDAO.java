package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Payment;

public class PaymentDAO extends DBContext {

    public void createPayment(Payment p) {
        String sql = "INSERT INTO Payment (order_id, payment_method, amount, receptionist_username) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, p.getOrderId());
            st.setString(2, p.getPaymentMethod());
            st.setInt(3, p.getAmount());
            st.setString(4, p.getReceptionistUsername());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public List<Payment> getAllPayments() {
        List<Payment> list = new ArrayList<>();
        String sql = "SELECT * FROM Payment ORDER BY payment_date DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Payment(rs.getInt("id"), rs.getInt("order_id"), rs.getString("payment_method"), rs.getInt("amount"), rs.getTimestamp("payment_date"), rs.getString("receptionist_username")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
