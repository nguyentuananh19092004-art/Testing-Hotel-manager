<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả Tìm kiếm - À LA CARTE HẠ LONG BAY</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
    
    <c:set var="bgImage" value="https://images.unsplash.com/photo-1540541338287-41700207dee6?q=80&w=2000" />
    <c:if test="${not empty selectedCategoryObj}">
        <c:choose>
            <c:when test="${selectedCategoryObj.name == 'Standard'}">
                <c:set var="bgImage" value="https://images.unsplash.com/photo-1631049307264-da0ec9d70304?q=80&w=2000" />
            </c:when>
            <c:when test="${selectedCategoryObj.name == 'Deluxe'}">
                <c:set var="bgImage" value="https://images.unsplash.com/photo-1590490360182-c33d57733427?q=80&w=2000" />
            </c:when>
            <c:otherwise>
                <c:set var="bgImage" value="https://images.unsplash.com/photo-1618773928121-c32242e63f39?q=80&w=2000" />
            </c:otherwise>
        </c:choose>
    </c:if>

    <style>
        .search-results-bg {
            background-color: #f8fafc;
            background-image: radial-gradient(#cbd5e1 1px, transparent 1px);
            background-size: 20px 20px;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            padding-top: 80px;
        }
        .search-results-content { flex-grow: 1; padding: 40px 0; }
        .glass-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 12px;
            border: 1px solid rgba(107, 70, 193, 0.1);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .glass-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(107, 70, 193, 0.15);
        }
        .side-image {
            height: calc(100vh - 160px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            background-size: cover;
            background-position: center;
            border: 8px solid white;
        }
    </style>
</head>
<body class="search-results-bg">

    <jsp:include page="components/public_header.jsp" />

    <!-- Search Results -->
    <main class="search-results-content">
        <div class="container-fluid px-4">
            <c:if test="${not empty rooms}">
                <div class="text-center mb-5 animate-fade-in-up">
                    <h2 class="display-5 fw-bold mb-3" style="color: #1e293b; text-shadow: 0 2px 10px rgba(0,0,0,0.05);">PHÒNG TRỐNG SẴN SÀNG</h2>
                    <p class="fs-5" style="color: #64748b;">
                        Hạng phòng <strong style="color: #6b46c1;">${selectedCategoryObj.name}</strong> từ <strong>${selectedCheckIn}</strong> đến <strong>${selectedCheckOut}</strong>
                    </p>
                </div>
                
                <div class="row justify-content-center animate-fade-in-up animate-delay-3">
                    <!-- Ảnh bên trái -->
                    <div class="col-lg-3 d-none d-lg-block">
                        <div class="side-image sticky-top" style="top: 100px; background-image: url('${bgImage}');"></div>
                    </div>
                    
                    <!-- Danh sách phòng ở giữa -->
                    <div class="col-md-10 col-lg-6 px-4">
                        <c:forEach items="${rooms}" var="r">
                            <div class="card glass-card mb-4 p-4 d-flex flex-row justify-content-between align-items-center">
                                <div>
                                    <h4 class="fw-bold mb-1" style="color: #1e293b;">Phòng số ${r.id}</h4>
                                    <p class="text-secondary mb-0"><i class="bi bi-building me-2"></i>Nằm tại tầng ${r.floor}</p>
                                </div>
                                <form action="customer" method="POST" class="m-0">
                                    <input type="hidden" name="action" value="book">
                                    <input type="hidden" name="roomId" value="${r.id}">
                                    <input type="hidden" name="price" value="0"> 
                                    <button type="submit" class="btn btn-primary fw-bold px-4 py-2 shadow-sm" style="background-color: #6b46c1; border-color: #6b46c1; border-radius: 8px;">
                                        ĐẶT PHÒNG
                                    </button>
                                </form>
                            </div>
                        </c:forEach>
                        
                        <div class="text-center mt-5">
                            <a href="home" class="btn btn-outline-secondary px-4 py-2 fw-medium rounded-pill"><i class="bi bi-arrow-left me-2"></i>Tìm phòng khác</a>
                        </div>
                    </div>

                    <!-- Ảnh bên phải -->
                    <div class="col-lg-3 d-none d-lg-block">
                        <div class="side-image sticky-top" style="top: 100px; background-image: url('${bgImage}'); transform: scaleX(-1);"></div>
                    </div>
                </div>
            </c:if>
            
            <c:if test="${empty rooms and not empty selectedCheckIn}">
                <div class="text-center mt-5 pt-5 animate-fade-in-up">
                    <h2 class="display-4 fw-bold mb-4" style="color: #ef4444; text-shadow: 0 2px 4px rgba(0,0,0,0.1);">HẾT PHÒNG</h2>
                    <p class="fs-5 mb-5" style="color: #64748b; max-width: 600px; margin: 0 auto;">
                        Rất tiếc, Hạng phòng <strong style="color: #6b46c1;">${selectedCategoryObj.name}</strong> đã được đặt kín trong khung thời gian bạn chọn. Vui lòng thử ngày khác hoặc xem hạng phòng khác.
                    </p>
                    <a href="home" class="btn btn-primary btn-lg px-5 shadow-lg" style="background-color: #6b46c1; border-color: #6b46c1; border-radius: 30px;">
                        <i class="bi bi-arrow-left me-2"></i>Quay lại Trang chủ
                    </a>
                </div>
            </c:if>
        </div>
    </main>

    <jsp:include page="components/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
