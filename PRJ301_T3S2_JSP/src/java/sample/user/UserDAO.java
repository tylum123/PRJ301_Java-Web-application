/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import sample.utils.DBUtils;

/**
 *
 * @author minhnguyen
 */
public class UserDAO {

    private static final String LOGIN = "SELECT fullName, roleID,status,isSale,picture,address,email  FROM tblUsers WHERE userID=? AND password=?";
    private static final String SEARCH = "SELECT userID, fullName,roleID,status,isSale,picture,address,email FROM tblUsers WHERE fullName LIKE ? ORDER BY userID OFFSET ? ROWS FETCH NEXT 5 ROWS ONLY";
    private static final String UPDATE = "UPDATE tblUsers SET fullName = ?, roleID = ?, status = ?, isSale=?, picture=?, address=?, email=? WHERE userID = ?";
    private static final String DUPLICATE = "SELECT fullName FROM tblUsers WHERE userID=?";
    private static final String INSERT = "INSERT INTO tblUsers(userID,fullName,roleID,password,status,isSale,picture,address,email) VALUES(?,?,?,?,?,?,?,?,?)";
    private static final String COUNT = "SELECT COUNT (*) FROM tblUsers WHERE fullName LIKE ?";

    public UserDTO checkLogin(String userID, String password) throws SQLException, ClassNotFoundException, NamingException {
        UserDTO user = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(LOGIN);
                ptm.setString(1, userID);
                ptm.setString(2, password);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    String fullName = rs.getString("fullName");
                    String roleID = rs.getString("roleID");
                    boolean status = rs.getBoolean("status");
                    boolean isSale = rs.getBoolean("isSale");
                    String picture = rs.getString("picture");
                    String address = rs.getString("address");
                    String email = rs.getString("email");
                    user = new UserDTO(userID, fullName, roleID, "***", status, isSale, picture, address, email);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }

        }

        return user;
    }

    public List<UserDTO> getListUser(String search, int index) throws SQLException, ClassNotFoundException, NamingException {
        List<UserDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH);
                ptm.setString(1, "%" + search + "%");
                ptm.setInt(2, (index - 1) * 5);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String userID = rs.getString("userID");
                    String fullName = rs.getString("fullName");
                    String roleID = rs.getString("roleID");
                    String password = "***";
                    boolean status = rs.getBoolean("status");
                    boolean isSale = rs.getBoolean("isSale");
                    String picture = rs.getString("picture");
                    String address = rs.getString("address");
                    String email = rs.getString("email");
                    list.add(new UserDTO(userID, fullName, roleID, password, status, isSale, picture, address, email));
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    public boolean delete(String userID) throws SQLException, ClassNotFoundException, NamingException {
        boolean success = false;
        Connection conn = null;
        PreparedStatement stmtOrders = null;
        PreparedStatement stmtOrderDetails = null;
        PreparedStatement stmtUser = null;
        String deleteOrdersSQL = "DELETE FROM tblOrders WHERE userID = ?";
        String deleteOrderDetailsSQL = "DELETE FROM tblOrderDetails WHERE orderID IN (SELECT orderID FROM tblOrders WHERE userID = ?)";
        String deleteUserSQL = "DELETE FROM tblUsers WHERE userID = ?";

        try {
            conn = DBUtils.getConnection();
            conn.setAutoCommit(false); // Bắt đầu transaction

            // Xóa các bản ghi trong tblOrderDetails liên quan đến userID
            stmtOrderDetails = conn.prepareStatement(deleteOrderDetailsSQL);
            stmtOrderDetails.setString(1, userID);
            stmtOrderDetails.executeUpdate();

            // Xóa các bản ghi trong tblOrders liên quan đến userID
            stmtOrders = conn.prepareStatement(deleteOrdersSQL);
            stmtOrders.setString(1, userID);
            stmtOrders.executeUpdate();

            // Xóa người dùng từ tblUsers
            stmtUser = conn.prepareStatement(deleteUserSQL);
            stmtUser.setString(1, userID);
            int rowsAffected = stmtUser.executeUpdate();

            if (rowsAffected > 0) {
                success = true;
                conn.commit(); // Hoàn thành transaction nếu thành công
            } else {
                conn.rollback(); // Rollback nếu không có bản ghi nào bị xóa
            }
        } catch (SQLException ex) {
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback transaction nếu có lỗi
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            ex.printStackTrace();
        } finally {
            // Đóng các tài nguyên
            if (stmtOrders != null) {
                stmtOrders.close();
            }
            if (stmtOrderDetails != null) {
                stmtOrderDetails.close();
            }
            if (stmtUser != null) {
                stmtUser.close();
            }
            if (conn != null) {
                conn.setAutoCommit(true); // Trả lại chế độ mặc định
                conn.close();
            }
        }

        return success;
    }

    public boolean updateInfo(String userID, String fullName, String roleID, boolean status, boolean isSale, String picture, String address, String email) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE);
                ptm.setString(1, fullName);
                ptm.setString(2, roleID);
                ptm.setInt(3, status ? 1 : 0);
                ptm.setInt(4, isSale ? 1 : 0);
                ptm.setString(5, picture);
                ptm.setString(6, address);
                ptm.setString(7, email);
                ptm.setString(8, userID);
                if (ptm.executeUpdate() > 0) {
                    check = true;
                }
            }
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean checkDuplicate(String userID) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(DUPLICATE);
                ptm.setString(1, userID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    check = true;
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean insert(UserDTO user) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(INSERT);
                ptm.setString(1, user.getUserID());
                ptm.setString(2, user.getFullName());
                ptm.setString(3, user.getRoleID());
                ptm.setString(4, user.getPassword());
                ptm.setInt(5, user.isStatus() ? 1 : 0);
                ptm.setInt(6, user.isIsSale() ? 1 : 0);
                ptm.setString(7, user.getPicture());
                ptm.setString(8, user.getAddress());
                ptm.setString(9, user.getEmail());

                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public int totalUser(String search) throws ClassNotFoundException, SQLException, NamingException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnectionV1();
            if (conn != null) {
                ptm = conn.prepareStatement(COUNT);
                ptm.setString(1, "%" + search + "%");
                rs = ptm.executeQuery();
                while (rs.next()) {
                    return rs.getInt(1);
                }

            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return 0;
    }
}
