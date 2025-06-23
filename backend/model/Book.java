package model;

import java.time.LocalDateTime;

public class Book {
    private int bookId;
    private String title;
    private String author;
    private String publisher;
    private int price;
    private String bookCondition;   // book_condition 컬럼
    private String category;
    private String description;
    private String imagePath;       // image_path 컬럼
    private String sellerId;
    private String status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    
    // 기본 생성자
    public Book() {}
    
    // 매개변수 생성자 (8개 매개변수)
    public Book(String title, String author, String publisher, int price, 
                String bookCondition, String category, String description, String sellerId) {
        this.title = title;
        this.author = author;
        this.publisher = publisher;
        this.price = price;
        this.bookCondition = bookCondition;
        this.category = category;
        this.description = description;
        this.sellerId = sellerId;
        this.status = "판매중";
    }
    
    // Getter and Setter
    public int getBookId() {
        return bookId;
    }
    
    public void setBookId(int bookId) {
        this.bookId = bookId;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getAuthor() {
        return author;
    }
    
    public void setAuthor(String author) {
        this.author = author;
    }
    
    public String getPublisher() {
        return publisher;
    }
    
    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }
    
    public int getPrice() {
        return price;
    }
    
    public void setPrice(int price) {
        this.price = price;
    }
    
    // bookCondition getter/setter (book_condition 컬럼)
    public String getBookCondition() {
        return bookCondition;
    }
    
    public void setBookCondition(String bookCondition) {
        this.bookCondition = bookCondition;
    }
    
    public String getCategory() {
        return category;
    }
    
    public void setCategory(String category) {
        this.category = category;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    // imagePath getter/setter (image_path 컬럼)
    public String getImagePath() {
        return imagePath;
    }
    
    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
    
    public String getSellerId() {
        return sellerId;
    }
    
    public void setSellerId(String sellerId) {
        this.sellerId = sellerId;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
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
    
    // ========== 호환성을 위한 추가 메소드들 ==========
    
    // getCondition() - bookCondition의 별칭
    public String getCondition() {
        return bookCondition;
    }
    
    public void setCondition(String condition) {
        this.bookCondition = condition;
    }
    
    // getImage() - imagePath의 별칭
    public String getImage() {
        return imagePath;
    }
    
    public void setImage(String image) {
        this.imagePath = image;
    }
}