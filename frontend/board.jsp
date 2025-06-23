w<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.PostDAO" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="model.Post" %>
<%@ page import="model.User" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    // 현재 선택된 카테고리 확인 (기본값: 전체)
    String selectedCategory = request.getParameter("category");
    
    PostDAO postDAO = new PostDAO();
    List<Post> posts = null;
    String dbStatus = "DB 연결 실패";
    
    try {
        // 카테고리에 따라 다른 게시글 로드
        if ("자유".equals(selectedCategory)) {
            posts = postDAO.getPostsByCategory("자유");
            dbStatus = "DB 연결 성공 - 자유게시판 " + posts.size() + "개의 게시글 로드됨";
        } else if ("질문".equals(selectedCategory)) {
            posts = postDAO.getPostsByCategory("질문");
            dbStatus = "DB 연결 성공 - 질문게시판 " + posts.size() + "개의 게시글 로드됨";
        } else {
            posts = postDAO.getAllPosts(1, 50);  // 전체 게시글
            dbStatus = "DB 연결 성공 - " + posts.size() + "개의 게시글 로드됨";
        }
    } catch (Exception e) {
        e.printStackTrace();
        posts = new ArrayList<>();
        dbStatus = "DB 연결 에러: " + e.getMessage();
    }
    
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
    
    // 로그인 상태 확인
    String userId = (String) session.getAttribute("userId");
    String username = (String) session.getAttribute("username");
    boolean isLoggedIn = (userId != null);
