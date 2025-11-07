/*package com.java04.controller;

import com.java04.entity.Users;
import com.java04.service.UsersDAO;
import com.java04.service.UsersDAOImpl;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.channels.ScatteringByteChannel;

@WebServlet({"/login", "/changePassword", "/logout",
        "/adminLogout", "/forgotPassword", "/profile"
})
public class AuthServlet extends HttpServlet {
    private UsersDAO  usersDAO = new UsersDAOImpl();

    @Override
    protected doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        String uri = req.getRequestURI();
        if (uri.contains("logout")){
            req.getSession().invalidate();
            resp.sendRedirect(req.getContextPath()+"/login");
        }
        String page = null;
        if (uri.contains("login")) page = "login";
        else if (uri.contains("register")) page = "register";
        else if (uri.contains("change-password")) page = "change-password";
        else if (uri.contains("forgot-password")) page = "forgot-password";
        else if (uri.contains("profile")) page = "profile";

        if (page != null){
            req.setAttribute("includePage", "/user/" + page + ".jsp");
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("/login");
        }
    }
    protect doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        String uri = req.getRequestURI();

        if (uri.contains("register")) {
            try {
                Users user = new Users();
                BeanUtils.populate(user, req.getParameterMap());
                user.setAdmin(false);
                usersDAO.create(user);

                req.setAttribute("message", "Register Success, Please login.");
                req.setAttribute("includePage", "/user/login.jsp");
                req.getRequestDispatcher("/index.jsp").forward(req, resp);
            } catch (Exception e){
                req.setAttribute("error", "Regis Failed");
                req.setAttribute("includePage", "/user/register.jsp");
                req.getRequestDispatcher("/index.jsp").forward(req, resp);
            }
        }
        if (uri.contains("login")){
            try {

            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
        return null;
    }
}*/


