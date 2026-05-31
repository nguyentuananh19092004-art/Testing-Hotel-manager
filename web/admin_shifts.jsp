<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Phân Ca Làm Việc</title>
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
            <h2 class="fw-bold m-0" style="color: #1e293b;">Quản Lý Phân Ca</h2>
            <a href="${pageContext.request.contextPath}/manager" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left"></i> Quay lại Dashboard
            </a>
        </div>
        
        <div class="row">
            <div class="col-lg-4 mb-4 mb-lg-0">
                <div class="card shadow-sm border-0 rounded-4">
                    <div class="card-header bg-white border-bottom-0 pt-4 pb-0 px-4">
                        <h4 class="fw-bold m-0 text-primary">Thêm Ca Trực</h4>
                    </div>
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/admin/shifts" method="POST">
                            <input type="hidden" name="action" value="add">
                            
                            <div class="mb-3">
                                <label class="form-label fw-medium text-secondary">Nhân viên</label>
                                <select name="username" id="employeeSelect" class="form-select bg-light" required onchange="handleEmployeeChange()">
                                    <option value="" disabled selected>-- Chọn Nhân viên --</option>
                                    <c:forEach items="${employees}" var="emp">
                                        <c:if test="${emp.role == 'housekeeper' || emp.role == 'receptionist'}">
                                            <option value="${emp.username}" data-role="${emp.role}">${emp.name} (${emp.role.toUpperCase()})</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-medium text-secondary">Ca làm</label>
                                <select name="shift_id" class="form-select bg-light" required>
                                    <c:forEach items="${shifts}" var="shift">
                                        <option value="${shift.id}">${shift.name} (${shift.startTime} - ${shift.endTime})</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="mb-3" id="floorContainer">
                                <label class="form-label fw-medium text-secondary">Tầng phụ trách (Floor)</label>
                                <input type="number" name="floor" id="floorInput" class="form-control bg-light" min="1" max="6" value="1" required>
                                <div class="form-text">Lễ tân sẽ tự động được gán vào tầng 1.</div>
                            </div>
                            <div class="mb-4">
                                <label class="form-label fw-medium text-secondary">Ngày phân công</label>
                                <input type="date" name="assign_date" class="form-control bg-light" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 fw-bold py-2 shadow-sm rounded-3">
                                <i class="bi bi-calendar-plus me-1"></i> Phân Ca Mới
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-lg-8">
                <div class="card shadow-sm border-0 rounded-4 overflow-hidden h-100">
                    <div class="card-header bg-white border-bottom-0 pt-4 pb-3 px-4">
                        <h4 class="fw-bold m-0 text-dark">Lịch Phân Ca Sắp Tới</h4>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th class="py-3 px-4">Nhân viên</th>
                                    <th class="py-3 px-4">Ca làm</th>
                                    <th class="py-3 px-4">Tầng</th>
                                    <th class="py-3 px-4">Thời gian</th>
                                    <th class="py-3 px-4 text-center">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${assignments}" var="sa">
                                    <tr>
                                        <td class="px-4 py-3">
                                            <div class="fw-bold">${sa.user.name}</div>
                                            <div class="small text-muted">@${sa.username}</div>
                                        </td>
                                        <td class="px-4 py-3">
                                            <div class="fw-medium text-primary">${sa.shift.name}</div>
                                        </td>
                                        <td class="px-4 py-3"><span class="badge bg-secondary">Tầng ${sa.floor}</span></td>
                                        <td class="px-4 py-3">
                                            <div class="small">Bắt đầu: <span class="fw-medium">${sa.assignDate} ${sa.shift.startTime}</span></div>
                                            <div class="small">Kết thúc: <span class="fw-medium">${sa.endAssignDate} ${sa.shift.endTime}</span></div>
                                        </td>
                                        <td class="px-4 py-3 text-center">
                                            <a href="${pageContext.request.contextPath}/admin/shifts?action=delete&id=${sa.id}" 
                                               class="btn btn-outline-danger btn-sm" 
                                               onclick="return confirm('Bạn có chắc muốn xóa lịch phân ca này?');">
                                                <i class="bi bi-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty assignments}">
                                    <tr><td colspan="5" class="text-center py-5 text-secondary">Chưa có lịch phân ca nào được tạo.</td></tr>
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
    <script>
        function handleEmployeeChange() {
            var select = document.getElementById('employeeSelect');
            var floorContainer = document.getElementById('floorContainer');
            var floorInput = document.getElementById('floorInput');
            
            // Get the selected option element
            var selectedOption = select.options[select.selectedIndex];
            // Get the role from the data attribute
            var role = selectedOption.getAttribute('data-role');
            
            if (role === 'receptionist') {
                floorContainer.style.display = 'none';
                floorInput.value = '1';
            } else {
                floorContainer.style.display = 'block';
            }
        }
    </script>
</body>
</html>
