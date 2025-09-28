package servlet;

import service.DatabaseService;
import model.Book;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/")
public class HomeServlet extends BaseServlet {
    private DatabaseService dbService = DatabaseService.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Book> books = dbService.getAllBooks();
        request.setAttribute("books", books);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}