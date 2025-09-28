<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý sách - Thư viện số</title>
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
                            <a class="nav-link active" href="admin-books">
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
                            <a class="nav-link" href="admin-loans">
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
                    <h1 class="h2">Quản lý sách</h1>
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#bookModal">
                        <i class="fas fa-plus"></i> Thêm sách mới
                    </button>
                </div>

                <c:if test="${param.success == 'save'}">
                    <div class="alert alert-success">Lưu thông tin sách thành công!</div>
                </c:if>
                <c:if test="${param.success == 'delete'}">
                    <div class="alert alert-success">Xóa sách thành công!</div>
                </c:if>

                <div class="card">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Tiêu đề</th>
                                        <th>Tác giả</th>
                                        <th>Số lượng</th>
                                        <th>Có sẵn</th>
                                        <th>Ngày tạo</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="book" items="${books}">
                                        <tr>
                                            <td>${book.id}</td>
                                            <td>${book.title}</td>
                                            <td>
                                                <c:forEach var="author" items="${book.authors}" varStatus="status">
                                                    ${author.name}<c:if test="${!status.last}">, </c:if>
                                                </c:forEach>
                                            </td>
                                            <td>${book.quantity}</td>
                                            <td>
                                                <span class="badge ${book.availableForLoan ? 'bg-success' : 'bg-danger'}">
                                                    ${book.availableQuantity}
                                                </span>
                                            </td>
                                            <td><fmt:formatDate value="${book.createdDate}" pattern="dd/MM/yyyy" /></td>
                                            <td>
                                                <button class="btn btn-sm btn-warning" onclick="editBook(${book.id})">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button class="btn btn-sm btn-danger" onclick="deleteBook(${book.id}, '${book.title}')">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Book Modal -->
    <div class="modal fade" id="bookModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <form method="post" action="admin-books">
                    <div class="modal-header">
                        <h5 class="modal-title">Thêm/Sửa sách</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" id="bookId" name="bookId">
                        
                        <div class="mb-3">
                            <label for="title" class="form-label">Tiêu đề sách *</label>
                            <input type="text" class="form-control" id="title" name="title" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="description" class="form-label">Mô tả</label>
                            <textarea class="form-control" id="description" name="description" rows="3"></textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label for="quantity" class="form-label">Số lượng *</label>
                            <input type="number" class="form-control" id="quantity" name="quantity" min="1" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Tác giả</label>
                            <div class="border p-3" style="max-height: 200px; overflow-y: auto;">
                                <c:forEach var="author" items="${authors}">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="authorIds" value="${author.id}" id="author${author.id}">
                                        <label class="form-check-label" for="author${author.id}">
                                            ${author.name}
                                        </label>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Lưu</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function editBook(bookId) {
            fetch(`admin-books?action=edit&id=${bookId}`)
                .then(response => response.text())
                .then(data => {
                    // This would need additional implementation to populate the modal
                    // For simplicity, redirecting to the edit form
                    window.location.href = `admin-books?action=edit&id=${bookId}`;
                });
        }

        function deleteBook(bookId, title) {
            if (confirm(`Bạn có chắc chắn muốn xóa sách "${title}"?`)) {
                window.location.href = `admin-books?action=delete&id=${bookId}`;
            }
        }
    </script>
</body>
</html>