<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>ReRead 게시판</title>
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
        }

        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>📌 ReRead 게시판</h2>

    <div class="button-container">
        <button onclick="alert('글 작성 기능은 나중에 추가')">✏️ 새 글 작성</button>
    </div>

    <table>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
        </tr>
        <!-- 예시 데이터 -->
        <tr>
            <td>1</td>
            <td><a href="postView.jsp?postId=1">ReRead</a></td>
            <td>홍길동</td>
            <td>2025-05-10</td>
        </tr>
        <tr>
            <td>2</td>
            <td><a href="postView.jsp?postId=2">책 추천 부탁드립니다!</a></td>
            <td>김철수</td>
            <td>2025-05-09</td>
        </tr>
        <tr>
            <td>3</td>
            <td><a href="postView.jsp?postId=3">Spring</a></td>
            <td>이영희</td>
            <td>2025-05-08</td>
        </tr>
    </table>
</div>

</body>
</html>
