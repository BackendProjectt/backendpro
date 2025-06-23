package model;

import java.time.LocalDateTime;

public class Comment {
    private int commentId;
    private int postId;
    private String userId;
    private String username;
    private String content;
    private LocalDateTime createdAt;
    
    public Comment() {}
    
    public Comment(int postId, String userId, String content) {
        this.postId = postId;
        this.userId = userId;
        this.content = content;
    }
    
    public int getCommentId() { return commentId; }
    public void setCommentId(int commentId) { this.commentId = commentId; }
    
    public int getPostId() { return postId; }
    public void setPostId(int postId) { this.postId = postId; }
    
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}