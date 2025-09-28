<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý mượn trả - Thư viện số</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-danger">
        <div class="container-fluid">
            <a class="navbar-brand" href="admin-dashboard">
                <i class="fas fa-tachometer-alt"></i> Quản trị thư viện
            </a>
            <div class="navbar-nav ms-auto">
                <span class="navbar-text me-3">
                    Xin chào, ${sessionScope.user.fullName}!
                </span>
                <a class="nav-link" href="logout?type=admin">
                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                </a>
            </div>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
                <div class="position-sticky pt-3">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="admin-dashboard">
                                <i class="fas fa-tachometer-alt"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="admin-books">
                                <i class="fas fa-book"></i> Quản lý sách
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="admin-authors">
                                <i class="fas fa-user-edit"></i> Quản lý tác giả
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="admin-members">
                                <i class="fas fa-users"></i> Quản lý thành viên
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="admin-loans">
                                <i class="fas fa-hand-holding"></i> Quản lý mượn trả
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="admin-users">
                                <i class="fas fa-user-cog"></i> Quản lý người dùng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="admin-statistics">
                                <i class="fas fa-chart-bar"></i> Thống kê
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Quản lý mượn trả sách</h1>
                </div>

                <c:if test="${param.success == 'return'}">
                    <div class="alert alert-success">Trả sách thành công!</div>
                </c:if>

                <div class="card">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Thành viên</th>
                                        <th>Tên sách</th>
                                        <th>Ngày mượn</th>
                                        <th>Ngày hẹn trả</th>
                                        <th>Ngày trả</th>
                                        <th>Trạng thái</th>
                                        <th>Ghi chú</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="loan" items="${loans}">
                                        <tr class="${loan.overdue && loan.status == 'ACTIVE' ? 'table-warning' : ''}">
                                            <td>${loan.id}</td>
                                            <td>
                                                <div>
                                                    <strong>${loan.member.fullName}</strong><br>
                                                    <small class="text-muted">${loan.member.memberCode}</small>
                                                </div>
                                            </td>
                                            <td>${loan.book.title}</td>
                                            <td><fmt:formatDate value="${loan.loanDate}" pattern="dd/MM/yyyy" /></td>
                                            <td><fmt:formatDate value="${loan.dueDate}" pattern="dd/MM/yyyy" /></td>
                                            <td>
                                                <c:if test="${loan.returnDate != null}">
                                                    <fmt:formatDate value="${loan.returnDate}" pattern="dd/MM/yyyy" />
                                                </c:if>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${loan.status == 'ACTIVE'}">
                                                        <c:choose>
                                                            <c:when test="${loan.overdue}">
                                                                <span class="badge bg-danger">Quá hạn</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-warning">Đang mượn</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:when>
                                                    <c:when test="${loan.status == 'RETURNED'}">
                                                        <span class="badge bg-success">Đã trả</span>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>${loan.notes}</td>
                                            <td>
                                                <c:if test="${loan.status == 'ACTIVE'}">
                                                    <button class="btn btn-sm btn-success" 
                                                            onclick="returnBook(${loan.id}, '${loan.book.title}', '${loan.member.fullName}')">
                                                        <i class="fas fa-check"></i> Trả sách
                                                    </button>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        
                        <c:if test="${empty loans}">
                            <div class="text-center text-muted py-4">
                                <i class="fas fa-inbox fa-3x mb-3"></i>
                                <p>Không có giao dịch mượn trả nào</p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function returnBook(loanId, bookTitle, memberName) {
            if (confirm(`Xác nhận trả sách "${bookTitle}" của thành viên "${memberName}"?`)) {
                window.location.href = `admin-loans?action=return&id=${loanId}`;
            }
        }
    </script>
</body>