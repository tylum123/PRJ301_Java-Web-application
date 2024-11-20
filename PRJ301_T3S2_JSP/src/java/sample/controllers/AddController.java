/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.comestic.Cart;
import sample.comestic.Comestic;

/**
 *
 * @author minhnguyen
 */
@WebServlet(name = "AddController", urlPatterns = {"/AddController"})
public class AddController extends HttpServlet {

    private static final String ERROR = "ShopController";
    private static final String SUCCESS = "ShopController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String url = ERROR;
        try {
            String cmbComestic = request.getParameter("cmbComestic");
            String tmp[] = cmbComestic.split("-");
            String id = tmp[0];
            String name = tmp[1];
            float price = Float.parseFloat(tmp[2]);
            int quantity = Integer.parseInt(request.getParameter("cmbQuantity"));
            boolean status = Boolean.parseBoolean(tmp[3]);
            String image = tmp[4];
            String description = tmp[5];
            String categoryID = tmp[6];
            String saleID = tmp[7];
            Comestic comestic = new Comestic(id, name, quantity, price, status, image, description, categoryID, saleID);
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("CART");
            if (cart == null) {
                cart = new Cart();
            }
            boolean checkAdd = cart.add(comestic);
            if (checkAdd) {
                session.setAttribute("CART", cart);
                request.setAttribute("MESSAGE", " ADDED SUCCESSFULLY " + name);
                url = SUCCESS;
            }
        } catch (Exception e) {
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
