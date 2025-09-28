package servlet;

import service.DatabaseService;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class DatabaseInitializer implements ServletContextListener {
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Initialize database on startup
        DatabaseService.getInstance();
        System.out.println("Database initialized successfully");
    }
    
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Close database on shutdown
        DatabaseService.getInstance().close();
        System.out.println("Database closed successfully");
    }
}