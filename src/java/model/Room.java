package model;

public class Room {
    private String id;
    private String type;
    private String status;
    private int price;
    private String features;

    public Room() {
    }

    public Room(String id, String type, String status, int price, String features) {
        this.id = id;
        this.type = type;
        this.status = status;
        this.price = price;
        this.features = features;
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public int getPrice() { return price; }
    public void setPrice(int price) { this.price = price; }
    public String getFeatures() { return features; }
    public void setFeatures(String features) { this.features = features; }
}
