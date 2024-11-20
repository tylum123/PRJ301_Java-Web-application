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
public class ComesticError {

    private String productIDError;
    private String productNameError;
    private String quantityError;
    private String priceError;

    public ComesticError() {
    }

    public ComesticError(String productIDError, String productNameError, String quantityError, String priceError) {
        this.productIDError = productIDError;
        this.productNameError = productNameError;
        this.quantityError = quantityError;
        this.priceError = priceError;
    }

    public String getProductIDError() {
        return productIDError;
    }

    public void setProductIDError(String productIDError) {
        this.productIDError = productIDError;
    }

    public String getProductNameError() {
        return productNameError;
    }

    public void setProductNameError(String productNameError) {
        this.productNameError = productNameError;
    }

    public String getQuantityError() {
        return quantityError;
    }

    public void setQuantityError(String quantityError) {
        this.quantityError = quantityError;
    }

    public String getPriceError() {
        return priceError;
    }

    public void setPriceError(String priceError) {
        this.priceError = priceError;
    }

}
