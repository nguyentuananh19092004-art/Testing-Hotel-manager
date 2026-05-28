const defaultUsers = [
    { username: 'khachhang', password: '123', role: 'customer', name: 'Nguyễn Khách Hàng' },
    { username: 'letan', password: '123', role: 'receptionist', name: 'Trần Lễ Tân' },
    { username: 'donphong', password: '123', role: 'housekeeper', name: 'Lê Dọn Phòng' },
    { username: 'quanly', password: '123', role: 'manager', name: 'Phạm Quản Lý' }
];

const defaultRooms = [
    { id: '101', type: 'Standard', status: 'Available', price: 500000, features: '1 Giường đơn, Wi-Fi' },
    { id: '102', type: 'Standard', status: 'Occupied', price: 500000, features: '1 Giường đơn, Wi-Fi' },
    { id: '201', type: 'Deluxe', status: 'Needs Cleaning', price: 800000, features: '2 Giường đơn, Ban công' },
    { id: '202', type: 'Deluxe', status: 'Available', price: 800000, features: '2 Giường đơn, Ban công' },
    { id: '301', type: 'Suite', status: 'Available', price: 1500000, features: 'Giường King, Bồn tắm' }
];

const defaultOrders = [];

function initDB() {
    if (!localStorage.getItem('users')) {
        localStorage.setItem('users', JSON.stringify(defaultUsers));
    }
    if (!localStorage.getItem('rooms')) {
        localStorage.setItem('rooms', JSON.stringify(defaultRooms));
    }
    if (!localStorage.getItem('orders')) {
        localStorage.setItem('orders', JSON.stringify(defaultOrders));
    }
}

// Call on load
initDB();

const DB = {
    getRooms: () => JSON.parse(localStorage.getItem('rooms')),
    setRooms: (rooms) => localStorage.setItem('rooms', JSON.stringify(rooms)),
    
    getOrders: () => JSON.parse(localStorage.getItem('orders')),
    setOrders: (orders) => localStorage.setItem('orders', JSON.stringify(orders)),
    
    getUsers: () => JSON.parse(localStorage.getItem('users'))
};
