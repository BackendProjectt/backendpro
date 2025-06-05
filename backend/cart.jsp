<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>장바구니</title>
	<style>
		body {
            margin: 0;
            padding: 0;
            font-family: 'Noto Sans KR', 'Apple SD Gothic Neo', 'Malgun Gothic', Arial, sans-serif;
            color: #222;
            padding: 40px;
            background: #f4f4f4;
        }
		.top-navbar {
            background: rgba(25, 118, 210, 0.92);
            color: white;
            position: fixed;
            left: 0;
            top: 0;
            width: 100vw;
            z-index: 100;
            box-shadow: 0 2px 12px rgba(25, 118, 210, 0.08);
            backdrop-filter: blur(6px);
        }
        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 24px;
            height: 62px;
        }
        .nav-left .logo {
            font-size: 26px;
            font-weight: 900;
            letter-spacing: 1px;
            color: #fff;
            text-shadow: 0 2px 8px rgba(25,118,210,0.16);
        }
        .nav-right a {
            color: #fff;
            margin-left: 28px;
            text-decoration: none;
            font-size: 16px;
            font-weight: 500;
            position: relative;
            transition: color 0.18s;
        }
        .nav-right a::after {
            content: "";
            display: block;
            width: 0%;
            height: 2px;
            background: #ffd600;
            transition: width 0.18s;
            position: absolute;
            bottom: -2px;
            left: 0;
        }
        .nav-right a:hover {
            color: #ffd600;
        }
        .nav-right a:hover::after {
            width: 100%;
        }
        
        .cart-container {
        max-width: 700px;
        margin: 110px auto 100px auto;
        background: #fff;
        border-radius: 14px;
        box-shadow: 0 2px 14px rgba(25, 118, 210, 0.08);
        padding: 35px 32px 18px 32px;
    	}
    	.cart-title {
        	font-size: 28px;
        	font-weight: bold;
        	margin-bottom: 20px;
        	color: #343a40;
    	}
    	.cart-list {
        	width: 100%;
    	}
    	.cart-item {
        	display: flex;
        	align-items: center;
        	border-bottom: 1px solid #eee;
        	padding: 18px 0;
        	gap: 26px;
    	}
    	.cart-img {
        	width: 90px; height: 120px;
        	border-radius: 5px;
        	background: #fafbfc;
        	display: flex;
        	align-items: center;
        	justify-content: center;
        	overflow: hidden;
        	border: 1px solid #f0f0f0;
   		}
    	.cart-img img {
        	width: 100%; height: 100%; object-fit: cover;
    	}
    	.cart-book-title {
        	font-size: 18px; font-weight: bold;
        	color: #222;
        	margin-bottom: 6px;
    	}
    	.cart-book-price {
        	color: #1976d2; font-size: 16px; font-weight: 600;
    	}
    	.cart-book-meta {
        	font-size: 14px; color: #888;
    	}
        
        .bottom-bar {
            position: fixed;
            left: 0;
            bottom: 0;
            width: 100vw;
            background: #f8f8f8;
            border-top: 1.5px solid #ececec;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 16px 0;
            z-index: 300;
        }
        .bottom-bar .total-price {
            font-size: 20px;
            margin-right: 28px;
        }
        .bottom-bar .total-price b {
            color: #1976d2;
            font-size: 22px;
            margin-left: 6px;
        }
        .btn-group {
            display: flex;
            gap: 10px;
        }
        .btn {
            padding: 12px 0;
            min-width: 180px;
            font-size: 17px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            transition: background 0.15s;
        }
        .btn-cart {
            background: #292929;
            color: #fff;
        }
        .btn-cart:hover {
            background: #444;
        }
        .btn-buy {
            background: #ffcf3f;
            color: #222;
        }
        .btn-buy:hover {
            background: #ffd964;
        }
        td {
            padding: 10px;
            border-bottom: 1px solid #ccc;
            text-align: left;
        }
</style>
</head>
<body>
	<div class="top-navbar">
        <div class="main-container">
            <div class="nav-left">
                <a href="index.jsp" class="logo" style="text-decoration:none; color:inherit;">📚 ReRead</a>
            </div>
            <div class="nav-right">
                <a href="login.jsp">로그인</a>
                <a href="signup.jsp">회원가입</a>
                <a href="mypage.jsp">마이페이지</a>
                <a href="cart.jsp">장바구니</a>
                <a href="bookRegister.jsp">책 등록</a>
            </div>
        </div>
    </div>
    
    <div class="cart-container">
        <div class="cart-title">장바구니에 넣은 책</div>
        <div class="cart-list">
          
            <div class="cart-item">
                <div class="cart-img">
                    <a href="bookdetail.jsp?bookId=1" target="_blank"><img src="image/book1.jpg" alt="책표지"> </a>
                </div>
                <div>
                    <div class="cart-book-title">글쓰기 생각쓰기</div>
                    <div class="cart-book-meta">저자: 윌리엄 진서 / 출판사: 돌베개</div>
                    <div class="cart-book-price">₩19,000</div>
                </div>
            </div>
            <div class="cart-item">
            	<div class="cart-img">
                    <a href="bookdetail.jsp?bookId=2" target="_blank"><img src="image/book1.jpg" alt="책표지"> </a>
                </div>
                <div>
                    <div class="cart-book-title">1퍼센트 부자들의 법칙</div>
                    <div class="cart-book-meta">저자: 송희연 / 출판사: 예문</div>
                    <div class="cart-book-price">₩13,500</div>
                </div>
            </div>
            <div class="cart-item">
                <div class="cart-img">
                    <a href="bookdetail.jsp?bookId=3" target="_blank"><img src="image/book1.jpg" alt="책표지"> </a>
                </div>
                <div>
                    <div class="cart-book-title">1퍼센트 부자들의 법칙</div>
                    <div class="cart-book-meta">저자: 송희연 / 출판사: 예문</div>
                    <div class="cart-book-price">₩13,500</div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="bottom-bar">
        <div class="total-price">총 결제 금액 : <b>₩46,000</b></div>
        <div class="btn-group">
    		<button class="btn btn-buy" onclick="window.open('review.jsp', 'reviewPopup', 'width=550,height=660,resizable=no,scrollbars=yes'); return false;">바로 구매</button>
        </div>
    </div>
</body>
</html>