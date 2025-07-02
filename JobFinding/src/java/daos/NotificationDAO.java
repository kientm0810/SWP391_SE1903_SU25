/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package daos;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import models.Recruiter;
import models.Notification;
import java.sql.Date;

/**
 *
 * @author andin
 */
public class NotificationDAO extends DBContext {

    public Vector<Notification> getNotice(int id, int topk, String role) {
        if (role.equals("job-seeker")){
            role = "job_seeker";
        }
        String sql = "SELECT " + (topk == -1 ? "" : "TOP (" + topk + ") ") + "*"
                + "  FROM [project_SWP391].[dbo].[Notifications]\n"
                + "  WHERE [user_id] = ? and [user_type] = ?"
                + " ORDER BY created_at DESC";

        Vector<Notification> list = new Vector<>();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, id);
            ptm.setString(2, role);
            ResultSet res = ptm.executeQuery();
            while (res.next()) {
                Notification p = mapResultSetToNotification(res);

                list.add(p);
            }
        } catch (SQLException ex) {
            //System.out.println(ex);
            ex.getStackTrace();
        }
        return list;
    }

    public Vector<Notification> getUnreadNotice(int id, int topk, String role) {
        if (role.equals("job-seeker")){
            role = "job_seeker";
        }
        String sql = "SELECT " + (topk == -1 ? "" : "TOP (" + topk + ") ") + "*"
                + "  FROM [project_SWP391].[dbo].[Notifications]\n"
                + "  WHERE [user_id] = ? and [is_read] = 0 and [user_type] = ?"
                + " ORDER BY created_at DESC";

        Vector<Notification> list = new Vector<>();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, id);
            ptm.setString(2, role);
            ResultSet res = ptm.executeQuery();
            while (res.next()) {
                Notification p = mapResultSetToNotification(res);

                list.add(p);
            }
        } catch (SQLException ex) {
            //System.out.println(ex);
            ex.getStackTrace();
        }
        return list;
    }

    public int insertNotice(Notification p) {
        String sql = "INSERT INTO [dbo].[Notifications]\n"
                + "           ([user_id]\n"
                + "           ,[user_type]\n"
                + "           ,[title]\n"
                + "           ,[content]\n"
                + "           ,[is_read]\n"
                + "           ,[redirect_url]\n"
                + "           ,[created_at])\n"
                + "     VALUES(?, ?, ?, ?, ?, ?, GETDATE())";

        int n = 0;

        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, p.getUser_id());
            ptm.setString(2, p.getType());
            ptm.setString(3, p.getTitle());
            ptm.setString(4, p.getContent());
            ptm.setBoolean(5, p.isIs_read());
            ptm.setString(6, p.getRedirect_url());
//            ptm.setDate(6, p.getImportDate());
//            ptm.setDate(7, p.getUsingDate());
//            ptm.setInt(8, p.getStatus());
            n = ptm.executeUpdate();
            //System.out.println("vcl " + n);
        } catch (SQLException ex) {
            ex.getStackTrace();
        }

        return n;
    }

    public Notification getSpecificNotification(int id) {
        String sql = "SELECT *"
                + "  FROM [project_SWP391].[dbo].[Notifications]\n"
                + "  WHERE [id] = ?";

        Notification p = new Notification();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, id);
            ResultSet res = ptm.executeQuery();
            while (res.next()) {
                p = mapResultSetToNotification(res);
            }
        } catch (SQLException ex) {
            //System.out.println(ex);
            ex.getStackTrace();
        }
        return p;
    }

    public boolean readSpecificNotification(int id) {
        String sql = "UPDATE [dbo].[Notifications]\n"
                + "   SET [is_read] = 1\n"
                + " WHERE [id] = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public void deleteAll(int id, String role){
        String sql = "DELETE FROM [dbo].[Notifications] WHERE [user_id] = ? and [user_type] = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.setString(2, role);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void deleteAllReaded(int id, String role){
        String sql = "DELETE FROM [dbo].[Notifications] WHERE [is_read] = 1 and [user_id] = ? and [user_type] = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.setString(2, role);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public boolean markAsUnread(int id) {
        String sql = "UPDATE [dbo].[Notifications]\n"
                + "   SET [is_read] = 0\n"
                + " WHERE [id] = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
    
    public void deleteSpecificNotice(int id){
        String sql = "DELETE FROM [dbo].[Notifications] WHERE [id] = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public Notification mapResultSetToNotification(ResultSet res) throws SQLException {
        Notification notification = new Notification();
        notification.setId(res.getInt("id"));
        notification.setType(res.getString("user_type"));
        notification.setRedirect_url(res.getString("redirect_url"));
        notification.setTitle(res.getString("title"));
        notification.setContent(res.getString("content"));
        notification.setIs_read(res.getBoolean("is_read"));
        notification.setCreated_at(res.getDate("created_at"));
        return notification;
    }
    
    
    public static void main(String[] args) {
        NotificationDAO dao = new NotificationDAO();
        Vector<Notification> list = dao.getNotice(5, 5, "recruiter");
        for (Notification notification : list) {
            System.out.println(notification.getId());
        }
    }

}
