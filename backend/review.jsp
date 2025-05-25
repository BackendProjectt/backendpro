<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>구매 리뷰 작성</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        body { font-family: 'Noto Sans KR', Arial, sans-serif; background: #f9f9f9; margin: 0; }
        .review-container {
            max-width: 400px;
            margin: 60px auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.07);
            padding: 34px 28px;
        }
        h2 { margin-bottom: 24px; color: #1976d2; }
        label { font-size: 17px; margin-bottom: 0px; display: block; }
        .stars {
            font-size: 48px;
            margin-bottom: 14px;
            cursor: pointer;
        }
        .stars input { display: none; }
        .stars label {
            color: #ddd;
            cursor: pointer;
            transition: color 0.2s;
            display: inline-block;
        }
        .stars input:checked ~ label,
        .stars label:hover,
        .stars label:hover ~ label {
            color: #FFD700;
        }
        textarea {
            width: 380px;
            height: 100px;
            border: 1px solid #ccc;
            border-radius: 6px;
            resize: none;
            padding: 10px;
            font-size: 15px;
            margin-bottom: 20px;
            font-family: 'Nanum Gothic';
        }
        button {
            background: #1976d2;
            color: #fff;
            border: none;
            border-radius: 7px;
            font-size: 16px;
            padding: 12px 0;
            width: 100%;
            font-weight: 700;
            cursor: pointer;
        }
        button:hover { background: #1257a8; }
    </style>
</head>
<body>
    <div class="review-container">
        <h2>구매 리뷰 작성</h2>
        <form action="reviewProcess.jsp" method="post">
            <label>판매자 ID: <b>hong123</b></label>
            <input type="hidden" name="seller" value="hong123">
            <div class="stars">
                <!-- 별점 5개 (라벨 클릭시 자바스크립트로 색 변경) -->
                <input type="hidden" name="rating" id="rating" value="0">
                <label onclick="setStar(1)">&#9733;</label>
                <label onclick="setStar(2)">&#9733;</label>
                <label onclick="setStar(3)">&#9733;</label>
                <label onclick="setStar(4)">&#9733;</label>
                <label onclick="setStar(5)">&#9733;</label>
            </div>
            <textarea name="comment" placeholder="리뷰를 작성해주세요"></textarea>
            <button type="submit">리뷰 등록</button>
        </form>

		<script>
			function setStar(num) {
    		document.getElementById('rating').value = num;
    		const stars = document.querySelectorAll('.stars label');
    		stars.forEach((star, i) => {
        		star.style.color = i < num ? '#FFD700' : '#ddd';
   				});
			}

			window.addEventListener('DOMContentLoaded', function() {
    		document.querySelector('form').onsubmit = function(e) {
        		if (document.getElementById('rating').value == "0") {
            		alert("별점을 선택해주세요!");
            		return false;
        			}
        		return true;
    			}
			});
		</script>
    </div>
</body>
</html>
