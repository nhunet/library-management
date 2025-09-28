package servlet;

import service.DatabaseService;
import model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin-users")
public class AdminUserServlet extends BaseServlet {
    private DatabaseService dbService = DatabaseService.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        if (!isUserLoggedIn(request)) {
            redirectToLogin(response, "admin");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("edit".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("id"));
            User user = dbService.getUserById(userId);
            request.setAttribute("user", user);
            request.getRequestDispatcher("admin-user-form.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("id"));
            User currentUser = getCurrentUser(request);
            if (currentUser.getId() != userId) { // Can't delete self
                dbService.deleteUser(userId);
            }
            response.sendRedirect("admin-users?success=delete");
        } else {
            List<User> users = dbService.getAllUsers();
            request.setAttribute("users", users);
            request.getRequestDispatcher("admin-users.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        if (!isUserLoggedIn(request)) {
            redirectToLogin(response, "admin");
            return;
        }
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String role = request.getParameter("role");
        boolean isActive = "on".equals(request.getParameter("isActive"));
        
        User user;
        String userIdStr = request.getParameter("userId");
        if (userIdStr != null && !userIdStr.isEmpty()) {
            // Update existing user
            user = dbService.getUserById(Integer.parseInt(userIdStr));
            user.setUsername(username);
            if (password != null && !password.trim().isEmpty()) {
                user.setPassword(password);
            }
            user.setFullName(fullName);
            user.setEmail(email);
            user.setRole(role);
            user.setActive(isActive);
        } else {
            // Create new user
            user = new User(username, password, fullName, role);
            user.setEmail(email);
            user.setActive(isActive);
        }
        
        dbService.saveUser(user);
        response.sendRedirect("admin-users?success=save");
    }
}