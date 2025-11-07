<%--
  Created by IntelliJ IDEA.
  User: Ca Ngao
  Date: 8/5/2025
  Time: 4:40 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Trang chủ User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body::before {
            content: "";
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background-image:
                    linear-gradient(rgba(0,0,0,0), rgba(0,0,0,0.5)), /* overlay tối */
                    url('https://wallpaperaccess.com/full/276258.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            opacity: 1; /* để overlay hiển thị rõ */
            z-index: -1;
        }
        .admin-navbar {
            background: linear-gradient(to bottom, #333 0%, #000 100%);
            border-radius: 10px;
            padding: 0.5rem 1rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .admin-title {
            font-weight: bold;
            color: yellow;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .admin-links {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .admin-links a {
            color: #a5ff75;
            text-decoration: none;
            font-weight: 500;
            text-transform: uppercase;
        }

        .admin-links a:hover {
            text-decoration: underline;
        }

        /* Custom dropdown override */
        .dropdown-menu {
            background-color: #222;
            border-radius: 8px;
            border: 1px solid #555;
        }

        .dropdown-menu a {
            color: #a5ff75;
        }

        .dropdown-menu a:hover {
            background-color: #333;
            color: #fff;
        }

        /* Video list */
        .video-row {
            display: flex;
            flex-wrap: nowrap;
            gap: 20px;
            overflow-x: auto;
            min-height: 80vh;
            padding: 40px 0;
            scroll-snap-type: x mandatory;
            scroll-behavior: smooth;
            scrollbar-width: none;
        }
        .video-row::-webkit-scrollbar { display: none; }
        /*thẻ video*/
        .video-card {
            width: 160px;
            height: 500px;
            flex-shrink: 0;
            background-color: rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            box-shadow: 0 0 5px white;
            overflow: hidden;
            scroll-snap-align: start;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: all 0.3s ease;
        }
        .video-card:hover {
            width: 400px;
            box-shadow: 0 0 15px #000000;
            z-index: 10;
        }
        .video-card img {
            width: 100%;
            height: 380px;
            object-fit: cover;
            border-radius: 10px 10px 0 0;
            clip-path: inset(12% 0 12% 0);
            object-position: center;
            transform: scale(1.35);
        }
        .video-title {
            padding: 12px 8px;
            font-size: 16px;
            font-weight: 700;
            color: #f0f0f0;
            /*background-color: rgba(0, 0, 0, 0.3); */
            backdrop-filter: blur(4px); /* kính mờ */
            text-align: center;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        /*tương tác thẻ video*/
        .video-actions {
            padding: 12px 0;
            display: flex;
            justify-content: center;
            gap: 8px;
        }

        .video-actions button,
        .video-actions a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            min-width: 42px; /* chỉ vừa icon lúc chưa hover */
            height: 42px;
            padding: 0;
            font-size: 15px;
            font-weight: 600;
            border: none;
            border-radius: 30px;
            cursor: pointer;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
            color: #fff;
            text-decoration: none;
            overflow: hidden;
            white-space: nowrap;
            transition: all 0.3s ease;
        }

        .video-actions button { background: linear-gradient(135deg, #28a745, #5fdc82); }
        .video-actions a { background: linear-gradient(135deg, #17a2b8, #5bc0de); }

        /* Ẩn chữ ban đầu */
        .video-actions button span,
        .video-actions a span {
            display: none;
        }

        /* Khi hover video-card => nút to ra, hiện chữ */
        .video-card:hover .video-actions button,
        .video-card:hover .video-actions a {
            min-width: 130px;
            padding: 0 16px;
        }

        .video-card:hover .video-actions button span,
        .video-card:hover .video-actions a span {
            display: inline;
        }


        /* Slider arrows */
        .slider-wrapper { position: relative; padding: 0 50px; }
        .slider-arrow {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            z-index: 20;
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background-color: rgba(0, 0, 0, 0.5);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: white;
            font-size: 1rem;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .slider-arrow.left { left: 0; }
        .slider-arrow.right { right: 0; }

        /*    footer*/
        .custom-footer {
            height: 50px;
            background-color: rgba(0,0,0,0.6); /* nền mờ */
            color: var(--text-color);
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 14px;
            position: relative; /* để nó nằm dưới nội dung */
            margin-top: 20px;
        }
    </style>
    </style>
</head>
<body class="bg-black text-white">

<div class="container fluid py-3">
    <div class="admin-navbar shadow">
        <div class="admin-title">User Tool</div>
        <div class="admin-links">
            <a href="${pageContext.request.contextPath}/user/videoList">Video List</a>
            <a href="${pageContext.request.contextPath}/user/videoLike">Video Favorite</a>
            <div class="dropdown">
                <a
                        class="nav-link dropdown-toggle"
                        href="#"
                        role="button"
                        data-bs-toggle="dropdown"
                        aria-expanded="false"
                >
                    My Account
                </a>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Logoff</a></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/changePassword">Change Password</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid">
    <h2 style="text-align: center; margin-bottom: 20px; font-weight: bold; text-transform: uppercase; color: black">
        DANH SÁCH VIDEO
    </h2>
    <c:if test="${!empty videos}">
        <div class="slider-wrapper">
            <button class="slider-arrow left" id="prevBtn"><i class="fas fa-chevron-left"></i></button>
            <div class="video-row" id="videoSlider">
                <c:forEach var="v" items="${videos}">
                    <c:set var="videoId" value="${fn:substringAfter(v.link, '/embed/')}" />
                    <div class="video-card">
                        <a href="${pageContext.request.contextPath}/user/videoDetail?id=${v.id}" title="${v.title}">
                            <img src="https://img.youtube.com/vi/${videoId}/hqdefault.jpg" alt="${v.title}"/>
                        </a>
                        <div class="video-title">${v.title}</div>
                        <div class="video-actions">
                            <form method="post" action="${pageContext.request.contextPath}/user/videoLike">
                                <input type="hidden" name="videoId" value="${v.id}" />
                                <button type="submit"><i class="fas fa-thumbs-up"></i> <span>Like</span></button>
                            </form>
                            <a href="${pageContext.request.contextPath}/user/videoShare?id=${v.id}">
                                <i class="fas fa-share-alt"></i> <span>Share</span>
                            </a>

                        </div>
                    </div>
                </c:forEach>
            </div>
            <button class="slider-arrow right" id="nextBtn"><i class="fas fa-chevron-right"></i></button>
        </div>
    </c:if>
</div>

<!-- Footer -->
<footer class="custom-footer">
    Website được thành lập từ 2025 - 2025
</footer>
<i>${message}</i>

<script>
    // Slider video
    document.addEventListener('DOMContentLoaded', function() {
        const slider = document.getElementById('videoSlider');
        const prevBtn = document.getElementById('prevBtn');
        const nextBtn = document.getElementById('nextBtn');
        const scrollAmount = (160 * 5) + (20 * 3);

        nextBtn.addEventListener('click', () => slider.scrollLeft += scrollAmount);
        prevBtn.addEventListener('click', () => slider.scrollLeft -= scrollAmount);
    });


</script>
</body>
</html>
