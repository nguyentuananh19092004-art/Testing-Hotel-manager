package model;

public class Order {
    private int id;
    private String roomId;
    private String customerUsername;
    private int total;
    private String status;

    public Order() {
    }

    public Order(int id, String roomId, String customerUsername, int total, String status) {
        this.id = id;
        this.roomId = roomId;
        this.customerUsername = customerUsername;
        this.total = total;
        this.status = status;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getRoomId() { return roomId; }
    public void setRoomId(String roomId) { this.roomId = roomId; }
    public String getCustomerUsername() { return customerUsername; }
    public void setCustomerUsername(String customerUsername) { this.customerUsername = customerUsername; }
    public int getTotal() { return total; }
    public void setTotal(int total) { this.total = total; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
