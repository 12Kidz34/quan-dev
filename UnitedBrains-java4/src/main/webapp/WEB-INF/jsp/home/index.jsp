<%@ page pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Trang chủ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --primary-color: #0D0D0D;
            --secondary-color: #1A1A1A;
            --accent-color: #4CAF50;
            --hover-color: #66BB6A;
            --text-color: #E0E0E0;
            --font-family: 'Poppins', sans-serif;
        }

        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            background-color: transparent;
            color: var(--text-color);
            font-family: var(--font-family);
            overflow-x: hidden;
        }

        body::before {
            content: "";
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background-image:
                    linear-gradient(rgba(0,0,0,0), rgba(0,0,0,0.5)),
                    url('https://wallpaperaccess.com/full/276258.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            opacity: 1;
            z-index: -1;
        }

        .custom-header {
            position: fixed;
            min-width: 98%;
            top: 10px;
            background: rgba(0, 0, 0, 0);
            border-radius: 12px;
            padding: 12px 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.4);
            z-index: 1000;
        }
        body { padding-top: 70px; }

        .header-left { display: flex; align-items: center; gap: 10px; }
        .header-title { font-size: 22px; font-weight: bold; color: #ffeb3b; text-transform: uppercase; }
        .header-nav { display: flex; gap: 20px; }
        .header-nav a {
            color: #a5ff75;
            font-weight: 600;
            text-transform: uppercase;
            text-decoration: none;
            position: relative;
            padding: 6px 10px;
            transition: color 0.3s ease;
        }
        .header-nav a::after {
            content: "";
            position: absolute;
            bottom: -4px;
            left: 0;
            width: 0%;
            height: 2px;
            background: #a5ff75;
            transition: width 0.3s ease;
        }
        .header-nav a:hover { color: #fff; }
        .header-nav a:hover::after { width: 100%; }

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
            text-align: center;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

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
            min-width: 42px;
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

        .video-actions button span,
        .video-actions a span { display: none; }

        .video-card:hover .video-actions button,
        .video-card:hover .video-actions a {
            min-width: 130px;
            padding: 0 16px;
        }
        .video-card:hover .video-actions button span,
        .video-card:hover .video-actions a span {
            display: inline;
        }

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

        .custom-footer {
            height: 50px;
            background-color: rgba(0,0,0,0.6);
            color: var(--text-color);
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 14px;
            position: relative;
            margin-top: 20px;
        }
    </style>

</head>
<body>

<div class="container-fluid py-3">
    <header class="custom-header shadow-lg">
        <div class="header-left">
            <i class="fas fa-film fa-lg text-warning me-2"></i>
            <span class="header-title">Online Entertainment</span>
        </div>
        <nav class="header-nav">
            <a href="${pageContext.request.contextPath}/"><i class="fas fa-video"></i> <span>Video List</span></a>
            <a href="${pageContext.request.contextPath}/register"><i class="fas fa-user-plus"></i> <span>Đăng ký</span></a>
            <a href="${pageContext.request.contextPath}/login"><i class="fas fa-sign-in-alt"></i> <span>Đăng nhập</span></a>
        </nav>
    </header>
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
                    <!-- Xử lý VIDEO_ID từ nhiều dạng link -->
                    <c:choose>
                        <c:when test="${fn:contains(v.link, '/embed/')}">
                            <c:set var="videoId" value="${fn:substringAfter(v.link, '/embed/')}" />
                        </c:when>
                        <c:when test="${fn:contains(v.link, 'watch?v=')}">
                            <c:set var="videoId" value="${fn:substringAfter(v.link, 'watch?v=')}" />
                        </c:when>
                        <c:when test="${fn:contains(v.link, 'youtu.be/')}">
                            <c:set var="videoId" value="${fn:substringAfter(v.link, 'youtu.be/')}" />
                        </c:when>
                        <c:otherwise>
                            <c:set var="videoId" value="" />
                        </c:otherwise>
                    </c:choose>

                    <div class="video-card">
                        <a href="${pageContext.request.contextPath}/user/videoDt?id=${v.id}" title="${v.title}">
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

<footer class="custom-footer">
    Website được thành lập từ 2025 - 2025
</footer>

<script>
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
