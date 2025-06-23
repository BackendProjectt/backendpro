package model;

import java.time.LocalDateTime;

public class Post {
    private int postId;
    private String title;
    private String category;
    private String content;
    private String authorId;       // author_id 컬럼 (DB에 맞춤)
    private String username;       // JOIN으로 가져온 사용자명
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    
    // 기본 생성자
    public Post() {}
    
    // 매개변수 생성자
    public Post(String title, String category, String content, String authorId) {
        this.title = title;
        this.category = category;
        this.content = content;
        this.authorId = authorId;
    }
    
    // Getter and Setter
    public int getPostId() {
        return postId;
    }
    
    public void setPostId(int postId) {
        this.postId = postId;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getCategory() {
        return category;
    }
    
    public void setCategory(String category) {
        this.category = category;
    }
    
    public String getContent() {
        return content;
    }
    
    public void setContent(String content) {
        this.content = content;
    }
    
    // authorId getter/setter (author_id 컬럼)
    public String getAuthorId() {
        return authorId;
    }
    
    public void setAuthorId(String authorId) {
        this.authorId = authorId;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    // 호환성을 위한 추가 메소드들
    public String getUserId() {
        return authorId; // authorId와 같음
    }
    
    public void setUserId(String userId) {
        this.authorId = userId;
    }
}