<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Simple Test</title>
    </head>

    <body>
        <h1>Simple JSP Test</h1>
        <p>If you can see this page, JSP compilation is working!</p>

        <% out.println("<p style='color: green;'>✓ JSP scriptlet is working!</p>");
            %>

            <p>Current time: <%= new java.util.Date() %>
            </p>
    </body>

    </html>