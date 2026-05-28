<%@page import="model.User"%>
<%@page import="java.util.List"%>
<%@page import="model.Room"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>À La Carte - Luxury Hotel</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <%
        User currentUser = (User) session.getAttribute("currentUser");
    %>
    <jsp:include page="components/public_header.jsp" />

    <div class="hero-section animate-fade-in-up">
        <div class="hero-overlay"></div>
        <div class="hero-content">
            <h1 class="hero-title">Trải nghiệm Nghỉ dưỡng Đỉnh cao</h1>
            <p class="hero-subtitle">Chào mừng đến với À La Carte Hạ Long Bay - Nơi không gian sang trọng giao thoa cùng kỳ quan thiên nhiên thế giới.</p>
            <a href="#rooms" class="btn btn-primary" style="font-size: 1.1rem; padding: 1rem 2rem;">Khám Phá Ngay</a>
        </div>
    </div>

    <div class="container animate-fade-in-up animate-delay-1" id="rooms" style="padding-top: 5rem; padding-bottom: 5rem;">
        <div style="text-align: center; margin-bottom: 4rem;">
            <h2 style="font-size: 2.5rem; color: var(--text-main);">Hạng Phòng Tuyệt Đỉnh</h2>
            <p style="color: var(--text-muted);">Tận hưởng sự thư giãn tuyệt đối với các phòng nghỉ được thiết kế hiện đại và đầy đủ tiện nghi.</p>
        </div>

        <div class="grid grid-cols-3">
            <%
                List<Room> rooms = (List<Room>) request.getAttribute("rooms");
                if (rooms != null) {
                    for (Room r : rooms) {
                        if (r.getStatus().equals("Available")) {
                            // Assign image based on room type
                            String imgPath = "img/room_standard.png";
                            if(r.getType().contains("Deluxe")) imgPath = "img/room_deluxe.png";
                            if(r.getType().contains("Suite")) imgPath = "img/room_suite.png";
            %>
            <div class="card glass-panel animate-fade-in-up animate-delay-2" style="display:flex; flex-direction:column; padding-bottom: 1.5rem;">
                <img src="<%= imgPath %>" alt="Room Image" class="room-img">
                
                <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom: 1rem;">
                    <h3 style="margin:0; color:var(--text-main);">Phòng <%= r.getId() %></h3>
                    <span class="badge badge-primary"><%= r.getType() %></span>
                </div>
                
                <p style="color:var(--text-muted); font-size:0.95rem; margin-bottom: 1.5rem; min-height: 40px;">
                    <%= r.getFeatures() %>
                </p>
                
                <div style="font-size: 1.5rem; font-weight: 700; color: #10b981; margin-bottom: 1.5rem;">
                    <%= String.format("%,d", r.getPrice()) %> đ <span style="font-size: 0.9rem; color: var(--text-muted); font-weight: 400;">/ đêm</span>
                </div>
                
                <% if (currentUser == null) { %>
                    <a href="login.jsp" class="btn btn-primary" style="margin-top:auto; text-decoration: none;">Đăng nhập để Đặt phòng</a>
                <% } else if (currentUser.getRole().equals("customer")) { %>
                    <form action="customer" method="POST" style="margin-top:auto;">
                        <input type="hidden" name="action" value="book">
                        <input type="hidden" name="roomId" value="<%= r.getId() %>">
                        <input type="hidden" name="price" value="<%= r.getPrice() %>">
                        <button type="submit" class="btn btn-primary" style="width: 100%;" onclick="return confirm('Xác nhận đặt phòng <%= r.getId() %>?');">
                            Đặt phòng ngay
                        </button>
                    </form>
                <% } else { %>
                    <button class="btn btn-primary" style="margin-top:auto; background: var(--border); cursor: not-allowed;" disabled>
                        Chỉ Khách hàng mới được Đặt
                    </button>
                <% } %>
            </div>
            <%
                        }
                    }
                }
            %>
        </div>
    </div>
    
    <jsp:include page="components/footer.jsp" />
</body>
</html>
