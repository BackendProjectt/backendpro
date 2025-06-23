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

@WebServlet("/postUpload")
public class PostUploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        String username = (String) session.getAttribute("username");
        
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            String title = request.getParameter("title");
            String category = request.getParameter("category");
            String content = request.getParameter("content");
            
            if (title == null || title.trim().isEmpty() || 
                content == null || content.trim().isEmpty() ||
                category == null || category.trim().isEmpty()) {
                
                response.sendRedirect("postWrite.jsp?error=모든 항목을 입력해주세요.");
                return;
            }
            
            Post post = new Post();
            post.setTitle(title.trim());
            post.setCategory(category);
            post.setContent(content.trim());
            post.setAuthorId(userId);
            post.setUsername(username);
            PostDAO postDAO = new PostDAO();
            boolean success = postDAO.addPost(post);
            
            if (success) {
                response.sendRedirect("board.jsp");
            } else {
                response.sendRedirect("postWrite.jsp?error=게시글 작성에 실패했습니다.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("postWrite.jsp?error=시스템 오류가 발생했습니다.");
        }
    }
}