package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CommentDAO;
import model.Comment;

@WebServlet("/addComment")
public class AddCommentServlet extends HttpServlet {
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
            String postIdParam = request.getParameter("postId");
            String content = request.getParameter("content");
            
            System.out.println("AddComment - postId: " + postIdParam + ", content: " + content);
            
            if (postIdParam == null || postIdParam.trim().isEmpty()) {
                System.out.println("AddComment - postId is null or empty");
                response.sendRedirect("board.jsp?error=게시글 ID가 없습니다.");
                return;
            }
            
            int postId = Integer.parseInt(postIdParam);
            
            if (content == null || content.trim().isEmpty()) {
                response.sendRedirect("postView.jsp?postId=" + postId + "&error=댓글 내용을 입력해주세요.");
                return;
            }
            
            Comment comment = new Comment();
            comment.setPostId(postId);
            comment.setUserId(userId);
            comment.setUsername(username);
            comment.setContent(content.trim());
            CommentDAO commentDAO = new CommentDAO();
            boolean success = commentDAO.addComment(comment);
            
            if (success) {
                response.sendRedirect("postView.jsp?postId=" + postId);
            } else {
                response.sendRedirect("postView.jsp?postId=" + postId + "&error=fail");
            }
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("board.jsp?error=잘못된 요청입니다.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("board.jsp?error=시스템 오류가 발생했습니다.");
        }
    }
}