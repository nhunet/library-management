package servlet;

import service.DatabaseService;
import model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin-login")
public class AdminLoginServlet extends BaseServlet {
    private DatabaseService dbService = DatabaseService.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("admin-login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin");
            request.getRequestDispatcher("admin-login.jsp").forward(request, response);
            return;
        }
        
        User user = dbService.getUserByUsername(username.trim());
        
        if (user != null && user.getPassword().equals(password) && user.isActive()) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("admin-dashboard");
        } else {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng");
            request.getRequestDispatcher("admin-login.jsp").forward(request, response);
        }
    }
}