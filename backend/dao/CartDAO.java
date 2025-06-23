package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Book;
import util.DBUtil;

public class CartDAO {
    
    // 장바구니에 책 추가
    public boolean addToCart(String userId, int bookId) {
        String sql = "INSERT INTO cart (user_id, book_id) VALUES (?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, userId);
            pstmt.setInt(2, bookId);
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            if (e.getErrorCode() == 1062) { // MySQL/MariaDB의 중복 키 에러
                return false; // 이미 장바구니에 있음
            }
            e.printStackTrace();
            return false;
        }
    }
    
    // 장바구니에서 책 제거
    public boolean removeFromCart(String userId, int bookId) {
        String sql = "DELETE FROM cart WHERE user_id = ? AND book_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, userId);
            pstmt.setInt(2, bookId);
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 사용자의 장바구니 목록 조회
    public List<Book> getCartBooks(String userId) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT b.* FROM cart c JOIN books b ON c.book_id = b.book_id WHERE c.user_id = ? ORDER BY c.added_at DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setPublisher(rs.getString("publisher"));
                book.setPrice(rs.getInt("price"));
                book.setDescription(rs.getString("description"));
                book.setBookCondition(rs.getString("book_condition"));
                book.setCategory(rs.getString("category"));
                book.setImagePath(rs.getString("image_path"));
                book.setSellerId(rs.getString("seller_id"));
                book.setStatus(rs.getString("status"));
                
                // Timestamp를 LocalDateTime으로 변환
                Timestamp createdTimestamp = rs.getTimestamp("created_at");
                if (createdTimestamp != null) {
                    book.setCreatedAt(createdTimestamp.toLocalDateTime());
                }
                
                Timestamp updatedTimestamp = rs.getTimestamp("updated_at");
                if (updatedTimestamp != null) {
                    book.setUpdatedAt(updatedTimestamp.toLocalDateTime());
                }
                
                books.add(book);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
    
    // 장바구니에 있는지 확인
    public boolean isInCart(String userId, int bookId) {
        String sql = "SELECT COUNT(*) FROM cart WHERE user_id = ? AND book_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, userId);
            pstmt.setInt(2, bookId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // 장바구니 비우기
    public boolean clearCart(String userId) {
        String sql = "DELETE FROM cart WHERE user_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, userId);
            
            return pstmt.executeUpdate() >= 0; // 0개 삭제도 성공으로 간주
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 장바구니 아이템 개수 조회
    public int getCartCount(String userId) {
        String sql = "SELECT COUNT(*) FROM cart WHERE user_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, userId);
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