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
import sample.user.UserDAO;

@WebServlet("/UploadFileServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class UploadFileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String PROJECT_PATH = "C:\\Users\\MyPC\\OneDrive\\Máy tính\\PRJ301\\PRJ301lesson\\PRJ301_T3S2_JSP\\web";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        // Extract user information from request
        String userID = request.getParameter("userID");
        String fullName = request.getParameter("fullName");
        String roleID = request.getParameter("roleID");
        String picture = request.getParameter("picture");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String uploadDir = request.getParameter("uploadDir");

        // Validate upload directory
        if (uploadDir == null || (!uploadDir.equals("users") && !uploadDir.equals("products"))) {
            request.setAttribute("message", "Invalid upload directory specified.");
            getServletContext().getRequestDispatcher("/user.jsp").forward(request, response);
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
            picture = fileName;
        }

        // Mock database update - replace this with actual database update code
        try {
            UserDAO dao = new UserDAO();
            dao.updateInfo(userID, fullName, roleID, true, false, picture, address, email);
        } catch (Exception e) {
        } finally {
            request.setAttribute("message", "User information and file upload successful!");
            getServletContext().getRequestDispatcher("/user.jsp").forward(request, response);
        }
    }

    /**
     * Extracts file name from HTTP header content-disposition
     */
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

    /**
     * Mock method to update user information - replace with actual database
     * update logic
     */
}
