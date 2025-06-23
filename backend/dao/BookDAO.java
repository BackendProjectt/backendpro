// src/main/java/dao/BookDAO.java
package dao;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import model.Book;
import util.DBUtil;

public class BookDAO {
    
    // 책 추가
    public boolean addBook(Book book) {
        String sql = "INSERT INTO books (title, author, publisher, price, book_condition, category, description, seller_id, image_path, status, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, '판매중', NOW())";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, book.getTitle());
            pstmt.setString(2, book.getAuthor());
            pstmt.setString(3, book.getPublisher());
            pstmt.setInt(4, book.getPrice());
            pstmt.setString(5, book.getBookCondition());
            pstmt.setString(6, book.getCategory());
            pstmt.setString(7, book.getDescription());
            pstmt.setString(8, book.getSellerId());
            pstmt.setString(9, book.getImagePath());
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 모든 책 조회
    public List<Book> getAllBooks() {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books WHERE status = '판매중' ORDER BY created_at DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setPublisher(rs.getString("publisher"));
                book.setPrice(rs.getInt("price"));
                book.setBookCondition(rs.getString("book_condition"));
                book.setCategory(rs.getString("category"));
                book.setDescription(rs.getString("description"));
                book.setSellerId(rs.getString("seller_id"));
                book.setImagePath(rs.getString("image_path"));
                book.setStatus(rs.getString("status"));
                
                Timestamp timestamp = rs.getTimestamp("created_at");
                if (timestamp != null) {
                    book.setCreatedAt(timestamp.toLocalDateTime());
                }
                
                timestamp = rs.getTimestamp("updated_at");
                if (timestamp != null) {
                    book.setUpdatedAt(timestamp.toLocalDateTime());
                }
                
                books.add(book);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
    
    // 특정 책 조회
    public Book getBookById(int bookId) {
        String sql = "SELECT * FROM books WHERE book_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, bookId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setPublisher(rs.getString("publisher"));
                book.setPrice(rs.getInt("price"));
                book.setBookCondition(rs.getString("book_condition"));
                book.setCategory(rs.getString("category"));
                book.setDescription(rs.getString("description"));
                book.setSellerId(rs.getString("seller_id"));
                book.setImagePath(rs.getString("image_path"));
                book.setStatus(rs.getString("status"));
                
                Timestamp timestamp = rs.getTimestamp("created_at");
                if (timestamp != null) {
                    book.setCreatedAt(timestamp.toLocalDateTime());
                }
                
                timestamp = rs.getTimestamp("updated_at");
                if (timestamp != null) {
                    book.setUpdatedAt(timestamp.toLocalDateTime());
                }
                
                return book;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // 판매자별 책 목록 조회
    public List<Book> getBooksBySellerId(String sellerId) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books WHERE seller_id = ? ORDER BY created_at DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, sellerId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setPublisher(rs.getString("publisher"));
                book.setPrice(rs.getInt("price"));
                book.setBookCondition(rs.getString("book_condition"));
                book.setCategory(rs.getString("category"));
                book.setDescription(rs.getString("description"));
                book.setSellerId(rs.getString("seller_id"));
                book.setImagePath(rs.getString("image_path"));
                book.setStatus(rs.getString("status"));
                
                Timestamp timestamp = rs.getTimestamp("created_at");
                if (timestamp != null) {
                    book.setCreatedAt(timestamp.toLocalDateTime());
                }
                
                timestamp = rs.getTimestamp("updated_at");
                if (timestamp != null) {
                    book.setUpdatedAt(timestamp.toLocalDateTime());
                }
                
                books.add(book);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
    
    // 책 수정
    public boolean updateBook(Book book) {
        String sql = "UPDATE books SET title=?, author=?, publisher=?, price=?, book_condition=?, category=?, description=?, image_path=?, updated_at=NOW() WHERE book_id=? AND seller_id=?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, book.getTitle());
            pstmt.setString(2, book.getAuthor());
            pstmt.setString(3, book.getPublisher());
            pstmt.setInt(4, book.getPrice());
            pstmt.setString(5, book.getBookCondition());
            pstmt.setString(6, book.getCategory());
            pstmt.setString(7, book.getDescription());
            pstmt.setString(8, book.getImagePath());
            pstmt.setInt(9, book.getBookId());
            pstmt.setString(10, book.getSellerId());
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 책 삭제
    public boolean deleteBook(int bookId, String sellerId) {
        String sql = "DELETE FROM books WHERE book_id = ? AND seller_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, bookId);
            pstmt.setString(2, sellerId);
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 책 상태 변경 (판매중 -> 판매완료)
    public boolean updateBookStatus(int bookId, String status) {
        String sql = "UPDATE books SET status = ?, updated_at = NOW() WHERE book_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, status);
            pstmt.setInt(2, bookId);
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 검색 기능
    public List<Book> searchBooks(String keyword) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books WHERE (title LIKE ? OR author LIKE ? OR publisher LIKE ?) AND status = '판매중' ORDER BY created_at DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            String searchKeyword = "%" + keyword + "%";
            pstmt.setString(1, searchKeyword);
            pstmt.setString(2, searchKeyword);
            pstmt.setString(3, searchKeyword);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setPublisher(rs.getString("publisher"));
                book.setPrice(rs.getInt("price"));
                book.setBookCondition(rs.getString("book_condition"));
                book.setCategory(rs.getString("category"));
                book.setDescription(rs.getString("description"));
                book.setSellerId(rs.getString("seller_id"));
                book.setImagePath(rs.getString("image_path"));
                book.setStatus(rs.getString("status"));
                
                Timestamp timestamp = rs.getTimestamp("created_at");
                if (timestamp != null) {
                    book.setCreatedAt(timestamp.toLocalDateTime());
                }
                
                timestamp = rs.getTimestamp("updated_at");
                if (timestamp != null) {
                    book.setUpdatedAt(timestamp.toLocalDateTime());
                }
                
                books.add(book);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
    
    // 카테고리별 검색
    public List<Book> searchBooksByCategory(String category) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books WHERE category = ? AND status = '판매중' ORDER BY created_at DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, category);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setPublisher(rs.getString("publisher"));
                book.setPrice(rs.getInt("price"));
                book.setBookCondition(rs.getString("book_condition"));
                book.setCategory(rs.getString("category"));
                book.setDescription(rs.getString("description"));
                book.setSellerId(rs.getString("seller_id"));
                book.setImagePath(rs.getString("image_path"));
                book.setStatus(rs.getString("status"));
                
                Timestamp timestamp = rs.getTimestamp("created_at");
                if (timestamp != null) {
                    book.setCreatedAt(timestamp.toLocalDateTime());
                }
                
                timestamp = rs.getTimestamp("updated_at");
                if (timestamp != null) {
                    book.setUpdatedAt(timestamp.toLocalDateTime());
                }
                
                books.add(book);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
    
    // 가격 범위 검색
    public List<Book> searchBooksByPriceRange(int minPrice, int maxPrice) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books WHERE price BETWEEN ? AND ? AND status = '판매중' ORDER BY price ASC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, minPrice);
            pstmt.setInt(2, maxPrice);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setPublisher(rs.getString("publisher"));
                book.setPrice(rs.getInt("price"));
                book.setBookCondition(rs.getString("book_condition"));
                book.setCategory(rs.getString("category"));
                book.setDescription(rs.getString("description"));
                book.setSellerId(rs.getString("seller_id"));
                book.setImagePath(rs.getString("image_path"));
                book.setStatus(rs.getString("status"));
                
                Timestamp timestamp = rs.getTimestamp("created_at");
                if (timestamp != null) {
                    book.setCreatedAt(timestamp.toLocalDateTime());
                }
                
                timestamp = rs.getTimestamp("updated_at");
                if (timestamp != null) {
                    book.setUpdatedAt(timestamp.toLocalDateTime());
                }
                
                books.add(book);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
    
    // 책 개수 조회
    public int getTotalBookCount() {
        String sql = "SELECT COUNT(*) FROM books WHERE status = '판매중'";
        
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
    
    // 카테고리별 책 개수 조회
    public int getBookCountByCategory(String category) {
        String sql = "SELECT COUNT(*) FROM books WHERE category = ? AND status = '판매중'";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, category);
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