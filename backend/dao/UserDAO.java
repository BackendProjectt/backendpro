package dao;

import java.sql.*;
import model.User;
import util.DBUtil;

public class UserDAO {
    
    // 회원가입
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (user_id, username, password, email) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, user.getUserId());
            pstmt.setString(2, user.getUsername());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getEmail());
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 로그인
    public User loginUser(String userId, String password) {
        String sql = "SELECT * FROM users WHERE user_id = ? AND password = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, userId);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getString("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setJoinDate(rs.getTimestamp("join_date").toLocalDateTime());
                user.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
                return user;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // 사용자 정보 조회
    public User getUserById(String userId) {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getString("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setJoinDate(rs.getTimestamp("join_date").toLocalDateTime());
                user.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
                return user;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // 사용자 정보 업데이트
    public boolean updateUser(User user) {
        String sql = "UPDATE users SET username=?, email=? WHERE user_id=?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getUserId());
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 아이디 중복 확인
    public boolean isUserIdExists(String userId) {
        String sql = "SELECT COUNT(*) FROM users WHERE user_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // 이메일 중복 확인
    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // 회원탈퇴
    public boolean deleteMember(String userId, String password) {
        if (!checkPassword(userId, password)) {
            return false;
        }
        
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false);
            
            // comments 테이블에서 author_id 기준으로 삭제
            PreparedStatement pstmt1 = conn.prepareStatement("DELETE FROM comments WHERE author_id = ?");
            pstmt1.setString(1, userId);
            pstmt1.executeUpdate();
            pstmt1.close();
            
            // reviews 테이블에서 삭제
            PreparedStatement pstmt2 = conn.prepareStatement("DELETE FROM reviews WHERE buyer_id = ? OR seller_id = ?");
            pstmt2.setString(1, userId);
            pstmt2.setString(2, userId);
            pstmt2.executeUpdate();
            pstmt2.close();
            
            // purchases 테이블에서 삭제
            PreparedStatement pstmt3 = conn.prepareStatement("DELETE FROM purchases WHERE buyer_id = ? OR seller_id = ?");
            pstmt3.setString(1, userId);
            pstmt3.setString(2, userId);
            pstmt3.executeUpdate();
            pstmt3.close();
            
            // cart 테이블에서 삭제
            PreparedStatement pstmt4 = conn.prepareStatement("DELETE FROM cart WHERE user_id = ?");
            pstmt4.setString(1, userId);
            pstmt4.executeUpdate();
            pstmt4.close();
            
            // books 테이블에서 삭제
            PreparedStatement pstmt5 = conn.prepareStatement("DELETE FROM books WHERE seller_id = ?");
            pstmt5.setString(1, userId);
            pstmt5.executeUpdate();
            pstmt5.close();
            
            // posts 테이블에서 author_id 기준으로 삭제
            PreparedStatement pstmt6 = conn.prepareStatement("DELETE FROM posts WHERE author_id = ?");
            pstmt6.setString(1, userId);
            pstmt6.executeUpdate();
            pstmt6.close();
            
            // 마지막으로 users 테이블에서 삭제
            PreparedStatement pstmt7 = conn.prepareStatement("DELETE FROM users WHERE user_id = ?");
            pstmt7.setString(1, userId);
            int result = pstmt7.executeUpdate();
            pstmt7.close();
            
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
    
    // 비밀번호 확인
    private boolean checkPassword(String userId, String password) {
        String sql = "SELECT password FROM users WHERE user_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                String dbPassword = rs.getString("password");
                return password.equals(dbPassword);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}