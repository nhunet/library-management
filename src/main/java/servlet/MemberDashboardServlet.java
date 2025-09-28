package servlet;

import service.DatabaseService;
import model.Member;
import model.Loan;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/member-dashboard")
public class MemberDashboardServlet extends BaseServlet {
    private DatabaseService dbService = DatabaseService.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        if (!isMemberLoggedIn(request)) {
            redirectToLogin(response, "member");
            return;
        }
        
        Member member = getCurrentMember(request);
        List<Loan> loans = dbService.getLoansByMember(member);
        
        request.setAttribute("loans", loans);
        request.getRequestDispatcher("member-dashboard.jsp").forward(request, response);
    }
}
