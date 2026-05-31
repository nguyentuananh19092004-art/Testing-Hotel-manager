<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manager Dashboard</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body { background-color: #f8fafc; }
        .stat-card {
            transition: transform 0.2s;
            border-left: 4px solid;
        }
        .stat-card:hover {
            transform: translateY(-5px);
        }
        .stat-revenue { border-left-color: #10b981; }
        .stat-occupancy { border-left-color: #3b82f6; }
        .stat-cleaning { border-left-color: #ef4444; }
        
        .action-card {
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s;
        }
        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important;
        }
    </style>
</head>
<body>
    <jsp:include page="../components/dashboard_header.jsp" />

    <%-- Tính toán số liệu bằng JSTL --%>
    <c:set var="totalRevenue" value="0" />
    <c:forEach items="${orders}" var="o">
        <c:if test="${o.status == 'Đã Check-out'}">
            <c:set var="totalRevenue" value="${totalRevenue + o.total}" />
        </c:if>
    </c:forEach>

    <c:set var="totalRooms" value="0" />
    <c:set var="activeRooms" value="0" />
    <c:set var="cleaningRooms" value="0" />
    <c:forEach items="${rooms}" var="r">
        <c:set var="totalRooms" value="${totalRooms + 1}" />
        <c:if test="${r.status == 'Occupied' || r.status == 'Reserved'}">
            <c:set var="activeRooms" value="${activeRooms + 1}" />
        </c:if>
        <c:if test="${r.status == 'Needs Cleaning'}">
            <c:set var="cleaningRooms" value="${cleaningRooms + 1}" />
        </c:if>
    </c:forEach>
    <fmt:parseNumber var="occupancyRate" value="${totalRooms > 0 ? (activeRooms * 100.0 / totalRooms) : 0}" integerOnly="true" />

    <div class="container my-5 py-3 animate-fade-in-up">
        <h2 class="fw-bold mb-4" style="color: #1e293b;">Báo Cáo Tổng Quan Hôm Nay</h2>
        
        <!-- Statistics Cards -->
        <div class="row g-4 mb-5">
            <div class="col-md-4">
                <div class="card stat-card stat-revenue h-100 border-0 shadow-sm rounded-4 p-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="text-secondary m-0">Tổng Doanh Thu</h5>
                        <i class="bi bi-currency-dollar fs-3 text-success"></i>
                    </div>
                    <h2 class="fw-bold text-success mb-1">
                        <fmt:formatNumber value="${totalRevenue}" pattern="#,###" /> ₫
                    </h2>
                    <p class="text-muted small m-0"><i class="bi bi-arrow-up-right text-success"></i> Cập nhật theo thời gian thực</p>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card stat-card stat-occupancy h-100 border-0 shadow-sm rounded-4 p-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="text-secondary m-0">Công Suất Phòng</h5>
                        <i class="bi bi-building fs-3 text-primary"></i>
                    </div>
                    <h2 class="fw-bold text-primary mb-1">${occupancyRate}%</h2>
                    <p class="text-muted small m-0">${activeRooms} / ${totalRooms} phòng đang sử dụng</p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card stat-card stat-cleaning h-100 border-0 shadow-sm rounded-4 p-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="text-secondary m-0">Phòng Cần Dọn</h5>
                        <i class="bi bi-stars fs-3 text-danger"></i>
                    </div>
                    <h2 class="fw-bold text-danger mb-1">${cleaningRooms}</h2>
                    <p class="text-muted small m-0">Đang chờ Housekeeper xử lý</p>
                </div>
            </div>
        </div>

        <h2 class="fw-bold mb-4 mt-5" style="color: #1e293b;">Chức Năng Quản Lý</h2>
        
        <!-- Management Actions -->
        <div class="row g-4">
            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/admin/employees" class="card action-card h-100 border-0 shadow-sm rounded-4 text-center p-5">
                    <div class="card-body d-flex flex-column justify-content-center align-items-center">
                        <div class="bg-primary bg-opacity-10 rounded-circle p-4 mb-3">
                            <i class="bi bi-people-fill fs-1 text-primary"></i>
                        </div>
                        <h4 class="fw-bold text-dark">Quản lý Nhân Viên</h4>
                        <p class="text-secondary mt-2">Xem danh sách, thêm sửa xóa tài khoản nhân sự</p>
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/admin/shifts" class="card action-card h-100 border-0 shadow-sm rounded-4 text-center p-5">
                    <div class="card-body d-flex flex-column justify-content-center align-items-center">
                        <div class="bg-warning bg-opacity-10 rounded-circle p-4 mb-3">
                            <i class="bi bi-calendar2-check fs-1 text-warning"></i>
                        </div>
                        <h4 class="fw-bold text-dark">Phân công Ca Làm Việc</h4>
                        <p class="text-secondary mt-2">Xếp ca trực cho Lễ tân và Nhân viên dọn phòng</p>
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/manager?action=reviews" class="card action-card h-100 border-0 shadow-sm rounded-4 text-center p-5">
                    <div class="card-body d-flex flex-column justify-content-center align-items-center">
                        <div class="bg-success bg-opacity-10 rounded-circle p-4 mb-3">
                            <i class="bi bi-star-fill fs-1 text-success"></i>
                        </div>
                        <h4 class="fw-bold text-dark">Quản lý Đánh Giá</h4>
                        <p class="text-secondary mt-2">Xem và phân tích phản hồi dịch vụ từ khách hàng</p>
                    </div>
                </a>
            </div>
        </div>
    </div>

    <jsp:include page="../components/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
