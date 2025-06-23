package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.PostDAO;

@WebServlet("/deletePost")
public class DeletePostServlet extends HttpServlet {
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
            int postId = Integer.parseInt(request.getParameter("postId"));
            
            PostDAO postDAO = new PostDAO();
            boolean success = postDAO.deletePost(postId, userId);
            
            if (success) {
                response.sendRedirect("board.jsp");
            } else {
                response.sendRedirect("board.jsp?error=게시글 삭제에 실패했습니다.");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("board.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("board.jsp?error=시스템 오류가 발생했습니다.");
        }
    }
}