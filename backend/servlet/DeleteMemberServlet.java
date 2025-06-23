package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDAO;

@WebServlet("/deleteMember")
public class DeleteMemberServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        String password = request.getParameter("password");
        
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        UserDAO userDAO = new UserDAO();
        try {
            boolean success = userDAO.deleteMember(userId, password);
            
            if (success) {
                session.invalidate();
                response.sendRedirect("deleteMemberComplete.jsp");
            } else {
                request.setAttribute("error", "비밀번호가 일치하지 않습니다.");
                request.getRequestDispatcher("mypage.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "회원탈퇴 처리 중 오류가 발생했습니다.");
            request.getRequestDispatcher("mypage.jsp").forward(request, response);
        }
    }
}