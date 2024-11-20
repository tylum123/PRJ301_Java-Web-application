/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.comestic;

/**
 *
 * @author minhnguyen
 */
public class Comestic {

    private String productID;
    private String productName;
    private int quantity;
    private float price;
    private boolean status;
    private String image;
    private String description;
    private String categoryID;
    private String saleID;

    public Comestic() {
    }

    public Comestic(String productID, String productName, int quantity, float price, boolean status, String image, String description, String categoryID, String saleID) {
        this.productID = productID;
        this.productName = productName;
        this.quantity = quantity;
        this.price = price;
        this.status = status;
        this.image = image;
        this.description = description;
        this.categoryID = categoryID;
        this.saleID = saleID;
    }

    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(String categoryID) {
        this.categoryID = categoryID;
    }

    public String getSaleID() {
        return saleID;
    }

    public void setSaleID(String saleID) {
        this.saleID = saleID;
    }

    @Override
    public String toString() {
        return "Comestic{" + "productID=" + productID + ", productName=" + productName + ", quantity=" + quantity + ", price=" + price + ", status=" + status + ", image=" + image + ", description=" + description + ", categoryID=" + categoryID + ", saleID=" + saleID + '}';
    }

}
