<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User currentUser = (User) session.getAttribute("currentUser");
%>
<nav class="navbar glass-panel animate-slide-in" style="margin: 1rem; border-radius: var(--radius-lg);">
    <div class="nav-brand" style="background: linear-gradient(135deg, #3b82f6, #8b5cf6); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
        Hệ thống Quản lý Khách sạn
    </div>
    <div style="display: flex; gap: 1rem; align-items: center;">
        <a href="${pageContext.request.contextPath}/home" class="btn btn-primary" style="background: rgba(255,255,255,0.1); border: 1px solid var(--border); color: var(--text-main);">Trang chủ</a>
        <% if (currentUser != null) { %>
            <% if ("manager".equals(currentUser.getRole())) { %>
                <a href="${pageContext.request.contextPath}/admin/employees" class="btn btn-primary" style="background: rgba(255,255,255,0.1); border: 1px solid var(--border); color: var(--text-main);">QL Nhân Viên</a>
                <a href="${pageContext.request.contextPath}/admin/shifts" class="btn btn-primary" style="background: rgba(255,255,255,0.1); border: 1px solid var(--border); color: var(--text-main);">Phân Ca</a>
            <% } %>
            <div style="display: flex; align-items: center; gap: 1rem; margin-left: 1rem;">
                <span style="color: var(--text-main);">Xin chào, <strong><%= currentUser.getName() %></strong></span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger" style="padding: 0.5rem 1rem; text-decoration: none;">Đăng xuất</a>
            </div>
        <% } %>
    </div>
</nav>
