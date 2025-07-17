package listeners;

import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import utils.EmailScheduler;

/**
 * Application startup listener để khởi động EmailScheduler
 * Được gọi khi ứng dụng web start và shutdown
 */
@WebListener
public class ApplicationStartupListener implements ServletContextListener {
    
    private static final Logger LOGGER = Logger.getLogger(ApplicationStartupListener.class.getName());
    private EmailScheduler emailScheduler;
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            LOGGER.info("Application starting up...");
            
            // Khởi động EmailScheduler
            emailScheduler = new EmailScheduler();
            emailScheduler.start();
            
            // Lưu scheduler vào ServletContext để có thể truy cập từ các servlet khác
            sce.getServletContext().setAttribute("emailScheduler", emailScheduler);
            
            LOGGER.info("Application startup completed successfully");
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error during application startup", e);
        }
    }
    
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        try {
            LOGGER.info("Application shutting down...");
            
            // Dừng EmailScheduler
            if (emailScheduler != null) {
                emailScheduler.stop();
                LOGGER.info("EmailScheduler stopped successfully");
            }
            
            LOGGER.info("Application shutdown completed");
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error during application shutdown", e);
        }
    }
} 