<%-- 
    Document   : sellerPage
    Created on : Jul 8, 2024, 3:29:57 PM
    Author     : minhnguyen
--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Product Management</title>
        <link rel="stylesheet" type="text/css" href="style/styleProductView.css">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
        <style>
            .image-container {
                width: 100px;
                height: 100px;
                overflow: hidden;
            }
            .image-container img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
        </style>
    </head>
    <body>
        <c:set var="err" value="${requestScope.ERROR_MESS != null ? requestScope.ERROR_MESS : ''}" />
        <header>
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                <div class="container-fluid">
                    <a class="navbar-brand" href="#"><c:out value="${sessionScope.LOGIN_USER.fullName}"/></a>
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="home.jsp">
                                <i class="fa fa-home"></i> Home
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="MainController?action=LOGOUT">
                                <i class="fa fa-sign-out"></i> Logout
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>
        </header>

        <div class="container mt-4">
            <h2>User Product Management</h2>
            <c:if test="${not empty requestScope.LIST_PRODUCT}">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Product ID</th>
                            <th>Product Name</th>
                            <th>Quantity</th>
                            <th>Price</th>
                            <th>Image</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="product" items="${requestScope.LIST_PRODUCT}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${product.productID}</td>
                                <td>${product.productName}</td>
                                <td>${product.quantity}</td>
                                <td>${product.price}$</td>
                                <td>
                                    <div class="image-container">
                                        <img src="img/products/${product.image}" alt="Product Image"/>
                                    </div>
                                </td>
                                <td><a href="DeleteBySeller?userID${sessionScope.LOGIN_USER.userID}" class="btn btn-danger"><i class='fa fa-trash-o'></i></a></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <p class="text-danger text-end">${err}</p>
            </c:if>
            <c:if test="${empty requestScope.LIST_PRODUCT}">
                <p class="text-center text-danger">No products found.</p>
            </c:if>
            <div class="text-center mt-4">
                <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addProductModal">
                    <i class="fa fa-plus-circle"></i> Add New Product
                </button>
            </div>
            <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addProductModalLabel">Add New Product</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="MainController" method="POST">
                                <div class="mb-3">
                                    <label for="productID" class="form-label">Product ID</label>
                                    <input type="text" class="form-control" id="productName" name="productID" required>
                                </div>
                                <div class="mb-3">
                                    <label for="productName" class="form-label">Product Name</label>
                                    <input type="text" class="form-control" id="productName" name="productName" required>
                                </div>
                                <div class="mb-3">
                                    <label for="quantity" class="form-label">Quantity</label>
                                    <input type="number" class="form-control" id="quantity" name="quantity" required>
                                </div>
                                <div class="mb-3">
                                    <label for="price" class="form-label">Price</label>
                                    <input type="number" class="form-control" id="price" name="price" required>
                                </div>
                                <div class="mb-3">
                                    <label for="description" class="form-label">Description</label>
                                    <textarea class="form-control" id="description" name="description" required></textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="categoryID" class="form-label">Category ID</label>
                                    <select name="categoryID" class="form-control" id="categoryID">
                                        <c:forEach items="${LIST_CATEGORY}" var="cate">
                                            <option value="${cate.categoryID}"> ${cate.categoryName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="saleID" class="form-label">Sale ID</label>
                                    <input type="text" class="form-control" id="saleID" value="${LOGIN_USER.userID}" name="saleID" readonly="">
                                </div>
                                <div class="modal-footer">
                                    <button type="submit" name="action" value="Add_Product" class="btn btn-success">Add Product</button>
                                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancel</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
