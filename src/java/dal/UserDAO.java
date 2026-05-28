package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.User;

public class UserDAO extends DBContext {
    
    public User login(String username, String password) {
        String sql = "SELECT * FROM Users WHERE username = ? AND password = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new User(
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("role"),
                    rs.getString("name")
                );
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public java.util.List<User> getAllUsers() {
        java.util.List<User> list = new java.util.ArrayList<>();
        String sql = "SELECT * FROM Users";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new User(
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("role"),
                    rs.getString("name")
                ));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public boolean register(User user) {
        String sql = "INSERT INTO Users (username, password, role, name) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user.getUsername());
            st.setString(2, user.getPassword());
            st.setString(3, user.getRole());
            st.setString(4, user.getName());
            int result = st.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }
}
