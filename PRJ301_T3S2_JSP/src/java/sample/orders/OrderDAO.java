package sample.orders;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;
import sample.comestic.Cart;
import sample.comestic.Comestic;
import sample.utils.DBUtils;

/**
 *
 * @author minhnguyen
 */
public class OrderDAO {

    public String saveOrder(Cart cart, String userID) throws ClassNotFoundException, SQLException, NamingException {
        Connection conn = null;
        PreparedStatement psOrder = null;
        PreparedStatement psOrderDetail = null;
        PreparedStatement psCheckQuantity = null;
        ResultSet rs = null;
        String orderId = null;
        boolean success = false;
        boolean sufficientQuantity = true;

        try {
            conn = DBUtils.getConnection();
            String orderSql = "INSERT INTO tblOrders (orderID, userID, date, total, status) VALUES (?, ?, ?, ?, ?)";
            String orderDetailSql = "INSERT INTO tblOrderDetails (orderID, productID, price, quantity, status) VALUES (?, ?, ?, ?, ?)";
            String checkQuantitySql = "SELECT quantity FROM tblProducts WHERE productID = ?";
            orderId = generateUniqueOrderId(conn); // Generate a unique order ID
            conn.setAutoCommit(false);

            // Check product quantities
            psCheckQuantity = conn.prepareStatement(checkQuantitySql);
            for (Comestic item : cart.getCart().values()) {
                psCheckQuantity.setString(1, item.getProductID());
                rs = psCheckQuantity.executeQuery();
                if (rs.next()) {
                    int availableQuantity = rs.getInt("quantity");
                    if (item.getQuantity() > availableQuantity) {
                        sufficientQuantity = false;
                        break;
                    }
                }
            }

            if (!sufficientQuantity) {
                return null; // or throw an exception to indicate insufficient quantity
            }

            // Insert into tblOrders
            psOrder = conn.prepareStatement(orderSql);
            psOrder.setString(1, orderId);
            psOrder.setString(2, userID);
            psOrder.setDate(3, new java.sql.Date(System.currentTimeMillis()));
            psOrder.setDouble(4, cart.getTotalPrice());
            psOrder.setBoolean(5, true);
            psOrder.executeUpdate();

            // Insert into OrderDetails
            psOrderDetail = conn.prepareStatement(orderDetailSql);
            for (Comestic item : cart.getCart().values()) {
                psOrderDetail.setString(1, orderId);
                psOrderDetail.setString(2, item.getProductID());
                psOrderDetail.setDouble(3, item.getPrice());
                psOrderDetail.setInt(4, item.getQuantity());
                psOrderDetail.setBoolean(5, item.isStatus());
                psOrderDetail.executeUpdate();
            }
            success = true;
        } catch (SQLException e) {
            System.err.println("SQLException: " + e.getMessage());
            System.err.println("SQLState: " + e.getSQLState());
            System.err.println("VendorError: " + e.getErrorCode());
        } finally {
            try {
                if (success) {
                    conn.commit();
                } else {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                System.err.println("Error during commit/rollback: " + ex.getMessage());
            }
            if (rs != null) {
                rs.close();
            }
            if (psCheckQuantity != null) {
                psCheckQuantity.close();
            }
            if (psOrderDetail != null) {
                psOrderDetail.close();
            }
            if (psOrder != null) {
                psOrder.close();
            }
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
        return orderId;
    }

    // Method to generate a unique orderID based on sequence
    private String generateUniqueOrderId(Connection conn) throws SQLException {
        String orderId = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT MAX(CAST(SUBSTRING(orderID, 2, LEN(orderID) - 1) AS INT)) FROM tblOrders WHERE orderID LIKE 'O%'";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                int maxId = rs.getInt(1);
                orderId = String.format("O%03d", maxId + 1); // Format as O followed by 3 digits
            } else {
                orderId = "O001"; // Start from O001 if there are no existing orders
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        }
        return orderId;
    }

}
