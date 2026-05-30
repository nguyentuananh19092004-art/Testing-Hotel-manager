package model;

public class RoomCategory {
    private int id;
    private String name;
    private int price;
    private int capacity;
    private String description;

    public RoomCategory() {
    }

    public RoomCategory(int id, String name, int price, int capacity, String description) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.capacity = capacity;
        this.description = description;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public int getPrice() { return price; }
    public void setPrice(int price) { this.price = price; }
    public int getCapacity() { return capacity; }
    public void setCapacity(int capacity) { this.capacity = capacity; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}
