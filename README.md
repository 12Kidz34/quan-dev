# 🎯 Quan-Dev – Ứng dụng quản lý bán linh kiện PC  
**Branch:** `Java4`

## 🔍 Giới thiệu  
Dự án này được thực hiện trong khuôn khổ môn **JAVA 4 – Lập trình Java Web cơ bản/nâng cao** tại trường …  
Ứng dụng mô phỏng hệ thống quản lý linh kiện máy tính (sản phẩm, kho hàng, đơn hàng, nhân viên, khách hàng…) với ba vai trò chính: **Khách hàng**, **Nhân viên**, **Quản lý**.

## 🛠 Công nghệ sử dụng  
- Ngôn ngữ: Java  
- Framework/Thư viện: Servlet + JSP (hoặc Spring Boot nếu có)  
- ORM/Database: JPA / Hibernate / JDBC → MySQL (hoặc SQL Server)  
- Frontend: JSP + Bootstrap (hoặc HTML/CSS/JS)  
- Công cụ: Git, GitHub, IntelliJ IDEA / Eclipse  
- Kiến trúc: MVC, phân quyền Admin/Staff/User

## 📁 Cấu trúc dự án  

<img width="521" height="309" alt="image" src="https://github.com/user-attachments/assets/027e198e-2c26-4c7f-86ef-c7b12043c434" />

## ✅ Các tính năng chính  
- Đăng ký, đăng nhập với phân quyền: Quản lý / Nhân viên / Khách hàng  
- Quản lý sản phẩm linh kiện (CRUD)  
- Quản lý kho hàng, tồn kho  
- Quản lý đơn hàng, khách hàng  
- Báo cáo/thống kê đơn giản  
- Giao diện người dùng thân thiện  
- Xác thực đầu vào, xử lý lỗi đơn giản

## 🧮 Hướng dẫn cài đặt & chạy dự án  
1. **Clone repository**  
    ```bash
    git clone https://github.com/12Kidz34/quan-dev.git
    cd quan-dev
    git checkout Java4
    ```  
2. **Cấu hình cơ sở dữ liệu**  
   - Tạo database trong MySQL (ví dụ: `quan_dev_db_java4`)  
   - Mở file cấu hình (ví dụ `application.properties` hoặc `jdbc.properties`) và chỉnh:  
     ```properties
     spring.datasource.url=jdbc:mysql://localhost:3306/quan_dev_db_java4
     spring.datasource.username=your_username
     spring.datasource.password=your_password
     ```  
3. **Build và chạy ứng dụng**  
   - Nếu sử dụng Spring Boot: `mvn spring-boot:run` hoặc `./gradlew bootRun`  
   - Nếu sử dụng Servlet/JSP: Deploy lên server như Apache Tomcat hoặc dùng plugin trong IDE  
4. **Truy cập ứng dụng**  
   Mở trình duyệt và vào: `http://localhost:8080` (hoặc port bạn cấu hình)  

## 🧑‍💼 Tài khoản mẫu  
| Vai trò       | Tài khoản   | Mật khẩu |
|--------------|-------------|----------|
| Quản lý      | manager     | 123      |
| Nhân viên     | staff       | 123      |
| Khách hàng    | customer    | 123      |

## 👥 Thành viên nhóm  
| STT | Họ tên         | Vai trò                |
|-----|----------------|-------------------------|
| 1   | Vũ Long Quân    | Full-stack Developer     |

*(Thêm nếu có các thành viên khác)*  

## 🏆 Kết luận  
Dự án Quan-Dev (branch Java4) là bước quan trọng giúp bạn rèn luyện kỹ năng xây dựng ứng dụng web Java – từ backend, frontend tới database, quản lý vai trò người dùng và xử lý nghiệp vụ thực tế. Đây là nền tảng tốt để bạn phát triển thêm và nâng cấp lên các phiên bản Java5, Java6…

---

📌 _Made with ❤️ by Vũ Long Quân – FPT Polytechnic_  

