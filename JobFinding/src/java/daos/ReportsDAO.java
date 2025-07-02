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
import models.RevenueData;

/**
 *
 * @author andin
 */
public class ReportsDAO extends DBContext {
    
    // Lấy doanh thu tổng theo tháng (12 tháng gần nhất)
    public List<RevenueData> getTotalRevenueByMonth() {
        List<RevenueData> revenueList = new ArrayList<>();
        String query = "SELECT " +
                       "YEAR(transaction_date) as year, " +
                       "MONTH(transaction_date) as month, " +
                       "SUM(amount) as total_revenue " +
                       "FROM Financial_Transactions " +
                       "WHERE status = 'completed' " +
                       "AND transaction_date >= DATEADD(MONTH, -12, GETDATE()) " +
                       "GROUP BY YEAR(transaction_date), MONTH(transaction_date) " +
                       "ORDER BY YEAR(transaction_date), MONTH(transaction_date)";
        
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int year = rs.getInt("year");
                int month = rs.getInt("month");
                double revenue = rs.getDouble("total_revenue");
                
                String monthLabel = String.format("%02d/%d", month, year);
                revenueList.add(new RevenueData(monthLabel, revenue));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return revenueList;
    }
    
    // Lấy doanh thu từ promotion programs theo tháng
    public List<RevenueData> getPromotionRevenueByMonth() {
        List<RevenueData> revenueList = new ArrayList<>();
        String query = "SELECT " +
                       "YEAR(ft.transaction_date) as year, " +
                       "MONTH(ft.transaction_date) as month, " +
                       "SUM(ft.amount) as total_revenue " +
                       "FROM Featured_Jobs fj " +
                       "INNER JOIN Financial_Transactions ft ON fj.transaction_id = ft.id " +
                       "WHERE ft.status = 'completed' " +
                       "AND ft.transaction_date >= DATEADD(MONTH, -12, GETDATE()) " +
                       "GROUP BY YEAR(ft.transaction_date), MONTH(ft.transaction_date) " +
                       "ORDER BY YEAR(ft.transaction_date), MONTH(ft.transaction_date)";
        
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int year = rs.getInt("year");
                int month = rs.getInt("month");
                double revenue = rs.getDouble("total_revenue");
                
                String monthLabel = String.format("%02d/%d", month, year);
                revenueList.add(new RevenueData(monthLabel, revenue));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return revenueList;
    }
    
    // Lấy thống kê tổng quan
    public RevenueStats getOverallStats() {
        RevenueStats stats = new RevenueStats();
        
        // Tổng doanh thu tháng này
        String monthlyQuery = "SELECT SUM(amount) as monthly_revenue " +
                              "FROM Financial_Transactions " +
                              "WHERE status = 'completed' " +
                              "AND YEAR(transaction_date) = YEAR(GETDATE()) " +
                              "AND MONTH(transaction_date) = MONTH(GETDATE())";
        
        // Tổng doanh thu tất cả
        String totalQuery = "SELECT SUM(amount) as total_revenue " +
                            "FROM Financial_Transactions " +
                            "WHERE status = 'completed'";
        
        // Số giao dịch tháng này
        String transactionQuery = "SELECT COUNT(*) as transaction_count " +
                                  "FROM Financial_Transactions " +
                                  "WHERE status = 'completed' " +
                                  "AND YEAR(transaction_date) = YEAR(GETDATE()) " +
                                  "AND MONTH(transaction_date) = MONTH(GETDATE())";
        
        try {
            // Monthly revenue
            PreparedStatement ps = connection.prepareStatement(monthlyQuery);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                stats.setMonthlyRevenue(rs.getDouble("monthly_revenue"));
            }
            
            // Total revenue
            ps = connection.prepareStatement(totalQuery);
            rs = ps.executeQuery();
            if (rs.next()) {
                stats.setTotalRevenue(rs.getDouble("total_revenue"));
            }
            
            // Transaction count
            ps = connection.prepareStatement(transactionQuery);
            rs = ps.executeQuery();
            if (rs.next()) {
                stats.setTransactionCount(rs.getInt("transaction_count"));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return stats;
    }
    
    // Inner classes for data models
    public static class RevenueData {
        private String month;
        private double revenue;
        
        public RevenueData(String month, double revenue) {
            this.month = month;
            this.revenue = revenue;
        }
        
        public String getMonth() { return month; }
        public double getRevenue() { return revenue; }
    }
    
    public static class RevenueStats {
        private double monthlyRevenue;
        private double totalRevenue;
        private int transactionCount;
        
        public double getMonthlyRevenue() { return monthlyRevenue; }
        public void setMonthlyRevenue(double monthlyRevenue) { this.monthlyRevenue = monthlyRevenue; }
        
        public double getTotalRevenue() { return totalRevenue; }
        public void setTotalRevenue(double totalRevenue) { this.totalRevenue = totalRevenue; }
        
        public int getTransactionCount() { return transactionCount; }
        public void setTransactionCount(int transactionCount) { this.transactionCount = transactionCount; }
    }
}