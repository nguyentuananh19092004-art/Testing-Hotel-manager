<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User currentUser = (User) session.getAttribute("currentUser");
%>
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm mb-4 position-relative" style="z-index: 1000;">
    <div class="container-fluid px-4 py-2">
        <a class="navbar-brand fw-bold fs-5" href="#" style="background: linear-gradient(135deg, #6b46c1, #8b5cf6); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
            Hệ thống Quản lý Khách sạn
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#dashboardNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="dashboardNav">
            <div class="d-flex gap-3 align-items-center">
                <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary px-4 rounded-pill">Trang chủ</a>
                <% if (currentUser != null) { %>
                    <% if ("manager".equals(currentUser.getRole())) { %>
                        <a href="${pageContext.request.contextPath}/admin/employees" class="btn btn-outline-primary px-3 rounded-pill">QL Nhân Viên</a>
                        <a href="${pageContext.request.contextPath}/admin/shifts" class="btn btn-outline-primary px-3 rounded-pill">Phân Ca</a>
                    <% } %>
                    <div class="d-flex align-items-center ms-3">
                        <span class="text-secondary fw-medium me-3">Xin chào, <strong style="color: #6b46c1;"><%= currentUser.getName() %></strong></span>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger px-4 rounded-pill shadow-sm" style="background-color: #ef4444; border: none;">Đăng xuất</a>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
</nav>
