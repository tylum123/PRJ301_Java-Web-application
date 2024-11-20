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

@WebServlet(name = "FindProductController", urlPatterns = {"/FindProductController"})
public class FindProductController extends HttpServlet {

    private static final String ERROR = "adminProductView.jsp";
    private static final String SUCCESS = "adminProductView.jsp";

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

            String indexPage = request.getParameter("index");
            if (indexPage == null) {
                indexPage = "1";
            }
            int index = Integer.parseInt(indexPage);

            int count = dao.totalProduct(search);
            int endpage = count / 3;
            if (count % 3 != 0) {
                endpage++;
            }

            List<Comestic> listProduct = dao.getListProduct(search, index);
            List<Categories> listCategory = dao.getListCategory();

            if (listProduct.size() > 0) {
                request.setAttribute("LIST_PRODUCT", listProduct);
                request.setAttribute("LIST_CATEGORY", listCategory);
                request.setAttribute("endp", endpage);
                request.setAttribute("currentPage", index);
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
