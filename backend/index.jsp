<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>ReRead 중고 책 거래</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 40px;
            background-color: #f5f5f5;
        }
        .header {
            text-align: center;
            font-size: 36px;   /* 🔹 더 크게 보이도록 수정 */
            font-weight: bold;
            margin: 40px 0;
            color: #333
        }
        .search-bar {
            margin-bottom: 20px;
        }
        .book-list {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .book-card {
            background: white;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            width: 200px;
        }
        .top-navbar {
            background-color: #007bff;
            color: white;
            padding: 10px 0;
        }

        .container {
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
        
        .board-link {
            display: block;
            text-align: center;
            margin: 30px 0;
            font-size: 20px;
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
        }

        .board-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
	<div class="top-navbar">
    <div class="container">
        <div class="nav-left">
            <span class="logo">📚 ReRead</span>
        </div>
        <div class="nav-right">
            <a href="login.jsp">로그인</a>
            <a href="signup.jsp">회원가입</a>
            <a href="mypage.jsp">마이페이지</a>
            <a href="cart.jsp">장바구니(0)</a>
            <a href="book.jsp">책 관리</a>
        </div>
    </div>
	</div>
	
    <div class="header">📚 ReRead 중고 책 거래</div>

    <div class="search-bar">
        <form action="search.jsp" method="get">
            <input type="text" name="keyword" placeholder="책 제목 또는 저자 검색..." />
            <select name="category">
                <option value="">전체</option>
                <option value="소설">소설</option>
                <option value="과학">과학</option>
                <option value="IT">IT</option>
            </select>
            <button type="submit">검색</button>
        </form>
    </div>
    
    <a href="board.jsp" class="board-link">📌 게시판 바로가기</a>

    <div class="book-list">
        <div class="book-card">
            <h4>대머리</h4>
            <p>저자: 홍길동</p>
            <p>₩10,000</p>
            <button>자세히 보기</button>
        </div>
        <div class="book-card">
            <h4>백책</h4>
            <p>저자: 김철수</p>
            <p>₩8,000</p>
            <button>자세히 보기</button>
        </div>
        <div class="book-card">
            <h4>책책책</h4>
            <p>저자: 김철광</p>
            <p>₩9,000</p>
            <button>자세히 보기</button>
        </div>
        <div class="book-card">
            <h4>모바일</h4>
            <p>저자: 김팔수</p>
            <p>₩6,000</p>
            <button>자세히 보기</button>
        </div>
        <div class="book-card">
            <h4>백육</h4>
            <p>저자: 오철이</p>
            <p>₩8,000</p>
            <button>자세히 보기</button>
        </div>
    </div>
</body>
</html>