%>
<!DOCTYPE html>
<html>
<head>
    <title>게시판 - ReRead</title>
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
        
        /* 메인페이지와 동일한 네비게이션 스타일 */
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
        
        /* 페이지 컨텐츠 */
        .page-content {
            margin-top: 80px;
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
        
        /* 카테고리 버튼 스타일 */
        .category-buttons {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .category-btn {
            display: inline-block;
            padding: 12px 30px;
            margin: 0 10px;
            border: 2px solid var(--main-blue);
            border-radius: 25px;
            background: white;
            color: var(--main-blue);
            text-decoration: none;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        
        .category-btn:hover {
            background: var(--main-blue);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 118, 210, 0.3);
        }
        
        .category-btn.active {
            background: var(--main-blue);
            color: white;
            box-shadow: 0 4px 15px rgba(25, 118, 210, 0.4);
        }
        
        .write-btn {
            text-align: right;
            margin-bottom: 20px;
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
        
        .posts-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        .posts-table th {
            background: var(--main-blue);
            color: white;
            padding: 15px 10px;
            text-align: center;
            font-weight: 600;
            border: none;
        }
        
        .posts-table td {
            padding: 12px 10px;
            text-align: center;
            border-bottom: 1px solid #e3eaf3;
            vertical-align: middle;
        }
        
        .posts-table tbody tr:hover {
            background: #f8f9fa;
        }
        
        .posts-table a {
            color: #333;
            text-decoration: none;
            font-weight: 500;
        }
        
        .posts-table a:hover {
            color: var(--main-blue);
            text-decoration: underline;
        }
        
        .db-status {
            text-align: center;
            margin: 20px 0;
            padding: 12px;
            background: #f0f8ff;
            border-radius: 8px;
            font-size: 14px;
            color: var(--main-blue);
            border: 1px solid #e3eaf3;
        }
        
        .no-posts {
            text-align: center;
            color: #666;
            font-style: italic;
            padding: 60px;
            background: #f8f9fa;
            border-radius: 12px;
            margin: 20px 0;
        }
        
        .category-tag {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
            margin-right: 8px;
        }
        
        .category-free {
            background: #e3f2fd;
            color: #1976d2;
        }
        
        .category-question {
            background: #fff3e0;
            color: #f57c00;
        }
        
        /* 반응형 디자인 */
        @media (max-width: 800px) {
            .posts-table {
                font-size: 14px;
            }
            
            .posts-table th,
            .posts-table td {
                padding: 8px 5px;
            }
            
            .header {
                font-size: 28px;
            }
            
            .main-container {
                flex-direction: column;
                height: auto;
                padding: 10px;
            }
            
            .nav-right {
                margin-top: 8px;
            }
            
            .category-btn {
                padding: 10px 20px;
                margin: 5px;
                font-size: 14px;
            }
        }
        
        @media (max-width: 600px) {
            .posts-table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
            }
            
            .header {
                font-size: 24px;
            }
            
            .section {
                padding: 20px;
            }
            
            .category-buttons {
                margin-bottom: 20px;
            }
            
            .category-btn {
                display: block;
                margin: 5px auto;
                max-width: 200px;
            }
        }
    </style>
</head>
<body>
    <!-- 메인페이지와 동일한 네비게이션바 -->
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
        <div class="header">📌 게시판</div>

        <div class="container">
            <!-- DB 상태 표시 -->
            <div class="db-status"><%= dbStatus %></div>
            
            <!-- 카테고리 버튼들 -->
            <div class="category-buttons">
                <a href="board.jsp" class="category-btn <%= (selectedCategory == null) ? "active" : "" %>">
                     전체
                </a>
                <a href="board.jsp?category=자유" class="category-btn <%= "자유".equals(selectedCategory) ? "active" : "" %>">
                     자유
                </a>
                <a href="board.jsp?category=질문" class="category-btn <%= "질문".equals(selectedCategory) ? "active" : "" %>">
                     질문
                </a>
            </div>
            
            <div class="section">
                <div class="write-btn">
                    <% if (isLoggedIn) { %>
                        <% if ("자유".equals(selectedCategory)) { %>
                            <a href="postWrite.jsp?category=자유" class="btn btn-primary">글쓰기</a>
                        <% } else if ("질문".equals(selectedCategory)) { %>
                            <a href="postWrite.jsp?category=질문" class="btn btn-primary">글쓰기</a>
                        <% } else { %>
                            <a href="postWrite.jsp" class="btn btn-primary">글쓰기</a>
                        <% } %>
                    <% } else { %>
                        <a href="login.jsp" class="btn btn-primary">로그인 후 글쓰기</a>
                    <% } %>
                </div>
                
                <% if (posts != null && !posts.isEmpty()) { %>
                    <table class="posts-table">
                        <thead>
                            <tr>
                                <th style="width: 8%;">번호</th>
                                <% if (selectedCategory == null) { %>
                                    <th style="width: 12%;">카테고리</th>
                                    <th style="width: 45%;">제목</th>
                                <% } else { %>
                                    <th style="width: 57%;">제목</th>
                                <% } %>
                                <th style="width: 15%;">작성자</th>
                                <th style="width: 20%;">작성일</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                            UserDAO userDAO = new UserDAO();
                            for (int i = 0; i < posts.size(); i++) { 
                                Post post = posts.get(i);
                                String authorName = "Unknown";
                                
                                try {
                                    if (post.getAuthorId() != null) {
                                        User author = userDAO.getUserById(post.getAuthorId());
                                        if (author != null) {
                                            authorName = author.getUsername();
                                        }
                                    }
                                } catch (Exception e) {
                                    authorName = "Unknown";
                                }
                            %>
                                <tr>
                                    <td><%= posts.size() - i %></td>
                                    <% if (selectedCategory == null) { %>
                                        <td>
                                            <span class="category-tag <%= "자유".equals(post.getCategory()) ? "category-free" : "category-question" %>">
                                                <%= post.getCategory() %>
                                            </span>
                                        </td>
                                    <% } %>
                                    <td style="text-align: left; padding-left: 20px;">
                                        <a href="postView.jsp?id=<%= post.getPostId() %>">
                                            <% if ("질문".equals(post.getCategory())) { %>
                                                <span style="color: #f57c00; font-weight: bold;"></span>
                                            <% } %>
                                            <%= post.getTitle() %>
                                        </a>
                                    </td>
                                    <td><%= authorName %></td>
                                    <td><%= post.getCreatedAt().format(dateFormatter) %></td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                <% } else { %>
                    <div class="no-posts">
                        <% if ("자유".equals(selectedCategory)) { %>
                            등록된 자유게시글이 없습니다.
                        <% } else if ("질문".equals(selectedCategory)) { %>
                            등록된 질문이 없습니다.
                        <% } else { %>
                            등록된 게시글이 없습니다.
                        <% } %>
                        <br><br>
                        <% if (isLoggedIn) { %>
                            첫 번째 글을 작성해보세요!
                        <% } else { %>
                            로그인 후 글을 작성할 수 있습니다.
                        <% } %>
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
        
        // 버튼 클릭 애니메이션
        document.addEventListener('DOMContentLoaded', function() {
            const categoryBtns = document.querySelectorAll('.category-btn');
            
            categoryBtns.forEach(btn => {
                btn.addEventListener('click', function(e) {
                    // 클릭 효과
                    this.style.transform = 'scale(0.95)';
                    setTimeout(() => {
                        this.style.transform = 'translateY(-2px)';
                    }, 100);
                });
            });
        });
    </script>
</body>
</html>