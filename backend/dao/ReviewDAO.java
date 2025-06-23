package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Review;
import util.DBUtil;

public class ReviewDAO {
    
    // 리뷰 추가 (purchaseId 기준)
    public boolean addReview(Review review) {
        String sql = "INSERT INTO reviews (purchase_id, seller_id, buyer_id, rating, comment, created_at) VALUES (?, ?, ?, ?, ?, NOW())";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, review.getPurchaseId());     // purchase_id
            pstmt.setString(2, review.getSellerId());    // seller_id  
            pstmt.setString(3, review.getBuyerId());     // buyer_id
            pstmt.setInt(4, review.getRating());         // rating
            pstmt.setString(5, review.getContent());     // comment
            
            System.out.println("SQL 실행: " + sql);
            System.out.println("파라미터: purchaseId=" + review.getPurchaseId() + 
                             ", sellerId=" + review.getSellerId() + 
                             ", buyerId=" + review.getBuyerId() + 
                             ", rating=" + review.getRating() + 
                             ", content=" + review.getContent());
            
            int result = pstmt.executeUpdate();
            System.out.println("SQL 실행 결과: " + result);
            
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("리뷰 추가 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // 특정 구매에 대한 리뷰 존재 여부 확인 (중복 방지용)
    public boolean hasReview(String buyerId, int purchaseId) {
        String sql = "SELECT COUNT(*) FROM reviews WHERE buyer_id = ? AND purchase_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, buyerId);
            pstmt.setInt(2, purchaseId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    System.out.println("리뷰 존재 여부 확인 - buyerId: " + buyerId + ", purchaseId: " + purchaseId + ", count: " + count);
                    return count > 0;
                }
            }
            
        } catch (SQLException e) {
            System.err.println("리뷰 존재 여부 확인 중 오류: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    // 판매자별 리뷰 목록 조회 (idReview.jsp에서 사용)
    public List<Review> getReviewsBySellerId(String sellerId) {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.*, u.username as reviewer_name, p.book_id " +
                     "FROM reviews r " +
                     "JOIN users u ON r.buyer_id = u.user_id " +
                     "JOIN purchases p ON r.purchase_id = p.purchase_id " +
                     "WHERE r.seller_id = ? " +
                     "ORDER BY r.created_at DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, sellerId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Review review = new Review();
                    review.setReviewId(rs.getInt("review_id"));
                    review.setPurchaseId(rs.getInt("purchase_id"));
                    review.setBookId(rs.getInt("book_id"));  // 책 ID 설정
                    review.setBuyerId(rs.getString("buyer_id"));
                    review.setSellerId(rs.getString("seller_id"));
                    review.setRating(rs.getInt("rating"));
                    review.setContent(rs.getString("comment"));
                    review.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    review.setReviewerName(rs.getString("reviewer_name"));
                    
                    reviews.add(review);
                }
            }
            
        } catch (SQLException e) {
            System.err.println("판매자별 리뷰 조회 중 오류: " + e.getMessage());
            e.printStackTrace();
        }
        
        return reviews;
    }
    
    // 판매자의 평균 평점 계산
    public double getAverageRatingBySellerId(String sellerId) {
        String sql = "SELECT AVG(rating) as avg_rating FROM reviews WHERE seller_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, sellerId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("avg_rating");
                }
            }
            
        } catch (SQLException e) {
            System.err.println("평균 평점 계산 중 오류: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0.0;
    }
    
    // 판매자의 총 리뷰 개수 조회
    public int getReviewCountBySellerId(String sellerId) {
        String sql = "SELECT COUNT(*) as review_count FROM reviews WHERE seller_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, sellerId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("review_count");
                }
            }
            
        } catch (SQLException e) {
            System.err.println("리뷰 개수 조회 중 오류: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }
    
    // 특정 리뷰 조회
    public Review getReviewById(int reviewId) {
        String sql = "SELECT r.*, u.username as reviewer_name " +
                     "FROM reviews r " +
                     "JOIN users u ON r.buyer_id = u.user_id " +
                     "WHERE r.review_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, reviewId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Review review = new Review();
                    review.setReviewId(rs.getInt("review_id"));
                    review.setPurchaseId(rs.getInt("purchase_id"));
                    review.setBuyerId(rs.getString("buyer_id"));
                    review.setSellerId(rs.getString("seller_id"));
                    review.setRating(rs.getInt("rating"));
                    review.setContent(rs.getString("comment"));
                    review.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    review.setReviewerName(rs.getString("reviewer_name"));
                    
                    return review;
                }
            }
            
        } catch (SQLException e) {
            System.err.println("리뷰 조회 중 오류: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    // 리뷰 수정
    public boolean updateReview(Review review) {
        String sql = "UPDATE reviews SET rating = ?, comment = ? WHERE review_id = ? AND buyer_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, review.getRating());
            pstmt.setString(2, review.getContent());
            pstmt.setInt(3, review.getReviewId());
            pstmt.setString(4, review.getBuyerId());
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("리뷰 수정 중 오류: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // 리뷰 삭제
    public boolean deleteReview(int reviewId, String buyerId) {
        String sql = "DELETE FROM reviews WHERE review_id = ? AND buyer_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, reviewId);
            pstmt.setString(2, buyerId);
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("리뷰 삭제 중 오류: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // 최근 리뷰 목록 조회 (관리자용)
    public List<Review> getRecentReviews(int limit) {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.*, u.username as reviewer_name " +
                     "FROM reviews r " +
                     "JOIN users u ON r.buyer_id = u.user_id " +
                     "ORDER BY r.created_at DESC " +
                     "LIMIT ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, limit);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Review review = new Review();
                    review.setReviewId(rs.getInt("review_id"));
                    review.setPurchaseId(rs.getInt("purchase_id"));
                    review.setBuyerId(rs.getString("buyer_id"));
                    review.setSellerId(rs.getString("seller_id"));
                    review.setRating(rs.getInt("rating"));
                    review.setContent(rs.getString("comment"));
                    review.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    review.setReviewerName(rs.getString("reviewer_name"));
                    
                    reviews.add(review);
                }
            }
            
        } catch (SQLException e) {
            System.err.println("최근 리뷰 조회 중 오류: " + e.getMessage());
            e.printStackTrace();
        }
        
        return reviews;
    }
}