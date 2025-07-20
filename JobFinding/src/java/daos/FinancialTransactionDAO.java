package daos;

import context.DBContext;
import models.FinancialTransaction;
//import utils.DatabaseConnection;
import java.sql.*;

public class FinancialTransactionDAO extends DBContext{
    
    public int createTransaction(FinancialTransaction transaction) {
        String sql = "INSERT INTO Financial_Transactions (recruiter_id, type, transaction_type, amount, description, status) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            stmt.setInt(1, transaction.getRecruiterId());
            stmt.setString(2, transaction.getType());
            stmt.setString(3, transaction.getTransactionType());
            stmt.setDouble(4, transaction.getAmount());
            stmt.setString(5, transaction.getDescription());
            stmt.setString(6, transaction.getStatus());
            
            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public FinancialTransaction getTransactionById(int id) {
        String sql = "SELECT * FROM Financial_Transactions WHERE id = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToTransaction(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public void updateTransaction(FinancialTransaction transaction) {
        String sql = "UPDATE Financial_Transactions SET transaction_code = ?, status = ? WHERE id = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, transaction.getTransactionCode());
            stmt.setString(2, transaction.getStatus());
            stmt.setInt(3, transaction.getId());
            
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    private FinancialTransaction mapResultSetToTransaction(ResultSet rs) throws SQLException {
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
        return transaction;
    }
}