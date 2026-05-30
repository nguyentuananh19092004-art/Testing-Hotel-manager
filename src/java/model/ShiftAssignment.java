package model;

import java.sql.Date;

public class ShiftAssignment {
    private int id;
    private String username;
    private int shiftId;
    private int floor;
    private Date assignDate;
    private User user;
    private Shift shift;

    public ShiftAssignment() {
    }

    public ShiftAssignment(int id, String username, int shiftId, int floor, Date assignDate) {
        this.id = id;
        this.username = username;
        this.shiftId = shiftId;
        this.floor = floor;
        this.assignDate = assignDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getShiftId() {
        return shiftId;
    }

    public void setShiftId(int shiftId) {
        this.shiftId = shiftId;
    }

    public int getFloor() {
        return floor;
    }

    public void setFloor(int floor) {
        this.floor = floor;
    }

    public Date getAssignDate() {
        return assignDate;
    }

    public void setAssignDate(Date assignDate) {
        this.assignDate = assignDate;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Shift getShift() {
        return shift;
    }

    public void setShift(Shift shift) {
        this.shift = shift;
    }
}
