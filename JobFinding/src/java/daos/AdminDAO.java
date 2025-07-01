/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package daos;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import models.Admin;
import models.JobSeeker;
import java.util.Vector;

/**
 *
 * @author SHD
 */
public class AdminDAO extends DBContext {

    public Admin getAdminByUsernameAndPassword(String username, String password) {
        String sql = "SELECT * FROM [project_SWP391].[dbo].[Admin] WHERE username = ? AND password = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Admin admin = new Admin();
                admin.setId(rs.getInt("id"));
                admin.setUsername(rs.getString("username"));
                admin.setPassword(rs.getString("password"));
                admin.setEmail(rs.getString("email"));
                admin.setFullName(rs.getString("full_name"));
                // Bạn có thể gán thêm các trường khác nếu cần
                return admin;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        AdminDAO dao = new AdminDAO();
        Vector<Admin> managers = dao.getAdmins("Manager");

        if (managers.isEmpty()) {
            System.out.println("No managers found.");
        } else {
            for (Admin admin : managers) {
                System.out.println("ID: " + admin.getId());
                System.out.println("Username: " + admin.getUsername());
                System.out.println("Full Name: " + admin.getFullName());
                System.out.println("Email: " + admin.getEmail());
                System.out.println("Role: " + admin.getRole());
                System.out.println("Active: " + admin.isActive());
                System.out.println("---------------------------");
            }
        }
    }

