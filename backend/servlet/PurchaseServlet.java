// src/main/java/servlet/PurchaseServlet.java
package servlet;

import dao.BookDAO;
import dao.PurchaseDAO;
import model.Book;
import model.Purchase;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/purchase")
public class PurchaseServlet extends HttpServlet {
    private PurchaseDAO purchaseDAO = new PurchaseDAO();
    private BookDAO bookDAO = new BookDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // 로그인 체크
        HttpSession session = request.getSession();
        String buyerId = (String) session.getAttribute("userId");
        
        if (buyerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        
        // 책 정보 조회
        Book book = bookDAO.getBookById(bookId);
        
        if (book == null || !"판매중".equals(book.getStatus())) {
            response.sendRedirect("index.jsp?error=book_not_available");
            return;
        }
        
        // 자신의 책은 구매할 수 없음
        if (buyerId.equals(book.getSellerId())) {
            response.sendRedirect("bookdetail.jsp?bookId=" + bookId + "&error=cannot_buy_own_book");
            return;
        }
        
        Purchase purchase = new Purchase(bookId, buyerId, book.getSellerId(), book.getPrice());
        
        if (purchaseDAO.addPurchase(purchase)) {
            response.sendRedirect("complete.jsp?success=1");
        } else {
            response.sendRedirect("bookdetail.jsp?bookId=" + bookId + "&error=purchase_failed");
        }
    }
}