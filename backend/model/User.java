package model;

import java.time.LocalDateTime;

public class User {
    private String userId;
    private String username;
    private String password;
    private String email;
    private LocalDateTime joinDate;
    private LocalDateTime updatedAt;
    
    // 기본 생성자
    public User() {}
    
    // 매개변수 생성자
    public User(String userId, String username, String password, String email) {
        this.userId = userId;
        this.username = username;
        this.password = password;
        this.email = email;
    }
    
    // Getter and Setter
    public String getUserId() {
        return userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public LocalDateTime getJoinDate() {
        return joinDate;
    }
    
    public void setJoinDate(LocalDateTime joinDate) {
        this.joinDate = joinDate;
    }
    
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    // 호환성 메소드들
    public String getPhone() {
        return null;
    }
    
    public void setPhone(String phone) {
        // 사용하지 않음
    }
    
    public String getAddress() {
        return null;
    }
    
    public void setAddress(String address) {
        // 사용하지 않음
    }
    
    public LocalDateTime getCreatedAt() {
        return joinDate;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.joinDate = createdAt;
    }
}