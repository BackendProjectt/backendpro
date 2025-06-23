<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*, model.*, java.util.*" %>
<%
		String postIdStr = request.getParameter("postId");
		if (postIdStr == null) {
    postIdStr = request.getParameter("id");
		}
    
    int postId = Integer.parseInt(postIdStr);
    PostDAO postDAO = new PostDAO();
    Post post = postDAO.getPostById(postId);
    
    if (post == null) {
        response.sendRedirect("board.jsp?error=게시글을 찾을 수 없습니다.");
        return;
    }
    
    // 댓글 목록 조회
    CommentDAO commentDAO = new CommentDAO();
    List<Comment> comments = commentDAO.getCommentsByPostId(postId);
    
    String currentUserId = (String) session.getAttribute("userId");
    String username = (String) session.getAttribute("username");
    boolean isLoggedIn = (currentUserId != null);
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= post.getTitle() %> - ReRead</title>
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
        
        /* ✅ 메인페이지와 동일한 네비게이션 스타일 */
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
        
        /* 페이지 컨텐츠 영역 */
        .page-content {
            margin-top: 80px; /* 네비게이션바 높이만큼 여백 */
            padding: 20px;
        }
        
        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
        }
        
        .post-container {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-bottom: 30px;
        }
        
        .post-header {
            background: #f8f9fa;
            padding: 20px;
            border-bottom: 1px solid #e9ecef;
        }
        
        .post-title {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }
        
        .post-meta {
            color: #666;
            font-size: 14px;
        }
        
        .post-category {
            background: #1976d2;
            color: white;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            margin-right: 10px;
        }
        
        .post-content {
            padding: 30px;
            line-height: 1.6;
            color: #333;
            min-height: 200px;
        }
        
        .post-actions {
            padding: 20px;
            border-top: 1px solid #e9ecef;
            text-align: right;
            background: #f8f9fa;
        }
        
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
            margin-left: 5px;
        }
        
        .btn-primary {
            background: #1976d2;
            color: white;
        }
        
        .btn-warning {
            background: #ff9800;
            color: white;
        }
        
        .btn-danger {
            background: #f44336;
            color: white;
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        
        .comments-section {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 20px;
        }
        
        .comments-header {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
            border-bottom: 2px solid #1976d2;
            padding-bottom: 10px;
        }
        
        .comment-form {
            margin-bottom: 30px;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 8px;
        }
        
        .comment-form textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            resize: vertical;
            min-height: 80px;
            font-family: inherit;
            box-sizing: border-box;
        }
        
        .comment-form .form-actions {
            margin-top: 10px;
            text-align: right;
        }
        
        .comment-item {
            border-bottom: 1px solid #e9ecef;
            padding: 15px 0;
        }
        
        .comment-item:last-child {
            border-bottom: none;
        }
        
        .comment-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 8px;
        }
        
        .comment-author {
            font-weight: bold;
            color: #1976d2;
        }
        
        .comment-date {
            color: #666;
            font-size: 12px;
        }
        
        .comment-content {
            color: #333;
            line-height: 1.5;
            margin-bottom: 8px;
        }
        
        .comment-actions {
            text-align: right;
        }
        
        .comment-actions .btn {
            font-size: 12px;
            padding: 4px 8px;
        }
        
        .no-comments {
            text-align: center;
            color: #666;
            font-style: italic;
            padding: 40px;
        }
        
        .login-notice {
            background: #e3f2fd;
            border: 1px solid #1976d2;
            border-radius: 4px;
            padding: 15px;
            text-align: center;
            color: #1976d2;
        }
        
        .login-notice a {
            color: #1976d2;
            font-weight: bold;
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
    <!-- ✅ 메인페이지와 동일한 네비게이션바 -->
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
            <!-- 게시글 내용 -->
            <div class="post-container">
                <div class="post-header">
                    <div class="post-title"><%= post.getTitle() %></div>
                    <div class="post-meta">
                        <span class="post-category"><%= post.getCategory() %></span>
                        작성자: <%= post.getUsername() %> | 
                        작성일: <%= post.getCreatedAt().format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")) %>
                        <% if (post.getUpdatedAt() != null) { %>
                            | 수정일: <%= post.getUpdatedAt().format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")) %>
                        <% } %>
                    </div>
                </div>
                
                <div class="post-content">
                    <%= post.getContent().replace("\n", "<br>") %>
                </div>
                
                <div class="post-actions">
                    <a href="board.jsp" class="btn btn-secondary">목록으로</a>
                    <% if (currentUserId != null && currentUserId.equals(post.getAuthorId())) { %>
                        <a href="editPost?postId=<%= post.getPostId() %>" class="btn btn-primary">수정</a>
                        <form action="deletePost" method="post" style="display: inline;" 
                              onsubmit="return confirm('정말 삭제하시겠습니까?');">
                            <input type="hidden" name="postId" value="<%= post.getPostId() %>">
                            <button type="submit" class="btn btn-danger">삭제</button>
                        </form>
                    <% } %>
                </div>
            </div>
            
            <!-- 댓글 섹션 -->
            <div class="comments-section">
                <div class="comments-header">
                    댓글 (<%= comments.size() %>개)
                </div>
                
                <!-- 댓글 작성 폼 -->
                <% if (currentUserId != null) { %>
                    <div class="comment-form">
                        <form action="addComment" method="post">
                            <input type="hidden" name="postId" value="<%= post.getPostId() %>">
                            <textarea name="content" placeholder="댓글을 입력하세요..." required></textarea>
                            <div class="form-actions">
                                <button type="submit" class="btn btn-primary">댓글 등록</button>
                            </div>
                        </form>
                    </div>
                <% } else { %>
                    <div class="login-notice">
                        댓글을 작성하려면 <a href="login.jsp">로그인</a>이 필요합니다.
                    </div>
                <% } %>
                
                <!-- 댓글 목록 -->
                <% if (comments != null && !comments.isEmpty()) { %>
                    <% for (Comment comment : comments) { %>
                        <div class="comment-item">
                            <div class="comment-header">
                                <span class="comment-author"><%= comment.getUsername() %></span>
                                <span class="comment-date">
                                    <%= comment.getCreatedAt().format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")) %>
                                </span>
                            </div>
                            <div class="comment-content">
                                <%= comment.getContent().replace("\n", "<br>") %>
                            </div>
                            <% if (currentUserId != null && currentUserId.equals(comment.getUserId())) { %>
                                <div class="comment-actions">
                                    <form action="deleteComment" method="post" style="display: inline;" 
                                          onsubmit="return confirm('정말 삭제하시겠습니까?');">
                                        <input type="hidden" name="commentId" value="<%= comment.getCommentId() %>">
                                        <input type="hidden" name="postId" value="<%= post.getPostId() %>">
                                        <button type="submit" class="btn btn-danger">삭제</button>
                                    </form>
                                </div>
                            <% } %>
                        </div>
                    <% } %>
                <% } else { %>
                    <div class="no-comments">
                        첫 번째 댓글을 작성해보세요!
                    </div>
                <% } %>
            </div>
        </div>
    </div>

    <script>
        // 에러/성공 메시지 표시
        <% if (request.getParameter("error") != null) { %>
            alert('<%= request.getParameter("error") %>');
        <% } %>
        
        <% if (request.getParameter("success") != null) { %>
            alert('<%= request.getParameter("success") %>');
        <% } %>
    </script>
</body>
</html>