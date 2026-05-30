<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả Tìm kiếm - À LA CARTE HẠ LONG BAY</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
    <style>
        body { background-color: #f8fafc; }
        .navbar-static {
            background-color: #0f172a;
            position: relative;
            padding: 20px 60px;
        }
    </style>
</head>
<body>

    <!-- Navbar Overlay -->
    <nav class="navbar navbar-static">
        <a href="home" class="logo">À LA CARTE</a>
        
        <div class="nav-right">
            <div class="nav-links">
                <a href="home">Trang chủ</a>
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

    <!-- Search Results -->
    <c:if test="${not empty rooms}">
        <section class="search-results">
            <h2 class="section-title">PHÒNG TRỐNG SẴN SÀNG</h2>
            <div style="text-align: center; margin-bottom: 40px; color: #64748b;">
                Kết quả tra cứu từ <strong>${selectedCheckIn}</strong> đến <strong>${selectedCheckOut}</strong>
            </div>
            
            <div style="max-width: 800px; margin: auto;">
                <c:forEach items="${rooms}" var="r">
                    <div class="room-card-result">
                        <div>
                            <h4>Mã phòng: ${r.id}</h4>
                            <p style="color: #64748b;">Nằm tại tầng ${r.floor}</p>
                        </div>
                        <form action="customer" method="POST">
                            <input type="hidden" name="action" value="book">
                            <input type="hidden" name="roomId" value="${r.id}">
                            <input type="hidden" name="price" value="0"> 
                            <button type="submit" class="btn-solid" style="padding: 10px 20px; font-size: 0.9rem;">ĐẶT PHÒNG</button>
                        </form>
                    </div>
                </c:forEach>
            </div>
            
            <div style="text-align: center; margin-top: 40px;">
                <a href="home" style="color: #6b46c1; text-decoration: none; font-weight: 600;">&larr; Quay lại danh sách Hạng phòng</a>
            </div>
        </section>
    </c:if>
    <c:if test="${empty rooms and not empty selectedCheckIn}">
        <section class="search-results">
            <h2 class="section-title" style="color: #ef4444;">HẾT PHÒNG</h2>
            <p style="text-align: center; color: #64748b; margin-bottom: 30px;">Hạng phòng này đã được đặt kín trong khung thời gian bạn chọn. Vui lòng thử ngày khác.</p>
            <div style="text-align: center;">
                <a href="home" class="btn-solid">Quay lại Trang chủ</a>
            </div>
        </section>
    </c:if>

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
</body>
</html>
