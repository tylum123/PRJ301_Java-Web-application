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
import sample.user.UserDAO;
import sample.user.UserDTO;
import sample.user.UserError;

/**
 *
 * @author minhnguyen
 */
@WebServlet(name = "AddUserController", urlPatterns = {"/AddUserController"})
public class AddUserController extends HttpServlet {

    private static final String ERROR = "SearchController";
    private static final String SUCCESS = "SearchController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        UserError userError = new UserError();
        String url = ERROR;
        try {
            boolean checkValidation = true;
            UserDAO dao = new UserDAO();
            String userID = request.getParameter("userID");
            String fullName = request.getParameter("fullName");
            String roleID = request.getParameter("roleID");
            String password = request.getParameter("password");
            String confirm = request.getParameter("confirm");
            String statusString = request.getParameter("status");
            boolean status = "Active".equalsIgnoreCase(statusString);
            if (userID.length() < 2 || userID.length() > 10) {
                checkValidation = false;
                userError.setUserIDError("UserID must be in [2,10] characters");
            }
            if (fullName.length() < 3 || fullName.length() > 50) {
                checkValidation = false;
                userError.setFullNameError("Full Name must be in [3,50] characters");
            }
            if (!confirm.equals(password)) {
                checkValidation = false;
                userError.setConfirmError("The confirm password is not the same");
            }

            if (checkValidation) {
                boolean checkInsert = dao.insert(new UserDTO(userID, fullName, roleID, password, status,false,null,null,null));
                if (checkInsert) {
                    url = SUCCESS;
                } else {
                    userError.setError("Unknow error!");
                    request.setAttribute("USER_ERROR", userError);
                }
            } else {
                request.setAttribute("USER_ERROR", userError);
            }

        } catch (Exception e) {
            log("Error at CreateController: " + e.toString());
            if (e.toString().contains("duplicate")) {
                userError.setUserIDError("User ID has already exist !!!");
                request.setAttribute("USER_ERROR", userError);
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
