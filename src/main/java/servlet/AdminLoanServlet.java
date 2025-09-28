package servlet;

import service.DatabaseService;
import model.Loan;
import model.Book;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Date;

@WebServlet("/admin-loans")
public class AdminLoanServlet extends BaseServlet {
    private DatabaseService dbService = DatabaseService.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        if (!isUserLoggedIn(request)) {
            redirectToLogin(response, "admin");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("return".equals(action)) {
            int loanId = Integer.parseInt(request.getParameter("id"));
            Loan loan = dbService.getLoanById(loanId);
            if (loan != null && "ACTIVE".equals(loan.getStatus())) {
                loan.setReturnDate(new Date());
                loan.setStatus("RETURNED");
                
                // Update book availability
                Book book = loan.getBook();
                book.setAvailableQuantity(book.getAvailableQuantity() + 1);
                dbService.saveBook(book);
                
                dbService.saveLoan(loan);
            }
            response.sendRedirect("admin-loans?success=return");
        } else {
            List<Loan> loans = dbService.getAllLoans();
            request.setAttribute("loans", loans);
            request.getRequestDispatcher("admin-loans.jsp").forward(request, response);
        }
    }
}