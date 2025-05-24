<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>ReRead 마이페이지</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Noto Sans KR', 'Apple SD Gothic Neo', 'Malgun Gothic', Arial, sans-serif;
            color: #222;
            padding: 40px;
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
        <%----------------마이페이지----------------%>
        .container {
            max-width: 1000px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-top: 60px;   
        }
        h2 {
            margin-bottom: 20px;
        }
        .section {
            margin-bottom: 30px;
        }
        button {
            padding: 8px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
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

<div class="container">
    <h2>마이페이지</h2>

    <div class="section">
    <h3>내 회원정보 수정</h3>
    <form action="updateMember.jsp" method="post">
        <table>
            <tr>
                <td>가입일</td>
                <td><input type="text" name="date" value="2023-01-01" readonly></td>
            </tr>
            <tr>
                <td>아이디</td>
                <td><input type="text" name="userid" value="hong123" readonly></td>
            </tr>
            <tr>
                <td>이름</td>
                <td><input type="text" name="username" value="홍길동"></td>
            </tr>
            <tr>
                <td>비밀번호</td>
                <td><input type="password" name="password" value="password"></td>
            </tr>
            <tr>
                <td>이메일</td>
                <td><input type="email" name="email" value="hong@google.com"></td>
            </tr>
        </table>
        <button type="submit" style="margin-top:16px;">저장</button>
    </form>
</div>

    <div class="section">
        <h3>판매중인 책</h3>
        <table>
            <tr>
                <th>책 제목</th>
                <th>등록일</th>
                <th>삭제</th>
            </tr>
            <tr>
                <td><a href="bookdetail.jsp">글쓰기 생각쓰기</a></td>
                <td>2023-05-01</td>
                <td>
                <form action="deleteBook.jsp" method="post" style="margin:0;">
                    <input type="hidden" name="bookid" value="1">
                    <button type="submit" style="padding:6px 13px; background-color:#dc3545; color:white; border-radius:4px; font-size:13px; cursor:pointer;">
                        삭제
                    </button>
                </form>
            </td>
            </tr>
            <tr>
                <td><a href="bookdetail.jsp">글쓰기 생각쓰기</a></td>
                <td>2023-05-13</td>
                <td>
                <form action="deleteBook.jsp" method="post" style="margin:0;">
                    <input type="hidden" name="bookid" value="1">
                    <button type="submit" style="padding:6px 13px; background-color:#dc3545; color:white; border-radius:4px; font-size:13px; cursor:pointer;">
                        삭제
                    </button>
                </form>
            </td>
            </tr>
        </table>
    </div>

    <div class="section">
        <h3>작성한 글 목록</h3>
        <table>
            <tr>
                <th>제목</th>
                <th>작성일</th>
            </tr>
            <tr>
                <td><a href="postView.jsp?postId=1">Spring Boot 질문 있습니다!</a></td>
                <td>2023-04-21</td>
            </tr>
            <tr>
                <td><a href="postView.jsp?postId=1">책 거래 후기입니다.</a></td>
                <td>2023-04-22</td>
            </tr>
        </table>
    </div>
</div>

</body>
</html>

