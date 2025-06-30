<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Sàng lọc hồ sơ - Recruitment Process</title>
            <link rel="stylesheet" href="assets/css/admin-tables.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
            <style>
                .screening-form {
                    background: white;
                    border-radius: 10px;
                    padding: 25px;
                    margin-bottom: 30px;
                    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
                }

                .form-group {
                    margin-bottom: 20px;
                }

                .form-group label {
                    display: block;
                    margin-bottom: 8px;
                    font-weight: 600;
                    color: #333;
                }

                .form-group input,
                .form-group select,
                .form-group textarea {
                    width: 100%;
                    padding: 12px;
                    border: 2px solid #e0e0e0;
                    border-radius: 8px;
                    font-size: 0.9rem;
                    transition: border-color 0.3s ease;
                }

                .form-group input:focus,
                .form-group select:focus,
                .form-group textarea:focus {
                    outline: none;
                    border-color: #00b894;
                }

                .form-row {
                    display: grid;
                    grid-template-columns: 1fr 1fr;
                    gap: 20px;
                }

                .candidate-card {
                    background: white;
                    border-radius: 10px;
                    padding: 20px;
                    margin-bottom: 15px;
                    box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
                    border-left: 4px solid #00b894;
                    transition: all 0.3s ease;
                }

                .candidate-card:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 5px 20px rgba(0, 184, 148, 0.15);
                }

                .candidate-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 15px;
                }

                .candidate-info h4 {
                    color: #333;
                    margin-bottom: 5px;
                }

                .candidate-info p {
                    color: #666;
                    font-size: 0.9rem;
                }

                .screening-actions {
                    display: flex;
                    gap: 10px;
                }

                .btn-sm {
                    padding: 6px 12px;
                    font-size: 0.8rem;
                }

                .criteria-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                    gap: 15px;
                    margin-bottom: 20px;
                }

                .criteria-item {
                    background: #f8f9fa;
                    border-radius: 8px;
                    padding: 15px;
                    border-left: 3px solid #00b894;
                }

                .criteria-item h5 {
                    color: #00b894;
                    margin-bottom: 8px;
                    font-size: 0.9rem;
                }

                .criteria-item p {
                    color: #666;
                    font-size: 0.8rem;
                    margin: 0;
                }

                .score-input {
                    width: 60px !important;
                    text-align: center;
                    font-weight: bold;
                }

                .modal {
                    display: none;
                    position: fixed;
                    z-index: 1000;
                    left: 0;
                    top: 0;
                    width: 100%;
                    height: 100%;
                    background-color: rgba(0, 0, 0, 0.5);
                }

                .modal-content {
                    background-color: white;
                    margin: 5% auto;
                    padding: 30px;
                    border-radius: 15px;
                    width: 80%;
                    max-width: 600px;
                    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
                }

                .close {
                    color: #aaa;
                    float: right;
                    font-size: 28px;
                    font-weight: bold;
                    cursor: pointer;
                }

                .close:hover {
                    color: #000;
                }
            </style>
        </head>

        <body>
            <div class="container">
                <div class="page-header">
                    <h2><i class="fas fa-search"></i> Sàng lọc hồ sơ</h2>
                    <p>Đánh giá và sàng lọc ứng viên theo tiêu chí tuyển dụng</p>
                </div>

                <div class="table-container">
                    <!-- Screening Criteria -->
                    <div class="screening-form">
                        <h3><i class="fas fa-clipboard-list"></i> Tiêu chí sàng lọc</h3>
                        <div class="criteria-grid">
                            <div class="criteria-item">
                                <h5><i class="fas fa-graduation-cap"></i> Bằng cấp</h5>
                                <p>Kiểm tra trình độ học vấn phù hợp với yêu cầu công việc</p>
                            </div>
                            <div class="criteria-item">
                                <h5><i class="fas fa-briefcase"></i> Kinh nghiệm</h5>
                                <p>Đánh giá số năm kinh nghiệm làm việc trong lĩnh vực</p>
                            </div>
                            <div class="criteria-item">
                                <h5><i class="fas fa-key"></i> Kỹ năng chuyên môn</h5>
                                <p>Kiểm tra các kỹ năng kỹ thuật cần thiết cho vị trí</p>
                            </div>
                            <div class="criteria-item">
                                <h5><i class="fas fa-language"></i> Ngoại ngữ</h5>
                                <p>Đánh giá khả năng ngoại ngữ theo yêu cầu công việc</p>
                            </div>
                            <div class="criteria-item">
                                <h5><i class="fas fa-users"></i> Văn hóa công ty</h5>
                                <p>Kiểm tra sự phù hợp về văn hóa và giá trị công ty</p>
                            </div>
                            <div class="criteria-item">
                                <h5><i class="fas fa-star"></i> Tổng quan</h5>
                                <p>Đánh giá tổng thể về hồ sơ ứng viên</p>
                            </div>
                        </div>
                    </div>

                    <!-- Candidates List -->
                    <c:choose>
                        <c:when test="${empty processes}">
                            <div class="empty-state">
                                <i class="fas fa-clipboard-check"></i>
                                <h3>Không có ứng viên cần sàng lọc</h3>
                                <p>Tất cả hồ sơ đã được xử lý hoặc chưa có đơn ứng tuyển mới</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <h3><i class="fas fa-users"></i> Danh sách ứng viên cần sàng lọc (${processes.size()})</h3>

                            <c:forEach var="process" items="${processes}">
                                <div class="candidate-card">
                                    <div class="candidate-header">
                                        <div class="candidate-info">
                                            <h4>Application #${process.applicationId}</h4>
                                            <p><i class="fas fa-clock"></i> Cập nhật: ${process.updatedAt}</p>
                                            <p><i class="fas fa-user"></i> HR: ID ${process.assignedHrId} | Recruiter:
                                                ID ${process.assignedRecruiterId}</p>
                                        </div>
                                        <div class="screening-actions">
                                            <button class="btn btn-primary btn-sm"
                                                onclick="openScreeningModal(${process.id})">
                                                <i class="fas fa-edit"></i> Đánh giá
                                            </button>
                                            <button class="btn btn-success btn-sm" onclick="quickPass(${process.id})">
                                                <i class="fas fa-check"></i> Pass
                                            </button>
                                            <button class="btn btn-secondary btn-sm" onclick="quickFail(${process.id})">
                                                <i class="fas fa-times"></i> Fail
                                            </button>
                                        </div>
                                    </div>

                                    <c:if test="${not empty process.notes}">
                                        <div
                                            style="background: #f8f9fa; padding: 10px; border-radius: 5px; margin-top: 10px;">
                                            <strong>Ghi chú:</strong> ${process.notes}
                                        </div>
                                    </c:if>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>

                    <div class="action-buttons">
                        <a href="recruitment_dashboard.jsp" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Quay lại Dashboard
                        </a>
                        <a href="recruitment/phone-interview" class="btn btn-primary">
                            <i class="fas fa-phone"></i> Phỏng vấn điện thoại
                        </a>
                    </div>
                </div>
            </div>

            <!-- Screening Modal -->
            <div id="screeningModal" class="modal">
                <div class="modal-content">
                    <span class="close" onclick="closeScreeningModal()">&times;</span>
                    <h3><i class="fas fa-edit"></i> Đánh giá sàng lọc</h3>

                    <form action="recruitment/screening-result" method="post">
                        <input type="hidden" id="processId" name="processId">

                        <div class="form-row">
                            <div class="form-group">
                                <label for="screeningType">Loại sàng lọc</label>
                                <select id="screeningType" name="screeningType" required>
                                    <option value="automated">Automated Screening</option>
                                    <option value="manual">Manual Review</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="reviewerName">Người đánh giá</label>
                                <input type="text" id="reviewerName" name="reviewerName" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="score">Điểm số (1-10)</label>
                            <input type="number" id="score" name="score" min="1" max="10" class="score-input" required>
                        </div>

                        <div class="form-group">
                            <label for="result">Kết quả</label>
                            <select id="result" name="result" required>
                                <option value="pass">Pass</option>
                                <option value="fail">Fail</option>
                                <option value="shortlist">Shortlist</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="feedback">Nhận xét chi tiết</label>
                            <textarea id="feedback" name="feedback" rows="4"
                                placeholder="Nhập nhận xét chi tiết về ứng viên..."></textarea>
                        </div>

                        <div class="action-buttons">
                            <button type="button" class="btn btn-secondary" onclick="closeScreeningModal()">
                                <i class="fas fa-times"></i> Hủy
                            </button>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Lưu đánh giá
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <script>
                function openScreeningModal(processId) {
                    document.getElementById('processId').value = processId;
                    document.getElementById('screeningModal').style.display = 'block';
                }

                function closeScreeningModal() {
                    document.getElementById('screeningModal').style.display = 'none';
                }

                function quickPass(processId) {
                    if (confirm('Xác nhận pass ứng viên này?')) {
                        // Submit quick pass form
                        const form = document.createElement('form');
                        form.method = 'POST';
                        form.action = 'recruitment/screening-result';

                        const fields = {
                            'processId': processId,
                            'screeningType': 'manual',
                            'result': 'pass',
                            'score': '8',
                            'feedback': 'Quick pass - Đáp ứng yêu cầu cơ bản',
                            'reviewerName': 'System'
                        };

                        for (const [key, value] of Object.entries(fields)) {
                            const input = document.createElement('input');
                            input.type = 'hidden';
                            input.name = key;
                            input.value = value;
                            form.appendChild(input);
                        }

                        document.body.appendChild(form);
                        form.submit();
                    }
                }

                function quickFail(processId) {
                    if (confirm('Xác nhận fail ứng viên này?')) {
                        // Submit quick fail form
                        const form = document.createElement('form');
                        form.method = 'POST';
                        form.action = 'recruitment/screening-result';

                        const fields = {
                            'processId': processId,
                            'screeningType': 'manual',
                            'result': 'fail',
                            'score': '3',
                            'feedback': 'Quick fail - Không đáp ứng yêu cầu',
                            'reviewerName': 'System'
                        };

                        for (const [key, value] of Object.entries(fields)) {
                            const input = document.createElement('input');
                            input.type = 'hidden';
                            input.name = key;
                            input.value = value;
                            form.appendChild(input);
                        }

                        document.body.appendChild(form);
                        form.submit();
                    }
                }

                // Close modal when clicking outside
                window.onclick = function (event) {
                    const modal = document.getElementById('screeningModal');
                    if (event.target == modal) {
                        closeScreeningModal();
                    }
                }
            </script>
        </body>

        </html>