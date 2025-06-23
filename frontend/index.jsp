<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.BookDAO" %>
<%@ page import="model.Book" %>

<%
    // 데이터베이스에서 책 정보 가져오기
    List<Book> books = new ArrayList<>();
    String dbStatus = "DB 연결 실패";
    
    try {
        BookDAO bookDAO = new BookDAO();
        books = bookDAO.getAllBooks();
        dbStatus = books.size() + "개의 책 로드됨";
    } catch (Exception e) {
        e.printStackTrace();
        dbStatus = "DB 연결 에러: " + e.getMessage();
    }
    
    // 로그인 상태 확인
    String userId = (String) session.getAttribute("userId");
    String username = (String) session.getAttribute("username");
    boolean isLoggedIn = (userId != null);
%>

<!DOCTYPE html>
<html>
<head>
    <title>ReRead 중고 책 거래</title>
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
            font-size: 40px;
            font-weight: 900;
            margin: 100px 0 40px 0;
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
        .board-link {
            text-align: center;
            margin: 36px 0 0 0;
            font-size: 20px;
            color: var(--main-blue);
            text-decoration: none;
            font-weight: bold;
            letter-spacing: 1px;
            transition: color 0.15s;
            display: block;
        }
        .board-link:hover {
            color: #ffd600;
            text-decoration: underline;
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
        .tab-bar {
            display: flex;
            gap: 18px;
            margin: 0 0 28px 7vw;
        }
        .tab {
            padding: 9px 30px;
            border: none;
            background: #f3f7fc;
            color: var(--main-blue);
            font-size: 16px;
            font-weight: 600;
            border-radius: 22px;
            cursor: pointer;
            transition: background 0.14s, color 0.14s, box-shadow 0.14s;
            box-shadow: 0 2px 8px rgba(25,118,210,0.04);
        }
        .tab.active, .tab:hover {
            background: var(--main-blue);
            color: #fff;
            box-shadow: 0 4px 14px rgba(25,118,210,0.11);
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
        .db-status {
            text-align: center;
            margin: 20px 0;
            padding: 10px;
            background: #f0f0f0;
            border-radius: 5px;
            font-size: 14px;
            color: #666;
        }
        
        /* Responsive */
        @media (max-width: 1100px) {
            .main-container { padding: 0 10px; }
            .book-list { padding: 0 2vw; gap: 20px; }
            .section-title, .tab-bar { margin-left: 2vw; }
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
        // 카테고리 필터
        function filterByCategory(idx) {
            var categories = ['경제', '문학', 'IT', '과학', '종교', '만화'];
            var selected = categories[idx];
            var cards = document.querySelectorAll('#category-list .book-card');
            cards.forEach(function(card) {
                var cat = card.getAttribute('data-category');
                card.style.display = (cat === selected) ? 'flex' : 'none';
            });

            var tabs = document.querySelectorAll('.category-tabs .tab');
            tabs.forEach((tab, i) => tab.classList.toggle('active', i === idx));
        }

        // 가격대 필터
        function filterByPrice(idx) {
            var ranges = [
                {min:1000, max:10000},
                {min:10001, max:20000},
                {min:20001, max:30000},
                {min:30001, max:9999999}
            ];
            var selected = ranges[idx];
            var cards = document.querySelectorAll('#price-list .book-card');
            cards.forEach(function(card) {
                var price = parseInt(card.getAttribute('data-price'));
                card.style.display = (price >= selected.min && price <= selected.max) ? 'flex' : 'none';
            });

            var tabs = document.querySelectorAll('.price-tabs .tab');
            tabs.forEach((tab, i) => tab.classList.toggle('active', i === idx));
        }

        document.addEventListener('DOMContentLoaded', function() {
            filterByCategory(0);
            filterByPrice(0);
        });
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

    <div class="header">📚 ReRead 중고 책 거래</div>

    <div class="search-bar">
        <form action="search" method="get">
            <input type="text" name="keyword" placeholder="책 제목 검색..." />
            <button type="submit">검색</button>
        </form>
    </div>
    
    <a href="board.jsp" class="board-link">📌 게시판 바로가기</a>

    <div class="db-status"><%= dbStatus %></div>
    
    <div class="section-title">최근 등록된 도서</div>
    <div class="book-list">
        <% 
        int count = 0;
        for (Book book : books) { 
            if (count >= 5) break;
            count++;
        %>
        <div class="book-card" onclick="location.href='bookdetail.jsp?bookId=<%= book.getBookId() %>'">
            <div class="book-img">
                <div class="state-box">상태: <%= book.getBookCondition() %></div>
                <img src="<%= book.getImagePath() != null ? book.getImagePath() : "image/book1.jpg" %>" alt="<%= book.getTitle() %>">
            </div>
            <h4><%= book.getTitle() %></h4>
            <p><%= book.getAuthor() %> / <%= book.getPublisher() %></p>
            <p>₩<%= String.format("%,d", book.getPrice()) %></p>
        </div>
        <% } %>
    </div>

    <div class="section-title">카테고리별 도서</div>
    <div class="tab-bar category-tabs">
        <button type="button" class="tab active" onclick="filterByCategory(0)">경제</button>
        <button type="button" class="tab" onclick="filterByCategory(1)">문학</button>
        <button type="button" class="tab" onclick="filterByCategory(2)">IT</button>
        <button type="button" class="tab" onclick="filterByCategory(3)">과학</button>
        <button type="button" class="tab" onclick="filterByCategory(4)">종교</button>
        <button type="button" class="tab" onclick="filterByCategory(5)">만화</button>
    </div>
    <div class="book-list" id="category-list">
        <% for (Book book : books) { %>
        <div class="book-card" data-category="<%= book.getCategory() %>" onclick="location.href='bookdetail.jsp?bookId=<%= book.getBookId() %>'">
            <div class="book-img">
                <div class="state-box">상태: <%= book.getBookCondition() %></div>
                <img src="<%= book.getImagePath() != null ? book.getImagePath() : "image/book1.jpg" %>" alt="<%= book.getTitle() %>">
            </div>
            <h4><%= book.getTitle() %></h4>
            <p><%= book.getAuthor() %> / <%= book.getPublisher() %></p>
            <p>₩<%= String.format("%,d", book.getPrice()) %></p>
        </div>
        <% } %>
    </div>

    <div class="section-title">가격대별 도서</div>
    <div class="tab-bar price-tabs">
        <button type="button" class="tab active" onclick="filterByPrice(0)">1만원 이하</button>
        <button type="button" class="tab" onclick="filterByPrice(1)">1-2만원</button>
        <button type="button" class="tab" onclick="filterByPrice(2)">2-3만원</button>
        <button type="button" class="tab" onclick="filterByPrice(3)">3만원 이상</button>
    </div>
    <div class="book-list" id="price-list">
        <% for (Book book : books) { %>
        <div class="book-card" data-price="<%= book.getPrice() %>" onclick="location.href='bookdetail.jsp?bookId=<%= book.getBookId() %>'">
            <div class="book-img">
                <div class="state-box">상태: <%= book.getBookCondition() %></div>
                <img src="<%= book.getImagePath() != null ? book.getImagePath() : "image/book1.jpg" %>" alt="<%= book.getTitle() %>">
            </div>
            <h4><%= book.getTitle() %></h4>
            <p><%= book.getAuthor() %> / <%= book.getPublisher() %></p>
            <p>₩<%= String.format("%,d", book.getPrice()) %></p>
        </div>
        <% } %>
    </div>
</body>
</html>