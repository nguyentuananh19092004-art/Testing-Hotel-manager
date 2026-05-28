<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Receptionist Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="../components/dashboard_header.jsp" />

    <div class="container animate-fade-in-up">
        <h2>Quản lý Đặt phòng & Check-in / Check-out</h2>
        <div class="card glass-panel" style="overflow-x: auto;">
            <table class="table">
                <thead>
                    <tr>
                        <th>Mã Order</th>
                        <th>Khách hàng</th>
                        <th>Phòng</th>
                        <th>Thanh toán</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody id="order-list">
                    <!-- Sẽ được render qua JS -->
                </tbody>
            </table>
        </div>

        <h2 style="margin-top: 3rem;">Tổng quan Phòng</h2>
        <div class="grid grid-cols-4" id="room-overview">
            <!-- Render danh sách phòng -->
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/mockData.js"></script>
    <script>

        function getStatusBadge(status) {
            if (status === 'Chờ Check-in') return '<span class="badge badge-warning">Chờ Check-in</span>';
            if (status === 'Đang ở') return '<span class="badge badge-primary">Đang ở</span>';
            if (status === 'Đã Check-out') return '<span class="badge badge-success">Đã hoàn thành</span>';
            return `<span class="badge">${status}</span>`;
        }

        function renderOrders() {
            const orders = DB.getOrders();
            const orderListEl = document.getElementById('order-list');
            
            if (orders.length === 0) {
                orderListEl.innerHTML = '<tr><td colspan="6" style="text-align:center;">Chưa có order nào</td></tr>';
                return;
            }

            orderListEl.innerHTML = orders.map(o => `
                <tr>
                    <td><strong>#\${o.id}</strong></td>
                    <td>\${o.customerId}</td>
                    <td>Phòng \${o.roomId}</td>
                    <td>\${o.total.toLocaleString('vi-VN')} đ</td>
                    <td>\${getStatusBadge(o.status)}</td>
                    <td>
                        \${o.status === 'Chờ Check-in' ? `<button class="btn btn-primary" onclick="checkIn(\${o.id})" style="padding: 0.25rem 0.75rem; font-size:0.8rem;">Check-in</button>` : ''}
                        \${o.status === 'Đang ở' ? `<button class="btn btn-danger" onclick="checkOut(\${o.id})" style="padding: 0.25rem 0.75rem; font-size:0.8rem;">Check-out</button>` : ''}
                    </td>
                </tr>
            `).join('');
        }

        function renderRooms() {
            const rooms = DB.getRooms();
            const roomOverviewEl = document.getElementById('room-overview');
            
            roomOverviewEl.innerHTML = rooms.map(r => {
                let colorClass = 'badge-success'; // Available
                if(r.status === 'Occupied') colorClass = 'badge-primary';
                if(r.status === 'Needs Cleaning') colorClass = 'badge-danger';
                if(r.status === 'Reserved') colorClass = 'badge-warning';

                return `
                <div class="card glass-panel" style="text-align:center; padding: 1rem;">
                    <h3 style="margin-bottom:0.5rem; color: var(--text-main)">P. \${r.id}</h3>
                    <span class="badge \${colorClass}">\${r.status}</span>
                </div>
                `;
            }).join('');
        }

        function checkIn(orderId) {
            const orders = DB.getOrders();
            const orderIndex = orders.findIndex(o => o.id === orderId);
            const roomId = orders[orderIndex].roomId;

            const rooms = DB.getRooms();
            const roomIndex = rooms.findIndex(r => r.id === roomId);

            // Cập nhật trạng thái
            orders[orderIndex].status = 'Đang ở';
            rooms[roomIndex].status = 'Occupied';

            DB.setOrders(orders);
            DB.setRooms(rooms);
            
            alert(`Check-in phòng ${roomId} thành công. Khách đã nhận phòng!`);
            renderOrders();
            renderRooms();
        }

        function checkOut(orderId) {
            if(confirm('Khách sẽ trả phòng và xuất hóa đơn?')) {
                const orders = DB.getOrders();
                const orderIndex = orders.findIndex(o => o.id === orderId);
                const roomId = orders[orderIndex].roomId;
                const total = orders[orderIndex].total;

                const rooms = DB.getRooms();
                const roomIndex = rooms.findIndex(r => r.id === roomId);

                // Cập nhật trạng thái
                orders[orderIndex].status = 'Đã Check-out';
                // Đổi trạng thái phòng thành Cần dọn dẹp
                rooms[roomIndex].status = 'Needs Cleaning';

                DB.setOrders(orders);
                DB.setRooms(rooms);
                
                alert(`Check-out thành công. Đã xuất hóa đơn ${total.toLocaleString('vi-VN')} đ. Báo dọn phòng!`);
                renderOrders();
                renderRooms();
            }
        }

        // Init
        renderOrders();
        renderRooms();
    </script>
    <jsp:include page="../components/footer.jsp" />
</body>
</html>
