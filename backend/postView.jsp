<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>ReRead 게시글</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background: var(--main-bg);
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
        .view-container {
            max-width: 700px;
            margin: 90px auto 40px auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 16px rgba(0,0,0,0.09);
            padding: 40px 36px 36px 36px;
        }
        <%----------------포스트 컨테이너----------------%>
        .post-title-row {
            display: flex;
            align-items: center;
            gap: 18px;
            margin-bottom: 18px;
        }
        .post-title {
            font-size: 26px;
            font-weight: bold;
            color: #222;
        }
        .post-category {
            font-size: 15px;
            background: #e3e6ee;
            color: #007bff;
            border-radius: 12px;
            padding: 3px 15px;
            margin-left: 6px;
            font-weight: bold;
        }
        .post-info {
            font-size: 14px;
            color: #666;
            margin-bottom: 16px;
        }
        .post-content {
            font-size: 18px;
            color: #232323;
            white-space: pre-line;
            margin-bottom: 32px;
            min-height: 220px;
            word-break: break-all;
        }
        <%----------------버튼----------------%>
        .btn-group {
            text-align: right;
        }
        .btn {
            display: inline-block;
            margin-left: 6px;
            padding: 8px 16px;
            background: #007bff;
            color: #fff;
            border: none;
            border-radius: 6px;
            font-size: 15px;
            cursor: pointer;
        }
        .btn:hover {
            background: #0056b3;
        }
        .btn-delete {
            background: #dc3545;
        }
        .btn-delete:hover {
            background: #a71d2a;
        }
        <%----------------댓글----------------%>
        .comment-section {
            margin-top: 38px;
        }
        .comment-list {
            list-style: none;
            padding: 0;
            margin: 0 0 24px 0;
        }
        .comment-item {
            border-bottom: 1px solid #e3e3e3;
            padding: 13px 0;
            font-size: 15px;
            color: #333;
        }
        .comment-meta {
            color: #666;
            font-size: 13px;
            margin-bottom: 3px;
        }
        .comment-form textarea {
            width: 100%;
            min-height: 64px;
            font-size: 15px;
            padding: 9px 12px;
            border-radius: 5px;
            border: 1px solid #b9d2f7;
            margin-bottom: 8px;
            resize: vertical;
            box-sizing: border-box;
            background: #fafdff;
        }
        .comment-form button {
            background: #1976d2;
            color: #fff;
            border: none;
            padding: 7px 26px;
            border-radius: 7px;
            font-size: 15px;
            cursor: pointer;
            transition: background 0.14s;
        }
        .comment-form button:hover { background: #1257a8; }
    </style>
</head>
<body>
    <!-- 네비게이션 바 -->
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

    <!-- 본문 컨테이너 -->
    <div class="view-container">
        <div class="post-title-row">
            <span class="post-title">게시글 제목</span>
            <span class="post-category">질문</span>
        </div>
        <div class="post-info">
            작성자: 홍길동&nbsp; | &nbsp;작성일: 2025-05-20&nbsp; 
            <!-- 수정된 경우 아래처럼 표시 -->
            <!-- | &nbsp;수정일: 2025-05-21 -->
        </div>
        <div class="post-content">
            글 내용이 여기에 표시됩니다.
        </div>
        <div class="btn-group">
            <button class="btn" onclick="location.href='postEdit.jsp?postId=1'">수정</button>
            <button class="btn btn-delete" onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='postDelete.jsp?postId=1';">삭제</button>
        </div>
        
        <div class="comment-section">
            <h3 style="font-size:20px; margin-bottom:10px;">댓글</h3>
            <ul class="comment-list">
                <li class="comment-item">
                    <div class="comment-meta">hong123 | 2025-05-20</div>
                    	좋은 정보 감사합니다!
                </li>
                <li class="comment-item">
                    <div class="comment-meta">bad1536 | 2025-05-20</div>
                    	좋은 정보 감사합니다!
                </li>
            </ul>
            <!-- 댓글 작성 폼 -->
            <form class="comment-form" action="commentUpload.jsp" method="post">
                <textarea name="comment" placeholder="댓글을 입력하세요." required></textarea>
                <br>
                <button type="submit">댓글 작성</button>
            </form>
        </div>
    </div>
</body>
</html>
