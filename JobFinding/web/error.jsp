<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error - Job Finding</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <body class="bg-light">
        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card shadow">
                        <div class="card-body text-center p-5">
                            <h1 class="display-1 text-danger mb-4">Oops!</h1>
                            <h2 class="h4 mb-4">Something went wrong</h2>
                            <p class="text-muted mb-4">
                                We're sorry, but there was an error processing your request.
                                Please try again later or contact support if the problem persists.
                            </p>
                            <p class="text-muted mb-4">
                                ${error}
                            </p>
                            <% if (exception !=null) { %>
                                <div class="alert alert-danger text-start">
                                    <strong>Error Details:</strong><br>
                                    <%= exception.getMessage() %>
                                </div>
                                <% } %>
                                    <div class="mt-4">
                                        <a href="home.jsp" class="btn btn-primary me-2">Go to Homepage</a>
                                        <button onclick="history.back()" class="btn btn-outline-secondary">Go
                                            Back</button>
                                    </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>

    </html>