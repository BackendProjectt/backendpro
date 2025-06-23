<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // 파라미터로 성공 타입 확인
    String successType = request.getParameter("success");
    String count = request.getParameter("count");
    String successCount = request.getParameter("success_count");
    String totalCount = request.getParameter("total_count");
    
    // 메시지 설정
    String mainMessage = "🎉 거래가 완료되었습니다!";
    String subMessage = "리뷰를 작성하여 판매자와 다른 구매자에게 도움을 주세요.";
    
    if ("all_purchased".equals(successType) && count != null) {
        mainMessage = "🎉 " + count + "권의 책을 모두 구매했습니다!";
        subMessage = "장바구니의 모든 책 구매가 완료되었습니다. 리뷰 작성 페이지에서 각 책에 대한 리뷰를 남겨주세요.";
    } else if ("partial_purchased".equals(successType) && successCount != null && totalCount != null) {
        mainMessage = "⚠️ " + totalCount + "권 중 " + successCount + "권 구매 완료";
        subMessage = "일부 책은 이미 판매완료되었거나 자신의 책이어서 구매하지 못했습니다. 구매 완료된 책에 대해 리뷰를 작성해주세요.";
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>거래 완료 - ReRead</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background: #f4f4f4;
            padding: 60px;
            text-align: center;
            margin: 0;
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
        .box {
            margin-top: 150px;
            background: white;
            padding: 50px 40px;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            display: inline-block;
            max-width: 500px;
            min-width: 400px;
        }
        h2 {
            color: #1976d2;
            margin-bottom: 20px;
            font-size: 28px;
            line-height: 1.3;
        }
        .sub-message {
            color: #666;
            margin-bottom: 30px;
            font-size: 16px;
            line-height: 1.5;
        }
        .btn-group {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }
        .btn-review {
            padding: 12px 24px;
            font-size: 16px;
            background: #ffd54f;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            transition: background 0.2s;
            text-decoration: none;
            color: #333;
        }
        .btn-review:hover {
            background: #ffec6e;
        }
        .btn-home {
            padding: 12px 24px;
            font-size: 16px;
            background: #1976d2;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            transition: background 0.2s;
            text-decoration: none;
            color: white;
        }
        .btn-home:hover {
            background: #1257a8;
        }
        .btn-cart {
            padding: 12px 24px;
            font-size: 16px;
            background: #28a745;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            transition: background 0.2s;
            text-decoration: none;
            color: white;
        }
        .btn-cart:hover {
            background: #218838;
        }
        .icon {
            font-size: 60px;
            margin-bottom: 20px;
        }
        .success-details {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 15px;
            margin: 20px 0;
            border-left: 4px solid #28a745;
        }
        .warning-details {
            background: #fff3cd;
            border-radius: 8px;
            padding: 15px;
            margin: 20px 0;
            border-left: 4px solid #ffc107;
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
                <a href="login.jsp">로그인</a>
                <a href="signup.jsp">회원가입</a>
                <a href="mypage.jsp">마이페이지</a>
                <a href="cart.jsp">장바구니</a>
                <a href="bookRegister.jsp">책 등록</a>
                <a href="bookReview.jsp">리뷰 등록</a>
            </div>
        </div>
    </div>
    
    <div class="box">
        <div class="icon">📚</div>
        <h2><%= mainMessage %></h2>
        
        <% if ("partial_purchased".equals(successType)) { %>
        <div class="warning-details">
            <strong>구매 상세:</strong><br>
            • 성공: <%= successCount %>권<br>
            • 실패: <%= Integer.parseInt(totalCount) - Integer.parseInt(successCount) %>권<br>
            <small>(자신의 책이거나 이미 판매완료된 책)</small>
        </div>
        <% } else if ("all_purchased".equals(successType)) { %>
        <div class="success-details">
            <strong>구매 완료:</strong> <%= count %>권의 책을 모두 성공적으로 구매했습니다!
        </div>
        <% } %>
        
        <p class="sub-message"><%= subMessage %></p>
        
        <div class="btn-group">
            <a href="bookReview.jsp" class="btn-review">📝 리뷰 작성하기</a>
            <a href="index.jsp" class="btn-home">🏠 홈으로 가기</a>
            <% if (!"all_purchased".equals(successType)) { %>
            <a href="cart.jsp" class="btn-cart">🛒 장바구니 보기</a>
            <% } %>
        </div>
    </div>
</body>
</html>