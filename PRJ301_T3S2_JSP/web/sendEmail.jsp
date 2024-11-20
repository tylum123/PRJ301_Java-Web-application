<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Send Email</title>
        <style><%@include file="/style/styleEmail.css"%></style>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
    </head>
    <body>
        <header>
            <nav class="navbar navbar-expand-lg navbar-dark">
                <div class="container-fluid">
                    <a class="navbar-brand" style="font-family:Verdana;" href="#"><c:out value="${sessionScope.LOGIN_USER.fullName}"/></a>
                    <div class="avatar-container">
                        <c:if test="${not empty sessionScope.avatarUrl}">
                            <img src="<c:out value="${sessionScope.avatarUrl}"/>" alt="User Avatar">
                        </c:if>
                        <c:if test="${empty sessionScope.avatarUrl}">
                            <div class="avatar-placeholder">
                                <i class="fa fa-user"></i>
                            </div>
                        </c:if>
                    </div>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav ms-auto">
                            <li class="nav-item">
                                <a class="nav-link" href="MainController?action=Search">
                                    <i class="fa fa-home"></i> Home
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="MainController?action=Find_Product">
                                    <i class="fa fa-star"></i> Product
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="sendEmail.jsp">
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
                <h1> Welcome to Admin Email Contact Page</h1>
            </div>
            <div class="container" id="table-view">
                <h2 class="text-primary">Send Email</h2>
                <div class="sendEmail">
                    <form action="SendEmailController" method="POST" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label for="to" class="form-label">To</label>
                            <input type="email" class="form-control" name="to" id="to" required />
                        </div>
                        <div class="mb-3">
                            <label for="cc" class="form-label">CC</label>
                            <input type="email" class="form-control" name="cc" id="cc" />
                        </div>
                        <div class="mb-3">
                            <label for="bcc" class="form-label">BCC</label>
                            <input type="email" class="form-control" name="bcc" id="bcc" />
                        </div>
                        <div class="mb-3">
                            <label for="title" class="form-label">Title</label>
                            <input type="text" class="form-control" name="title" id="title" required />
                        </div>
                        <div class="mb-3">
                            <label for="content" class="form-label">Content</label>
                            <textarea class="form-control" name="content" id="content" rows="5" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="file">Attachment:</label>
                            <input type="file" name="file" id="file"><br>
                        </div>
                        <button type="submit" class="btn btn-success">Send</button>
                        <button type="reset" class="btn btn-danger">Reset</button>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
