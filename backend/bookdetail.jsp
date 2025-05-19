<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>책 상세 정보</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 40px;
            background-color: #f5f5f5;
        }
        <%----------------네이게이션 바----------------%>
        .top-navbar {
            background-color: #007bff;
            color: white;
            padding: 10px 0;
            position: fixed;
            left: 0;
            top: 0;
            width: 100vw;
            z-index: 10;
        }
        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }
        .nav-left .logo {
            font-size: 22px;
            font-weight: bold;
        }
        .nav-right a {
            color: black;
            margin-left: 20px;
            text-decoration: none;
            font-size: 14px;
        }
        .nav-right a:hover {
            text-decoration: underline;
            color: black;
        }
        <%----------------자세히보기 컨테이너----------------%>
        .detail-container {
            max-width: 800px;
            margin: 40px auto;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
            padding: 40px 32px 32px 32px;
        }
        .detail-main {
            display: flex;
            gap: 36px;
        }
        <%----------------책 이미지----------------%>
        .book-img {
            width: 180px;
            height: 250px;
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
        <%----------------책 정보----------------%>
        .book-info {
            flex: 1;
        }
        .book-info h2 {
            font-size: 28px;
            margin: 0 0 16px 0;
        }
        .info-table {
            font-size: 16px;
            margin-bottom: 22px;
        }
        .info-table tr > td:first-child {
            color: #666;
            width: 100px;
            padding-right: 12px;
            font-weight: bold;
        }
        .price {
            color: #222;
            font-size: 22px;
            font-weight: bold;
        }
        <%----------------책 설명----------------%>
        .section {
            margin-top: 28px;
        }
        .desc-box {
            font-size: 15px;
            color: #222;
            background: #f6f6f6;
            border-radius: 6px;
            padding: 12px 16px;
            margin-bottom: 24px;
        }
        <%----------------버튼----------------%>
        .btn-group {
            display: flex;
            gap: 16px;
            margin-top: 15px;
        }
        .btn {
            flex: 1;
            padding: 12px 0;
            font-size: 16px;
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
    
    <div class="detail-container">
        <div class="detail-main">
            <div class="book-img">
                <img src="image/book1.jpg">
            </div>
            <div class="book-info">
                <h2>글쓰기 생각쓰기</h2>
                <table class="info-table">
                    <tr>
                        <td>카테고리</td>
                        <td>문학</td>
                    </tr>
                    <tr>
                        <td>저자</td>
                        <td>윌리엄 진서</td>
                    </tr>
                    <tr>
                        <td>출판사</td>
                        <td>돌베개</td>
                    </tr>
                    <tr>
                        <td>판매가</td>
                        <td class="price">₩19,000</td>
                    </tr>
                    
                </table>
            </div>
        </div>
        
        <div class="section">
            <div class="desc-box">
                글쓰기의 기본을 다룬 고전
				쉽고 알차게 구성한 글쓰기 안내서 [글쓰기 생각쓰기]. 
				1976년 초판이 나온 이후 30년 동안 100만 명이 넘는 사람들이 읽은 글쓰기의 고전이다. 
				논픽션 작가이자 오랫동안 글쓰기를 강의해온 저자가 자신의 경험을 바탕으로 명쾌하고 따뜻한 조언을 전해준다.
            </div>
            <div class="btn-group">
                <button class="btn btn-cart">장바구니에 담기</button>
                <button class="btn btn-buy">바로 구매</button>
            </div>
        </div>
    </div>
    
</body>
</html>