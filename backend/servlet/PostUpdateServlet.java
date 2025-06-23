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

@WebServlet("/updatePost")
public class PostUpdateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            int postId = Integer.parseInt(request.getParameter("postId"));
            String title = request.getParameter("title");
            String category = request.getParameter("category");
            String content = request.getParameter("content");
            
            // 입력값 검증
            if (title == null || title.trim().isEmpty() || 
                content == null || content.trim().isEmpty()) {
                response.sendRedirect("editPost?id=" + postId + "&error=제목과 내용을 입력해주세요.");
                return;
            }
            
            PostDAO postDAO = new PostDAO();
            Post existingPost = postDAO.getPostById(postId);
            
            // 작성자 확인
            if (existingPost == null || !existingPost.getUserId().equals(userId)) {
                response.sendRedirect("board.jsp?error=수정 권한이 없습니다.");
                return;
            }
            
            Post post = new Post();
            post.setPostId(postId);
            post.setTitle(title.trim());
            post.setCategory(category);
            post.setContent(content.trim());
            post.setUserId(userId);  // ✅ 올바른 메소드 사용
            
            boolean success = postDAO.updatePost(post);
            
            if (success) {
                response.sendRedirect("postView.jsp?id=" + postId + "&success=게시글이 수정되었습니다.");
            } else {
                response.sendRedirect("editPost?id=" + postId + "&error=게시글 수정에 실패했습니다.");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("board.jsp?error=잘못된 요청입니다.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("board.jsp?error=오류가 발생했습니다.");
        }
    }
}