<%--
  Created by IntelliJ IDEA.
  User: Ca Ngao
  Date: 8/7/2025
  Time: 12:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Đăng ký</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <style>
        * { box-sizing: border-box; }

        body {
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: url('https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0') no-repeat center/cover;
            font-family: 'Segoe UI', sans-serif;
        }

        .wrapper {
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: rgba(0,0,0,0.3);
        }

        .login_box {
            position: relative;
            width: 450px;
            backdrop-filter: blur(12px);
            border: 2px solid rgba(255,255,255,0.2);
            border-radius: 15px;
            padding: 3rem 2rem 2rem;
            color: white;
            background-color: rgba(0,0,0,0.4);
            box-shadow: 0 0 30px rgba(0,0,0,0.3);
            animation: fadeInUp 0.6s ease-out;
            text-align: center;
        }

        .login_header {
            position: absolute;
            top: 0;
            left: 50%;
            transform: translateX(-50%) translateY(-50%);
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #c6c3c3;
            width: 160px;
            height: 70px;
            border-radius: 0 0 20px 20px;
        }

        .login_header span {
            font-size: 26px;
            font-weight: bold;
            color: black;
        }

        .form-control {
            background-color: transparent !important;
            border: 1px solid rgba(255,255,255,0.4);
            border-radius: 8px;
            color: white !important;
            padding-left: 40px;
        }

        .form-control:focus,
        .form-control:not(:placeholder-shown) {
            background-color: transparent !important;
            color: white !important;
        }

        .form-control::placeholder {
            color: rgba(255,255,255,0.7);
        }

        .input-group-text {
            background: transparent;
            border: none;
            color: rgba(255,255,255,0.7);
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            pointer-events: none;
        }

        .btn-login {
            background: white;
            color: black;
            font-weight: bold;
            border-radius: 20px;
            transition: all 0.3s;
        }

        .btn-login:hover {
            background: gold;
            color: black;
        }

        .options {
            font-size: 0.9rem;
            display: flex;
            justify-content: space-between;
            margin-top: -5px;
            margin-bottom: 15px;
        }

        .options a {
            color: #fff;
            text-decoration: none;
        }

        .options a:hover {
            text-decoration: underline;
        }

        @keyframes fadeInUp {
            from {opacity: 0; transform: translateY(20px);}
            to {opacity: 1; transform: translateY(0);}
        }

        @keyframes fallOut {
            0% { transform: translateY(0) rotate(0deg); opacity: 1; }
            30% { transform: translateY(50px) rotate(3deg); opacity: 0.9; }
            100% { transform: translateY(200px) rotate(10deg); opacity: 0; }
        }

        .fall-out {
            animation: fallOut 0.8s ease-in forwards;
        }

        .back-btn {
            position: absolute;
            top: 15px;
            left: 15px;
            font-size: 24px;
            color: white;
            cursor: pointer;
            transition: color 0.3s;
        }

        .back-btn:hover {
            color: gold;
        }

        /* Toast thông báo */
        .toast-success {
            position: fixed;
            top: -60px;
            left: 50%;
            transform: translateX(-50%);
            background-color: #28a745;
            color: white;
            padding: 14px 24px;
            border-radius: 6px;
            font-size: 16px;
            opacity: 0;
            z-index: 9999;
            transition: all 0.5s ease;
        }
        .toast-success.show {
            top: 30px;
            opacity: 1;
        }
    </style>

</head>
<body>
<div class="wrapper">
    <div class="login_box" id="registerBox">
        <i class="bi bi-arrow-left-circle back-btn" id="backBtn"></i>
        <div class="login_header">
            <span>Register</span>
        </div>
        <c:url var="url" value="/register"></c:url>
        <form id="registerForm" action="${url}" method="post" class="mt-4">
            <div class="mb-3 position-relative">
                <span class="input-group-text"><i class="bi bi-person"></i></span>
                <input type="text" name="username" class="form-control" placeholder="Username" required>
            </div>
            <div class="mb-3 position-relative">
                <span class="input-group-text"><i class="bi bi-card-text"></i></span>
                <input type="text" name="fullname" class="form-control" placeholder="Full name" required>
            </div>
            <div class="mb-3 position-relative">
                <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                <input type="email" name="email" class="form-control" placeholder="Email" required>
            </div>
            <div class="mb-3 position-relative">
                <span class="input-group-text"><i class="bi bi-lock"></i></span>
                <input type="password" name="password" class="form-control" placeholder="Password" required>
            </div>

            <button type="submit" class="btn btn-login w-100">Register</button>

            <p class="text-center mt-3 mb-0">Already have an account?
                <a id="loginLink" href="${pageContext.request.contextPath}/login">Login</a>
            </p>
        </form>
    </div>
</div>

<!-- Toast -->
<div id="successToast" class="toast-success">Đăng ký thành công!</div>

<script>
    function addExitEffectAndRedirect(element, redirectUrl) {
        element.classList.add("fall-out");
        setTimeout(() => {
            window.location.href = redirectUrl;
        }, 800);
    }

    document.addEventListener("DOMContentLoaded", function() {
        const loginLink = document.getElementById("loginLink");
        const backBtn = document.getElementById("backBtn");
        const registerBox = document.getElementById("registerBox");
        const registerForm = document.getElementById("registerForm");
        const successToast = document.getElementById("successToast");

        if (loginLink) {
            loginLink.addEventListener("click", function(e) {
                e.preventDefault();
                addExitEffectAndRedirect(registerBox, loginLink.href);
            });
        }

        if (backBtn) {
            backBtn.addEventListener("click", function(e) {
                e.preventDefault();
                addExitEffectAndRedirect(
                    registerBox,
                    "http://localhost:8080/08_TC00224_LeKhangThinh_ASM_war/"
                );
            });
        }

        // Hiện toast + rớt xuống + tự động sang trang login
        registerForm.addEventListener("submit", function(e) {
            successToast.classList.add("show");

            setTimeout(() => {
                successToast.classList.remove("show");
                registerBox.classList.add("fall-out");
            }, 2000);

            setTimeout(() => {
                window.location.href = "${pageContext.request.contextPath}/login";
            }, 2800);
        });
    });
</script>

</body>
</html>
