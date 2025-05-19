<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>ReRead 게시판</title>
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
        <%----------------게시판 컨테이너----------------%>
        .board-container {
            max-width: 1000px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-top: 60px;
        }
        h2 {
            margin-bottom: 24px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            padding: 10px;
            border-bottom: 1px solid #ccc;
            text-align: left;
        }
        th {
            background-color: #f1f1f1;
        }
        a {
            color: #007bff;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        <%----------------카테고리 탭----------------%>
        .category-tabs {
            display: flex;
            gap: 16px;
            margin-bottom: 18px;
        }
        .tab {
            padding: 6px 24px;
            font-size: 16px;
            border-radius: 18px;
            border: none;
            background: #f0f0f0;
            color: #222;
            font-weight: 500;
            cursor: pointer;
            transition: background 0.12s;
        }
        .tab.active {
            background: #007bff;
            color: #fff;
        }
        <%----------------버튼----------------%>
        .button-container {
            text-align: right;
        }
        button {
            padding: 10px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-bottom: 20px;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
    <script>
        function selectTab(idx) {
            var tabs = document.querySelectorAll('.tab');
            tabs.forEach(function(tab, i){
                tab.className = 'tab' + (i===idx?' active':'');
            });
            // 실제로는 카테고리별 목록 출력, 현재는 UI만 구현
        }
    </script>
</head>
<body>

<div class="board-container">

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
    <h2>ReRead 게시판</h2>

    <div class="category-tabs">
        <button type="button" class="tab active" onclick="selectTab(0)">자유</button>
        <button type="button" class="tab" onclick="selectTab(1)">질문</button>
    </div>

    <div class="button-container">
        <button onclick="location.href='postWrite.jsp'">새 글 작성</button>
    </div>

    <table>
        <tr>
            <th>번호</th>
            <th>카테고리</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
        </tr>

        <tr>
            <td>1</td>
            <td>자유</td>
            <td><a href="postView.jsp?postId=1">ReRead</a></td>
            <td>홍길동</td>
            <td>2025-05-10</td>
        </tr>
        <tr>
            <td>2</td>
            <td>질문</td>
            <td><a href="postView.jsp?postId=2">책 추천 부탁드립니다!</a></td>
            <td>김철수</td>
            <td>2025-05-09</td>
        </tr>
        <tr>
            <td>3</td>
            <td>질문</td>
            <td><a href="postView.jsp?postId=3">Spring</a></td>
            <td>이영희</td>
            <td>2025-05-08</td>
        </tr>
    </table>
</div>

</body>
</html>

