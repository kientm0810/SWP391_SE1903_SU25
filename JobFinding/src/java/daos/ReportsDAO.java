/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package daos;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import context.DBContext;
import models.FinancialTransaction;
import models.RevenueData;
import models.RevenueStats;

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
    
    // Lấy doanh thu của recruiter theo tháng
    public List<RevenueData> getRecruiterRevenueByMonth(int recruiterId) {
        List<RevenueData> revenueList = new ArrayList<>();
        String query = "SELECT " +
                       "YEAR(transaction_date) as year, " +
                       "MONTH(transaction_date) as month, " +
                       "SUM(amount) as total_revenue " +
                       "FROM Financial_Transactions " +
                       "WHERE status = 'completed' " +
                       "AND recruiter_id = ? " +
                       "AND transaction_date >= DATEADD(MONTH, -12, GETDATE()) " +
                       "GROUP BY YEAR(transaction_date), MONTH(transaction_date) " +
                       "ORDER BY YEAR(transaction_date), MONTH(transaction_date)";
        
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, recruiterId);
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
    
    // Lấy doanh thu promotion của recruiter theo tháng
    public List<RevenueData> getRecruiterPromotionRevenueByMonth(int recruiterId) {
        List<RevenueData> revenueList = new ArrayList<>();
        String query = "SELECT " +
                       "YEAR(ft.transaction_date) as year, " +
                       "MONTH(ft.transaction_date) as month, " +
                       "SUM(ft.amount) as total_revenue " +
                       "FROM Featured_Jobs fj " +
                       "INNER JOIN Financial_Transactions ft ON fj.transaction_id = ft.id " +
                       "WHERE ft.status = 'completed' " +
                       "AND ft.recruiter_id = ? " +
                       "AND ft.transaction_date >= DATEADD(MONTH, -12, GETDATE()) " +
                       "GROUP BY YEAR(ft.transaction_date), MONTH(ft.transaction_date) " +
                       "ORDER BY YEAR(ft.transaction_date), MONTH(ft.transaction_date)";
        
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, recruiterId);
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
    
    // Lấy thống kê tổng quan của recruiter
    public RevenueStats getRecruiterStats(int recruiterId) {
        RevenueStats stats = new RevenueStats();
        
        // Tổng doanh thu tháng này của recruiter
        String monthlyQuery = "SELECT SUM(amount) as monthly_revenue " +
                              "FROM Financial_Transactions " +
                              "WHERE status = 'completed' " +
                              "AND recruiter_id = ? " +
                              "AND YEAR(transaction_date) = YEAR(GETDATE()) " +
                              "AND MONTH(transaction_date) = MONTH(GETDATE())";
        
        // Tổng doanh thu tất cả của recruiter
        String totalQuery = "SELECT SUM(amount) as total_revenue " +
                            "FROM Financial_Transactions " +
                            "WHERE status = 'completed' " +
                            "AND recruiter_id = ?";
        
        // Số giao dịch tháng này của recruiter
        String transactionQuery = "SELECT COUNT(*) as transaction_count " +
                                  "FROM Financial_Transactions " +
                                  "WHERE status = 'completed' " +
                                  "AND recruiter_id = ? " +
                                  "AND YEAR(transaction_date) = YEAR(GETDATE()) " +
                                  "AND MONTH(transaction_date) = MONTH(GETDATE())";
        
        try {
            // Monthly revenue
            PreparedStatement ps = connection.prepareStatement(monthlyQuery);
            ps.setInt(1, recruiterId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                stats.setMonthlyRevenue(rs.getDouble("monthly_revenue"));
            }
            
            // Total revenue
            ps = connection.prepareStatement(totalQuery);
            ps.setInt(1, recruiterId);
            rs = ps.executeQuery();
            if (rs.next()) {
                stats.setTotalRevenue(rs.getDouble("total_revenue"));
            }
            
            // Transaction count
            ps = connection.prepareStatement(transactionQuery);
            ps.setInt(1, recruiterId);
            rs = ps.executeQuery();
            if (rs.next()) {
                stats.setTransactionCount(rs.getInt("transaction_count"));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return stats;
    }
    
    // Lấy danh sách giao dịch gần đây của recruiter
    public List<FinancialTransaction> getRecentTransactions(int recruiterId, int limit) {
        List<FinancialTransaction> transactions = new ArrayList<>();
        String query = "SELECT * FROM Financial_Transactions " +
                       "WHERE recruiter_id = ? " +
                       "ORDER BY transaction_date DESC " +
                       "LIMIT ?";
        
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, recruiterId);
            ps.setInt(2, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                FinancialTransaction transaction = new FinancialTransaction();
                transaction.setId(rs.getInt("id"));
                transaction.setRecruiterId(rs.getInt("recruiter_id"));
                transaction.setType(rs.getString("type"));
                transaction.setTransactionType(rs.getString("transaction_type"));
                transaction.setAmount(rs.getDouble("amount"));
                transaction.setDescription(rs.getString("description"));
                transaction.setStatus(rs.getString("status"));
                transaction.setTransactionDate(rs.getTimestamp("transaction_date"));
                transaction.setTransactionCode(rs.getString("transaction_code"));
                transactions.add(transaction);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return transactions;
    }
}