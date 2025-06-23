// src/main/java/servlet/PurchaseAllServlet.java
package servlet;

import dao.CartDAO;
import dao.PurchaseDAO;
import dao.BookDAO;
import model.Book;
import model.Purchase;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/purchaseAll")
public class PurchaseAllServlet extends HttpServlet {
    private CartDAO cartDAO = new CartDAO();
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
        
        try {
            // 장바구니에서 책 목록 가져오기
            List<Book> cartBooks = cartDAO.getCartBooks(buyerId);
            
            if (cartBooks.isEmpty()) {
                response.sendRedirect("cart.jsp?error=empty_cart");
                return;
            }
            
            int successCount = 0;
            int totalCount = cartBooks.size();
            
            // 각 책에 대해 구매 처리
            for (Book book : cartBooks) {
                // 자신의 책은 구매할 수 없음
                if (buyerId.equals(book.getSellerId())) {
                    continue;
                }
                
                // 이미 판매된 책은 구매할 수 없음
                if (!"판매중".equals(book.getStatus())) {
                    continue;
                }
                
                // 구매 처리
                Purchase purchase = new Purchase(book.getBookId(), buyerId, book.getSellerId(), book.getPrice());
                if (purchaseDAO.addPurchase(purchase)) {
                    // 구매 성공시 장바구니에서 제거
                    cartDAO.removeFromCart(buyerId, book.getBookId());
                    successCount++;
                }
            }
            
            if (successCount > 0) {
                if (successCount == totalCount) {
                    response.sendRedirect("complete.jsp?success=all_purchased&count=" + successCount);
                } else {
                    response.sendRedirect("complete.jsp?success=partial_purchased&success_count=" + successCount + "&total_count=" + totalCount);
                }
            } else {
                response.sendRedirect("cart.jsp?error=purchase_failed");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("cart.jsp?error=purchase_error");
        }
    }
}