package model;

import java.time.LocalDateTime;
import java.util.Date;

public class Purchase {
    private int purchaseId;
    private int bookId;
    private String buyerId;
    private String sellerId;
    private int price;
    private Date purchaseDate;
    private LocalDateTime purchaseDateTime;
    private String status;
    
    // 책 정보 추가 (JOIN용)
    private String bookTitle;
    private String bookAuthor;
    private String bookPublisher;
    private String bookImagePath;

    // 기본 생성자
    public Purchase() {}

    // 생성자
    public Purchase(int bookId, String buyerId, String sellerId, int price) {
        this.bookId = bookId;
        this.buyerId = buyerId;
        this.sellerId = sellerId;
        this.price = price;
        this.status = "구매완료";
    }

    // Getter와 Setter
    public int getPurchaseId() { 
        return purchaseId; 
    }
    
    public void setPurchaseId(int purchaseId) { 
        this.purchaseId = purchaseId; 
    }

    public int getBookId() { 
        return bookId; 
    }
    
    public void setBookId(int bookId) { 
        this.bookId = bookId; 
    }

    public String getBuyerId() { 
        return buyerId; 
    }
    
    public void setBuyerId(String buyerId) { 
        this.buyerId = buyerId; 
    }

    public String getSellerId() { 
        return sellerId; 
    }
    
    public void setSellerId(String sellerId) { 
        this.sellerId = sellerId; 
    }

    public int getPrice() { 
        return price; 
    }
    
    public void setPrice(int price) { 
        this.price = price; 
    }

    public Date getPurchaseDate() { 
        return purchaseDate; 
    }
    
    public void setPurchaseDate(Date purchaseDate) { 
        this.purchaseDate = purchaseDate; 
    }
    
    public LocalDateTime getPurchaseDateTime() {
        return purchaseDateTime;
    }
    
    public void setPurchaseDateTime(LocalDateTime purchaseDateTime) {
        this.purchaseDateTime = purchaseDateTime;
    }

    public String getStatus() { 
        return status; 
    }
    
    public void setStatus(String status) { 
        this.status = status; 
    }
    
    // 책 정보 Getter/Setter
    public String getBookTitle() {
        return bookTitle;
    }
    
    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }
    
    public String getBookAuthor() {
        return bookAuthor;
    }
    
    public void setBookAuthor(String bookAuthor) {
        this.bookAuthor = bookAuthor;
    }
    
    public String getBookPublisher() {
        return bookPublisher;
    }
    
    public void setBookPublisher(String bookPublisher) {
        this.bookPublisher = bookPublisher;
    }
    
    public String getBookImagePath() {
        return bookImagePath;
    }
    
    public void setBookImagePath(String bookImagePath) {
        this.bookImagePath = bookImagePath;
    }
}