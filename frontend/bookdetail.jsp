<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.BookDAO" %>
<%@ page import="dao.CartDAO" %>
<%@ page import="model.Book" %>

<%
    // 책 ID 파라미터 받기
    int bookId = 1; // 기본값
    try {
        String bookIdParam = request.getParameter("bookId");
        if (bookIdParam != null) {
            bookId = Integer.parseInt(bookIdParam);
        }
    } catch (NumberFormatException e) {
        bookId = 1;
    }
    
    // 데이터베이스에서 책 정보 가져오기
    Book book = null;
    boolean inCart = false;
    String userId = (String) session.getAttribute("userId");
    
    try {
        BookDAO bookDAO = new BookDAO();
        book = bookDAO.getBookById(bookId);
        
        // 로그인한 사용자의 장바구니에 이미 있는지 확인
        if (userId != null && book != null) {
            CartDAO cartDAO = new CartDAO();
            inCart = cartDAO.isInCart(userId, bookId);
        }
        
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    if (book == null) {
        response.sendRedirect("index.jsp?error=book_not_found");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title><%= book.getTitle() %> - 책 상세 정보</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Noto Sans KR', 'Apple SD Gothic Neo', 'Malgun Gothic', Arial, sans-serif;
            color: #222;
            padding: 25px;
            background: #f4f4f4;
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
        .detail-container {
            max-width: 800px;
            margin: 80px auto 24px auto;
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.09);
            padding: 42px 38px 28px 38px;
            padding-bottom: 80px;
        }
        .detail-main {
            display: flex;
            gap: 36px;
        }
        .book-img {
            width: 270px;
            height: 375px;
            background: #f3f3f3;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        .book-img img {
            max-width: 100%;
            max-height: 100%;
            display: block;
            object-fit: cover;
        }
        .book-info {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
        }
        .book-title {
            font-size: 36px;
            font-weight: 900;
            margin-bottom: 0px;
        }
        .book-meta {
            font-size: 16px;
            color: #888;
            margin-bottom: 18px;
            margin-left: 2px;
        }
        .info-list {
            font-size: 17px;
            margin-bottom: 18px;
            line-height: 2.2;
            position: relative;
        }
        .info-label {
            color: #888;
            font-weight: bold;
            width: 92px;
            display: inline-block;
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
        }
        .desc-title {
            font-size: 24px;
            font-weight: 800;
            margin: 24px 0 10px 0;
        }
        .desc-box {
            font-size: 17px;
            color: #222;
            background: #f6f6f6;
            border-radius: 6px;
            padding: 16px 19px;
            margin-bottom: 24px;
        }
        .bottom-bar {
            position: fixed;
            left: 0;
            bottom: 0;
            width: 100vw;
            background: #f8f8f8;
            border-top: 1.5px solid #ececec;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 16px 0;
            z-index: 300;
        }
        .bottom-bar .total-price {
            font-size: 20px;
            margin-right: 28px;
        }
        .bottom-bar .total-price b {
            color: #1976d2;
            font-size: 22px;
            margin-left: 6px;
        }
        .btn-group {
            display: flex;
            gap: 10px;
        }
        .btn {
            padding: 12px 0;
            min-width: 180px;
            font-size: 17px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            transition: background 0.15s;
        }
        .btn-cart {
            background: #292929;
            color: #fff;
        }
        .btn-cart:hover {
            background: #444;
        }
        .btn-cart.in-cart {
            background: #28a745;
        }
        .btn-cart.in-cart:hover {
            background: #218838;
        }
        .btn-buy {
            background: #ffcf3f;
            color: #222;
        }
        .btn-buy:hover {
            background: #ffd964;
        }
        .btn-disabled {
            background: #ccc;
            color: #666;
            cursor: not-allowed;
        }
        .success-message {
            color: green;
            text-align: center;
            margin: 10px 0;
            font-weight: bold;
        }
        .error-message {
            color: red;
            text-align: center;
            margin: 10px 0;
            font-weight: bold;
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
                <% if (userId != null) { %>
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

    <div class="detail-container">
        <!-- 성공/실패 메시지 표시 -->
        <% if (request.getParameter("success") != null) { %>
            <div class="success-message">
                <% if ("added_to_cart".equals(request.getParameter("success"))) { %>
                    장바구니에 추가되었습니다!
                <% } %>
            </div>
        <% } %>
        
        <% if (request.getParameter("error") != null) { %>
            <div class="error-message">
                <% if ("cannot_add_own_book".equals(request.getParameter("error"))) { %>
                    자신이 등록한 책은 장바구니에 추가할 수 없습니다.
                <% } else if ("add_failed".equals(request.getParameter("error"))) { %>
                    장바구니 추가에 실패했습니다.
                <% } else if ("cannot_buy_own_book".equals(request.getParameter("error"))) { %>
                    자신이 등록한 책은 구매할 수 없습니다.
                <% } else if ("purchase_failed".equals(request.getParameter("error"))) { %>
                    구매에 실패했습니다.
                <% } %>
            </div>
        <% } %>
        
        <div class="book-title" style="margin-bottom:28px;"><%= book.getTitle() %></div>
        <div class="book-meta">저자 : <%= book.getAuthor() %> / 출판사 : <%= book.getPublisher() %></div>
        <div class="detail-main">
            <div class="book-img">
                <img src="<%= book.getImagePath() != null ? book.getImagePath() : "image/book1.jpg" %>" alt="<%= book.getTitle() %>">
            </div>
            <div class="book-info">
                <div class="info-list">
                    <span class="info-label">카테고리</span> <%= book.getCategory() %><br>
                    <span class="info-label">판매가</span>
                    <span class="price">₩<%= String.format("%,d", book.getPrice()) %></span> <br>
                    <span class="info-label">판매자 ID</span> <%= book.getSellerId() %>
                    <a href="idReview.jsp?seller=<%= book.getSellerId() %>" style="text-decoration:none; font-weight: bold;">[리뷰보기]</a><br>
                    <span class="state-box">상태: <%= book.getBookCondition() %></span><br>
                </div>
            </div>
        </div>

        <div class="desc-title">책 소개</div>
        <div class="desc-box">
            <%= book.getDescription() != null ? book.getDescription().replace("\n", "<br>") : "상세 설명이 없습니다." %>
        </div>
    </div>

    <div style="height:80px;"></div>

    <div class="bottom-bar">
        <div class="total-price">총 결제 금액 : <b>₩<%= String.format("%,d", book.getPrice()) %></b></div>
        <div class="btn-group">
            <% if (userId == null) { %>
                <!-- 로그인하지 않은 경우 -->
                <button class="btn btn-cart btn-disabled" onclick="alert('로그인이 필요합니다.'); location.href='login.jsp'">장바구니에 담기</button>
                <button class="btn btn-buy btn-disabled" onclick="alert('로그인이 필요합니다.'); location.href='login.jsp'">바로 구매</button>
            <% } else if (userId.equals(book.getSellerId())) { %>
                <!-- 자신의 책인 경우 -->
                <button class="btn btn-cart btn-disabled" onclick="alert('자신이 등록한 책입니다.')">장바구니에 담기</button>
                <button class="btn btn-buy btn-disabled" onclick="alert('자신이 등록한 책입니다.')">바로 구매</button>
            <% } else if (!"판매중".equals(book.getStatus())) { %>
                <!-- 판매중이 아닌 경우 -->
                <button class="btn btn-cart btn-disabled">판매 완료</button>
                <button class="btn btn-buy btn-disabled">판매 완료</button>
            <% } else { %>
                <!-- 정상적으로 구매 가능한 경우 -->
                <% if (inCart) { %>
                    <button class="btn btn-cart in-cart" onclick="location.href='cart.jsp'">장바구니에 있음</button>
                <% } else { %>
                    <button class="btn btn-cart" onclick="addToCart(<%= book.getBookId() %>)">장바구니에 담기</button>
                <% } %>
                <button class="btn btn-buy" onclick="buyNow(<%= book.getBookId() %>)">바로 구매</button>
            <% } %>
        </div>
    </div>
    
    <script>
        function addToCart(bookId) {
            var form = document.createElement('form');
            form.method = 'POST';
            form.action = 'cart';
            
            var actionInput = document.createElement('input');
            actionInput.type = 'hidden';
            actionInput.name = 'action';
            actionInput.value = 'add';
            
            var bookIdInput = document.createElement('input');
            bookIdInput.type = 'hidden';
            bookIdInput.name = 'bookId';
            bookIdInput.value = bookId;
            
            form.appendChild(actionInput);
            form.appendChild(bookIdInput);
            document.body.appendChild(form);
            form.submit();
        }
        
        function buyNow(bookId) {
            if (confirm('이 책을 구매하시겠습니까?')) {
                var form = document.createElement('form');
                form.method = 'POST';
                form.action = 'purchase';
                
                var bookIdInput = document.createElement('input');
                bookIdInput.type = 'hidden';
                bookIdInput.name = 'bookId';
                bookIdInput.value = bookId;
                
                form.appendChild(bookIdInput);
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>