package servlet;

import service.DatabaseService;
import model.Member;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin-members")
public class AdminMemberServlet extends BaseServlet {
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
            int memberId = Integer.parseInt(request.getParameter("id"));
            Member member = dbService.getMemberById(memberId);
            request.setAttribute("member", member);
            request.getRequestDispatcher("admin-member-form.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            int memberId = Integer.parseInt(request.getParameter("id"));
            dbService.deleteMember(memberId);
            response.sendRedirect("admin-members?success=delete");
        } else {
            List<Member> members = dbService.getAllMembers();
            request.setAttribute("members", members);
            request.getRequestDispatcher("admin-members.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        if (!isUserLoggedIn(request)) {
            redirectToLogin(response, "admin");
            return;
        }
        
        String memberCode = request.getParameter("memberCode");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        boolean isActive = "on".equals(request.getParameter("isActive"));
        
        Member member;
        String memberIdStr = request.getParameter("memberId");
        if (memberIdStr != null && !memberIdStr.isEmpty()) {
            // Update existing member
            member = dbService.getMemberById(Integer.parseInt(memberIdStr));
            member.setMemberCode(memberCode);
            member.setFullName(fullName);
            member.setEmail(email);
            member.setPhone(phone);
            member.setAddress(address);
            if (password != null && !password.trim().isEmpty()) {
                member.setPassword(password);
            }
            member.setActive(isActive);
        } else {
            // Create new member
            member = new Member(memberCode, fullName, email, password);
            member.setPhone(phone);
            member.setAddress(address);
            member.setActive(isActive);
        }
        
        dbService.saveMember(member);
        response.sendRedirect("admin-members?success=save");
    }
}