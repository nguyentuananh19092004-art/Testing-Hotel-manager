package model;

import java.sql.Timestamp;

public class Payment {
    private int id;
    private int orderId;
    private String paymentMethod;
    private int amount;
    private Timestamp paymentDate;
    private String receptionistUsername;

    public Payment() {
    }

    public Payment(int id, int orderId, String paymentMethod, int amount, Timestamp paymentDate, String receptionistUsername) {
        this.id = id;
        this.orderId = orderId;
        this.paymentMethod = paymentMethod;
        this.amount = amount;
        this.paymentDate = paymentDate;
        this.receptionistUsername = receptionistUsername;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    public int getAmount() { return amount; }
    public void setAmount(int amount) { this.amount = amount; }
    public Timestamp getPaymentDate() { return paymentDate; }
    public void setPaymentDate(Timestamp paymentDate) { this.paymentDate = paymentDate; }
    public String getReceptionistUsername() { return receptionistUsername; }
    public void setReceptionistUsername(String receptionistUsername) { this.receptionistUsername = receptionistUsername; }
}
