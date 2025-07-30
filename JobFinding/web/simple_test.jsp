<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ page import="daos.PostTypeDAO" %>
        <%@ page import="models.PostType" %>
            <%@ page import="java.util.Vector" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <title>Simple Test</title>
                </head>

                <body>
                    <h1>Simple PostType Test</h1>

                    <% try { PostTypeDAO postTypeDAO=new PostTypeDAO(); Vector<PostType> postTypes =
                        postTypeDAO.getAllPostTypes();

                        out.println("<p>Total PostTypes: " + postTypes.size() + "</p>");

                        if (postTypes.isEmpty()) {
                        out.println("<p style='color: red;'>No PostTypes found!</p>");
                        } else {
                        out.println("<p style='color: green;'>PostTypes loaded successfully!</p>");
                        for (PostType pt : postTypes) {
                        out.println("<p>" + pt.getId() + " - " + pt.getTypeName() + "</p>");
                        }
                        }

                        } catch (Exception e) {
                        out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
                        e.printStackTrace();
                        }
                        %>
                </body>

                </html>