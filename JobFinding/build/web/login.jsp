<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">
        <title>Login</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background: linear-gradient(to right, #c8e6c9, #a5d6a7);
                height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .card {
                border: none;
                border-radius: 20px;
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
                padding: 30px;
                width: 100%;
                max-width: 420px;
                background-color: #ffffff;
            }

            .card h4 {
                font-weight: bold;
                color: #2e7d32;
            }

            .form-control {
                border-radius: 10px;
                border: 1px solid #a5d6a7;
            }

            .btn-green {
                background-color: #66bb6a;
                color: white;
                border-radius: 10px;
                font-weight: bold;
            }

            .btn-green:hover {
                background-color: #388e3c;
            }

            .radio-group {
                display: flex;
                justify-content: space-between;
                margin-bottom: 15px;
            }

            .radio-group label {
                margin-left: 5px;
                margin-right: 10px;
                color: #2e7d32;
                font-weight: 500;
            }

            .alert {
                border-radius: 10px;
            }

            .text-center a {
                font-weight: 500;
            }
        </style>
    </head>

    <body>
        <div class="card">
            <h4 class="text-center mb-4">🔐 Login</h4>
            <form action="login" method="post">
                <div class="mb-3">
                    <input type="text" name="username" class="form-control" placeholder="Username" required>
                </div>
                <div class="mb-3">
                    <input type="password" name="password" class="form-control" placeholder="Password" required>
                </div>

                <div class="radio-group mb-3">
                    <div>
                        <input type="radio" id="job-seeker" name="role" value="job-seeker" required>
                        <label for="job-seeker">Job Seeker</label>
                    </div>
                    <div>
                        <input type="radio" id="recruiter" name="role" value="recruiter">
                        <label for="recruiter">Recruiter</label>
                    </div>
                    <div>
                        <input type="radio" id="admin" name="role" value="admin">
                        <label for="admin">Admin</label>
                    </div>
                </div>

                <button type="submit" class="btn btn-green w-100 mb-3">Login</button>

                <div class="text-center">
                    <a href="reset_password.jsp" class="text-decoration-none text-dark">🔁 Forgot password?</a>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger mt-3" role="alert">
                        <c:choose>
                            <c:when test="${error == 'Please fill in all login information'}">
                                Please enter both username and password
                            </c:when>
                            <c:when test="${error == 'Invalid username, password or account status'}">
                                Invalid credentials or account not active
                            </c:when>
                            <c:otherwise>
                                ${error}
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>
            </form>
        </div>

        <script>
            // Store selected user type in session storage
            document.querySelector('form').addEventListener('submit', function (e) {
                const userType = document.querySelector('input[name="role"]:checked').value;
                sessionStorage.setItem('userType', userType);
            });
        </script>
    </body>

</html>