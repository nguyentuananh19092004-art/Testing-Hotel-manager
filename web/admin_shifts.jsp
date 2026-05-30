<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Phân Ca Làm Việc</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="components/dashboard_header.jsp" />

    <div class="container animate-fade-in-up">
        <h2>Quản Lý Phân Ca</h2>
        
        <div class="card glass-panel" style="margin-bottom: 2rem;">
            <h3>Thêm Ca Trực Cho Nhân Viên Dọn Phòng</h3>
            <form action="${pageContext.request.contextPath}/admin/shifts" method="POST" style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                <input type="hidden" name="action" value="add">
                
                <div>
                    <label>Nhân viên:</label>
                    <select name="username" class="form-control" required>
                        <c:forEach items="${employees}" var="emp">
                            <c:if test="${emp.role == 'housekeeper'}">
                                <option value="${emp.username}">${emp.name} (${emp.username})</option>
                            </c:if>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <label>Ca làm:</label>
                    <select name="shift_id" class="form-control" required>
                        <c:forEach items="${shifts}" var="shift">
                            <option value="${shift.id}">${shift.name} (${shift.startTime} - ${shift.endTime})</option>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <label>Tầng (Floor):</label>
                    <input type="number" name="floor" class="form-control" min="1" max="6" required>
                </div>
                <div>
                    <label>Ngày (Date):</label>
                    <input type="date" name="assign_date" class="form-control" required>
                </div>
                <div style="grid-column: span 2;">
                    <button type="submit" class="btn btn-primary">Phân Ca</button>
                </div>
            </form>
        </div>

        <div class="card glass-panel">
            <h3>Danh Sách Phân Ca</h3>
            <table class="table">
                <thead>
                    <tr>
                        <th>Nhân viên</th>
                        <th>Ca làm</th>
                        <th>Tầng</th>
                        <th>Ngày</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${assignments}" var="sa">
                        <tr>
                            <td><strong>${sa.user.name}</strong> (${sa.username})</td>
                            <td>${sa.shift.name} (${sa.shift.startTime} - ${sa.shift.endTime})</td>
                            <td>Tầng ${sa.floor}</td>
                            <td>${sa.assignDate}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/shifts?action=delete&id=${sa.id}" class="btn badge-danger" onclick="return confirm('Xóa phân ca này?');" style="padding: 0.3rem 0.6rem; text-decoration: none;">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>
