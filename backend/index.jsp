<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            font-size: 36px;
            font-weight: bold;
            margin: 40px 0;
            color: #333;
        }
        .search-bar {
            margin-bottom: 20px;
            text-align: center;
        }
        .section-title {
            font-size: 22px;
            font-weight: bold;
            margin: 30px 0 10px 5vw;
        }
        
        .category-tabs {
            display: flex;
            gap: 14px;
            margin: 0 0 12px 5vw;
        }
        .category-tab {
            padding: 4px 16px;
            border: none;
            background: none;
            font-size: 15px;
            cursor: pointer;
            color: #444;
            border-radius: 16px;
        }
        .category-tab.active {
            font-weight: bold;
            color: #fff;
            background: #007bff;
        }
        
        .book-list {
            display: flex;
            gap: 25px;
            padding: 0 5vw;
            margin-bottom: 30px;
        }
        
        .book-card {
            background: white;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            width: 200px;
        }
        .book-card p {
            margin: 6px 0;
        }
        .book-card span {
            font-weight: bold;
        }
        .book-card button {
            margin-top: 10px;
            padding: 6px 16px;
            background: #292929;
            color: #fff;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        
        .tab-bar {
        	display: flex;
        	gap: 16px;
        	margin: 0 0 10px 5vw;
    	}
    	.tab {
     	    padding: 3px 10px;
    	    border-bottom: 2px solid transparent;
  	   	    cursor: pointer;
   	    	font-size: 15px;
        	color: #444;
        	background: none;
      	 	border: none;
    	    transition: color 0.1s, border-bottom 0.1s;
    	}
    	.tab.active {
        	font-weight: bold;
        	color: #222 !important;
        	border-bottom: 2px solid #222 !important;
        	background: none;
    	}
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
        
        .book-img {
    		width: 100%;
    		height: 140px;
   	 		background: #f3f3f3;
    		border-radius: 6px;
    		margin-bottom: 8px;
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
        <div class="container">
            <div class="nav-left">
                <span class="logo">📚 ReRead</span>
            </div>
            <div class="nav-right">
                <a href="login.jsp">로그인</a>
                <a href="signup.jsp">회원가입</a>
                <a href="mypage.jsp">마이페이지</a>
                <a href="cart.jsp">장바구니</a>
                <a href="book.jsp">책 거래 관리</a>
            </div>
        </div>
    </div>

    <div class="header">📚 ReRead 중고 책 거래</div>

    <div class="search-bar">
        <form action="search.jsp" method="get">
            <input type="text" name="keyword" placeholder="책 제목 또는 저자 검색..." />
            <button type="submit">검색</button>
        </form>
    </div>
    
    <a href="board.jsp" class="board-link">📌 게시판 바로가기</a>

    <div class="section-title">최근 등록된 도서</div>
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
            <h4>책1</h4>
            <p>₩10,000</p>
            <p>남은 수량: <span style="color:#007bff;">2</span></p>
            <button onclick="location.href='bookdetail.jsp'">자세히 보기</button>
        </div>
        <div class="book-card">
        <div class="book-img">
        <img src="image/book1.jpg">
    	</div>
            <h4>책2</h4>
            <p>₩8,000</p>
            <p>남은 수량: <span style="color:#007bff;">1</span></p>
            <button onclick="location.href='bookdetail.jsp'">자세히 보기</button>
        </div>
        <div class="book-card">
        <div class="book-img">
        <img src="image/book1.jpg">
    	</div>
            <h4>책3</h4>
            <p>₩9,000</p>
            <p>남은 수량: <span style="color:#007bff;">5</span></p>
            <button onclick="location.href='bookdetail.jsp'">자세히 보기</button>
        </div>
        <div class="book-card">
        <div class="book-img">
        <img src="image/book1.jpg">
    	</div>
            <h4>책4</h4>
            <p>₩6,000</p>
            <p>남은 수량: <span style="color:#007bff;">0</span></p>
            <button onclick="location.href='bookdetail.jsp'">자세히 보기</button>
        </div>
        <div class="book-card">
        <div class="book-img">
        <img src="image/book1.jpg">
    	</div>
            <h4>책5</h4>
            <p>₩8,000</p>
            <p>남은 수량: <span style="color:#007bff;">3</span></p>
            <button onclick="location.href='bookdetail.jsp'">자세히 보기</button>
        </div>
    </div>

    <div class="section-title">가격대별</div>
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
            <p>남은 수량: <span style="color:#007bff;">5</span></p>
            <button onclick="location.href='bookdetail.jsp'">자세히 보기</button>
        </div>
        <div class="book-card">
        <div class="book-img">
        <img src="image/book1.jpg">
    	</div>
            <h4>책B</h4>
            <p>₩2,500</p>
            <p>남은 수량: <span style="color:#007bff;">3</span></p>
            <button onclick="location.href='bookdetail.jsp'">자세히 보기</button>
        </div>
        <div class="book-card">
        <div class="book-img">
        <img src="image/book1.jpg">
    	</div>
            <h4>책C</h4>
            <p>₩3,000</p>
            <p>남은 수량: <span style="color:#007bff;">2</span></p>
            <button onclick="location.href='bookdetail.jsp'">자세히 보기</button>
        </div>
        <div class="book-card">
        <div class="book-img">
        <img src="image/book1.jpg">
    	</div>
            <h4>책D</h4>
            <p>₩2,000</p>
            <p>남은 수량: <span style="color:#007bff;">2</span></p>
            <button onclick="location.href='bookdetail.jsp'">자세히 보기</button>
        </div>
        <div class="book-card">
        <div class="book-img">
        <img src="image/book1.jpg">
    	</div>
            <h4>책E</h4>
            <p>₩1,500</p>
            <p>남은 수량: <span style="color:#007bff;">2</span></p>
            <button onclick="location.href='bookdetail.jsp'">자세히 보기</button>
        </div>
    </div>
</body>
</html>
