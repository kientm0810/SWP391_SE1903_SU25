<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <title>Báo cáo tài chính - JobFinding</title>

                <!-- Bootstrap CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <!-- Font Awesome -->
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
                <!-- Chart.js -->
                <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

                <style>
                    :root {
                        --primary-color: #1e88e5;
                        --secondary-color: #1976d2;
                        --success-color: #4caf50;
                        --warning-color: #ff9800;
                        --danger-color: #f44336;
                        --light-bg: #f8f9fa;
                        --border-color: #e9ecef;
                    }

                    body {
                        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                        background-color: var(--light-bg);
                    }

                    .report-header {
                        background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
                        color: white;
                        padding: 2rem 0;
                        margin-bottom: 2rem;
                    }

                    .stats-card {
                        background: white;
                        border-radius: 12px;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                        padding: 1.5rem;
                        margin-bottom: 1.5rem;
                        border: 1px solid var(--border-color);
                        transition: transform 0.3s ease;
                    }

                    .stats-card:hover {
                        transform: translateY(-2px);
                    }

                    .stats-icon {
                        width: 60px;
                        height: 60px;
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 1.5rem;
                        color: white;
                        margin-bottom: 1rem;
                    }

                    .stats-icon.revenue {
                        background: linear-gradient(135deg, var(--success-color), #45a049);
                    }

                    .stats-icon.transactions {
                        background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                    }

                    .stats-icon.promotions {
                        background: linear-gradient(135deg, var(--warning-color), #e68900);
                    }

                    .stats-icon.balance {
                        background: linear-gradient(135deg, var(--danger-color), #d32f2f);
                    }

                    .chart-container {
                        background: white;
                        border-radius: 12px;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                        padding: 1.5rem;
                        margin-bottom: 1.5rem;
                        border: 1px solid var(--border-color);
                    }

                    .table-container {
                        background: white;
                        border-radius: 12px;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                        padding: 1.5rem;
                        margin-bottom: 1.5rem;
                        border: 1px solid var(--border-color);
                    }

                    .table th {
                        background-color: var(--light-bg);
                        border-bottom: 2px solid var(--primary-color);
                        color: var(--primary-color);
                        font-weight: 600;
                    }

                    .status-badge {
                        padding: 0.25rem 0.75rem;
                        border-radius: 20px;
                        font-size: 0.85rem;
                        font-weight: 500;
                    }

                    .status-completed {
                        background-color: #d4edda;
                        color: #155724;
                    }

                    .status-pending {
                        background-color: #fff3cd;
                        color: #856404;
                    }

                    .status-failed {
                        background-color: #f8d7da;
                        color: #721c24;
                    }

                    .filter-section {
                        background: white;
                        border-radius: 12px;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                        padding: 1.5rem;
                        margin-bottom: 1.5rem;
                        border: 1px solid var(--border-color);
                    }

                    .btn-export {
                        background: linear-gradient(135deg, var(--success-color), #45a049);
                        border: none;
                        color: white;
                        padding: 0.75rem 1.5rem;
                        border-radius: 8px;
                        font-weight: 600;
                        transition: all 0.3s ease;
                    }

                    .btn-export:hover {
                        transform: translateY(-1px);
                        box-shadow: 0 4px 15px rgba(76, 175, 80, 0.3);
                        color: white;
                    }

                    .period-selector {
                        display: flex;
                        gap: 1rem;
                        align-items: center;
                        flex-wrap: wrap;
                    }

                    .period-btn {
                        padding: 0.5rem 1rem;
                        border: 2px solid var(--border-color);
                        background: white;
                        color: var(--primary-color);
                        border-radius: 8px;
                        cursor: pointer;
                        transition: all 0.3s ease;
                    }

                    .period-btn.active {
                        background: var(--primary-color);
                        color: white;
                        border-color: var(--primary-color);
                    }

                    .period-btn:hover {
                        border-color: var(--primary-color);
                    }

                    .loading {
                        display: none;
                        text-align: center;
                        padding: 2rem;
                    }

                    .loading i {
                        font-size: 2rem;
                        color: var(--primary-color);
                        animation: spin 1s linear infinite;
                    }

                    @keyframes spin {
                        0% {
                            transform: rotate(0deg);
                        }

                        100% {
                            transform: rotate(360deg);
                        }
                    }

                    .no-data {
                        text-align: center;
                        padding: 3rem;
                        color: #6c757d;
                    }

                    .no-data i {
                        font-size: 4rem;
                        margin-bottom: 1rem;
                        opacity: 0.5;
                    }
                </style>
            </head>

            <body>
                <!-- Header -->
                <jsp:include page="header.jsp" />

                <!-- Report Header -->
                <div class="report-header">
                    <div class="container">
                        <div class="row align-items-center">
                            <div class="col-md-8">
                                <h1 class="mb-2">
                                    <i class="fas fa-chart-line me-3"></i>
                                    Báo cáo tài chính
                                </h1>
                                <p class="mb-0 opacity-75">Theo dõi doanh thu và giao dịch của bạn</p>
                            </div>
                            <div class="col-md-4 text-end">
                                <button class="btn btn-export" onclick="exportReport()">
                                    <i class="fas fa-download me-2"></i>
                                    Xuất báo cáo
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="container">
                    <!-- Filter Section -->
                    <div class="filter-section">
                        <div class="row align-items-center">
                            <div class="col-md-6">
                                <h5 class="mb-3">
                                    <i class="fas fa-filter me-2"></i>
                                    Bộ lọc thời gian
                                </h5>
                                <div class="period-selector">
                                    <button class="period-btn active" data-period="7">7 ngày</button>
                                    <button class="period-btn" data-period="30">30 ngày</button>
                                    <button class="period-btn" data-period="90">3 tháng</button>
                                    <button class="period-btn" data-period="365">1 năm</button>
                                    <button class="period-btn" data-period="custom">Tùy chỉnh</button>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-6">
                                        <label class="form-label">Từ ngày</label>
                                        <input type="date" class="form-control" id="startDate">
                                    </div>
                                    <div class="col-6">
                                        <label class="form-label">Đến ngày</label>
                                        <input type="date" class="form-control" id="endDate">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Loading -->
                    <div class="loading" id="loading">
                        <i class="fas fa-spinner"></i>
                        <p class="mt-2">Đang tải dữ liệu...</p>
                    </div>

                    <!-- Statistics Cards -->
                    <div class="row" id="statsSection">
                        <div class="col-lg-3 col-md-6">
                            <div class="stats-card">
                                <div class="stats-icon revenue">
                                    <i class="fas fa-dollar-sign"></i>
                                </div>
                                <h4 class="mb-1" id="totalRevenue">0 VND</h4>
                                <p class="text-muted mb-0">Tổng doanh thu</p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="stats-card">
                                <div class="stats-icon transactions">
                                    <i class="fas fa-exchange-alt"></i>
                                </div>
                                <h4 class="mb-1" id="totalTransactions">0</h4>
                                <p class="text-muted mb-0">Tổng giao dịch</p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="stats-card">
                                <div class="stats-icon promotions">
                                    <i class="fas fa-star"></i>
                                </div>
                                <h4 class="mb-1" id="promotionRevenue">0 VND</h4>
                                <p class="text-muted mb-0">Doanh thu promotion</p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="stats-card">
                                <div class="stats-icon balance">
                                    <i class="fas fa-wallet"></i>
                                </div>
                                <h4 class="mb-1" id="currentBalance">0 VND</h4>
                                <p class="text-muted mb-0">Số dư hiện tại</p>
                            </div>
                        </div>
                    </div>

                    <!-- Charts Section -->
                    <div class="row">
                        <div class="col-lg-8">
                            <div class="chart-container">
                                <h5 class="mb-3">
                                    <i class="fas fa-chart-area me-2"></i>
                                    Biểu đồ doanh thu theo thời gian
                                </h5>
                                <canvas id="revenueChart" height="100"></canvas>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="chart-container">
                                <h5 class="mb-3">
                                    <i class="fas fa-chart-pie me-2"></i>
                                    Phân bố giao dịch
                                </h5>
                                <canvas id="transactionChart" height="100"></canvas>
                            </div>
                        </div>
                    </div>

                    <!-- Recent Transactions Table -->
                    <div class="table-container">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="mb-0">
                                <i class="fas fa-list me-2"></i>
                                Giao dịch gần đây
                            </h5>
                            <a href="#" class="btn btn-outline-primary btn-sm" onclick="viewAllTransactions()">
                                Xem tất cả
                            </a>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-hover" id="transactionsTable">
                                <thead>
                                    <tr>
                                        <th>Mã giao dịch</th>
                                        <th>Loại</th>
                                        <th>Số tiền</th>
                                        <th>Trạng thái</th>
                                        <th>Ngày tạo</th>
                                        <th>Mô tả</th>
                                    </tr>
                                </thead>
                                <tbody id="transactionsTableBody">
                                    <!-- Data will be loaded here -->
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- No Data Message -->
                    <div class="no-data" id="noData" style="display: none;">
                        <i class="fas fa-chart-bar"></i>
                        <h4>Chưa có dữ liệu</h4>
                        <p>Bạn chưa có giao dịch nào trong khoảng thời gian này.</p>
                    </div>
                </div>

                <!-- Footer -->
                <jsp:include page="footer.jsp" />

                <!-- Bootstrap JS -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                <!-- jQuery -->
                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

                <script>
                    let revenueChart, transactionChart;
                    let currentPeriod = 30;

                            // Initialize page
        document.addEventListener('DOMContentLoaded', function () {
            initializeCharts();
            setupEventListeners();
            
            // Load initial data from server
            <c:if test="${not empty totalRevenueData}">
                updateDashboard(${totalRevenueData});
            </c:if>
            <c:if test="${empty totalRevenueData}">
                loadReportData();
            </c:if>
        });

                    function setupEventListeners() {
                        // Period selector
                        document.querySelectorAll('.period-btn').forEach(btn => {
                            btn.addEventListener('click', function () {
                                document.querySelectorAll('.period-btn').forEach(b => b.classList.remove('active'));
                                this.classList.add('active');
                                currentPeriod = this.dataset.period;
                                loadReportData();
                            });
                        });

                        // Date inputs
                        document.getElementById('startDate').addEventListener('change', loadReportData);
                        document.getElementById('endDate').addEventListener('change', loadReportData);
                    }

                    function initializeCharts() {
                        // Revenue Chart
                        const revenueCtx = document.getElementById('revenueChart').getContext('2d');
                        revenueChart = new Chart(revenueCtx, {
                            type: 'line',
                            data: {
                                labels: [],
                                datasets: [{
                                    label: 'Doanh thu',
                                    data: [],
                                    borderColor: '#1e88e5',
                                    backgroundColor: 'rgba(30, 136, 229, 0.1)',
                                    borderWidth: 3,
                                    fill: true,
                                    tension: 0.4
                                }]
                            },
                            options: {
                                responsive: true,
                                maintainAspectRatio: false,
                                plugins: {
                                    legend: {
                                        display: false
                                    }
                                },
                                scales: {
                                    y: {
                                        beginAtZero: true,
                                        ticks: {
                                            callback: function (value) {
                                                return formatCurrency(value);
                                            }
                                        }
                                    }
                                }
                            }
                        });

                        // Transaction Chart
                        const transactionCtx = document.getElementById('transactionChart').getContext('2d');
                        transactionChart = new Chart(transactionCtx, {
                            type: 'doughnut',
                            data: {
                                labels: ['Hoàn thành', 'Đang xử lý', 'Thất bại'],
                                datasets: [{
                                    data: [0, 0, 0],
                                    backgroundColor: ['#4caf50', '#ff9800', '#f44336'],
                                    borderWidth: 0
                                }]
                            },
                            options: {
                                responsive: true,
                                maintainAspectRatio: false,
                                plugins: {
                                    legend: {
                                        position: 'bottom'
                                    }
                                }
                            }
                        });
                    }

                    function loadReportData() {
                        showLoading(true);

                        const startDate = document.getElementById('startDate').value;
                        const endDate = document.getElementById('endDate').value;

                        // Load data from server
                        fetch('ReportsController?action=data&type=total')
                            .then(response => response.json())
                            .then(data => {
                                updateDashboard(data);
                                showLoading(false);
                            })
                            .catch(error => {
                                console.error('Error loading data:', error);
                                showLoading(false);
                            });
                    }



                    function updateDashboard(data) {
                        // Update revenue chart with server data
                        const labels = data.map(item => item.month);
                        const revenueData = data.map(item => item.revenue);

                        updateRevenueChart({
                            labels: labels,
                            revenue: revenueData
                        });

                        // Update statistics (using mock data for now)
                        document.getElementById('totalRevenue').textContent = formatCurrency(75000000);
                        document.getElementById('totalTransactions').textContent = '45';
                        document.getElementById('promotionRevenue').textContent = formatCurrency(25000000);
                        document.getElementById('currentBalance').textContent = formatCurrency(15000000);

                        // Update transaction chart (mock data)
                        updateTransactionChart([30, 8, 7]);

                        // Update table (mock data)
                        const mockTransactions = [
                            {
                                id: 'TXN001',
                                type: 'Promotion',
                                amount: 5000000,
                                status: 'completed',
                                date: '2024-01-15',
                                description: 'Thanh toán gói promotion Premium'
                            },
                            {
                                id: 'TXN002',
                                type: 'Subscription',
                                amount: 2000000,
                                status: 'pending',
                                date: '2024-01-14',
                                description: 'Gói subscription tháng'
                            },
                            {
                                id: 'TXN003',
                                type: 'CV Service',
                                amount: 1000000,
                                status: 'completed',
                                date: '2024-01-13',
                                description: 'Dịch vụ xem CV'
                            }
                        ];
                        updateTransactionsTable(mockTransactions);

                        // Show/hide no data message
                        const noDataElement = document.getElementById('noData');
                        const statsSection = document.getElementById('statsSection');

                        if (data.length === 0) {
                            noDataElement.style.display = 'block';
                            statsSection.style.display = 'none';
                        } else {
                            noDataElement.style.display = 'none';
                            statsSection.style.display = 'block';
                        }
                    }

                    function updateRevenueChart(chartData) {
                        revenueChart.data.labels = chartData.labels;
                        revenueChart.data.datasets[0].data = chartData.revenue;
                        revenueChart.update();
                    }

                    function updateTransactionChart(transactionData) {
                        transactionChart.data.datasets[0].data = transactionData;
                        transactionChart.update();
                    }

                    function updateTransactionsTable(transactions) {
                        const tbody = document.getElementById('transactionsTableBody');
                        tbody.innerHTML = '';

                        transactions.forEach(transaction => {
                            const row = document.createElement('tr');
                            row.innerHTML = `
                    <td><strong>${transaction.id}</strong></td>
                    <td>${transaction.type}</td>
                    <td><strong>${formatCurrency(transaction.amount)}</strong></td>
                    <td><span class="status-badge status-${transaction.status}">${getStatusText(transaction.status)}</span></td>
                    <td>${formatDate(transaction.date)}</td>
                    <td>${transaction.description}</td>
                `;
                            tbody.appendChild(row);
                        });
                    }

                    function formatCurrency(amount) {
                        return new Intl.NumberFormat('vi-VN', {
                            style: 'currency',
                            currency: 'VND'
                        }).format(amount);
                    }

                    function formatDate(dateString) {
                        return new Date(dateString).toLocaleDateString('vi-VN');
                    }

                    function getStatusText(status) {
                        const statusMap = {
                            'completed': 'Hoàn thành',
                            'pending': 'Đang xử lý',
                            'failed': 'Thất bại'
                        };
                        return statusMap[status] || status;
                    }

                    function showLoading(show) {
                        const loading = document.getElementById('loading');
                        const content = document.querySelector('.container');

                        if (show) {
                            loading.style.display = 'block';
                            content.style.opacity = '0.5';
                        } else {
                            loading.style.display = 'none';
                            content.style.opacity = '1';
                        }
                    }

                    function exportReport() {
                        // Implement export functionality
                        alert('Chức năng xuất báo cáo sẽ được triển khai sau!');
                    }

                    function viewAllTransactions() {
                        // Implement view all transactions
                        alert('Chức năng xem tất cả giao dịch sẽ được triển khai sau!');
                    }

                    // Set default dates
                    document.addEventListener('DOMContentLoaded', function () {
                        const today = new Date();
                        const thirtyDaysAgo = new Date();
                        thirtyDaysAgo.setDate(today.getDate() - 30);

                        document.getElementById('endDate').value = today.toISOString().split('T')[0];
                        document.getElementById('startDate').value = thirtyDaysAgo.toISOString().split('T')[0];
                    });
                </script>
            </body>

            </html>