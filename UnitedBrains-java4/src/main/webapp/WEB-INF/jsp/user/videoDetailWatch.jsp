<%@ page pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Chi tiết video</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        .video-box { border: 1px solid #f0ad4e; padding: 1rem; } .video-thumbnail { background-color: #f8f9fa; border: 1px solid #f0ad4e; height: 300px; display: flex; align-items: center; justify-content: center; color: #333; } .video-title { background-color: #e8f5e9; font-weight: bold; padding: 0.5rem; } .video-description { padding: 0.5rem; } .sidebar-video { border: 1px solid #c8e6c9; padding: 0.5rem; margin-bottom: 0.5rem; display: flex; align-items: center; } .sidebar-video img { width: 60px; height: 45px; object-fit: cover; margin-right: 0.5rem; } .video-actions { background-color: #f8f9fa; padding: 0.5rem; display: flex; justify-content: end; gap: 0.5rem; } .extra-links { padding: 0.5rem 0 0.5rem 0; border-top: 1px solid #ddd; } .extra-links a { margin-right: 1rem; }
        body::before {
            content: "";
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background-image:
                    linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), /* overlay tối */
                    url('https://wallpaperaccess.com/full/276258.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            opacity: 1; /* để overlay hiển thị rõ */
            z-index: -1;
        }
        /*------------*/
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

        /* Video chính */
        .video-box {
            background-color: rgba(0,0,0,0.7);
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgb(133, 133, 133);
            padding: 0;
            border: none;
        }

        .video-box h5 {
            font-weight: 600;
            margin: 1rem;
            color: #fff;
        }
        .video-actions{
            background-color: transparent;
        }
        .video-actions button,
        .video-actions a {
            all: unset; /* Xóa toàn bộ style mặc định của trình duyệt */
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            height: 42px;
            font-size: 15px;
            font-weight: 600;
            border-radius: 30px;
            cursor: pointer;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
            color: #fff;
            text-decoration: none;
            padding: 0 16px;
        }

        /* Like button */
        .video-actions button {
            background: linear-gradient(135deg, #28a745, #5fdc82);
        }

        /* Share button */
        .video-actions a {
            background: linear-gradient(135deg, #17a2b8, #5bc0de);
        }


        /* Sidebar video */
        .sidebar-video {
            background-color: rgba(0,0,0,0.4);
            border-radius: 8px;
            padding: 0.5rem;
            border: none;
            margin-bottom: 0.75rem;
            display: flex;
            align-items: center;
            transition: background-color 0.2s;
        }

        .sidebar-video:hover {
            background-color: rgba(0,0,0,0.8);
        }

        .sidebar-video img {
            width: 120px;
            height: 68px;
            object-fit: cover;
            border-radius: 4px;
            margin-right: 0.75rem;
        }

        .sidebar-video span {
            color: #fff;
            font-size: 0.95rem;
            font-weight: 500;
            line-height: 1.3;
        }



    </style>
</head>
<body class="bg-black">

<div class="container-fluid">
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
<div class="container-fluid mt-4"> <div class="row"> <!-- Main Video Section -->
    <div class="col-lg-8">
        <div class="video-box">

            <!-- Khu vực nhúng video lấy từ DB -->
            <div class="mt-3">
                <h5 class="text-warning">${video.title}</h5>
                <div class="ratio ratio-16x9 position-relative">
                    <iframe
                            src="${video.link}"
                            title="${video.title}"
                            frameborder="0"
                            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                            allowfullscreen
                            style="width: 100%; height: 100%; display: block;"
                    ></iframe>
                    <!-- overlay link phủ toàn bộ iframe -->

                </div>
            </div>

            <div class="video-actions">
                <form method="post" action="${pageContext.request.contextPath}/user/videoLike">
                    <input type="hidden" name="videoId" value="${video.id}" />
                    <button type="submit"><i class="fas fa-thumbs-up"></i> <span>Like</span></button>
                </form>
                <a href="${pageContext.request.contextPath}/user/videoShare?id=${video.id}">
                    <i class="fas fa-share-alt"></i> <span>Share</span>
                </a>
            </div>
        </div>
    </div>
    <!-- Sidebar Video List -->
    <div class="col-lg-4">
        <c:forEach var="v" items="${videos}">
            <c:if test="${v.id ne video.id}">
                <div class="sidebar-video">
                    <a href="${pageContext.request.contextPath}/user/videoDetail?id=${v.id}">
                        <c:set var="videoId" value="${fn:substringAfter(v.link, '/embed/')}" />
                        <img src="https://img.youtube.com/vi/${videoId}/hqdefault.jpg" alt="${video.title}" style="max-height: 300px;" />
                    </a>
                    <span>${v.title}</span>
                </div>
            </c:if>
        </c:forEach>
    </div>
</div> </div>
</body>
</html>
