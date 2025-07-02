/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package daos;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.Posts;

/**
 *
 * @author andin
 */
public class HomeDAO extends DBContext {

    public List<Integer> getAllPostsID() {
        List<Integer> posts = new ArrayList<>();
        String query = "SELECT [post_id]\n"
                + "  FROM [project_SWP391].[dbo].[Featured_Jobs]"
                + "  WHERE [promotion_id] = 4";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                posts.add(rs.getInt(1));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }
    
    public List<Integer> getAllPostsIDbaseOnID(int id) {
        List<Integer> posts = new ArrayList<>();
        String query = "SELECT [post_id]\n"
                + "  FROM [project_SWP391].[dbo].[Featured_Jobs]"
                + "  WHERE [promotion_id] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                posts.add(rs.getInt(1));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }
    
    public static void main(String[] args) {
        HomeDAO dao = new HomeDAO();
        System.out.println(dao.getAllPostsID().size());
    }
}
