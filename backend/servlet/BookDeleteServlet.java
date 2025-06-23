// src/main/java/servlet/BookDeleteServlet.java
package servlet;

import dao.BookDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/bookDelete")
public class BookDeleteServlet extends HttpServlet {
    private BookDAO bookDAO = new BookDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // 로그인 체크
        HttpSession session = request.getSession();
        String sellerId = (String) session.getAttribute("userId");
        
        if (sellerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        
        if (bookDAO.deleteBook(bookId, sellerId)) {
            response.sendRedirect("mypage.jsp?success=book_deleted");
        } else {
            response.sendRedirect("mypage.jsp?error=delete_failed");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}