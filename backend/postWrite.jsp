<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>게시글 작성</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background: #f4f4f4;
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
        <%----------------작성 컨테이너----------------%>
        .write-container {
            max-width: 900px;
            min-width: 400px;
            margin: 80px auto 40px auto;
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 2px 16px rgba(0,0,0,0.09);
            padding: 48px 44px 38px 44px;
        }
        h2 {
            margin-top: 0;
            margin-bottom: 34px;
            text-align: center;
            font-size: 30px;
        }
        .form-row-horizontal {
            display: flex;
            align-items: center;
            margin-bottom: 26px;
            gap: 10px;
        }
        .label-title {
            font-size: 15px;
            color: #222;
            font-weight: 500;
            margin-right: 8px;
            min-width: 38px;
        }
        .input-title {
            flex: 0 0 320px;
            padding: 13px 16px;
            border: 1.5px solid #ccd3db;
            border-radius: 5px;
            font-size: 17px;
            background: #fafdff;
            margin-right: 18px;
        }
        .label-category {
            font-size: 15px;
            color: #222;
            font-weight: 500;
            margin-right: 8px;
            min-width: 56px;
            text-align: right;
        }
        .select-category {
            width: 110px;
            font-size: 15px;
            border: 1.3px solid #ccd3db;
            border-radius: 5px;
            padding: 11px 7px 11px 13px;
            background: #fafdff;
        }
        .content-label {
            display: block;
            margin-bottom: 10px;
            font-size: 16px;
            color: #222;
            font-weight: 500;
        }
        textarea {
            width: 100%;
            font-size: 16px;
            font-family: 'Nanum Gothic';
            border: 1.5px solid #ccd3db;
            border-radius: 7px;
            padding: 18px 16px;
            box-sizing: border-box;
            min-height: 500px;
            resize: vertical;
        }
        @media (max-width: 600px) {
            .write-container {
                max-width: 98vw;
                padding: 15vw 2vw;
            }
            .form-row-horizontal {
                flex-direction: column;
                gap: 4px;
                align-items: stretch;
            }
            .input-title, .select-category {
                width: 100% !important;
                max-width: 100%;
                margin-right: 0;
            }
        }
        <%----------------버튼----------------%>
        button {
            width: 100%;
            padding: 16px 0;
            background: #007bff;
            color: #fff;
            border: none;
            border-radius: 7px;
            font-size: 20px;
            font-weight: bold;
            cursor: pointer;
            letter-spacing: 1px;
            margin-top: 28px;
        }
        button:hover {
            background: #0056b3;
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

    <div class="write-container">
        <h2>게시글 작성</h2>
        <form action="postUpload.jsp" method="post">
            <div class="form-row-horizontal">
                <label for="title" class="label-title">제목</label>
                <input type="text" id="title" name="title" maxlength="80" required class="input-title">
                <label for="category" class="label-category">카테고리</label>
                <select id="category" name="category" required class="select-category">
                    <option value="">선택</option>
                    <option value="자유">자유</option>
                    <option value="질문">질문</option>
                </select>
            </div>
            <label for="content" class="content-label">내용</label>
            <textarea id="content" name="content" required maxlength="2000"></textarea>
            <button type="submit">작성하기</button>
        </form>
    </div>
</body>
</html>

