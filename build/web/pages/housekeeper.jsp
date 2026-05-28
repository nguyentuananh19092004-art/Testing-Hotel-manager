<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Housekeeper Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="../components/dashboard_header.jsp" />

    <div class="container animate-fade-in-up">
        <h2>Danh sách Phòng Cần Dọn</h2>
        <div class="grid grid-cols-3" id="cleaning-list">
            <!-- Sẽ được render qua JS -->
        </div>

        <h2 style="margin-top: 3rem;">Các Phòng Khác</h2>
        <div class="grid grid-cols-4" id="other-rooms">
            <!-- Sẽ được render qua JS -->
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/mockData.js"></script>
    <script>

        function renderRooms() {
            const rooms = DB.getRooms();
            const needsCleaning = rooms.filter(r => r.status === 'Needs Cleaning');
            const others = rooms.filter(r => r.status !== 'Needs Cleaning');
            
            const cleaningListEl = document.getElementById('cleaning-list');
            const otherRoomsEl = document.getElementById('other-rooms');

            if(needsCleaning.length === 0) {
                cleaningListEl.innerHTML = '<div class="card glass-panel" style="grid-column: span 3; text-align:center; padding: 3rem; color: var(--text-muted)">Không có phòng nào cần dọn lúc này. Tốt lắm!</div>';
            } else {
                cleaningListEl.innerHTML = needsCleaning.map(r => `
                    <div class="card glass-panel" style="display:flex; flex-direction:column; gap:1rem; border-color: var(--danger);">
                        <div style="display:flex; justify-content:space-between; align-items:center;">
                            <h3 style="margin:0; color:var(--danger)">Phòng \${r.id}</h3>
                            <span class="badge badge-danger">Cần dọn dẹp</span>
                        </div>
                        <p style="color:var(--text-muted); font-size:0.9rem;">Loại: \${r.type}</p>
                        <button class="btn btn-primary" onclick="markAsCleaned('\${r.id}')" style="margin-top:auto;">
                            Đã dọn xong (Sẵn sàng)
                        </button>
                    </div>
                `).join('');
            }

            otherRoomsEl.innerHTML = others.map(r => {
                let colorClass = 'badge-success';
                if(r.status === 'Occupied') colorClass = 'badge-primary';
                if(r.status === 'Reserved') colorClass = 'badge-warning';

                return `
                <div class="card glass-panel" style="text-align:center; padding: 1rem; opacity: 0.6;">
                    <h3 style="margin-bottom:0.5rem; color: var(--text-main)">P. \${r.id}</h3>
                    <span class="badge \${colorClass}">\${r.status}</span>
                </div>
                `;
            }).join('');
        }

        function markAsCleaned(roomId) {
            if(confirm(`Xác nhận đã dọn dẹp xong phòng \${roomId}?`)) {
                const rooms = DB.getRooms();
                const roomIndex = rooms.findIndex(r => r.id === roomId);

                rooms[roomIndex].status = 'Available';
                DB.setRooms(rooms);
                
                alert(`Đã cập nhật trạng thái phòng \${roomId} thành Trống/Sẵn sàng! Lễ tân đã có thể đón khách mới.`);
                renderRooms();
            }
        }

        // Init
        renderRooms();
    </script>
    <jsp:include page="../components/footer.jsp" />
</body>
</html>
