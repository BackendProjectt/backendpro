<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>ReRead 중고 책 거래</title>
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
        <%----------------책 거래 컨테이너----------------%>
        .bookregister-container {
            max-width: 620px;
            min-width: 350px;
            margin: 80px auto 40px auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 16px rgba(0,0,0,0.09);
            padding: 38px 36px 32px 36px;
        }
        h2 {
            margin-top: 0;
            margin-bottom: 28px;
            text-align: center;
            font-size: 28px;
        }
        .form-group {
            margin-bottom: 22px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-size: 15px;
            color: #222;
            font-weight: 500;
        }
        input[type="text"], input[type="number"], textarea, select {
            width: 100%;
            padding: 10px 12px;
            border: 1.2px solid #ccd3db;
            border-radius: 5px;
            font-size: 15px;
            background: #fafdff;
            margin-bottom: 0;
            box-sizing: border-box;
        }
        textarea {
            min-height: 120px;
            resize: vertical;
        }
        input[type="file"] {
            padding: 8px 2px;
            font-size: 14px;
            border: none;
            background: none;
        }
        <%----------------상태----------------%>
        .state-group {
            display: flex;
            gap: 16px;
            margin-bottom: 0;
        }
        .state-group label {
            margin-bottom: 0;
            font-weight: 400;
            font-size: 15px;
        }
        <%----------------버튼----------------%>
        .button-group {
            margin-top: 30px;
        }
        button {
            width: 100%;
            padding: 13px 0;
            background: #007bff;
            color: #fff;
            border: none;
            border-radius: 7px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            letter-spacing: 1px;
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
                <a href="bookReview.jsp">리뷰 등록</a>
            </div>
        </div>
    </div>
    
    <div class="bookregister-container">
        <h2>책 판매 등록</h2>
        <form action="bookUpload.jsp" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="title">책 이름</label>
                <input type="text" id="title" name="title" required maxlength="80">
            </div>
            <div class="form-group">
                <label for="author">저자</label>
                <input type="text" id="author" name="author" required maxlength="50">
            </div>
            <div class="form-group">
                <label for="publisher">출판사</label>
                <input type="text" id="publisher" name="author" required maxlength="50">
            </div>
            <div class="form-group">
                <label for="price">판매 가(원)</label>
                <input type="number" id="price" name="price" min="0" step="100" required>
            </div>
            <div class="form-group">
                <label for="desc">설명</label>
                <textarea id="desc" name="desc" required maxlength="2000" placeholder="책 설명"></textarea>
            </div>
            <div class="form-group">
                <label>상태</label>
                <div class="state-group">
                    <label><input type="radio" name="state" value="상" checked> 상</label>
                    <label><input type="radio" name="state" value="중"> 중</label>
                    <label><input type="radio" name="state" value="하"> 하</label>
                </div>
            </div>
            <div class="form-group">
                <label for="category">카테고리</label>
                <select id="category" name="category" required>
                    <option value="">카테고리 선택</option>
                    <option value="소설">소설</option>
                    <option value="문학">과학</option>
                    <option value="IT">문학</option>
                    <option value="과학">종교</option>
                </select>
            </div>
            <div class="form-group">
                <label for="image">이미지</label>
                <input type="file" id="image" name="image" accept="image/*" required>
            </div>
            <div class="button-group">
                <button type="submit">등록하기</button>
            </div>
        </form>
    </div>
</body>
</html>