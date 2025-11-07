<%--
  Created by IntelliJ IDEA.
  User: Ca Ngao
  Date: 8/5/2025
  Time: 4:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Đổi mật khẩu</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: url('https://images.unsplash.com/photo-1506744038136-46273834b3fb') no-repeat center/cover;
            font-family: 'Segoe UI', sans-serif;
            overflow: hidden;
        }

        /* Hiệu ứng xuất hiện */
        .page-enter {
            animation: fadeSlideIn 0.6s ease forwards;
        }
        @keyframes fadeSlideIn {
            from {
                opacity: 0;
                transform: translateY(-40px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Hiệu ứng rớt xuống */
        .page-exit {
            animation: dropDown 0.6s ease forwards;
        }
        @keyframes dropDown {
            from {
                opacity: 1;
                transform: translateY(0);
            }
            to {
                opacity: 0;
                transform: translateY(200px);
            }
        }

        /* Lớp mờ nền */
        .wrapper {
            width: 100%;
            height: 100%;
            position: absolute;
            top: 0;
            left: 0;
            background-color: rgba(0, 0, 0, 0.4);
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Khung đổi mật khẩu */
        .login_box {
            position: relative;
            width: 450px;
            backdrop-filter: blur(15px);
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 15px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.2);
            color: white;
            padding: 2.5rem 2rem 2rem;
        }

        /* Header */
        .login_header {
            position: absolute;
            top: 0;
            left: 50%;
            transform: translate(-50%, -50%);
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #c6c3c3;
            width: 160px;
            height: 70px;
            border-radius: 20px;
            font-size: 24px;
            font-weight: bold;
            color: black;
            text-transform: uppercase;
        }

        label {
            display: block;
            font-weight: 600;
            margin-bottom: 5px;
            font-size: 14px;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 6px;
            border: none;
            outline: none;
        }

        .btn-change {
            width: 100%;
            background-color: #198754;
            color: white;
            padding: 10px;
            border-radius: 6px;
            font-weight: 600;
            border: none;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn-change:hover {
            background-color: #157347;
        }

        i.message {
            display: block;
            margin-top: 10px;
            text-align: center;
            color: #ff4d4d;
            font-weight: bold;
        }

        /* Nút Back */
        .btn-back {
            position: absolute;
            top: 16px;
            left: 16px;
            font-size: 1.3rem;
            color: white;
            background: rgba(0, 0, 0, 0.3);
            border: none;
            cursor: pointer;
            display: flex;
            align-items: center;
            padding: 6px 10px;
            border-radius: 6px;
            text-decoration: none;
            gap: 4px;
        }
        .btn-back:hover {
            background: rgba(0, 0, 0, 0.5);
        }
        .btn-back svg {
            width: 20px;
            height: 20px;
            fill: currentColor;
        }
    </style>
</head>
<body>
<div class="wrapper page-enter" id="pageWrapper">
    <div class="login_box">
        <!-- Nút Back -->
        <a href="http://localhost:8080/08_TC00224_LeKhangThinh_ASM_war/user/videoList" class="btn-back" id="btnBack" title="Quay lại">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M15.41 7.41 14 6l-6 6 6 6 1.41-1.41L10.83 12z"/></svg>
        </a>

        <!-- Header -->
        <div class="login_header">Đổi MK</div>

        <!-- Form -->
        <form method="post" novalidate style="margin-top: 40px;">
            <label for="username">Tên đăng nhập</label>
            <input type="text" id="username" name="userId" placeholder="Nhập tên đăng nhập" required />

            <label for="currentPassword">Mật khẩu hiện tại</label>
            <input type="password" id="currentPassword" name="currentPassword" placeholder="Nhập mật khẩu hiện tại" required />

            <label for="newPassword">Mật khẩu mới</label>
            <input type="password" id="newPassword" name="newPassword" placeholder="Nhập mật khẩu mới" required />

            <label for="confirmPassword">Xác nhận mật khẩu mới</label>
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại mật khẩu mới" required />

            <button type="submit" class="btn-change">Đổi mật khẩu</button>
        </form>
        <i class="message">${message}</i>
    </div>
</div>

<script>
    const wrapper = document.getElementById('pageWrapper');
    const btnBack = document.getElementById('btnBack');

    // Khi bấm nút Back thì chạy hiệu ứng rớt xuống
    btnBack.addEventListener('click', function (e) {
        e.preventDefault(); // chặn ngay việc chuyển trang
        wrapper.classList.remove('page-enter');
        wrapper.classList.add('page-exit');
        setTimeout(() => {
            window.location.href = btnBack.href; // chuyển trang sau khi animation xong
        }, 600); // thời gian khớp với animation
    });

    // Nếu đóng hoặc reload thì cũng hiệu ứng rớt xuống
    window.addEventListener('beforeunload', function () {
        wrapper.classList.remove('page-enter');
        wrapper.classList.add('page-exit');
    });
</script>
</body>
</html>
