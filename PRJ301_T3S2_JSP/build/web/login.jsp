<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://www.google.com/recaptcha/api.js?hl=en" async defer></script>
        <style>
            @import url("https://fonts.googleapis.com/css2?family=Quicksand:wght@300&display=swap");

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: "Quicksand", sans-serif;
            }

            body {
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                background: #111;
                width: 100%;
                overflow: hidden;
            }

            .ring {
                position: relative;
                width: 500px;
                height: 500px;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .ring i {
                position: absolute;
                inset: 0;
                border: 2px solid #fff;
                transition: 0.5s;
            }

            .ring i:nth-child(1) {
                border-radius: 38% 62% 63% 37% / 41% 44% 56% 59%;
                animation: animate 6s linear infinite;
            }

            .ring i:nth-child(2) {
                border-radius: 41% 44% 56% 59% / 38% 62% 63% 37%;
                animation: animate 4s linear infinite;
            }

            .ring i:nth-child(3) {
                border-radius: 41% 44% 56% 59% / 38% 62% 63% 37%;
                animation: animate2 10s linear infinite;
            }

            .ring:hover i {
                border: 6px solid var(--clr);
                filter: drop-shadow(0 0 20px var(--clr));
            }

            @keyframes animate {
                0% {
                    transform: rotate(0deg);
                }
                100% {
                    transform: rotate(360deg);
                }
            }

            @keyframes animate2 {
                0% {
                    transform: rotate(360deg);
                }
                100% {
                    transform: rotate(0deg);
                }
            }

            .login {
                position: absolute;
                width: 300px;
                height: 100%;
                display: flex;
                justify-content: center;
                align-items: center;
                flex-direction: column;
                gap: 20px;
            }

            .login h2 {
                font-size: 2em;
                color: #fff;
            }

            .login .inputBx {
                position: relative;
                width: 100%;
            }

            .login .inputBx input {
                position: relative;
                width: 100%;
                padding: 12px 20px;
                background: transparent;
                border: 2px solid #fff;
                border-radius: 40px;
                font-size: 1.2em;
                color: #fff;
                box-shadow: none;
                outline: none;
            }

            .login .inputBx input[type="submit"] {
                width: 100%;
                background: linear-gradient(45deg, #ff357a, #fff172);
                border: none;
                cursor: pointer;
            }

            .login .inputBx input::placeholder {
                color: rgba(255, 255, 255, 0.75);
            }

            .login .links {
                position: relative;
                width: 100%;
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 0 20px;
            }

            .login .links a {
                color: #fff;
                text-decoration: none;
            }

            .loader-background {
                display: none;
                position: fixed;
                z-index: 9999;
                width: 100%;
                height: 100%;
                background: rgba(255, 255, 255, 0.8);
                justify-content: center;
                align-items: center;
            }

            .loader {
                border: 16px solid #f3f3f3;
                border-radius: 50%;
                border-top: 16px solid #3498db;
                width: 120px;
                height: 120px;
                animation: spin 2s linear infinite;
            }

            @keyframes spin {
                0% { transform: rotate(0deg); }
                100% { transform: rotate(360deg); }
            }
        </style>
    </head>
    <body>
        <div class="loader-background">
            <div class="loader"></div>
        </div>
        <div class="ring">
            <i style="--clr:#00ff0a;"></i>
            <i style="--clr:#ff0057;"></i>
            <i style="--clr:#fffd44;"></i>
            <div class="login">
                <h2>Login</h2>
                <form action="MainController" method="POST" id="form">
                    <div class="inputBx">
                        <input type="text" name="userID" placeholder="Username" required>
                    </div>
                    <div class="inputBx">
                        <input type="password" name="password" placeholder="Password" required>
                    </div>
                    <div class="row">
                        <div class="d-grid">
                            <c:set var="error" value="${requestScope.ERROR != null ? requestScope.ERROR : '***'}"/>
                            <c:if test="${error != '***'}">
                                <div class="g-recaptcha" data-sitekey="6LdhefwpAAAAAPSQAP-T3E3PvNq3VIZrdNK57C-1"></div>
                            </c:if>
                            <script>
                                window.onload = function () {
                                    const form = document.getElementById("form");
                                    const errorElement = document.getElementById("error");

                                    form.addEventListener("submit", function (event) {
                                        const recaptcha = document.querySelector(".g-recaptcha");

                                        if (recaptcha) {
                                            const response = grecaptcha.getResponse();
                                            if (!response) {
                                                event.preventDefault();
                                                errorElement.innerHTML = "You must check the captcha.";
                                            }
                                        }
                                    });
                                };
                            </script>
                            <p class="text-danger" id="error"><c:out value="${error}"/></p>
                        </div>
                    </div>
                    <div class="inputBx">
                        <input type="submit" value="Login" name="action">
                    </div>
                    <div class="links">
                        <a href="#">Forget Password</a>
                        <a href="MainController?action=Create_Page">Signup</a>
                    </div>
                    <div class="inputBx">
                        <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile openid&redirect_uri=http://localhost:8084/PRJ301_T3S2_JSP/GoogleLoginController&response_type=code&client_id=1013605276110-usqa78trdk81ni84ke8uimtejmr5se70.apps.googleusercontent.com&approval_prompt=force" class="btn btn-outline-light w-100">
                            <img src="https://img.icons8.com/color/16/000000/google-logo.png" class="me-2" alt="Google logo" />Login with Google
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>