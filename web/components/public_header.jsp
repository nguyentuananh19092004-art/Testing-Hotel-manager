<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User currentUser = (User) session.getAttribute("currentUser");
%>
<nav class="public-navbar animate-fade-in">
    <div class="nav-brand" style="color: white; text-shadow: 0 2px 10px rgba(0,0,0,0.5);">À LA CARTE</div>
    <div style="display: flex; gap: 1rem; align-items: center;">
        <a href="${pageContext.request.contextPath}/home#rooms" style="color: white; text-decoration: none; font-weight: 500; transition: var(--transition);" onmouseover="this.style.color='var(--primary)'" onmouseout="this.style.color='white'">Phòng Nghỉ</a>
        <a href="#" style="color: white; text-decoration: none; font-weight: 500; transition: var(--transition);" onmouseover="this.style.color='var(--primary)'" onmouseout="this.style.color='white'">Dịch Vụ</a>
        <% if (currentUser != null) { %>
            <a href="${pageContext.request.contextPath}/<%= currentUser.getRole() %>" class="btn btn-primary" style="padding: 0.5rem 1rem;">Dashboard</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger" style="padding: 0.5rem 1rem;">Đăng xuất</a>
        <% } else { %>
            <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary" style="background: rgba(255,255,255,0.2); border: 1px solid white;">Đăng nhập</a>
            <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-primary">Đăng ký</a>
        <% } %>
    </div>
</nav>
