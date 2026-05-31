<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Hệ thống Quản lý Khách sạn</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="bg-light">
    <jsp:include page="components/public_header.jsp" />
    <div class="container my-5 py-5 d-flex justify-content-center animate-fade-in-up">
        <div class="card shadow-lg border-0" style="width: 100%; max-width: 400px; border-radius: 12px;">
            <div class="card-body p-5">
                <h2 class="text-center mb-4 fw-bold" style="color: #6b46c1;">Đăng nhập</h2>
                
                <% if (request.getParameter("msg") != null && request.getParameter("msg").equals("registered")) { %>
                    <div class="alert alert-success text-center py-2">Đăng ký thành công! Vui lòng đăng nhập.</div>
                <% } %>
                <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger text-center py-2"><%= request.getAttribute("error") %></div>
                <% } %>

                <form action="login" method="POST">
                    <div class="mb-3">
                        <label class="form-label fw-medium text-secondary">Tài khoản</label>
                        <input type="text" name="username" class="form-control form-control-lg bg-light" placeholder="Nhập tài khoản" required>
                    </div>
                    
                    <div class="mb-4">
                        <label class="form-label fw-medium text-secondary">Mật khẩu</label>
                        <input type="password" name="password" class="form-control form-control-lg bg-light" placeholder="Nhập mật khẩu" required>
                    </div>
                    
                    <button type="submit" class="btn btn-primary btn-lg w-100 fw-bold shadow-sm" style="background-color: #6b46c1; border-color: #6b46c1;">
                        Đăng nhập hệ thống
                    </button>
                </form>

                <div class="text-center mt-4" style="font-size: 0.95rem;">
                    Chưa có tài khoản? <a href="register.jsp" style="color: #6b46c1; text-decoration: none; font-weight: 600;">Đăng ký ngay</a>
                </div>

                <div class="mt-4 pt-3 border-top text-center" style="font-size: 0.85rem; color: #64748b;">
                    <p class="mb-2">Tài khoản Demo (Database):</p>
                    <ul class="list-unstyled mb-0 d-grid gap-1">
                        <li>Khách hàng: <strong>khachhang/123</strong></li>
                        <li>Lễ tân: <strong>letan/123</strong></li>
                        <li>Dọn phòng: <strong>donphong/123</strong></li>
                        <li>Quản lý: <strong>quanly/123</strong></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="components/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
