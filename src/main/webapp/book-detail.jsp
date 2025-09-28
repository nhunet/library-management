<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${book.title} - Thư viện số</title>
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
                <a href="/" class="btn btn-secondary mb-3">
                    <i class="fas fa-arrow-left"></i> Về trang chủ
                </a>
                
                <div class="card">
                    <div class="card-body">
                        <h2 class="card-title">${book.title}</h2>
                        <p class="card-text">${book.description}</p>
                        
                        <div class="mb-3">
                            <strong>Tác giả:</strong>
                            <c:forEach var="author" items="${book.authors}" varStatus="status">
                                ${author.name}<c:if test="${!status.last}">, </c:if>
                            </c:forEach>
                        </div>
                        
                        <div class="mb-3">
                            <strong>Số lượng:</strong> ${book.quantity}
                        </div>
                        
                        <div class="mb-3">
                            <strong>Có sẵn:</strong> 
                            <span class="badge ${book.availableForLoan ? 'bg-success' : 'bg-danger'}">
                                ${book.availableQuantity} cuốn
                            </span>
                        </div>
                        
                        <c:if test="${book.availableForLoan}">
                            <c:choose>
                                <c:when test="${sessionScope.member != null}">
                                    <form method="post" action="loan-book" class="d-inline">
                                        <input type="hidden" name="bookId" value="${book.id}">
                                        <button type="submit" class="btn btn-success">
                                            <i class="fas fa-hand-holding"></i> Mượn sách
                                        </button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <a href="member-login.jsp" class="btn btn-primary">
                                        <i class="fas fa-sign-in-alt"></i> Đăng nhập để mượn sách
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>