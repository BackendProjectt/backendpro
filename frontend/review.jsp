<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*, model.*, java.util.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    
    String userId = (String) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // purchaseId 파라미터 받기
    String purchaseIdStr = request.getParameter("purchaseId");
    String bookIdStr = request.getParameter("bookId");
    String sellerId = request.getParameter("sellerId");
    
    if (purchaseIdStr == null || purchaseIdStr.trim().isEmpty()) {
        out.println("<script>alert('잘못된 접근입니다.'); window.close();</script>");
        return;
    }
    
    int purchaseId = 0;
    int bookId = 0;
    try {
        purchaseId = Integer.parseInt(purchaseIdStr);
        if (bookIdStr != null && !bookIdStr.trim().isEmpty()) {
            bookId = Integer.parseInt(bookIdStr);
        }
    } catch (NumberFormatException e) {
        out.println("<script>alert('잘못된 구매 정보입니다.'); window.close();</script>");
        return;
    }
    
    // 구매 정보 가져오기
    PurchaseDAO purchaseDAO = new PurchaseDAO();
    Purchase purchase = purchaseDAO.getPurchaseById(purchaseId);
    
    if (purchase == null || !purchase.getBuyerId().equals(userId)) {
        out.println("<script>alert('구매 정보를 찾을 수 없습니다.'); window.close();</script>");
        return;
    }
    
    // 책 정보 가져오기
    BookDAO bookDAO = new BookDAO();
    Book book = bookDAO.getBookById(purchase.getBookId());
    
    if (book == null) {
        out.println("<script>alert('책 정보를 찾을 수 없습니다.'); window.close();</script>");
        return;
    }
    
    // 이미 리뷰를 작성했는지 확인
    ReviewDAO reviewDAO = new ReviewDAO();
    boolean hasReview = reviewDAO.hasReview(userId, purchaseId);
    
    if (hasReview) {
        out.println("<script>alert('이미 리뷰를 작성하셨습니다.'); window.close();</script>");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 작성 - ReRead</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        :root {
            --main-blue: #1976d2;
            --light-blue: #e3f0fb;
            --success-green: #4caf50;
            --warning-orange: #ff9800;
            --error-red: #f44336;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, var(--light-blue) 0%, #f8fbff 100%);
            padding: 20px;
            line-height: 1.6;
        }
        
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(25, 118, 210, 0.1);
            overflow: hidden;
        }
        
        .header {
            background: linear-gradient(135deg, var(--main-blue), #1565c0);
            color: white;
            padding: 25px;
            text-align: center;
        }
        
        .header h1 {
            font-size: 24px;
            margin-bottom: 8px;
        }
        
        .header p {
            opacity: 0.9;
            font-size: 14px;
        }
        
        .book-info {
            padding: 25px;
            border-bottom: 1px solid #e0e0e0;
            background: #fafafa;
        }
        
        .book-card {
            display: flex;
            gap: 20px;
            align-items: center;
        }
        
        .book-image {
            width: 80px;
            height: 100px;
            border-radius: 8px;
            object-fit: cover;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        
        .book-details h3 {
            color: #333;
            margin-bottom: 8px;
            font-size: 18px;
        }
        
        .book-meta {
            color: #666;
            font-size: 14px;
            margin-bottom: 4px;
        }
        
        .purchase-info {
            display: inline-block;
            background: var(--light-blue);
            color: var(--main-blue);
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            margin-top: 8px;
        }
        
        .form-container {
            padding: 30px;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 10px;
            font-weight: 600;
            color: #333;
            font-size: 16px;
        }
        
        .rating-container {
            display: flex;
            gap: 8px;
            align-items: center;
            margin-bottom: 10px;
        }
        
        .star {
            font-size: 30px;
            color: #ddd;
            cursor: pointer;
            transition: all 0.2s ease;
            user-select: none;
        }
        
        .star:hover {
            color: #ffeb3b;
            transform: scale(1.1);
        }
        
        .star.active {
            color: #ffd700;
            transform: scale(1.05);
        }
        
        .star.inactive {
            color: #e0e0e0;
        }
        
        .rating-text {
            margin-left: 15px;
            font-size: 14px;
            color: #666;
            font-weight: 500;
        }
        
        textarea {
            width: 100%;
            min-height: 120px;
            padding: 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 14px;
            font-family: inherit;
            resize: vertical;
            transition: all 0.3s ease;
        }
        
        textarea:focus {
            outline: none;
            border-color: var(--main-blue);
            box-shadow: 0 0 0 3px rgba(25, 118, 210, 0.1);
        }
        
        .char-count {
            text-align: right;
            font-size: 12px;
            color: #999;
            margin-top: 5px;
        }
        
        .button-group {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 30px;
        }
        
        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--main-blue), #1565c0);
            color: white;
            box-shadow: 0 4px 15px rgba(25, 118, 210, 0.3);
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 118, 210, 0.4);
        }
        
        .btn-secondary {
            background: #f5f5f5;
            color: #666;
        }
        
        .btn-secondary:hover {
            background: #e0e0e0;
        }
        
        .required {
            color: var(--error-red);
        }
        
        .error-message {
            color: var(--error-red);
            font-size: 12px;
            margin-top: 5px;
            display: none;
        }
        
        @media (max-width: 600px) {
            .book-card {
                flex-direction: column;
                text-align: center;
            }
            
            .button-group {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📝 리뷰 작성</h1>
            <p>구매하신 책에 대한 소중한 리뷰를 남겨주세요</p>
        </div>
        
        <div class="book-info">
            <div class="book-card">
                <img src="<%= book.getImagePath() != null ? book.getImagePath() : "image/book1.jpg" %>" 
                     alt="<%= book.getTitle() %>" 
                     class="book-image"
                     onerror="this.src='image/book1.jpg';">
                
                <div class="book-details">
                    <h3><%= book.getTitle() %></h3>
                    <div class="book-meta">저자: <%= book.getAuthor() %></div>
                    <div class="book-meta">출판사: <%= book.getPublisher() %></div>
                    <div class="book-meta">판매자: <%= book.getSellerId() %></div>
                    <div class="purchase-info">
                        ₩<%= String.format("%,d", purchase.getPrice()) %> 구매
                    </div>
                </div>
            </div>
        </div>
        
        <div class="form-container">
            <form action="reviewProcess" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="purchaseId" value="<%= purchaseId %>">
                <input type="hidden" name="bookId" value="<%= book.getBookId() %>">
                <input type="hidden" name="sellerId" value="<%= book.getSellerId() %>">
                
                <div class="form-group">
                    <label for="rating">평점 <span class="required">*</span></label>
                    <div class="rating-container">
                        <span class="star inactive" data-rating="1">★</span>
                        <span class="star inactive" data-rating="2">★</span>
                        <span class="star inactive" data-rating="3">★</span>
                        <span class="star inactive" data-rating="4">★</span>
                        <span class="star inactive" data-rating="5">★</span>
                        <span class="rating-text">별점을 선택해주세요</span>
                    </div>
                    <input type="hidden" name="rating" id="rating" value="0">
                    <div class="error-message" id="rating-error">평점을 선택해주세요.</div>
                </div>
                
                <div class="form-group">
                    <label for="content">리뷰 내용 <span class="required">*</span></label>
                    <textarea name="content" 
                              id="content" 
                              placeholder="책에 대한 솔직한 후기를 남겨주세요. 다른 구매자들에게 도움이 되는 리뷰를 작성해주시면 감사하겠습니다." 
                              maxlength="500"
                              oninput="updateCharCount()"></textarea>
                    <div class="char-count">
                        <span id="char-count">0</span>/500자
                    </div>
                    <div class="error-message" id="content-error">리뷰 내용을 입력해주세요. (최소 2자 이상)</div>
                </div>
                
                <div class="button-group">
                    <button type="submit" class="btn btn-primary">
                        ✍️ 리뷰 등록
                    </button>
                    <button type="button" class="btn btn-secondary" onclick="window.close()">
                        ❌ 취소
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        let selectedRating = 0;
        
        // 별점 기능
        document.querySelectorAll('.star').forEach(star => {
            star.addEventListener('click', function() {
                selectedRating = parseInt(this.getAttribute('data-rating'));
                document.getElementById('rating').value = selectedRating;
                updateStars();
                updateRatingText();
                hideError('rating-error');
            });
            
            star.addEventListener('mouseover', function() {
                const rating = parseInt(this.getAttribute('data-rating'));
                highlightStars(rating);
            });
        });
        
        document.querySelector('.rating-container').addEventListener('mouseleave', function() {
            updateStars();
        });
        
        function highlightStars(rating) {
            document.querySelectorAll('.star').forEach((star, index) => {
                star.classList.remove('active', 'inactive');
                if (index < rating) {
                    star.classList.add('active');
                } else {
                    star.classList.add('inactive');
                }
            });
        }
        
        function updateStars() {
            highlightStars(selectedRating);
        }
        
        function updateRatingText() {
            const ratingTexts = {
                1: "😞 별로예요",
                2: "😐 그저 그래요", 
                3: "😊 보통이에요",
                4: "😄 좋아요",
                5: "🥰 최고예요!"
            };
            
            const ratingText = document.querySelector('.rating-text');
            if (selectedRating > 0) {
                ratingText.textContent = ratingTexts[selectedRating];
                ratingText.style.color = '#ffd700';
                ratingText.style.fontWeight = 'bold';
            } else {
                ratingText.textContent = "별점을 선택해주세요";
                ratingText.style.color = '#666';
                ratingText.style.fontWeight = '500';
            }
        }
        
        // 글자 수 카운트
        function updateCharCount() {
            const content = document.getElementById('content').value;
            const charCount = document.getElementById('char-count');
            charCount.textContent = content.length;
            
            if (content.length >= 2) {
                hideError('content-error');
            }
        }
        
        // 폼 유효성 검사
        function validateForm() {
            let isValid = true;
            
            // 평점 검사
            if (selectedRating === 0) {
                showError('rating-error');
                isValid = false;
            }
            
            // 리뷰 내용 검사
            const content = document.getElementById('content').value.trim();
            if (content.length < 2) {
                showError('content-error');
                isValid = false;
            }
            
            return isValid;
        }
        
        function showError(errorId) {
            document.getElementById(errorId).style.display = 'block';
        }
        
        function hideError(errorId) {
            document.getElementById(errorId).style.display = 'none';
        }
    </script>
</body>
</html>