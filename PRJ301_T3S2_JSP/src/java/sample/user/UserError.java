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
public class UserError {

    private String userIDError;
    private String fullNameError;
    private String uroleIDError;
    private String upasswordError;
    private String confirmError;
    private String error;

    public UserError() {
        this.userIDError = "";
        this.fullNameError = "";
        this.uroleIDError = "";
        this.upasswordError = "";
        this.confirmError ="";
        this.error = "";
    }

    public UserError(String userIDError, String fullNameError, String uroleIDError, String upasswordError, String confirmError, String error) {
        this.userIDError = userIDError;
        this.fullNameError = fullNameError;
        this.uroleIDError = uroleIDError;
        this.upasswordError = upasswordError;
        this.confirmError = confirmError;
        this.error = error;
    }

    public String getUserIDError() {
        return userIDError;
    }

    public void setUserIDError(String userIDError) {
        this.userIDError = userIDError;
    }

    public String getFullNameError() {
        return fullNameError;
    }

    public void setFullNameError(String fullNameError) {
        this.fullNameError = fullNameError;
    }

    public String getUroleIDError() {
        return uroleIDError;
    }

    public void setUroleIDError(String uroleIDError) {
        this.uroleIDError = uroleIDError;
    }

    public String getUpasswordError() {
        return upasswordError;
    }

    public void setUpasswordError(String upasswordError) {
        this.upasswordError = upasswordError;
    }

    public String getConfirmError() {
        return confirmError;
    }

    public void setConfirmError(String confirmError) {
        this.confirmError = confirmError;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    @Override
    public String toString() {
        return "UserError{" + "userIDError=" + userIDError + ", fullNameError=" + fullNameError + ", uroleIDError=" + uroleIDError + ", upasswordError=" + upasswordError + ", confirmError=" + confirmError + ", error=" + error + '}';
    }

    
}
