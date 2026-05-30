<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Nhân Viên</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="components/dashboard_header.jsp" />

    <div class="container animate-fade-in-up">
        <h2>Quản Lý Nhân Viên</h2>
        
        <div class="card glass-panel" style="margin-bottom: 2rem;">
            <h3>Thêm Nhân Viên Mới</h3>
            <form action="${pageContext.request.contextPath}/admin/employees" method="POST" style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                <input type="hidden" name="action" value="add">
                
                <div>
                    <label>Tên đăng nhập:</label>
                    <input type="text" name="username" class="form-control" required>
                </div>
                <div>
                    <label>Mật khẩu:</label>
                    <input type="password" name="password" class="form-control" required>
                </div>
                <div>
                    <label>Họ và Tên:</label>
                    <input type="text" name="name" class="form-control" required>
                </div>
                <div>
                    <label>Chức vụ (Role):</label>
                    <select name="role" class="form-control" required>
                        <option value="receptionist">Lễ tân (Receptionist)</option>
                        <option value="housekeeper">Dọn phòng (Housekeeper)</option>
                        <option value="manager">Quản lý (Manager)</option>
                    </select>
                </div>
                <div>
                    <label>Số điện thoại:</label>
                    <input type="text" name="phone" class="form-control">
                </div>
                <div>
                    <label>Email (Gmail):</label>
                    <input type="email" name="gmail" class="form-control">
                </div>
                <div style="grid-column: span 2;">
                    <button type="submit" class="btn btn-primary">Thêm Nhân Viên</button>
                </div>
            </form>
        </div>

        <div class="card glass-panel">
            <h3>Danh Sách Nhân Viên</h3>
            <table class="table">
                <thead>
                    <tr>
                        <th>Tên đăng nhập</th>
                        <th>Họ tên</th>
                        <th>Chức vụ</th>
                        <th>SĐT</th>
                        <th>Email</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${employees}" var="emp">
                        <tr>
                            <td>${emp.username}</td>
                            <td><strong>${emp.name}</strong></td>
                            <td>
                                <c:choose>
                                    <c:when test="${emp.role == 'manager'}"><span class="badge badge-warning">MANAGER</span></c:when>
                                    <c:when test="${emp.role == 'housekeeper'}"><span class="badge badge-danger">HOUSEKEEPER</span></c:when>
                                    <c:when test="${emp.role == 'receptionist'}"><span class="badge badge-success">RECEPTIONIST</span></c:when>
                                    <c:otherwise><span class="badge badge-primary">${emp.role.toUpperCase()}</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>${emp.phone}</td>
                            <td>${emp.gmail}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/employees?action=delete&username=${emp.username}" class="btn badge-danger" onclick="return confirm('Bạn có chắc muốn xóa tài khoản này?');" style="padding: 0.3rem 0.6rem; text-decoration: none;">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>
