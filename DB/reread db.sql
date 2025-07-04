CREATE DATABASE IF NOT EXISTS reread_db CHARACTER SET utf8mb4 COLLATE UTF8MB4_UNICODE_CI;
USE reread_db;


-- 1. 사용자 테이블
CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    join_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 2. 책 테이블
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL,
    publisher VARCHAR(100) NOT NULL,
    price INT NOT NULL,
    description TEXT,
    book_condition ENUM('상', '중', '하') NOT NULL,
    category ENUM('소설', '문학', 'IT', '과학', '종교', '경제', '만화') NOT NULL,
    image_path VARCHAR(255),
    seller_id VARCHAR(50) NOT NULL,
    status ENUM('판매중', '판매완료', '삭제됨') DEFAULT '판매중',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (seller_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 3. 게시글 테이블
CREATE TABLE posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    category ENUM('자유', '질문') NOT NULL,
    author_id VARCHAR(50) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (author_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 4. 댓글 테이블
CREATE TABLE comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    author_id VARCHAR(50) NOT NULL,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 5. 구매 내역 테이블
CREATE TABLE purchases (
    purchase_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    buyer_id VARCHAR(50) NOT NULL,
    seller_id VARCHAR(50) NOT NULL,
    price INT NOT NULL,
    purchase_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('구매완료', '취소됨') DEFAULT '구매완료',
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (buyer_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (seller_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 6. 리뷰 테이블
CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    purchase_id INT NOT NULL,
    seller_id VARCHAR(50) NOT NULL,
    buyer_id VARCHAR(50) NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (purchase_id) REFERENCES purchases(purchase_id) ON DELETE CASCADE,
    FOREIGN KEY (seller_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (buyer_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 7. 장바구니 테이블
CREATE TABLE cart (
    cart_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL,
    book_id INT NOT NULL,
    added_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_book (user_id, book_id)
);

-- 테스트 데이터 삽입
INSERT INTO users (user_id, username, password, email) VALUES 
('hong123', '홍길동', 'password123', 'hong@example.com'),
('kim456', '김철수', 'password456', 'kim@example.com'),
('lee789', '이영희', 'password789', 'lee@example.com');

INSERT INTO books (title, author, publisher, price, description, book_condition, category, seller_id) VALUES 
('글쓰기 생각쓰기', '윌리엄 진서', '돌베개', 19000, '글쓰기의 기본을 다룬 고전 쉽고 알차게 구성한 글쓰기 안내서', '상', '문학', 'hong123'),
('1퍼센트 부자들의 법칙', '송희연', '예문', 13500, '부자가 되는 법칙을 알려주는 책', '중', '경제', 'kim456'),
('Spring Boot 완전정복', '김스프링', 'IT출판사', 25000, 'Spring Boot의 모든 것', '상', 'IT', 'lee789');

INSERT INTO posts (title, content, category, author_id) VALUES 
('ReRead 서비스에 대해', 'ReRead 서비스 정말 좋네요!', '자유', 'hong123'),
('책 추천 부탁드립니다!', '프로그래밍 관련 책 추천해주세요', '질문', 'kim456'),
('Spring 질문있습니다', 'Spring Boot 설정 관련 질문드립니다', '질문', 'lee789');
ALTER TABLE posts MODIFY COLUMN category VARCHAR(20);
COMMIT;