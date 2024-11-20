/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.comestic;

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
public class ProductDAO {

    private static final String SEARCH = "SELECT productID, productName,quantity,price,status,image,description,categoryID,saleID FROM tblProducts WHERE productName LIKE ? ORDER BY productID OFFSET ? ROWS FETCH NEXT 3 ROWS ONLY";
    private static final String SHOW1 = "SELECT productID, productName,quantity,price,status,image,description,categoryID,saleID FROM tblProducts WHERE productName Like ?";
    private static final String SHOW3 = "SELECT productID, productName,quantity,price,status,image,description,categoryID,saleID FROM tblProducts WHERE  saleID=?";
    private static final String SHOW2 = "SELECT productID, productName,quantity,price,status,image,description,categoryID,saleID FROM tblProducts WHERE categoryID LIKE ?";
    private static final String DELETE = "DELETE FROM tblProducts WHERE productID = ?";
    private static final String DELETE2 = "DELETE FROM tblProducts WHERE saleID = ?";
    private static final String UPDATE = "UPDATE tblProducts SET productName = ?, quantity = ?, price = ?, status = ?, image=?, description=?, categoryID=?, saleID=? WHERE productID = ?";
    private static final String INSERT = "INSERT INTO tblProducts(productID,productName,quantity,price,status,image,description,categoryID,saleID) VALUES(?,?,?,?,?,?,?,?,?)";
    private static final String DUPLICATE = "SELECT fullName FROM tblProducts WHERE productID=?";
    private static final String COUNT = "SELECT COUNT (*) FROM tblProducts WHERE productName LIKE ?";
    private static final String CATEGORY = "SELECT * FROM tblCategories";

    public List<Comestic> getListProduct(String search, int index) throws SQLException, ClassNotFoundException, NamingException {
        List<Comestic> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH);
                ptm.setString(1, "%" + search + "%");
                ptm.setInt(2, (index - 1) * 3);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String productID = rs.getString("productID");
                    String productName = rs.getString("productName");
                    int quantity = rs.getInt("quantity");
                    float price = rs.getFloat("price");
                    boolean status = rs.getBoolean("status");
                    String image = rs.getString("image");
                    String description = rs.getString("description");
                    String categoryID = rs.getString("categoryID");
                    String saleID = rs.getString("saleID");
                    list.add(new Comestic(productID, productName, quantity, price, status, image, description, categoryID, saleID));
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

    public List<Comestic> getListProduct2(String search) throws SQLException, ClassNotFoundException, NamingException {
        List<Comestic> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SHOW1);
                ptm.setString(1, "%" + search + "%");
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String productID = rs.getString("productID");
                    String productName = rs.getString("productName");
                    int quantity = rs.getInt("quantity");
                    float price = rs.getFloat("price");
                    boolean status = rs.getBoolean("status");
                    String image = rs.getString("image");
                    String description = rs.getString("description");
                    String categoryID = rs.getString("categoryID");
                    String saleID = rs.getString("saleID");
                    list.add(new Comestic(productID, productName, quantity, price, status, image, description, categoryID, saleID));
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

    public List<Comestic> getListProduct3(String userID) throws SQLException, ClassNotFoundException, NamingException {
        List<Comestic> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SHOW3);
                ptm.setString(1, userID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String productID = rs.getString("productID");
                    String productName = rs.getString("productName");
                    int quantity = rs.getInt("quantity");
                    float price = rs.getFloat("price");
                    boolean status = rs.getBoolean("status");
                    String image = rs.getString("image");
                    String description = rs.getString("description");
                    String categoryID = rs.getString("categoryID");
                    String saleID = rs.getString("saleID");
                    list.add(new Comestic(productID, productName, quantity, price, status, image, description, categoryID, saleID));
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

    public List<Categories> getListCategory() throws SQLException, ClassNotFoundException, NamingException {
        List<Categories> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CATEGORY);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    list.add(new Categories(rs.getString(1), rs.getString(2)));
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

    public boolean deleteProduct(String productID) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(DELETE);
                ptm.setString(1, productID);
                check = ptm.executeUpdate() > 0;
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

    public boolean deleteProductBySeller(String userID) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(DELETE2);
                ptm.setString(1, userID);
                check = ptm.executeUpdate() > 0;
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

    public boolean updateProduct(String productID, String productName, int quantity, float price, boolean status, String image, String description, String categoryID, String saleID) throws ClassNotFoundException, SQLException, NamingException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE);
                ptm.setString(9, productID);
                ptm.setString(1, productName);
                ptm.setInt(2, quantity);
                ptm.setFloat(3, price);
                ptm.setInt(4, status ? 1 : 0);
                ptm.setString(5, image);
                ptm.setString(6, description);
                ptm.setString(7, categoryID);
                ptm.setString(8, saleID);
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

    public boolean checkDuplicate(String productID) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(DUPLICATE);
                ptm.setString(1, productID);
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

    public boolean insertProduct(Comestic comestic) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(INSERT);
                ptm.setString(1, comestic.getProductID());
                ptm.setString(2, comestic.getProductName());
                ptm.setInt(3, comestic.getQuantity());
                ptm.setFloat(4, comestic.getPrice());
                ptm.setInt(5, comestic.isStatus() ? 1 : 0);
                ptm.setString(6, comestic.getImage());
                ptm.setString(7, comestic.getDescription());
                ptm.setString(8, comestic.getCategoryID());
                ptm.setString(9, comestic.getSaleID());

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

    public int totalProduct(String search) throws ClassNotFoundException, SQLException, NamingException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
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

    public List<Comestic> getListProductByCid(String Cid) throws ClassNotFoundException, SQLException, NamingException {
        List<Comestic> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SHOW2);
                ptm.setString(1, Cid);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String productID = rs.getString("productID");
                    String productName = rs.getString("productName");
                    int quantity = rs.getInt("quantity");
                    float price = rs.getFloat("price");
                    boolean status = rs.getBoolean("status");
                    String image = rs.getString("image");
                    String description = rs.getString("description");
                    String categoryID = rs.getString("categoryID");
                    String saleID = rs.getString("saleID");
                    list.add(new Comestic(productID, productName, quantity, price, status, image, description, categoryID, saleID));
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

    public void updateProductQuantity(String productID, int quantity) throws ClassNotFoundException, SQLException, NamingException {
        Connection conn = DBUtils.getConnection();
        String checkQuantitySql = "SELECT quantity FROM tblProducts WHERE productID = ?";
        String updateSql = "UPDATE tblProducts SET quantity = quantity - ? WHERE productID = ?";

        try {
            PreparedStatement checkPs = conn.prepareStatement(checkQuantitySql);
            checkPs.setString(1, productID);
            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                int currentQuantity = rs.getInt("quantity");
                if (currentQuantity < quantity) {
                    // Số lượng không đủ để cập nhật
                    System.out.println("Quantity is insufficient to update.");
                    return;
                }
            } else {
                // Sản phẩm không tồn tại
                System.out.println("Product not found.");
                return;
            }

            PreparedStatement updatePs = conn.prepareStatement(updateSql);
            updatePs.setInt(1, quantity);
            updatePs.setString(2, productID);
            updatePs.executeUpdate();
        } finally {
            conn.close();
        }
    }

}
