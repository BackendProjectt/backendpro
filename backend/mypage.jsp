<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>마이페이지 - ReRead</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
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

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
	<div class="top-navbar">
        <div class="main-container">
            <div class="nav-left">
                <span class="logo">📚 ReRead</span>
            </div>
            <div class="nav-right">
                <a href="index.jsp">메인 화면</a>
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
                <td><input type="text" name="username" value="홍길동" readonly></td>
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
        <h3>거래 내역</h3>
        <table>
            <tr>
                <th>책 제목</th>
                <th>가격</th>
                <th>상태</th>
            </tr>
            <tr>
                <td><a href="bookdetail.jsp">Java Programming</a></td>
                <td>15,000원</td>
                <td>판매 중</td>
            </tr>
            <tr>
                <td><a href="bookdetail.jsp">Spring Boot Guide</a></td>
                <td>20,000원</td>
                <td>예약 중</td>
            </tr>
        </table>
    </div>

    <div class="section">
        <h3>거래 내역</h3>
        <table>
            <tr>
                <th>책 제목</th>
                <th>거래일</th>
                <th>상태</th>
            </tr>
            <tr>
                <td><a href="bookdetail.jsp">Effective Java</a></td>
                <td>2023-05-01</td>
                <td>완료</td>
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

