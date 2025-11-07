<%--
  Created by IntelliJ IDEA.
  User: Ca Ngao
  Date: 7/24/2025
  Time: 3:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quản lý User</title>
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

    <h5 class="mb-3">QUẢN LÝ USER</h5>

    <!-- Tabs -->
    <ul class="nav nav-tabs" id="userTab" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" id="edition-tab" data-bs-toggle="tab" data-bs-target="#edition" type="button" role="tab">
                USER EDITION
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="list-tab" data-bs-toggle="tab" data-bs-target="#list" type="button" role="tab">
                USER LIST
            </button>
        </li>
    </ul>

    <!-- Tab content -->
    <div class="tab-content" id="userTabContent">

        <!-- USER EDITION -->
        <div class="tab-pane fade show active" id="edition" role="tabpanel">
            <form class="mt-3" action="${pageContext.request.contextPath}/admin/userManagement" method="post">
                <input type="hidden" name="action" value="update" id="formAction">

                <div class="row mb-2">
                    <div class="col-md-6">
                        <label class="form-label">ID:</label>
                        <input type="text" name="id" class="form-control" value="${selectedUser.id}" ${selectedUser != null ? 'readonly' : ''}>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Password:</label>
                        <input type="password" name="password" class="form-control" value="${selectedUser.password}">
                    </div>
                </div>

                <div class="row mb-2">
                    <div class="col-md-6">
                        <label class="form-label">Fullname:</label>
                        <input type="text" name="fullName" class="form-control" value="${selectedUser.fullName}">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Email Address:</label>
                        <input type="email" name="email" class="form-control" value="${selectedUser.email}">
                    </div>
                </div>

                <!-- Role Radio -->
                <div class="mb-3">
                    <label class="form-label d-block">Role:</label>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="admin" value="false" ${selectedUser == null || !selectedUser.admin ? 'checked' : ''}>
                        <label class="form-check-label">User</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="admin" value="true" ${selectedUser != null && selectedUser.admin ? 'checked' : ''}>
                        <label class="form-check-label">Admin</label>
                    </div>
                </div>

                <!-- Buttons -->
                <div class="btn-group-bottom">
                    <button type="submit" class="btn btn-secondary" onclick="document.getElementById('formAction').value='update'">Update</button>
                    <button type="submit" class="btn btn-danger" onclick="document.getElementById('formAction').value='delete'">Delete</button>
                    <button type="submit" class="btn btn-warning" onclick="document.getElementById('formAction').value='reset'">Reset</button>
                </div>
            </form>
            <i>${message}</i>
        </div>


        <!-- USER LIST (placeholder) -->
        <div class="tab-pane fade" id="list" role="tabpanel">
            <div class="mt-3">
                <c:if test="${!empty users}">
                    <table class="table table-bordered table-hover table-striped text-center align-middle">
                        <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Password</th>
                            <th>Fullname</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Edit</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="u" items="${users}">
                            <tr>
                                <td>${u.id}</td>
                                <td>${u.password}</td>
                                <td>${u.fullName}</td>
                                <td>${u.email}</td>
                                <td><c:out value="${u.admin ? 'Admin' : 'User'}" /></td>
                                <td><a href="${pageContext.request.contextPath}/admin/userManagement?action=edit&id=${u.id}" class="btn btn-sm btn-primary">Edit</a></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${empty users}">
                    <div class="alert alert-warning text-center">Không có user nào được tìm thấy.</div>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>
