<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manager Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .stat-card {
            padding: 2rem;
            text-align: center;
        }
        .stat-number {
            font-size: 3rem;
            font-weight: 700;
            margin: 1rem 0;
            background: linear-gradient(135deg, var(--warning), #fbbf24);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
    </style>
</head>
<body>
    <jsp:include page="../components/dashboard_header.jsp" />

    <div class="container animate-fade-in-up">
        <h2>Báo Cáo Hoạt Động (Hôm nay)</h2>
        <div class="grid grid-cols-3" style="margin-bottom: 3rem;">
            <div class="card glass-panel stat-card">
                <h3 style="color: var(--text-muted); font-size: 1.1rem;">Tổng Doanh Thu</h3>
                <div class="stat-number" id="total-revenue">0đ</div>
                <p style="color: #10b981; font-size: 0.9rem;">+12% so với hôm qua</p>
            </div>
            
            <div class="card glass-panel stat-card">
                <h3 style="color: var(--text-muted); font-size: 1.1rem;">Công Suất Phòng</h3>
                <div class="stat-number" id="occupancy-rate">0%</div>
                <p style="color: var(--text-muted); font-size: 0.9rem;" id="occupancy-text">0/0 phòng đang sử dụng</p>
            </div>

            <div class="card glass-panel stat-card">
                <h3 style="color: var(--text-muted); font-size: 1.1rem;">Phòng Cần Dọn</h3>
                <div class="stat-number" id="cleaning-count" style="background: linear-gradient(135deg, #ef4444, #f87171); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">0</div>
                <p style="color: var(--text-muted); font-size: 0.9rem;">Đang chờ xử lý</p>
            </div>
        </div>

        <h2>Danh Sách Nhân Sự & Tài Khoản</h2>
        <div class="card glass-panel">
            <table class="table">
                <thead>
                    <tr>
                        <th>Họ tên</th>
                        <th>Tên đăng nhập</th>
                        <th>Chức vụ (Role)</th>
                        <th>Trạng thái</th>
                    </tr>
                </thead>
                <tbody id="user-list">
                    <!-- Sẽ được render bằng JS -->
                </tbody>
            </table>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/mockData.js"></script>
    <script>

        function renderStats() {
            const orders = DB.getOrders();
            const rooms = DB.getRooms();

            // 1. Tính doanh thu từ các order đã thanh toán (Đã Check-out)
            const completedOrders = orders.filter(o => o.status === 'Đã Check-out');
            const totalRevenue = completedOrders.reduce((sum, o) => sum + o.total, 0);
            document.getElementById('total-revenue').innerText = totalRevenue.toLocaleString('vi-VN') + ' đ';

            // 2. Tính công suất phòng (Phòng đang Occupied hoặc Reserved)
            const totalRooms = rooms.length;
            const activeRooms = rooms.filter(r => r.status === 'Occupied' || r.status === 'Reserved').length;
            const occupancyRate = (totalRooms > 0) ? Math.round((activeRooms / totalRooms) * 100) : 0;
            document.getElementById('occupancy-rate').innerText = occupancyRate + '%';
            document.getElementById('occupancy-text').innerText = `\${activeRooms}/\${totalRooms} phòng đang sử dụng/đặt`;

            // 3. Phòng cần dọn
            const cleaningRooms = rooms.filter(r => r.status === 'Needs Cleaning').length;
            document.getElementById('cleaning-count').innerText = cleaningRooms;
        }

        function renderUsers() {
            const users = DB.getUsers();
            const userListEl = document.getElementById('user-list');

            userListEl.innerHTML = users.map(u => {
                let roleColor = 'badge-primary';
                if(u.role === 'manager') roleColor = 'badge-warning';
                if(u.role === 'housekeeper') roleColor = 'badge-danger';
                if(u.role === 'receptionist') roleColor = 'badge-success';

                return `
                <tr>
                    <td><strong>\${u.name}</strong></td>
                    <td>\${u.username}</td>
                    <td><span class="badge \${roleColor}">\${u.role.toUpperCase()}</span></td>
                    <td><span style="color: #10b981;">● Đang hoạt động</span></td>
                </tr>
                `;
            }).join('');
        }

        // Init
        renderStats();
        renderUsers();
    </script>
    <jsp:include page="../components/footer.jsp" />
</body>
</html>
