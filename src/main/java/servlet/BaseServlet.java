package servlet;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Member;
import model.User;
import java.io.IOException;

public abstract class BaseServlet extends HttpServlet {
    
    protected boolean isUserLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute("user") != null;
    }
    
    protected boolean isMemberLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute("member") != null;
    }
    
    protected User getCurrentUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null ? (User) session.getAttribute("user") : null;
    }
    
    protected Member getCurrentMember(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null ? (Member) session.getAttribute("member") : null;
    }
    
    protected void redirectToLogin(HttpServletResponse response, String type) throws IOException {
        if ("admin".equals(type)) {
            response.sendRedirect("admin-login.jsp");
        } else {
            response.sendRedirect("member-login.jsp");
        }
    }
}