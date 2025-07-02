/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package daos;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author andin
 */
public class PromotionProgramDAO extends DBContext {

    public int findProgramIDBy(String type) {
        String sql = "SELECT [id] FROM [project_SWP391].[dbo].[Promotion_Programs] WHERE [position_type] = ?";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, type);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()){
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public static void main(String[] args) {
        PromotionProgramDAO dao = new PromotionProgramDAO();
        System.out.println(dao.findProgramIDBy("normal"));
    }
}
