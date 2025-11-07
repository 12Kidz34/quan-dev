# 🧩 Quan-Dev – Ứng dụng quản lý bán linh kiện PC  
**Branch:** `Java5`  

---

## 🇻🇳 GIỚI THIỆU (Vietnamese)

### 🔍 Giới thiệu  
Dự án này được thực hiện trong khuôn khổ môn **JAVA 5 – Ứng dụng Java Web nâng cao** tại **FPT Polytechnic**.  
Ứng dụng mô phỏng hệ thống **quản lý linh kiện PC**, bao gồm các chức năng quản lý sản phẩm, khách hàng, đơn hàng, kho hàng, và báo cáo thống kê.  
Hệ thống có **phân quyền người dùng** gồm **Quản lý**, **Nhân viên**, và **Khách hàng**, với giao diện hiện đại và dữ liệu động từ cơ sở dữ liệu MySQL.

### 🛠 Công nghệ sử dụng  
- **Ngôn ngữ:** Java 8+  
- **Framework:** Spring Boot / Hibernate / JPA  
- **Database:** MySQL  
- **Frontend:** JSP + Bootstrap / Thymeleaf  
- **Build Tool:** Maven  
- **IDE:** IntelliJ IDEA / Eclipse  
- **Kiến trúc:** MVC + RESTful API  

### 📁 Cấu trúc dự án  

<img width="659" height="318" alt="image" src="https://github.com/user-attachments/assets/3f4d5028-3249-4932-8666-1cdf0b4384b4" />


### ✅ Các tính năng chính  
- **Đăng nhập / Đăng ký tài khoản**  
- **Phân quyền người dùng (Admin / Staff / User)**  
- **Quản lý sản phẩm, khách hàng, đơn hàng, kho hàng (CRUD)**  
- **Thống kê dữ liệu, doanh thu, báo cáo nhanh**  
- **Xử lý API (RESTful Web Services)**  
- **Giao diện hiện đại, responsive (Bootstrap 5)**  
- **Xử lý lỗi và xác thực dữ liệu đầu vào**

### 🧮 Hướng dẫn cài đặt & chạy  
1. **Clone project**
    ```bash
    git clone https://github.com/12Kidz34/quan-dev.git
    cd quan-dev
    git checkout java5
    ```
2. **Cấu hình database**
    - Tạo database: `quan_dev_db_java5`
    - Cập nhật file `application.properties`
      ```properties
      spring.datasource.url=jdbc:mysql://localhost:3306/quan_dev_db_java5
      spring.datasource.username=root
      spring.datasource.password=123456
      ```
3. **Chạy ứng dụng**
    ```bash
    mvn spring-boot:run
    ```
4. **Truy cập trình duyệt**
    ```
    http://localhost:8080
    ```

### 🧑‍💼 Tài khoản mẫu  
| Vai trò | Tài khoản | Mật khẩu |
|----------|------------|-----------|
| Quản lý | admin | 123 |
| Nhân viên | staff | 123 |
| Khách hàng | user | 123 |

### 👥 Thành viên nhóm  
| STT | Họ tên | Vai trò |
|-----|---------|----------|
| 1 | Vũ Long Quân | Full-stack Developer |

### 🏆 Kết luận  
Phiên bản **Java5** của dự án **Quan-Dev** là bước nâng cấp toàn diện từ Java4, áp dụng **Spring Boot**, **JPA/Hibernate**, và **REST API** để tạo nên ứng dụng web động, hiện đại và mở rộng dễ dàng.  
Dự án giúp người học hiểu rõ cách kết hợp giữa **backend – frontend – database – API**, đồng thời rèn luyện kỹ năng phát triển ứng dụng thực tế trong doanh nghiệp.  

---

## 🇬🇧 INTRODUCTION (English)

### 🔍 Overview  
This project was developed as part of the **JAVA 5 – Advanced Java Web Development** course at **FPT Polytechnic**.  
It simulates a **PC component management system**, providing modules for managing products, customers, orders, warehouses, and business reports.  
The system supports multiple roles — **Admin**, **Staff**, and **Customer** — with a modern, responsive interface connected to a MySQL database.

### 🛠 Technologies Used  
- **Language:** Java 8+  
- **Framework:** Spring Boot / Hibernate / JPA  
- **Database:** MySQL  
- **Frontend:** JSP + Bootstrap / Thymeleaf  
- **Build Tool:** Maven  
- **IDE:** IntelliJ IDEA / Eclipse  
- **Architecture:** MVC + RESTful API  

### 📁 Project Structure  

<img width="681" height="326" alt="image" src="https://github.com/user-attachments/assets/9e1fed1c-8759-43c8-a21f-452122b840d0" />

### ✅ Main Features  
- User login / registration  
- Role-based access (Admin / Staff / User)  
- CRUD for products, customers, orders, and warehouse data  
- Sales and revenue reports  
- RESTful Web API integration  
- Responsive UI (Bootstrap 5)  
- Validation and exception handling  

### 🧮 How to Run  
1. **Clone the repository**
    ```bash
    git clone https://github.com/12Kidz34/quan-dev.git
    cd quan-dev
    git checkout java5
    ```
2. **Configure the database**
    - Create a database named `quan_dev_db_java5`
    - Update `application.properties`
      ```properties
      spring.datasource.url=jdbc:mysql://localhost:3306/quan_dev_db_java5
      spring.datasource.username=root
      spring.datasource.password=123456
      ```
3. **Run the application**
    ```bash
    mvn spring-boot:run
    ```
4. **Open in browser**
    ```
    http://localhost:8080
    ```

### 🧑‍💼 Sample Accounts  
| Role | Username | Password |
|------|-----------|-----------|
| Admin | admin | 123 |
| Staff | staff | 123 |
| User | user | 123 |

### 👥 Team Members  
| No. | Name | Role |
|-----|------|------|
| 1 | Vũ Long Quân | Full-stack Developer |

### 🏆 Conclusion  
The **Java5** branch of **Quan-Dev** represents a major enhancement over the previous version.  
It leverages **Spring Boot**, **Hibernate**, and **RESTful APIs** to deliver a modern, scalable web application with clear role separation and dynamic data handling.  
This project strengthens understanding of enterprise-level **Java Web development**, including **backend logic**, **frontend integration**, and **database communication**.

---

📌 _Made with ❤️ by Vũ Long Quân – FPT Polytechnic_
