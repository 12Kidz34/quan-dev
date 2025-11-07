# 🎯 Quan-Dev – Ứng dụng quản lý bán linh kiện PC  
**Branch:** `java5`  

## 🔍 Giới thiệu  
Dự án này được thực hiện trong khuôn khổ môn **JAVA 5 – Ứng dụng Java Web nâng cao** của trường FPT Polytechnic.  
Ứng dụng cho phép quản lý linh kiện PC (sản phẩm, kho hàng, đơn hàng, nhân viên, khách hàng…) với ba vai trò chính: **Khách hàng**, **Nhân viên**, **Quản lý**.

## 🛠 Công nghệ sử dụng  
- Ngôn ngữ: Java  
- Framework/Thư viện: Servlet + JSP (hoặc Spring Boot tùy cấu hình)  
- ORM/Database: JPA / Hibernate → MySQL  
- Frontend: JSP + Bootstrap (hoặc Vue.js nếu bạn kết hợp)  
- Công cụ: Git, GitHub, IntelliJ IDEA / Eclipse  
- Kiến trúc: MVC, phân quyền Admin/Staff/User  

## 📁 Cấu trúc dự án  
src/
├─ main/
│ ├─ java/com/quan/dev/… → controller, dao, entity, service
│ ├─ resources/
│ │ └─ application.properties (cấu hình DB…)
│ ├─ webapp/
│ │ ├─ WEB-INF/views/ → các file JSP/HTML
│ │ └─ assets/ → CSS, JS, hình ảnh
└─ pom.xml (hoặc build.gradle)


## ✅ Các tính năng chính  
- Đăng ký, đăng nhập với phân quyền: Quản lý / Nhân viên / Khách hàng  
- Quản lý sản phẩm linh kiện (CRUD)  
- Quản lý kho hàng, tồn kho  
- Quản lý đơn hàng, khách hàng  
- Báo cáo thống kê (ví dụ: tồn kho, doanh thu)  
- Giao diện người dùng thân thiện, responsive (Bootstrap)  
- Xác thực đầu vào, xử lý lỗi.

## 🧮 Hướng dẫn cài đặt & chạy dự án  
1. **Clone repository**  
    ```bash
    git clone https://github.com/12Kidz34/quan-dev.git
    cd quan-dev
    git checkout java5
    ```  
2. **Cấu hình cơ sở dữ liệu**  
   - Tạo database trong MySQL, ví dụ: `quan_dev_db`  
   - Mở file `application.properties` (hoặc tương đương) và điều chỉnh:  
     ```properties
     spring.datasource.url=jdbc:mysql://localhost:3306/quan_dev_db
     spring.datasource.username=your_username
     spring.datasource.password=your_password
     ```  
3. **Build và chạy ứng dụng**  
   - Nếu dùng Spring Boot: chạy `mvn spring-boot:run` hoặc `./gradlew bootRun`  
   - Nếu dùng Servlet/JSP: deploy lên server như Apache Tomcat  
4. **Truy cập ứng dụng**  
   Mở trình duyệt và vào: `http://localhost:8080` (hoặc port bạn cấu hình)  

## 🧑‍💼 Tài khoản mẫu  
| Vai trò      | Tài khoản   | Mật khẩu |
|-------------|-------------|----------|
| Quản lý     | manager     | 123      |
| Nhân viên    | staff       | 123      |
| Khách hàng   | customer    | 123      |

## 👥 Thành viên nhóm  
| STT | Họ tên            | Vai trò                 |
|-----|-------------------|--------------------------|
| 1   | Vũ Long Quân       | Full-stack Developer     |

*(Bạn có thể thêm các thành viên khác nếu có)*  

## 🏆 Kết luận  
Dự án Quan-Dev giúp bạn thực hành và hoàn thiện kỹ năng xây dựng ứng dụng web Java (backend + frontend + database), quản lý đa vai trò, xử lý nghiệp vụ quản lý kho & bán hàng – là một nền tảng rất tốt để phát triển thêm và nâng cao trong tương lai.

---

📌 _Made with ❤️ by Vũ Long Quân – FPT Polytechnic (2023-2025)_  
