<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký Tài khoản - À La Carte Hotel</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="bg-light">
    <jsp:include page="components/public_header.jsp" />
    <div class="container my-5 py-5 d-flex justify-content-center animate-fade-in-up">
        <div class="card shadow-lg border-0" style="width: 100%; max-width: 450px; border-radius: 12px;">
            <div class="card-body p-5">
                <h2 class="text-center mb-4 fw-bold" style="color: #6b46c1;">Đăng ký Hội viên</h2>
                
                <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger text-center py-2">
                        <%= request.getAttribute("error") %>
                    </div>
                <% } %>

                <form action="register" method="POST">
                    <div class="mb-3">
                        <label class="form-label fw-medium text-secondary">Tên đăng nhập (Username)</label>
                        <input type="text" name="username" class="form-control form-control-lg bg-light" placeholder="Tạo tên đăng nhập" required>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label fw-medium text-secondary">Họ và tên</label>
                        <input type="text" name="name" class="form-control form-control-lg bg-light" placeholder="Nhập họ tên của bạn" required>
                    </div>
                    
                    <div class="mb-4">
                        <label class="form-label fw-medium text-secondary">Mật khẩu</label>
                        <input type="password" name="password" class="form-control form-control-lg bg-light" placeholder="Tạo mật khẩu" required>
                    </div>
                    
                    <button type="submit" class="btn btn-primary btn-lg w-100 fw-bold shadow-sm" style="background-color: #6b46c1; border-color: #6b46c1;">
                        Đăng ký ngay
                    </button>
                </form>

                <div class="text-center mt-4" style="font-size: 0.95rem;">
                    Đã có tài khoản? <a href="login.jsp" style="color: #6b46c1; text-decoration: none; font-weight: 600;">Đăng nhập tại đây</a>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="components/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
