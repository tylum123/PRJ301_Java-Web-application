/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import sample.comestic.ProductDAO;

/**
 *
 * @author minhnguyen
 */
@WebServlet(name = "UpdateProductController", urlPatterns = {"/UpdateProductController"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class UpdateProductController extends HttpServlet {

    private static final String ERROR = "FindProductController";
    private static final String SUCCESS = "FindProductController";
    private static final long serialVersionUID = 1L;
    private static final String PROJECT_PATH = "C:\\Users\\MyPC\\OneDrive\\Máy tính\\PRJ301\\PRJ301lesson\\PRJ301_T3S2_JSP\\web";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String url = ERROR;
        try {
            String productID = request.getParameter("productID");
            String productName = request.getParameter("productName");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            float price = Float.parseFloat(request.getParameter("price"));
            String statusStr = request.getParameter("status");
            boolean status = "Active".equalsIgnoreCase(statusStr);
            String image = request.getParameter("image");
            String description = request.getParameter("description");
            String categoryID = request.getParameter("categoryID");
            String saleID = request.getParameter("saleID");
            String uploadDir = request.getParameter("uploadDir");

            if (uploadDir == null || (!uploadDir.equals("users") && !uploadDir.equals("products"))) {
                request.setAttribute("message", "Invalid upload directory specified.");
                getServletContext().getRequestDispatcher("/home.jsp").forward(request, response);
                return;
            }

            // Process file upload
            String fileName = null;
            for (Part part : request.getParts()) {
                if (part.getName().equals("file") && part.getSize() > 0) {
                    fileName = extractFileName(part);
                    if (fileName != null && !fileName.isEmpty()) {
                        // Refines the fileName in case it is an absolute path
                        fileName = new File(fileName).getName();
                        part.write(this.getFolderUpload(uploadDir).getAbsolutePath() + File.separator + fileName);
                    }
                }
            }

            // If a new file was uploaded, update the picture field with the new file name
            if (fileName != null) {
                image = fileName;
            }

            ProductDAO dao = new ProductDAO();
            boolean check = dao.updateProduct(productID, productName, quantity, price, status, image, description, categoryID, saleID);
            if (check == true) {
                url = SUCCESS;
                request.setAttribute("ERROR_MESS", "Update Successfully");
            } else {
                request.setAttribute("ERROR_MESS", "Update Fail");
            }
        } catch (Exception e) {
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }

    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }

    public File getFolderUpload(String uploadDir) {
        File folderUpload = new File(PROJECT_PATH + File.separator + "img" + File.separator + uploadDir);
        if (!folderUpload.exists()) {
            folderUpload.mkdirs();
        }
        return folderUpload;
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
