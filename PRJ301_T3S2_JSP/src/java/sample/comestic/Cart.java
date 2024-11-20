/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.comestic;

import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author minhnguyen
 */
public class Cart {

    private Map<String, Comestic> cart;

    public Cart() {
    }

    public Map<String, Comestic> getCart() {
        return cart;
    }

    public void setCart(Map<String, Comestic> cart) {
        this.cart = cart;
    }

    public boolean add(Comestic comestic) {
        boolean check = false;
        try {
            if (this.cart == null) {
                this.cart = new HashMap<>();
            }
            if (this.cart.containsKey(comestic.getProductID())) {
                int currentQuantity = cart.get(comestic.getProductID()).getQuantity();
                comestic.setQuantity(currentQuantity + comestic.getQuantity());
            }
            this.cart.put(comestic.getProductID(), comestic);
            check = true;
        } catch (Exception e) {
        }
        return check;
    }

    public boolean remove(String id) {
        boolean check = false;
        try {
            if (this.cart != null) {
                this.cart.remove(id);
                check = true;
            }
        } catch (Exception e) {
        }
        return check;
    }

    public boolean edit(String id, int quantity) {
        boolean check = false;
        try {
            if (this.cart != null) {
                this.cart.get(id).setQuantity(quantity);
                check = true;
            }
        } catch (Exception e) {
        }
        return check;
    }

    public double getTotalPrice() {
        double totalPrice = 0;
        if (this.cart != null) {
            for (Comestic comestic : cart.values()) {
                totalPrice += comestic.getPrice() * comestic.getQuantity();
            }
        }
        return totalPrice;
    }

}
