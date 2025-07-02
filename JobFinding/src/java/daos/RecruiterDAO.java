/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package daos;

/**
 *
 * @author thaison
 */
import context.DBContext;
import java.sql.*;
import models.Recruiter;
import context.DBContext;
import java.util.Vector;

public class RecruiterDAO extends DBContext {

    private String getAll = "SELECT *"
            + "  FROM [project_SWP391].[dbo].[Recruiter]";

    public Vector<Recruiter> getAllRecruiter() {
        String sql = getAll;
        Vector<Recruiter> listRecruiters = new Vector<>();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet res = ptm.executeQuery();
            while (res.next()) {
                Recruiter p = new Recruiter(res.getInt(1),
                        res.getString(2),
                        res.getString(3),
                        res.getString(4),
                        res.getString(5),
                        res.getString(6),
                        res.getDate(7),
                        res.getString(8),
                        res.getString(9),
                        res.getString(10),
                        res.getString(11),
                        res.getString(12),
                        res.getString(13),
                        res.getString(14),
                        res.getString(15),
                        res.getString(16),
                        res.getString(17),
                        res.getString(18),
                        res.getDouble(19),
                        res.getString(20),
                        res.getDate(21),
                        res.getDate(22),
                        res.getBoolean(23));

                listRecruiters.add(p);
            }
        } catch (SQLException ex) {
            //System.out.println(ex);
            ex.getStackTrace();
        }

