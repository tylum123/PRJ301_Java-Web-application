<%-- 
    Document   : error
    Created on : Jul 10, 2024, 9:45:57 AM
    Author     : minhnguyen
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Payment Failed</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            body {
                background-color: #f8d7da;
                color: #721c24;
                text-align: center;
                padding: 50px;
            }
            .container {
                max-width: 600px;
                margin: auto;
                background-color: #ffffff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            }
            .btn-home {
                background-color: #f44336;
                color: white;
                border: none;
                padding: 10px 20px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                margin: 10px 2px;
                cursor: pointer;
                border-radius: 5px;
            }
            .btn-home:hover {
                background-color: #d32f2f;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Payment Failed</h1>
            <p>Unfortunately, your payment could not be processed at this time. Please try again later.</p>
            <a href="MainController?action=Shop" class="btn btn-home">Home</a>
        </div>
    </body>
</html>