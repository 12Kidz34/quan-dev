package com.java04.controller;

/*import com.java04.entity.Users;
import com.java04.service.UsersDAO;
import com.java04.service.UsersDAOImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet({"/login","/changePassword","/register","/index"})
public class LoginServlet extends HttpServlet {
    UsersDAO dao = new UsersDAOImpl();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uri = request.getRequestURI();
        if (uri.contains("/login")) {
            request.getRequestDispatcher("/WEB-INF/jsp/login/login.jsp").forward(request, response);
        }
        if (uri.contains("/changePassword")) {
            request.getRequestDispatcher("/WEB-INF/jsp/user/changePassword.jsp").forward(request, response);
        }
        if (uri.contains("/register")) {
            request.getRequestDispatcher("/WEB-INF/jsp/login/accountRegister.jsp").forward(request, response);
        }
        if (uri.contains("/index")) {
            request.getRequestDispatcher("/WEB-INF/jsp/home/index.jsp").forward(request, response);
        }
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uri = request.getRequestURI();
        if (uri.contains("/login")) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");


            Users user = dao.findById(username);

            if (user == null) {
                request.setAttribute("message", "Invalid username");
            } else if (!user.getPassword().equals(password)) {
                request.setAttribute("message", "Invalid password");
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                request.setAttribute("message", "Login successfully");
                Users user1 = (Users) session.getAttribute("user");
                Boolean role = user1.getAdmin(); // giả sử là "admin" hoặc "user"

                if (Boolean.TRUE.equals(role)) {
                    request.getRequestDispatcher("/WEB-INF/jsp/home/home.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("/WEB-INF/jsp/home/userHome.jsp").forward(request, response);
                }
                return;
            }
            request.getRequestDispatcher("/WEB-INF/jsp/login/login.jsp").forward(request, response);
        }
        if(uri.contains("/changePassword")){
            HttpSession session = request.getSession();
            Users user = (Users) session.getAttribute("user");
            String userId = request.getParameter("userId");
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            Users u = dao.findById(userId);
            if (u == null) {
                request.setAttribute("message", "Không tìm thấy người dùng với ID: " + userId);
                request.getRequestDispatcher("/WEB-INF/jsp/user/changePassword.jsp").forward(request, response);
                return;
            }
            // Kiểm tra mật khẩu hiện tại
            if (!user.getPassword().equals(currentPassword)) {
                request.setAttribute("message", "Mật khẩu hiện tại không đúng");
                request.getRequestDispatcher("/WEB-INF/jsp/user/changePassword.jsp").forward(request, response);
                return;
            }

            // Kiểm tra xác nhận mật khẩu
            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("message", "Xác nhận mật khẩu không khớp");
                request.getRequestDispatcher("/WEB-INF/jsp/user/changePassword.jsp").forward(request, response);
                return;
            }

            // Cập nhật mật khẩu mới
            user.setPassword(newPassword);
              // Đảm bảo phương thức update có xử lý cập nhật mật khẩu
            dao.update(user);
            request.setAttribute("message", "Đổi mật khẩu thành công");
            request.getRequestDispatcher("/WEB-INF/jsp/user/changePassword.jsp").forward(request, response);
        }
        if(uri.contains("/register")){
            request.setCharacterEncoding("UTF-8");

            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String fullname = request.getParameter("fullname");
            String email = request.getParameter("email");

            Users user = new Users();
            user.setId(username);
            user.setPassword(password); // Nên mã hóa mật khẩu trước khi lưu
            user.setFullName(fullname);
            user.setEmail(email);
            user.setAdmin(false); // Mặc định admin = false

            dao.create(user);

            request.setAttribute("message", "Đăng ký thành công!");
            request.getRequestDispatcher("/WEB-INF/jsp/login/accountRegister.jsp").forward(request, response);
        }
    }
}*/
import com.java04.entity.Users;
import com.java04.entity.Video;
import com.java04.service.UsersDAO;
import com.java04.service.UsersDAOImpl;
import com.java04.service.VideoDAO;
import com.java04.service.VideoDAOImpl;
import com.java04.utils.MailSender;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet({"/login", "/changePassword", "/logout", "/register"})
public class LoginServlet extends HttpServlet {
    // Khai báo nhưng không khởi tạo ngay để tránh lỗi khởi tạo servlet
    private UsersDAO  usersDAO;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        // Khởi tạo usersDAO khi cần thiết
        try {
            usersDAO = new UsersDAOImpl();
        } catch (Exception e) {
            // Xử lý lỗi khởi tạo DAO (thường do lỗi kết nối cơ sở dữ liệu)
            req.setAttribute("error", "Database connection error: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/jsp/login/login.jsp").forward(req, resp);
            return;
        }

        String uri = req.getRequestURI();
        if (uri.contains("logout")){
            req.getSession().invalidate();
            resp.sendRedirect(req.getContextPath()+"/");
            return;
        }

