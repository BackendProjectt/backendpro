<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>거래 완료</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background: #f4f4f4;
            padding: 60px;
            text-align: center;
        }
        .box {
        		margin-top:100px;
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            display: inline-block;
        }
        h2 {
            color: #1976d2;
            margin-bottom: 20px;
        }
        .btn-review {
            margin-top: 24px;
            padding: 12px 24px;
            font-size: 16px;
            background: #ffd54f;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
        }
        .btn-review:hover {
            background: #ffec6e;
        }
        :root {
            --main-blue: #1976d2;
            --main-blue-dark: #1257a8;
            --main-bg: #f6f8fa;
            --card-bg: #fff;
            /*--gray: #888;*/
            /*--shadow: 0 4px 24px rgba(30, 144, 255, 0.13);*/
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
		.board-div-link{
			width: auto;
			height: auto;
			text-align: center;
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
            width: auto;
            height: auto;
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
        .tab-bar, .category-tabs, .price-tabs {
            display: flex;
            gap: 18px;
            margin: 0 0 28px 7vw;
        }
        .tab, .category-tab {
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
        .tab.active, .tab:hover, .category-tab.active, .category-tab:hover {
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
            box-shadow: var(--shadow);
            width: auto;
            height: auto;
            padding: 22px 16px 18px 16px;
            display: flex;
            flex-direction: column;
            transition: box-shadow 0.18s, transform 0.18s;
            position: relative;
            overflow: hidden;
			background: var(--card-bg);
            text-decoration: none;   /* 링크 밑줄 제거 */
    		cursor: pointer;
    		line-height: 1;
   			vertical-align: top;
    		white-space: normal;
        }
        .book-card::before {
            content: "";
            display: block;
            position: absolute;
            left: -40%;
            top: -40%;
            width: 180%;
            height: 60%;
            /*background: linear-gradient(120deg, #e3f0fb 0, transparent 100%);*/
            z-index: 0;
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
            position: relative; /* 새로 추가 */
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
            position: absolute;       /* 새로 추가 */
    		top: 5px;                /* 원하는 만큼 간격 조절 (예: 10px) */
    		left: 5px;               /* 원하는 만큼 간격 조절 (예: 10px) */
        }
        /* Responsive */
        @media (max-width: 1100px) {
            .main-container { padding: 0 10px; }
            .book-list { padding: 0 2vw; gap: 20px; }
            .section-title, .category-tabs, .price-tabs { margin-left: 2vw; }
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
        <h2>🎉 거래가 완료되었습니다!</h2>
        <p>리뷰를 작성하여 판매자와 다른 구매자에게 도움을 주세요.</p>
        <button class="btn-review" onclick="window.open('review.jsp', 'reviewPopup', 'width=550,height=660,resizable=no,scrollbars=yes'); return false;">리뷰 작성하기</button>
    </div>
</body>
</html>
