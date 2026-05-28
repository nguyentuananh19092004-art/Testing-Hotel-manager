-- =======================================================
-- Kịch bản khởi tạo CSDL Hệ thống Quản lý Khách sạn
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

-- Bảng Rooms (Thông tin các phòng)
CREATE TABLE Rooms (
    id VARCHAR(10) PRIMARY KEY,
    type NVARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Available', -- Available, Occupied, Needs Cleaning, Reserved
    price INT NOT NULL,
    features NVARCHAR(255)
);
GO

-- Bảng Orders (Thông tin đặt phòng / Hóa đơn)
CREATE TABLE Orders (
    id INT IDENTITY(1,1) PRIMARY KEY,
    roomId VARCHAR(10) FOREIGN KEY REFERENCES Rooms(id) ON DELETE CASCADE,
    customerUsername VARCHAR(50) FOREIGN KEY REFERENCES Users(username) ON DELETE CASCADE,
    total INT NOT NULL,
    status NVARCHAR(50) NOT NULL DEFAULT N'Chờ Check-in' -- Chờ Check-in, Đang ở, Đã Check-out
);
GO

-- =======================================================
-- CHÈN DỮ LIỆU MẪU (MOCK DATA CƠ BẢN & MỞ RỘNG)
-- =======================================================

-- 1. Thêm nhân sự & Khách hàng
INSERT INTO Users (username, password, role, name) VALUES 
('khachhang', '123', 'customer', N'Nguyễn Khách Hàng (VIP)'),
('khachhang2', '123', 'customer', N'Trần Văn A (Khách thường)'),
('letan', '123', 'receptionist', N'Trần Lễ Tân'),
('donphong', '123', 'housekeeper', N'Lê Dọn Phòng'),
('quanly', '123', 'manager', N'Phạm Quản Lý');
GO

-- 2. Thêm danh mục Phòng đa dạng (từ rẻ đến cao cấp)
INSERT INTO Rooms (id, type, status, price, features) VALUES 
('101', 'Standard', 'Available', 500000, N'1 Giường đơn, Wi-Fi, Quạt'),
('102', 'Standard', 'Available', 500000, N'1 Giường đơn, Wi-Fi, Quạt'),
('103', 'Standard', 'Occupied', 500000, N'1 Giường đơn, Wi-Fi, Quạt'),
('201', 'Deluxe', 'Needs Cleaning', 800000, N'2 Giường đơn, Điều hòa, Ban công, Tivi'),
('202', 'Deluxe', 'Available', 800000, N'2 Giường đơn, Điều hòa, Ban công, Tivi'),
('203', 'Deluxe', 'Reserved', 800000, N'1 Giường King, Điều hòa, Ban công view biển'),
('301', 'Suite', 'Available', 1500000, N'Giường King lớn, Bồn tắm massage, Minibar, VIP'),
('302', 'Suite', 'Needs Cleaning', 1500000, N'Giường King lớn, Bồn tắm massage, Minibar, VIP');
GO

-- 3. Thêm các Đơn đặt phòng mẫu để test (Bao phủ mọi trạng thái)
-- Trạng thái: "Đang ở" -> Khách đang thuê, lễ tân chuẩn bị check-out
INSERT INTO Orders (roomId, customerUsername, total, status) VALUES 
('103', 'khachhang', 500000, N'Đang ở');

-- Trạng thái: "Đã Check-out" -> Đơn đã hoàn thành, phòng cần dọn
INSERT INTO Orders (roomId, customerUsername, total, status) VALUES 
('201', 'khachhang2', 800000, N'Đã Check-out'),
('302', 'khachhang', 1500000, N'Đã Check-out');

-- Trạng thái: "Chờ Check-in" -> Khách vừa đặt phòng, lễ tân chờ đón
INSERT INTO Orders (roomId, customerUsername, total, status) VALUES 
('203', 'khachhang2', 800000, N'Chờ Check-in');
GO

-- =======================================================
-- KIỂM TRA LẠI DỮ LIỆU
-- =======================================================
-- SELECT * FROM Users;
-- SELECT * FROM Rooms;
-- SELECT * FROM Orders;
