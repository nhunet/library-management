<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý tác giả - Thư viện số</title>
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
                            <a class="nav-link active" href="admin-authors">
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
                    <h1 class="h2">Quản lý tác giả</h1>
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#authorModal">
                        <i class="fas fa-plus"></i> Thêm tác giả mới
                    </button>
                </div>

                <c:if test="${param.success == 'save'}">
                    <div class="alert alert-success">Lưu thông tin tác giả thành công!</div>
                </c:if>
                <c:if test="${param.success == 'delete'}">
                    <div class="alert alert-success">Xóa tác giả thành công!</div>
                </c:if>

                <div class="card">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Tên tác giả</th>
                                        <th>Quốc tịch</th>
                                        <th>Ngày sinh</th>
                                        <th>Tiểu sử</th>
                                        <th>Ngày tạo</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="author" items="${authors}">
                                        <tr>
                                            <td>${author.id}</td>
                                            <td>${author.name}</td>
                                            <td>${author.nationality}</td>
                                            <td>
                                                <c:if test="${author.birthDate != null}">
                                                    <fmt:formatDate value="${author.birthDate}" pattern="dd/MM/yyyy" />
                                                </c:if>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${author.biography.length() > 50}">
                                                        ${author.biography.substring(0, 50)}...
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${author.biography}
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td><fmt:formatDate value="${author.createdDate}" pattern="dd/MM/yyyy" /></td>
                                            <td>
                                                <a href="admin-authors?action=edit&id=${author.id}" class="btn btn-sm btn-warning">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <button class="btn btn-sm btn-danger" onclick="deleteAuthor(${author.id}, '${author.name}')">
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

    <!-- Author Modal -->
    <div class="modal fade" id="authorModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <form method="post" action="admin-authors">
                    <div class="modal-header">
                        <h5 class="modal-title">Thêm tác giả mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="name" class="form-label">Tên tác giả *</label>
                            <input type="text" class="form-control" id="name" name="name" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="nationality" class="form-label">Quốc tịch</label>
                            <input type="text" class="form-control" id="nationality" name="nationality">
                        </div>
                        
                        <div class="mb-3">
                            <label for="birthDate" class="form-label">Ngày sinh</label>
                            <input type="date" class="form-control" id="birthDate" name="birthDate">
                        </div>
                        
                        <div class="mb-3">
                            <label for="biography" class="form-label">Tiểu sử</label>
                            <textarea class="form-control" id="biography" name="biography" rows="4"></textarea>
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
        function deleteAuthor(authorId, name) {
            if (confirm(`Bạn có chắc chắn muốn xóa tác giả "${name}"?`)) {
                window.location.href = `admin-authors?action=delete&id=${authorId}`;
            }
        }
    </script>
</body>
</html>