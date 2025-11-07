package com.java04.controller;

import com.java04.entity.Favorite;
import com.java04.entity.Share;
import com.java04.entity.Users;
import com.java04.entity.Video;
import com.java04.service.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

@WebServlet({
        "/admin/videoManagement",
        "/admin/userManagement",
        "/admin/report",
        "/admin/videoManagement/create",
        "/admin/videoManagement/update",
        "/admin/videoManagement/delete",
        "/admin/videoManagement/reset",
        "/admin/videoManagement/edit/*"
})
public class AdminServlet extends HttpServlet {

    private final VideoDAO vdao = new VideoDAOImpl();
    private final UsersDAO udao = new UsersDAOImpl();
    private final FavoriteDAO fdao = new FavoriteDAOImpl();
    private final ShareDAO sdao = new ShareDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uri = request.getRequestURI();

        if (uri.contains("/admin/videoManagement")) {
            String id = request.getParameter("id");
            Video video = (id != null) ? vdao.findById(id) : new Video();
            request.setAttribute("video", video);

            List<Video> videos = vdao.findAll();
            request.setAttribute("videos", videos);
            request.getRequestDispatcher("/WEB-INF/jsp/admin/videoManagement.jsp").forward(request, response);
        } else if (uri.contains("/admin/userManagement")) {
            String action = request.getParameter("action");
            if ("edit".equals(action)) {
                String id = request.getParameter("id");
                Users selectedUser = udao.findById(id);
                request.setAttribute("selectedUser", selectedUser);
            }
            if ("reset".equals(action)) {
                request.setAttribute("selectedUser", null);
            }
            List<Users> users = udao.findAll();
            request.setAttribute("users", users);
            request.getRequestDispatcher("/WEB-INF/jsp/admin/userManagement.jsp").forward(request, response);
        } else if (uri.contains("/admin/report")) {
            List<Object[]> list = fdao.getVideoFavoritesSummary();
            request.setAttribute("favoritesSummary", list);
            String videoId = request.getParameter("videoId");
            String videoKey = request.getParameter("videoKey");

            // Đổ combobox
            List<Video> videos = vdao.getVideosWithFavorites();
            request.setAttribute("videos", videos);

            List<Video> videoss = vdao.getVideosWithShares();
            request.setAttribute("videoss", videoss);

            // Nếu đã chọn video -> lấy danh sách user
            if (videoId != null && !videoId.isEmpty()) {
                List<Favorite> favs = fdao.getUsersByVideoId(videoId);
                request.setAttribute("favorites", favs);
                request.setAttribute("selectedVideoId", videoId);
            }
            if (videoKey != null && !videoKey.isEmpty()) {
                List<Share> share = sdao.getUsersByVideoId(videoKey);
                request.setAttribute("share", share);
                request.setAttribute("selectedVideoKey", videoKey);
            }
            request.getRequestDispatcher("/WEB-INF/jsp/admin/report.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String uri = request.getRequestURI();

        if (uri.contains("/admin/videoManagement")) {
            handleVideoManagementPost(request, response);
        }
        if(uri.contains("/admin/userManagement")){
            String action = request.getParameter("action");
            String id = request.getParameter("id");
            String password = request.getParameter("password");
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            boolean admin = Boolean.parseBoolean(request.getParameter("admin"));

            if ("update".equals(action)) {
                Users user = new Users();
                user.setId(id);
                user.setPassword(password);
                user.setFullName(fullName);
                user.setEmail(email);
                user.setAdmin(admin);
                udao.update(user);
                request.setAttribute("message", "User updated successfully!");
            } else if ("delete".equals(action)) {
                udao.deleteById(id);
                request.setAttribute("message", "User deleted successfully!");
            }
            response.sendRedirect(request.getContextPath() + "/admin/userManagement");
        }
    }

    private void handleVideoManagementPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String id = request.getParameter("id");
        String title = request.getParameter("title");
        String poster = request.getParameter("poster");
        String link = request.getParameter("link");
        String description = request.getParameter("description");
        Boolean active = Boolean.valueOf(request.getParameter("active"));

        Video video = new Video();
        video.setId(id);
        video.setTitle(title);
        video.setLink(link);
        video.setDescription(description);

        video.setActive(active);
        video.setPoster(poster);

        try {
            switch (action) {
                case "create":
                    if (id == null || id.trim().isEmpty()) {
                        request.setAttribute("message", "ID cannot be empty when creating a new video.");
                    } else {
                        video.setViews(0);
                        vdao.create(video);
                        request.setAttribute("message", "Video created successfully!");
                    }
                    break;

                case "update":
                    String videoId = request.getParameter("id");
                    Video videos = vdao.findById(videoId);

                    if (videos != null) {
                        String newTitle = request.getParameter("title");
                        String newDescription = request.getParameter("description");
                        String newPoster = request.getParameter("poster");
                        String newLink = request.getParameter("link");
                        boolean newActive = Boolean.parseBoolean(request.getParameter("active"));

                        boolean linkChanged = !videos.getLink().equals(newLink);

                        videos.setTitle(newTitle);
                        videos.setDescription(newDescription);
                        videos.setPoster(newPoster);
                        videos.setLink(newLink);
                        videos.setActive(newActive);

                        if (linkChanged) {
                            // Reset lượt xem nếu link video thay đổi
                            videos.setViews(0);
                        }
                        // Nếu link không đổi thì giữ nguyên lượt xem

                        vdao.update(videos);
                        request.setAttribute("message", "Video updated successfully!");
                    } else {
                        request.setAttribute("message", "Video not found!");
                    }
                    break;

                case "delete":
                    vdao.deleteById(id);
                    request.setAttribute("message", "Video deleted successfully!");
                    video = new Video(); // clear form
                    break;

                case "reset":
                    video = new Video(); // clear form
                    break;

                default:
                    request.setAttribute("message", "Unknown action: " + action);
            }
        } catch (Exception e) {
            request.setAttribute("message", "Error during " + action + ": " + e.getMessage());
            e.printStackTrace();
        }

        // Load lại danh sách
        List<Video> videos = vdao.findAll();
        request.setAttribute("video", video);
        request.setAttribute("videos", videos);
        request.getRequestDispatcher("/WEB-INF/jsp/admin/videoManagement.jsp").forward(request, response);
    }

}
