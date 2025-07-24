<!-- admin_saler_add_homecomponent.jsp -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title><c:choose>
        <c:when test="${not empty component.id}">Update Homepage Component</c:when>
        <c:otherwise>Create New Homepage Component</c:otherwise>
    </c:choose> - Admin Panel</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <jsp:include page="admin-common-styles.jsp" />
</head>
<body>
    <div class="dashboard-container">
        <jsp:include page="sidebar.jsp" />
        
        <div class="main-content">
            <div class="page-header">
                <c:choose>
                    <c:when test="${not empty component.id}">
                        <h1>Update Homepage Component</h1>
                    </c:when>
                    <c:otherwise>
                        <h1>Create New Homepage Component</h1>
                    </c:otherwise>
                </c:choose>
                <div class="header-actions">
                    <a href="AdminSalerController?target=homecomponent" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i>
                        Back to List
                    </a>
                </div>
            </div>
            
            <div class="form-container">
                <form action="AdminSalerController" method="post" enctype="multipart/form-data" onsubmit="tinymce.triggerSave();">
                    <div class="form-group">
                        <label>Component Type</label>
                        <c:choose>
                            <c:when test="${not empty component.id}">
                                <select name="typeId" class="form-control" required>
                                    <option value="">Select Component Type</option>
                                    <c:forEach var="type" items="${componentTypes}">
                                        <option value="${type.id}" ${component.typeId == type.id ? 'selected' : ''}>
                                            <c:choose>
                                                <c:when test="${type.typeName == 'testimonial'}">Testimonial</c:when>
                                                <c:when test="${type.typeName == 'apply_process'}">Apply Process</c:when>
                                                <c:otherwise>${type.typeName}</c:otherwise>
                                            </c:choose>
                                        </option>
                                    </c:forEach>
                                </select>
                            </c:when>
                            <c:otherwise>
                                <select name="typeId" class="form-control" required onchange="toggleFields(this.value)">
                                    <option value="">Select Component Type</option>
                                    <c:forEach var="type" items="${componentTypes}">
                                        <option value="${type.id}">
                                            <c:choose>
                                                <c:when test="${type.typeName == 'testimonial'}">Testimonial</c:when>
                                                <c:when test="${type.typeName == 'apply_process'}">Apply Process</c:when>
                                                <c:otherwise>${type.typeName}</c:otherwise>
                                            </c:choose>
                                        </option>
                                    </c:forEach>
                                </select>
                            </c:otherwise>
                        </c:choose>
                        <small class="form-text text-muted">Choose the type of homepage component you want to manage</small>
                    </div>
                    
                    <div class="form-group">
                        <label>Image</label>
                        <c:choose>
                            <c:when test="${not empty component.id}">
                                <input type="file" name="thumbnail" accept="image/*" class="form-control" />
                            </c:when>
                            <c:otherwise>
                                <input type="file" name="thumbnail" accept="image/*" class="form-control" required />
                            </c:otherwise>
                        </c:choose>
                        <c:if test="${not empty mustbeImg}">
                            ${mustbeImg}
                        </c:if>
                    </div>

                    <div class="form-group">
                        <label>Position</label>
                        <c:choose>
                            <c:when test="${not empty component.id}">
                                <input name="position" type="number" class="form-control" value="${component.position}" min="1" required>
                            </c:when>
                            <c:otherwise>
                                <input name="position" type="number" class="form-control" min="1" required>
                            </c:otherwise>
                        </c:choose>
                        <small class="form-text text-muted">Display order (1, 2, 3...)</small>
                    </div>

                    <div class="form-group">
                        <label>Name</label>
                        <c:choose>
                            <c:when test="${not empty component.id}">
                                <input name="name" type="text" class="form-control" value="${component.name}" required>
                            </c:when>
                            <c:otherwise>
                                <input name="name" type="text" class="form-control" required>
                            </c:otherwise>
                        </c:choose>
                        <small class="form-text text-muted">Name or identifier for this component</small>
                        <span class="error-message">${message}</span>
                    </div>

                    <div class="form-group">
                        <label>Title</label>
                        <c:choose>
                            <c:when test="${not empty component.id}">
                                <input name="title" type="text" class="form-control" value="${component.title}" required>
                            </c:when>
                            <c:otherwise>
                                <input name="title" type="text" class="form-control" required>
                            </c:otherwise>
                        </c:choose>
                        <small class="form-text text-muted">Display title for the component</small>
                    </div>

                    <div class="form-group" id="iconField" style="display: none;">
                        <label>Icon Class</label>
                        <c:choose>
                            <c:when test="${not empty component.id}">
                                <input name="iconClass" type="text" class="form-control" value="${component.iconClass}" placeholder="e.g., flaticon-search">
                            </c:when>
                            <c:otherwise>
                                <input name="iconClass" type="text" class="form-control" placeholder="e.g., flaticon-search">
                            </c:otherwise>
                        </c:choose>
                        <small class="form-text text-muted">CSS class for the icon (only for Apply Process components)</small>
                    </div>

                    <div class="form-group">
                        <label>Content</label>
                        <c:choose>
                            <c:when test="${not empty component.id}">
                                <textarea name="content" id="default" class="form-control" rows="6">${component.content}</textarea>
                            </c:when>
                            <c:otherwise>
                                <textarea name="content" id="default" class="form-control" rows="6"></textarea>
                            </c:otherwise>
                        </c:choose>
                        <small class="form-text text-muted">Main content or description</small>
                    </div>

                    <div class="form-group">
                        <label>Status</label>
                        <select name="status" class="form-control" required>
                            <c:choose>
                                <c:when test="${not empty component.id}">
                                    <option value="active" ${component.status == 'active' ? 'selected' : ''}>Active</option>
                                    <option value="inactive" ${component.status == 'inactive' ? 'selected' : ''}>Inactive</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="active">Active</option>
                                    <option value="inactive">Inactive</option>
                                </c:otherwise>
                            </c:choose>
                        </select>
                        <small class="form-text text-muted">Component visibility status</small>
                    </div>

                    <input type="hidden" name="target" value="homecomponent">
                    <c:choose>
                        <c:when test="${not empty component.id}">
                            <input type="hidden" name="componentId" value="${component.id}">
                            <input type="hidden" name="service" value="Update">
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" name="service" value="Add">
                        </c:otherwise>
                    </c:choose>

                    <div class="form-actions">
                        <button type="submit" name="submit" value="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i>
                            Confirm
                        </button>
                        <a href="AdminSalerController?target=homecomponent" class="btn btn-secondary">
                            <i class="fas fa-times"></i>
                            Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- TinyMCE -->
    <script src="./tinymce/tinymce.min.js"></script>
    <script src="./assets/js/tinymceConfig.js"></script>
    
    <style>
        .form-actions {
            margin-top: 30px;
            display: flex;
            gap: 15px;
        }
        
        .error-message {
            color: #dc3545;
            font-size: 14px;
            margin-top: 5px;
            display: block;
        }
        
        .form-text {
            color: #6c757d;
            font-size: 12px;
        }
    </style>

    <script>
        // Function to toggle icon field based on component type
        function toggleFields(typeId) {
            var iconField = document.getElementById('iconField');
            // Assuming type ID 2 is for apply_process, adjust as needed
            var isApplyProcess = false;
            <c:forEach var="type" items="${componentTypes}">
                if (typeId == '${type.id}' && '${type.typeName}' == 'apply_process') {
                    isApplyProcess = true;
                }
            </c:forEach>
            
            if (isApplyProcess) {
                iconField.style.display = 'block';
            } else {
                iconField.style.display = 'none';
            }
        }

        // Initialize on page load
        document.addEventListener('DOMContentLoaded', function() {
            var typeSelect = document.querySelector('select[name="typeId"]');
            if (typeSelect.value) {
                toggleFields(typeSelect.value);
            }
        });
    </script>
</body>
</html>