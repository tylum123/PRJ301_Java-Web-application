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
import sample.comestic.Comestic;
import sample.comestic.ComesticError;
import sample.comestic.ProductDAO;

/**
 *
 * @author minhnguyen
 */
@WebServlet(name = "AddProductController", urlPatterns = {"/AddProductController"})
public class AddProductController extends HttpServlet {

    private static final String ERROR = "adminProductView.jsp";
    private static final String SUCCESS = "FindProductController";
    private static final long serialVersionUID = 1L;
    private static final String PROJECT_PATH = "C:\\Users\\MyPC\\OneDrive\\Máy tính\\PRJ301\\PRJ301lesson\\PRJ301_T3S2_JSP\\web";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String url = ERROR;
        ComesticError err = new ComesticError();
        try {
            boolean checkValidation = true;
            ProductDAO dao = new ProductDAO();
            String productID = request.getParameter("productID");
            String productName = request.getParameter("productName");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            float price = Float.parseFloat(request.getParameter("price"));
            String statusString = request.getParameter("status");
            boolean status = "Active".equalsIgnoreCase(statusString);
            String image = request.getParameter("image");
            String description = request.getParameter("description");
            String categoryID = request.getParameter("categoryID");
            String saleID = request.getParameter("saleID");
            if (!productID.matches("^P\\d{3}$")) {
                checkValidation = false;
                err.setProductIDError("The Product ID must follow the type {P/3digits}! ex:P001 ");
            }
            if (productName.length() < 4 || productName.length() > 50) {
                checkValidation = false;
                err.setProductNameError("Product Name must be in [4,50] characters");
            }
            if (quantity < 0) {
                checkValidation = false;
                err.setQuantityError("Product quantity can not below 0 !!");
            }
            if (price < 0) {
                checkValidation = false;
                err.setPriceError("Product price must had the minimum value is 1000");
            }
            if (!categoryID.matches("^CAT\\d{3}$")) {
                checkValidation = false;
            }
            if (checkValidation) {
                boolean checkInsert = dao.insertProduct(new Comestic(productID, productName, quantity, price, status, image, description, categoryID, saleID));
                if (checkInsert) {
                    url = SUCCESS;
                } else {
                    request.setAttribute("PRODUCT_ERROR", err);
                }
            } else {
                request.setAttribute("PRODUCT_ERROR", err);
            }
        } catch (Exception e) {
            log("Error at AddProductController " + e.toString());
            if (e.toString().contains("duplicate")) {
                err.setProductIDError("Product ID has already exist !!!");
                request.setAttribute("PRODUCT_ERROR", err);
            }
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
