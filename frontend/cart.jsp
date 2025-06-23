<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.CartDAO" %>
<%@ page import="model.Book" %>

<%
    // 로그인 체크
    String userId = (String) session.getAttribute("userId");
    String username = (String) session.getAttribute("username");
    
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // 장바구니 책 목록 가져오기
    List<Book> cartBooks = new ArrayList<>();
    int totalPrice = 0;
    String dbStatus = "DB 연결 실패";
    
    try {
        CartDAO cartDAO = new CartDAO();
        cartBooks = cartDAO.getCartBooks(userId);
        
        // 총 가격 계산
        for (Book book : cartBooks) {
            totalPrice += book.getPrice();
        }
        
        dbStatus = "장바구니: " + cartBooks.size() + "개 책, 총 ₩" + String.format("%,d", totalPrice);
        
    } catch (Exception e) {
        e.printStackTrace();
        dbStatus = "DB 연결 에러: " + e.getMessage();
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>장바구니</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Noto Sans KR', 'Apple SD Gothic Neo', 'Malgun Gothic', Arial, sans-serif;
            color: #222;
            padding: 40px;
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
        
        .cart-container {
            max-width: 700px;
            margin: 110px auto 100px auto;
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 2px 14px rgba(25, 118, 210, 0.08);
            padding: 35px 32px 18px 32px;
        }
        .cart-title {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 20px;
            color: #343a40;
        }
        .cart-list {
            width: 100%;
        }
        .cart-item {
            display: flex;
            align-items: center;
            border-bottom: 1px solid #eee;
            padding: 18px 0;
            gap: 26px;
            position: relative;
        }
        .cart-img {
            width: 90px; 
            height: 120px;
            border-radius: 5px;
            background: #fafbfc;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            border: 1px solid #f0f0f0;
        }
        .cart-img img {
            width: 100%; 
            height: 100%; 
            object-fit: cover;
        }
        .cart-book-info {
            flex: 1;
        }
        .cart-book-title {
            font-size: 18px; 
            font-weight: bold;
            color: #222;
            margin-bottom: 6px;
        }
        .cart-book-meta {
            font-size: 14px; 
            color: #888;
            margin-bottom: 6px;
        }
        .cart-book-price {
            color: #1976d2; 
            font-size: 16px; 
            font-weight: 600;
        }
        
        .btn-delete {
            position: absolute;
            right: 0;
            top: 50%;
            transform: translateY(-50%);
            background-color: #ff4d4d;
            color: white;
            border: none;
            border-radius: 6px;
            padding: 8px 14px;
            cursor: pointer;
            font-weight: bold;
            transition: background 0.2s ease;
        }
        .btn-delete:hover {
            background-color: #cc0000;
        }
        
        .btn-clear {
            background-color: #6c757d;
            color: white;
            border: none;
            border-radius: 6px;
            padding: 10px 20px;
            cursor: pointer;
            font-weight: bold;
            margin-bottom: 20px;
            transition: background 0.2s ease;
        }
        .btn-clear:hover {
            background-color: #545b62;
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
        .btn-buy {
            background: #ffcf3f;
            color: #222;
        }
        .btn-buy:hover {
            background: #ffd964;
        }
        .empty-cart {
            text-align: center;
            padding: 50px;
            color: #666;
            font-size: 16px;
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
        .db-status {
            text-align: center;
            margin: 10px 0;
            padding: 8px;
            background: #f0f0f0;
            border-radius: 5px;
            font-size: 12px;
            color: #666;
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
                <span style="margin-right: 10px;">안녕하세요, <%= username %>님!</span>
                <a href="logout">로그아웃</a>
                <a href="mypage.jsp">마이페이지</a>
                <a href="cart.jsp">장바구니</a>
                <a href="bookRegister.jsp">책 등록</a>
                <a href="bookReview.jsp">리뷰 등록</a>
            </div>
        </div>
    </div>
    
    <div class="cart-container">
        <div class="cart-title">장바구니에 넣은 책</div>
        
        <!-- DB 상태 표시 -->
        <div class="db-status"><%= dbStatus %></div>
        
        <!-- 성공/실패 메시지 표시 -->
        <% if (request.getParameter("success") != null) { %>
            <div class="success-message">
                <% if ("added".equals(request.getParameter("success"))) { %>
                    장바구니에 추가되었습니다!
                <% } else if ("removed".equals(request.getParameter("success"))) { %>
                    장바구니에서 삭제되었습니다!
                <% } else if ("cleared".equals(request.getParameter("success"))) { %>
                    장바구니가 비워졌습니다!
                <% } %>
            </div>
        <% } %>
        
        <% if (request.getParameter("error") != null) { %>
            <div class="error-message">
                <% if ("remove_failed".equals(request.getParameter("error"))) { %>
                    삭제에 실패했습니다.
                <% } else if ("clear_failed".equals(request.getParameter("error"))) { %>
                    장바구니 비우기에 실패했습니다.
                <% } %>
            </div>
        <% } %>
        
        <% if (cartBooks.isEmpty()) { %>
            <div class="empty-cart">
                장바구니가 비어있습니다.<br>
                <a href="index.jsp" style="color: #1976d2;">책을 구경하러 가기</a>
            </div>
        <% } else { %>
           
            
            <div class="cart-list">
                <% for (Book book : cartBooks) { %>
                <div class="cart-item">
                    <div class="cart-img">
                        <a href="bookdetail.jsp?bookId=<%= book.getBookId() %>" target="_blank">
                            <img src="<%= book.getImagePath() != null ? book.getImagePath() : "image/book1.jpg" %>" alt="<%= book.getTitle() %>">
                        </a>
                    </div>
                    <div class="cart-book-info">
                        <div class="cart-book-title"><%= book.getTitle() %></div>
                        <div class="cart-book-meta">저자: <%= book.getAuthor() %> / 출판사: <%= book.getPublisher() %></div>
                        <div class="cart-book-meta">상태: <%= book.getBookCondition() %> / 판매자: <%= book.getSellerId() %></div>
                        <div class="cart-book-price">₩<%= String.format("%,d", book.getPrice()) %></div>
                        <!-- 개별 구매 버튼 추가 -->
                        <button style="background: #28a745; color: white; border: none; border-radius: 4px; padding: 6px 12px; margin-top: 8px; cursor: pointer;" 
                                onclick="purchaseBook(<%= book.getBookId() %>)">개별 구매</button>
                    </div>
                    <button class="btn-delete" onclick="removeFromCart(<%= book.getBookId() %>)">삭제</button>
                </div>
                <% } %>
            </div>
        <% } %>
    </div>
    
    <% if (!cartBooks.isEmpty()) { %>
    <div class="bottom-bar">
        <div class="total-price">총 결제 금액 : <b>₩<%= String.format("%,d", totalPrice) %></b></div>
        <div class="btn-group">
            <button class="btn btn-buy" onclick="purchaseAll()">전체 구매</button>
        </div>
    </div>
    <% } %>
    
    <script>
        function removeFromCart(bookId) {
            if (confirm('이 책을 장바구니에서 삭제하시겠습니까?')) {
                var form = document.createElement('form');
                form.method = 'POST';
                form.action = 'cart';
                
                var actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'remove';
                
                var bookIdInput = document.createElement('input');
                bookIdInput.type = 'hidden';
                bookIdInput.name = 'bookId';
                bookIdInput.value = bookId;
                
                form.appendChild(actionInput);
                form.appendChild(bookIdInput);
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        function clearCart() {
            if (confirm('장바구니를 모두 비우시겠습니까?')) {
                var form = document.createElement('form');
                form.method = 'POST';
                form.action = 'cart';
                
                var actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'clear';
                
                form.appendChild(actionInput);
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        function purchaseAll() {
            if (confirm('장바구니의 모든 책을 구매하시겠습니까?')) {
                var form = document.createElement('form');
                form.method = 'POST';
                form.action = 'purchaseAll';
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        function purchaseBook(bookId) {
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