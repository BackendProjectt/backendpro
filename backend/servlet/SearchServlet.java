// src/main/java/servlet/SearchServlet.java
package servlet;

import dao.BookDAO;
import model.Book;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    private BookDAO bookDAO = new BookDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        // 검색 키워드 받기
        String keyword = request.getParameter("keyword");
        
        if (keyword == null || keyword.trim().isEmpty()) {
            // 키워드가 없으면 메인페이지로 리다이렉트
            response.sendRedirect("index.jsp?error=검색어를 입력해주세요");
            return;
        }
        
        keyword = keyword.trim();
        
        try {
            // 데이터베이스에서 검색 실행
            List<Book> searchResults = bookDAO.searchBooks(keyword);
            
            // 결과를 request에 저장
            request.setAttribute("searchResults", searchResults);
            request.setAttribute("keyword", keyword);
            request.setAttribute("resultCount", searchResults.size());
            
            // 검색 결과 페이지로 포워드 (search.jsp로 변경)
            request.getRequestDispatcher("search.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=검색 중 오류가 발생했습니다");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // POST 요청도 GET으로 처리
        doGet(request, response);
    }
}