        if (uri.contains("login")) {
            req.getRequestDispatcher("/WEB-INF/jsp/login/login.jsp").forward(req, resp);
        } else if (uri.contains("register")) {
            req.getRequestDispatcher("/WEB-INF/jsp/login/accountRegister.jsp").forward(req, resp);
        } else if (uri.contains("changePassword")) {
            req.getRequestDispatcher("/WEB-INF/jsp/user/changePassword.jsp").forward(req, resp);
            // Chuyển hướng về trang đăng nhập thay vì trang chủ
            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        // Khởi tạo usersDAO khi cần thiết
        try {
            usersDAO = new UsersDAOImpl();
        } catch (Exception e) {
            // Xử lý lỗi khởi tạo DAO (thường do lỗi kết nối cơ sở dữ liệu)
            req.setAttribute("error", "Database connection error: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/jsp/login/login.jsp").forward(req, resp);
            return;
        };

        String uri = req.getRequestURI();

        if (uri.contains("register")) {
            try {
                req.setCharacterEncoding("UTF-8");

                String username = req.getParameter("username");
                String password = req.getParameter("password");
                String fullname = req.getParameter("fullname");
                String email = req.getParameter("email");

                Users user = new Users();
                user.setId(username);
                user.setPassword(password); // Nên mã hóa mật khẩu trước khi lưu
                user.setFullName(fullname);
                user.setEmail(email);
                user.setAdmin(false); // Mặc định admin = false

                usersDAO.create(user);
                MailSender.send(user.getEmail(), "Chào mừng đến với OE Video!",
                        "Xin chào " + user.getFullName() + ",\n\nTài khoản của bạn đã được đăng ký thành công.");
                req.setAttribute("message", "Register Success, Please login.");
                resp.sendRedirect(req.getContextPath() + "/login");
            } catch (Exception e){
                req.setAttribute("error", "Registration Failed: " + e.getMessage());
                req.getRequestDispatcher("/WEB-INF/jsp/login/accountRegister.jsp").forward(req, resp);
            }
        }

        if (uri.contains("login")){
            try {
                // Lấy thông tin từ form đăng nhập
                String username = req.getParameter("username");
                String password = req.getParameter("password");

                Users user = usersDAO.findByIdOrEmail(username);

                if (user == null) {
                    req.setAttribute("message", "Invalid username");
                    req.getRequestDispatcher("/WEB-INF/jsp/login/login.jsp").forward(req, resp);
                } else if (!user.getPassword().equals(password)) {
                    req.setAttribute("message", "Invalid password");
                    req.getRequestDispatcher("/WEB-INF/jsp/login/login.jsp").forward(req, resp);
                } else {
                    HttpSession session = req.getSession();
                    session.setAttribute("user", user);
                    req.setAttribute("message", "Login successfully");
                    Boolean role = user.getAdmin(); // giả sử là "admin" hoặc "user"

                    String targetPage;
                    if (Boolean.TRUE.equals(role)) {
                        targetPage = "/WEB-INF/jsp/home/home.jsp";
                    } else {
                        VideoDAO vdao = new VideoDAOImpl();
                        List<Video> videos =  vdao.findAll();
                        req.setAttribute("videos", videos);
                        targetPage = "/WEB-INF/jsp/home/userHome.jsp";
                    }

                    req.getRequestDispatcher(targetPage).forward(req, resp);


                }
            } catch (Exception e) {
                req.setAttribute("error", "Login Failed: " + e.getMessage());
                req.getRequestDispatcher("/WEB-INF/jsp/login/login.jsp").forward(req, resp);
            }
        }
        if(uri.contains("/changePassword")){
            HttpSession session = req.getSession();
            Users user = (Users) session.getAttribute("user");
            String userId = req.getParameter("userId");
            String currentPassword = req.getParameter("currentPassword");
            String newPassword = req.getParameter("newPassword");
            String confirmPassword = req.getParameter("confirmPassword");
            Users u = usersDAO.findById(userId);
            if (u == null) {
                req.setAttribute("message", "Không tìm thấy người dùng với ID: " + userId);
                req.getRequestDispatcher("/WEB-INF/jsp/user/changePassword.jsp").forward(req, resp);
                return;
            }
            // Kiểm tra mật khẩu hiện tại
            if (!user.getPassword().equals(currentPassword)) {
                req.setAttribute("message", "Mật khẩu hiện tại không đúng");
                req.getRequestDispatcher("/WEB-INF/jsp/user/changePassword.jsp").forward(req, resp);
                return;
            }

            // Kiểm tra xác nhận mật khẩu
            if (!newPassword.equals(confirmPassword)) {
                req.setAttribute("message", "Xác nhận mật khẩu không khớp");
                req.getRequestDispatcher("/WEB-INF/jsp/user/changePassword.jsp").forward(req, resp);
                return;
            }

            // Cập nhật mật khẩu mới
            user.setPassword(newPassword);
            // Đảm bảo phương thức update có xử lý cập nhật mật khẩu
            usersDAO.update(user);
            req.setAttribute("message", "Đổi mật khẩu thành công");
            req.getRequestDispatcher("/WEB-INF/jsp/user/changePassword.jsp").forward(req, resp);
        }
    }
    public UsersDAO getUsersDAO() {
        return usersDAO;
    }

    public void setUsersDAO(UsersDAO usersDAO) {
        this.usersDAO = usersDAO;
    }

}
