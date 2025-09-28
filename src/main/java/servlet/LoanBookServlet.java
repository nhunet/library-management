package servlet;

import service.DatabaseService;
import model.Member;
import model.Book;
import model.Loan;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/loan-book")
public class LoanBookServlet extends BaseServlet {
    private DatabaseService dbService = DatabaseService.getInstance();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        if (!isMemberLoggedIn(request)) {
            response.sendRedirect("member-login.jsp");
            return;
        }
        
        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            Member member = getCurrentMember(request);
            Book book = dbService.getBookById(bookId);
            
            if (book == null || !book.isAvailableForLoan()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Sách không có sẵn để mượn");
                return;
            }
            
            // Create new loan
            Loan loan = new Loan(member, book);
            dbService.saveLoan(loan);
            
            // Update book availability
            book.setAvailableQuantity(book.getAvailableQuantity() - 1);
            dbService.saveBook(book);
            
            response.sendRedirect("member-dashboard?success=loan");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}