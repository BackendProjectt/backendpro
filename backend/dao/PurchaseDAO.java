package dao;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import model.Purchase;
import util.DBUtil;

public class PurchaseDAO {
    
    // 구매 추가
    public boolean addPurchase(Purchase purchase) {
        String sql = "INSERT INTO purchases (book_id, buyer_id, seller_id, price, purchase_date, status) VALUES (?, ?, ?, ?, NOW(), '구매완료')";
        
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false);
            
            // 구매 정보 저장
            PreparedStatement pstmt1 = conn.prepareStatement(sql);
            pstmt1.setInt(1, purchase.getBookId());
            pstmt1.setString(2, purchase.getBuyerId());
            pstmt1.setString(3, purchase.getSellerId());
            pstmt1.setInt(4, purchase.getPrice());
            
            int result = pstmt1.executeUpdate();
            
            if (result > 0) {
                // 책 상태를 '판매완료'로 변경
                PreparedStatement pstmt2 = conn.prepareStatement("UPDATE books SET status = '판매완료' WHERE book_id = ?");
                pstmt2.setInt(1, purchase.getBookId());
                pstmt2.executeUpdate();
                
                conn.commit();
                return true;
            } else {
                conn.rollback();
                return false;
            }
            
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
    
    // 특정 구매 ID로 구매 정보 조회
    public Purchase getPurchaseById(int purchaseId) {
        String sql = "SELECT p.*, b.title, b.author, b.publisher, b.image_path " +
                     "FROM purchases p " +
                     "JOIN books b ON p.book_id = b.book_id " +
                     "WHERE p.purchase_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, purchaseId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Purchase purchase = new Purchase();
                    purchase.setPurchaseId(rs.getInt("purchase_id"));
                    purchase.setBuyerId(rs.getString("buyer_id"));
                    purchase.setSellerId(rs.getString("seller_id"));
                    purchase.setBookId(rs.getInt("book_id"));
                    purchase.setPrice(rs.getInt("price"));
                    purchase.setPurchaseDate(rs.getTimestamp("purchase_date"));
                    purchase.setStatus(rs.getString("status"));
                    
                    return purchase;
                }
            }
            
        } catch (SQLException e) {
            System.err.println("구매 정보 조회 중 오류: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    // 구매자별 구매 내역 조회
    public List<Purchase> getPurchasesByBuyerId(String buyerId) {
        List<Purchase> purchases = new ArrayList<>();
        String sql = "SELECT p.*, b.title, b.author, b.publisher, b.image_path " +
                     "FROM purchases p " +
                     "JOIN books b ON p.book_id = b.book_id " +
                     "WHERE p.buyer_id = ? " +
                     "ORDER BY p.purchase_date DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, buyerId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Purchase purchase = new Purchase();
                    purchase.setPurchaseId(rs.getInt("purchase_id"));
                    purchase.setBuyerId(rs.getString("buyer_id"));
                    purchase.setSellerId(rs.getString("seller_id"));
                    purchase.setBookId(rs.getInt("book_id"));
                    purchase.setPrice(rs.getInt("price"));
                    purchase.setPurchaseDate(rs.getTimestamp("purchase_date"));
                    purchase.setStatus(rs.getString("status"));
                    
                    purchases.add(purchase);
                }
            }
            
        } catch (SQLException e) {
            System.err.println("구매 내역 조회 중 오류: " + e.getMessage());
            e.printStackTrace();
        }
        
        return purchases;
    }
    
    // 판매자별 판매 내역 조회
    public List<Purchase> getPurchasesBySellerId(String sellerId) {
        List<Purchase> purchases = new ArrayList<>();
        String sql = "SELECT p.*, b.title, b.author, b.publisher, b.image_path " +
                     "FROM purchases p " +
                     "JOIN books b ON p.book_id = b.book_id " +
                     "WHERE p.seller_id = ? " +
                     "ORDER BY p.purchase_date DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, sellerId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Purchase purchase = new Purchase();
                    purchase.setPurchaseId(rs.getInt("purchase_id"));
                    purchase.setBuyerId(rs.getString("buyer_id"));
                    purchase.setSellerId(rs.getString("seller_id"));
                    purchase.setBookId(rs.getInt("book_id"));
                    purchase.setPrice(rs.getInt("price"));
                    purchase.setPurchaseDate(rs.getTimestamp("purchase_date"));
                    purchase.setStatus(rs.getString("status"));
                    
                    purchases.add(purchase);
                }
            }
            
        } catch (SQLException e) {
            System.err.println("판매 내역 조회 중 오류: " + e.getMessage());
            e.printStackTrace();
        }
        
        return purchases;
    }
}