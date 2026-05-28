<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký Tài khoản - À La Carte Hotel</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <jsp:include page="components/public_header.jsp" />
    <div class="auth-container animate-fade-in-up">
        <div class="card auth-card glass-panel">
            <h2 style="text-align: center; margin-bottom: 2rem;">Đăng ký Hội viên</h2>
            
            <% if (request.getAttribute("error") != null) { %>
                <div style="color: var(--danger); text-align: center; margin-bottom: 1rem;">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form action="register" method="POST">
                <div class="form-group">
                    <label class="form-label">Tên đăng nhập (Username)</label>
                    <input type="text" name="username" class="form-input" placeholder="Tạo tên đăng nhập" required>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Họ và tên</label>
                    <input type="text" name="name" class="form-input" placeholder="Nhập họ tên của bạn" required>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Mật khẩu</label>
                    <input type="password" name="password" class="form-input" placeholder="Tạo mật khẩu" required>
                </div>
                
                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem;">
                    Đăng ký ngay
                </button>
            </form>

            <div style="margin-top: 1.5rem; text-align: center; font-size: 0.9rem;">
                Đã có tài khoản? <a href="login.jsp" style="color: var(--primary); text-decoration: none;">Đăng nhập tại đây</a>
            </div>
        </div>
    </div>
    <jsp:include page="components/footer.jsp" />
</body>
</html>
