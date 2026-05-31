<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Đánh giá</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body { background-color: #f8fafc; }
    </style>
</head>
<body>
    <jsp:include page="../components/dashboard_header.jsp" />

    <div class="container my-5 py-3 animate-fade-in-up">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold m-0" style="color: #1e293b;">Quản lý Phản hồi & Đánh giá</h2>
            <a href="${pageContext.request.contextPath}/manager" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left"></i> Quay lại Dashboard
            </a>
        </div>

        <div class="card shadow-sm border-0 rounded-4 overflow-hidden mb-5">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="py-3 px-4">Mã Booking</th>
                            <th class="py-3 px-4">Khách hàng</th>
                            <th class="py-3 px-4">Phòng</th>
                            <th class="py-3 px-4">Đánh giá (Sao)</th>
                            <th class="py-3 px-4">Ghi chú / Nhận xét</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="hasReview" value="false" />
                        <c:forEach items="${orders}" var="o">
                            <c:if test="${o.rating > 0}">
                                <c:set var="hasReview" value="true" />
                                <tr>
                                    <td class="px-4 py-3"><strong class="text-secondary">#${o.id}</strong></td>
                                    <td class="px-4 py-3 fw-medium">${o.customerUsername}</td>
                                    <td class="px-4 py-3">Phòng ${o.roomId}</td>
                                    <td class="px-4 py-3">
                                        <span class="text-warning fs-5">
                                            <c:forEach begin="1" end="${o.rating}">★</c:forEach>
                                        </span>
                                    </td>
                                    <td class="px-4 py-3">
                                        <c:choose>
                                            <c:when test="${not empty o.note}">
                                                <i>"${o.note}"</i>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">Không có ghi chú</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        
                        <c:if test="${not hasReview}">
                            <tr><td colspan="5" class="text-center py-5 text-secondary">
                                <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                Chưa có khách hàng nào đánh giá dịch vụ.
                            </td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <jsp:include page="../components/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
