<%@page import="sample.user.UserDTO"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Page</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: Arial, sans-serif;
            }
            .container {
                margin-top: 50px;
            }
            .card {
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .card-header {
                background-color: #343a40;
                color: white;
                border-radius: 10px 10px 0 0;
            }
            .card-body {
                padding: 30px;
            }
            .responsive-image {
                max-width: 100%;
                height: auto;
            }

            .image-container {
                width: 200px; /* or any specific width */
                height: 200px; /* or any specific height */
                overflow: hidden;
                position: relative;
            }

            .image-container img {
                width: 100%;
                height: 100%;
                object-fit: fill; /* or 'contain' depending on your need */
            }
        </style>
    </head>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h3>User Information</h3>
                        <a href="MainController?action=Shop" class="btn btn-outline-light float-left mr-2"><i class="fas fa-box"></i>SHOP</a>
                        <button type="button" class="btn btn-outline-light float-left" data-toggle="modal" data-target="#editModal">
                            Edit
                        </button>
                        <form action="MainController" method="POST">
                            <button type="submit" class="btn btn-outline-light float-left ml-2" data-toggle="modal" value="Logout" name="action">
                                Logout
                            </button>
                        </form>

                    </div>
                    <div class="card-body">
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label">User ID:</label>
                            <div class="col-sm-9">
                                <p class="form-control-plaintext"><c:out value="${sessionScope.LOGIN_USER.userID}"/></p>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label">Full Name:</label>
                            <div class="col-sm-9">
                                <p class="form-control-plaintext"><c:out value="${sessionScope.LOGIN_USER.fullName}"/></p>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label">Role ID:</label>
                            <div class="col-sm-9">
                                <p class="form-control-plaintext"><c:out value="${sessionScope.LOGIN_USER.roleID}"/></p>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label">Password:</label>
                            <div class="col-sm-9">
                                <p class="form-control-plaintext"><c:out value="${sessionScope.LOGIN_USER.password}"/></p>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label">Seller status</label>
                            <div class="col-sm-9">
                                <p class="form-control-plaintext"><c:out value="${sessionScope.LOGIN_USER.isSale? 'Seller':'Customer'}"/></p>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label">Photo:</label>
                            <div class="image-container">
                                <img src="img/users/<c:out value="${sessionScope.LOGIN_USER.picture}"/>" alt="yours image"/>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label">Address:</label>
                            <div class="col-sm-9">
                                <p class="form-control-plaintext"><c:out value="${sessionScope.LOGIN_USER.address}"/></p>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label">Email:</label>
                            <div class="col-sm-9">
                                <p class="form-control-plaintext"><c:out value="${sessionScope.LOGIN_USER.email}"/></p>
                            </div>
                        </div>
                    </div>
                    <c:if test="${not empty requestScope.message}">
                        <pre style="color: red">                <c:out value="${requestScope.message}"/></pre>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit Modal -->
    <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabel">Edit User Information</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action="UploadFileServlet" method="post" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="userID">User ID:</label>
                            <input type="text" class="form-control" id="userID" name="userID" value="${sessionScope.LOGIN_USER.userID}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="fullName">Full Name:</label>
                            <input type="text" class="form-control" id="fullName" name="fullName" value="${sessionScope.LOGIN_USER.fullName}">
                        </div>
                        <div class="form-group">
                            <label for="roleID">Role ID:</label>
                            <input type="text" class="form-control" id="roleID" name="roleID" value="${sessionScope.LOGIN_USER.roleID}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="password">Password:</label>
                            <input type="password" class="form-control" id="password" name="password" value="${sessionScope.LOGIN_USER.password}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="picture">Photo:</label>
                            <input type="text" class="form-control" id="picture" name="picture" value="${sessionScope.LOGIN_USER.picture}">

                            <label for="uploadDir">Choose upload directory:</label>
                            <select name="uploadDir" id="uploadDir">
                                <option value="users">Users</option>
                            </select>
                            <br><br>

                            <label for="file">Select file:</label>
                            <input type="file" name="file" id="file" onchange="updateFileName()">
                            <br><br>
                            <script>
                                function updateFileName() {
                                    var fileInput = document.getElementById('file');
                                    var pictureInput = document.getElementById('picture');
                                    var fileName = fileInput.files[0].name;
                                    pictureInput.value = fileName;
                                }
                            </script>
                        </div>
                        <div class="form-group">
                            <label for="address">Address:</label>
                            <input type="text" class="form-control" id="address" name="address" value="${sessionScope.LOGIN_USER.address}">
                        </div>
                        <div class="form-group">
                            <label for="email">Email:</label>
                            <input type="email" class="form-control" id="email" name="email" value="${sessionScope.LOGIN_USER.email}">
                        </div>
                        <button type="submit" class="btn btn-primary">Save changes</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</html>
