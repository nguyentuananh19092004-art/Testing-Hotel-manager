package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {
    protected Connection connection;

    public DBContext() {
        try {
            String user = "sa";
            String pass = "123";
            // Thêm encrypt=true;trustServerCertificate=true để tránh lỗi SSL/TLS của driver mới
            String url = "jdbc:sqlserver://localhost:1433;databaseName=HotelManagement;encrypt=true;trustServerCertificate=true;";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException ex) {
            System.out.println("Lỗi: Không tìm thấy JDBC Driver (mssql-jdbc.jar). Vui lòng kiểm tra lại thư viện thư mục lib.");
            ex.printStackTrace();
        } catch (SQLException ex) {
            System.out.println("Lỗi: Không thể kết nối tới SQL Server. Vui lòng kiểm tra lại SQL Server đã bật TCP/IP port 1433 chưa, hoặc sai mật khẩu sa.");
            ex.printStackTrace();
        }
    }
}
