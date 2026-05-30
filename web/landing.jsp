<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>À LA CARTE HẠ LONG BAY</title>
    <!-- Thêm ?v=<%= System.currentTimeMillis() %> để chống cache CSS của trình duyệt -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>

    <!-- Navbar Overlay -->
    <nav class="navbar">
        <a href="home" class="logo">À LA CARTE</a>
        
        <div class="nav-right">
            <div class="nav-links">
                <a href="#rooms">Phòng Nghỉ</a>
                <a href="#services">Dịch Vụ</a>
            </div>
            
            <div class="auth-buttons">
                <c:choose>
                    <c:when test="${not empty sessionScope.currentUser}">
                        <c:choose>
                            <c:when test="${sessionScope.currentUser.role == 'customer'}"><a href="customer" class="btn-outline">Quản Lý Đơn</a></c:when>
                            <c:when test="${sessionScope.currentUser.role == 'manager'}"><a href="manager" class="btn-outline">Trang Quản Lý</a></c:when>
                            <c:when test="${sessionScope.currentUser.role == 'receptionist'}"><a href="receptionist" class="btn-outline">Quầy Lễ Tân</a></c:when>
                            <c:otherwise><a href="#" class="btn-outline">Xin chào, ${sessionScope.currentUser.name}</a></c:otherwise>
                        </c:choose>
                        <!-- Nút Logout thay vì Đăng ký -->
                        <a href="logout" class="btn-solid">Đăng xuất</a>
                    </c:when>
                    <c:otherwise>
                        <a href="login.jsp" class="btn-outline">Đăng nhập</a>
                        <a href="register.jsp" class="btn-solid">Đăng ký</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <header class="hero">
        <h1>Trải nghiệm Nghỉ dưỡng<br>Đỉnh cao</h1>
        <p>Chào mừng đến với À La Carte Hạ Long Bay - Nơi không gian sang trọng giao thoa cùng kỳ quan thiên nhiên thế giới.</p>
        <button class="btn-explore" onclick="document.getElementById('rooms').scrollIntoView({ behavior: 'smooth' });">Khám Phá Ngay</button>
    </header>

    <!-- Rooms Section -->
    <section class="section" id="rooms">
        <h2 class="section-title">Hệ Thống Phòng Nghỉ</h2>
        <div class="room-grid">
            <c:forEach items="${categories}" var="cat">
                <div class="room-card">
                    <c:choose>
                        <c:when test="${cat.name == 'Standard'}">
                            <div class="room-img" style="background-image: url('https://images.unsplash.com/photo-1631049307264-da0ec9d70304?q=80&w=600');"></div>
                        </c:when>
                        <c:when test="${cat.name == 'Deluxe'}">
                            <div class="room-img" style="background-image: url('https://images.unsplash.com/photo-1590490360182-c33d57733427?q=80&w=600');"></div>
                        </c:when>
                        <c:otherwise>
                            <div class="room-img" style="background-image: url('https://images.unsplash.com/photo-1618773928121-c32242e63f39?q=80&w=600');"></div>
                        </c:otherwise>
                    </c:choose>
                    <div class="room-info">
                        <h3>Phòng ${cat.name}</h3>
                        <div class="price">${String.format("%,d", cat.price)} VNĐ / Đêm</div>
                        <p style="color: #64748b; font-size: 0.9rem; margin-bottom: 20px;">Sức chứa tối đa ${cat.capacity} người.<br>${cat.description}</p>
                        <button class="btn-select" onclick="openModal(${cat.id}, 'Phòng ${cat.name}')">Kiểm tra phòng trống</button>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>



    <!-- Booking Modal -->
    <div id="bookingModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h3>Tra cứu phòng</h3>
            <p style="margin-bottom: 20px;">Đang chọn: <strong id="modalCatName" style="color: #6b46c1;"></strong></p>
            
            <form action="home" method="POST">
                <input type="hidden" id="modalCatId" name="categoryId" value="">
                <div class="form-group">
                    <label>Ngày Check-in (Từ 14:00)</label>
                    <input type="date" name="checkIn" required>
                </div>
                <div class="form-group">
                    <label>Ngày Check-out (Đến 12:00)</label>
                    <input type="date" name="checkOut" required>
                </div>
                <button type="submit" class="btn-submit">TRA CỨU</button>
            </form>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-content">
            <div class="footer-brand" style="text-align: left;">
                <div class="footer-logo">À LA CARTE<span>.</span></div>
                <p style="max-width: 300px; line-height: 1.8;">Trải nghiệm không gian nghỉ dưỡng đỉnh cao nơi kỳ quan thiên nhiên thế giới.</p>
            </div>
            <div class="footer-contact" style="text-align: right;">
                <p><strong>Hotline:</strong> 0904.536.822</p>
                <p><strong>Email:</strong> contact@alacarte.com.vn</p>
                <p><strong>Địa chỉ:</strong> Hạ Long Marina, Bãi Cháy, Quảng Ninh</p>
            </div>
        </div>
        <div class="footer-bottom">
            &copy; 2026 À La Carte Ha Long Bay. All rights reserved.
        </div>
    </footer>

    <script>
        var modal = document.getElementById("bookingModal");
        function openModal(id, name) {
            document.getElementById("modalCatId").value = id;
            document.getElementById("modalCatName").innerText = name;
            modal.style.display = "block";
        }
        function closeModal() {
            modal.style.display = "none";
        }
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>
</body>
</html>
