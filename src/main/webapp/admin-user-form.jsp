<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Form người dùng - Thư viện số</title>
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
                                <c:when test="${user != null}">
                                    <i class="fas fa-edit"></i> Chỉnh sửa người dùng
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-plus"></i> Thêm người dùng mới
                                </c:otherwise>
                            </c:choose>
                        </h4>
                    </div>
                    <div class="card-body">
                        <form method="post" action="admin-users">
                            <c:if test="${user != null}">
                                <input type="hidden" name="userId" value="${user.id}">
                            </c:if>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="username" class="form-label">Tên đăng nhập *</label>
                                        <input type="text" class="form-control" id="username" name="username" 
                                               value="${user != null ? user.username : ''}" required>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="password" class="form-label">
                                            Mật khẩu <c:if test="${user != null}"> (để trống nếu không đổi)</c:if>
                                        </label>
                                        <input type="password" class="form-control" id="password" name="password" 
                                               <c:if test="${user == null}">required</c:if>>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="fullName" class="form-label">Họ tên *</label>
                                        <input type="text" class="form-control" id="fullName" name="fullName" 
                                               value="${user != null ? user.fullName : ''}" required>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email</label>
                                        <input type="email" class="form-control" id="email" name="email" 
                                               value="${user != null ? user.email : ''}">
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="role" class="form-label">Vai trò *</label>
                                        <select class="form-select" id="role" name="role" required>
                                            <option value="STAFF" ${user != null && user.role == 'STAFF' ? 'selected' : ''}>Nhân viên</option>
                                            <option value="ADMIN" ${user != null && user.role == 'ADMIN' ? 'selected' : ''}>Quản trị viên</option>
                                        </select>
                                    </div>
                                    
                                    <div class="mb-3 form-check">
                                        <input type="checkbox" class="form-check-input" id="isActive" name="isActive" 
                                               ${user == null || user.active ? 'checked' : ''}>
                                        <label class="form-check-label" for="isActive">
                                            Kích hoạt tài khoản
                                        </label>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Lưu
                                </button>
                                <a href="admin-users" class="btn btn-secondary">
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