        /*
            private int id;
            private String username;
            private String password;
            private String email;
            private String fullName;
            private String phone;
            private Date dateOfBirth;
            private String gender;
            private String address;
            private String profilePicture;
            private String companyName;
            private String companyDescription;
            private String logo;
            private String website;
            private String companyAddress;
            private String companySize;
            private String industry;
            private String taxCode;
            private double loyaltyScore;
            private String verificationStatus;
            private Date createdAt;
            private Date updatedAt;
            private boolean isActive;
         */
        return listRecruiters;
    }
    
    public Vector<Recruiter> getRecruiterByName(String name) {
        String sql = "SELECT *"
                + "  FROM [project_SWP391].[dbo].[Recruiter]"
                + "WHERE [full_name] like N'%" + name + "%'";
        
        Vector<Recruiter> listRecruiters = new Vector<>();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet res = ptm.executeQuery();
            while (res.next()) {
//                Recruiter p = new Recruiter(res.getInt(1),
//                        res.getString(2),
//                        res.getString(3),
//                        res.getString(4),
//                        res.getString(5),
//                        res.getString(6),
//                        res.getDate(7),
//                        res.getString(8),
//                        res.getString(9),
//                        res.getString(10),
//                        res.getString(11),
//                        res.getString(12),
//                        res.getString(13),
//                        res.getString(14),
//                        res.getString(15),
//                        res.getString(16),
//                        res.getString(17),
//                        res.getString(18),
//                        res.getDouble(19),
//                        res.getString(20),
//                        res.getDate(21),
//                        res.getDate(22),
//                        res.getBoolean(23));
                Recruiter p = mapResultSetToRecruiter(res);
                listRecruiters.add(p);
            }
        } catch (SQLException ex) {
            //System.out.println(ex);
            ex.getStackTrace();
        }

        /*
            private int id;
            private String username;
            private String password;
            private String email;
            private String fullName;
            private String phone;
            private Date dateOfBirth;
            private String gender;
            private String address;
            private String profilePicture;
            private String companyName;
            private String companyDescription;
            private String logo;
            private String website;
            private String companyAddress;
            private String companySize;
            private String industry;
            private String taxCode;
            private double loyaltyScore;
            private String verificationStatus;
            private Date createdAt;
            private Date updatedAt;
            private boolean isActive;
         */
        return listRecruiters;
    }

    public boolean isUsernameTaken(String username) {
        String sql = "SELECT username FROM Recruiter WHERE username = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean register(Recruiter recruiter) {
        String sql = "INSERT INTO Recruiter "
                + "(username, password, email, full_name, phone, date_of_birth, gender, address, company_name, company_description, logo, website, company_address, company_size, industry) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, recruiter.getUsername());
            ps.setString(2, recruiter.getPassword());
            ps.setString(3, recruiter.getEmail());
            ps.setString(4, recruiter.getFullName());
            ps.setString(5, recruiter.getPhone());
            ps.setDate(6, new java.sql.Date(recruiter.getDateOfBirth().getTime()));
            ps.setString(7, recruiter.getGender());
            ps.setString(8, recruiter.getAddress());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Recruiter getRecruiterByUsernameAndPassword(String username, String password) {
        String sql = "SELECT * FROM Recruiter WHERE username = ? AND password = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Recruiter r = new Recruiter();
                r.setId(rs.getInt("id"));
                r.setUsername(rs.getString("username"));
                r.setPassword(rs.getString("password"));
                r.setEmail(rs.getString("email"));
                r.setFullName(rs.getString("full_name"));
                // Gán thêm các trường khác nếu cần
                return r;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updatePassword(int recruiterId, String newPassword) {
        String sql = "UPDATE Recruiter SET password = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setInt(2, recruiterId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void changeStatus(int ID, boolean status) {
        String sql = "UPDATE [dbo].[Recruiter]\n"
                + "   SET [is_active] = ?\n"
                + " WHERE id = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setBoolean(1, status == true ? false : true);
            ptm.setInt(2, ID);
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
    }
    
    public Recruiter getSpeccificRecruiter(int id){
        String sql = "SELECT *\n"
            + "  FROM [project_SWP391].[dbo].[Recruiter]"
            + " WHERE id = ?";
        
        Recruiter p = new Recruiter();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, id);
            ResultSet res = ptm.executeQuery();
            while (res.next()) {
//                p = new Recruiter(res.getInt(1),
//                        res.getString(2),
//                        res.getString(3),
//                        res.getString(4),
//                        res.getString(5),
//                        res.getString(6),
//                        res.getDate(7),
//                        res.getString(8),
//                        res.getString(9),
//                        res.getString(10),
//                        res.getString(11),
//                        res.getString(12),
//                        res.getString(13),
//                        res.getString(14),
//                        res.getString(15),
//                        res.getString(16),
//                        res.getString(17),
//                        res.getString(18),
//                        res.getDouble(19),
//                        res.getString(20),
//                        res.getDate(21),
//                        res.getDate(22),
//                        res.getBoolean(23));
                p = mapResultSetToRecruiter(res);
            }
        } catch (SQLException ex) {
            //System.out.println(ex);
            ex.getStackTrace();
        }
        
        return p;
    }
    
    public Recruiter mapResultSetToRecruiter(ResultSet res) throws SQLException {
        return new Recruiter(
            res.getInt(1),
            res.getString(2),
            res.getString(3),
            res.getString(4),
            res.getString(5),
            res.getString(6),
            res.getDate(7),
            res.getString(8),
            res.getString(9),
            res.getString(10),
            res.getString(11),
            res.getString(12),
            res.getString(13),
            res.getString(14),
            res.getString(15),
            res.getString(16),
            res.getString(17),
            res.getString(18),
            res.getDouble(19),
            res.getString(20),
            res.getDate(21),
            res.getDate(22),
            res.getBoolean(23)
        );
    }
    
    public Vector<Recruiter> searchRecruiters(Recruiter criteria){
        StringBuilder sql = new StringBuilder("SELECT * FROM [project_SWP391].[dbo].[Recruiter] WHERE 1=1");
        Vector<Object> params = new Vector<>();

        if (criteria.getId() != 0) {  // Giả sử id=0 nghĩa không lọc
            sql.append(" AND id = ?");
            params.add(criteria.getId());
        }
        if (criteria.getUsername() != null && !criteria.getUsername().isEmpty()) {
            sql.append(" AND username LIKE ?");
            params.add("%" + criteria.getUsername() + "%");
        }
        if (criteria.getEmail() != null && !criteria.getEmail().isEmpty()) {
            sql.append(" AND email LIKE ?");
            params.add("%" + criteria.getEmail() + "%");
        }
        if (criteria.getPhone() != null && !criteria.getPhone().isEmpty()) {
            sql.append(" AND phone LIKE ?");
            params.add("%" + criteria.getPhone() + "%");
        }
        if (criteria.getCompanyName() != null && !criteria.getCompanyName().isEmpty()) {
            sql.append(" AND company_name LIKE ?");
            params.add("%" + criteria.getCompanyName() + "%");
        }
        if (criteria.getCompanyAddress() != null && !criteria.getCompanyAddress().isEmpty()) {
            sql.append(" AND company_address LIKE ?");
            params.add("%" + criteria.getCompanyAddress() + "%");
        }
        if (criteria.getCompanySize() != null && !criteria.getCompanySize().isEmpty()) {
            sql.append(" AND company_size = ?");
            params.add(criteria.getCompanySize());
        }
        if (criteria.getIndustry() != null && !criteria.getIndustry().isEmpty()) {
            sql.append(" AND industry = ?");
            params.add(criteria.getIndustry());
        }
        if (criteria.getLoyaltyScore() > 0) { // Lọc từ giá trị > 0 trở lên
            sql.append(" AND loyalty_score >= ?");
            params.add(criteria.getLoyaltyScore());
        }
        if (criteria.getVerificationStatus() != null && !criteria.getVerificationStatus().isEmpty()) {
            sql.append(" AND verification_status = ?");
            params.add(criteria.getVerificationStatus());
        }
        // Lọc isActive, mặc định false nếu chưa set thì không lọc
        if (criteria.isActive() || !criteria.isActive()) { 
            sql.append(" AND is_active = ?");
            params.add(criteria.isActive());
        }

        Vector<Recruiter> result = new Vector<>();
        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                result.add(mapResultSetToRecruiter(rs));  // Hàm extractRecruiter lấy data từ rs vào object
            }
        } catch (SQLException ex) {
            //System.out.println(ex);
            ex.getStackTrace();
        }
        return result;
    }   
    
    public void updateVerificationStatus(int id, String status){
        String sql = "UPDATE [project_SWP391].[dbo].[Recruiter] SET verification_status = ? WHERE id = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, status);
            ps.setInt(2, id);

            ps.executeUpdate();
        } catch (SQLException e) {
            e.getStackTrace();
        }
    }
    
    // Thêm vào RecruiterDAO.java sau các phương thức hiện có

    public int getTotalRecruiters() {
        String sql = "SELECT COUNT(*) FROM [project_SWP391].[dbo].[Recruiter]";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public int getTotalSearchResults(Recruiter criteria) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM [project_SWP391].[dbo].[Recruiter] WHERE 1=1");
        Vector<Object> params = new Vector<>();

        if (criteria.getId() != 0) {
            sql.append(" AND id = ?");
            params.add(criteria.getId());
        }
        if (criteria.getUsername() != null && !criteria.getUsername().isEmpty()) {
            sql.append(" AND username LIKE ?");
            params.add("%" + criteria.getUsername() + "%");
        }
        if (criteria.getEmail() != null && !criteria.getEmail().isEmpty()) {
            sql.append(" AND email LIKE ?");
            params.add("%" + criteria.getEmail() + "%");
        }
        if (criteria.getPhone() != null && !criteria.getPhone().isEmpty()) {
            sql.append(" AND phone LIKE ?");
            params.add("%" + criteria.getPhone() + "%");
        }
        if (criteria.getCompanyName() != null && !criteria.getCompanyName().isEmpty()) {
            sql.append(" AND company_name LIKE ?");
            params.add("%" + criteria.getCompanyName() + "%");
        }
        if (criteria.getCompanyAddress() != null && !criteria.getCompanyAddress().isEmpty()) {
            sql.append(" AND company_address LIKE ?");
            params.add("%" + criteria.getCompanyAddress() + "%");
        }
        if (criteria.getCompanySize() != null && !criteria.getCompanySize().isEmpty()) {
            sql.append(" AND company_size = ?");
            params.add(criteria.getCompanySize());
        }
        if (criteria.getIndustry() != null && !criteria.getIndustry().isEmpty()) {
            sql.append(" AND industry = ?");
            params.add(criteria.getIndustry());
        }
        if (criteria.getLoyaltyScore() > 0) {
            sql.append(" AND loyalty_score >= ?");
            params.add(criteria.getLoyaltyScore());
        }
        if (criteria.getVerificationStatus() != null && !criteria.getVerificationStatus().isEmpty()) {
            sql.append(" AND verification_status = ?");
            params.add(criteria.getVerificationStatus());
        }
        sql.append(" AND is_active = ?");
        params.add(criteria.isActive());

        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public Vector<Recruiter> getAllRecruiterWithPagingAndSorting(int page, int recordsPerPage, String sortField, String sortOrder) {
        int start = (page - 1) * recordsPerPage;
        String sql = "SELECT * FROM [project_SWP391].[dbo].[Recruiter] ORDER BY " + sortField + " " + sortOrder + 
                     " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        Vector<Recruiter> listRecruiters = new Vector<>();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, start);
            ptm.setInt(2, recordsPerPage);
            ResultSet res = ptm.executeQuery();
            while (res.next()) {
                Recruiter p = mapResultSetToRecruiter(res);
                listRecruiters.add(p);
            }
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
        return listRecruiters;
    }
    
    public Vector<Recruiter> searchRecruitersWithPagingAndSorting(Recruiter criteria, int page, int recordsPerPage, String sortField, String sortOrder) {
        int start = (page - 1) * recordsPerPage;
        StringBuilder sql = new StringBuilder("SELECT * FROM [project_SWP391].[dbo].[Recruiter] WHERE 1=1");
        Vector<Object> params = new Vector<>();

        if (criteria.getId() != 0) {
            sql.append(" AND id = ?");
            params.add(criteria.getId());
        }
        if (criteria.getUsername() != null && !criteria.getUsername().isEmpty()) {
            sql.append(" AND username LIKE ?");
            params.add("%" + criteria.getUsername() + "%");
        }
        if (criteria.getEmail() != null && !criteria.getEmail().isEmpty()) {
            sql.append(" AND email LIKE ?");
            params.add("%" + criteria.getEmail() + "%");
        }
        if (criteria.getPhone() != null && !criteria.getPhone().isEmpty()) {
            sql.append(" AND phone LIKE ?");
            params.add("%" + criteria.getPhone() + "%");
        }
        if (criteria.getCompanyName() != null && !criteria.getCompanyName().isEmpty()) {
            sql.append(" AND company_name LIKE ?");
            params.add("%" + criteria.getCompanyName() + "%");
        }
        if (criteria.getCompanyAddress() != null && !criteria.getCompanyAddress().isEmpty()) {
            sql.append(" AND company_address LIKE ?");
            params.add("%" + criteria.getCompanyAddress() + "%");
        }
        if (criteria.getCompanySize() != null && !criteria.getCompanySize().isEmpty()) {
            sql.append(" AND company_size = ?");
            params.add(criteria.getCompanySize());
        }
        if (criteria.getIndustry() != null && !criteria.getIndustry().isEmpty()) {
            sql.append(" AND industry = ?");
            params.add(criteria.getIndustry());
        }
        if (criteria.getLoyaltyScore() > 0) {
            sql.append(" AND loyalty_score >= ?");
            params.add(criteria.getLoyaltyScore());
        }
        if (criteria.getVerificationStatus() != null && !criteria.getVerificationStatus().isEmpty()) {
            sql.append(" AND verification_status = ?");
            params.add(criteria.getVerificationStatus());
        }
        sql.append(" AND is_active = ?");
        params.add(criteria.isActive());
        
        sql.append(" ORDER BY ").append(sortField).append(" ").append(sortOrder);
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        Vector<Recruiter> result = new Vector<>();
        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ps.setInt(params.size() + 1, start);
            ps.setInt(params.size() + 2, recordsPerPage);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                result.add(mapResultSetToRecruiter(rs));
            }
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
        return result;
    }

    // Thêm vào RecruiterDAO.java
    public String getVerificationStatus(int recruiterId) {
        String sql = "SELECT verification_status FROM [project_SWP391].[dbo].[Recruiter] WHERE id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, recruiterId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("verification_status");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "pending";
    }

    public String getRecruiterEmail(int recruiterId) {
        String sql = "SELECT email FROM [project_SWP391].[dbo].[Recruiter] WHERE id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, recruiterId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("email");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public Recruiter getSpeccificRecruiterByEmail(String email){
        String sql = "SELECT *\n"
            + "  FROM [project_SWP391].[dbo].[Recruiter]"
            + " WHERE email = ?";
        
        Recruiter p = new Recruiter();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, email);
            ResultSet res = ptm.executeQuery();
            while (res.next()) {
//                p = new Recruiter(res.getInt(1),
//                        res.getString(2),
//                        res.getString(3),
//                        res.getString(4),
//                        res.getString(5),
//                        res.getString(6),
//                        res.getDate(7),
//                        res.getString(8),
//                        res.getString(9),
//                        res.getString(10),
//                        res.getString(11),
//                        res.getString(12),
//                        res.getString(13),
//                        res.getString(14),
//                        res.getString(15),
//                        res.getString(16),
//                        res.getString(17),
//                        res.getString(18),
//                        res.getDouble(19),
//                        res.getString(20),
//                        res.getDate(21),
//                        res.getDate(22),
//                        res.getBoolean(23));
                p = mapResultSetToRecruiter(res);
            }
        } catch (SQLException ex) {
            //System.out.println(ex);
            ex.getStackTrace();
        }
        
        return p;
    }
    
    public int countActiveRecruiters() {
        String sql = "SELECT COUNT(*) FROM [project_SWP391].[dbo].[Recruiter] WHERE [is_active] = 1";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

}
