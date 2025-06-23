package model;

import java.time.LocalDateTime;

public class Review {
    private int reviewId;
    private int purchaseId;    // 구매 ID (기존 bookId 대신)
    private int bookId;        // 책 ID도 함께 보관
    private String buyerId;
    private String sellerId;
    private int rating;
    private String content;
    private LocalDateTime createdAt;
    private String reviewerName; // JOIN으로 가져올 구매자 이름
    
    // 기본 생성자
    public Review() {}
    
    // 리뷰 생성시 사용하는 생성자 (purchaseId 기준) - 메인 생성자
    public Review(int purchaseId, String sellerId, String buyerId, int rating, String content) {
        this.purchaseId = purchaseId;
        this.sellerId = sellerId;
        this.buyerId = buyerId;
        this.rating = rating;
        this.content = content;
    }
    
    // 완전한 생성자 (모든 필드 포함)
    public Review(int reviewId, int purchaseId, int bookId, String buyerId, String sellerId, 
                  int rating, String content, LocalDateTime createdAt, String reviewerName) {
        this.reviewId = reviewId;
        this.purchaseId = purchaseId;
        this.bookId = bookId;
        this.buyerId = buyerId;
        this.sellerId = sellerId;
        this.rating = rating;
        this.content = content;
        this.createdAt = createdAt;
        this.reviewerName = reviewerName;
    }
    
    // Getter 메소드들
    public int getReviewId() {
        return reviewId;
    }
    
    public int getPurchaseId() {
        return purchaseId;
    }
    
    public int getBookId() {
        return bookId;
    }
    
    public String getBuyerId() {
        return buyerId;
    }
    
    public String getSellerId() {
        return sellerId;
    }
    
    public int getRating() {
        return rating;
    }
    
    public String getContent() {
        return content;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public String getReviewerName() {
        return reviewerName;
    }
    
    // Setter 메소드들
    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }
    
    public void setPurchaseId(int purchaseId) {
        this.purchaseId = purchaseId;
    }
    
    public void setBookId(int bookId) {
        this.bookId = bookId;
    }
    
    public void setBuyerId(String buyerId) {
        this.buyerId = buyerId;
    }
    
    public void setSellerId(String sellerId) {
        this.sellerId = sellerId;
    }
    
    public void setRating(int rating) {
        this.rating = rating;
    }
    
    public void setContent(String content) {
        this.content = content;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public void setReviewerName(String reviewerName) {
        this.reviewerName = reviewerName;
    }
    
    // 별점을 별 모양으로 변환하는 헬퍼 메소드
    public String getStarRating() {
        StringBuilder stars = new StringBuilder();
        for (int i = 1; i <= 5; i++) {
            if (i <= rating) {
                stars.append("⭐");
            } else {
                stars.append("☆");
            }
        }
        return stars.toString();
    }
    
    // 평점 텍스트 반환
    public String getRatingText() {
        switch (rating) {
            case 1: return "별로예요";
            case 2: return "그저 그래요";
            case 3: return "보통이에요";
            case 4: return "좋아요";
            case 5: return "최고예요";
            default: return "평점 없음";
        }
    }
    
    // 리뷰 내용 요약 (긴 내용일 때)
    public String getContentSummary(int maxLength) {
        if (content == null || content.length() <= maxLength) {
            return content;
        }
        return content.substring(0, maxLength) + "...";
    }
    
    @Override
    public String toString() {
        return "Review{" +
                "reviewId=" + reviewId +
                ", purchaseId=" + purchaseId +
                ", bookId=" + bookId +
                ", buyerId='" + buyerId + '\'' +
                ", sellerId='" + sellerId + '\'' +
                ", rating=" + rating +
                ", content='" + content + '\'' +
                ", createdAt=" + createdAt +
                ", reviewerName='" + reviewerName + '\'' +
                '}';
    }
}