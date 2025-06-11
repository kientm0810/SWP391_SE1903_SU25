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
import models.RecruiterNotification;
import java.sql.Date;

/**
 *
 * @author andin
 */
public class RecruiterNotificationDAO extends DBContext {

    public Vector<RecruiterNotification> getNotice(int id, int topk) {
        String sql = "SELECT " + (topk == -1 ? "" : "TOP (" + topk + ") ") + "*"
                + "  FROM [project_SWP391].[dbo].[RecruiterNotification]\n"
                + "  WHERE [recruiter_id] = ?"
                + " ORDER BY created_at DESC";

        Vector<RecruiterNotification> list = new Vector<>();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, id);
            ResultSet res = ptm.executeQuery();
            while (res.next()) {
                RecruiterNotification p = mapResultSetToNotification(res);

                list.add(p);
            }
        } catch (SQLException ex) {
            //System.out.println(ex);
            ex.getStackTrace();
        }
        return list;
    }

    public Vector<RecruiterNotification> getUnreadNotice(int id, int topk) {
        String sql = "SELECT " + (topk == -1 ? "" : "TOP (" + topk + ") ") + "*"
                + "  FROM [project_SWP391].[dbo].[RecruiterNotification]\n"
                + "  WHERE [recruiter_id] = ? and [is_read] = 0"
                + " ORDER BY created_at DESC";

        Vector<RecruiterNotification> list = new Vector<>();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, id);
            ResultSet res = ptm.executeQuery();
            while (res.next()) {
                RecruiterNotification p = mapResultSetToNotification(res);

                list.add(p);
            }
        } catch (SQLException ex) {
            //System.out.println(ex);
            ex.getStackTrace();
        }
        return list;
    }

    public int insertNotice(RecruiterNotification p) {
        String sql = "INSERT INTO [dbo].[RecruiterNotification]\n"
                + "           ([recruiter_id]\n"
                + "           ,[type]\n"
                + "           ,[title]\n"
                + "           ,[content]\n"
                + "           ,[is_read]\n"
                + "           ,[created_at])\n"
                + "     VALUES(?, ?, ?, ?, ?, GETDATE())";

        int n = 0;

        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, p.getRecruiter_id());
            ptm.setString(2, p.getType());
            ptm.setString(3, p.getTitle());
            ptm.setString(4, p.getContent());
            ptm.setBoolean(5, p.isIs_read());
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

    public RecruiterNotification getSpecificNotification(int id) {
        String sql = "SELECT *"
                + "  FROM [project_SWP391].[dbo].[RecruiterNotification]\n"
                + "  WHERE [id] = ?";

        RecruiterNotification p = new RecruiterNotification();
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
        String sql = "UPDATE [dbo].[RecruiterNotification]\n"
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

    public void deleteAll(int id){
        String sql = "DELETE FROM [dbo].[RecruiterNotification] WHERE [recruiter_id] = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void deleteAllReaded(int id){
        String sql = "DELETE FROM [dbo].[RecruiterNotification] WHERE [is_read] = 1 and [recruiter_id] = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public boolean markAsUnread(int id) {
        String sql = "UPDATE [dbo].[RecruiterNotification]\n"
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
        String sql = "DELETE FROM [dbo].[RecruiterNotification] WHERE [id] = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public RecruiterNotification mapResultSetToNotification(ResultSet res) throws SQLException {
        RecruiterNotification notification = new RecruiterNotification();
        notification.setId(res.getInt("id"));
        notification.setRecruiter_id(res.getInt("recruiter_id"));
        notification.setType(res.getString("type"));
        notification.setTitle(res.getString("title"));
        notification.setContent(res.getString("content"));
        notification.setIs_read(res.getBoolean("is_read"));
        notification.setCreated_at(res.getDate("created_at"));
        return notification;
    }

}
