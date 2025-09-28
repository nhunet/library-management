package service;

import com.db4o.Db4oEmbedded;
import com.db4o.ObjectContainer;
import com.db4o.ObjectSet;
import com.db4o.config.EmbeddedConfiguration;
import model.*;
import java.util.List;
import java.util.ArrayList;
import java.util.Date;
import java.util.Calendar;

public class DatabaseService {
    private static final String DB_FILE = "library.db4o";
    private static DatabaseService instance;
    private ObjectContainer db;
    
    private DatabaseService() {
        initializeDatabase();
        createDefaultData();
    }
    
    public static synchronized DatabaseService getInstance() {
        if (instance == null) {
            instance = new DatabaseService();
        }
        return instance;
    }
    
    private void initializeDatabase() {
        EmbeddedConfiguration config = Db4oEmbedded.newConfiguration();
        config.common().objectClass(Book.class).cascadeOnUpdate(true);
        config.common().objectClass(Author.class).cascadeOnUpdate(true);
        config.common().objectClass(Member.class).cascadeOnUpdate(true);
        config.common().objectClass(User.class).cascadeOnUpdate(true);
        config.common().objectClass(Loan.class).cascadeOnUpdate(true);
        
        db = Db4oEmbedded.openFile(config, DB_FILE);
    }
    
    private void createDefaultData() {
        // Create default admin user
        List<User> users = getAllUsers();
        if (users.isEmpty()) {
            User admin = new User("admin", "admin123", "Administrator", "ADMIN");
            admin.setEmail("admin@library.com");
            saveUser(admin);
            
            // Create sample authors
            Author author1 = new Author("Nguyễn Du", "Tác giả của Truyện Kiều", "Việt Nam");
            Author author2 = new Author("Tô Hoài", "Tác giả nổi tiếng văn học thiếu nhi", "Việt Nam");
            saveAuthor(author1);
            saveAuthor(author2);
            
            // Create sample books
            Book book1 = new Book("Truyện Kiều", "Tác phẩm kinh điển của văn học Việt Nam", 5);
            book1.getAuthors().add(author1);
            
            Book book2 = new Book("Dế Mèn phiêu lưu ký", "Tác phẩm nổi tiếng dành cho thiếu nhi", 3);
            book2.getAuthors().add(author2);
            
            saveBook(book1);
            saveBook(book2);
            
            // Create sample member
            Member member = new Member("M001", "Nguyễn Văn A", "member@example.com", "123456");
            member.setPhone("0123456789");
            member.setAddress("123 Đường ABC, TP.HCM");
            saveMember(member);
        }
    }
    
    // Book operations
    public void saveBook(Book book) {
        if (book.getId() == 0) {
            book.setId(generateBookId());
        }
        db.store(book);
        db.commit();
    }
    
    public List<Book> getAllBooks() {
        ObjectSet<Book> result = db.queryByExample(Book.class);
        return new ArrayList<>(result);
    }
    
    public Book getBookById(int id) {
        Book example = new Book();
        example.setId(id);
        ObjectSet<Book> result = db.queryByExample(example);
        return result.hasNext() ? result.next() : null;
    }
    
    public void deleteBook(int id) {
        Book book = getBookById(id);
        if (book != null) {
            db.delete(book);
            db.commit();
        }
    }
    
    // Author operations
    public void saveAuthor(Author author) {
        if (author.getId() == 0) {
            author.setId(generateAuthorId());
        }
        db.store(author);
        db.commit();
    }
    
    public List<Author> getAllAuthors() {
        ObjectSet<Author> result = db.queryByExample(Author.class);
        return new ArrayList<>(result);
    }
    
    public Author getAuthorById(int id) {
        Author example = new Author();
        example.setId(id);
        ObjectSet<Author> result = db.queryByExample(example);
        return result.hasNext() ? result.next() : null;
    }
    
    public void deleteAuthor(int id) {
        Author author = getAuthorById(id);
        if (author != null) {
            db.delete(author);
            db.commit();
        }
    }
    
    // Member operations
    public void saveMember(Member member) {
        if (member.getId() == 0) {
            member.setId(generateMemberId());
        }
        db.store(member);
        db.commit();
    }
    
    public List<Member> getAllMembers() {
        ObjectSet<Member> result = db.queryByExample(Member.class);
        return new ArrayList<>(result);
    }
    
