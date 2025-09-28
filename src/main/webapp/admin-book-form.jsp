<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Form sách - Thư viện số</title>
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

    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h4>
                            <c:choose>
                                <c:when test="${book != null}">
                                    <i class="fas fa-edit"></i> Chỉnh sửa sách
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-plus"></i> Thêm sách mới
                                </c:otherwise>
                            </c:choose>
                        </h4>
                    </div>
                    <div class="card-body">
                        <form method="post" action="admin-books">
                            <c:if test="${book != null}">
                                <input type="hidden" name="bookId" value="${book.id}">
                            </c:if>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="title" class="form-label">Tiêu đề sách *</label>
                                        <input type="text" class="form-control" id="title" name="title" 
                                               value="${book != null ? book.title : ''}" required>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="quantity" class="form-label">Số lượng *</label>
                                        <input type="number" class="form-control" id="quantity" name="quantity" 
                                               value="${book != null ? book.quantity : 1}" min="1" required>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="description" class="form-label">Mô tả</label>
                                        <textarea class="form-control" id="description" name="description" rows="4">${book != null ? book.description : ''}</textarea>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Tác giả</label>
                                <div class="border p-3" style="max-height: 300px; overflow-y: auto;">
                                    <div class="row">
                                        <c:forEach var="author" items="${authors}">
                                            <div class="col-md-4 mb-2">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" name="authorIds" 
                                                           value="${author.id}" id="author${author.id}"
                                                           <c:forEach var="bookAuthor" items="${book.authors}">
                                                               <c:if test="${bookAuthor.id == author.id}">checked</c:if>
                                                           </c:forEach>>
                                                    <label class="form-check-label" for="author${author.id}">
                                                        ${author.name}
                                                    </label>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Lưu
                                </button>
                                <a href="admin-books" class="btn btn-secondary">
                                    <i class="fas fa-times"></i> Hủy
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>