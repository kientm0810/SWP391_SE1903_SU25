/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package daos.Admin;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

/**
 *
 * @author andin
 */
public class AdminDAO {
    public AdminDAO() {
    }
    
//    public Vector<Products> getAllProduct(String sql) {
//        Vector<Products> listProducts = new Vector<>();
//        try {
//            PreparedStatement ptm = connection.prepareStatement(sql);
//            ResultSet res = ptm.executeQuery();
//            while (res.next()) {
//                Products p = new Products(res.getInt(1),
//                        res.getString(2),
//                        res.getString(3),
//                        res.getDouble(4),
//                        res.getInt(5),
//                        res.getString(6),
//                        res.getDate(7),
//                        res.getDate(8),
//                        res.getInt(9));
//
//                listProducts.add(p);
//            }
//        } catch (SQLException ex) {
//            //System.out.println(ex);
//            ex.getStackTrace();
//        }
//
//        return listProducts;
//    }
//
//    public int insertProduct(Products p) {
//        String sql = "INSERT INTO [dbo].[tblProducts]\n"
//                + "           ([productName]\n"
//                + "           ,[image]\n"
//                + "           ,[price]\n"
//                + "           ,[quantity]\n"
//                + "           ,[categoryID]\n"
//                + "           ,[importDate]\n"
//                + "           ,[usingDate]\n"
//                + "           ,[status])\n"
//                + "     VALUES(?,?,?,?,?,?,?,?)";
//
//        int n = 0;
//        try {
//            PreparedStatement ptm = connection.prepareStatement(sql);
//            ptm.setString(1, p.getProductName());
//            ptm.setString(2, p.getImage());
//            ptm.setDouble(3, p.getPrice());
//            ptm.setInt(4, p.getQuantity());
//            ptm.setString(5, p.getCategoryID());
//            ptm.setDate(6, p.getImportDate());
//            ptm.setDate(7, p.getUsingDate());
//            ptm.setInt(8, p.getStatus());
//            n = ptm.executeUpdate();
//            System.out.println("vcl " + n);
//        } catch (SQLException ex) {
//            ex.getStackTrace();
//        }
//
//        return n;
//    }
//
//    public void updateProduct(Products p) {
//        String sql = "UPDATE [dbo].[tblProducts]\n"
//                + "   SET [productName] = ?\n"
//                + "      ,[image] = ?\n"
//                + "      ,[price] = ?\n"
//                + "      ,[quantity] = ?\n"
//                + "      ,[categoryID] = ?\n"
//                + "      ,[importDate] = ?\n"
//                + "      ,[usingDate] = ?\n"
//                + "      ,[status] = ?\n"
//                + " WHERE productID=?";
//
//        try {
//            PreparedStatement ptm = connection.prepareStatement(sql);
//            ptm.setString(1, p.getProductName());
//            ptm.setString(2, p.getImage());
//            ptm.setDouble(3, p.getPrice());
//            ptm.setInt(4, p.getQuantity());
//            ptm.setString(5, p.getCategoryID());
//            ptm.setDate(6, p.getImportDate());
//            ptm.setDate(7, p.getUsingDate());
//            ptm.setInt(8, p.getStatus());
//            ptm.setInt(9, p.getProductID());
//            ptm.executeUpdate();
//        } catch (SQLException ex) {
//            ex.getStackTrace();
//        }
//    }
//
//    public void changeStatus(int productID, int status){
//        String sql = "UPDATE [dbo].[tblProducts]\n"
//                + "   SET [status] = ?\n"
//                + " WHERE productID=?";
//
//        try {
//            PreparedStatement ptm = connection.prepareStatement(sql);
//            ptm.setInt(1, status);
//            ptm.setInt(2, productID);
//            ptm.executeUpdate();
//        } catch (SQLException ex) {
//            ex.getStackTrace();
//        }
//    }
//    
//    public int deleteProduct(int productID) {
//        String sql = "DELETE FROM [dbo].[tblProducts]\n"
//                + "      WHERE productID=?";
//
//        int n = 0;
//        
//        try {
//            PreparedStatement ptm = connection.prepareStatement(sql);
//            ptm.setInt(1, productID);
//
//            ResultSet res = getData("SELECT *\n"
//                    + "FROM [dbo].[tblOrderDetails]\n"
//                    + "Where productID =" + productID);
//
//            if (res.next()){
//                changeStatus(productID, 0);
//                return n;
//            }
//            
//            n = ptm.executeUpdate();
//        } catch (SQLException ex) {
//            ex.getStackTrace();
//        }
//        return n;
//    }
//
//    public Products searchProduct(int productID) {
//        String sql = "SELECT *\n"
//                + "FROM [dbo].[tblProducts]\n"
//                + "WHERE productID=?";
//
//        try {
//            PreparedStatement ptm = connection.prepareStatement(sql);
//            ptm.setInt(1, productID);
//
//            ResultSet res = ptm.executeQuery();
//            if (res.next()) {
//                return new Products(res.getInt(1),
//                        res.getString(2),
//                        res.getString(3),
//                        res.getDouble(4),
//                        res.getInt(5),
//                        res.getString(6),
//                        res.getDate(7),
//                        res.getDate(8),
//                        res.getInt(9));
//            }
//        } catch (SQLException ex) {
//            ex.getStackTrace();
//        }
//
//        return null;
//    }
//
//    public static void main(String[] args) {
//        String sql = "SELECT [productID]\n"
//                + "      ,[productName]\n"
//                + "      ,[image]\n"
//                + "      ,[price]\n"
//                + "      ,[quantity]\n"
//                + "      ,[categoryID]\n"
//                + "      ,[importDate]\n"
//                + "      ,[usingDate]\n"
//                + "      ,[status]\n"
//                + "  FROM [dbo].[tblProducts]";
//
//        ProductDAO pDAO = new ProductDAO();
//
//        Vector<Products> p = pDAO.getAllProduct(sql);
//        for (Products products : p) {
//            System.out.println(products);
//        }
//
//        Products pro = new Products("Noi com cao cao",
//                "noicomcao.jpg",
//                999,
//                99,
//                "C004",
//                new Date(2025 - 1900, 0, 15),
//                new Date(2025 - 1900, 0, 15), 1);
//
//        int n = pDAO.insertProduct(pro);
//
//        if (n > 0) {
//            System.out.println("Inserted!");
//            p = pDAO.getAllProduct(sql);
//            for (Products products : p) {
//                System.out.println(products);
//            }
//        } else {
//            System.out.println("Insert fail!");
//        }
//
//        Products pr = pDAO.searchProduct(6);
//        if (pr != null) {
//            pDAO.updateProduct(new Products(6,
//                    "Noi com cao tan",
//                    "noicom.jpg",
//                    9999,
//                    99,
//                    "C004",
//                    new Date(2025 - 1900, 0, 15),
//                    new Date(2025 - 1900, 0, 15), 1));
//        }
//
//        int x = pDAO.deleteProduct(10);
//        if (x > 0) {
//            System.out.println("Deleted!");
//            p = pDAO.getAllProduct(sql);
//            for (Products products : p) {
//                System.out.println(products);
//            }
//        }
//        
//        
//    }
}
