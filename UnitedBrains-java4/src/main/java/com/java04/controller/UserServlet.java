package com.java04.controller;

import com.java04.entity.Favorite;
import com.java04.entity.Share;
import com.java04.entity.Users;
import com.java04.entity.Video;
import com.java04.service.*;
import com.java04.utils.MailSender;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@WebServlet({"/user/videoList","/user/videoDetail/*","/user/videoShare/*","/user/videoLike/*","/user/videoUnlike","/user/videoDt/*","/user/videoWatch/*"})
public class UserServlet extends HttpServlet {
    VideoDAO vdao = new VideoDAOImpl();
    FavoriteDAO fdao = new FavoriteDAOImpl();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uri = request.getRequestURI();
        if (uri.contains("/user/videoList")) {
            List<Video> videos =  vdao.findAll();
            request.setAttribute("videos", videos);
            request.getRequestDispatcher("/WEB-INF/jsp/user/videoList.jsp").forward(request, response);
        }
        if (uri.contains("/user/videoDetail")) {
            String id = request.getParameter("id");
            Video video = vdao.findById(id);
            List<Video> videos =  vdao.findAll();
            request.setAttribute("videos", videos);
            request.setAttribute("video", video);
            request.getRequestDispatcher("/WEB-INF/jsp/user/videoDetail.jsp").forward(request, response);
        }
        if (uri.contains("/user/videoDt")) {
            String id = request.getParameter("id");
            Video video = vdao.findById(id);
            List<Video> videos =  vdao.findAll();
            request.setAttribute("videos", videos);
            request.setAttribute("video", video);
            request.getRequestDispatcher("/WEB-INF/jsp/user/videoDetailHome.jsp").forward(request, response);
        }
        if (uri.contains("/user/videoShare")) {
            request.getRequestDispatcher("/WEB-INF/jsp/user/videoShare.jsp").forward(request, response);
        }
        if (uri.contains("/user/videoLike")) {
            Users user = (Users) request.getSession().getAttribute("user");
            List<Favorite> favorites = fdao.findByUserId(user.getId());
            request.setAttribute("favorites", favorites);
            request.getRequestDispatcher("/WEB-INF/jsp/user/videoLike.jsp").forward(request, response);
        }
        if (uri.contains("/user/videoWatch")) {
            String videoId = request.getParameter("id");

            if (videoId != null) {
                // Tăng lượt xem
                vdao.incrementViews(videoId);

                // Lấy video để hiển thị
                Video video = vdao.findById(videoId);
                request.setAttribute("video", video);
                List<Video> videos =  vdao.findAll();
                request.setAttribute("videos", videos);
                HttpSession session = request.getSession();
                Object user = session.getAttribute("user");
                if( user != null) {
                    request.getRequestDispatcher("/WEB-INF/jsp/user/videoDetailWatch.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("/WEB-INF/jsp/user/videoDetailHomeWatch.jsp").forward(request, response);
                }

            }
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uri = request.getRequestURI();
        if (uri.contains("/user/videoShare")) {
            String emailsInput = request.getParameter("emails");
            String videoId = request.getParameter("videoId");
// Tách email bởi dấu phẩy hoặc chấm phẩy
            String[] emails = emailsInput.split("[,;\\s]+");

// Tạo link video cần gửi
            Video video = vdao.findById(videoId);
            String videoLink;
            if (video != null && video.getLink() != null) {
                videoLink = video.getLink();
            } else {
                videoLink = "#"; // Hoặc xử lý lỗi
            }
            HttpSession session = request.getSession();
            Users user = (Users) session.getAttribute("user");
            for (String email : emails) {
                if (!email.trim().isEmpty()) {// Gửi email
                    MailSender.send(email, user.getFullName()+ " đã chia sẽ 1 video với bạn" ,
                            video.getTitle() + "\n" + videoLink);
                }
            }
            user = (Users) request.getSession().getAttribute("user");
            if (user != null && video != null) {
                Share share = new Share();
                share.setId(UUID.randomUUID().getMostSignificantBits() & Long.MAX_VALUE);
                share.setUser(user);
                share.setVideo(video);
                share.setEmails(emailsInput);
                share.setShareDate(new Date());

                ShareDAO shareDAO = new ShareDAOImpl();
                shareDAO.create(share);
            }
            request.setAttribute("message", "Video đã được chia sẻ thành công!");
            request.getRequestDispatcher("/WEB-INF/jsp/user/videoShare.jsp").forward(request, response);
        }
        if (uri.contains("/user/videoLike")) {
            String videoId = request.getParameter("videoId");
            Users user = (Users) request.getSession().getAttribute("user");
            if (user != null && videoId != null) {
                Video video = vdao.findById(videoId);

                if (video != null) {

                    Favorite f = new Favorite();
                    f.setId(UUID.randomUUID().getMostSignificantBits() & Long.MAX_VALUE);
                    f.setUser(user);
                    f.setVideo(video);
                    f.setLikeDate(new Date());
                    fdao.create(f);
                }
            }

            response.sendRedirect(request.getContextPath() + "/user/videoLike");
        }
        if(uri.contains("/user/videoUnlike")){
            String favoriteIdStr = request.getParameter("favoriteId");

            try {
                long favoriteId = Long.parseLong(favoriteIdStr);
                fdao.deleteById(favoriteId); // gọi DAO để xóa
            } catch (Exception e) {
                e.printStackTrace(); // có thể log hoặc báo lỗi
            }
            response.sendRedirect(request.getContextPath() + "/user/videoLike");
        }
    }
}

