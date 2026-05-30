package model;

public class RoomItem {
    private int id;
    private String name;
    private int compensationPrice;

    public RoomItem() {
    }

    public RoomItem(int id, String name, int compensationPrice) {
        this.id = id;
        this.name = name;
        this.compensationPrice = compensationPrice;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public int getCompensationPrice() { return compensationPrice; }
    public void setCompensationPrice(int compensationPrice) { this.compensationPrice = compensationPrice; }
}
