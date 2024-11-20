<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta http-equiv="x-ua-compatible" content="ie=edge" />
        <title>Cart</title>
        <!-- MDB icon -->
        <link rel="icon" href="img/mdb-favicon.ico" type="image/x-icon" />
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.2/css/all.css" />
        <!-- Google Fonts Roboto -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700;900&display=swap" />
        <!-- MDB -->
        <link rel="stylesheet" href="style/bootstrap-shopping-carts.min.css" />
    </head>

    <body>
        <!-- Start your project here-->
        <style>
            @media (min-width: 1025px) {
                .h-custom {
                    height: 100vh !important;
                }
            }

            .card-registration .select-input.form-control[readonly]:not([disabled]) {
                font-size: 1rem;
                line-height: 2.15;
                padding-left: .75em;
                padding-right: .75em;
            }

            .card-registration .select-arrow {
                top: 13px;
            }

            .bg-grey {
                background-color: #eae8e8;
            }

            @media (min-width: 992px) {
                .card-registration-2 .bg-grey {
                    border-top-right-radius: 16px;
                    border-bottom-right-radius: 16px;
                }
            }

            @media (max-width: 991px) {
                .card-registration-2 .bg-grey {
                    border-bottom-left-radius: 16px;
                    border-bottom-right-radius: 16px;
                }
            }
        </style>
        <section class="h-100 h-custom" style="background-color: #d2c9ff;">
            <div class="container py-5 h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-12">
                        <div class="card card-registration card-registration-2" style="border-radius: 15px;">
                            <div class="card-body p-0">
                                <div class="row g-0">
                                    <div class="col-lg-8">
                                        <div class="p-5">
                                            <div class="d-flex justify-content-between align-items-center mb-5">
                                                <h1 class="fw-bold mb-0 text-black">Shopping Cart</h1>
                                                <h6 class="mb-0 text-muted">items <c:out value="${fn:length(CART.cart)}" /></h6>
                                            </div>
                                            <hr class="my-4">

                                            <c:if test="${empty CART.cart.values()}">
                                                <h3>
                                                    Your cart is Empty !!
                                                </h3>
                                            </c:if>


                                            <c:forEach var="comestic" items="${CART.cart.values()}">
                                                <div class="row mb-4 d-flex justify-content-between align-items-center">
                                                    <div class="col-md-2 col-lg-2 col-xl-2">
                                                        <img src="img/products/${comestic.image}" class="img-fluid rounded-3" alt="${comestic.productName}">
                                                    </div>
                                                    <div class="col-md-3 col-lg-3 col-xl-3">
                                                        <h6 class="text-muted">${comestic.productName}</h6>
                                                        <h6 class="text-black mb-0">${comestic.description}</h6>
                                                    </div>
                                                    <div class="col-md-3 col-lg-3 col-xl-2 d-flex">
                                                        <a class="btn btn-link px-2" onclick="changeQuantity(this, -1)">
                                                            <i class="fas fa-minus"></i>
                                                        </a>

                                                        <input id="form1" min="1" name="quantity" value="${comestic.quantity}" type="number"
                                                               class="form-control form-control-sm" data-product-id="${comestic.productID}" onchange="updateLink(this)" />

                                                        <a class="btn btn-link px-2" onclick="changeQuantity(this, 1)">
                                                            <i class="fas fa-plus"></i>
                                                        </a>
                                                    </div>
                                                    <div class="col-md-3 col-lg-2 col-xl-2 offset-lg-1">
                                                        <h6 class="mb-0">${comestic.price} $</h6>
                                                    </div>
                                                    <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                                                        <a href="MainController?action=Remove&id=${comestic.productID}" class="text-muted"><i class="fas fa-times"></i></a>
                                                    </div>
                                                    <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                                                        <a id="update-link-${comestic.productID}" href="MainController?action=Edit&id=${comestic.productID}&quantity=${comestic.quantity}" class="text-muted"><i class="fas fa-check"></i></a>
                                                    </div>
                                                </div>
                                            </c:forEach>

                                            <script>
                                                function changeQuantity(element, step) {
                                                    var input = element.parentNode.querySelector('input[type=number]');
                                                    if (input) {
                                                        var newQuantity = parseInt(input.value) + step;
                                                        if (newQuantity > 0) {
                                                            input.value = newQuantity;
                                                            updateLink(input);
                                                        }
                                                    }
                                                }

                                                function updateLink(input) {
                                                    var productId = input.getAttribute('data-product-id');
                                                    var quantity = input.value;
                                                    var updateLink = document.getElementById('update-link-' + productId);
                                                    if (updateLink) {
                                                        updateLink.href = 'MainController?action=Edit&id=' + productId + '&quantity=' + quantity;
                                                    }
                                                }
                                            </script>

                                            <hr class="my-4">

                                            <div class="pt-5">
                                                <h6 class="mb-0"><a href="MainController?action=Shop" class="text-body"><i
                                                            class="fas fa-long-arrow-alt-left me-2"></i>Back to shop</a></h6>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 bg-grey">
                                        <div class="p-5">
                                            <h3 class="fw-bold mb-5 mt-2 pt-1">Summary</h3>
                                            <hr class="my-4">

                                            <c:set var="totalPrice" value="0" />
                                            <c:forEach var="product" items="${CART.cart.values()}">
                                                <c:set var="lineTotal" value="${product.quantity * product.price}" />
                                                <c:set var="totalPrice" value="${totalPrice + lineTotal}" />
                                            </c:forEach>

                                            <div class="d-flex justify-content-between mb-4">
                                                <h5 class="text-uppercase">items <c:out value="${fn:length(CART.cart)}" /></h5>
                                                <h5>$ <c:out value="${totalPrice}" /></h5>
                                            </div>

                                            <h5 class="text-uppercase mb-3">Shipping</h5>

                                            <div class="mb-4 pb-2">
                                                <select class="select" id="deliveryOption" onchange="updateTotalPrice()">
                                                    <option value="5">Standard-Delivery- 5.00 $</option>
                                                    <option value="10">Express-Delivery- 10.00 $</option>
                                                    <option value="20">Overnight-Delivery- 20.00 $</option>
                                                </select>
                                            </div>

                                            <h5 class="text-uppercase mb-3">Give code</h5>

                                            <div class="mb-5">
                                                <div class="form-outline">
                                                    <input type="text" id="form3Examplea2" class="form-control form-control-lg" />
                                                    <label class="form-label" for="form3Examplea2">Enter your code</label>
                                                </div>
                                            </div>

                                            <hr class="my-4">

                                            <div class="d-flex justify-content-between mb-5">
                                                <h5 class="text-uppercase">Total price</h5>
                                                <h5 id="finalTotalPrice">$ <c:out value="${totalPrice+5}" /></h5>
                                            </div>

                                            <form action="OrderController" method="POST">
                                                <button type="submit" name="action" value="checkout"  data-mdb-ripple-color="dark" class="btn btn-dark btn-block btn-lg">Check Out</button>
                                            </form>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- End your project here-->

        <!-- MDB -->
        <script type="text/javascript" src="script/mdb.min.js"></script>
        <!-- Custom scripts -->
        <script type="text/javascript">
                                                    function updateTotalPrice() {
                                                        var deliveryOption = document.getElementById('deliveryOption').value;
                                                        var baseTotalPrice = parseFloat('${totalPrice}');
                                                        var finalTotalPrice = baseTotalPrice + parseFloat(deliveryOption);
                                                        document.getElementById('finalTotalPrice').innerText = '$ ' + finalTotalPrice.toFixed(2);
                                                    }
        </script>
    </body>

</html>
