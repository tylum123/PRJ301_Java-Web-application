<%-- 
    Document   : shop
    Created on : Jul 7, 2024, 12:24:44 AM
    Author     : minhnguyen
--%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Fshop Luxury Cosmetics</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Roboto', sans-serif;
            }
            .navbar {
                background: linear-gradient(to right, #040404, #000000, #656565);
            }
            .sidebar {
                background: #f8f9fa;
                padding: 15px;
                border-radius: 5px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            .sidebar a {
                display: block;
                padding: 10px;
                color: #333;
                font-weight: 500;
                border-radius: 4px;
                transition: background 0.3s, color 0.3s;
            }
            .sidebar a:hover {
                background: #007bff;
                color: #fff;
            }
            .navbar-avatar {
                border-radius: 50%;
                width: 30px;
                height: 30px;
            }
            .search-bar {
                display: flex;
                justify-content: center;
                padding: 10px;
                margin-bottom: 20px;
            }
            .search-bar input {
                width: 100%;
                border-radius: 30px 0 0 30px;
            }
            .search-bar button {
                border-radius: 0 30px 30px 0;
            }
            .card {
                transition: transform 0.3s;
            }
            .card:hover {
                transform: scale(1.05);
            }
            footer h5 {
                font-size: 1.25rem;
                margin-bottom: 1rem;
                color: #ffd700;
            }
            footer ul {
                padding-left: 0;
                list-style: none;
            }
            footer ul li {
                margin-bottom: 0.5rem;
                font-size: 1.1rem;
            }
            footer a {
                color: #e0e0e0;
                text-decoration: none;
                transition: color 0.3s ease;
            }
            footer a:hover {
                color: #ffd700;
            }
            footer a i {
                transition: transform 0.3s;
            }
            footer a:hover i {
                transform: scale(1.2);
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark">
            <div class="container">
                <a class="navbar-brand" href="#" style="font-family: 'Roboto', sans-serif; font-size: 24px; font-weight: bold;">Fshop Luxury Cosmetics</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="home.jsp"><i class="fas fa-home"></i> Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="user.jsp"><i class="fas fa-info-circle"></i> About</a>
                        </li>
                        <li class="nav-item">
                            <c:choose>
                                <c:when test="${LOGIN_USER.isSale==true}">
                                    <a class="nav-link" href="SellerProductController"><i class="fas fa-box"></i> Manage Product</a>
                                </c:when>
                                <c:otherwise>
                                    <a class="nav-link" href="contact.html"><i class="fas fa-concierge-bell"></i> Services</a>
                                </c:otherwise>
                            </c:choose>                         
                        </li>
                        <li class="nav-item">
                            <c:choose>
                                <c:when test="${empty LOGIN_USER}">
                                    <a class="nav-link" href="login.html"><i class="fas fa-user"></i> Login</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="MainController?action=Logout" class="nav-link"> <i class="fas fa-sign-out-alt"></i>Logout</a>
                                </c:otherwise>
                            </c:choose>

                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="cart.jsp">
                                <i class="fas fa-shopping-cart"></i> Cart
                                <span class="badge badge-pill badge-danger">${CART.cart.size()}</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container mt-4">
            <form action="MainController" method="POST">
                <div class="search-bar">
                    <input type="text" class="form-control" value="${param.search}" name="search" placeholder="Search for products...">
                    <button type="submit" class="btn btn-primary" name="action" value="Shop">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </form>
            <div class="row">
                <div class="col-lg-3">
                    <div class="sidebar">
                        <h4 class="mb-4">Categories</h4>
                        <c:forEach var="cate" items="${LIST_CATEGORY}">
                            <a href="FindProductByCategory?categoryID=${cate.categoryID}">
                                ${cate.categoryName}
                            </a>
                        </c:forEach>
                    </div>
                </div>
                <div class="col-lg-9">
                    <div id="carouselExampleIndicators" class="carousel slide mb-4" data-ride="carousel">
                        <ol class="carousel-indicators">
                            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                            <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                            <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                        </ol>
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img class="d-block w-100" src="img/decoration/manicure-870857_1280.jpg" alt="First slide">
                            </div>
                            <div class="carousel-item">
                                <img class="d-block w-100" src="img/decoration/lipstick-2585174_1280.jpg" alt="Second slide">
                            </div>
                            <div class="carousel-item">
                                <img class="d-block w-100" src="img/decoration/cosmetics-1063134_1280.jpg" alt="Third slide">
                            </div>
                        </div>
                        <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>

                    <c:if var="mess" test="${empty MESSAGE}">
                        ${mess=""}
                    </c:if>
                    <c:out value="${MESSAGE}"></c:out>

                        <div class="row">
                        <c:forEach items="${LIST_PRODUCT}" var="list">
                            <c:if test="${list.status}">
                                <div class="col-lg-4 col-md-6 mb-4">
                                    <div class="card h-100">
                                        <img class="card-img-top" src="img/products/${list.image}" style="width: 100%; height: 180px; object-fit: fill;" alt="">
                                        <div class="card-body">
                                            <h4 class="card-title">
                                                <a href="#">${list.productName}</a>
                                            </h4>
                                            <h5>$ ${list.price}</h5>
                                            <p class="card-text">${list.description}</p>
                                            <p class="card-text">
                                                <c:choose>
                                                    <c:when test="${list.quantity > 0}">
                                                        Quantity: ${list.quantity}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-danger">Out of Stock</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                        <div class="card-footer d-flex justify-content-center">
                                            <form action="MainController" method="POST">
                                                <input type="hidden" name="cmbComestic" value="${list.productID}-${list.productName}-${list.price}-${list.status}-${list.image}-${list.description}-${list.categoryID}-${list.saleID}">
                                                <input type="hidden" name="cmbQuantity" value="1">
                                                <c:if test="${list.quantity > 0}">
                                                    <c:if test="${not empty LOGIN_USER}">
                                                        <button type="submit" name="action" value="Add" class="btn btn-primary">Add to cart</button>
                                                    </c:if>
                                                    <c:if test="${empty LOGIN_USER}">
                                                        <button type="submit" name="action" value="Login" class="btn btn-primary">Add to cart</button>
                                                    </c:if>
                                                </c:if>
                                                <c:if test="${list.quantity == 0}">
                                                    <button type="button" class="btn btn-secondary" disabled>Out of Stock</button>
                                                </c:if>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

        <footer class="bg-dark text-white py-4">
            <div class="container">
                <div class="row">
                    <div class="col-md-4">
                        <h5>About Us</h5>
                        <p>We are dedicated to providing the best beauty products and services to our customers.</p>
                    </div>
                    <div class="col-md-4">
                        <h5>Contact</h5>
                        <ul class="list-unstyled">
                            <li><i class="fas fa-phone"></i> +123 456 7890</li>
                            <li><i class="fas fa-envelope"></i> info@fshopluxurycosmetics.com</li>
                            <li><i class="fas fa-map-marker-alt"></i> FPT University</li>
                        </ul>
                    </div>
                    <div class="col-md-4">
                        <h5>Follow Us</h5>
                        <div>
                            <a href="#" class="text-white mr-3"><i class="fab fa-facebook-f fa-2x"></i></a>
                            <a href="#" class="text-white mr-3"><i class="fab fa-twitter fa-2x"></i></a>
                            <a href="#" class="text-white mr-3"><i class="fab fa-instagram fa-2x"></i></a>
                            <a href="#" class="text-white"><i class="fab fa-linkedin-in fa-2x"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </footer>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
