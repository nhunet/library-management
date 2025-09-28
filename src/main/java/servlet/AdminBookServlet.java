package servlet;

import service.DatabaseService;
import model.Book;
import model.Author;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin-books")
public class AdminBookServlet extends BaseServlet {
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
            int bookId = Integer.parseInt(request.getParameter("id"));
            Book book = dbService.getBookById(bookId);
            List<Author> authors = dbService.getAllAuthors();
            request.setAttribute("book", book);
            request.setAttribute("authors", authors);
            request.getRequestDispatcher("admin-book-form.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            int bookId = Integer.parseInt(request.getParameter("id"));
            dbService.deleteBook(bookId);
            response.sendRedirect("admin-books?success=delete");
        } else {
            List<Book> books = dbService.getAllBooks();
            List<Author> authors = dbService.getAllAuthors();
            request.setAttribute("books", books);
            request.setAttribute("authors", authors);
            request.getRequestDispatcher("admin-books.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        if (!isUserLoggedIn(request)) {
            redirectToLogin(response, "admin");
            return;
        }
        
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String[] authorIds = request.getParameterValues("authorIds");
        
        Book book;
        String bookIdStr = request.getParameter("bookId");
        if (bookIdStr != null && !bookIdStr.isEmpty()) {
            // Update existing book
            book = dbService.getBookById(Integer.parseInt(bookIdStr));
            book.setTitle(title);
            book.setDescription(description);
            book.setQuantity(quantity);
        } else {
            // Create new book
            book = new Book(title, description, quantity);
        }
        
        // Set authors
        book.getAuthors().clear();
        if (authorIds != null) {
            for (String authorIdStr : authorIds) {
                Author author = dbService.getAuthorById(Integer.parseInt(authorIdStr));
                if (author != null) {
                    book.getAuthors().add(author);
                }
            }
        }
        
        dbService.saveBook(book);
        response.sendRedirect("admin-books?success=save");
    }
}