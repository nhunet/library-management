# Hệ thống quản lý thư viện - Library Management System

## Tổng quan
Hệ thống quản lý thư viện được phát triển bằng Java Servlet với cơ sở dữ liệu DB4O, cung cấp các chức năng quản lý sách, tác giả, thành viên, mượn trả sách và báo cáo thống kê.

## Công nghệ sử dụng
- **Backend:** Java Servlet, JSP
- **Database:** DB4O (Object Database)
- **Frontend:** Bootstrap 5, Font Awesome
- **Build Tool:** Maven
- **Application Server:** Tomcat 10

## Cấu trúc dự án
```
src/
├── main/
│   ├── java/
│   │   ├── model/          # Các lớp đối tượng
│   │   ├── service/        # Service layer
│   │   └── servlet/        # Web servlets
│   └── webapp/
│       ├── WEB-INF/
│       │   └── web.xml
│       └── *.jsp           # JSP pages
└── pom.xml
```

## Các lớp đối tượng chính
- **Book:** Quản lý thông tin sách
- **Author:** Quản lý thông tin tác giả
- **Member:** Quản lý thành viên thư viện
- **User:** Quản lý tài khoản admin/staff
- **Loan:** Quản lý việc mượn trả sách

## Chức năng hệ thống

### Phần Web User (Thành viên)
- Xem danh sách sách có sẵn
- Xem chi tiết từng cuốn sách
- Đăng nhập và mượn sách
- Theo dõi lịch sử mượn sách

### Phần Web Admin
- **Dashboard:** Tổng quan thống kê hệ thống
- **Quản lý sách:** CRUD operations cho sách
- **Quản lý tác giả:** CRUD operations cho tác giả  
- **Quản lý thành viên:** CRUD operations cho thành viên
- **Quản lý mượn trả:** Theo dõi và xử lý việc mượn trả sách
- **Quản lý người dùng:** CRUD operations cho admin users
- **Báo cáo thống kê:** Thống kê sách được mượn theo tháng

## Cài đặt và chạy

### Yêu cầu hệ thống
- Java 11+
- Apache Tomcat 11
- Maven 3.9+

### Các bước cài đặt

1. **Clone project:**
```bash
git clone <repository-url>
cd library-management-system
```

2. **Build project với Maven:**
```bash
mvn clean compile
mvn package
```

3. **Deploy lên Tomcat:**
- Copy file `.war` từ thư mục `target/` vào thư mục `webapps/` của Tomcat
- Start Tomcat server

4. **Truy cập ứng dụng:**
- Trang chủ: `http://localhost:8080/library-management/`
- Admin login: `http://localhost:8080/library-management/admin-login.jsp`

### Tài khoản mặc định
- **Admin:** admin / admin123
- **Member:** member@example.com / 123456

## Cơ sở dữ liệu
Hệ thống sử dụng DB4O - một object database không cần cấu hình phức tạp. File database (`library.db4o`) sẽ được tạo tự động khi khởi chạy ứng dụng lần đầu.

## Tính năng nổi bật
- **Responsive Design:** Giao diện thân thiện trên mọi thiết bị
- **Real-time Updates:** Cập nhật số lượng sách available khi mượn/trả
- **Security:** Session management và access control
- **Statistics:** Báo cáo thống kê theo thời gian
- **Data Validation:** Kiểm tra dữ liệu đầu vào

## Cấu trúc URL

### Public URLs
- `/` - Trang chủ
- `/book-detail?id=<id>` - Chi tiết sách
- `/member-login` - Đăng nhập thành viên

### Member URLs  
- `/member-dashboard` - Dashboard thành viên
- `/loan-book` - Mượn sách

### Admin URLs
- `/admin-login` - Đăng nhập admin
- `/admin-dashboard` - Dashboard admin
- `/admin-books` - Quản lý sách
- `/admin-authors` - Quản lý tác giả
- `/admin-members` - Quản lý thành viên
- `/admin-loans` - Quản lý mượn trả
- `/admin-users` - Quản lý người dùng
- `/admin-statistics` - Thống kê

## Mở rộng hệ thống
Hệ thống được thiết kế modular, dễ dàng mở rộng:
- Thêm các loại sách (categories)
- Tích hợp email notification
- Báo cáo chi tiết hơn
- API REST cho mobile app
- Tích hợp thanh toán phí phạt