package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CommentDAO;

@WebServlet("/deleteComment")
public class DeleteCommentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            String commentIdParam = request.getParameter("commentId");
            String postIdParam = request.getParameter("postId");
            
            System.out.println("DeleteComment - commentId: " + commentIdParam + ", postId: " + postIdParam);
            
            if (commentIdParam == null || postIdParam == null) {
                System.out.println("DeleteComment - missing parameters");
                response.sendRedirect("board.jsp?error=필수 파라미터가 없습니다.");
                return;
            }
            
            int commentId = Integer.parseInt(commentIdParam);
            int postId = Integer.parseInt(postIdParam);
            
            CommentDAO commentDAO = new CommentDAO();
            boolean success = commentDAO.deleteComment(commentId, userId);
            
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