    public Member getMemberById(int id) {
        Member example = new Member();
        example.setId(id);
        ObjectSet<Member> result = db.queryByExample(example);
        return result.hasNext() ? result.next() : null;
    }
    
    public Member getMemberByEmail(String email) {
        Member example = new Member();
        example.setEmail(email);
        ObjectSet<Member> result = db.queryByExample(example);
        return result.hasNext() ? result.next() : null;
    }
    
    public void deleteMember(int id) {
        Member member = getMemberById(id);
        if (member != null) {
            db.delete(member);
            db.commit();
        }
    }
    
    // User operations
    public void saveUser(User user) {
        if (user.getId() == 0) {
            user.setId(generateUserId());
        }
        db.store(user);
        db.commit();
    }
    
    public List<User> getAllUsers() {
        ObjectSet<User> result = db.queryByExample(User.class);
        return new ArrayList<>(result);
    }
    
    public User getUserById(int id) {
        User example = new User();
        example.setId(id);
        ObjectSet<User> result = db.queryByExample(example);
        return result.hasNext() ? result.next() : null;
    }
    
    public User getUserByUsername(String username) {
        User example = new User();
        example.setUsername(username);
        ObjectSet<User> result = db.queryByExample(example);
        return result.hasNext() ? result.next() : null;
    }
    
    public void deleteUser(int id) {
        User user = getUserById(id);
        if (user != null) {
            db.delete(user);
            db.commit();
        }
    }
    
    // Loan operations
    public void saveLoan(Loan loan) {
        if (loan.getId() == 0) {
            loan.setId(generateLoanId());
        }
        db.store(loan);
        db.commit();
    }
    
    public List<Loan> getAllLoans() {
        ObjectSet<Loan> result = db.queryByExample(Loan.class);
        return new ArrayList<>(result);
    }
    
    public Loan getLoanById(int id) {
        Loan example = new Loan();
        example.setId(id);
        ObjectSet<Loan> result = db.queryByExample(example);
        return result.hasNext() ? result.next() : null;
    }
    
    public List<Loan> getLoansByMember(Member member) {
        List<Loan> allLoans = getAllLoans();
        List<Loan> memberLoans = new ArrayList<>();
        for (Loan loan : allLoans) {
            if (loan.getMember() != null && loan.getMember().getId() == member.getId()) {
                memberLoans.add(loan);
            }
        }
        return memberLoans;
    }
    
    public List<Loan> getLoansInMonth(Date month) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(month);
        cal.set(Calendar.DAY_OF_MONTH, 1);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        Date startOfMonth = cal.getTime();
        
        cal.add(Calendar.MONTH, 1);
        Date startOfNextMonth = cal.getTime();
        
        List<Loan> allLoans = getAllLoans();
        List<Loan> monthLoans = new ArrayList<>();
        for (Loan loan : allLoans) {
            if (loan.getLoanDate().after(startOfMonth) && loan.getLoanDate().before(startOfNextMonth)) {
                monthLoans.add(loan);
            }
        }
        return monthLoans;
    }
    
    public void deleteLoan(int id) {
        Loan loan = getLoanById(id);
        if (loan != null) {
            db.delete(loan);
            db.commit();
        }
    }
    
    // ID generation methods
    private int generateBookId() {
        List<Book> books = getAllBooks();
        int maxId = 0;
        for (Book book : books) {
            if (book.getId() > maxId) {
                maxId = book.getId();
            }
        }
        return maxId + 1;
    }
    
    private int generateAuthorId() {
        List<Author> authors = getAllAuthors();
        int maxId = 0;
        for (Author author : authors) {
            if (author.getId() > maxId) {
                maxId = author.getId();
            }
        }
        return maxId + 1;
    }
    
    private int generateMemberId() {
        List<Member> members = getAllMembers();
        int maxId = 0;
        for (Member member : members) {
            if (member.getId() > maxId) {
                maxId = member.getId();
            }
        }
        return maxId + 1;
    }
    
    private int generateUserId() {
        List<User> users = getAllUsers();
        int maxId = 0;
        for (User user : users) {
            if (user.getId() > maxId) {
                maxId = user.getId();
            }
        }
        return maxId + 1;
    }
    
    private int generateLoanId() {
        List<Loan> loans = getAllLoans();
        int maxId = 0;
        for (Loan loan : loans) {
            if (loan.getId() > maxId) {
                maxId = loan.getId();
            }
        }
        return maxId + 1;
    }
    
    public void close() {
        if (db != null) {
            db.close();
        }
    }
}