package sample.controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sample.comestic.Categories;
import sample.comestic.Comestic;
import sample.comestic.ProductDAO;

@WebServlet(name = "ShopController", urlPatterns = {"/ShopController"})
public class ShopController extends HttpServlet {

    private static final String ERROR = "shop.jsp";
    private static final String SUCCESS = "shop.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String url = ERROR;
        ProductDAO dao = new ProductDAO();
        try {
            String search = request.getParameter("search");
            if (search == null) {
                search = "";
            }

            List<Comestic> listProduct = dao.getListProduct2(search);
            List<Categories> listCategory = dao.getListCategory();

            if (listProduct.size() > 0) {
                request.setAttribute("LIST_PRODUCT", listProduct);
                request.setAttribute("LIST_CATEGORY", listCategory);
                url = SUCCESS;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
