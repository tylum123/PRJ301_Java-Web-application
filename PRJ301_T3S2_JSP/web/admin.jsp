<%@page contentType="text/html; charset=UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin User View Page</title>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
        <script>
            function editUser(userID, email, fullName, roleID, address, status, isSale, picture) {
                document.getElementById('editForm').style.display = 'block';
                document.getElementById('editUserID').value = userID;
                document.getElementById('editEmail').value = email;
                document.getElementById('editFullName').value = fullName;
                document.getElementById('editRoleID').value = roleID;
                document.getElementById('editAddress').value = address;
                document.getElementById('editStatus').value = status;
                document.getElementById('editIsSeller').value = isSale;
                document.getElementById('editPicture').value = picture;
            }
            function cancelEdit() {
                document.getElementById('editForm').style.display = 'none';
            }
            document.addEventListener('DOMContentLoaded', (event) => {
            <c:if test="${not empty USER_ERROR}">
                var myModal = new bootstrap.Modal(document.getElementById('addUserModal'));
                myModal.show();
            </c:if>
            });
        </script>
        <style><%@include file="/style/style.css"%></style>
        <style>
            .responsive-image {
                max-width: 100%;
                height: auto;
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
                object-fit: cover;
            }
        </style>
    </head>
    <body>
        <c:set var="err" value="${requestScope.ERROR_MESS != null ? requestScope.ERROR_MESS : ''}" />
        <header>
            <nav class="navbar navbar-expand-lg navbar-dark">
                <div class="container-fluid">
                    <a class="navbar-brand" style="font-family:Verdana;" href="#"><c:out value="${sessionScope.LOGIN_USER.fullName}"/></a>
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
                            <button class="btn btn-outline-secondary border-0" id="button" type="submit" name="action" value="Search">
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
                                <a class="nav-link active" aria-current="page" href="MainController?action=Search">
                                    <i class="fa fa-user"></i> User
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="MainController?action=Find_Product">
                                    <i class="fa fa-dropbox"></i> Product
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
                <h1 class="text-danger"> Welcome to Admin User Management Page</h1>
            </div>
            <div class="container" id="table-view">
                <h2 class="text-warning">User Management</h2>
                <div class="userManagement">
                    <c:if test="${not empty requestScope.LIST_USER}">
                        <table class="">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>User ID</th>
                                    <th>Email</th>
                                    <th>Full Name</th>
                                    <th>Role ID</th>
                                    <th>Address</th>
                                    <th>Status</th>
                                    <th>Is Sale</th>
                                    <th>Photo</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="user" items="${requestScope.LIST_USER}" varStatus="status">
                                    <tr>
                                        <td style="width: 10%">${status.index + 1}</td>
                                        <td style="width: 10%">${user.userID}</td>
                                        <td style="width: 10%">${user.email}</td>
                                        <td style="width: 10%">${user.fullName}</td>
                                        <td style="width: 10%">${user.roleID}</td>
                                        <td style="width: 10%">${user.address}</td>
                                        <td style="width: 10%">${user.status ? 'Active' : 'Inactive'}</td>
                                        <td style="width: 10%">${user.isSale ? 'Seller' : 'Customer'}</td>
                                        <td style="width: 10%">
                                            <div class="image-container">
                                                <img src="img/users/${user.picture}" alt="User"/>
                                            </div>
                                        </td>
                                        <td style="width: 10%">
                                            <button class="btn btn-warning" onclick="editUser('${user.userID}', '${user.email}', '${user.fullName}', '${user.roleID}', '${user.address}', '${user.status ? 'Active' : 'Inactive'}', '${user.isSale ? 'Seller' : 'Customer'}', '${user.picture}')"><i class='fa fa-edit'></i></button>
                                            <a href="MainController?action=Delete&userID=${user.userID}&search=${param.search}" class="btn btn-danger"><i class='fa fa-trash-o'></i></a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <p style="color: red; justify-content: flex-end">${err}</p>
                    </c:if>
                    <c:if test="${empty requestScope.LIST_USER}">
                        <p style="text-align: center; color: red">No users found.</p>
                    </c:if>
                    <div style="width: 100%;" class="text-center">
                        <nav aria-label="Page navigation example">
                            <ul class="pagination justify-content-center">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="MainController?action=Search&index=${currentPage - 1}&search=${param.search}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo; Previous</span>
                                        </a>
                                    </li>
                                </c:if>
                                <c:forEach begin="1" end="${endp}" var="i">
                                    <li class="page-item <c:if test='${i == currentPage}'>active</c:if>">
                                        <a class="page-link" href="MainController?action=Search&index=${i}&search=${param.search}">${i}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${currentPage < endp}">
                                    <li class="page-item">
                                        <a class="page-link" href="MainController?action=Search&index=${currentPage + 1}&search=${param.search}" aria-label="Next">
                                            <span aria-hidden="true">Next &raquo;</span>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>
                    <div class="show-button">
                        <button style="display: flex; justify-content: center" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addUserModal">
                            <i class="fa fa-plus"></i> Add New User
                        </button>
                    </div>
                </div>

                <!-- Form for editing user -->
                <div id="editForm" style="display: none; margin-bottom: 4px">
                    <h2>Edit User</h2>
                    <form action="UpdateController" method="POST" enctype="multipart/form-data">
                        <input type="hidden" name="userID" id="editUserID" />
                        <div class="mb-3">
                            <label for="editEmail" class="form-label">Email</label>
                            <input type="text" class="form-control" name="email" id="editEmail" required />
                        </div>
                        <div class="mb-3">
                            <label for="editFullName" class="form-label">Full Name</label>
                            <input type="text" class="form-control" name="fullName" id="editFullName" required />
                        </div>
                        <div class="mb-3">
                            <label for="editRoleID" class="form-label">Role ID</label>
                            <select name="roleID" class="form-control" id="editRoleID">
                                <option value="US">US</option>
                                <option value="AD">AD</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="editAddress" class="form-label">Address</label>
                            <input type="text" class="form-control" name="address" id="editAddress" required />
                        </div>
                        <div class="mb-3">
                            <label for="editStatus" class="form-label">Status</label>
                            <select name="status" class="form-control" id="editStatus">
                                <option value="Active">Active</option>
                                <option value="Inactive">Inactive</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="editIsSale" class="form-label">Is Sale</label>
                            <select name="isSale" class="form-control" id="editIsSeller">
                                <option value="Seller">Seller</option>
                                <option value="Customer">Customer</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="picture">Photo:</label>
                            <input type="text" class="form-control" name="picture" id="editPicture" required />
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
                                    var pictureInput = document.getElementById('editPicture');
                                    var fileName = fileInput.files[0].name;
                                    pictureInput.value = fileName;
                                }
                            </script>
                        </div>
                        <button type="submit" name="action" class="btn btn-warning">Update</button>
                        <button type="button" class="btn btn-danger" onclick="cancelEdit()">Cancel</button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Modal for adding new user -->
        <div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addUserModalLabel">Add New User</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="MainController" method="POST">
                            <div class="mb-3">
                                <label for="addUserID" class="form-label">User ID</label>
                                <input type="text" class="form-control" name="userID" id="addUserID" required value="${param.userID}" />
                                <p class="text-danger">${USER_ERROR.userIDError}</p>
                            </div>
                            <div class="mb-3">
                                <label for="addFullName" class="form-label">Full Name</label>
                                <input type="text" class="form-control" name="fullName" id="addFullName" required value="${param.fullName}" />
                                <p class="text-danger">${USER_ERROR.fullNameError}</p>
                            </div>
                            <div class="mb-3">
                                <label for="addPassword" class="form-label">Password</label>
                                <input type="password" class="form-control" name="password" id="addPassword" required />
                                <p class="text-danger">${USER_ERROR.upasswordError}</p>
                            </div>
                            <div class="mb-3">
                                <label for="addConfirm" class="form-label">Confirm Password</label>
                                <input type="password" class="form-control" name="confirm" id="addConfirm" required />
                                <p class="text-danger">${USER_ERROR.confirmError}</p>
                            </div>
                            <div class="mb-3">
                                <label for="addRoleID" class="form-label">Role ID</label>
                                <select name="roleID" class="form-control" id="addRoleID">
                                    <option value="US" ${param.roleID == 'US' ? 'selected' : ''}>US</option>
                                    <option value="AD" ${param.roleID == 'AD' ? 'selected' : ''}>AD</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="addStatus" class="form-label">Status</label>
                                <select name="status" class="form-control" id="addStatus">
                                    <option value="Active" ${param.status == 'Active' ? 'selected' : ''}>Active</option>
                                    <option value="Inactive" ${param.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                                </select>
                            </div>
                            <input type="hidden" name="search" value="${param.search}" />
                            <button type="submit" name="action" value="AddUser" class="btn btn-success">Create</button>
                        </form>
                        <p class="text-danger">${USER_ERROR.error}</p>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
