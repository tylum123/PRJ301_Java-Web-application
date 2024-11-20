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
import sample.comestic.ProductDAO;
import sample.orders.OrderDAO;
import sample.user.UserDTO;

/**
 *
 * @author minhnguyen
 */
@WebServlet(name = "OrderController", urlPatterns = {"/OrderController"})
public class OrderController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("CART");
        UserDTO login = (UserDTO) session.getAttribute("LOGIN_USER");

        if ("checkout".equals(action)) {
            try {
                // Lưu thông tin hóa đơn
                OrderDAO orderDAO = new OrderDAO();
                String orderId = orderDAO.saveOrder(cart, login.getUserID());
                if(orderId == null){
                    response.sendRedirect("error.jsp");
                }

                // Cập nhật số lượng sản phẩm
                ProductDAO productDAO = new ProductDAO();
                for (Comestic item : cart.getCart().values()) {
                    productDAO.updateProductQuantity(item.getProductID(), item.getQuantity());
                }

                // Xóa giỏ hàng sau khi thanh toán
                session.removeAttribute("CART");

                // Chuyển hướng đến trang xác nhận
                response.sendRedirect("orderConfirmation.jsp?orderId=" + orderId);
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp");
            }
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
