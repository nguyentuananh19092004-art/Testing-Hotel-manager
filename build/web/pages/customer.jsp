<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="../components/dashboard_header.jsp" />

    <div class="container animate-fade-in-up">
        <h2>Phòng trống hôm nay</h2>
        <div class="grid grid-cols-3" id="room-list">
            <!-- Danh sách phòng sẽ được render bằng JS -->
        </div>

        <h2 style="margin-top: 3rem;">Lịch sử Đặt phòng của bạn</h2>
        <div class="card glass-panel">
            <table class="table">
                <thead>
                    <tr>
                        <th>Mã Đặt Phòng</th>
                        <th>Phòng</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                    </tr>
                </thead>
                <tbody id="order-list">
                    <!-- Danh sách booking -->
                </tbody>
            </table>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/mockData.js"></script>
    <script>
        // Data is passed from Server if we implement it, but for now mockData is used for rendering.
        // Wait, currentUser is needed for bookRoom function logic in mockData context.
        const currentUser = { username: '${sessionScope.currentUser.username}' };

        function renderRooms() {
            const rooms = DB.getRooms();
            const availableRooms = rooms.filter(r => r.status === 'Available');
            const roomListEl = document.getElementById('room-list');
            
            roomListEl.innerHTML = availableRooms.map(r => {
                let imgPath = "${pageContext.request.contextPath}/img/room_standard.png";
                if(r.type.includes("Deluxe")) imgPath = "${pageContext.request.contextPath}/img/room_deluxe.png";
                if(r.type.includes("Suite")) imgPath = "${pageContext.request.contextPath}/img/room_suite.png";
                
                return `
                <div class="card glass-panel animate-fade-in-up animate-delay-2" style="display:flex; flex-direction:column; padding-bottom: 1.5rem;">
                    <img src="\${imgPath}" alt="Room Image" class="room-img">
                    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom: 1rem; margin-top: 1rem;">
                        <h3 style="margin:0; color:var(--primary)">Phòng \${r.id}</h3>
                        <span class="badge badge-primary">\${r.type}</span>
                    </div>
                    <p style="color:var(--text-muted); font-size:0.95rem; margin-bottom: 1.5rem; min-height: 40px;">\${r.features}</p>
                    <div style="font-size: 1.5rem; font-weight: 700; color: #10b981; margin-bottom: 1.5rem;">
                        \${r.price.toLocaleString('vi-VN')} đ <span style="font-size: 0.9rem; color: var(--text-muted); font-weight: 400;">/ đêm</span>
                    </div>
                    <button class="btn btn-primary" onclick="bookRoom('\${r.id}')" style="margin-top:auto; width:100%;">
                        Đặt phòng ngay
                    </button>
                </div>
                `;
            }).join('');
        }

        function renderOrders() {
            const orders = DB.getOrders();
            const myOrders = orders.filter(o => o.customerId === currentUser.username);
            const orderListEl = document.getElementById('order-list');
            
            if(myOrders.length === 0) {
                orderListEl.innerHTML = '<tr><td colspan="4" style="text-align:center;">Chưa có lịch sử đặt phòng</td></tr>';
                return;
            }

            orderListEl.innerHTML = myOrders.map(o => `
                <tr>
                    <td><strong>#\${o.id}</strong></td>
                    <td>Phòng \${o.roomId}</td>
                    <td>\${o.total.toLocaleString('vi-VN')} đ</td>
                    <td><span class="badge badge-warning">\${o.status}</span></td>
                </tr>
            `).join('');
        }

        function bookRoom(roomId) {
            if(confirm(`Bạn có chắc chắn muốn đặt phòng \${roomId}?`)) {
                const rooms = DB.getRooms();
                const roomIndex = rooms.findIndex(r => r.id === roomId);
                
                // Cập nhật trạng thái phòng (Tuy nhiên quy trình thực tế thường lễ tân mới duyệt, ở đây tạm khóa)
                rooms[roomIndex].status = 'Reserved';
                DB.setRooms(rooms);

                // Tạo order
                const orders = DB.getOrders();
                const newOrder = {
                    id: Math.floor(Math.random() * 10000),
                    roomId: roomId,
                    customerId: currentUser.username,
                    total: rooms[roomIndex].price,
                    status: 'Chờ Check-in' // Lễ tân sẽ thao tác Check-in
                };
                orders.push(newOrder);
                DB.setOrders(orders);

                alert(`Đặt phòng \${roomId} thành công! Lễ tân sẽ liên hệ bạn.`);
                
                // Render lại trang
                renderRooms();
                renderOrders();
            }
        }

        // Khởi tạo
        renderRooms();
        renderOrders();
    </script>
    <jsp:include page="../components/footer.jsp" />
</body>
</html>
