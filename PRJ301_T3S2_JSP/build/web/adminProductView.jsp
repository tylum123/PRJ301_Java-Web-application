<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Product View Page</title>
        <link rel="stylesheet" type="text/css" href="style/styleProductView.css">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
        <script>
            function editProduct(productID, productName, quantity, price, status, description, categoryID, image, saleID) {
                document.getElementById('editForm').style.display = 'block'; // Hiển thị form
                document.getElementById('editProductID').value = productID;
                document.getElementById('editProductName').value = productName;
                document.getElementById('editQuantity').value = quantity;
                document.getElementById('editPrice').value = price;
                document.getElementById('editStatus').value = status;
                document.getElementById('editDescription').value = description;
                document.getElementById('editCategoryID').value = categoryID;
                document.getElementById('editImage').value = image;
                document.getElementById('editSaleID').value = saleID;
            }
            function cancelEdit() {
                document.getElementById('editForm').style.display = 'none';
            }
            function updateFileName() {
                var fileInput = document.getElementById('file');
                var pictureInput = document.getElementById('editPicture');
                var fileName = fileInput.files[0].name;
                pictureInput.value = fileName;
            }
        </script>
        <style>
            .responsive-image {
                max-width: 200px;
                height: 200px;
            }
            .image-container {
                width: 200px;
                height: 200px;
                overflow: hidden;
                position: relative;
            }
            .image-container img {
                width: 100%;
                height: 100%;
                object-fit: fill;
            }
        </style>
    </head>
    <body>
        <c:set var="err" value="${requestScope.ERROR_MESS != null ? requestScope.ERROR_MESS : ''}" />
        <header>
            <nav class="navbar navbar-expand-lg navbar-dark">
                <div class="container-fluid">
                    <a class="navbar-brand" style="font-family: Verdana;" href="#"><c:out value="${sessionScope.LOGIN_USER.fullName}"/></a>
                    <div class="avatar-container">
                        <c:if test="${not empty sessionScope.LOGIN_USER.picture}">
                            <img src="img/users/<c:out value="${sessionScope.LOGIN_USER.picture}"/>" class="avatar" alt="User Avatar">
                        </c:if>
                        <c:if test="${empty sessionScope.LOGIN_USER.picture}">
                            <div class="avatar-placeholder">
                                <i class="fa fa-user"></i>
                            </div>
                        </c:if>
                    </div>
                    <form action="MainController" method="POST">
                        <div class="input-group parent">
                            <input type="text" class="form-control" id="input" name="search" value="${param.search}" placeholder="Search..." />
                            <button class="btn btn-outline-secondary border-0" id="button" type="submit" name="action" value="Find_Product">
                                <i class="fa fa-search"></i>
                            </button>
                        </div>
                    </form>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav ms-auto">
                            <li class="nav-item">
                                <a class="nav-link " href="MainController?action=Search">
                                    <i class="fa fa-home"></i> Home
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link active"  aria-current="page" href="MainController?action=Find_Product">
                                    <i class="fa fa-star"></i> Product
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="sendEmail.jsp">
                                    <i class="fa fa-envelope"></i> Contact
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="home.jsp">
                                    <i class="fa fa-home"></i> HOME PAGE
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="MainController?action=LOGOUT">
                                    <i class="fa fa-sign-out"></i> Logout
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>

        <div class="container-fluid" id="view">
            <div id='welcome'>
                <h1 class="text-primary"> Welcome to Admin Product Management Page</h1>
            </div>
            <div class="container" id="table-view">
                <h2 class="text-success">Product Management</h2>
                <div class="productManagement">
                    <c:if test="${not empty requestScope.LIST_PRODUCT}">
                        <table class="">
                            <thead class="">
                                <tr>
                                    <th>No</th>
                                    <th>Product ID</th>
                                    <th>Product Name</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                    <th>Status</th>
                                    <th>Description</th>
                                    <th>CategoryID</th>
                                    <th>SaleID</th>
                                    <th>Image</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="product" items="${requestScope.LIST_PRODUCT}" varStatus="status">
                                    <tr>
                                        <td style="width: 5%">${status.index + 1}</td>
                                        <td style="width: 10%">${product.productID}</td>
                                        <td style="width: 10%">${product.productName}</td>
                                        <td style="width: 10%">${product.quantity}</td>
                                        <td style="width: 10%">${product.price}$</td>
                                        <td style="width: 10%">${product.status ? 'Active' : 'Inactive'}</td>
                                        <td style="width: 10%">${product.description}</td>
                                        <td style="width: 10%">${product.categoryID}</td>
                                        <td style="width: 10%">${product.saleID}</td>
                                        <td style="width: 15%">
                                            <div class="image-container">
                                                <img src="img/products/${product.image}" alt="Products"/>
                                            </div>
                                        </td>
                                        <td style="width: 10%">
                                            <button class="btn btn-warning" onclick="editProduct('${product.productID}', '${product.productName}', '${product.quantity}', '${product.price}', '${product.status ? 'Active' : 'Inactive'}', '${product.description}', '${product.categoryID}', '${product.image}', '${product.saleID}')"><i class='fa fa-edit'></i></button>
                                            <a href="MainController?action=Delete_Product&productID=${product.productID}&search=${param.search}" class="btn btn-danger"><i class='fa fa-trash-o'></i></a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <p style="color: red; text-align: right;">${err}</p>
                    </c:if>
                    <!--When the page is empty this announcement will appear -->
                    <c:if test="${empty requestScope.LIST_PRODUCT}">
                        <p style="text-align: center; color: red">No products found.</p>
                    </c:if>
                    <!--Paging is here -->
                    <div style="width: 100%;" class="text-center">
                        <nav aria-label="Page navigation example">
                            <ul class="pagination justify-content-center">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="MainController?action=Find_Product&index=${currentPage - 1}&search=${param.search}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo; Previous</span>
                                        </a>
                                    </li>
                                </c:if>
                                <c:forEach begin="1" end="${endp}" var="i">
                                    <li class="page-item <c:if test='${i == currentPage}'>active</c:if>">
                                        <a class="page-link" href="MainController?action=Find_Product&index=${i}&search=${param.search}">${i}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${currentPage < endp}">
                                    <li class="page-item">
                                        <a class="page-link" href="MainController?action=Find_Product&index=${currentPage + 1}&search=${param.search}" aria-label="Next">
                                            <span aria-hidden="true">Next &raquo;</span>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>
                    <div class="show-button">
                        <button style="display: flex; justify-content: center" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addProductModal">
                            <i class="fa fa-plus-circle"></i> Add New Product
                        </button>
                    </div>

                    <!-- Edit is here-->
                    <div class="modal" id="editForm">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title">Edit Product Information</h4>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body">
                                    <form action="UpdateProductController" method="POST" enctype="multipart/form-data">
                                        <label for="editProductID" class="form-label">Product ID</label>
                                        <input type="text" id="editProductID" name="productID" readonly="">
                                        <div class="mb-3">
                                            <label for="editProductName" class="form-label">Product Name</label>
                                            <input type="text" class="form-control" id="editProductName" name="productName" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="editQuantity" class="form-label">Quantity</label>
                                            <input type="number" class="form-control" id="editQuantity" name="quantity" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="editPrice" class="form-label">Price</label>
                                            <input type="number" class="form-control" id="editPrice" name="price" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="editStatus" class="form-label">Status</label>
                                            <select class="form-select" id="editStatus" name="status" required>
                                                <option value="Active">Active</option>
                                                <option value="Inactive">Inactive</option>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label for="editDescription" class="form-label">Description</label>
                                            <textarea class="form-control" id="editDescription" name="description" required></textarea>
                                        </div>
                                        <div class="mb-3">
                                            <label for="editCategoryID" class="form-label">Category ID</label>
                                            <select name="categoryID" id="editCategoryID" class="form-select">
                                                <c:forEach var="listC" items="${LIST_CATEGORY}">
                                                    <option value="${listC.categoryID}">${listC.categoryName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label for="editImage" class="form-label">Image</label>
                                            <input type="text" class="form-control" name="image" id="editImage" required />
                                            <label for="uploadDir">Choose upload directory:</label>
                                            <select name="uploadDir" id="uploadDir">
                                                <option value="products">Products</option>
                                            </select>
                                            <br><br>

                                            <label for="file">Select file:</label>
                                            <input type="file" name="file" id="file" onchange="updateFileName()">
                                            <br><br>
                                            <script>
                                                function updateFileName() {
                                                    var fileInput = document.getElementById('file');
                                                    var pictureInput = document.getElementById('editImage');
                                                    var fileName = fileInput.files[0].name;
                                                    pictureInput.value = fileName;
                                                }
                                            </script>
                                        </div>
                                        <div class="mb-3">
                                            <label for="editSaleID" class="form-label">Sale ID</label>
                                            <input type="text" class="form-control" id="editSaleID" name="saleID" required>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="submit" name="action" class="btn btn-success">Update</button>
                                            <button type="button" class="btn btn-danger" onclick="cancelEdit()">Cancel</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal -->
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
                                <input type="text" class="form-control" id="productID" name="productID" required>
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
                                <label for="status" class="form-label">Status</label>
                                <select class="form-select" id="status" name="status" required>
                                    <option value="true">Active</option>
                                    <option value="false">Inactive</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="description" class="form-label">Description</label>
                                <textarea class="form-control" id="description" name="description" required></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="categoryID" class="form-label">Category ID</label>
                                <input type="text" class="form-control" id="categoryID" name="categoryID" required>
                            </div>
                            <div class="mb-3">
                                <label for="saleID" class="form-label">Sale ID</label>
                                <input type="text" class="form-control" id="saleID" name="saleID" required>
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
    </body>
</html>
