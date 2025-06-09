<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>hong123님의 리뷰</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
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
        
        .outer-card {
            max-width: 650px;
            margin: 70px auto 0 auto;
            background: #fff;
            border-radius: 22px;
            box-shadow: 0 7px 22px rgba(0,0,0,0.09);
            padding: 34px 0 36px 0;
        }
        .user-title {
            font-size: 32px;
            color: #2584df;
            font-weight: 700;
            text-align: center;
            margin-bottom: 6px;
            margin-top: 7px;
            letter-spacing: -1px;
        }
        .user-date {
            text-align: center;
            font-size: 16px;
            color: #888;
            margin-bottom: 40px;
        }
        .review-list {
            width: 90%;
            margin: 0 auto;
        }
        .review-item {
            background: #ececec;
            border-radius: 10px;
            margin-bottom: 22px;
            padding: 18px 24px 14px 24px;
            box-shadow: 2px 3px 7px rgba(180,180,180,0.09);
            border: none;
        }
        .review-rating {
            color: #FFD600;
            font-size: 25px;
            margin-bottom: 2px;
            letter-spacing: 3px;
        }
        .review-meta {
            color: #7b7b7b;
            font-size: 15px;
            margin-bottom: 8px;
        }
        .review-meta b {
            color: #222;
        }
        .review-comment {
            color: #333;
            font-size: 16.5px;
            margin-top: 2px;
            line-height: 1.7;
        }
        .back-button {
            display: inline-block;
            background-color: #1976d2;
            color: white;
            border: none;
            border-radius: 10px;
            padding: 10px 22px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            margin-top: 32px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            transition: background-color 0.25s;
        }
        .back-button:hover {
            background-color: #135ba1;
        }
        @media (max-width: 700px) {
            .outer-card { max-width: 98vw; padding: 14px 0 20px 0;}
            .review-list { width: 97%; }
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
            </div>
        </div>
    </div>
    
    <div class="outer-card">
        <div class="user-title">hong123님의 리뷰페이지</div>
        <div class="user-date">가입일 : 2023-01-01</div>
        <div class="review-list">
            <div class="review-item">
                <div class="review-rating">★★★★★</div>
                <div class="review-meta">구매자: <b>reader77</b> | 작성일: 2025-05-22</div>
                <div class="review-comment">포장도 꼼꼼하고 연락도 잘 돼요. 또 구매하고 싶어요!</div>
            </div>
            <div class="review-item">
                <div class="review-rating">★★★★★</div>
                <div class="review-meta">구매자: <b>reader77</b> | 작성일: 2025-05-22</div>
                <div class="review-comment">포장도 꼼꼼하고 연락도 잘 돼요. 또 구매하고 싶어요!</div>
            </div>
            <div class="review-item">
                <div class="review-rating">★★★★☆</div>
                <div class="review-meta">구매자: <b>tester</b> | 작성일: 2025-05-19</div>
                <div class="review-comment">책 상태는 좋았으나 배송이 조금 느렸어요.</div>
            </div>
            <div class="review-item">
                <div class="review-rating">★★★★☆</div>
                <div class="review-meta">구매자: <b>tester</b> | 작성일: 2025-05-19</div>
                <div class="review-comment">책 상태는 좋았으나 배송이 조금 느렸어요.</div>
            </div>
        </div>
        <div style="text-align: center;">
            <button class="back-button" onclick="history.back()">← 이전 화면으로</button>
        </div>
    </div>
</body>
</html>
