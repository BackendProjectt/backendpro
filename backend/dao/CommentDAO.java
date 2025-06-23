package dao;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import model.Comment;
import util.DBUtil;

public class CommentDAO {
    
    public boolean addComment(Comment comment) {
        String sql = "INSERT INTO comments (post_id, author_id, content, created_at) VALUES (?, ?, ?, NOW())";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, comment.getPostId());
            pstmt.setString(2, comment.getUserId());  // author_id로 저장
            pstmt.setString(3, comment.getContent());
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Comment> getCommentsByPostId(int postId) {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT c.comment_id, c.post_id, c.author_id, u.username, c.content, c.created_at " +
                    "FROM comments c JOIN users u ON c.author_id = u.user_id " +
                    "WHERE c.post_id = ? ORDER BY c.created_at ASC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, postId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Comment comment = new Comment();
                comment.setCommentId(rs.getInt("comment_id"));
                comment.setPostId(rs.getInt("post_id"));
                comment.setUserId(rs.getString("author_id"));  // author_id를 userId로 설정
                comment.setUsername(rs.getString("username"));
                comment.setContent(rs.getString("content"));
                comment.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                comments.add(comment);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return comments;
    }
    
    public List<Comment> getCommentsByUserId(String userId) {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT c.comment_id, c.post_id, p.title as post_title, c.content, c.created_at " +
                    "FROM comments c JOIN posts p ON c.post_id = p.post_id " +
                    "WHERE c.author_id = ? ORDER BY c.created_at DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Comment comment = new Comment();
                comment.setCommentId(rs.getInt("comment_id"));
                comment.setPostId(rs.getInt("post_id"));
                comment.setUserId(userId);
                comment.setContent(rs.getString("content"));
                comment.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                comment.setUsername(rs.getString("post_title")); // 게시글 제목을 username에 저장
                comments.add(comment);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return comments;
    }
    
    public boolean deleteComment(int commentId, String userId) {
        String sql = "DELETE FROM comments WHERE comment_id = ? AND author_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, commentId);
            pstmt.setString(2, userId);
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public int getCommentCountByPostId(int postId) {
        String sql = "SELECT COUNT(*) FROM comments WHERE post_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, postId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}