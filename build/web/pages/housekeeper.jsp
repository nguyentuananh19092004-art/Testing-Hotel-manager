<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Housekeeper Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="../components/dashboard_header.jsp" />

    <div class="container animate-fade-in-up">
        <h2>Danh sách Phòng Cần Dọn</h2>
        <div class="grid grid-cols-3" id="cleaning-list">
            <c:choose>
                <c:when test="${empty tasks}">
                    <div class="card glass-panel" style="grid-column: span 3; text-align:center; padding: 3rem; color: var(--text-muted)">Không có phòng nào cần dọn lúc này. Tốt lắm!</div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${tasks}" var="task">
                        <c:if test="${task.status != 'Completed'}">
                            <div class="card glass-panel" style="display:flex; flex-direction:column; gap:1rem; border-color: var(--danger);">
                                <div style="display:flex; justify-content:space-between; align-items:center;">
                                    <h3 style="margin:0; color:var(--danger)">Phòng ${task.roomId}</h3>
                                    <span class="badge badge-danger">Cần dọn dẹp</span>
                                </div>
                                <p style="color:var(--text-muted); font-size:0.9rem;">Tạo lúc: ${task.createdAt}</p>
                                <form method="POST" action="${pageContext.request.contextPath}/housekeeper" style="margin-top:auto;">
                                    <input type="hidden" name="action" value="clean">
                                    <input type="hidden" name="roomId" value="${task.roomId}">
                                    <input type="hidden" name="taskId" value="${task.id}">
                                    <button type="submit" class="btn btn-primary" style="width: 100%" onclick="return confirm('Xác nhận đã dọn dẹp xong?');">
                                        Đã dọn xong (Sẵn sàng)
                                    </button>
                                </form>
                            </div>
                        </c:if>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

        <h2 style="margin-top: 3rem;">Tổng Quan Các Phòng</h2>
        <div class="grid grid-cols-4" id="other-rooms">
            <c:forEach items="${rooms}" var="r">
                <c:set var="colorClass" value="badge-success" />
                <c:if test="${r.status == 'Occupied'}"><c:set var="colorClass" value="badge-primary" /></c:if>
                <c:if test="${r.status == 'Needs Cleaning'}"><c:set var="colorClass" value="badge-danger" /></c:if>
                <c:if test="${r.status == 'Reserved'}"><c:set var="colorClass" value="badge-warning" /></c:if>
                
                <div class="card glass-panel" style="text-align:center; padding: 1rem; opacity: 0.8;">
                    <h3 style="margin-bottom:0.5rem; color: var(--text-main)">P. ${r.id}</h3>
                    <span class="badge ${colorClass}">${r.status}</span>
                </div>
            </c:forEach>
        </div>
    </div>
    <jsp:include page="../components/footer.jsp" />
</body>
</html>
