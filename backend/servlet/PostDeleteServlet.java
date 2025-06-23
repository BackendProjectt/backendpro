// src/main/java/servlet/PostDeleteServlet.java
package servlet;

import dao.PostDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/postDelete")
public class PostDeleteServlet extends HttpServlet {
    private PostDAO postDAO = new PostDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // 로그인 체크
        HttpSession session = request.getSession();
        String authorId = (String) session.getAttribute("userId");
        
        if (authorId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int postId = Integer.parseInt(request.getParameter("postId"));
        
        if (postDAO.deletePost(postId, authorId)) {
            response.sendRedirect("board.jsp?success=deleted");
        } else {
            response.sendRedirect("board.jsp?error=delete_failed");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}