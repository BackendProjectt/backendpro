package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Post;
import util.DBUtil;

public class PostDAO {
    
    // 게시글 추가
    public boolean addPost(Post post) {
        String sql = "INSERT INTO posts (title, category, content, author_id) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, post.getTitle());
            pstmt.setString(2, post.getCategory());
            pstmt.setString(3, post.getContent());
            pstmt.setString(4, post.getAuthorId());
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 모든 게시글 조회 (페이징)
    public List<Post> getAllPosts(int page, int pageSize) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT p.post_id, p.title, p.category, p.content, p.author_id, u.username, p.created_at, p.updated_at " +
                    "FROM posts p JOIN users u ON p.author_id = u.user_id " +
                    "ORDER BY p.created_at DESC LIMIT ? OFFSET ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, pageSize);
            pstmt.setInt(2, (page - 1) * pageSize);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Post post = createPostFromResultSet(rs);
                posts.add(post);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }
    
    // 특정 게시글 조회
    public Post getPostById(int postId) {
        String sql = "SELECT p.post_id, p.title, p.category, p.content, p.author_id, u.username, p.created_at, p.updated_at " +
                    "FROM posts p JOIN users u ON p.author_id = u.user_id " +
                    "WHERE p.post_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, postId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return createPostFromResultSet(rs);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // 사용자별 게시글 조회 (author_id 기준)
    public List<Post> getPostsByUserId(String userId) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT * FROM posts WHERE author_id = ? ORDER BY created_at DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Post post = new Post();
                post.setPostId(rs.getInt("post_id"));
                post.setTitle(rs.getString("title"));
                post.setCategory(rs.getString("category"));
                post.setContent(rs.getString("content"));
                post.setAuthorId(rs.getString("author_id"));
                
                // Timestamp를 LocalDateTime으로 변환
                Timestamp createdTimestamp = rs.getTimestamp("created_at");
                if (createdTimestamp != null) {
                    post.setCreatedAt(createdTimestamp.toLocalDateTime());
                }
                
                Timestamp updatedTimestamp = rs.getTimestamp("updated_at");
                if (updatedTimestamp != null) {
                    post.setUpdatedAt(updatedTimestamp.toLocalDateTime());
                }
                
                posts.add(post);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }
    
    // 게시글 수정
    public boolean updatePost(Post post) {
        String sql = "UPDATE posts SET title=?, category=?, content=?, updated_at=NOW() WHERE post_id=? AND author_id=?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, post.getTitle());
            pstmt.setString(2, post.getCategory());
            pstmt.setString(3, post.getContent());
            pstmt.setInt(4, post.getPostId());
            pstmt.setString(5, post.getAuthorId());
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 게시글 삭제 (댓글까지 함께 삭제)
    public boolean deletePost(int postId, String userId) {
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false);
            
            // 먼저 댓글 삭제
            PreparedStatement pstmt1 = conn.prepareStatement("DELETE FROM comments WHERE post_id = ?");
            pstmt1.setInt(1, postId);
            pstmt1.executeUpdate();
            
            // 게시글 삭제 (작성자 확인)
            PreparedStatement pstmt2 = conn.prepareStatement("DELETE FROM posts WHERE post_id = ? AND author_id = ?");
            pstmt2.setInt(1, postId);
            pstmt2.setString(2, userId);
            int result = pstmt2.executeUpdate();
            
            conn.commit();
            return result > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    
    // 카테고리별 게시글 조회
    public List<Post> getPostsByCategory(String category) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT p.post_id, p.title, p.category, p.content, p.author_id, u.username, p.created_at, p.updated_at " +
                    "FROM posts p JOIN users u ON p.author_id = u.user_id " +
                    "WHERE p.category = ? ORDER BY p.created_at DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, category);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Post post = createPostFromResultSet(rs);
                posts.add(post);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }
    
    // 게시글 총 개수 조회
    public int getTotalPostCount() {
        String sql = "SELECT COUNT(*) FROM posts";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // 검색 기능
    public List<Post> searchPosts(String keyword) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT p.post_id, p.title, p.category, p.content, p.author_id, u.username, p.created_at, p.updated_at " +
                    "FROM posts p JOIN users u ON p.author_id = u.user_id " +
                    "WHERE p.title LIKE ? OR p.content LIKE ? ORDER BY p.created_at DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            String searchKeyword = "%" + keyword + "%";
            pstmt.setString(1, searchKeyword);
            pstmt.setString(2, searchKeyword);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Post post = createPostFromResultSet(rs);
                posts.add(post);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }
    
    // ResultSet으로부터 Post 객체 생성
    private Post createPostFromResultSet(ResultSet rs) throws SQLException {
        Post post = new Post();
        post.setPostId(rs.getInt("post_id"));
        post.setTitle(rs.getString("title"));
        post.setCategory(rs.getString("category"));
        post.setContent(rs.getString("content"));
        post.setAuthorId(rs.getString("author_id"));
        post.setUsername(rs.getString("username"));
        
        // Timestamp를 LocalDateTime으로 변환
        Timestamp createdTimestamp = rs.getTimestamp("created_at");
        if (createdTimestamp != null) {
            post.setCreatedAt(createdTimestamp.toLocalDateTime());
        }
        
        Timestamp updatedTimestamp = rs.getTimestamp("updated_at");
        if (updatedTimestamp != null) {
            post.setUpdatedAt(updatedTimestamp.toLocalDateTime());
        }
        
        return post;
    }
}