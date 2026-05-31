<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Housekeeper Dashboard</title>
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
        
        <c:if test="${not empty message}">
            <div class="alert alert-warning shadow-sm rounded-3 mb-4 border-warning">
                <i class="bi bi-exclamation-triangle-fill me-2"></i><strong>Lưu ý:</strong> ${message}
            </div>
        </c:if>

        <c:if test="${hasShift == true}">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold m-0" style="color: #1e293b;">Phòng Cần Dọn Dẹp (Tầng ${shiftFloor})</h2>
            </div>
            
            <div class="row g-4 mb-5">
                <c:choose>
                    <c:when test="${empty tasks}">
                        <div class="col-12">
                            <div class="card border-0 shadow-sm rounded-4 p-5 text-center bg-white">
                                <i class="bi bi-emoji-smile fs-1 text-success mb-3 d-block"></i>
                                <h4 class="text-secondary mb-0">Không có phòng nào cần dọn lúc này. Làm tốt lắm!</h4>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${tasks}" var="task">
                            <c:if test="${task.status != 'Completed'}">
                                <div class="col-md-4">
                                    <div class="card h-100 border-danger border-2 shadow-sm rounded-4">
                                        <div class="card-body p-4 d-flex flex-column">
                                            <div class="d-flex justify-content-between align-items-start mb-3">
                                                <h3 class="fw-bold text-danger m-0">Phòng ${task.roomId}</h3>
                                                <span class="badge bg-danger rounded-pill px-3 py-2">
                                                    <i class="bi bi-stars me-1"></i> Cần dọn dẹp
                                                </span>
                                            </div>
                                            <p class="text-muted small mb-4">
                                                <i class="bi bi-clock me-1"></i> Yêu cầu lúc: ${task.createdAt}
                                            </p>
                                            
                                            <form method="POST" action="${pageContext.request.contextPath}/housekeeper" class="mt-auto">
                                                <input type="hidden" name="action" value="clean">
                                                <input type="hidden" name="roomId" value="${task.roomId}">
                                                <input type="hidden" name="taskId" value="${task.id}">
                                                <button type="submit" class="btn btn-primary w-100 fw-bold py-2 shadow-sm rounded-3" 
                                                        onclick="return confirm('Xác nhận phòng này đã được dọn dẹp sạch sẽ và sẵn sàng đón khách?');"
                                                        style="background-color: #10b981; border: none;">
                                                    <i class="bi bi-check2-circle me-1"></i> Đã Dọn Xong (Sẵn sàng)
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>

            <h2 class="fw-bold mt-5 pt-4 mb-4" style="color: #1e293b;">Tổng Quan Trạng Thái Khách Sạn</h2>
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
                    
                    <div class="col-md-2 col-sm-4 col-6">
                        <div class="card h-100 border-0 shadow-sm rounded-3 text-center p-3 opacity-75">
                            <h5 class="fw-bold mb-2 text-dark">P. ${r.id}</h5>
                            <div><span class="badge rounded-pill ${colorClass} w-100 py-2"><i class="bi ${iconClass}"></i></span></div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
    </div>
    
    <jsp:include page="../components/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
