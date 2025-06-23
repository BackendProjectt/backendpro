<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*, model.*, java.util.*" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    String userId = (String) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    UserDAO userDAO = new UserDAO();
    BookDAO bookDAO = new BookDAO();
    PostDAO postDAO = new PostDAO();
    
    User currentUser = userDAO.getUserById(userId);
    List<Book> myBooks = bookDAO.getBooksBySellerId(userId);
    List<Post> myPosts = postDAO.getPostsByUserId(userId);
    
    // ✅ DateTimeFormatter 사용 (SimpleDateFormat 대신)
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    
    // 로그인 상태 확인
    String username = (String) session.getAttribute("username");
    boolean isLoggedIn = (userId != null);
%>
<!DOCTYPE html>
<html>
<head>
    <title>마이페이지 - ReRead</title>
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
        
        .header {
            text-align: center;
            font-size: 36px;
            font-weight: 900;
            margin: 40px 0;
            color: var(--main-blue);
            letter-spacing: 2px;
            text-shadow: 0 2px 8px rgba(25,118,210,0.08);
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .section {
            background: white;
            margin-bottom: 30px;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 4px 24px rgba(30, 144, 255, 0.13);
            transition: box-shadow 0.18s;
        }
        
        .section:hover {
            box-shadow: 0 8px 32px rgba(25,118,210,0.17);
        }
        
        .section h2 {
            color: var(--main-blue);
            margin-bottom: 20px;
            border-bottom: 2px solid var(--main-blue);
            padding-bottom: 10px;
            font-size: 24px;
            font-weight: 700;
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
        
        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1.5px solid #e3eaf3;
            border-radius: 8px;
            font-size: 14px;
            box-sizing: border-box;
            transition: border-color 0.18s;
        }
        
        .form-group input:focus {
            border-color: var(--main-blue);
            outline: none;
        }
        
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            margin-right: 10px;
            margin-bottom: 10px;
            transition: all 0.18s;
        }
        
        .btn-primary {
            background: var(--main-blue);
            color: white;
        }
        
        .btn-primary:hover {
            background: var(--main-blue-dark);
            transform: translateY(-2px);
        }
        
        .btn-view {
            background: #4caf50;
            color: white;
            font-size: 12px;
            padding: 6px 12px;
        }
        
        .btn-delete {
            background: #f44336;
            color: white;
            font-size: 12px;
            padding: 6px 12px;
        }
        
        .btn-edit {
            background: #ff9800;
            color: white;
            font-size: 12px;
            padding: 6px 12px;
        }
        
        .btn-danger {
            background: #dc3545;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.18s;
        }
        
        .btn-danger:hover {
            background: #c82333;
            transform: translateY(-2px);
        }
        
        .tabs {
            margin-bottom: 20px;
            border-bottom: 1px solid #ddd;
        }
        
        .tab-button {
            padding: 12px 24px;
            border: none;
            background: none;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            color: #666;
            border-bottom: 2px solid transparent;
            transition: all 0.18s;
        }
        
        .tab-button.active {
            color: var(--main-blue);
            border-bottom-color: var(--main-blue);
        }
        
        .tab-button:hover {
            color: var(--main-blue);
        }
        
        .tab-content {
            margin-top: 20px;
        }
        
        .book-grid, .post-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 24px;
            margin-top: 20px;
        }
        
        .book-item, .post-item {
            border: 1px solid #e3eaf3;
            border-radius: 12px;
            padding: 20px;
            background: white;
            transition: all 0.18s;
            box-shadow: 0 2px 8px rgba(25,118,210,0.08);
        }
        
        .book-item:hover, .post-item:hover {
            box-shadow: 0 8px 24px rgba(25,118,210,0.15);
            transform: translateY(-4px);
        }
        
        .book-item img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 12px;
        }
        
        .book-info h4, .post-info h4 {
            margin: 0 0 10px 0;
            color: #333;
            font-size: 18px;
            font-weight: 700;
        }
        
        .book-info p, .post-info p {
            margin: 6px 0;
            color: #666;
            font-size: 14px;
        }
        
        .status.available {
            color: #4caf50;
            font-weight: bold;
        }
        
        .status.sold {
            color: #f44336;
            font-weight: bold;
        }
        
        .no-data {
            text-align: center;
            color: #666;
            font-style: italic;
            padding: 60px;
            background: #f8f9fa;
            border-radius: 12px;
            margin: 20px 0;
        }
        
        .comments-list {
            margin-top: 20px;
        }
        
        .comment-item {
            border: 1px solid #e3eaf3;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 16px;
            background: #f8f9fa;
            transition: all 0.18s;
        }
        
        .comment-item:hover {
            box-shadow: 0 4px 16px rgba(25,118,210,0.12);
        }
        
        .comment-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
            border-bottom: 1px solid #e0e0e0;
            padding-bottom: 8px;
        }
        
        .comment-header h5 {
            margin: 0;
            color: var(--main-blue);
            font-size: 16px;
            font-weight: 600;
        }
        
        .comment-date {
            font-size: 12px;
            color: #999;
        }
        
        .comment-content {
            margin: 12px 0;
            line-height: 1.6;
            color: #333;
        }
        
        .comment-actions {
            text-align: right;
        }
        
        .comment-actions .btn {
            font-size: 12px;
            margin-left: 8px;
        }
        
        .danger-zone {
            border: 2px solid #dc3545;
            border-radius: 12px;
            padding: 24px;
            background: #fff5f5;
            margin-top: 20px;
        }
        
        .danger-zone h3 {
            color: #dc3545;
            margin-top: 0;
            font-size: 20px;
            font-weight: 700;
        }
        
        .danger-zone ul {
            color: #666;
            margin: 16px 0;
            padding-left: 24px;
        }
        
        .danger-zone li {
            margin: 10px 0;
            line-height: 1.5;
        }
        
        .delete-form {
            margin-top: 24px;
            padding-top: 24px;
            border-top: 1px solid #dc3545;
        }
        
        .delete-form h4 {
            color: #dc3545;
            margin-bottom: 16px;
            font-size: 18px;
            font-weight: 600;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        
        table td {
            padding: 12px 16px;
            border-bottom: 1px solid #f0f0f0;
            vertical-align: middle;
        }
        
        table td:first-child {
            font-weight: bold;
            width: 140px;
            color: #333;
            background: #f8f9fa;
        }
        
        table input[readonly] {
            background: #f5f5f5;
            color: #666;
            border: 1px solid #e0e0e0;
        }
        
        /* 반응형 디자인 */
        @media (max-width: 1100px) {
            .main-container { padding: 0 16px; }
            .container { padding: 16px; }
        }
        
        @media (max-width: 800px) {
            .header { font-size: 28px; margin: 30px 0; }
            .book-grid, .post-grid { grid-template-columns: 1fr; }
            .main-container { flex-direction: column; height: auto; padding: 10px; }
            .nav-right { margin-top: 8px; }
            .nav-right a { margin-left: 16px; font-size: 14px; }
        }
        
        @media (max-width: 600px) {
            .header { font-size: 24px; }
            .section { padding: 20px; margin-bottom: 20px; }
            .nav-left .logo { font-size: 20px; }
            .nav-right a { margin-left: 12px; font-size: 13px; }
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
        <div class="header">📚 마이페이지</div>

        <div class="container">
            <!-- 개인정보 수정 -->
            <div class="section">
                <h2>개인정보 수정</h2>
                <form action="updateUser" method="post">
                    <table>
                        <tr>
                            <td>가입일</td>
                            <!-- ✅ 수정: LocalDateTime을 DateTimeFormatter로 포맷 -->
                            <td><input type="text" name="date" value="<%= currentUser.getJoinDate().format(dateFormatter) %>" readonly></td>
                        </tr>
                        <tr>
                            <td>아이디</td>
                            <td><input type="text" name="id" value="<%= currentUser.getUserId() %>" readonly></td>
                        </tr>
                        <tr>
                            <td>이름</td>
                            <td><input type="text" name="name" value="<%= currentUser.getUsername() %>" required></td>
                        </tr>
                        <tr>
                            <td>이메일</td>
                            <td><input type="email" name="email" value="<%= currentUser.getEmail() %>" required></td>
                        </tr>
                    </table>
                    <button type="submit" class="btn btn-primary">정보 수정</button>
                </form>
            </div>
            
            <!-- 판매도서/작성글/댓글 관리 -->
            <div class="section">
                <h2>나의 활동</h2>
                <div class="tabs">
                    <button class="tab-button active" onclick="showTab('books')">판매도서</button>
                    <button class="tab-button" onclick="showTab('posts')">작성글</button>
                    <button class="tab-button" onclick="showTab('comments')">작성댓글</button>
                </div>
                
                <div class="tab-content">
                    <!-- 판매도서 탭 -->
                    <div id="books-tab">
                        <h3>나의 판매도서</h3>
                        <%
                        if (myBooks != null && !myBooks.isEmpty()) {
                        %>
                            <div class="book-grid">
                                <%
                                for (Book book : myBooks) {
                                %>
                                    <div class="book-item">
                                        <% if (book.getImagePath() != null && !book.getImagePath().isEmpty()) { %>
                                            <img src="<%= book.getImagePath() %>" alt="<%= book.getTitle() %>" onerror="this.src='https://via.placeholder.com/200x250?text=No+Image'">
                                        <% } else { %>
                                            <img src="https://via.placeholder.com/200x250?text=No+Image" alt="<%= book.getTitle() %>">
                                        <% } %>
                                        
                                        <div class="book-info">
                                            <h4><%= book.getTitle() %></h4>
                                            <p>저자: <%= book.getAuthor() %></p>
                                            <p>가격: <%= String.format("%,d", book.getPrice()) %>원</p>
                                            <p>상태: 
                                                <span class="status <%= book.getStatus().equals("판매중") ? "available" : "sold" %>">
                                                    <%= book.getStatus() %>
                                                </span>
                                            </p>
                                            <div class="book-actions">
                                                <a href="bookdetail.jsp?bookId=<%= book.getBookId() %>" class="btn btn-view">상세보기</a>
                                                <form action="bookDelete" method="post" style="display: inline;" 
                                                      onsubmit="return confirm('정말 삭제하시겠습니까?');">
                                                    <input type="hidden" name="bookId" value="<%= book.getBookId() %>">
                                                    <button type="submit" class="btn btn-delete">삭제</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                <%
                                }
                                %>
                            </div>
                        <%
                        } else {
                        %>
                            <p class="no-data">등록된 책이 없습니다.</p>
                        <%
                        }
                        %>
                    </div>
                    
                    <!-- 작성글 탭 -->
                    <div id="posts-tab" style="display: none;">
                        <h3>작성한 게시글</h3>
                        <%
                        if (myPosts != null && !myPosts.isEmpty()) {
                        %>
                            <div class="post-grid">
                                <%
                                for (Post post : myPosts) {
                                %>
                                    <div class="post-item">
                                        <div class="post-info">
                                            <h4><%= post.getTitle() %></h4>
                                            <p>카테고리: <%= post.getCategory() %></p>
                                            <!-- ✅ 수정: LocalDateTime을 DateTimeFormatter로 포맷 -->
                                            <p>작성일: <%= post.getCreatedAt().format(dateFormatter) %></p>
                                            <% if (post.getUpdatedAt() != null) { %>
                                                <p>수정일: <%= post.getUpdatedAt().format(dateFormatter) %></p>
                                            <% } %>
                                            <div class="post-actions">
                                                <a href="postView.jsp?id=<%= post.getPostId() %>" class="btn btn-view">보기</a>
                                                <a href="editPost?id=<%= post.getPostId() %>" class="btn btn-edit">수정</a>
                                                <form action="deletePost" method="post" style="display: inline;" 
                                                      onsubmit="return confirm('정말 삭제하시겠습니까?');">
                                                    <input type="hidden" name="postId" value="<%= post.getPostId() %>">
                                                    <button type="submit" class="btn btn-delete">삭제</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                <%
                                }
                                %>
                            </div>
                        <%
                        } else {
                        %>
                            <p class="no-data">작성한 게시글이 없습니다.</p>
                        <%
                        }
                        %>
                    </div>
                    
                    <!-- 작성댓글 탭 -->
                    <div id="comments-tab" style="display: none;">
                        <h3>작성한 댓글</h3>
                        <%
                        dao.CommentDAO commentDAO = new dao.CommentDAO();
                        java.util.List<model.Comment> myComments = commentDAO.getCommentsByUserId(userId);
                        
                        if (myComments != null && !myComments.isEmpty()) {
                        %>
                            <div class="comments-list">
                                <%
                                for (model.Comment comment : myComments) {
                                %>
                                    <div class="comment-item">
                                        <div class="comment-header">
                                            <h5>게시글: <%= comment.getUsername() %></h5>
                                            <!-- ✅ 수정: LocalDateTime을 DateTimeFormatter로 포맷 -->
                                            <span class="comment-date"><%= comment.getCreatedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")) %></span>
                                        </div>
                                        <div class="comment-content">
                                            <%= comment.getContent() %>
                                        </div>
                                        <div class="comment-actions">
                                            <a href="postView.jsp?id=<%= comment.getPostId() %>" class="btn btn-view">게시글 보기</a>
                                            <form action="deleteComment" method="post" style="display: inline;" 
                                                  onsubmit="return confirm('정말 삭제하시겠습니까?');">
                                                <input type="hidden" name="commentId" value="<%= comment.getCommentId() %>">
                                                <input type="hidden" name="postId" value="<%= comment.getPostId() %>">
                                                <button type="submit" class="btn btn-delete">삭제</button>
                                            </form>
                                        </div>
                                    </div>
                                <%
                                }
                                %>
                            </div>
                        <%
                        } else {
                        %>
                            <p class="no-data">작성한 댓글이 없습니다.</p>
                        <%
                        }
                        %>
                    </div>
                </div>
            </div>
            
            <!-- 회원탈퇴 섹션 -->
            <div class="section">
                <h2>회원탈퇴</h2>
                <div class="danger-zone">
                    <h3>⚠️ 주의사항</h3>
                    <ul>
                        <li>회원탈퇴 시 모든 개인정보가 삭제됩니다.</li>
                        <li>작성한 게시글, 댓글, 리뷰가 모두 삭제됩니다.</li>
                        <li>등록한 책 정보와 구매/판매 내역이 삭제됩니다.</li>
                        <li>삭제된 정보는 복구할 수 없습니다.</li>
                    </ul>
                    
                    <div class="delete-form">
                        <h4>비밀번호를 입력하여 회원탈퇴를 진행해주세요</h4>
                        <form action="deleteMember" method="post" onsubmit="return confirmDelete();">
                            <div class="form-group">
                                <label for="password">비밀번호 확인:</label>
                                <input type="password" id="password" name="password" required 
                                       placeholder="현재 비밀번호를 입력하세요">
                            </div>
                            <button type="submit" class="btn btn-danger">회원탈퇴</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // 탭 전환 기능
        function showTab(tabName) {
            // 모든 탭 버튼 비활성화
            document.querySelectorAll('.tab-button').forEach(btn => {
                btn.classList.remove('active');
            });
            
            // 모든 탭 컨텐츠 숨기기
            document.querySelectorAll('[id$="-tab"]').forEach(content => {
                content.style.display = 'none';
            });
            
            // 선택된 탭 버튼 활성화
            event.target.classList.add('active');
            
            // 해당 탭 컨텐츠 보이기
            document.getElementById(tabName + '-tab').style.display = 'block';
        }
        
        // 회원탈퇴 확인
        function confirmDelete() {
            return confirm('정말로 회원탈퇴를 하시겠습니까?\n\n이 작업은 되돌릴 수 없으며, 모든 정보가 영구적으로 삭제됩니다.');
        }
        
        // 에러/성공 메시지 표시
        <% if (request.getParameter("error") != null) { %>
            alert('<%= request.getParameter("error") %>');
        <% } %>
        
        <% if (request.getParameter("success") != null) { %>
            alert('<%= request.getParameter("success") %>');
        <% } %>
        
        <% if (request.getAttribute("error") != null) { %>
            alert('<%= request.getAttribute("error") %>');
        <% } %>
        
        <% if (request.getAttribute("success") != null) { %>
            alert('<%= request.getAttribute("success") %>');
        <% } %>
    </script>
</body>
</html>