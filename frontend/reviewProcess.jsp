<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ReviewDAO" %>
<%@ page import="dao.BookDAO" %>
<%@ page import="model.Review" %>
<%@ page import="model.Book" %>
<%@ page import="java.net.URLEncoder" %>
<%
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");

// 로그인 체크
String buyerId = (String) session.getAttribute("userId");
if (buyerId == null) {
    %>
    <script>
    alert("로그인이 필요합니다.");
    window.opener.location.href = "login.jsp";
    window.close();
    </script>
    <%
    return;
}

// 파라미터 받아오기
String bookIdStr = request.getParameter("bookId");
String sellerId = request.getParameter("sellerId");
String ratingStr = request.getParameter("rating");
String content = request.getParameter("content");


try {
    // 유효성 검사
    if (sellerId == null || ratingStr == null || content == null || 
        sellerId.trim().isEmpty() || ratingStr.trim().isEmpty() || content.trim().isEmpty()) {
        %>
        <script>
        alert("모든 필드를 입력해주세요!");
        window.close();
        </script>
        <%
        return;
    }
    
    // 기본값 설정 (테스트용)
    int bookId = 1; // 기본 책 ID
    if (bookIdStr != null && !bookIdStr.trim().isEmpty()) {
        bookId = Integer.parseInt(bookIdStr);
    }
    
    int rating = Integer.parseInt(ratingStr);
    
    // 평점 범위 검사
    if (rating < 1 || rating > 5) {
        %>
        <script>
        alert("평점은 1-5점 사이여야 합니다.");
        window.close();
        </script>
        <%
        return;
    }
    
    // 자신의 책에 리뷰 작성 방지
    if (buyerId.equals(sellerId)) {
        %>
        <script>
        alert("자신이 등록한 책에는 리뷰를 작성할 수 없습니다.");
        window.close();
        </script>
        <%
        return;
    }
    
    // DAO 인스턴스 생성
    ReviewDAO reviewDAO = new ReviewDAO();
    
    // 이미 리뷰를 작성했는지 확인
    if (reviewDAO.hasReview(buyerId, bookId)) {
        %>
        <script>
        alert("이미 이 책에 대한 리뷰를 작성하셨습니다.");
        window.close();
        </script>
        <%
        return;
    }
    
    // Review 객체 생성
    Review review = new Review(bookId, buyerId, sellerId, rating, content.trim());
    
    // 데이터베이스에 저장
    if (reviewDAO.addReview(review)) {
        %>
        <script>
        alert("리뷰가 성공적으로 등록되었습니다!");
        if (window.opener) {
            window.opener.location.reload(); // 부모 창 새로고침
        }
        window.close(); // 팝업 창 닫기
        </script>
        <%
    } else {
        %>
        <script>
        alert("리뷰 등록에 실패했습니다. 다시 시도해주세요.");
        window.close();
        </script>
        <%
    }
    
} catch (NumberFormatException e) {
    %>
    <script>
    alert("잘못된 숫자 형식입니다.");
    window.close();
    </script>
    <%
} catch (Exception e) {
    e.printStackTrace();
    %>
    <script>
    alert("리뷰 등록 중 오류가 발생했습니다.");
    window.close();
    </script>
    <%
}
%>