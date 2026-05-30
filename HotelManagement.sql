-- =======================================================
-- Kịch bản khởi tạo CSDL Hệ thống Quản lý Khách sạn
-- Cập nhật: Tích hợp thiết kế 6 tầng x 9 phòng, Hạng phòng, và Thanh toán bồi thường
-- =======================================================

USE master;
GO

-- 1. Tạo mới hoặc Reset lại Database nếu đã tồn tại
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'HotelManagement')
BEGIN
    -- Ngắt kết nối các session đang sử dụng để có thể drop
    ALTER DATABASE HotelManagement SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE HotelManagement;
END
GO

CREATE DATABASE HotelManagement;
GO

USE HotelManagement;
GO

-- =======================================================
-- TẠO CÁC BẢNG (TABLES)
-- =======================================================

-- Bảng Users (Tài khoản người dùng & Phân quyền)
CREATE TABLE Users (
    username VARCHAR(50) PRIMARY KEY,
    password VARCHAR(50) NOT NULL,
    role VARCHAR(20) NOT NULL, -- Các quyền: customer, receptionist, housekeeper, manager
    name NVARCHAR(100) NOT NULL
);
GO

-- Bảng Hạng Phòng (RoomCategory)
CREATE TABLE RoomCategory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(50) NOT NULL,
    price INT NOT NULL,
    capacity INT,
    description NVARCHAR(255)
);
GO

-- Bảng Phòng (Room)
CREATE TABLE Room (
    id VARCHAR(10) PRIMARY KEY,
    category_id INT FOREIGN KEY REFERENCES RoomCategory(id) ON DELETE CASCADE,
    floor INT,
    status VARCHAR(20) DEFAULT 'Available'
);
GO

-- Bảng Đặt phòng (Orders)
CREATE TABLE Orders (
    id INT IDENTITY(1,1) PRIMARY KEY,
    room_id VARCHAR(10) FOREIGN KEY REFERENCES Room(id) ON DELETE CASCADE,
    customer_username VARCHAR(50) FOREIGN KEY REFERENCES Users(username) ON DELETE CASCADE,
    total INT,
    check_in_date DATE,
    check_out_date DATE,
    status NVARCHAR(50), -- Chờ Check-in, Đang ở, Đã Check-out
    payment_status VARCHAR(20) DEFAULT 'Unpaid'
);
GO

-- Bảng Danh mục Đồ đạc (RoomItem)
CREATE TABLE RoomItem (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    compensation_price INT NOT NULL
);
GO

-- Bảng Phụ phí làm hỏng đồ (OrderDamage)
CREATE TABLE OrderDamage (
    id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT FOREIGN KEY REFERENCES Orders(id) ON DELETE CASCADE,
    item_id INT FOREIGN KEY REFERENCES RoomItem(id) ON DELETE CASCADE,
    quantity INT NOT NULL,
    total_cost INT NOT NULL
);
GO

-- Bảng Thanh toán (Payment)
CREATE TABLE Payment (
    id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT FOREIGN KEY REFERENCES Orders(id) ON DELETE CASCADE,
    payment_method VARCHAR(50),
    amount INT NOT NULL,
    payment_date DATETIME DEFAULT GETDATE(),
    receptionist_username VARCHAR(50) FOREIGN KEY REFERENCES Users(username)
);
GO

-- =======================================================
-- CHÈN DỮ LIỆU MẪU (MOCK DATA CƠ BẢN & MỞ RỘNG)
-- =======================================================

-- 1. Thêm nhân sự & Khách hàng (Đã được giữ nguyên từ file cũ)
INSERT INTO Users (username, password, role, name) VALUES 
('khachhang', '123', 'customer', N'Nguyễn Khách Hàng (VIP)'),
('khachhang2', '123', 'customer', N'Trần Văn A (Khách thường)'),
('letan', '123', 'receptionist', N'Trần Lễ Tân'),
('donphong', '123', 'housekeeper', N'Lê Dọn Phòng'),
('quanly', '123', 'manager', N'Phạm Quản Lý');
GO

-- 2. Insert 3 Hạng Phòng
INSERT INTO RoomCategory (name, price, capacity, description) VALUES
('Standard', 500000, 2, 'Basic amenities, 1 Double Bed'),
('Deluxe', 1000000, 3, 'Ocean view, 1 King Bed or 2 Twin Beds'),
('Suite', 2500000, 4, 'Premium luxury, Living room, 2 Bedrooms');
GO

-- 3. Insert Đồ đạc trong phòng và giá đền bù (VND)
INSERT INTO RoomItem (name, compensation_price) VALUES
(N'Khăn tắm (Towel)', 150000),
(N'Cốc thủy tinh (Glass)', 50000),
(N'Điều khiển TV (TV Remote)', 300000),
(N'Điều khiển Điều hòa (AC Remote)', 250000),
(N'Chìa khóa phòng (Room Key)', 100000),
(N'Bình siêu tốc (Kettle)', 500000),
(N'Máy sấy tóc (Hair Dryer)', 400000),
(N'Tivi (TV)', 8000000);
GO

-- 4. Vòng lặp T-SQL Insert 54 phòng (6 tầng)
DECLARE @floor INT = 1;
DECLARE @roomNumber INT;
DECLARE @roomId VARCHAR(10);
DECLARE @catId INT;

WHILE @floor <= 6
BEGIN
    SET @roomNumber = 1;
    WHILE @roomNumber <= 9
    BEGIN
        SET @roomId = CAST(@floor AS VARCHAR(1)) + RIGHT('0' + CAST(@roomNumber AS VARCHAR(2)), 2);
        
        IF @roomNumber <= 3 SET @catId = 1;
        ELSE IF @roomNumber <= 6 SET @catId = 2;
        ELSE SET @catId = 3;

        -- Đặt một vài phòng giả lập trạng thái khác nhau cho chân thực
        DECLARE @status VARCHAR(20) = 'Available';
        IF @roomId IN ('101', '203', '302') SET @status = 'Occupied';
        IF @roomId IN ('201', '405') SET @status = 'Needs Cleaning';

        INSERT INTO Room (id, category_id, floor, status) 
        VALUES (@roomId, @catId, @floor, @status);

        SET @roomNumber = @roomNumber + 1;
    END
    SET @floor = @floor + 1;
END
GO
