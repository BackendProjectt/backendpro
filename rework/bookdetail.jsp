<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>책 상세 정보</title>
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
    		margin-left: 2px; /* 제목과 정렬 맞추고 싶을 때 */
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
        .btn-buy {
            background: #ffcf3f;
            color: #222;
        }
        .btn-buy:hover {
            background: #ffd964;
        }
        td {
            padding: 10px;
            border-bottom: 1px solid #ccc;
            text-align: left;
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

    <div class="detail-container">
        <div class="book-title" style="margin-bottom:28px;">글쓰기 생각쓰기</div>
        <div class="book-meta">저자 : 윌리엄 진서 / 출판사 : 돌베개</div>
        <div class="detail-main">
            <div class="book-img">
                <img src="image/book1.jpg" alt="책 표지">
            </div>
            <div class="book-info">
                <div class="info-list">
                    <span class="info-label">카테고리</span> 문학<br>
                    <span class="info-label">판매가</span>
                    <span class="price">₩19,000</span> <br>
                    <span class="info-label">판매자 ID</span> hong123
                    <a href="idReview.jsp?seller=hong123" style="text-decoration:none; font-weight: bold;">[리뷰보기]</a><br>
                    <span class="state-box">상태: 상</span><br>
                </div>
            </div>
        </div>

        <div class="desc-title">책 소개</div>
        <div class="desc-box">
            글쓰기의 기본을 다룬 고전 쉽고 알차게 구성한 글쓰기 안내서 [글쓰기 생각쓰기].<br>
            1976년 초판이 나온 이후 30년 동안 100만 명이 넘는 사람들이 읽은 글쓰기의 고전이다.<br>
            논픽션 작가이자 오랫동안 글쓰기를 강의해온 저자가 자신의 경험을 바탕으로 명쾌하고 따뜻한 조언을 전해준다.
        </div>
    </div>

    <div style="height:80px;"></div>

    <div class="bottom-bar">
        <div class="total-price">총 결제 금액 : <b>₩19,000</b></div>
        <div class="btn-group">
            <button class="btn btn-cart" onclick="location.href='cart.jsp'">장바구니에 담기</button>
            <!-- 바로 구매 시 review.jsp가 아닌 complete.jsp로 이동 -->
            <button class="btn btn-buy" onclick="location.href='complete.jsp'">바로 구매</button>
        </div>
    </div>
</body>
</html>
