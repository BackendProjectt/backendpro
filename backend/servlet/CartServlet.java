// src/main/java/servlet/CartServlet.java
package servlet;

import dao.CartDAO;
import dao.BookDAO;
import model.Book;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private CartDAO cartDAO = new CartDAO();
    private BookDAO bookDAO = new BookDAO();

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
        
        String action = request.getParameter("action");
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        
        if ("add".equals(action)) {
            // 자신의 책은 장바구니에 추가할 수 없음
            Book book = bookDAO.getBookById(bookId);
            if (book != null && userId.equals(book.getSellerId())) {
                response.sendRedirect("bookdetail.jsp?bookId=" + bookId + "&error=cannot_add_own_book");
                return;
            }
            
            // 장바구니에 추가
            if (cartDAO.addToCart(userId, bookId)) {
                response.sendRedirect("cart.jsp?success=added");
            } else {
                response.sendRedirect("bookdetail.jsp?bookId=" + bookId + "&error=add_failed");
            }
            
        } else if ("remove".equals(action)) {
            // 장바구니에서 제거
            if (cartDAO.removeFromCart(userId, bookId)) {
                response.sendRedirect("cart.jsp?success=removed");
            } else {
                response.sendRedirect("cart.jsp?error=remove_failed");
            }
            
        } else if ("clear".equals(action)) {
            // 장바구니 전체 비우기
            if (cartDAO.clearCart(userId)) {
                response.sendRedirect("cart.jsp?success=cleared");
            } else {
                response.sendRedirect("cart.jsp?error=clear_failed");
            }
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // AJAX 요청 처리 (장바구니 개수 등)
        String action = request.getParameter("action");
        
        if ("count".equals(action)) {
            HttpSession session = request.getSession();
            String userId = (String) session.getAttribute("userId");
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            
            if (userId != null) {
                int count = cartDAO.getCartCount(userId);
                out.print("{\"count\": " + count + "}");
            } else {
                out.print("{\"count\": 0}");
            }
            
        } else if ("check".equals(action)) {
            // 특정 책이 장바구니에 있는지 확인
            HttpSession session = request.getSession();
            String userId = (String) session.getAttribute("userId");
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            
            if (userId != null) {
                boolean inCart = cartDAO.isInCart(userId, bookId);
                out.print("{\"inCart\": " + inCart + "}");
            } else {
                out.print("{\"inCart\": false}");
            }
            
        } else {
            // 장바구니 페이지로 이동
            response.sendRedirect("cart.jsp");
        }
    }
}