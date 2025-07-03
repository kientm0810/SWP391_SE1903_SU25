<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Báo cáo doanh thu - Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
    <jsp:include page="admin-common-styles.jsp" />
    <style>
        .reports-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 30px;
            margin-top: 30px;
        }
        
        .chart-container {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        .chart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #e0e0e0;
        }
        
        .chart-title {
            font-size: 20px;
            font-weight: bold;
            color: #2e7d32;
        }
        
        .chart-subtitle {
            font-size: 14px;
            color: #666;
            margin-top: 5px;
        }
        
        .chart-canvas {
            position: relative;
            height: 400px;
            margin-top: 20px;
        }
        
        .page-stats {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
        }
        
        .overall-stat {
            text-align: center;
            padding: 20px;
            border-radius: 10px;
            background: linear-gradient(135deg, #f1f8e9 0%, #ffffff 100%);
            border: 1px solid #e8f5e8;
        }
        
        .overall-stat-value {
            font-size: 28px;
            font-weight: bold;
            color: #2e7d32;
            margin-bottom: 8px;
        }
        
        .overall-stat-label {
            color: #666;
            font-size: 14px;
            font-weight: 500;
        }
        
        .chart-controls {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        
        .btn-refresh {
            background: #4caf50;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            transition: background 0.3s;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .btn-refresh:hover {
            background: #45a049;
        }
        
        .loading {
            display: none;
            text-align: center;
            color: #666;
            padding: 40px;
        }
        
        .export-buttons {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }
        
        .btn-export {
            background: #2196f3;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 13px;
            transition: background 0.3s;
        }
        
        .btn-export:hover {
            background: #1976d2;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <jsp:include page="sidebar.jsp" />
        
        <div class="main-content">
            <div class="page-header">
                <h1>Báo cáo doanh thu</h1>
<!--                <div class="header-actions">
                    <button onclick="refreshAllCharts()" class="btn btn-primary">
                        <i class="fas fa-sync-alt"></i>
                        Cập nhật dữ liệu
                    </button>
                </div>-->
            </div>
            
            <!-- Tổng quan thống kê -->
            <div class="page-stats">
                <h3 style="margin-bottom: 20px; color: #2e7d32;">Tổng quan doanh thu</h3>
                <div class="stats-grid">
                    <div class="overall-stat">
                        <div class="overall-stat-value">
                            <fmt:formatNumber value="${stats.monthlyRevenue}" pattern="#,###" /> VNĐ
                        </div>
                        <div class="overall-stat-label">Doanh thu tháng này</div>
                    </div>
                    <div class="overall-stat">
                        <div class="overall-stat-value">
                            <fmt:formatNumber value="${stats.totalRevenue}" pattern="#,###" /> VNĐ
                        </div>
                        <div class="overall-stat-label">Tổng doanh thu</div>
                    </div>
                    <div class="overall-stat">
                        <div class="overall-stat-value">${stats.transactionCount}</div>
                        <div class="overall-stat-label">Giao dịch tháng này</div>
                    </div>
                    <div class="overall-stat">
                        <div class="overall-stat-value">
                            <fmt:formatNumber value="${stats.totalRevenue / 12}" pattern="#,###" /> VNĐ
                        </div>
                        <div class="overall-stat-label">Trung bình/tháng</div>
                    </div>
                </div>
            </div>
            
            <!-- Biểu đồ doanh thu -->
            <div class="reports-grid">
                <!-- Biểu đồ tổng doanh thu -->
                <div class="chart-container">
                    <div class="chart-header">
                        <div>
                            <div class="chart-title">Tổng doanh thu theo tháng</div>
                            <div class="chart-subtitle">Doanh thu từ tất cả các giao dịch đã hoàn thành (12 tháng gần nhất)</div>
                        </div>
<!--                        <div class="chart-controls">
                            <button onclick="refreshChart('total')" class="btn-refresh">
                                <i class="fas fa-sync-alt"></i>
                                Cập nhật
                            </button>
                        </div>-->
                    </div>
                    <div class="chart-canvas">
                        <canvas id="totalRevenueChart"></canvas>
                    </div>
                    <div class="loading" id="totalLoading">
                        <i class="fas fa-spinner fa-spin"></i>
                        Đang tải dữ liệu...
                    </div>
                </div>
                
                <!-- Biểu đồ doanh thu promotion -->
                <div class="chart-container">
                    <div class="chart-header">
                        <div>
                            <div class="chart-title">Doanh thu từ chương trình khuyến mãi</div>
                            <div class="chart-subtitle">Doanh thu từ việc đăng ký các gói promotion (12 tháng gần nhất)</div>
                        </div>
<!--                        <div class="chart-controls">
                            <button onclick="refreshChart('promotion')" class="btn-refresh">
                                <i class="fas fa-sync-alt"></i>
                                Cập nhật
                            </button>
                        </div>-->
                    </div>
                    <div class="chart-canvas">
                        <canvas id="promotionRevenueChart"></canvas>
                    </div>
                    <div class="loading" id="promotionLoading">
                        <i class="fas fa-spinner fa-spin"></i>
                        Đang tải dữ liệu...
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        // Dữ liệu từ server
        const totalRevenueData = ${totalRevenueData};
        const promotionRevenueData = ${promotionRevenueData};
        
        let totalChart = null;
        let promotionChart = null;
        
        // Khởi tạo biểu đồ khi trang load
        document.addEventListener('DOMContentLoaded', function() {
            initTotalRevenueChart();
            initPromotionRevenueChart();
        });
        
        // Biểu đồ tổng doanh thu
        function initTotalRevenueChart() {
            const ctx = document.getElementById('totalRevenueChart').getContext('2d');
            
            const labels = totalRevenueData.map(item => item.month);
            const data = totalRevenueData.map(item => item.revenue);
            
            totalChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Doanh thu (VNĐ)',
                        data: data,
                        borderColor: '#4caf50',
                        backgroundColor: 'rgba(76, 175, 80, 0.1)',
                        borderWidth: 3,
                        fill: true,
                        tension: 0.4,
                        pointBackgroundColor: '#4caf50',
                        pointBorderColor: '#ffffff',
                        pointBorderWidth: 2,
                        pointRadius: 6
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: true,
                            position: 'top'
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                callback: function(value) {
                                    return new Intl.NumberFormat('vi-VN').format(value) + ' VNĐ';
                                }
                            }
                        }
                    },
                    interaction: {
                        intersect: false,
                        mode: 'index'
                    },
                    elements: {
                        point: {
                            hoverRadius: 8
                        }
                    }
                }
            });
        }
        
        // Biểu đồ doanh thu promotion
        function initPromotionRevenueChart() {
            const ctx = document.getElementById('promotionRevenueChart').getContext('2d');
            
            const labels = promotionRevenueData.map(item => item.month);
            const data = promotionRevenueData.map(item => item.revenue);
            
            promotionChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Doanh thu Promotion (VNĐ)',
                        data: data,
                        borderColor: '#2196f3',
                        backgroundColor: 'rgba(33, 150, 243, 0.1)',
                        borderWidth: 3,
                        fill: true,
                        tension: 0.4,
                        pointBackgroundColor: '#2196f3',
                        pointBorderColor: '#ffffff',
                        pointBorderWidth: 2,
                        pointRadius: 6
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: true,
                            position: 'top'
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                callback: function(value) {
                                    return new Intl.NumberFormat('vi-VN').format(value) + ' VNĐ';
                                }
                            }
                        }
                    },
                    interaction: {
                        intersect: false,
                        mode: 'index'
                    },
                    elements: {
                        point: {
                            hoverRadius: 8
                        }
                    }
                }
            });
        }
        
        // Refresh chart data
        function refreshChart(type) {
            const loadingElement = document.getElementById(type + 'Loading');
            loadingElement.style.display = 'block';
            
            fetch('ReportsController?action=data&type=' + type)
                .then(response => response.json())
                .then(data => {
                    const labels = data.map(item => item.month);
                    const values = data.map(item => item.revenue);
                    
                    if (type === 'total') {
                        totalChart.data.labels = labels;
                        totalChart.data.datasets[0].data = values;
                        totalChart.update();
                    } else if (type === 'promotion') {
                        promotionChart.data.labels = labels;
                        promotionChart.data.datasets[0].data = values;
                        promotionChart.update();
                    }
                    
                    loadingElement.style.display = 'none';
                })
                .catch(error => {
                    console.error('Error:', error);
                    loadingElement.style.display = 'none';
                    alert('Có lỗi xảy ra khi tải dữ liệu!');
                });
        }
        
        // Refresh all charts
        function refreshAllCharts() {
            location.reload();
        }
    </script>
</body>
</html>