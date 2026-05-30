package model;

import java.sql.Date;

public class Order {
    private int id;
    private String roomId;
    private String customerUsername;
    private int total;
    private Date checkInDate;
    private Date checkOutDate;
    private String status;
    private String paymentStatus;

    public Order() {
    }

    public Order(int id, String roomId, String customerUsername, int total, Date checkInDate, Date checkOutDate, String status, String paymentStatus) {
        this.id = id;
        this.roomId = roomId;
        this.customerUsername = customerUsername;
        this.total = total;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.status = status;
        this.paymentStatus = paymentStatus;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getRoomId() { return roomId; }
    public void setRoomId(String roomId) { this.roomId = roomId; }
    public String getCustomerUsername() { return customerUsername; }
    public void setCustomerUsername(String customerUsername) { this.customerUsername = customerUsername; }
    public int getTotal() { return total; }
    public void setTotal(int total) { this.total = total; }
    public Date getCheckInDate() { return checkInDate; }
    public void setCheckInDate(Date checkInDate) { this.checkInDate = checkInDate; }
    public Date getCheckOutDate() { return checkOutDate; }
    public void setCheckOutDate(Date checkOutDate) { this.checkOutDate = checkOutDate; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }
}
