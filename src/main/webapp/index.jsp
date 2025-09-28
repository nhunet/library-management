<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hệ thống quản lý thư viện</title>
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
                <a class="nav-link" href="member-login.jsp">
                    <i class="fas fa-user"></i> Đăng nhập thành viên
                </a>
                <a class="nav-link" href="admin-login.jsp">
                    <i class="fas fa-cog"></i> Quản trị
                </a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <h2><i class="fas fa-books"></i> Danh sách sách</h2>
                <div class="row">
                    <c:forEach var="book" items="${books}">
                        <div class="col-md-4 mb-3">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">${book.title}</h5>
                                    <p class="card-text">${book.description}</p>
                                    <div class="mb-2">
                                        <small class="text-muted">
                                            Tác giả: 
                                            <c:forEach var="author" items="${book.authors}" varStatus="status">
                                                ${author.name}<c:if test="${!status.last}">, </c:if>
                                            </c:forEach>
                                        </small>
                                    </div>
                                    <div class="mb-2">
                                        <span class="badge ${book.availableForLoan ? 'bg-success' : 'bg-danger'}">
                                            ${book.availableQuantity} / ${book.quantity} có sẵn
                                        </span>
                                    </div>
                                    <a href="book-detail?id=${book.id}" class="btn btn-primary btn-sm">
                                        <i class="fas fa-eye"></i> Xem chi tiết
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>