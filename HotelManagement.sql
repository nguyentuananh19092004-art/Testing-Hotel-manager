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
    name NVARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    gmail VARCHAR(100)
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
    payment_status VARCHAR(20) DEFAULT 'Unpaid',
    rating INT DEFAULT 0,
    note NVARCHAR(500)
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

-- Bảng Ca làm việc (Shift)
CREATE TABLE Shift (
    id INT PRIMARY KEY,
    name NVARCHAR(50) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL
);
GO

-- Bảng Phân ca (ShiftAssignment)
CREATE TABLE ShiftAssignment (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50) FOREIGN KEY REFERENCES Users(username) ON DELETE CASCADE,
    shift_id INT FOREIGN KEY REFERENCES Shift(id) ON DELETE CASCADE,
    floor INT NOT NULL,
    assign_date DATE NOT NULL
);
GO

-- Bảng Nhiệm vụ dọn phòng (CleaningTask)
CREATE TABLE CleaningTask (
    id INT IDENTITY(1,1) PRIMARY KEY,
    room_id VARCHAR(10) FOREIGN KEY REFERENCES Room(id) ON DELETE CASCADE,
    assigned_to VARCHAR(50) FOREIGN KEY REFERENCES Users(username) ON DELETE SET NULL,
    status VARCHAR(20) DEFAULT 'Pending', -- Pending, In Progress, Completed
    created_at DATETIME DEFAULT GETDATE(),
    completed_at DATETIME
);
GO

-- =======================================================
-- CHÈN DỮ LIỆU MẪU (MOCK DATA CƠ BẢN & MỞ RỘNG)
-- =======================================================

-- 1. Thêm nhân sự & Khách hàng (Đã được giữ nguyên từ file cũ)
INSERT INTO Users (username, password, role, name, phone, gmail) VALUES 
('khachhang', '123', 'customer', N'Nguyễn Khách Hàng (VIP)', '0123456789', 'kh1@gmail.com'),
('khachhang2', '123', 'customer', N'Trần Văn A (Khách thường)', '0123456788', 'kh2@gmail.com'),
('letan', '123', 'receptionist', N'Trần Lễ Tân', '0987654321', 'lt@gmail.com'),
('donphong', '123', 'housekeeper', N'Lê Dọn Phòng', '0987654322', 'dp@gmail.com'),
('quanly', '123', 'manager', N'Phạm Quản Lý', '0909090909', 'admin@gmail.com');

-- 5 Lễ tân thêm
INSERT INTO Users (username, password, role, name, phone, gmail) VALUES 
('lt1', '123', 'receptionist', N'Lễ Tân 1', '0911111111', 'lt1@gmail.com'),
('lt2', '123', 'receptionist', N'Lễ Tân 2', '0911111112', 'lt2@gmail.com'),
('lt3', '123', 'receptionist', N'Lễ Tân 3', '0911111113', 'lt3@gmail.com'),
('lt4', '123', 'receptionist', N'Lễ Tân 4', '0911111114', 'lt4@gmail.com'),
('lt5', '123', 'receptionist', N'Lễ Tân 5', '0911111115', 'lt5@gmail.com');

-- 20 Dọn phòng thêm
INSERT INTO Users (username, password, role, name, phone, gmail) VALUES 
('dp1', '123', 'housekeeper', N'Dọn Phòng 1', '0922222201', 'dp1@gmail.com'),
('dp2', '123', 'housekeeper', N'Dọn Phòng 2', '0922222202', 'dp2@gmail.com'),
('dp3', '123', 'housekeeper', N'Dọn Phòng 3', '0922222203', 'dp3@gmail.com'),
('dp4', '123', 'housekeeper', N'Dọn Phòng 4', '0922222204', 'dp4@gmail.com'),
('dp5', '123', 'housekeeper', N'Dọn Phòng 5', '0922222205', 'dp5@gmail.com'),
('dp6', '123', 'housekeeper', N'Dọn Phòng 6', '0922222206', 'dp6@gmail.com'),
('dp7', '123', 'housekeeper', N'Dọn Phòng 7', '0922222207', 'dp7@gmail.com'),
('dp8', '123', 'housekeeper', N'Dọn Phòng 8', '0922222208', 'dp8@gmail.com'),
('dp9', '123', 'housekeeper', N'Dọn Phòng 9', '0922222209', 'dp9@gmail.com'),
('dp10', '123', 'housekeeper', N'Dọn Phòng 10', '0922222210', 'dp10@gmail.com'),
('dp11', '123', 'housekeeper', N'Dọn Phòng 11', '0922222211', 'dp11@gmail.com'),
('dp12', '123', 'housekeeper', N'Dọn Phòng 12', '0922222212', 'dp12@gmail.com'),
('dp13', '123', 'housekeeper', N'Dọn Phòng 13', '0922222213', 'dp13@gmail.com'),
('dp14', '123', 'housekeeper', N'Dọn Phòng 14', '0922222214', 'dp14@gmail.com'),
('dp15', '123', 'housekeeper', N'Dọn Phòng 15', '0922222215', 'dp15@gmail.com'),
('dp16', '123', 'housekeeper', N'Dọn Phòng 16', '0922222216', 'dp16@gmail.com'),
('dp17', '123', 'housekeeper', N'Dọn Phòng 17', '0922222217', 'dp17@gmail.com'),
('dp18', '123', 'housekeeper', N'Dọn Phòng 18', '0922222218', 'dp18@gmail.com'),
('dp19', '123', 'housekeeper', N'Dọn Phòng 19', '0922222219', 'dp19@gmail.com'),
('dp20', '123', 'housekeeper', N'Dọn Phòng 20', '0922222220', 'dp20@gmail.com');
GO

-- Insert 3 Ca làm việc
INSERT INTO Shift (id, name, start_time, end_time) VALUES
(1, N'Ca Sáng', '07:00:00', '14:59:59'),
(2, N'Ca Chiều', '15:00:00', '20:59:59'),
(3, N'Ca Đêm', '21:00:00', '06:59:59');
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

        DECLARE @status VARCHAR(20) = 'Available';

        INSERT INTO Room (id, category_id, floor, status) 
        VALUES (@roomId, @catId, @floor, @status);

        SET @roomNumber = @roomNumber + 1;
    END
    SET @floor = @floor + 1;
END
GO
