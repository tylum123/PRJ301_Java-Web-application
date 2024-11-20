<%-- 
    Document   : orderConfirmation
    Created on : Jul 9, 2024, 2:31:25 AM
    Author     : minhnguyen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Order Confirmation</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
                color: #333;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }
            .container {
                text-align: center;
                background-color: #fff;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                max-width: 600px;
                width: 100%;
            }
            h1 {
                font-size: 2.5rem;
                margin-bottom: 20px;
                color: #007bff;
            }
            p {
                font-size: 1.2rem;
                margin-bottom: 20px;
            }
            a {
                text-decoration: none;
                color: #007bff;
                font-weight: bold;
            }
            a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Order Confirmation</h1>
            <p>Your order has been successfully placed. Your order ID is: ${param.orderId}</p>
            <a href="home.jsp">Back to Home</a>
        </div>
    </body>
</html>