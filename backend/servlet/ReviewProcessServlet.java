package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ReviewDAO;
import dao.PurchaseDAO;
import model.Review;
import model.Purchase;

@WebServlet("/reviewProcess")
public class ReviewProcessServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        PrintWriter out = response.getWriter();
        
        try {
            // 세션에서 사용자 ID 가져오기
            HttpSession session = request.getSession();
            String buyerId = (String) session.getAttribute("userId");
            
            if (buyerId == null) {
                out.println("<script>");
                out.println("alert('로그인이 필요합니다.');");
                out.println("window.opener.location.href = 'login.jsp';");
                out.println("window.close();");
                out.println("</script>");
                return;
            }
            
            // 파라미터 받기
            String purchaseIdStr = request.getParameter("purchaseId");
            String bookIdStr = request.getParameter("bookId");
            String ratingStr = request.getParameter("rating");
            String content = request.getParameter("content");
            String sellerId = request.getParameter("sellerId");
            
            System.out.println("=== 리뷰 파라미터 디버깅 ===");
            System.out.println("purchaseId: " + purchaseIdStr);
            System.out.println("bookId: " + bookIdStr);
            System.out.println("rating: " + ratingStr);
            System.out.println("content: " + content);
            System.out.println("sellerId: " + sellerId);
            System.out.println("buyerId: " + buyerId);
            System.out.println("========================");
            
            // 필수 파라미터 유효성 검사
            if (purchaseIdStr == null || purchaseIdStr.trim().isEmpty() ||
                bookIdStr == null || bookIdStr.trim().isEmpty() ||
                ratingStr == null || ratingStr.trim().isEmpty() ||
                content == null || content.trim().isEmpty() ||
                sellerId == null || sellerId.trim().isEmpty()) {
                
                out.println("<script>");
                out.println("alert('모든 필드를 입력해주세요!');");
                out.println("history.back();");
                out.println("</script>");
                return;
            }
            
            // 숫자 파싱
            int purchaseId, bookId, rating;
            try {
                purchaseId = Integer.parseInt(purchaseIdStr);
                bookId = Integer.parseInt(bookIdStr);
                rating = Integer.parseInt(ratingStr);
                System.out.println("파싱된 값들 - purchaseId: " + purchaseId + ", bookId: " + bookId + ", rating: " + rating);
            } catch (NumberFormatException e) {
                out.println("<script>");
                out.println("alert('잘못된 데이터 형식입니다.');");
                out.println("history.back();");
                out.println("</script>");
                return;
            }
            
            // 평점 범위 검사 (1-5점)
            if (rating < 1 || rating > 5) {
                out.println("<script>");
                out.println("alert('평점은 1점부터 5점까지 선택해주세요.');");
                out.println("history.back();");
                out.println("</script>");
                return;
            }
            System.out.println("평점 범위 검사 통과: " + rating);
            
            // 리뷰 내용 길이 검사
            if (content.trim().length() < 10) {
                out.println("<script>");
                out.println("alert('리뷰 내용은 최소 10자 이상 입력해주세요.');");
                out.println("history.back();");
                out.println("</script>");
                return;
            }
            System.out.println("리뷰 내용 길이 검사 통과");
            
            // 자신의 책에 리뷰 작성 방지
            if (buyerId.equals(sellerId)) {
                out.println("<script>");
                out.println("alert('자신이 등록한 책에는 리뷰를 작성할 수 없습니다.');");
                out.println("window.close();");
                out.println("</script>");
                return;
            }
            System.out.println("자신의 책 리뷰 방지 검사 통과");
            
            // 구매 내역 확인
            PurchaseDAO purchaseDAO = new PurchaseDAO();
            Purchase purchase = purchaseDAO.getPurchaseById(purchaseId);
            
            if (purchase == null || !purchase.getBuyerId().equals(buyerId)) {
                out.println("<script>");
                out.println("alert('구매 내역을 확인할 수 없습니다.');");
                out.println("window.close();");
                out.println("</script>");
                return;
            }
            System.out.println("구매 내역 확인 완료");
            
            // 중복 리뷰 방지
            ReviewDAO reviewDAO = new ReviewDAO();
            boolean hasExistingReview = reviewDAO.hasReview(buyerId, purchaseId);
            System.out.println("기존 리뷰 존재 여부: " + hasExistingReview + " (buyerId: " + buyerId + ", purchaseId: " + purchaseId + ")");
            
            if (hasExistingReview) {
                out.println("<script>");
                out.println("alert('이미 이 구매에 대한 리뷰를 작성하셨습니다.');");
                out.println("window.close();");
                out.println("</script>");
                return;
            }
            System.out.println("중복 리뷰 검사 통과");
            
            // Review 객체 생성 (purchaseId 기준)
            Review review = new Review(purchaseId, sellerId, buyerId, rating, content.trim());
            System.out.println("Review 객체 생성 완료");
            
            // 데이터베이스에 저장
            System.out.println("데이터베이스 저장 시도...");
            boolean isSuccess = reviewDAO.addReview(review);
            System.out.println("데이터베이스 저장 결과: " + isSuccess);
            
            if (isSuccess) {
                out.println("<script>");
                out.println("alert('✅ 리뷰가 성공적으로 등록되었습니다!\\n\\n⭐ 평점: " + rating + "점\\n📝 내용: " + content.substring(0, Math.min(20, content.length())) + "...');");
                out.println("window.opener.location.reload();"); // 부모 창 새로고침
                out.println("window.close();"); // 팝업 창 닫기
                out.println("</script>");
            } else {
                out.println("<script>");
                out.println("alert('❌ 리뷰 등록에 실패했습니다.\\n\\n다시 시도해주세요.');");
                out.println("history.back();");
                out.println("</script>");
            }
            
        } catch (Exception e) {
            System.err.println("리뷰 처리 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
            
            out.println("<script>");
            out.println("alert('❌ 서버 오류가 발생했습니다.\\n\\n잠시 후 다시 시도해주세요.');");
            out.println("history.back();");
            out.println("</script>");
        } finally {
            if (out != null) {
                out.close();
            }
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("index.jsp");
    }
}