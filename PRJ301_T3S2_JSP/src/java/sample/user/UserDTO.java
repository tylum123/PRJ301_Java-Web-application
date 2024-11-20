/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.user;

/**
 *
 * @author minhnguyen
 */
public class UserDTO {

    private String userID;
    private String fullName;
    private String roleID;
    private String password;
    private boolean status;
    private boolean isSale;
    private String picture;
    private String address;
    private String Email;

    public UserDTO() {
    }

    public UserDTO(String userID, String fullName, String roleID, String password, boolean status, boolean isSale, String picture, String address, String Email) {
        this.userID = userID;
        this.fullName = fullName;
        this.roleID = roleID;
        this.password = password;
        this.status = status;
        this.isSale = isSale;
        this.picture = picture;
        this.address = address;
        this.Email = Email;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getRoleID() {
        return roleID;
    }

    public void setRoleID(String roleID) {
        this.roleID = roleID;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public boolean isIsSale() {
        return isSale;
    }

    public void setIsSale(boolean isSale) {
        this.isSale = isSale;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    @Override
    public String toString() {
        return "UserDTO{" + "userID=" + userID + ", fullName=" + fullName + ", roleID=" + roleID + ", password=" + password + ", status=" + status + ", isSale=" + isSale + ", picture=" + picture + ", address=" + address + ", Email=" + Email + '}';
    }

   
}
