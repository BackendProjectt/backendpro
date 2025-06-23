package servlet;

import dao.UserDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/updateUser")
public class UpdateMemberServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // 로그인 체크
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String username = request.getParameter("name");  // name 파라미터로 받기
        String email = request.getParameter("email");
        
        User user = new User();
        user.setUserId(userId);
        user.setUsername(username);
        user.setEmail(email);
        
        if (userDAO.updateUser(user)) {
            // 세션 정보 업데이트
            session.setAttribute("username", username);
            User updatedUser = userDAO.getUserById(userId);
            session.setAttribute("user", updatedUser);
            
            response.sendRedirect("mypage.jsp?success=정보가 성공적으로 수정되었습니다.");
        } else {
            response.sendRedirect("mypage.jsp?error=정보 수정에 실패했습니다.");
        }
    }
}