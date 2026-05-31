<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Nhân Viên</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body { background-color: #f8fafc; }
    </style>
</head>
<body>
    <jsp:include page="components/dashboard_header.jsp" />

    <div class="container my-5 py-3 animate-fade-in-up">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold m-0" style="color: #1e293b;">Quản Lý Nhân Viên</h2>
            <a href="${pageContext.request.contextPath}/manager" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left"></i> Quay lại Dashboard
            </a>
        </div>
        
        <div class="row">
            <div class="col-lg-4 mb-4 mb-lg-0">
                <div class="card shadow-sm border-0 rounded-4">
                    <div class="card-header bg-white border-bottom-0 pt-4 pb-0 px-4">
                        <h4 class="fw-bold m-0 text-primary">Thêm Nhân Viên Mới</h4>
                    </div>
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/admin/employees" method="POST">
                            <input type="hidden" name="action" value="add">
                            
                            <div class="mb-3">
                                <label class="form-label fw-medium text-secondary">Tên đăng nhập</label>
                                <input type="text" name="username" class="form-control bg-light" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-medium text-secondary">Mật khẩu</label>
                                <input type="password" name="password" class="form-control bg-light" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-medium text-secondary">Họ và Tên</label>
                                <input type="text" name="name" class="form-control bg-light" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-medium text-secondary">Chức vụ (Role)</label>
                                <select name="role" class="form-select bg-light" required>
                                    <option value="receptionist">Lễ tân (Receptionist)</option>
                                    <option value="housekeeper">Dọn phòng (Housekeeper)</option>
                                    <option value="manager">Quản lý (Manager)</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-medium text-secondary">Số điện thoại</label>
                                <input type="text" name="phone" class="form-control bg-light">
                            </div>
                            <div class="mb-4">
                                <label class="form-label fw-medium text-secondary">Email</label>
                                <input type="email" name="gmail" class="form-control bg-light">
                            </div>
                            <button type="submit" class="btn btn-primary w-100 fw-bold py-2 shadow-sm rounded-3">
                                <i class="bi bi-person-plus me-1"></i> Thêm Nhân Viên
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-lg-8">
                <div class="card shadow-sm border-0 rounded-4 overflow-hidden h-100">
                    <div class="card-header bg-white border-bottom-0 pt-4 pb-3 px-4">
                        <h4 class="fw-bold m-0 text-dark">Danh Sách Nhân Sự</h4>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th class="py-3 px-4">Tên đăng nhập</th>
                                    <th class="py-3 px-4">Họ tên</th>
                                    <th class="py-3 px-4">Chức vụ</th>
                                    <th class="py-3 px-4">Liên hệ</th>
                                    <th class="py-3 px-4 text-center">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${employees}" var="emp">
                                    <tr>
                                        <td class="px-4 py-3"><span class="text-secondary">@${emp.username}</span></td>
                                        <td class="px-4 py-3"><strong>${emp.name}</strong></td>
                                        <td class="px-4 py-3">
                                            <c:choose>
                                                <c:when test="${emp.role == 'manager'}"><span class="badge rounded-pill bg-warning text-dark px-3">MANAGER</span></c:when>
                                                <c:when test="${emp.role == 'housekeeper'}"><span class="badge rounded-pill bg-danger px-3">HOUSEKEEPER</span></c:when>
                                                <c:when test="${emp.role == 'receptionist'}"><span class="badge rounded-pill bg-success px-3">RECEPTIONIST</span></c:when>
                                                <c:otherwise><span class="badge rounded-pill bg-primary px-3">${emp.role.toUpperCase()}</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-4 py-3 small text-muted">
                                            <div class="mb-1"><i class="bi bi-telephone text-secondary me-1"></i> ${emp.phone}</div>
                                            <div><i class="bi bi-envelope text-secondary me-1"></i> ${emp.gmail}</div>
                                        </td>
                                        <td class="px-4 py-3 text-center">
                                            <a href="${pageContext.request.contextPath}/admin/employees?action=delete&username=${emp.username}" 
                                               class="btn btn-outline-danger btn-sm" 
                                               onclick="return confirm('Bạn có chắc muốn xóa tài khoản này? Mọi dữ liệu liên quan có thể bị ảnh hưởng.');">
                                                <i class="bi bi-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty employees}">
                                    <tr><td colspan="5" class="text-center py-5 text-secondary">Không có nhân viên nào.</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="components/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
