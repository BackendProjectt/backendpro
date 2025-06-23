<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    String userId = (String) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // DAO 인스턴스 생성
    PurchaseDAO purchaseDAO = new PurchaseDAO();
    ReviewDAO reviewDAO = new ReviewDAO();
    BookDAO bookDAO = new BookDAO();
    
    // 구매한 책 목록 가져오기
    List<Purchase> purchasedBooks = new ArrayList<>();
    try {
        purchasedBooks = purchaseDAO.getPurchasesByBuyerId(userId);
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    String username = (String) session.getAttribute("username");
    boolean isLoggedIn = (userId != null);
    
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
%>
<!DOCTYPE html>
<html>
<head>
    <title>구매 내역 및 리뷰 작성 - ReRead</title>
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
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .section-title {
            font-size: 24px;
            font-weight: 700;
            color: #333;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #1976d2;
        }
        
        .purchase-table {
            width: 100%;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        
        .purchase-table table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .purchase-table th {
            background: #1976d2;
            color: white;
            padding: 15px;
            text-align: center;
            font-weight: 600;
        }
        
        .purchase-table td {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }
        
        .purchase-table tr:hover {
            background: #f8f9fa;
        }
        
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: all 0.18s;
        }
        
        .btn-review {
            background: #ffd600;
            color: #333;
        }
        
        .btn-review:hover {
            background: #ffc107;
            transform: translateY(-2px);
        }
        
        .btn-completed {
            background: #28a745;
            color: white;
            cursor: default;
        }
        
        .btn-disabled {
            background: #6c757d;
            color: white;
            cursor: not-allowed;
        }
        
        .no-purchases {
            text-align: center;
            padding: 60px;
            color: #666;
            font-size: 18px;
        }
        
        .review-status {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .status-pending {
            background: #fff3cd;
            color: #856404;
        }
        
        .status-completed {
            background: #d4edda;
            color: #155724;
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
        <div class="header">📝 구매 내역 및 리뷰 작성</div>

        <div class="container">
            <div class="section-title">📋 구매한 책 목록 (총 <%= purchasedBooks.size() %>권)</div>
            
            <% if (purchasedBooks != null && !purchasedBooks.isEmpty()) { %>
                <div class="purchase-table">
                    <table>
                        <thead>
                            <tr>
                                <th>구매번호</th>
                                <th>책 ID</th>
                                <th>판매자 ID</th>
                                <th>가격</th>
                                <th>구매일</th>
                                <th>리뷰 작성</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Purchase purchase : purchasedBooks) { 
                                // 이미 리뷰를 작성했는지 확인
                                boolean hasReview = reviewDAO.hasReview(userId, purchase.getPurchaseId());
                            %>
                                <tr>
                                    <td><%= purchase.getPurchaseId() %></td>
                                    <td><%= purchase.getBookId() %></td>
                                    <td><%= purchase.getSellerId() %></td>
                                    <td>₩<%= String.format("%,d", purchase.getPrice()) %></td>
                                    <td><%= purchase.getPurchaseDate() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(purchase.getPurchaseDate()) : "날짜 없음" %></td>
                                    <td>
                                        <% if (hasReview) { %>
                                            <span class="review-status status-completed">✅ 리뷰 완료</span>
                                        <% } else { %>
                                            <button class="btn btn-review" onclick="openReviewPopup('<%= purchase.getPurchaseId() %>', '<%= purchase.getBookId() %>', '<%= purchase.getSellerId() %>')">
                                                📝 리뷰 작성
                                            </button>
                                        <% } %>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } else { %>
                <div class="no-purchases">
                    <h3>📦 구매 내역이 없습니다</h3>
                    <p>책을 구매한 후 리뷰를 작성할 수 있습니다.</p>
                    <a href="index.jsp" style="color: #1976d2; text-decoration: none; font-weight: bold;">책 둘러보기 →</a>
                </div>
            <% } %>
        </div>
    </div>

    <script>
    function openReviewPopup(purchaseId, bookId, sellerId) {
        var url = 'review.jsp?purchaseId=' + purchaseId + '&bookId=' + bookId + '&sellerId=' + sellerId;
        var popup = window.open(url, 'reviewPopup', 'width=650,height=600,scrollbars=yes,resizable=yes');
        
        // 팝업이 닫힐 때 페이지 새로고침
        var checkClosed = setInterval(function() {
            if (popup.closed) {
                clearInterval(checkClosed);
                location.reload();
            }
        }, 1000);
    }
    </script>
</body>
</html>