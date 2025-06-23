<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // 로그인 체크
    String userId = (String) session.getAttribute("userId");
    String username = (String) session.getAttribute("username");
    
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>ReRead 책 등록</title>
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
        .success-message {
            color: green;
            text-align: center;
            margin: 10px 0;
            font-weight: bold;
        }
        .error-message {
            color: red;
            text-align: center;
            margin: 10px 0;
            font-weight: bold;
        }
        .required {
            color: red;
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
                <span style="margin-right: 10px;">안녕하세요, <%= username %>님!</span>
                <a href="logout">로그아웃</a>
                <a href="mypage.jsp">마이페이지</a>
                <a href="cart.jsp">장바구니</a>
                <a href="bookRegister.jsp">책 등록</a>
                <a href="bookReview.jsp">리뷰 등록</a>
            </div>
        </div>
    </div>
    
    <div class="bookregister-container">
        <h2>책 판매 등록</h2>
        
        <!-- 성공/실패 메시지 표시 -->
        <% if (request.getParameter("success") != null) { %>
            <div class="success-message">
                <% if ("book_added".equals(request.getParameter("success"))) { %>
                    책이 성공적으로 등록되었습니다!
                <% } %>
            </div>
        <% } %>
        
        <% if (request.getParameter("error") != null) { %>
            <div class="error-message">
                <% if ("1".equals(request.getParameter("error"))) { %>
                    책 등록에 실패했습니다. 다시 시도해주세요.
                <% } %>
            </div>
        <% } %>
        
        <form action="bookRegister" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="title">책 이름 <span class="required">*</span></label>
                <input type="text" id="title" name="title" required maxlength="200" placeholder="책 제목을 입력하세요">
            </div>
            <div class="form-group">
                <label for="author">저자 <span class="required">*</span></label>
                <input type="text" id="author" name="author" required maxlength="100" placeholder="저자명을 입력하세요">
            </div>
            <div class="form-group">
                <label for="publisher">출판사 <span class="required">*</span></label>
                <input type="text" id="publisher" name="publisher" required maxlength="100" placeholder="출판사를 입력하세요">
            </div>
            <div class="form-group">
                <label for="price">판매 가격(원) <span class="required">*</span></label>
                <input type="number" id="price" name="price" min="100" step="100" required placeholder="예: 15000">
            </div>
            <div class="form-group">
                <label for="desc">책 설명 <span class="required">*</span></label>
                <textarea id="desc" name="desc" required maxlength="2000" placeholder="책의 상태, 특징 등을 자세히 설명해주세요"></textarea>
            </div>
            <div class="form-group">
                <label>책 상태 <span class="required">*</span></label>
                <div class="state-group">
                    <label><input type="radio" name="state" value="상" checked> 상 (거의 새 책)</label>
                    <label><input type="radio" name="state" value="중"> 중 (약간의 사용감)</label>
                    <label><input type="radio" name="state" value="하"> 하 (사용감 많음)</label>
                </div>
            </div>
            <div class="form-group">
                <label for="category">카테고리 <span class="required">*</span></label>
                <select id="category" name="category" required>
                    <option value="">카테고리 선택</option>
                    <option value="소설">소설</option>
                    <option value="문학">문학</option>
                    <option value="IT">IT</option>
                    <option value="과학">과학</option>
                    <option value="종교">종교</option>
                    <option value="경제">경제</option>
                    <option value="만화">만화</option>
                </select>
            </div>
            <div class="form-group">
                <label for="image">책 사진</label>
                <input type="file" id="image" name="image" accept="image/*">
                <small style="color: #666; font-size: 12px;">* 사진을 등록하지 않으면 기본 이미지가 사용됩니다.</small>
            </div>
            <div class="button-group">
                <button type="submit">등록하기</button>
            </div>
        </form>
    </div>
    
    <script>
        function validateForm() {
            var title = document.getElementById('title').value.trim();
            var author = document.getElementById('author').value.trim();
            var publisher = document.getElementById('publisher').value.trim();
            var price = document.getElementById('price').value;
            var desc = document.getElementById('desc').value.trim();
            var category = document.getElementById('category').value;
            
            if (title === '') {
                alert('책 이름을 입력해주세요.');
                document.getElementById('title').focus();
                return false;
            }
            
            if (author === '') {
                alert('저자를 입력해주세요.');
                document.getElementById('author').focus();
                return false;
            }
            
            if (publisher === '') {
                alert('출판사를 입력해주세요.');
                document.getElementById('publisher').focus();
                return false;
            }
            
            if (price === '' || parseInt(price) < 100) {
                alert('가격은 100원 이상 입력해주세요.');
                document.getElementById('price').focus();
                return false;
            }
            
            if (desc === '') {
                alert('책 설명을 입력해주세요.');
                document.getElementById('desc').focus();
                return false;
            }
            
            if (category === '') {
                alert('카테고리를 선택해주세요.');
                document.getElementById('category').focus();
                return false;
            }
            
            return true;
        }
        
        // 숫자만 입력 가능하도록 제한
        document.getElementById('price').addEventListener('input', function(e) {
            this.value = this.value.replace(/[^0-9]/g, '');
        });
        
        // 엔터키로 폼 제출 방지 (파일 업로드 때문에)
        document.addEventListener('keypress', function(e) {
            if (e.keyCode === 13 && e.target.type !== 'submit' && e.target.type !== 'textarea') {
                e.preventDefault();
            }
        });
    </script>
</body>
</html>