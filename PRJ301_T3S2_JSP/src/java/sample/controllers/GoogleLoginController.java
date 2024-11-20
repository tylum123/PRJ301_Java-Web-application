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
import sample.user.UserDAO;
import sample.user.UserDTO;
import sample.user.UserGoogleDTO;
import sample.utils.LoginGoogleHander;

/**
 *
 * @author Admin
 */
@WebServlet(name = "GoogleLoginController", urlPatterns = {"/GoogleLoginController"})
public class GoogleLoginController extends HttpServlet {

    private static final String ERROR = "login.html";
    private static final String US = "US";
    private static final String AD = "AD";
    private static final String USER_PAGE = "user.jsp";
    private static final String ADMIN_PAGE = "SearchController";
    private static final String ERROR_MESSAGE = "Your role is not support";
    private static final String ERROR_GOOGLE_MESSAGER = "access_denied";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String url = ERROR;
        HttpSession session = request.getSession();
        String code = request.getParameter("code");
        if (code != null) {
            String accessToken = LoginGoogleHander.getToken(code);
            UserGoogleDTO acc = LoginGoogleHander.getUserInfo(accessToken);

            try {
                UserDAO dao = new UserDAO();

                String userID = acc.getEmail();
                String password = acc.getId();
                UserDTO loginUser = dao.checkLogin(userID, password);
                // phan quyen o day ne
                if (loginUser == null) {
                    dao.insert(new UserDTO(userID, acc.getName(), "US", password, true, false, null, null, acc.getEmail()));
                    session.setAttribute("LOGIN_USER", loginUser);
                    url = USER_PAGE;
                } else {
                    session.setAttribute("LOGIN_USER", loginUser);
                    String roleID = loginUser.getRoleID();
                    if (AD.equals(roleID)) {
                        url = ADMIN_PAGE;
                    } else if (US.equals(roleID)) {
                        url = USER_PAGE;
                    } else {
                        request.setAttribute("ERROR", ERROR_MESSAGE);
                    }
                }
            } catch (Exception e) {
                log("ERROR at Login Controler" + e.toString());
            }
        }
        request.getRequestDispatcher(url).forward(request, response);
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
