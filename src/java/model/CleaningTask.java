package model;

import java.sql.Timestamp;

public class CleaningTask {
    private int id;
    private String roomId;
    private String assignedTo;
    private String status;
    private Timestamp createdAt;
    private Timestamp completedAt;
    private User assignedUser;

    public CleaningTask() {
    }

    public CleaningTask(int id, String roomId, String assignedTo, String status, Timestamp createdAt, Timestamp completedAt) {
        this.id = id;
        this.roomId = roomId;
        this.assignedTo = assignedTo;
        this.status = status;
        this.createdAt = createdAt;
        this.completedAt = completedAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRoomId() {
        return roomId;
    }

    public void setRoomId(String roomId) {
        this.roomId = roomId;
    }

    public String getAssignedTo() {
        return assignedTo;
    }

    public void setAssignedTo(String assignedTo) {
        this.assignedTo = assignedTo;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getCompletedAt() {
        return completedAt;
    }

    public void setCompletedAt(Timestamp completedAt) {
        this.completedAt = completedAt;
    }

    public User getAssignedUser() {
        return assignedUser;
    }

    public void setAssignedUser(User assignedUser) {
        this.assignedUser = assignedUser;
    }
}
