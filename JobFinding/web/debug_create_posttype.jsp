<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ page import="daos.PostTypeDAO" %>
        <%@ page import="models.PostType" %>
            <%@ page import="java.util.Vector" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <title>Debug Create PostType</title>
                </head>

                <body>
                    <h1>Debug Create PostType</h1>

                    <% // Test form data String typeCode=request.getParameter("typeCode"); String
                        typeName=request.getParameter("typeName"); String
                        description=request.getParameter("description"); String
                        category=request.getParameter("category"); String
                        priorityLevelStr=request.getParameter("priorityLevel"); String
                        iconClass=request.getParameter("iconClass"); String colorCode=request.getParameter("colorCode");
                        out.println("<h2>Form Data Received:</h2>");
                        out.println("<ul>");
                            out.println("<li>typeCode: " + (typeCode != null ? typeCode : "null") + "</li>");
                            out.println("<li>typeName: " + (typeName != null ? typeName : "null") + "</li>");
                            out.println("<li>description: " + (description != null ? description : "null") + "</li>");
                            out.println("<li>category: " + (category != null ? category : "null") + "</li>");
                            out.println("<li>priorityLevel: " + (priorityLevelStr != null ? priorityLevelStr : "null") +
                                "</li>");
                            out.println("<li>iconClass: " + (iconClass != null ? iconClass : "null") + "</li>");
                            out.println("<li>colorCode: " + (colorCode != null ? colorCode : "null") + "</li>");
                            out.println("</ul>");

                        if (typeCode != null && typeName != null && category != null && priorityLevelStr != null) {
                        try {
                        out.println("<h2>Step 1: Creating PostType Object</h2>");
                        PostType postType = new PostType();
                        postType.setTypeCode(typeCode);
                        postType.setTypeName(typeName);
                        postType.setDescription(description != null ? description : "");
                        postType.setCategory(category);
                        postType.setPriorityLevel(Integer.parseInt(priorityLevelStr));
                        postType.setActive(true);
                        postType.setIconClass(iconClass != null ? iconClass : "");
                        postType.setColorCode(colorCode != null ? colorCode : "#007bff");

                        out.println("<p style='color: green;'>✓ PostType object created successfully</p>");
                        out.println("<p>PostType: " + postType.toString() + "</p>");

                        out.println("<h2>Step 2: Testing Database Connection</h2>");
                        PostTypeDAO postTypeDAO = new PostTypeDAO();
                        out.println("<p style='color: green;'>✓ PostTypeDAO created successfully</p>");

                        out.println("<h2>Step 3: Checking if typeCode exists</h2>");
                        boolean exists = postTypeDAO.isTypeCodeExists(typeCode);
                        out.println("<p>TypeCode '" + typeCode + "' exists: " + exists + "</p>");

                        if (exists) {
                        out.println("<p style='color: red;'>✗ TypeCode already exists! This will cause an error.</p>");
                        } else {
                        out.println("<p style='color: green;'>✓ TypeCode is unique</p>");

                        out.println("<h2>Step 4: Creating PostType in Database</h2>");
                        boolean success = postTypeDAO.createPostType(postType);

                        if (success) {
                        out.println("<p style='color: green;'>✓ PostType created successfully!</p>");

                        // Verify by getting the created PostType
                        PostType created = postTypeDAO.getPostTypeByCode(typeCode);
                        if (created != null) {
                        out.println("<p>Created PostType ID: " + created.getId() + "</p>");
                        out.println("<p>Created PostType: " + created.toString() + "</p>");
                        }
                        } else {
                        out.println("<p style='color: red;'>✗ Failed to create PostType!</p>");
                        }
                        }

                        } catch (NumberFormatException e) {
                        out.println("<p style='color: red;'>✗ Error: Invalid priority level - " + e.getMessage() + "</p>
                        ");
                        } catch (Exception e) {
                        out.println("<p style='color: red;'>✗ Error: " + e.getMessage() + "</p>");
                        out.println("<h3>Stack Trace:</h3>");
                        out.println("
                        <pre>");
            e.printStackTrace();
            out.println("</pre>");
                        }
                        } else {
                        out.println("<p style='color: orange;'>⚠ No form data submitted. Please submit the form first.
                        </p>");
                        }
                        %>

                        <h2>Test Form</h2>
                        <form method="POST" action="debug_create_posttype.jsp">
                            <div>
                                <label>Type Code: <input type="text" name="typeCode" value="test_type" required></label>
                            </div>
                            <div>
                                <label>Type Name: <input type="text" name="typeName" value="Test Type" required></label>
                            </div>
                            <div>
                                <label>Description: <textarea name="description">Test description</textarea></label>
                            </div>
                            <div>
                                <label>Category:
                                    <select name="category" required>
                                        <option value="job_posting">Job Posting</option>
                                        <option value="content">Content</option>
                                        <option value="announcement">Announcement</option>
                                        <option value="event">Event</option>
                                    </select>
                                </label>
                            </div>
                            <div>
                                <label>Priority Level: <input type="number" name="priorityLevel" value="1"
                                        required></label>
                            </div>
                            <div>
                                <label>Icon Class: <input type="text" name="iconClass" value="fas fa-test"></label>
                            </div>
                            <div>
                                <label>Color Code: <input type="text" name="colorCode" value="#ff0000"></label>
                            </div>
                            <div>
                                <button type="submit">Test Create PostType</button>
                            </div>
                        </form>
                </body>

                </html>