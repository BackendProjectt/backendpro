<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="dao.BookDAO" %>
<%@ page import="dao.ReviewDAO" %>
<%@ page import="model.User" %>
<%@ page import="model.Book" %>
<%@ page import="model.Review" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    // URL에서 seller 파라미터 받기 (bookdetail.jsp에서 seller= 로 넘어옴)
    String sellerId = request.getParameter("seller");
    if (sellerId == null) {
        // sellerId 파라미터도 체크 (다른 곳에서 연결될 수 있음)
        sellerId = request.getParameter("sellerId");
    }
    
    if (sellerId == null || sellerId.trim().isEmpty()) {
        response.sendRedirect("index.jsp?error=판매자 정보가 없습니다.");
        return;
    }
    
    UserDAO userDAO = new UserDAO();
    BookDAO bookDAO = new BookDAO();
    ReviewDAO reviewDAO = new ReviewDAO();
    
    User seller = null;
    List<Book> sellerBooks = null;
    List<Review> sellerReviews = null;
    String errorMessage = null;
    
    try {
        seller = userDAO.getUserById(sellerId);
        if (seller != null) {
            // 판매자의 책 목록 가져오기
            sellerBooks = bookDAO.getBooksBySellerId(sellerId);
            // 판매자에 대한 리뷰 목록 가져오기
            sellerReviews = reviewDAO.getReviewsBySellerId(sellerId);
        }
    } catch (Exception e) {
        e.printStackTrace();
        errorMessage = "데이터를 불러오는 중 오류가 발생했습니다: " + e.getMessage();
    }
    
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    
    String currentUserId = (String) session.getAttribute("userId");
    String username = (String) session.getAttribute("username");
    boolean isLoggedIn = (currentUserId != null);
    
    // 평균 평점 계산
    double averageRating = 0.0;
    if (sellerReviews != null && !sellerReviews.isEmpty()) {
        int totalRating = 0;
        for (Review review : sellerReviews) {
            totalRating += review.getRating();
        }
        averageRating = (double) totalRating / sellerReviews.size();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= seller != null ? seller.getUsername() + "님의 리뷰" : "판매자 리뷰" %> - ReRead</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        body {
            font-family: 'Noto Sans KR', Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: #f6f8fa;
        }
        
        .top-navbar {
            background: rgba(25, 118, 210, 0.92);
            color: white;
            position: fixed;
            left: 0;
            top: 0;
            width: 100vw;
            z-index: 100;
            box-shadow: 0 2px 12px rgba(25, 118, 210, 0.08);
            backdrop-filter: blur(6px);
        }
        
        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 24px;
            height: 62px;
        }
        
        .nav-left .logo {
            font-size: 26px;
            font-weight: 900;
            letter-spacing: 1px;
            color: #fff;
            text-shadow: 0 2px 8px rgba(25,118,210,0.16);
        }
        
        .nav-right a {
            color: #fff;
            margin-left: 28px;
            text-decoration: none;
            font-size: 16px;
            font-weight: 500;
            position: relative;
            transition: color 0.18s;
        }
        
        .nav-right a::after {
            content: "";
            display: block;
            width: 0%;
            height: 2px;
            background: #ffd600;
            transition: width 0.18s;
            position: absolute;
            bottom: -2px;
            left: 0;
        }
        
        .nav-right a:hover {
            color: #ffd600;
        }
        
        .nav-right a:hover::after {
            width: 100%;
        }
        
        .page-content {
            margin-top: 80px;
            padding: 20px;
        }
        
        .header {
            text-align: center;
            font-size: 36px;
            font-weight: 900;
            margin: 40px 0;
            color: #1976d2;
            letter-spacing: 2px;
        }
        
        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 4px 24px rgba(30, 144, 255, 0.13);
            padding: 30px;
            margin-bottom: 30px;
            transition: box-shadow 0.18s;
        }
        
        .card:hover {
            box-shadow: 0 8px 32px rgba(25,118,210,0.17);
        }
        
        .user-title {
            font-size: 24px;
            font-weight: 700;
            color: #1976d2;
            margin-bottom: 20px;
            text-align: center;
            border-bottom: 2px solid #1976d2;
            padding-bottom: 15px;
        }
        
        .user-info {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 25px;
            border: 1px solid #e3eaf3;
        }
        
        .user-date {
            font-size: 16px;
            color: #555;
            margin: 8px 0;
            font-weight: 500;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 20px;
            margin: 20px 0;
        }
        
        .stat-card {
            background: linear-gradient(135deg, #e3f2fd 0%, #f3e5f5 100%);
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            border: 1px solid #e3eaf3;
        }
        
        .stat-number {
            font-size: 24px;
            font-weight: 700;
            color: #1976d2;
            margin-bottom: 5px;
        }
        
        .stat-label {
            font-size: 14px;
            color: #666;
        }
        
        .rating-display {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            margin: 10px 0;
        }
        
        .stars {
            color: #ffd700;
            font-size: 20px;
            letter-spacing: 2px;
        }
        
        .rating-number {
            font-size: 18px;
            font-weight: 600;
            color: #1976d2;
        }
        
        .reviews-section {
            margin-top: 30px;
        }
        
        .section-title {
            font-size: 20px;
            font-weight: 600;
            color: #333;
            margin-bottom: 20px;
            border-left: 4px solid #1976d2;
            padding-left: 12px;
        }
        
        .review-item {
            background: #f8f9fa;
            border: 1px solid #e3eaf3;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            transition: all 0.18s;
        }
        
        .review-item:hover {
            box-shadow: 0 4px 16px rgba(25,118,210,0.12);
            transform: translateY(-2px);
        }
        
        .review-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
            border-bottom: 1px solid #e0e0e0;
            padding-bottom: 8px;
        }
        
        .reviewer-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .reviewer-name {
            font-weight: 600;
            color: #333;
            font-size: 16px;
        }
        
        .review-rating {
            color: #ffd700;
            font-size: 16px;
            letter-spacing: 1px;
        }
        
        .review-date {
            font-size: 12px;
            color: #999;
        }
        
        .review-content {
            margin: 12px 0;
            line-height: 1.6;
            color: #333;
            font-size: 15px;
        }
        
        .book-info-in-review {
            font-size: 13px;
            color: #666;
            background: #fff;
            padding: 8px 12px;
            border-radius: 6px;
            border: 1px solid #ddd;
            margin-top: 8px;
            display: inline-block;
        }
        
        .no-reviews {
            text-align: center;
            color: #666;
            font-style: italic;
            padding: 60px;
            background: #f8f9fa;
            border-radius: 12px;
            margin: 20px 0;
        }
        
        .error-message {
            background: #f8d7da;
            color: #721c24;
            padding: 16px;
            border-radius: 8px;
            margin: 20px 0;
            border: 1px solid #f5c6cb;
            text-align: center;
        }
        
        .back-btn {
            text-align: center;
            margin: 30px 0;
        }
        
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            margin: 0 8px;
            transition: all 0.18s;
            background: #6c757d;
            color: white;
        }
        
        .btn:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }
        
        .btn-primary {
            background: #1976d2;
        }
        
        .btn-primary:hover {
            background: #1565c0;
        }
        
        @media (max-width: 800px) {
            .main-container {
                flex-direction: column;
                height: auto;
                padding: 10px;
            }
            
            .nav-right {
                margin-top: 8px;
            }
            
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 15px;
            }
            
            .review-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 8px;
            }
        }
    </style>
