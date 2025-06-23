<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Book" %>
<%
    // 검색 결과 데이터 받기
    @SuppressWarnings("unchecked")
    List<Book> searchResults = (List<Book>) request.getAttribute("searchResults");
    String keyword = (String) request.getAttribute("keyword");
    Integer resultCount = (Integer) request.getAttribute("resultCount");
    
    if (searchResults == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    // 로그인 상태 확인
    String userId = (String) session.getAttribute("userId");
    String username = (String) session.getAttribute("username");
    boolean isLoggedIn = (userId != null);
%>
<!DOCTYPE html>
<html>
<head>
    <title>검색 결과: <%= keyword %> - ReRead</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        :root {
            --main-blue: #1976d2;
            --main-blue-dark: #1257a8;
            --main-bg: #f6f8fa;
            --card-bg: #fff;
        }
        html, body {
            margin: 0;
            padding: 0;
            font-family: 'Noto Sans KR', 'Apple SD Gothic Neo', 'Malgun Gothic', Arial, sans-serif;
            color: #222;
            background: var(--main-bg);
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
        .header {
            text-align: center;
            font-size: 36px;
            font-weight: 900;
            margin: 100px 0 20px 0;
            color: var(--main-blue);
            letter-spacing: 2px;
            text-shadow: 0 2px 8px rgba(25,118,210,0.08);
        }
        .search-bar {
            margin-bottom: 36px;
            text-align: center;
        }
        .search-bar form {
            display: inline-flex;
            background: #fff;
            border-radius: 32px;
            box-shadow: 0 2px 12px rgba(25,118,210,0.09);
            overflow: hidden;
            border: 1.5px solid #e3eaf3;
        }
        .search-bar input[type="text"] {
            width: 320px;
            padding: 14px 20px;
            border: none;
            font-size: 17px;
            outline: none;
            background: none;
        }
        .search-bar button {
            padding: 0 32px;
            background: var(--main-blue);
            color: #fff;
            font-size: 17px;
            font-weight: 600;
            border: none;
            cursor: pointer;
            transition: background 0.16s;
        }
        .search-bar button:hover {
            background: var(--main-blue-dark);
        }
        .search-info {
            text-align: center;
            margin: 20px 0;
            font-size: 18px;
            color: #666;
        }
        .search-keyword {
            color: var(--main-blue);
            font-weight: bold;
        }
        .section-title {
            font-size: 25px;
            font-weight: 800;
            margin: 48px 0 18px 7vw;
            color: #222;
            letter-spacing: 1px;
            border-left: 6px solid var(--main-blue);
            padding-left: 14px;
            background: linear-gradient(90deg, #e3f0fb 0 80%, transparent 100%);
            border-radius: 0 16px 16px 0;
            width: fit-content;
            box-shadow: 0 2px 12px rgba(25,118,210,0.04);
        }
        .book-list {
            display: flex;
            gap: 32px;
            flex-wrap: wrap;
            justify-content: flex-start;
            padding: 0 7vw;
            margin-bottom: 38px;
        }
        .book-card {
            border-radius: 16px;
            box-shadow: 0 4px 24px rgba(30, 144, 255, 0.13);
            width: auto;
            height: auto;
            padding: 22px 16px 18px 16px;
            display: flex;
            flex-direction: column;
            transition: box-shadow 0.18s, transform 0.18s;
            position: relative;
            overflow: hidden;
            background: var(--card-bg);
            text-decoration: none;
            cursor: pointer;
            line-height: 1;
            vertical-align: top;
            white-space: normal;
        }
        .book-card:hover {
            box-shadow: 0 8px 32px rgba(25,118,210,0.17);
            transform: translateY(-6px) scale(1.03);
        }
        .book-img {
            width: 180px;
            height: 240px;
            background: #e3f0fb;
            border-radius: 10px;
            margin-bottom: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(25,118,210,0.08);
            position: relative;
            z-index: 1;
        }
        .book-img img {
            max-width: 100%;
            max-height: 100%;
            object-fit: cover;
            display: block;
        }
        .book-card h4 {
            font-size: 19px;
            margin: 10px 0 4px 0;
            color: #222;
            font-weight: 700;
            letter-spacing: 0.5px;
            z-index: 1;
        }
        .book-card p {
            margin: 5px 0;
            font-size: 15px;
            color: #444;
            z-index: 1;
        }
        .book-card span {
            color: var(--main-blue);
            font-weight: bold;
        }
        .state-box {
            display: inline-block;
            font-size: 15px;
            border-radius: 8px;
            padding: 3px 16px;
            font-weight: bold;
            background: linear-gradient(90deg, #ffe082 60%, #ffd54f 100%);
            color: #7c6a00;
            box-shadow: 0 1px 4px rgba(255,214,79,0.09);
            letter-spacing: 1px;
            line-height: 1.4; 
            position: absolute;
            top: 5px;
            left: 5px;
        }
        
        /* ✅ 판매자 링크 스타일 */
        .seller-link {
            display: block;
            margin-top: 8px;
            padding: 4px 0;
            font-size: 12px;
            color: #666;
            text-decoration: none;
            transition: color 0.18s;
            border-top: 1px solid #f0f0f0;
            cursor: pointer;
        }
        
        .seller-link:hover {
            color: var(--main-blue);
            text-decoration: underline;
        }
        
        .seller-link::before {
            content: "🏪 ";
            margin-right: 4px;
        }
        
        .no-results {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }
        .no-results h3 {
            font-size: 24px;
            margin-bottom: 16px;
            color: #999;
        }
        .no-results p {
            font-size: 16px;
            line-height: 1.6;
        }
        .back-btn {
            text-align: center;
            margin: 40px 0;
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
            background: var(--main-blue);
        }
        .btn-primary:hover {
            background: var(--main-blue-dark);
        }
        
        /* Responsive */
        @media (max-width: 1100px) {
            .main-container { padding: 0 10px; }
            .book-list { padding: 0 2vw; gap: 20px; }
            .section-title { margin-left: 2vw; }
        }
        @media (max-width: 800px) {
            .header { font-size: 28px; margin-top: 80px; }
            .book-list { flex-wrap: wrap; gap: 12px; }
            .book-card { width: 44vw; min-width: 140px; }
            .section-title { font-size: 18px; }
            .main-container { flex-direction: column; height: auto; }
            .nav-right { margin-top: 6px; }
        }
        @media (max-width: 600px) {
            .header { font-size: 21px; }
            .book-list { gap: 7px; }
            .book-card { width: 95vw; min-width: 0; }
            .section-title { font-size: 15px; }
            .search-bar input[type="text"] { width: 140px; font-size: 13px; }
            .search-bar button { font-size: 13px; padding: 0 12px; }
        }
    </style>
    
    <script>
    // ✅ 판매자 상점 이동 함수
    function goToSellerStore(event, sellerId) {
        event.stopPropagation(); // 책 상세페이지로 이동하는 것을 방지
        location.href = 'idReview.jsp?seller=' + sellerId;
    }
    </script>
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

    <div class="header">🔍 검색 결과</div>

    <!-- 새로운 검색 폼 -->
    <div class="search-bar">
        <form action="search" method="get">
            <input type="text" name="keyword" value="<%= keyword %>" placeholder="책 제목 검색..." />
            <button type="submit">검색</button>
        </form>
    </div>
    
    <!-- 검색 결과 정보 -->
    <div class="search-info">
        '<span class="search-keyword"><%= keyword %></span>' 검색 결과 
        <strong><%= resultCount %></strong>개 발견
    </div>

    <% if (searchResults != null && !searchResults.isEmpty()) { %>
        <div class="section-title">검색 결과 (<%= resultCount %>개)</div>
        <div class="book-list">
            <% for (Book book : searchResults) { %>
                <div class="book-card" onclick="location.href='bookdetail.jsp?bookId=<%= book.getBookId() %>'">
                    <div class="book-img">
                        <div class="state-box">상태: <%= book.getBookCondition() %></div>
                        <!-- ✅ 메인페이지와 동일한 이미지 처리 방식 -->
                        <img src="<%= book.getImagePath() != null ? book.getImagePath() : "image/book1.jpg" %>" 
                             alt="<%= book.getTitle() %>" 
                             onerror="this.src='image/book1.jpg';">
                    </div>
                    <h4><%= book.getTitle() %></h4>
                    <p><%= book.getAuthor() %> / <%= book.getPublisher() %></p>
                    <p>₩<%= String.format("%,d", book.getPrice()) %></p>
                    <!-- ✅ 판매자 상점 링크 -->
                    <a href="javascript:void(0)" class="seller-link" onclick="goToSellerStore(event, '<%= book.getSellerId() %>')">
                        판매자: <%= book.getSellerId() %>님의 상점
                    </a>
                </div>
            <% } %>
        </div>
    <% } else { %>
        <div class="no-results">
            <h3>🔍 검색 결과가 없습니다</h3>
            <p>'<strong><%= keyword %></strong>'에 대한 검색 결과를 찾을 수 없습니다.</p>
            <p>다른 키워드로 다시 검색해보세요.</p>
        </div>
    <% } %>
    
    <div class="back-btn">
        <a href="index.jsp" class="btn btn-primary">메인으로 돌아가기</a>
        
    </div>
</body>
</html>