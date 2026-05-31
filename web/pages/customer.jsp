<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body { background-color: #f8fafc; }
    </style>
</head>
<body>
    <jsp:include page="../components/dashboard_header.jsp" />

    <div class="container my-5 py-3 animate-fade-in-up">
        <h2 class="fw-bold mb-4" style="color: #1e293b;">Khám phá các hạng phòng</h2>
        <div class="row g-4">
            <!-- Standard Room -->
            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm room-card-hover rounded-4 overflow-hidden">
                    <img src="https://images.unsplash.com/photo-1631049307264-da0ec9d70304?q=80&w=600" class="card-img-top" alt="Standard" style="height: 220px; object-fit: cover;">
                    <div class="card-body p-4 d-flex flex-column text-center">
                        <h4 class="fw-bold mb-3" style="color: #6b46c1;">Standard</h4>
                        <p class="text-secondary small mb-4 flex-grow-1">Phòng tiêu chuẩn ấm cúng, thiết kế hiện đại, đầy đủ tiện nghi cơ bản mang lại cho bạn kỳ nghỉ thoải mái và trọn vẹn.</p>
                        <button class="btn btn-primary w-100 fw-bold py-2 shadow-sm rounded-3 mt-auto" onclick="openBookModal(1, 'Standard')" style="background-color: #6b46c1; border: none;">
                            Kiểm tra phòng trống
                        </button>
                    </div>
                </div>
            </div>
            <!-- Deluxe Room -->
            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm room-card-hover rounded-4 overflow-hidden">
                    <img src="https://images.unsplash.com/photo-1590490360182-c33d57733427?q=80&w=600" class="card-img-top" alt="Deluxe" style="height: 220px; object-fit: cover;">
                    <div class="card-body p-4 d-flex flex-column text-center">
                        <h4 class="fw-bold mb-3" style="color: #6b46c1;">Deluxe</h4>
                        <p class="text-secondary small mb-4 flex-grow-1">Không gian rộng rãi với tầm nhìn hướng biển tuyệt đẹp, ban công riêng và nội thất cao cấp dành cho trải nghiệm đáng nhớ.</p>
                        <button class="btn btn-primary w-100 fw-bold py-2 shadow-sm rounded-3 mt-auto" onclick="openBookModal(2, 'Deluxe')" style="background-color: #6b46c1; border: none;">
                            Kiểm tra phòng trống
                        </button>
                    </div>
                </div>
            </div>
            <!-- Suite Room -->
            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm room-card-hover rounded-4 overflow-hidden">
                    <img src="https://images.unsplash.com/photo-1618773928121-c32242e63f39?q=80&w=600" class="card-img-top" alt="Suite" style="height: 220px; object-fit: cover;">
                    <div class="card-body p-4 d-flex flex-column text-center">
                        <h4 class="fw-bold mb-3" style="color: #6b46c1;">Suite</h4>
                        <p class="text-secondary small mb-4 flex-grow-1">Đỉnh cao của sự sang trọng. Diện tích lớn với phòng khách riêng, bồn tắm jacuzzi và dịch vụ đẳng cấp 5 sao 24/7.</p>
                        <button class="btn btn-primary w-100 fw-bold py-2 shadow-sm rounded-3 mt-auto" onclick="openBookModal(3, 'Suite')" style="background-color: #6b46c1; border: none;">
                            Kiểm tra phòng trống
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <h2 class="fw-bold mt-5 pt-4 mb-4" style="color: #1e293b;">Lịch sử Đặt phòng của bạn</h2>
        <div class="card shadow-sm border-0 rounded-4 overflow-hidden mb-5">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="py-3 px-4">Mã Đặt Phòng</th>
                            <th class="py-3 px-4">Phòng</th>
                            <th class="py-3 px-4">Ngày nhận phòng</th>
                            <th class="py-3 px-4">Ngày trả phòng</th>
                            <th class="py-3 px-4">Tổng tiền</th>
                            <th class="py-3 px-4">Trạng thái</th>
                        </tr>
                    </thead>
                    <tbody id="order-list">
                        <c:set var="hasOrder" value="false" />
                        <c:forEach items="${orders}" var="o">
                            <c:if test="${o.customerUsername == sessionScope.currentUser.username}">
                                <c:set var="hasOrder" value="true" />
                                <c:set var="badgeClass" value="bg-warning text-dark" />
                                <c:if test="${o.status == 'Đã hoàn thành'}"><c:set var="badgeClass" value="bg-success" /></c:if>
                                <c:if test="${o.status == 'Đã hủy'}"><c:set var="badgeClass" value="bg-danger" /></c:if>
                                
                                <tr>
                                    <td class="px-4 py-3"><strong class="text-secondary">#${o.id}</strong></td>
                                    <td class="px-4 py-3 fw-medium">Phòng ${o.roomId}</td>
                                    <td class="px-4 py-3"><fmt:formatDate value="${o.checkInDate}" pattern="dd/MM/yyyy" /></td>
                                    <td class="px-4 py-3"><fmt:formatDate value="${o.checkOutDate}" pattern="dd/MM/yyyy" /></td>
                                    <td class="px-4 py-3 fw-bold" style="color: #10b981;">
                                        <fmt:formatNumber value="${o.total}" pattern="#,###" /> đ
                                    </td>
                                    <td class="px-4 py-3"><span class="badge rounded-pill ${badgeClass} px-3 py-2">${o.status}</span></td>
                                    <td class="px-4 py-3">
                                        <c:choose>
                                            <c:when test="${o.status == 'Đã Check-out' && o.rating == 0}">
                                                <button class="btn btn-primary btn-sm" onclick="openReviewModal(${o.id})">Đánh giá</button>
                                            </c:when>
                                            <c:when test="${o.rating > 0}">
                                                <span class="text-warning">
                                                    <c:forEach begin="1" end="${o.rating}">★</c:forEach>
                                                </span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        <c:if test="${not hasOrder}">
                            <tr><td colspan="7" class="text-center py-4 text-secondary">Chưa có lịch sử đặt phòng</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Modal Kiểm Tra Phòng -->
    <div class="modal fade" id="bookModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content rounded-4 border-0 shadow-lg">
                <div class="modal-header border-bottom-0 pb-0 mt-3 px-4">
                    <h5 class="modal-title fw-bold fs-4" style="color: #1e293b;">Tìm phòng <span id="modalRoomName" style="color: #6b46c1;"></span></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <form action="${pageContext.request.contextPath}/home" method="POST">
                        <input type="hidden" name="categoryId" id="modalCategoryId" value="">
                        <div class="mb-3">
                            <label class="form-label fw-medium text-secondary">Ngày nhận phòng (Check-in)</label>
                            <input type="date" name="checkIn" class="form-control form-control-lg bg-light" required>
                        </div>
                        <div class="mb-4">
                            <label class="form-label fw-medium text-secondary">Ngày trả phòng (Check-out)</label>
                            <input type="date" name="checkOut" class="form-control form-control-lg bg-light" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100 py-3 fw-bold rounded-3 shadow-sm" style="background-color: #6b46c1; border: none;">
                            TIẾP TỤC &rarr;
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        function openBookModal(catId, catName) {
            document.getElementById('modalCategoryId').value = catId;
            document.getElementById('modalRoomName').innerText = catName;
            var myModal = new bootstrap.Modal(document.getElementById('bookModal'));
            myModal.show();
        }
        function openReviewModal(orderId) {
            document.getElementById('reviewOrderId').value = orderId;
            var reviewModal = new bootstrap.Modal(document.getElementById('reviewModal'));
            reviewModal.show();
        }
    </script>
    <jsp:include page="../components/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Review Modal -->
    <div class="modal fade" id="reviewModal" tabindex="-1" aria-labelledby="reviewModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content glass-panel" style="background-color: var(--card-bg);">
          <div class="modal-header border-bottom border-secondary">
            <h5 class="modal-title" id="reviewModalLabel" style="color: var(--text-main);">Đánh giá Trải nghiệm</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <form action="${pageContext.request.contextPath}/customer" method="POST">
              <div class="modal-body">
                <input type="hidden" name="action" value="review">
                <input type="hidden" name="orderId" id="reviewOrderId">
                
                <div class="mb-3 text-center">
                    <label class="form-label d-block mb-3" style="color: var(--text-main);">Chất lượng phòng & Dịch vụ (1-5 Sao)</label>
                    <div class="rating-stars fs-2 d-flex justify-content-center gap-2 flex-row-reverse" style="color: #4b5563; cursor: pointer;">
                        <!-- Using flex-row-reverse for CSS adjacent sibling selector magic -->
                        <input type="radio" name="rating" id="star5" value="5" class="d-none" required>
                        <label for="star5" class="star-label">★</label>
                        
                        <input type="radio" name="rating" id="star4" value="4" class="d-none">
                        <label for="star4" class="star-label">★</label>
                        
                        <input type="radio" name="rating" id="star3" value="3" class="d-none">
                        <label for="star3" class="star-label">★</label>
                        
                        <input type="radio" name="rating" id="star2" value="2" class="d-none">
                        <label for="star2" class="star-label">★</label>
                        
                        <input type="radio" name="rating" id="star1" value="1" class="d-none">
                        <label for="star1" class="star-label">★</label>
                    </div>
                </div>
                
                <div class="mb-3">
                    <label for="note" class="form-label" style="color: var(--text-main);">Ghi chú / Nhận xét thêm</label>
                    <textarea class="form-control text-dark border-secondary" id="note" name="note" rows="3" placeholder="Chia sẻ trải nghiệm của bạn..."></textarea>
                </div>
              </div>
              <div class="modal-footer border-top border-secondary">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="submit" class="btn btn-primary" style="background-color: #6b46c1; border: none;">Gửi Đánh Giá</button>
              </div>
          </form>
        </div>
      </div>
    </div>
    
    <style>
        .star-label {
            transition: color 0.2s ease;
        }
        .star-label:hover,
        .star-label:hover ~ .star-label,
        input[type="radio"]:checked ~ .star-label {
            color: #fbbf24; /* Gold */
        }
    </style>
</body>
</html>
