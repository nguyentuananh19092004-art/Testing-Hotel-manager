package model;

public class Room {
    private String id;
    private int categoryId;
    private int floor;
    private String status;

    public Room() {
    }

    public Room(String id, int categoryId, int floor, String status) {
        this.id = id;
        this.categoryId = categoryId;
        this.floor = floor;
        this.status = status;
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
    public int getFloor() { return floor; }
    public void setFloor(int floor) { this.floor = floor; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
