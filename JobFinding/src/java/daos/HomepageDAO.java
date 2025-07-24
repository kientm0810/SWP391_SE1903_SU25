package daos;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import context.DBContext;
import models.HomepageComponentType;
import models.HomepageComponentContent;

/**
 * DAO for Homepage Components
 */
public class HomepageDAO extends DBContext {

    // Methods for ComponentType
    public Vector<HomepageComponentType> getAllComponentTypes() {
        Vector<HomepageComponentType> types = new Vector<>();
        String sql = "SELECT * FROM HomePageComponentType ORDER BY id";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                types.add(mapResultSetToComponentType(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return types;
    }

    public HomepageComponentType getComponentTypeById(int id) {
        String sql = "SELECT * FROM HomePageComponentType WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToComponentType(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public HomepageComponentType getComponentTypeByName(String typeName) {
        String sql = "SELECT * FROM HomePageComponentType WHERE type_name = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, typeName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToComponentType(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Methods for ComponentContent
    public Vector<HomepageComponentContent> getAllComponentContents() {
        Vector<HomepageComponentContent> contents = new Vector<>();
        String sql = "SELECT hcc.*, hct.type_name FROM HomePageComponentContent hcc "
                + "JOIN HomePageComponentType hct ON hcc.type_id = hct.id "
                + "ORDER BY hcc.type_id, hcc.position";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                contents.add(mapResultSetToComponentContent(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return contents;
    }

    public int getComponentContentsByType(String typeName) {
        int contents = 0;
        String sql = "SELECT hcc.*, hct.type_name FROM HomePageComponentContent hcc "
                + "JOIN HomePageComponentType hct ON hcc.type_id = hct.id "
                + "WHERE hct.type_name like N'%" + typeName + "%' AND hcc.status = 'active' "
                + "ORDER BY hcc.position";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ps.setString(1, typeName);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
//                contents.add(mapResultSetToComponentContent(rs));
                contents += 1;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return contents;
    }
    
    public Vector<HomepageComponentContent> getListComponentContentsByType(String typeName) {
        Vector<HomepageComponentContent> contents = new Vector<>();
        String sql = "SELECT hcc.*, hct.type_name FROM HomePageComponentContent hcc " +
                     "JOIN HomePageComponentType hct ON hcc.type_id = hct.id " +
                     "WHERE hct.type_name = ? AND hcc.status = 'active' " +
                     "ORDER BY hcc.position";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, typeName);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                contents.add(mapResultSetToComponentContent(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return contents;
    }

    public HomepageComponentContent getComponentContentById(int id) {
        String sql = "SELECT hcc.*, hct.type_name FROM HomePageComponentContent hcc "
                + "JOIN HomePageComponentType hct ON hcc.type_id = hct.id "
                + "WHERE hcc.id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToComponentContent(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean insertComponentContent(HomepageComponentContent content) {
        String sql = "INSERT INTO HomePageComponentContent (type_id, position, name, title, content, icon_class, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, content.getTypeId());
            ps.setInt(2, content.getPosition());
            ps.setString(3, content.getName());
            ps.setString(4, content.getTitle());
            ps.setString(5, content.getContent());
            ps.setString(6, content.getIconClass());
            ps.setString(7, content.getStatus());

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateComponentContent(HomepageComponentContent content) {
        String sql = "UPDATE HomePageComponentContent SET "
                + "type_id = ?, position = ?, name = ?, title = ?, content = ?, icon_class = ?, "
                + "status = ?, updated_at = GETDATE() WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, content.getTypeId());
            ps.setInt(2, content.getPosition());
            ps.setString(3, content.getName());
            ps.setString(4, content.getTitle());
            ps.setString(5, content.getContent());
            ps.setString(6, content.getIconClass());
            ps.setString(7, content.getStatus());
            ps.setInt(8, content.getId());

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteComponentContent(int id) {
        String sql = "DELETE FROM HomePageComponentContent WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Pagination methods
    public int getTotalComponentContents() {
        String sql = "SELECT COUNT(*) FROM HomePageComponentContent";
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

    public Vector<HomepageComponentContent> getComponentContentsWithPaging(String type, int page,
            int recordsPerPage, String sortField, String sortOrder) {
        int start = (page - 1) * recordsPerPage;
        Vector<HomepageComponentContent> contents = new Vector<>();
        String sql = "SELECT hcc.*, hct.type_name FROM HomePageComponentContent hcc "
                + "JOIN HomePageComponentType hct ON hcc.type_id = hct.id "
                + "WHERE hct.type_name like N'%" + type + "%'"
                + "ORDER BY hcc." + sortField + " " + sortOrder
                + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, start);
            ps.setInt(2, recordsPerPage);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                contents.add(mapResultSetToComponentContent(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return contents;
    }

    // Mapping methods
    private HomepageComponentType mapResultSetToComponentType(ResultSet rs) throws SQLException {
        HomepageComponentType type = new HomepageComponentType();
        type.setId(rs.getInt("id"));
        type.setTypeName(rs.getString("type_name"));
        type.setDescription(rs.getString("description"));
        type.setCreatedAt(rs.getDate("created_at"));
        type.setUpdatedAt(rs.getDate("updated_at"));
        return type;
    }

    private HomepageComponentContent mapResultSetToComponentContent(ResultSet rs) throws SQLException {
        HomepageComponentContent content = new HomepageComponentContent();
        content.setId(rs.getInt("id"));
        content.setImg(rs.getString("img"));
        content.setTypeId(rs.getInt("type_id"));
        content.setPosition(rs.getInt("position"));
        content.setName(rs.getString("name"));
        content.setTitle(rs.getString("title"));
        content.setContent(rs.getString("content"));
        content.setIconClass(rs.getString("icon_class"));
        content.setStatus(rs.getString("status"));
        content.setCreatedAt(rs.getDate("created_at"));
        content.setUpdatedAt(rs.getDate("updated_at"));
        content.setTypeName(rs.getString("type_name")); // From JOIN
        return content;
    }
}
