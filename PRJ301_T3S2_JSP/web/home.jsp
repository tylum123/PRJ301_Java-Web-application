<!DOCTYPE html>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Fshop Luxury Cosmetics</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">
        <link href="style/homepage.css" rel="stylesheet">
        <style>
            @font-face {
                font-family: 'MFont';
                src: url('font/KUNSTLER.TTF') format('truetype');
            }
        </style>
    </head>
    <body>
        <header class="py-3 bg-dark text-white">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-3 col-md-6 mb-2 mb-lg-0">
                        <form class="form-inline" action="MainController" method="POST">
                            <div class="input-group w-100">
                                <input type="text" class="form-control border-0 bg-light" name="search" value="${param.search}" placeholder="Search products">
                                <div class="input-group-append">
                                    <button class="btn btn-outline-light" type="submit" name="action" value="Shop">
                                        <i class="fas fa-search"></i>
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="col-lg-6 col-md-6 text-center mb-2 mb-lg-0">
                        <a href="#" class="text-decoration-none text-white">
                            <span class="h2">Fshop Luxury Cosmetics</span>
                        </a>
                    </div>
                    <div class="col-lg-3 col-md-12 text-lg-right">
                        <c:choose>
                            <c:when test="${empty LOGIN_USER}">
                                <a href="login.html" class="btn btn-outline-light mr-2">Login</a>
                            </c:when>
                            <c:otherwise>
                                <a href="MainController?action=Logout" class="btn btn-outline-light mr-2">Logout</a>
                            </c:otherwise>
                        </c:choose>
                        <a href="cart.jsp" class="btn btn-outline-light">
                            <i class="fas fa-shopping-cart"></i> Cart
                            <span class="badge badge-pill badge-danger">${CART.cart.size()}</span>
                        </a>
                    </div>
                </div>
            </div>
        </header>

        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container">
                <button class="navbar-toggler mx-auto" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item active">
                            <a class="nav-link" href="home.jsp">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="MainController?action=Shop">Shop</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="aboutUs.jsp">About Us</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="contact.html">Contact</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <main>
            <section class="hero-carousel">
                <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                    <ol class="carousel-indicators">
                        <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                        <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                        <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                    </ol>
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img src="img/decoration/eye-shadow-4558443_1280.jpg" class="d-block w-100" alt="Luxury Cosmetics">
                            <div class="carousel-caption d-none d-md-block">
                                <h5 style="color: #ebd197; font-family: 'MFont'">New Arrivals</h5>
                                <p>Discover the latest in beauty products.</p>
                                <a href="MainController?action=Shop" class="btn btn-outline-light">Shop Now</a>
                            </div>
                        </div>
                        <div class="carousel-item">
                            <img src="img/decoration/Untitled-4.jpg"  class="d-block w-100" alt="New Fashion">
                            <div class="carousel-caption d-none d-md-block">
                                <h5 style="color: #ebd197; font-family: 'MFont'">New Fashion</h5>
                                <p>Explore the newest trends in beauty.</p>
                                <a href="MainController?action=Shop "  class="btn btn-outline-light">Discover</a>
                            </div>
                        </div>
                        <div class="carousel-item">
                            <img src="img/decoration/makeup-2676392_1920.jpg" class="d-block w-100" alt="Join With Us">
                            <div class="carousel-caption d-none d-md-block">
                                <h5 style="color: #ebd197; font-family: 'MFont'">Join With Us</h5>
                                <p>Join our community for exclusive offers.</p>
                                <c:choose>
                                    <c:when test="${empty LOGIN_USER}">
                                        <a href="login.html" class="btn btn-outline-light">Join Now</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="MainController?action=Shop" class="btn btn-outline-light">Explore</a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <!-- Add more carousel items here -->
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
            </section>

            <section class="featured-products my-5">
                <div class="container">
                    <h2 class="text-center mb-4">Featured Products</h2>
                    <div class="row">
                        <!-- Add product cards here -->
                        <div class="col-md-4 mb-4">
                            <div class="card h-100">
                                <img src="img/decoration/Untitled-4.jpg" style="object-fit: fill" class="card-img-top" alt="Product 1">
                                <div class="card-body">
                                    <h5 class="card-title">Product 1</h5>
                                    <p class="card-text">Description of Product 1.</p>
                                    <a href="MainController?action=Shop" class="btn btn-primary">Buy Now</a>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4 mb-4">
                            <div class="card h-100">
                                <img src="img/decoration/eye-shadow-4558443_1280.jpg" style="object-fit: cover" class="card-img-top" alt="Product 1">
                                <div class="card-body">
                                    <h5 class="card-title">Product 1</h5>
                                    <p class="card-text">Description of Product 1.</p>
                                    <a href="MainController?action=Shop" class="btn btn-primary">Buy Now</a>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4 mb-4">
                            <div class="card h-100">
                                <img src="img/decoration/makeup-2676392_1920.jpg" class="card-img-top" alt="Product 1">
                                <div class="card-body">
                                    <h5 class="card-title">Product 1</h5>
                                    <p class="card-text">Description of Product 1.</p>
                                    <a href="MainController?action=Shop" class="btn btn-primary">Buy Now</a>
                                </div>
                            </div>
                        </div>

                        <!-- Add more product cards -->
                    </div>
                </div>
            </section>
        </main>

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
                            <li><i class="fas fa-envelope"></i> info@glamourcosmetics.com</li>
                            <li><i class="fas fa-map-marker-alt"></i> FPT University</li>
                        </ul>
                    </div>
                    <div class="col-md-4">
                        <h5>Follow Us</h5>
                        <a href="#" class="text-white mr-3"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="text-white mr-3"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-white mr-3"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="text-white"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
            </div>
        </footer>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
