package com.java04.filter;

import com.java04.entity.Users;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter({
        "/admin/*",
        "/change-password",
        "/user/videoLike/*",
        "/user/videoShare/*",
        "/user/videoUnlike/*",
})
public class AuthFilter implements Filter {
    public static final String SECURITY_URI = "securityUri";

    @Override
    public void init(FilterConfig filterConfig) throws ServletException { }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession();
        Users user = (Users) session.getAttribute("user");

        String uri = req.getRequestURI();

        if (user == null) {
            // Chưa đăng nhập → chuyển hướng login
            session.setAttribute(AuthFilter.SECURITY_URI, uri);
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Nếu là admin nhưng cố truy cập video (chỉ dành cho user thường)
        if (uri.contains("/user/videoLike/*")&&uri.contains("/user/videoShare/*")&&uri.contains("/user/videoUnlike/*") && user.getAdmin()) {
            resp.setContentType("text/html;charset=UTF-8");
            resp.getWriter().write("<h2 style='color: red; text-align: center; margin-top: 2rem;'>Admins are not allowed to access video features.</h2>");
            return;
        }

        // Nếu là user thường nhưng cố truy cập admin
        if (uri.contains("/admin/") && !user.getAdmin()) {
            resp.setContentType("text/html;charset=UTF-8");
            resp.getWriter().write("<h2 style='color: red; text-align: center; margin-top: 2rem;'>You do not have permission to access this page.</h2>");
            return;
        }

        // Có quyền → tiếp tục
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() { }
}
