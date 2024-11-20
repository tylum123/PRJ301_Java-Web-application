/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.orders;

/**
 *
 * @author minhnguyen
 */
public class OrderDetails {

    private String orderID;
    private String productID;
    private float price;
    private int quantity;
    private boolean status;

    // Getters and setters
    public OrderDetails() {
    }

    public OrderDetails(String orderID, String productID, float price, int quantity, boolean status) {
        this.orderID = orderID;
        this.productID = productID;
        this.price = price;
        this.quantity = quantity;
        this.status = status;
    }

    public String getOrderID() {
        return orderID;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    

}
