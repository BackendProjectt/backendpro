<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            --gray: #888;
            --shadow: 0 4px 24px rgba(30, 144, 255, 0.13);
        }
        html, body {
            margin: 0;
            padding: 0;
            background: var(--main-bg);
            font-family: 'Noto Sans KR', 'Apple SD Gothic Neo', 'Malgun Gothic', Arial, sans-serif;
            color: #222;
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
            background: var(--card-bg);
            border-radius: 16px;
            box-shadow: var(--shadow);
            width: 220px;
            padding: 22px 16px 18px 16px;
            display: flex;
            flex-direction: column;
            align-items: center;
            transition: box-shadow 0.18s, transform 0.18s;
            position: relative;
            overflow: hidden;
        }
        .book-card::before {
            content: "";
            display: block;
            position: absolute;
            left: -40%;
            top: -40%;
            width: 180%;
            height: 60%;
            background: linear-gradient(120deg, #e3f0fb 0, transparent 100%);
            z-index: 0;
        }
        .book-card:hover {
            box-shadow: 0 8px 32px rgba(25,118,210,0.17);
            transform: translateY(-6px) scale(1.03);
        }
        .book-img {
            width: 100%;
            height: 160px;
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
        .book-card span {
            color: var(--main-blue);
            font-weight: bold;
        }
        .book-card button {
            margin-top: 12px;
            padding: 9px 26px;
            background: linear-gradient(90deg, #1976d2 60%, #1257a8 100%);
            color: #fff;
            border: none;
            border-radius: 9px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 2px 8px rgba(25,118,210,0.08);
            transition: background 0.14s, box-shadow 0.14s;
            z-index: 1;
        }
        .book-card button:hover {
            background: linear-gradient(90deg, #1257a8 0%, #1976d2 100%);
            box-shadow: 0 4px 14px rgba(25,118,210,0.18);
        }
        .state-box {
            display: inline-block;
            font-size: 15px;
            border-radius: 8px;
            padding: 3px 16px;
            margin-bottom: 10px;
            font-weight: bold;
            background: linear-gradient(90deg, #ffe082 60%, #ffd54f 100%);
            color: #7c6a00;
            box-shadow: 0 1px 4px rgba(255,214,79,0.09);
            letter-spacing: 1px;
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
    <script>
        function selectTab(group, idx) {
            var tabs = document.querySelectorAll('.'+group+'-tabs .tab');
            for (var i = 0; i < tabs.length; i++)
                tabs[i].className = 'tab' + (i === idx ? ' active' : '');
        }
    </script>
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

    <div class="header">📚 ReRead 중고 책 거래</div>

    <div class="search-bar">
        <form action="search.jsp" method="get">
            <input type="text" name="keyword" placeholder="책 제목 검색..." />
            <button type="submit">검색</button>
        </form>
    </div>
    
    <div class="board-div-link">
    <a href="board.jsp" class="board-link">📌 게시판 바로가기</a>
	</div>
	
    <div class="section-title">최근 등록된 도서</div>
    <div class="book-list">
        <div class="book-card">
            <div class="book-img">
                <img src="image/book1.jpg">
            </div>
            <h4>책1</h4>
            <p>₩10,000</p>
            <div class="state-box">상태: 상</div>
            <button onclick="location.href='bookdetail.jsp'">자세히 보기</button>
        </div>
        <div class="book-card">
            <div class="book-img">
                <img src="image/book1.jpg">
            </div>
            <h4>책2</h4>
            <p>₩8,000</p>
            <div class="state-box">상태: 중</div>
            <button onclick="location.href='bookdetail.jsp'">자세히 보기</button>
        </div>
        <div class="book-card">
            <div class="book-img">
                <img src="image/book1.jpg">
            </div>
            <h4>책3</h4>
            <p>₩9,000</p>
            <div class="state-box">상태: 상</div>
            <button onclick="location.href='bookdetail.jsp'">자세히 보기</button>
        </div>
        <div class="book-card">
            <div class="book-img">
                <img src="image/book1.jpg">
            </div>
            <h4>책4</h4>
            <p>₩6,000</p>
            <div class="state-box">상태: 하</div>
            <button onclick="location.href='bookdetail.jsp'">자세히 보기</button>
        </div>
        <div class="book-card">
            <div class="book-img">
                <img src="image/book1.jpg">
            </div>
            <h4>책5</h4>
            <p>₩8,000</p>
            <div class="state-box">상태: 상</div>
            <button onclick="location.href='bookdetail.jsp'">자세히 보기</button>
        </div>
    </div>

    <div class="section-title">카테고리별 도서</div>
    <div class="tab-bar category-tabs">
        <button type="button" class="tab" onclick="selectTab('category',0)">전체</button>
        <button type="button" class="tab" onclick="selectTab('category',1)">소설</button>
        <button type="button" class="tab" onclick="selectTab('category',2)">과학</button>
        <button type="button" class="tab" onclick="selectTab('category',3)">문학</button>
        <button type="button" class="tab" onclick="selectTab('category',4)">종교</button>
    </div>
    <div class="book-list">
        <div class="book-card">
            <div class="book-img">
                <img src="image/book1.jpg">
            </div>
            <h4>책A</h4>
            <p>₩1,000</p>
            <div class="state-box">상태: 하</div>
            <button onclick="location.href='bookdetail.jsp'">자세히 보기</button>
        </div>
        <div class="book-card">
            <div class="book-img">
                <img src="image/book1.jpg">
            </div>
            <h4>책B</h4>
            <p>₩2,500</p>
            <div class="state-box">상태: 상</div>
            <button onclick="location.href='bookdetail.jsp'">자세히 보기</button>
        </div>
        <div class="book-card">
            <div class="book-img">
                <img src="image/book1.jpg">
            </div>
            <h4>책C</h4>
            <p>₩3,000</p>
            <div class="state-box">상태: 중</div>
            <button onclick="location.href='bookdetail.jsp'">자세히 보기</button>
        </div>
        <div class="book-card">
            <div class="book-img">
                <img src="image/book1.jpg">
            </div>
            <h4>책D</h4>
            <p>₩2,000</p>
            <div class="state-box">상태: 상</div>
            <button onclick="location.href='bookdetail.jsp'">자세히 보기</button>
        </div>
        <div class="book-card">
            <div class="book-img">
                <img src="image/book1.jpg">
            </div>
            <h4>책E</h4>
            <p>₩1,500</p>
            <div class="state-box">상태: 중</div>
            <button onclick="location.href='bookdetail.jsp'">자세히 보기</button>
        </div>
    </div>

    <div class="section-title">가격대별 도서</div>
    <div class="tab-bar price-tabs">
        <button type="button" class="tab active" onclick="selectTab('price',0)">1천원~3천원</button>
        <button type="button" class="tab" onclick="selectTab('price',1)">4천원~6천원</button>
        <button type="button" class="tab" onclick="selectTab('price',2)">7천원~9천원</button>
        <button type="button" class="tab" onclick="selectTab('price',3)">만원 이상</button>
    </div>
    <div class="book-list">
        <div class="book-card">
            <div class="book-img">
                <img src="image/book1.jpg">
            </div>
            <h4>책A</h4>
            <p>₩1,000</p>
            <div class="state-box">상태: 하</div>
            <button onclick="location.href='bookdetail.jsp'">자세히 보기</button>
        </div>
        <div class="book-card">
            <div class="book-img">
                <img src="image/book1.jpg">
            </div>
            <h4>책B</h4>
            <p>₩2,500</p>
            <div class="state-box">상태: 상</div>
            <button onclick="location.href='bookdetail.jsp'">자세히 보기</button>
        </div>
        <div class="book-card">
            <div class="book-img">
                <img src="image/book1.jpg">
            </div>
            <h4>책C</h4>
            <p>₩3,000</p>
            <div class="state-box">상태: 중</div>
            <button onclick="location.href='bookdetail.jsp'">자세히 보기</button>
        </div>
        <div class="book-card">
            <div class="book-img">
                <img src="image/book1.jpg">
            </div>
            <h4>책D</h4>
            <p>₩2,000</p>
            <div class="state-box">상태: 상</div>
            <button onclick="location.href='bookdetail.jsp'">자세히 보기</button>
        </div>
        <div class="book-card">
            <div class="book-img">
                <img src="image/book1.jpg">
            </div>
            <h4>책E</h4>
            <p>₩1,500</p>
            <div class="state-box">상태: 중</div>
            <button onclick="location.href='bookdetail.jsp'">자세히 보기</button>
        </div>
    </div>
</body>
</html>
