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
public class Categories {
    private String categoryID;
    private String categoryName;

    public Categories() {
    }

    public Categories(String categoryID, String categoryName) {
        this.categoryID = categoryID;
        this.categoryName = categoryName;
    }

    public String getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(String categoryID) {
        this.categoryID = categoryID;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    @Override
    public String toString() {
        return "Categories{" + "categoryID=" + categoryID + ", categoryName=" + categoryName + '}';
    }
    
    
}
