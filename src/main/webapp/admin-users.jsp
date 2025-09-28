<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý người dùng - Thư viện số</title>
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
                            <a class="nav-link" href="admin-loans">
                                <i class="fas fa-hand-holding"></i> Quản lý mượn trả
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="admin-users">
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
                    <h1 class="h2">Quản lý người dùng hệ thống</h1>
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#userModal">
                        <i class="fas fa-plus"></i> Thêm người dùng mới
                    </button>
                </div>

                <c:if test="${param.success == 'save'}">
                    <div class="alert alert-success">Lưu thông tin người dùng thành công!</div>
                </c:if>
                <c:if test="${param.success == 'delete'}">
                    <div class="alert alert-success">Xóa người dùng thành công!</div>
                </c:if>

                <div class="card">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Tên đăng nhập</th>
                                        <th>Họ tên</th>
                                        <th>Email</th>
                                        <th>Vai trò</th>
                                        <th>Trạng thái</th>
                                        <th>Ngày tạo</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="user" items="${users}">
                                        <tr>
                                            <td>${user.id}</td>
                                            <td>${user.username}</td>
                                            <td>${user.fullName}</td>
                                            <td>${user.email}</td>
                                            <td>
                                                <span class="badge ${user.role == 'ADMIN' ? 'bg-danger' : 'bg-info'}">
                                                    ${user.role == 'ADMIN' ? 'Quản trị viên' : 'Nhân viên'}
                                                </span>
                                            </td>
                                            <td>
                                                <span class="badge ${user.active ? 'bg-success' : 'bg-secondary'}">
                                                    ${user.active ? 'Hoạt động' : 'Tạm khóa'}
                                                </span>
                                            </td>
                                            <td><fmt:formatDate value="${user.createdDate}" pattern="dd/MM/yyyy" /></td>
                                            <td>
                                                <a href="admin-users?action=edit&id=${user.id}" class="btn btn-sm btn-warning">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <c:if test="${user.id != sessionScope.user.id}">
                                                    <button class="btn btn-sm btn-danger" onclick="deleteUser(${user.id}, '${user.username}')">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </c:if>
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

    <!-- User Modal -->
    <div class="modal fade" id="userModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <form method="post" action="admin-users">
                    <div class="modal-header">
                        <h5 class="modal-title">Thêm người dùng mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="username" class="form-label">Tên đăng nhập *</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="password" class="form-label">Mật khẩu *</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="fullName" class="form-label">Họ tên *</label>
                            <input type="text" class="form-control" id="fullName" name="fullName" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email">
                        </div>
                        
                        <div class="mb-3">
                            <label for="role" class="form-label">Vai trò *</label>
                            <select class="form-select" id="role" name="role" required>
                                <option value="STAFF">Nhân viên</option>
                                <option value="ADMIN">Quản trị viên</option>
                            </select>
                        </div>
                        
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="isActive" name="isActive" checked>
                            <label class="form-check-label" for="isActive">
                                Kích hoạt tài khoản
                            </label>
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
        function deleteUser(userId, username) {
            if (confirm(`Bạn có chắc chắn muốn xóa người dùng "${username}"?`)) {
                window.location.href = `admin-users?action=delete&id=${userId}`;
            }
        }
    </script>
</body>
</html>