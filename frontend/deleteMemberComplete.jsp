<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>회원탈퇴 완료 - ReRead</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background: linear-gradient(135deg, #e3f2fd 0%, #f8fbff 100%);
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .container {
            max-width: 500px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(25, 118, 210, 0.15);
            padding: 60px 40px;
            text-align: center;
            border: 1px solid #e3eaf3;
        }
        
        .icon {
            font-size: 80px;
            margin-bottom: 30px;
            animation: fadeIn 1s ease-in;
        }
        
        .title {
            font-size: 28px;
            font-weight: 700;
            color: #1976d2;
            margin-bottom: 20px;
            letter-spacing: -0.5px;
        }
        
        .message {
            font-size: 18px;
            color: #333;
            line-height: 1.6;
            margin-bottom: 15px;
        }
        
        .sub-message {
            font-size: 16px;
            color: #666;
            line-height: 1.5;
            margin-bottom: 40px;
        }
        
        .thank-you {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 20px;
            margin: 30px 0;
            border-left: 4px solid #1976d2;
        }
        
        .thank-you p {
            margin: 0;
            color: #555;
            font-size: 16px;
            line-height: 1.5;
        }
        
        .countdown {
            font-size: 14px;
            color: #999;
            margin: 20px 0;
        }
        
        .countdown span {
            font-weight: bold;
            color: #1976d2;
        }
        
        .btn-group {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .btn {
            padding: 15px 30px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #1976d2, #1565c0);
            color: white;
            box-shadow: 0 4px 15px rgba(25, 118, 210, 0.3);
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 118, 210, 0.4);
        }
        
        .btn-secondary {
            background: #f5f5f5;
            color: #666;
            border: 1px solid #ddd;
        }
        
        .btn-secondary:hover {
            background: #e0e0e0;
        }
        
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: scale(0.8);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }
        
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .container > * {
            animation: slideUp 0.6s ease-out;
        }
        
        .container > *:nth-child(2) { animation-delay: 0.1s; }
        .container > *:nth-child(3) { animation-delay: 0.2s; }
        .container > *:nth-child(4) { animation-delay: 0.3s; }
        .container > *:nth-child(5) { animation-delay: 0.4s; }
        .container > *:nth-child(6) { animation-delay: 0.5s; }
        
        @media (max-width: 600px) {
            .container {
                margin: 20px;
                padding: 40px 30px;
            }
            
            .title {
                font-size: 24px;
            }
            
            .message {
                font-size: 16px;
            }
            
            .btn-group {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        
        
        <h1 class="title">회원탈퇴가 완료되었습니다</h1>
        
        <p class="message">
            ReRead 서비스를 이용해 주셔서 감사했습니다.
        </p>
        
        <p class="sub-message">
            회원님의 모든 개인정보와 활동 내역이 안전하게 삭제되었습니다.<br>   
        </p>
        
        <div class="thank-you">
            <p>
                그동안 ReRead와 함께해 주셔서 진심으로 감사드립니다.<br>
                더 나은 서비스로 다시 만나뵐 수 있기를 희망합니다.
            </p>
        </div>
       
        
        <div class="btn-group">
            <a href="index.jsp" class="btn btn-primary">
                🏠 메인페이지로 이동
            </a>
            <a href="signup.jsp" class="btn btn-secondary">
                ✨ 다시 가입하기
            </a>
        </div>
    </div>

    <script>
        // 카운트다운 및 자동 리다이렉트
        let countdown = 5;
       
       
        
        // 페이지 이탈 방지 (사용자가 실수로 뒤로가기 등을 눌렀을 때)
        window.addEventListener('beforeunload', function(e) {
            clearInterval(timer);
        });
        
        // ESC 키로 메인페이지 이동
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                clearInterval(timer);
                window.location.href = 'index.jsp';
            }
        });
    </script>
</body>
</html>