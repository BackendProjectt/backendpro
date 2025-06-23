<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Post" %>
<%
    String userId = (String) session.getAttribute("userId");
    String username = (String) session.getAttribute("username");
    boolean isLoggedIn = (userId != null);
    
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    Post post = (Post) request.getAttribute("post");
    if (post == null) {
        response.sendRedirect("board.jsp?error=게시글을 찾을 수 없습니다.");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>게시글 수정 - ReRead</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        :root {
            --main-blue: #1976d2;
            --main-blue-dark: #1257a8;
            --main-bg: #f6f8fa;
            --card-bg: #fff;
        }
        
        html, body {
            margin: 0;
            padding: 0;
            font-family: 'Noto Sans KR', 'Apple SD Gothic Neo', 'Malgun Gothic', Arial, sans-serif;
            color: #222;
            background: var(--main-bg);
        }
        
        /* 인덱스와 동일한 네비게이션 스타일 */
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
        
        .nav-right {
            display: flex;
            align-items: center;
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
        
        /* 페이지 컨텐츠 */
        .page-content {
            margin-top: 80px;
            padding: 20px;
        }
        
        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
        }
        
        .form-container {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .form-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .form-header h2 {
            color: #1976d2;
            margin-bottom: 10px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }
        
        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            font-family: inherit;
            box-sizing: border-box;
        }
        
        .form-group textarea {
            resize: vertical;
            min-height: 300px;
        }
        
        .form-group select {
            height: 40px;
        }
        
        .char-count {
            text-align: right;
            font-size: 12px;
            color: #666;
            margin-top: 5px;
        }
        
        .form-actions {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #e9ecef;
        }
        
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            margin: 0 10px;
            font-weight: bold;
            display: inline-block;
        }
        
        .btn-primary {
            background: #1976d2;
            color: white;
        }
        
        .btn-primary:hover {
            background: #1565c0;
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        
        .btn-secondary:hover {
            background: #5a6268;
        }
        
        .required {
            color: #f44336;
        }
        
        /* 반응형 디자인 */
        @media (max-width: 800px) {
            .main-container {
                flex-direction: column;
                height: auto;
                padding: 10px;
            }
            
            .nav-right {
                margin-top: 8px;
            }
            
            .nav-right a {
                margin-left: 16px;
                font-size: 14px;
            }
        }
        
        @media (max-width: 600px) {
            .nav-left .logo {
                font-size: 20px;
            }
            
            .nav-right a {
                margin-left: 12px;
                font-size: 13px;
            }
            
            .container {
                padding: 16px;
            }
        }
    </style>
</head>
<body>
    <!-- 인덱스와 동일한 네비게이션바 -->
    <div class="top-navbar">
        <div class="main-container">
            <div class="nav-left">
                <a href="index.jsp" class="logo" style="text-decoration:none; color:inherit;">📚 ReRead</a>
            </div>
            <div class="nav-right">
                <% if (isLoggedIn) { %>
                    <span style="margin-right: 10px;">안녕하세요, <%= username %>님!</span>
                    <a href="logout">로그아웃</a>
                <% } else { %>
                    <a href="login.jsp">로그인</a>
                    <a href="signup.jsp">회원가입</a>
                <% } %>
                <a href="mypage.jsp">마이페이지</a>
                <a href="cart.jsp">장바구니</a>
                <a href="bookRegister.jsp">책 등록</a>
                <a href="bookReview.jsp">리뷰 등록</a>
            </div>
        </div>
    </div>

    <div class="page-content">
        <div class="container">
            <div class="form-container">
                <div class="form-header">
                    <h2>게시글 수정</h2>
                    <p>게시글 정보를 수정하세요.</p>
                </div>
                
                <form action="editPost" method="post" onsubmit="return validateForm();">
                    <input type="hidden" name="postId" value="<%= post.getPostId() %>">
                    
                    <div class="form-group">
                        <label for="title">제목 <span class="required">*</span></label>
                        <input type="text" id="title" name="title" value="<%= post.getTitle() %>" 
                               required maxlength="100" placeholder="제목을 입력하세요">
                        <div class="char-count">
                            <span id="titleCount">0</span>/100
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="category">카테고리 <span class="required">*</span></label>
                        <select id="category" name="category" required>
                            <option value="">카테고리를 선택하세요</option>
                            <option value="자유" <%= "자유".equals(post.getCategory()) ? "selected" : "" %>>자유</option>
                            <option value="질문" <%= "질문".equals(post.getCategory()) ? "selected" : "" %>>질문</option>
                            <option value="정보" <%= "정보".equals(post.getCategory()) ? "selected" : "" %>>정보</option>
                            <option value="거래후기" <%= "거래후기".equals(post.getCategory()) ? "selected" : "" %>>거래후기</option>
                            <option value="공지" <%= "공지".equals(post.getCategory()) ? "selected" : "" %>>공지</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="content">내용 <span class="required">*</span></label>
                        <textarea id="content" name="content" required maxlength="2000" 
                                  placeholder="게시글 내용을 입력하세요"><%= post.getContent() %></textarea>
                        <div class="char-count">
                            <span id="contentCount">0</span>/2000
                        </div>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">수정 완료</button>
                        <a href="postView.jsp?postId=<%= post.getPostId() %>" class="btn btn-secondary">취소</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        // 글자 수 카운터
        function updateCharCount() {
            const title = document.getElementById('title');
            const content = document.getElementById('content');
            const titleCount = document.getElementById('titleCount');
            const contentCount = document.getElementById('contentCount');
            
            titleCount.textContent = title.value.length;
            contentCount.textContent = content.value.length;
        }
        
        // 페이지 로드 시 글자 수 초기화
        window.onload = function() {
            updateCharCount();
        };
        
        // 입력 시 글자 수 업데이트
        document.getElementById('title').addEventListener('input', updateCharCount);
        document.getElementById('content').addEventListener('input', updateCharCount);
        
        // 폼 검증
        function validateForm() {
            const title = document.getElementById('title').value.trim();
            const category = document.getElementById('category').value;
            const content = document.getElementById('content').value.trim();
            
            if (!title) {
                alert('제목을 입력해주세요.');
                return false;
            }
            
            if (!category) {
                alert('카테고리를 선택해주세요.');
                return false;
            }
            
            if (!content) {
                alert('내용을 입력해주세요.');
                return false;
            }
            
            if (title.length > 100) {
                alert('제목은 100자 이내로 입력해주세요.');
                return false;
            }
            
            if (content.length > 2000) {
                alert('내용은 2000자 이내로 입력해주세요.');
                return false;
            }
            
            return confirm('게시글을 수정하시겠습니까?');
        }
        
        // 에러 메시지 표시
        <% if (request.getParameter("error") != null) { %>
            alert('<%= request.getParameter("error") %>');
        <% } %>
    </script>
</body>
</html>