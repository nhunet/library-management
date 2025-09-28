<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard thành viên - Thư viện số</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="/">
                <i class="fas fa-book"></i> Thư viện số
            </a>
            <div class="navbar-nav ms-auto">
                <span class="navbar-text me-3">
                    Xin chào, ${sessionScope.member.fullName}!
                </span>
                <a class="nav-link" href="logout">
                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                </a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <c:if test="${param.success == 'loan'}">
            <div class="alert alert-success">Mượn sách thành công!</div>
        </c:if>
        
        <div class="row">
            <div class="col-12">
                <h2><i class="fas fa-user"></i> Thông tin cá nhân</h2>
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <p><strong>Mã thành viên:</strong> ${sessionScope.member.memberCode}</p>
                                <p><strong>Họ tên:</strong> ${sessionScope.member.fullName}</p>
                                <p><strong>Email:</strong> ${sessionScope.member.email}</p>
                            </div>
                            <div class="col-md-6">
                                <p><strong>Điện thoại:</strong> ${sessionScope.member.phone}</p>
                                <p><strong>Địa chỉ:</strong> ${sessionScope.member.address}</p>
                                <p><strong>Ngày đăng ký:</strong> <fmt:formatDate value="${sessionScope.member.registrationDate}" pattern="dd/MM/yyyy" /></p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <h3><i class="fas fa-list"></i> Lịch sử mượn sách</h3>
                <div class="card">
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty loans}">
                                <div class="table-responsive">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>Tên sách</th>
                                                <th>Ngày mượn</th>
                                                <th>Ngày hẹn trả</th>
                                                <th>Ngày trả</th>
                                                <th>Trạng thái</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="loan" items="${loans}">
                                                <tr>
                                                    <td>${loan.book.title}</td>
                                                    <td><fmt:formatDate value="${loan.loanDate}" pattern="dd/MM/yyyy" /></td>
                                                    <td><fmt:formatDate value="${loan.dueDate}" pattern="dd/MM/yyyy" /></td>
                                                    <td>
                                                        <c:if test="${not empty loan.returnDate}">
                                                            <fmt:formatDate value="${loan.returnDate}" pattern="dd/MM/yyyy" />
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${loan.status == 'ACTIVE'}">
                                                                <span class="badge bg-warning">Đang mượn</span>
                                                            </c:when>
                                                            <c:when test="${loan.status == 'RETURNED'}">
                                                                <span class="badge bg-success">Đã trả</span>
                                                            </c:when>
                                                            <c:when test="${loan.status == 'OVERDUE'}">
                                                                <span class="badge bg-danger">Quá hạn</span>
                                                            </c:when>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <p class="text-muted">Bạn chưa mượn sách nào.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                
                <div class="mt-3">
                    <a href="/" class="btn btn-primary">
                        <i class="fas fa-book"></i> Xem danh sách sách
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>