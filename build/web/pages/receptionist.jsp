<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Receptionist Dashboard</title>
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
        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-success alert-dismissible fade show shadow-sm rounded-3 mb-4" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i>${sessionScope.message}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="message" scope="session" />
        </c:if>
        
        <c:if test="${not empty message}">
            <div class="alert alert-warning shadow-sm rounded-3 mb-4 border-warning">
                <i class="bi bi-exclamation-triangle-fill me-2"></i><strong>Lưu ý:</strong> ${message}
            </div>
        </c:if>

        <c:if test="${hasShift == true}">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold m-0" style="color: #1e293b;">Quản lý Đặt phòng & Check-in / Check-out</h2>
            </div>
            
            <div class="card shadow-sm border-0 rounded-4 overflow-hidden mb-5">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th class="py-3 px-4">Mã Order</th>
                                <th class="py-3 px-4">Khách hàng</th>
                                <th class="py-3 px-4">Phòng</th>
                                <th class="py-3 px-4">Thanh toán</th>
                                <th class="py-3 px-4">Trạng thái</th>
                                <th class="py-3 px-4 text-center">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${orders}" var="o">
                                <tr>
                                    <td class="px-4 py-3"><strong class="text-secondary">#${o.id}</strong></td>
                                    <td class="px-4 py-3 fw-medium">${o.customerUsername}</td>
                                    <td class="px-4 py-3">Phòng ${o.roomId}</td>
                                    <td class="px-4 py-3 fw-bold text-success"><fmt:formatNumber value="${o.total}" pattern="#,###"/> đ</td>
                                    <td class="px-4 py-3">
                                        <c:choose>
                                            <c:when test="${o.status == 'Chờ Check-in'}"><span class="badge rounded-pill bg-warning text-dark px-3 py-2">Chờ Check-in</span></c:when>
                                            <c:when test="${o.status == 'Đang ở'}"><span class="badge rounded-pill bg-primary px-3 py-2">Đang ở</span></c:when>
                                            <c:when test="${o.status == 'Đã Check-out'}"><span class="badge rounded-pill bg-success px-3 py-2">Đã hoàn thành</span></c:when>
                                            <c:otherwise><span class="badge rounded-pill bg-secondary px-3 py-2">${o.status}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="px-4 py-3 text-center">
                                        <c:if test="${o.status == 'Chờ Check-in'}">
                                            <button class="btn btn-primary btn-sm rounded-pill px-3 shadow-sm" onclick="submitAction('checkin', ${o.id}, '${o.roomId}')">
                                                <i class="bi bi-box-arrow-in-right me-1"></i> Check-in
                                            </button>
                                        </c:if>
                                        <c:if test="${o.status == 'Đang ở'}">
                                            <button class="btn btn-danger btn-sm rounded-pill px-3 shadow-sm" onclick="submitAction('checkout', ${o.id}, '${o.roomId}')">
                                                <i class="bi bi-box-arrow-right me-1"></i> Check-out
                                            </button>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty orders}">
                                <tr><td colspan="6" class="text-center py-5 text-secondary">
                                    <i class="bi bi-inbox fs-1 d-block mb-2"></i> Chưa có dữ liệu đặt phòng.
                                </td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

            <h2 class="fw-bold mt-5 pt-4 mb-4" style="color: #1e293b;">Tổng quan Trạng thái Phòng</h2>
            <div class="row g-3">
                <c:forEach items="${rooms}" var="r">
                    <c:set var="colorClass" value="bg-success text-white"/>
                    <c:set var="iconClass" value="bi-check-circle"/>
                    <c:if test="${r.status == 'Occupied'}">
                        <c:set var="colorClass" value="bg-primary text-white"/>
                        <c:set var="iconClass" value="bi-door-closed"/>
                    </c:if>
                    <c:if test="${r.status == 'Needs Cleaning'}">
                        <c:set var="colorClass" value="bg-danger text-white"/>
                        <c:set var="iconClass" value="bi-stars"/>
                    </c:if>
                    <c:if test="${r.status == 'Reserved'}">
                        <c:set var="colorClass" value="bg-warning text-dark"/>
                        <c:set var="iconClass" value="bi-calendar-check"/>
                    </c:if>
                    
                    <div class="col-md-3 col-sm-6">
                        <div class="card h-100 border-0 shadow-sm rounded-4 text-center p-3">
                            <h4 class="fw-bold mb-2 text-dark">Phòng ${r.id}</h4>
                            <div><span class="badge rounded-pill ${colorClass} px-3 py-2 fs-6"><i class="bi ${iconClass} me-1"></i> ${r.status}</span></div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
    </div>

    <script>
        function submitAction(action, orderId, roomId) {
            let msg = action === 'checkin' ? 'Tiến hành Check-in cho khách hàng này?' : 'Khách hàng sẽ trả phòng và hệ thống sẽ tự động giao việc dọn phòng?';
            if(confirm(msg)) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/receptionist';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = action;
                form.appendChild(actionInput);
                
                const orderIdInput = document.createElement('input');
                orderIdInput.type = 'hidden';
                orderIdInput.name = 'orderId';
                orderIdInput.value = orderId;
                form.appendChild(orderIdInput);
                
                const roomIdInput = document.createElement('input');
                roomIdInput.type = 'hidden';
                roomIdInput.name = 'roomId';
                roomIdInput.value = roomId;
                form.appendChild(roomIdInput);
                
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
    <jsp:include page="../components/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
