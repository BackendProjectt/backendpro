<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>회원가입</title>
    <style>
        body {
            font-family: 'Noto Sans KR', 'Apple SD Gothic Neo', 'Malgun Gothic', Arial, sans-serif;
            background: #f4f4f4;
            color: #222;
            min-height: 100vh;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        <%----------------네이게이션 바----------------%>
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
        <%----------------회원가입 컨테이너----------------%>
        .signup-container {
            width: 360px;
            background: #fff;
            padding: 34px 28px 28px 28px;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.13);
        }
        h2 {
            text-align: center;
            color: #007bff;
            font-weight: bold;
            font-size: 26px;
            margin-bottom: 24px;
            letter-spacing: 1px;
        }
        .form-group {
            margin-bottom: 17px;
        }
        label {
            display: block;
            margin-bottom: 7px;
            color: #222;
            font-weight: 500;
            font-size: 15px;
        }
        <%----------------버튼----------------%>
        button {
            width: 100%;
            padding: 12px 0;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 6px;
            font-size: 17px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 10px;
            box-shadow: 0 2px 7px rgba(0,123,255,0.06);
            letter-spacing: 1px;
            transition: background 0.13s;
        }
        button:hover {
            background-color: #0056b3;
        }
        <%----------------기타----------------%>
        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 11px 12px;
            border: 1.5px solid #d6dbe3;
            border-radius: 5px;
            background: #fafcff;
            box-sizing: border-box;
            transition: border 0.2s, box-shadow 0.2s;
            font-size: 15px;
            outline: none;
            box-shadow: 0 2px 7px rgba(0,0,0,0.03);
        }
        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus {
            border-color: #007bff;
            box-shadow: 0 2px 8px rgba(0,123,255,0.08);
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

    <div class="signup-container">
        <h2>회원가입</h2>
        <form action="register" method="post">
            <div class="form-group">
                <label for="userid">유저 ID</label>
                <input type="text" id="userid" name="userid" placeholder="아이디(영문/숫자 조합)" required>
            </div>
            <div class="form-group">
                <label for="username">이름</label>
                <input type="text" id="username" name="username" placeholder="이름" required>
            </div>
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" placeholder="비밀번호" required>
            </div>
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" placeholder="이메일" required>
            </div>
            <button type="submit">가입하기</button>
        </form>
    </div>

</body>
</html>
