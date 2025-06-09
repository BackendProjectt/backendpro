<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>구매 내역 및 리뷰 작성</title>
    <style>
        body {
            margin: 0;
            padding: 40px;
            background: #f4f4f4;
            font-family: 'Noto Sans KR', 'Apple SD Gothic Neo', 'Malgun Gothic', Arial, sans-serif;
            color: #222;
        }
        .board-container {
            max-width: 1000px;
            margin: 100px auto;
            background-color: white;
            padding: 20px 30px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            min-height: 500px;
        }
        h2 {
            margin-bottom: 24px;
            color: #1976d2;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }
        th, td {
            padding: 14px 12px;
            border-bottom: 1px solid #ccc;
            text-align: center;
            word-wrap: break-word;
        }
        th {
            background-color: #f1f1f1;
            font-weight: 600;
        }
        button.review-btn {
            padding: 8px 14px;
            background-color: #ffd54f;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            color: #333;
            transition: background-color 0.3s ease;
        }
        button.review-btn:hover {
            background-color: #ffec6e;
        }
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
<div class="board-container">
    <h2>구매 내역 및 리뷰 작성</h2>

    <table>
        <thead>
            <tr>
                <th>판매자 ID</th>
                <th>책 이름</th>
                <th>가격</th>
                <th>구매일</th>
                <th>리뷰 작성</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>seller123</td>
                <td>자바 완전 정복</td>
                <td>15,000원</td>
                <td>2025-06-01</td>
                <td>
                    <form action="review.jsp" method="post" style="margin:0;">
                        <input type="hidden" name="seller_id" value="seller123" />
                        <input type="hidden" name="book_title" value="자바 완전 정복" />
                        <input type="hidden" name="price" value="15000" />
                        <input type="hidden" name="purchase_date" value="2025-06-01" />
                        <button type="submit" class="review-btn" onclick="window.open('review.jsp', 'reviewPopup', 'width=550,height=660,resizable=no,scrollbars=yes'); return false;">리뷰 작성</button>
                    </form>
                </td>
            </tr>
            <tr>
                <td>seller456</td>
                <td>스프링 입문</td>
                <td>22,000원</td>
                <td>2025-05-28</td>
                <td>
                    <form action="review.jsp" method="post" style="margin:0;">
                        <input type="hidden" name="seller_id" value="seller456" />
                        <input type="hidden" name="book_title" value="스프링 입문" />
                        <input type="hidden" name="price" value="22000" />
                        <input type="hidden" name="purchase_date" value="2025-05-28" />
                        <button type="submit" class="review-btn" onclick="window.open('review.jsp', 'reviewPopup', 'width=550,height=660,resizable=no,scrollbars=yes'); return false;">리뷰 작성</button>
                    </form>
                </td>
            </tr>
            <tr>
                <td>seller789</td>
                <td>HTML5 & CSS3</td>
                <td>18,500원</td>
                <td>2025-05-15</td>
                <td>
                    <form action="review.jsp" method="post" style="margin:0;">
                        <input type="hidden" name="seller_id" value="seller789" />
                        <input type="hidden" name="book_title" value="HTML5 & CSS3" />
                        <input type="hidden" name="price" value="18500" />
                        <input type="hidden" name="purchase_date" value="2025-05-15" />
                        <button type="submit" class="review-btn" onclick="window.open('review.jsp', 'reviewPopup', 'width=550,height=660,resizable=no,scrollbars=yes'); return false;">리뷰 작성</button>
                    </form>
                </td>
            </tr>
        </tbody>
    </table>
</div>

</body>
</html>
