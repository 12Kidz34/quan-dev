<%--
  Created by IntelliJ IDEA.
  User: Ca Ngao
  Date: 8/5/2025
  Time: 4:12 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Đăng nhập</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
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
      background-color: rgba(0,0,0,0.2);
    }
    .login_box {
      position: relative;
      width: 450px;
      backdrop-filter: blur(12px);
      border: 2px solid rgba(255,255,255,0.2);
      border-radius: 15px;
      padding: 3rem 2rem 2rem;
      color: white;
      background-color: rgba(0,0,0,0.3);
      box-shadow: 0 0 30px rgba(0,0,0,0.3);
      animation: fadeInUp 0.6s ease-out;
      transition: transform 0.6s ease, opacity 0.6s ease;
    }
    #backBtn {
      position: absolute;
      top: 10px;
      left: 10px;
      border-radius: 50px;
      padding: 5px 10px;
      background-color: rgba(255,255,255,0.8);
      border: none;
      color: black;
      font-weight: bold;
      transition: background 0.3s;
    }
    #backBtn:hover { background-color: gold; color: black; }
    .login_header {
      position: absolute;
      top: 0;
      left: 50%;
      transform: translateX(-50%) translateY(-50%);
      display: flex;
      justify-content: center;
      align-items: center;
      background-color: #c6c3c3;
      width: 140px;
      height: 70px;
      border-radius: 0 0 20px 20px;
    }
    .login_header span { font-size: 26px; font-weight: bold; color: black; }
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
    .form-control:focus {
      border-color: gold;
      box-shadow: 0 0 5px gold;
    }
    .form-control::placeholder { color: rgba(255,255,255,0.7); }
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
    .btn-login:hover { background: gold; color: black; }
    @keyframes fadeInUp {
      from {opacity: 0; transform: translateY(20px);}
      to {opacity: 1; transform: translateY(0);}
    }
    @keyframes fallOut {
      0% { transform: translateY(0) rotate(0deg); opacity: 1; }
      30% { transform: translateY(50px) rotate(3deg); opacity: 0.9; }
      100% { transform: translateY(200px) rotate(10deg); opacity: 0; }
    }
    .fall-out { animation: fallOut 0.6s ease-in forwards; }
    /* Toast rớt xuống */
    .toast-container {
      position: fixed;
      top: -100px;
      left: 50%;
      transform: translateX(-50%);
      z-index: 2000;
      animation: dropDown 0.6s ease forwards;
    }
    @keyframes dropDown {
      0% { top: -100px; opacity: 0; }
      50% { top: 30px; opacity: 1; }
      100% { top: 20px; opacity: 1; }
    }
  </style>
</head>
<body>
<div class="wrapper">
  <div class="login_box">
    <button type="button" id="backBtn"><i class="bi bi-arrow-left"></i></button>
    <div class="login_header"><span>Login</span></div>
    <c:url var="url" value="/login"></c:url>
    <form id="loginForm" action="${url}" method="post" class="mt-4">
      <div class="mb-3 position-relative">
        <span class="input-group-text"><i class="bi bi-person"></i></span>
        <input type="text" name="username" class="form-control" placeholder="Username" required>
      </div>
      <div class="mb-3 position-relative">
        <span class="input-group-text"><i class="bi bi-lock"></i></span>
        <input type="password" name="password" class="form-control" placeholder="Password" required>
      </div>
      <button type="submit" class="btn btn-login w-100">Login</button>
      <p class="text-center mt-3 mb-0">Don't have an account?
        <a id="registerLink" href="${pageContext.request.contextPath}/register">Register</a>
      </p>
      <i>${message}</i>
    </form>
  </div>
</div>

<!-- Toast -->

<script>
  document.addEventListener("DOMContentLoaded", function() {
    const loginBox = document.querySelector(".login_box");
    const backBtn = document.getElementById("backBtn");
    const registerLink = document.getElementById("registerLink");

    function addExitEffectAndRedirect(url) {
      loginBox.classList.add("fall-out");
      setTimeout(() => { window.location.href = url; }, 600);
    }

    backBtn.addEventListener("click", () => {
      addExitEffectAndRedirect("http://localhost:8080/08_TC00224_LeKhangThinh_ASM_war/");
    });

    registerLink.addEventListener("click", (e) => {
      e.preventDefault();
      addExitEffectAndRedirect(registerLink.href);
    });


  });
</script>
</body>
</html>
