package servlet;

import service.DatabaseService;
import model.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Date;

@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends BaseServlet {
    private DatabaseService dbService = DatabaseService.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        if (!isUserLoggedIn(request)) {
            redirectToLogin(response, "admin");
            return;
        }
        
        // Get statistics
        List<Book> books = dbService.getAllBooks();
        List<Member> members = dbService.getAllMembers();
        List<Author> authors = dbService.getAllAuthors();
        List<Loan> loans = dbService.getAllLoans();
        List<Loan> monthlyLoans = dbService.getLoansInMonth(new Date());
        
        request.setAttribute("bookCount", books.size());
        request.setAttribute("memberCount", members.size());
        request.setAttribute("authorCount", authors.size());
        request.setAttribute("loanCount", loans.size());
        request.setAttribute("monthlyLoanCount", monthlyLoans.size());
        
        request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
    }
}