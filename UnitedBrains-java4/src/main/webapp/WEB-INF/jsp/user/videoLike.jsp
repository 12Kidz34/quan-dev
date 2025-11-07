<%--
  Created by IntelliJ IDEA.
  User: Ca Ngao
  Date: 8/5/2025
  Time: 4:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Danh sách Video yêu thích</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <style>

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

        .video-card {
            border-radius: 15px;
            overflow: hidden;
            border: none;
            background-color: rgba(0,0,0,0.6);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .video-card body{
            background-color: transparent;
        }

        .video-card footer{
            background-color: transparent;
        }
        .video-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(255, 215, 0, 0.2);
        }

        .video-thumb img {
            height: 200px;
            object-fit: cover;
            border-bottom: 1px solid ;
            transition: transform 0.3s ease;
        }
        .video-card:hover .video-thumb img {
            transform: scale(1.05);
        }

        .action-btn {
            border: none;
            border-radius: 20px;
            font-weight: 500;
            padding: 6px 14px;
            transition: background 0.3s ease, transform 0.2s ease;
        }
        .action-btn:hover {
            transform: scale(1.05);
        }

        .unlike-btn {
            background: linear-gradient(45deg, #ff6b6b, #ff4757);
            color: white;
        }
        .share-btn {
            background: linear-gradient(45deg, #1dd1a1, #10ac84);
            color: white;
        }

    </style>
</head>
<body class="bg-black text-white">

<div class="container py-3">
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
<div class="container">
    <h2 style="text-align: center">Danh sách Video yêu thích</h2>
    <c:if test="${!empty favorites}">
        <div class="row g-4">
            <c:forEach var="f" items="${favorites}">
                <div class="col-md-4">
                    <div class="card video-card bg-dark text-white h-100 shadow-sm border-secondary">
                        <a href="${pageContext.request.contextPath}/user/videoDetail?id=${f.video.id}" class="video-thumb">
                            <c:set var="videoId" value="${fn:substringAfter(f.video.link, '/embed/')}" />
                            <img src="https://img.youtube.com/vi/${videoId}/hqdefault.jpg"
                                 class="card-img-top"
                                 alt="${f.video.title}">
                        </a>
                        <div class="card-body">
                            <h5 class="card-title text-warning">${f.video.title}</h5>
                            <p class="card-text mb-1">
                                <small class="text-muted">👁 ${f.video.views} views</small><br>
                                <small class="text-muted">❤️ <fmt:formatDate value="${f.likeDate}" pattern="dd/MM/yyyy"/></small>
                            </p>
                        </div>
                        <div class="card-footer d-flex justify-content-between">
                            <form method="post" action="${pageContext.request.contextPath}/user/videoUnlike" style="margin:0;">
                                <input type="hidden" name="favoriteId" value="${f.id}" />
                                <button type="submit" class="btn action-btn unlike-btn btn-sm">
                                    <i class="fas fa-thumbs-down"></i> Unlike
                                </button>
                            </form>
                            <a href="${pageContext.request.contextPath}/user/videoShare?id=${f.video.id}"
                               class="btn action-btn share-btn btn-sm">
                                <i class="fas fa-share-alt"></i> Share
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>


    <c:if test="${empty favorites}">
        <div class="alert alert-warning text-center">Không có video nào được tìm thấy.</div>
    </c:if>
</div>
</body>
</html>