    public String debug(String role) {
        Vector<Admin> admins = new Vector<>();
        String sql = "SELECT * FROM [project_SWP391].[dbo].[Admin] WHERE [role] = '?'";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, role);
            return stmt.toString();
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
        return "sai";
    }

    public Vector<Admin> getAdmins(String role) {
        Vector<Admin> admins = new Vector<>();
        String sql = "SELECT * FROM [project_SWP391].[dbo].[Admin] WHERE [role] = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, role);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Admin admin = mapResultSetToAdmin(rs);
                admins.add(admin);
            }
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
        return admins;
    }

    public static Admin mapResultSetToAdmin(ResultSet res) throws SQLException {
        Admin admin = new Admin();
        admin.setId(res.getInt("id"));
        admin.setUsername(res.getString("username"));
        admin.setPassword(res.getString("password"));
        admin.setEmail(res.getString("email"));
        admin.setFullName(res.getString("full_name"));
        admin.setPhone(res.getString("phone"));
        admin.setDateOfBirth(res.getDate("date_of_birth"));
        admin.setGender(res.getString("gender"));
        admin.setAddress(res.getString("address"));
        admin.setProfilePicture(res.getString("profile_picture"));
        admin.setCreatedAt(res.getDate("created_at"));
        admin.setUpdatedAt(res.getDate("updated_at"));
        admin.setIsActive(res.getBoolean("is_active"));
        admin.setRole(res.getString("role"));
        return admin;
    }

    public Vector<Admin> searchAdmin(Admin criteria, String role) {
        Vector<Admin> list = new Vector<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM [project_SWP391].[dbo].[Admin] WHERE [role] = '" + role + "'");
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
        if (criteria.getFullName() != null && !criteria.getFullName().isEmpty()) {
            sql.append(" AND full_name LIKE ?");
            params.add("%" + criteria.getFullName() + "%");
        }
        if (criteria.getPhone() != null && !criteria.getPhone().isEmpty()) {
            sql.append(" AND phone LIKE ?");
            params.add("%" + criteria.getPhone() + "%");
        }
        if (criteria.getGender() != null && !criteria.getGender().isEmpty()) {
            sql.append(" AND gender = ?");
            params.add(criteria.getGender());
        }
        if (criteria.getAddress() != null && !criteria.getAddress().isEmpty()) {
            sql.append(" AND address LIKE ?");
            params.add("%" + criteria.getAddress() + "%");
        }

        sql.append(" AND is_active = ?");
        params.add(criteria.isActive());

        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = connection.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToAdmin(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public void registerAdmin(Admin admin, String role) {
        String sql = "INSERT INTO [project_SWP391].[dbo].[Admin] (username, password, email, full_name, phone, date_of_birth, gender, address, profile_picture, created_at, updated_at, is_active, role) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), GETDATE(), ?, ?)";
        PreparedStatement ps = null;
        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, admin.getUsername());
            ps.setString(2, admin.getPassword());
            ps.setString(3, admin.getEmail());
            ps.setString(4, admin.getFullName());
            ps.setString(5, admin.getPhone());
            ps.setDate(6, admin.getDateOfBirth());
            ps.setString(7, admin.getGender());
            ps.setString(8, admin.getAddress());
            ps.setString(9, admin.getProfilePicture());
//            ps.setDate(10, admin.getCreatedAt());
//            ps.setDate(11, admin.getUpdatedAt());
            ps.setBoolean(10, admin.isActive());
            ps.setString(11, role);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public void changeStatus(int ID, boolean status) {
        String sql = "UPDATE [project_SWP391].[dbo].[Admin] SET is_active = ? WHERE id = ?";
        PreparedStatement ps = null;
        try {
            ps = connection.prepareStatement(sql);
            ps.setBoolean(1, status);
            ps.setInt(2, ID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public Admin getSpecificStaff(int ID) {
        String sql = "SELECT * FROM [project_SWP391].[dbo].[Admin] WHERE id = ?";
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, ID);
            rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToAdmin(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    public Admin getSpecificAdmin(int ID, String role) {
        String sql = "SELECT * FROM [project_SWP391].[dbo].[Admin] WHERE id = ? AND role = ?";
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, ID);
            ps.setString(2, role);
            rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToAdmin(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    public int getTotalStaff() {
        String sql = "SELECT COUNT(*) FROM [project_SWP391].[dbo].[Admin] WHERE [role] != 'admin'";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
//            ps.setString(1, role);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Thêm vào AdminDAO.java sau các phương thức hiện có
    public int getTotalAdmins(String role) {
        String sql = "SELECT COUNT(*) FROM [project_SWP391].[dbo].[Admin] WHERE [role] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, role);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getTotalSearchResults(Admin criteria, String role) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM [project_SWP391].[dbo].[Admin] WHERE [role] = '" + role + "'");
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
        if (criteria.getFullName() != null && !criteria.getFullName().isEmpty()) {
            sql.append(" AND full_name LIKE ?");
            params.add("%" + criteria.getFullName() + "%");
        }
        if (criteria.getPhone() != null && !criteria.getPhone().isEmpty()) {
            sql.append(" AND phone LIKE ?");
            params.add("%" + criteria.getPhone() + "%");
        }
        if (criteria.getGender() != null && !criteria.getGender().isEmpty()) {
            sql.append(" AND gender = ?");
            params.add(criteria.getGender());
        }
        if (criteria.getAddress() != null && !criteria.getAddress().isEmpty()) {
            sql.append(" AND address LIKE ?");
            params.add("%" + criteria.getAddress() + "%");
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

    public int getTotalStaff(Admin criteria) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM [project_SWP391].[dbo].[Admin] WHERE [role] != 'admin'");
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
        if (criteria.getFullName() != null && !criteria.getFullName().isEmpty()) {
            sql.append(" AND full_name LIKE ?");
            params.add("%" + criteria.getFullName() + "%");
        }
        if (criteria.getPhone() != null && !criteria.getPhone().isEmpty()) {
            sql.append(" AND phone LIKE ?");
            params.add("%" + criteria.getPhone() + "%");
        }
        if (criteria.getGender() != null && !criteria.getGender().isEmpty()) {
            sql.append(" AND gender = ?");
            params.add(criteria.getGender());
        }
        if (criteria.getAddress() != null && !criteria.getAddress().isEmpty()) {
            sql.append(" AND address LIKE ?");
            params.add("%" + criteria.getAddress() + "%");
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

    public Vector<Admin> getStaffWithPagingAndSorting(int page, int recordsPerPage, String sortField, String sortOrder) {
        int start = (page - 1) * recordsPerPage;
        Vector<Admin> admins = new Vector<>();
        String sql = "SELECT * FROM [project_SWP391].[dbo].[Admin] WHERE [role] != 'admin' ORDER BY " + sortField + " " + sortOrder
                + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
//            stmt.setString(1, role);
            stmt.setInt(1, start);
            stmt.setInt(2, recordsPerPage);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Admin admin = mapResultSetToAdmin(rs);
                admins.add(admin);
            }
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
        return admins;
    }

    public Vector<Admin> getAdminsWithPagingAndSorting(String role, int page, int recordsPerPage, String sortField, String sortOrder) {
        int start = (page - 1) * recordsPerPage;
        Vector<Admin> admins = new Vector<>();
        String sql = "SELECT * FROM [project_SWP391].[dbo].[Admin] WHERE [role] = ? ORDER BY " + sortField + " " + sortOrder
                + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, role);
            stmt.setInt(2, start);
            stmt.setInt(3, recordsPerPage);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Admin admin = mapResultSetToAdmin(rs);
                admins.add(admin);
            }
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
        return admins;
    }

    public Vector<Admin> searchAdminWithPagingAndSorting(Admin criteria, String role, int page, int recordsPerPage, String sortField, String sortOrder) {
        int start = (page - 1) * recordsPerPage;
        Vector<Admin> list = new Vector<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM [project_SWP391].[dbo].[Admin] WHERE [role] = '" + role + "'");
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
        if (criteria.getFullName() != null && !criteria.getFullName().isEmpty()) {
            sql.append(" AND full_name LIKE ?");
            params.add("%" + criteria.getFullName() + "%");
        }
        if (criteria.getPhone() != null && !criteria.getPhone().isEmpty()) {
            sql.append(" AND phone LIKE ?");
            params.add("%" + criteria.getPhone() + "%");
        }
        if (criteria.getGender() != null && !criteria.getGender().isEmpty()) {
            sql.append(" AND gender = ?");
            params.add(criteria.getGender());
        }
        if (criteria.getAddress() != null && !criteria.getAddress().isEmpty()) {
            sql.append(" AND address LIKE ?");
            params.add("%" + criteria.getAddress() + "%");
        }
//        sql.append(" AND is_active = ?");
//        params.add(criteria.isActive());

        sql.append(" ORDER BY ").append(sortField).append(" ").append(sortOrder);
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = connection.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ps.setInt(params.size() + 1, start);
            ps.setInt(params.size() + 2, recordsPerPage);

            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToAdmin(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public Vector<Admin> searchStaffWithPagingAndSorting(Admin criteria, int page, int recordsPerPage, String sortField, String sortOrder) {
        int start = (page - 1) * recordsPerPage;
        Vector<Admin> list = new Vector<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM [project_SWP391].[dbo].[Admin] WHERE [role] != 'admin'");
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
        if (criteria.getFullName() != null && !criteria.getFullName().isEmpty()) {
            sql.append(" AND full_name LIKE ?");
            params.add("%" + criteria.getFullName() + "%");
        }
        if (criteria.getPhone() != null && !criteria.getPhone().isEmpty()) {
            sql.append(" AND phone LIKE ?");
            params.add("%" + criteria.getPhone() + "%");
        }
        if (criteria.getGender() != null && !criteria.getGender().isEmpty()) {
            sql.append(" AND gender = ?");
            params.add(criteria.getGender());
        }
        if (criteria.getAddress() != null && !criteria.getAddress().isEmpty()) {
            sql.append(" AND address LIKE ?");
            params.add("%" + criteria.getAddress() + "%");
        }
//        sql.append(" AND is_active = ?");
//        params.add(criteria.isActive());

        sql.append(" ORDER BY ").append(sortField).append(" ").append(sortOrder);
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = connection.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ps.setInt(params.size() + 1, start);
            ps.setInt(params.size() + 2, recordsPerPage);

            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToAdmin(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public boolean updateAdmin(Admin criteria) {
        String sql = "UPDATE [dbo].[Admin]\n"
                + "   SET [username] = ?\n"
                + "      ,[password] = ?\n"
                + "      ,[email] = ?\n"
                + "      ,[full_name] = ?\n"
                + "      ,[phone] = ?\n"
                + "      ,[date_of_birth] = ?\n"
                + "      ,[gender] = ?\n"
                + "      ,[address] = ?\n"
                + "      ,[profile_picture] = ?\n"
                + "      ,[updated_at] = GETDATE()\n"
                + "      ,[is_active] = ?\n"
                + "      ,[role] = ?\n"
                + " WHERE [id] = ? ";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, criteria.getUsername());
            stmt.setString(2, criteria.getPassword());
            stmt.setString(3, criteria.getEmail());
            stmt.setString(4, criteria.getFullName());
            stmt.setString(5, criteria.getPhone());
            stmt.setDate(6, criteria.getDateOfBirth());
            stmt.setString(7, criteria.getGender());
            stmt.setString(8, criteria.getAddress());
            stmt.setString(9, criteria.getProfilePicture());
            stmt.setBoolean(10, criteria.isActive());
            stmt.setString(11, criteria.getRole());
            stmt.setInt(12, criteria.getId());
            int n = stmt.executeUpdate();
            return n > 0;
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
        return false;
    }

    public boolean checkEmailPhone(Admin criteria) {
        String sql = "SELECT * "
                + "  FROM [project_SWP391].[dbo].[Admin] "
                + "WHERE [email] = ? or [phone] = ?";
        
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, criteria.getEmail());
            stmt.setString(2, criteria.getPhone());
            ResultSet res = stmt.executeQuery();
            while (res.next()){
                return false;
            }
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
        return true;
    }

}
