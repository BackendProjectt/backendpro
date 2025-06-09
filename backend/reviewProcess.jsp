<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    // 파라미터 받아오기
    String seller = request.getParameter("seller");
    String rating = request.getParameter("rating");
    String comment = request.getParameter("comment");

    // 여기에 DB 저장 로직이 들어가야 함
    // 예: INSERT INTO reviews (seller, rating, comment) VALUES (?, ?, ?)

    // 등록 완료 후 알림 + 메인 페이지로 이동
%>
<script>
    alert("리뷰가 등록되었습니다.");
    window.opener.location.href = "index.jsp"; // 부모 창 이동
    window.close(); // 팝업 창 닫기
</script>
