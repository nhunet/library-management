package servlet;

import service.DatabaseService;
import model.Author;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.Date;

@WebServlet("/admin-authors")
public class AdminAuthorServlet extends BaseServlet {
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
            int authorId = Integer.parseInt(request.getParameter("id"));
            Author author = dbService.getAuthorById(authorId);
            request.setAttribute("author", author);
            request.getRequestDispatcher("admin-author-form.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            int authorId = Integer.parseInt(request.getParameter("id"));
            dbService.deleteAuthor(authorId);
            response.sendRedirect("admin-authors?success=delete");
        } else {
            List<Author> authors = dbService.getAllAuthors();
            request.setAttribute("authors", authors);
            request.getRequestDispatcher("admin-authors.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        if (!isUserLoggedIn(request)) {
            redirectToLogin(response, "admin");
            return;
        }
        
        String name = request.getParameter("name");
        String biography = request.getParameter("biography");
        String nationality = request.getParameter("nationality");
        String birthDateStr = request.getParameter("birthDate");
        
        Author author;
        String authorIdStr = request.getParameter("authorId");
        if (authorIdStr != null && !authorIdStr.isEmpty()) {
            // Update existing author
            author = dbService.getAuthorById(Integer.parseInt(authorIdStr));
            author.setName(name);
            author.setBiography(biography);
            author.setNationality(nationality);
        } else {
            // Create new author
            author = new Author(name, biography, nationality);
        }
        
        // Parse birth date
        if (birthDateStr != null && !birthDateStr.trim().isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date birthDate = sdf.parse(birthDateStr);
                author.setBirthDate(birthDate);
            } catch (ParseException e) {
                // Ignore parse error
            }
        }
        
        dbService.saveAuthor(author);
        response.sendRedirect("admin-authors?success=save");
    }
}