<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User currentUser = (User) session.getAttribute("currentUser");
%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark py-3 shadow-sm animate-fade-in">
    <div class="container-fluid px-5">
        <a class="navbar-brand fw-bold fs-4" href="${pageContext.request.contextPath}/home" style="color: #6b46c1; letter-spacing: 1px; text-shadow: 0 2px 4px rgba(0,0,0,0.3);">À LA CARTE</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#publicNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="publicNav">
            <ul class="navbar-nav align-items-center me-4">
                <li class="nav-item"><a class="nav-link text-white fw-medium px-3" href="${pageContext.request.contextPath}/home#rooms">Phòng Nghỉ</a></li>
                <li class="nav-item"><a class="nav-link text-white fw-medium px-3" href="#">Dịch Vụ</a></li>
            </ul>
            <div class="d-flex gap-3 align-items-center">
                <% if (currentUser != null) { %>
                    <a href="${pageContext.request.contextPath}/<%= currentUser.getRole() %>" class="btn btn-outline-light px-4">Dashboard</a>
                    <a href="${pageContext.request.contextPath}/logout" class="btn px-4" style="background-color: #6b46c1; color: white;">Đăng xuất</a>
                <% } else { %>
                    <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline-light px-4">Đăng nhập</a>
                    <a href="${pageContext.request.contextPath}/register.jsp" class="btn px-4" style="background-color: #6b46c1; color: white;">Đăng ký</a>
                <% } %>
            </div>
        </div>
    </div>
</nav>
