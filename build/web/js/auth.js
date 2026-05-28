// auth.js
const Auth = {
    login: (username, password) => {
        const users = DB.getUsers();
        const user = users.find(u => u.username === username && u.password === password);
        
        if (user) {
            localStorage.setItem('currentUser', JSON.stringify(user));
            Auth.redirectBasedOnRole(user.role);
            return true;
        }
        return false;
    },
    
    logout: () => {
        localStorage.removeItem('currentUser');
        window.location.href = '/Testing1/index.jsp'; // Adjust path if needed
    },
    
    getCurrentUser: () => {
        const userStr = localStorage.getItem('currentUser');
        return userStr ? JSON.parse(userStr) : null;
    },
    
    redirectBasedOnRole: (role) => {
        switch(role) {
            case 'customer':
                window.location.href = 'pages/customer.jsp';
                break;
            case 'receptionist':
                window.location.href = 'pages/receptionist.jsp';
                break;
            case 'housekeeper':
                window.location.href = 'pages/housekeeper.jsp';
                break;
            case 'manager':
                window.location.href = 'pages/manager.jsp';
                break;
            default:
                window.location.href = '../index.jsp';
        }
    },

    checkAuth: (requiredRole) => {
        const user = Auth.getCurrentUser();
        if (!user) {
            window.location.href = '../index.jsp';
            return;
        }
        if (requiredRole && user.role !== requiredRole) {
            alert('Bạn không có quyền truy cập trang này!');
            Auth.redirectBasedOnRole(user.role);
        }
        
        // Show user info on page if element exists
        const userInfoEl = document.getElementById('user-info');
        if (userInfoEl) {
            userInfoEl.innerHTML = `
                <div style="display: flex; align-items: center; gap: 1rem;">
                    <span>Xin chào, <strong>${user.name}</strong></span>
                    <button onclick="Auth.logout()" class="btn btn-danger" style="padding: 0.5rem 1rem;">Đăng xuất</button>
                </div>
            `;
        }
    }
};
