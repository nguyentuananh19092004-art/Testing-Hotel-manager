<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Hệ thống Quản lý Khách sạn</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <jsp:include page="components/public_header.jsp" />
    <div class="auth-container animate-fade-in-up">
        <div class="card auth-card glass-panel">
            <h2 style="text-align: center; margin-bottom: 2rem;">Đăng nhập</h2>
            
            <% if (request.getParameter("msg") != null && request.getParameter("msg").equals("registered")) { %>
                <div style="color: #10b981; text-align: center; margin-bottom: 1rem;">Đăng ký thành công! Vui lòng đăng nhập.</div>
            <% } %>
            <% if (request.getAttribute("error") != null) { %>
                <div style="color: var(--danger); text-align: center; margin-bottom: 1rem;"><%= request.getAttribute("error") %></div>
            <% } %>

            <form action="login" method="POST">
                <div class="form-group">
                    <label class="form-label">Tài khoản</label>
                    <input type="text" name="username" class="form-input" placeholder="Nhập tài khoản" required>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Mật khẩu</label>
                    <input type="password" name="password" class="form-input" placeholder="Nhập mật khẩu" required>
                </div>
                
                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem;">
                    Đăng nhập hệ thống
                </button>
            </form>

            <div style="margin-top: 1.5rem; text-align: center; font-size: 0.9rem;">
                Chưa có tài khoản? <a href="register.jsp" style="color: var(--primary); text-decoration: none;">Đăng ký ngay</a>
            </div>

            <div style="margin-top: 2rem; border-top: 1px solid var(--border); padding-top: 1rem; font-size: 0.85rem; color: var(--text-muted);">
                <p>Tài khoản Demo (Database):</p>
                <ul style="list-style-type: none; margin-top: 0.5rem; display: grid; gap: 0.5rem;">
                    <li>Khách hàng: <strong>khachhang/123</strong></li>
                    <li>Lễ tân: <strong>letan/123</strong></li>
                    <li>Dọn phòng: <strong>donphong/123</strong></li>
                    <li>Quản lý: <strong>quanly/123</strong></li>
                </ul>
            </div>
        </div>
    </div>
    <jsp:include page="components/footer.jsp" />
</body>
</html>