</head>
<body>
    <div class="top-navbar">
        <div class="main-container">
            <div class="nav-left">
                <a href="index.jsp" class="logo" style="text-decoration:none; color:inherit;">📚 ReRead</a>
            </div>
            <div class="nav-right">
                <% if (isLoggedIn) { %>
                    <span style="margin-right: 10px;">안녕하세요, <%= username %>님!</span>
                    <a href="logout">로그아웃</a>
                <% } else { %>
                    <a href="login.jsp">로그인</a>
                    <a href="signup.jsp">회원가입</a>
                <% } %>
                <a href="mypage.jsp">마이페이지</a>
                <a href="cart.jsp">장바구니</a>
                <a href="bookRegister.jsp">책 등록</a>
                <a href="bookReview.jsp">리뷰 등록</a>
            </div>
        </div>
    </div>

    <div class="page-content">
        <div class="header">⭐ 판매자 리뷰</div>

        <div class="container">
            <% if (errorMessage != null) { %>
                <div class="error-message">
                    <%= errorMessage %>
                </div>
            <% } %>
            
            <% if (seller != null) { %>
                <!-- 판매자 정보 -->
                <div class="card">
                    <div class="user-title">⭐ <%= seller.getUsername() %>님의 상점</div>
                    <div class="user-info">
                        <div class="user-date">📅 가입일: <%= seller.getJoinDate().format(dateFormatter) %></div>
                        <div class="user-date">🆔 판매자 ID: <%= seller.getUserId() %></div>
                    </div>
                    
                    <!-- 통계 정보 -->
                    <div class="stats-grid">
                        <div class="stat-card">
                            <div class="stat-number"><%= sellerBooks != null ? sellerBooks.size() : 0 %></div>
                            <div class="stat-label">등록된 책</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number"><%= sellerReviews != null ? sellerReviews.size() : 0 %></div>
                            <div class="stat-label">받은 리뷰</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number"><%= String.format("%.1f", averageRating) %></div>
                            <div class="stat-label">평균 평점</div>
                            <div class="rating-display">
                                <span class="stars">
                                    <% 
                                    int fullStars = (int) averageRating;
                                    for (int i = 0; i < 5; i++) {
                                        if (i < fullStars) {
                                            out.print("★");
                                        } else {
                                            out.print("☆");
                                        }
                                    }
                                    %>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- 리뷰 목록 -->
                <div class="card">
                    <div class="reviews-section">
                        <div class="section-title">📝 구매자 리뷰</div>
                        
                        <% if (sellerReviews != null && !sellerReviews.isEmpty()) { %>
                            <% for (Review review : sellerReviews) { 
                                // 책 정보 가져오기
                                Book reviewedBook = null;
                                try {
                                    reviewedBook = bookDAO.getBookById(review.getBookId());
                                } catch (Exception e) {
                                    // 책 정보 조회 실패시 무시
                                }
                            %>
                                <div class="review-item">
                                    <div class="review-header">
                                        <div class="reviewer-info">
                                            <span class="reviewer-name"><%= review.getReviewerName() %></span>
                                            <span class="review-rating">
                                                <% 
                                                for (int i = 0; i < 5; i++) {
                                                    if (i < review.getRating()) {
                                                        out.print("★");
                                                    } else {
                                                        out.print("☆");
                                                    }
                                                }
                                                %>
                                                (<%= review.getRating() %>/5)
                                            </span>
                                        </div>
                                        <span class="review-date">
                                            <%= review.getCreatedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) %>
                                        </span>
                                    </div>
                                    
                                    <div class="review-content">
                                        <%= review.getContent().replace("\n", "<br>") %>
                                    </div>
                                    
                                    <!-- 책 정보 표시 -->
                                    <div class="book-info-in-review">
                                        📚 구매한 책: 
                                        <% if (reviewedBook != null) { %>
                                            <%= reviewedBook.getTitle() %> (ID: <%= review.getBookId() %>)
                                        <% } else { %>
                                            책 ID <%= review.getBookId() %>
                                        <% } %>
                                    </div>
                                </div>
                            <% } %>
                        <% } else { %>
                            <div class="no-reviews">
                                <h3>📝 아직 리뷰가 없습니다</h3>
                                <p>이 판매자에 대한 구매자 리뷰가 아직 없습니다.</p>
                                <p>첫 번째 리뷰를 남겨보세요!</p>
                            </div>
                        <% } %>
                    </div>
                </div>
            <% } else { %>
                <div class="card">
                    <div class="error-message">
                        <h3>😔 판매자 정보를 찾을 수 없습니다</h3>
                        <p>요청된 판매자 ID: <strong><%= sellerId %></strong></p>
                        <p>존재하지 않는 판매자이거나 잘못된 ID입니다.</p>
                    </div>
                </div>
            <% } %>
            
            <div class="back-btn">
                <a href="javascript:history.back()" class="btn">이전 페이지로</a>
                <a href="index.jsp" class="btn btn-primary">메인으로</a>
            </div>
        </div>
    </div>
</body>
</html>