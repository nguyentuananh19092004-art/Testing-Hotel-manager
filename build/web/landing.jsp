<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>À LA CARTE HẠ LONG BAY</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Thêm ?v=<%= System.currentTimeMillis() %> để chống cache CSS của trình duyệt -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>

    <!-- Navbar Overlay -->
    <nav class="navbar navbar-expand-lg position-absolute w-100 z-3 pt-3">
        <div class="container-fluid px-5">
            <a href="home" class="navbar-brand fw-bold fs-4" style="color: #6b46c1; letter-spacing: 1px;">À LA CARTE</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav align-items-center me-4">
                    <li class="nav-item"><a class="nav-link text-white fw-medium" href="#rooms">Phòng Nghỉ</a></li>
                    <li class="nav-item"><a class="nav-link text-white fw-medium" href="#services">Dịch Vụ</a></li>
                </ul>
                <div class="d-flex gap-3 align-items-center">
                    <c:choose>
                        <c:when test="${not empty sessionScope.currentUser}">
                            <c:choose>
                                <c:when test="${sessionScope.currentUser.role == 'customer'}"><a href="customer" class="btn btn-outline-light">Quản Lý Đơn</a></c:when>
                                <c:when test="${sessionScope.currentUser.role == 'manager'}"><a href="manager" class="btn btn-outline-light">Trang Quản Lý</a></c:when>
                                <c:when test="${sessionScope.currentUser.role == 'receptionist'}"><a href="receptionist" class="btn btn-outline-light">Quầy Lễ Tân</a></c:when>
                                <c:otherwise><span class="text-white me-3">Xin chào, ${sessionScope.currentUser.name}</span></c:otherwise>
                            </c:choose>
                            <a href="logout" class="btn btn-primary" style="background-color: #6b46c1; border-color: #6b46c1;">Đăng xuất</a>
                        </c:when>
                        <c:otherwise>
                            <a href="login.jsp" class="btn btn-outline-light">Đăng nhập</a>
                            <a href="register.jsp" class="btn btn-primary" style="background-color: #6b46c1; border-color: #6b46c1;">Đăng ký</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <header class="hero d-flex flex-column justify-content-center align-items-center text-center">
        <h1 class="display-2 fw-bold text-white mb-3" style="text-shadow: 0 4px 20px rgba(0,0,0,0.5);">Trải nghiệm Nghỉ dưỡng<br>Đỉnh cao</h1>
        <p class="lead text-light mb-5" style="max-width: 800px; text-shadow: 0 2px 10px rgba(0,0,0,0.5);">Chào mừng đến với À La Carte Hạ Long Bay - Nơi không gian sang trọng giao thoa cùng kỳ quan thiên nhiên thế giới.</p>
        <button class="btn btn-primary btn-lg px-5 py-3 shadow-lg" style="background-color: #6b46c1; border-color: #6b46c1; border-radius: 8px;" onclick="document.getElementById('rooms').scrollIntoView({ behavior: 'smooth' });">Khám Phá Ngay</button>
    </header>

    <!-- Rooms Section -->
    <section class="py-5" id="rooms">
        <div class="container my-5">
            <h2 class="text-center fw-bold mb-5 text-dark" style="font-size: 2.5rem;">Hệ Thống Phòng Nghỉ</h2>
            <div class="row g-4">
                <c:forEach items="${categories}" var="cat">
                    <div class="col-md-4">
                        <div class="card h-100 border-0 shadow-sm room-card-hover">
                            <c:choose>
                                <c:when test="${cat.name == 'Standard'}">
                                    <div class="card-img-top" style="height: 250px; background-image: url('https://images.unsplash.com/photo-1631049307264-da0ec9d70304?q=80&w=600'); background-size: cover; background-position: center;"></div>
                                </c:when>
                                <c:when test="${cat.name == 'Deluxe'}">
                                    <div class="card-img-top" style="height: 250px; background-image: url('https://images.unsplash.com/photo-1590490360182-c33d57733427?q=80&w=600'); background-size: cover; background-position: center;"></div>
                                </c:when>
                                <c:otherwise>
                                    <div class="card-img-top" style="height: 250px; background-image: url('https://images.unsplash.com/photo-1618773928121-c32242e63f39?q=80&w=600'); background-size: cover; background-position: center;"></div>
                                </c:otherwise>
                            </c:choose>
                            <div class="card-body p-4 d-flex flex-column">
                                <h3 class="h4 mb-2 text-dark">Phòng ${cat.name}</h3>
                                <div class="fs-5 fw-semibold mb-3" style="color: #6b46c1;">${String.format("%,d", cat.price)} VNĐ / Đêm</div>
                                <p class="text-secondary small mb-4 flex-grow-1">Sức chứa tối đa ${cat.capacity} người.<br>${cat.description}</p>
                                <button class="btn btn-light w-100 fw-semibold text-secondary" style="background-color: #f1f5f9; transition: all 0.3s;" onmouseover="this.style.backgroundColor='#6b46c1'; this.style.color='white'" onmouseout="this.style.backgroundColor='#f1f5f9'; this.style.color='#6c757d'" onclick="openModal(${cat.id}, 'Phòng ${cat.name}')">Kiểm tra phòng trống</button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </section>



    <!-- Booking Modal (Mô phỏng bằng Bootstrap Modal) -->
    <div class="modal fade" id="bookingModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow-lg" style="border-radius: 12px;">
                <div class="modal-header border-0 pb-0">
                    <h5 class="modal-title fs-4 fw-bold text-center w-100">Tra cứu phòng</h5>
                    <button type="button" class="btn-close" onclick="closeModal()"></button>
                </div>
                <div class="modal-body px-5 py-4">
                    <p class="mb-4 text-center">Đang chọn: <strong id="modalCatName" style="color: #6b46c1;"></strong></p>
                    
                    <form action="home" method="POST">
                        <input type="hidden" id="modalCatId" name="categoryId" value="">
                        <div class="mb-3">
                            <label class="form-label fw-medium text-secondary">Ngày Check-in (Từ 14:00)</label>
                            <input type="date" name="checkIn" class="form-control form-control-lg" required>
                        </div>
                        <div class="mb-4">
                            <label class="form-label fw-medium text-secondary">Ngày Check-out (Đến 12:00)</label>
                            <input type="date" name="checkOut" class="form-control form-control-lg" required>
                        </div>
                        <button type="submit" class="btn btn-primary btn-lg w-100 fw-bold" style="background-color: #6b46c1; border-color: #6b46c1;">TRA CỨU</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-light py-5 border-top border-secondary">
        <div class="container">
            <div class="row mb-4 pb-4 border-bottom border-secondary">
                <div class="col-md-6 mb-4 mb-md-0">
                    <div class="fs-4 fw-bold mb-3" style="letter-spacing: 2px;">À LA CARTE<span style="color: #6b46c1;">.</span></div>
                    <p class="text-secondary" style="max-width: 300px; line-height: 1.8;">Trải nghiệm không gian nghỉ dưỡng đỉnh cao nơi kỳ quan thiên nhiên thế giới.</p>
                </div>
                <div class="col-md-6 text-md-end text-secondary">
                    <p class="mb-2"><strong class="text-light">Hotline:</strong> 0904.536.822</p>
                    <p class="mb-2"><strong class="text-light">Email:</strong> contact@alacarte.com.vn</p>
                    <p class="mb-0"><strong class="text-light">Địa chỉ:</strong> Hạ Long Marina, Bãi Cháy, Quảng Ninh</p>
                </div>
            </div>
            <div class="text-center text-secondary small">
                &copy; 2026 À La Carte Ha Long Bay. All rights reserved.
            </div>
        </div>
    </footer>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        var bsModal = null;
        document.addEventListener("DOMContentLoaded", function() {
            bsModal = new bootstrap.Modal(document.getElementById('bookingModal'), {
                keyboard: false
            });
        });
        
        function openModal(id, name) {
            document.getElementById("modalCatId").value = id;
            document.getElementById("modalCatName").innerText = name;
            if(bsModal) bsModal.show();
        }
        function closeModal() {
            if(bsModal) bsModal.hide();
        }
    </script>
</body>
</html>
