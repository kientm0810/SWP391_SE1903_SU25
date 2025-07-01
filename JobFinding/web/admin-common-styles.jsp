<!-- admin-common-styles.jsp -->
<style>
    /* Reset and Base Styles */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f0f2f5;
        color: #333;
    }
    
    /* Main Layout */
    .dashboard-container {
        display: flex;
        min-height: 100vh;
    }
    
    .main-content {
        margin-left: 280px;
        padding: 30px;
        width: calc(100% - 280px);
    }
    
    /* Common Header */
    .page-header {
        background-color: white;
        padding: 20px 30px;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        margin-bottom: 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .page-header h1 {
        color: #2e7d32;
        font-size: 28px;
    }
    
    /* Buttons */
    .btn {
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 14px;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        text-decoration: none;
    }
    
    .btn-primary {
        background-color: #4caf50;
        color: white;
    }
    
    .btn-primary:hover {
        background-color: #45a049;
    }
    
    .btn-secondary {
        background-color: #e0e0e0;
        color: #333;
    }
    
    .btn-secondary:hover {
        background-color: #d0d0d0;
    }
    
    .btn-danger {
        background-color: #f44336;
        color: white;
    }
    
    .btn-danger:hover {
        background-color: #d32f2f;
    }
    
    .btn-info {
        background-color: #2196f3;
        color: white;
    }
    
    .btn-info:hover {
        background-color: #1976d2;
    }
    
    /* Form Styles */
    .form-container {
        background-color: white;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    
    .form-group {
        margin-bottom: 20px;
    }
    
    .form-group label {
        display: block;
        margin-bottom: 5px;
        color: #555;
        font-weight: 500;
    }
    
    .form-control {
        width: 100%;
        padding: 10px 15px;
        border: 1px solid #ddd;
        border-radius: 5px;
        font-size: 14px;
        transition: border-color 0.3s ease;
    }
    
    .form-control:focus {
        outline: none;
        border-color: #4caf50;
        box-shadow: 0 0 0 2px rgba(76, 175, 80, 0.2);
    }
    
    select.form-control {
        background-color: white;
    }
    
    textarea.form-control {
        resize: vertical;
        min-height: 100px;
    }
    
    /* Table Styles */
    .table-container {
        background-color: white;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        overflow: hidden;
    }
    
    .data-table {
        width: 100%;
        border-collapse: collapse;
    }
    
    .data-table thead {
        background-color: #f5f5f5;
    }
    
    .data-table th {
        padding: 15px;
        text-align: left;
        font-weight: 600;
        color: #333;
        border-bottom: 2px solid #e0e0e0;
    }
    
    .data-table td {
        padding: 15px;
        border-bottom: 1px solid #e0e0e0;
    }
    
    .data-table tbody tr:hover {
        background-color: #f9f9f9;
    }
    
    /* Status Badges */
    .status-badge {
        padding: 5px 12px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 500;
        display: inline-block;
    }
    
    .status-active {
        background-color: #e8f5e9;
        color: #2e7d32;
    }
    
    .status-inactive {
        background-color: #ffebee;
        color: #c62828;
    }
    
    .status-pending {
        background-color: #fff3e0;
        color: #ef6c00;
    }
    
    .status-verified {
        background-color: #e3f2fd;
        color: #1565c0;
    }
    
    .status-draft {
        background-color: #f3e5f5;
        color: #6a1b9a;
    }
    
    .status-published {
        background-color: #e8f5e9;
        color: #2e7d32;
    }
    
    /* Action Buttons in Table */
    .action-buttons {
        display: flex;
        gap: 10px;
    }
    
    .action-btn {
        padding: 5px 10px;
        border: none;
        border-radius: 3px;
        cursor: pointer;
        font-size: 14px;
        transition: background-color 0.3s ease;
        color: white;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 5px;
    }
    
    .edit-btn {
        background-color: #2196f3;
    }
    
    .edit-btn:hover {
        background-color: #1976d2;
    }
    
    .delete-btn {
        background-color: #f44336;
    }
    
    .delete-btn:hover {
        background-color: #d32f2f;
    }
    
    .view-btn {
        background-color: #9c27b0;
    }
    
    .view-btn:hover {
        background-color: #7b1fa2;
    }
    
    /* Search and Filter Section */
    .search-filter-section {
        background-color: white;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        margin-bottom: 20px;
    }
    
    .search-filter-row {
        display: flex;
        gap: 15px;
        flex-wrap: wrap;
        align-items: center;
    }
    
    .search-box {
        flex: 1;
        min-width: 300px;
        position: relative;
    }
    
    .search-box input {
        width: 100%;
        padding: 10px 40px 10px 15px;
        border: 1px solid #ddd;
        border-radius: 5px;
        font-size: 14px;
    }
    
    .search-box i {
        position: absolute;
        right: 15px;
        top: 50%;
        transform: translateY(-50%);
        color: #666;
    }
    
    /* Cards */
    .card {
        background-color: white;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        padding: 25px;
        margin-bottom: 20px;
    }
    
    .card-header {
        margin-bottom: 20px;
        padding-bottom: 15px;
        border-bottom: 1px solid #e0e0e0;
    }
    
    .card-header h2 {
        color: #2e7d32;
        font-size: 20px;
    }
    
    /* Detail View */
    .detail-container {
        background-color: white;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        padding: 30px;
    }
    
    .detail-row {
        display: grid;
        grid-template-columns: 200px 1fr;
        padding: 15px 0;
        border-bottom: 1px solid #f0f0f0;
    }
    
    .detail-row:last-child {
        border-bottom: none;
    }
    
    .detail-label {
        font-weight: 600;
        color: #555;
    }
    
    .detail-value {
        color: #333;
    }
    
    .custom-pagination .page-item .page-link {
        color: #333;
        background-color: #f8f9fa;
        border: 1px solid #dee2e6;
        border-radius: 8px;
        padding: 8px 14px;
        margin: 0 5px;
        font-weight: 500;
        transition: all 0.2s ease-in-out;
    }

    .custom-pagination .page-item .page-link:hover {
        background-color: #e2e6ea;
        color: #212529;
    }

    .custom-pagination .page-item.active .page-link {
        background-color: #28a745;
        border-color: #28a745;
        color: white;
        font-weight: bold;
        pointer-events: none;
    }

    @media (max-width: 576px) {
        .custom-pagination .page-item .page-link {
            padding: 6px 10px;
            font-size: 14px;
        }
    }

    
    /* Responsive */
    @media (max-width: 768px) {
        .main-content {
            margin-left: 70px;
            width: calc(100% - 70px);
            padding: 20px;
        }
        
        .page-header {
            flex-direction: column;
            gap: 15px;
        }
        
        .search-filter-row {
            flex-direction: column;
        }
        
        .search-box {
            min-width: 100%;
        }
        
        .data-table {
            font-size: 14px;
        }
        
        .data-table th,
        .data-table td {
            padding: 10px;
        }
        
        .detail-row {
            grid-template-columns: 1fr;
            gap: 5px;
        }
    }
    
    /* Utilities */
    .text-center {
        text-align: center;
    }
    
    .mb-3 {
        margin-bottom: 20px;
    }
    
    .mt-3 {
        margin-top: 20px;
    }
    
    .alert {
        padding: 15px;
        border-radius: 5px;
        margin-bottom: 20px;
    }
    
    .alert-success {
        background-color: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
    }
    
    .alert-danger {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
    }
</style>