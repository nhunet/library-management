<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard quản trị - Thư viện số</title>
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
                            <a class="nav-link active" href="admin-dashboard">
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
                    <h1 class="h2">Dashboard</h1>
                </div>

                <div class="row">
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-primary shadow h-100 py-2" style="border-left: 0.25rem solid #4e73df!important;">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                            Tổng số sách
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${bookCount}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-book fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-success shadow h-100 py-2" style="border-left: 0.25rem solid #1cc88a!important;">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                            Tổng thành viên
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${memberCount}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-users fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-info shadow h-100 py-2" style="border-left: 0.25rem solid #36b9cc!important;">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                            Tổng tác giả
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${authorCount}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-user-edit fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-warning shadow h-100 py-2" style="border-left: 0.25rem solid #f6c23e!important;">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                            Lượt mượn tháng này
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${monthlyLoanCount}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-hand-holding fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-12">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">Chào mừng đến với hệ thống quản lý thư viện</h6>
                            </div>
                            <div class="card-body">
                                <p>Sử dụng menu bên trái để quản lý các chức năng của thư viện:</p>
                                <ul>
                                    <li><strong>Quản lý sách:</strong> Thêm, sửa, xóa thông tin sách</li>
                                    <li><strong>Quản lý tác giả:</strong> Quản lý thông tin tác giả</li>
                                    <li><strong>Quản lý thành viên:</strong> Quản lý thành viên thư viện</li>
                                    <li><strong>Quản lý mượn trả:</strong> Theo dõi việc mượn trả sách</li>
                                    <li><strong>Quản lý người dùng:</strong> Quản lý tài khoản quản trị</li>
                                    <li><strong>Thống kê:</strong> Xem báo cáo thống kê</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>