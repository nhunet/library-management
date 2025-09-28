package servlet;

import service.DatabaseService;
import model.Loan;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Date;
import java.util.Calendar;
import java.text.SimpleDateFormat;
import java.text.ParseException;

@WebServlet("/admin-statistics")
public class AdminStatisticsServlet extends BaseServlet {
    private DatabaseService dbService = DatabaseService.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        if (!isUserLoggedIn(request)) {
            redirectToLogin(response, "admin");
            return;
        }
        
        Date selectedMonth = new Date(); // Default to current month
        String monthParam = request.getParameter("month");
        
        if (monthParam != null && !monthParam.isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
                selectedMonth = sdf.parse(monthParam);
            } catch (ParseException e) {
                // Use default date
            }
        }
        
        List<Loan> monthlyLoans = dbService.getLoansInMonth(selectedMonth);
        
        Calendar cal = Calendar.getInstance();
        cal.setTime(selectedMonth);
        String monthYear = new SimpleDateFormat("MM/yyyy").format(selectedMonth);
        
        request.setAttribute("monthlyLoans", monthlyLoans);
        request.setAttribute("selectedMonth", monthYear);
        request.setAttribute("selectedMonthValue", new SimpleDateFormat("yyyy-MM").format(selectedMonth));
        request.getRequestDispatcher("admin-statistics.jsp").forward(request, response);
    }
}