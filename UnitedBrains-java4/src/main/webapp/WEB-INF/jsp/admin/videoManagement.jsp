<%--
  Created by IntelliJ IDEA.
  User: Ca Ngao
  Date: 7/24/2025
  Time: 3:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quản lý Video</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <style>
        .admin-navbar {
            background: linear-gradient(to bottom, #333 0%, #000 100%);
            border-radius: 10px;
            padding: 0.5rem 1rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            color: white;
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
    </style>
</head>
<body class="bg-black container">

<div class="py-3">
    <div class="admin-navbar shadow">
        <div class="admin-title">Administration Tool</div>
        <div class="admin-links">
            <a href="${pageContext.request.contextPath}/admin/userManagement">User Management</a>
            <a href="${pageContext.request.contextPath}/admin/videoManagement">Video Management</a>
            <a href="${pageContext.request.contextPath}/admin/report">Report</a>

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
    <h5 class="mb-3">QUẢN LÝ VIDEO</h5>

    <!-- Nav Tabs -->
    <ul class="nav nav-tabs" id="videoTab" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" id="edition-tab" data-bs-toggle="tab" data-bs-target="#edition" type="button" role="tab">
                VIDEO EDITION
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="list-tab" data-bs-toggle="tab" data-bs-target="#list" type="button" role="tab">
                VIDEO LIST
            </button>
        </li>
    </ul>

    <!-- Tab Content -->
    <div class="tab-content" id="videoTabContent">
        <!-- Video Edition -->
        <div class="tab-pane fade show active" id="edition" role="tabpanel">
            <form action="${pageContext.request.contextPath}/admin/videoManagement" method="post">

                <div class="mb-2">
                    <label class="form-label">Poster:</label>
                    <input type="hidden" name="poster" id="posterInput">
                    <div class="mt-2">
                        <img id="posterPreview"
                             src="${video.poster != null ? video.poster : ''}"
                             class="img-fluid"
                             alt="poster"
                             style="max-height: 200px;">
                    </div>
                </div>

                <div class="mb-2">
                    <label class="form-label">ID:</label>
                    <input type="text" class="form-control" name="id" value="${video.id}">
                </div>
                <div class="mb-2">
                    <label class="form-label">Video Title:</label>
                    <input type="text" class="form-control" name="title" value="${video.title}">
                </div>

                <div class="mb-2">
                    <label class="form-label">View Count:</label>
                    <input type="number" class="form-control" name="views" value="${video.views}" readonly>
                </div>

                <div class="mb-2">
                    <label class="form-label">Link (YouTube):</label>
                    <input type="text" class="form-control" id="videoLink" value="${video.link}">
                    <input type="hidden" id="embedLink" name="link">
                </div>

                <div class="mb-2">
                    <label class="form-label d-block">Trạng thái:</label>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="activeCheck" name="active" value="true" ${video.active ? "checked" : ""}>
                        <label class="form-check-label" for="activeCheck">Active</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="inactiveCheck" name="active" value="false" ${!video.active ? "checked" : ""}>
                        <label class="form-check-label" for="inactiveCheck">Inactive</label>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Description:</label>
                    <textarea class="form-control" name="description" rows="3">${video.description}</textarea>
                </div>

                <div class="btn-group-bottom">
                    <button type="submit" class="btn btn-success" name="action" value="create">Create</button>
                    <button type="submit" class="btn btn-secondary" name="action" value="update">Update</button>
                    <button type="submit" class="btn btn-danger" name="action" value="delete">Delete</button>
                    <button type="submit" class="btn btn-warning" name="action" value="reset">Reset</button>
                </div>
            </form>
            <i>${message}</i>

        </div>

        <!-- Video List (empty placeholder) -->
        <div class="tab-pane fade" id="list" role="tabpanel">
            <div class="mt-3">
                <c:if test="${!empty videos}">
                    <table class="table table-bordered table-hover table-striped text-center align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Title</th>
                                <th>Poster</th>
                                <th>Views</th>
                                <th>Description</th>
                                <th>Active</th>
                                <th>Link</th>
                                <th>Edit</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="v" items="${videos}">
                            <tr>
                                <td>${v.id}</td>
                                <td>${v.title}</td>
                                <td><a href="${pageContext.request.contextPath}/user/videoDetail?id=${v.id}"><c:set var="videoId" value="${fn:substringAfter(v.link, '/embed/')}" />
                                    <img src="https://img.youtube.com/vi/${videoId}/hqdefault.jpg" alt="${video.title}" style="max-height: 300px;" /></a></td>
                                <td>${v.views}</td>
                                <td>${v.description}</td>
                                <td><c:out value="${v.active ? 'Còn' : 'Hết'}" /></td>
                                <td><a href="${v.link}" target="_blank">${v.link}</a></td>
                                <td> <a href="${pageContext.request.contextPath}/admin/videoManagement/edit?id=${v.id}" class="btn btn-sm btn-primary">Edit</a></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${empty videos}">
                    <div class="alert alert-warning text-center">Không có video nào được tìm thấy.</div>
                </c:if>
            </div>
        </div>
    </div>
<script>
    function extractYouTubeId(url) {
        let regExp = /(?:youtu\.be\/|youtube\.com\/(?:watch\?v=|embed\/|v\/))([^?&"'>]+)/;
        let match = url.match(regExp);
        return match ? match[1] : null;
    }

    document.getElementById("videoLink").addEventListener("input", function() {
        let youtubeId = extractYouTubeId(this.value);
        if (youtubeId) {
            let embedUrl = "https://www.youtube.com/embed/" + youtubeId;
            let posterUrl = "https://img.youtube.com/vi/" + youtubeId + "/hqdefault.jpg";

            // set link embed để lưu vào DB
            document.getElementById("embedLink").value = embedUrl;

            // set poster để lưu vào DB
            document.getElementById("posterInput").value = posterUrl;

            // hiển thị ảnh poster
            document.getElementById("posterPreview").src = posterUrl;
        }
    });
</script>

</body>
</html>
