package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.PostDAO;
import model.Post;

@WebServlet("/editPost")
public class PostEditServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        // 세션 확인
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            // postId 또는 id 파라미터 모두 처리
            String postIdParam = request.getParameter("postId");
            if (postIdParam == null) {
                postIdParam = request.getParameter("id");
            }
            
            if (postIdParam == null) {
                response.sendRedirect("board.jsp?error=게시글 ID가 없습니다.");
                return;
            }
            
            int postId = Integer.parseInt(postIdParam);
            PostDAO postDAO = new PostDAO();
            Post post = postDAO.getPostById(postId);
            
            if (post == null) {
                response.sendRedirect("board.jsp?error=게시글을 찾을 수 없습니다.");
                return;
            }
            
            // 작성자 본인인지 확인
            if (!userId.equals(post.getAuthorId())) {
                response.sendRedirect("postView.jsp?postId=" + postId + "&error=수정 권한이 없습니다.");
                return;
            }
            
            // 수정 폼으로 데이터 전달
            request.setAttribute("post", post);
            request.getRequestDispatcher("postEdit.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect("board.jsp?error=잘못된 요청입니다.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("board.jsp?error=시스템 오류가 발생했습니다.");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        // 세션 확인
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            // POST에서는 hidden input의 postId를 받음
            String postIdParam = request.getParameter("postId");
            if (postIdParam == null) {
                System.out.println("PostEdit POST - postId parameter is null");
                response.sendRedirect("board.jsp?error=게시글 ID가 없습니다.");
                return;
            }
            
            int postId = Integer.parseInt(postIdParam);
            String title = request.getParameter("title");
            String category = request.getParameter("category");
            String content = request.getParameter("content");
            
            System.out.println("PostEdit POST - postId: " + postId + ", title: " + title);
            
            // 입력값 검증
            if (title == null || title.trim().isEmpty() || 
                content == null || content.trim().isEmpty() ||
                category == null || category.trim().isEmpty()) {
                
                response.sendRedirect("editPost?postId=" + postId + "&error=모든 필드를 입력해주세요.");
                return;
            }
            
            PostDAO postDAO = new PostDAO();
            Post existingPost = postDAO.getPostById(postId);
            
            if (existingPost == null) {
                response.sendRedirect("board.jsp?error=게시글을 찾을 수 없습니다.");
                return;
            }
            
            // 작성자 본인인지 확인
            if (!userId.equals(existingPost.getAuthorId())) {
                response.sendRedirect("postView.jsp?postId=" + postId + "&error=수정 권한이 없습니다.");
                return;
            }
            
            // 게시글 수정
            Post updatedPost = new Post();
            updatedPost.setPostId(postId);
            updatedPost.setTitle(title.trim());
            updatedPost.setCategory(category);
            updatedPost.setContent(content.trim());
            updatedPost.setAuthorId(userId);
            updatedPost.setUsername(existingPost.getUsername());
            
            boolean success = postDAO.updatePost(updatedPost);
            
            System.out.println("PostEdit POST - update success: " + success);
            
            if (success) {
                System.out.println("PostEdit POST - redirecting to postView.jsp?postId=" + postId);
                response.sendRedirect("postView.jsp?postId=" + postId);
            } else {
                System.out.println("PostEdit POST - update failed, redirecting back to edit form");
                // 한글 메시지 제거
                response.sendRedirect("editPost?postId=" + postId + "&error=update_failed");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("board.jsp?error=잘못된 요청입니다.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("board.jsp?error=시스템 오류가 발생했습니다.");
        }
    }
}