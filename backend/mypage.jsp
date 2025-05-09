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

        .container {
            max-width: 1000px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
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

<div class="container">
    <h2>마이페이지</h2>

    <!-- 내 회원정보 수정 -->
    <div class="section">
        <h3>내 회원정보 수정</h3>
        <p>이름: 홍길동</p>
        <p>이메일: hong@example.com</p>
        <button onclick="location.href='memberEdit.jsp'">정보 수정</button>
    </div>

    <!-- 내가 찜한 책 -->
    <div class="section">
        <h3>내가 찜한 책</h3>
        <table>
            <tr>
                <th>책 제목</th>
                <th>저자</th>
                <th>가격</th>
                <th>상태</th>
            </tr>
            <tr>
                <td><a href="#">Java Programming</a></td>
                <td>김철수</td>
                <td>15,000원</td>
                <td>판매 중</td>
            </tr>
            <tr>
                <td><a href="#">Spring Boot Guide</a></td>
                <td>이영희</td>
                <td>20,000원</td>
                <td>예약 중</td>
            </tr>
        </table>
    </div>

    <!-- 거래 내역 -->
    <div class="section">
        <h3>거래 내역</h3>
        <table>
            <tr>
                <th>책 제목</th>
                <th>거래일</th>
                <th>상태</th>
            </tr>
            <tr>
                <td><a href="#">Effective Java</a></td>
                <td>2023-05-01</td>
                <td>완료</td>
            </tr>
        </table>
    </div>

    <!-- 작성한 글 -->
    <div class="section">
        <h3>작성한 글 목록</h3>
        <table>
            <tr>
                <th>제목</th>
                <th>작성일</th>
            </tr>
            <tr>
                <td><a href="#">Spring Boot 질문 있습니다!</a></td>
                <td>2023-04-21</td>
            </tr>
            <tr>
                <td><a href="#">책 거래 후기입니다.</a></td>
                <td>2023-04-22</td>
            </tr>
        </table>
    </div>
</div>

</body>
</html>

