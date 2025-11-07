# 🎯 Quan-Dev – Ứng dụng quản lý bán linh kiện PC  
**Branch:** `Java4`  

---

## 🇻🇳 GIỚI THIỆU (Vietnamese)

### 🔍 Giới thiệu  
Dự án này được thực hiện trong khuôn khổ môn **JAVA 4 – Lập trình Java Web cơ bản/nâng cao** tại **FPT Polytechnic**.  
Ứng dụng mô phỏng hệ thống **quản lý linh kiện PC** (sản phẩm, kho hàng, đơn hàng, nhân viên, khách hàng…) với ba vai trò chính: **Khách hàng**, **Nhân viên**, **Quản lý**.

### 🛠 Công nghệ sử dụng  
- Ngôn ngữ: Java  
- Framework/Thư viện: Servlet + JSP  
- ORM/Database: JDBC / JPA / Hibernate → MySQL  
- Frontend: JSP + Bootstrap  
- Công cụ: Git, GitHub, Eclipse / IntelliJ IDEA  
- Kiến trúc: MVC, có phân quyền Admin / Staff / User  

### 📁 Cấu trúc dự án  

<img width="579" height="312" alt="image" src="https://github.com/user-attachments/assets/5ebe277d-b88b-4d2f-b7f5-3b676c862224" />


### ✅ Các tính năng chính  
- Đăng nhập / Đăng ký tài khoản  
- CRUD sản phẩm, khách hàng, đơn hàng  
- Quản lý kho hàng, tồn kho  
- Phân quyền người dùng (Admin / Staff / Customer)  
- Báo cáo / thống kê cơ bản  
- Giao diện responsive bằng Bootstrap  

### 🧮 Cách chạy dự án  
1. **Clone repository**
    ```bash
    git clone https://github.com/12Kidz34/quan-dev.git
    cd quan-dev
    git checkout Java4
    ```
2. **Cấu hình database**
    - Tạo database: `quan_dev_db_java4`
    - Cập nhật thông tin kết nối trong `application.properties`
      ```properties
      spring.datasource.url=jdbc:mysql://localhost:3306/quan_dev_db_java4
      spring.datasource.username=root
      spring.datasource.password=123456
      ```
3. **Chạy ứng dụng**
    - Với Servlet/JSP: Deploy trên Tomcat  
    - Truy cập: `http://localhost:8080`  

### 🧑‍💼 Tài khoản mẫu  
| Vai trò | Tài khoản | Mật khẩu |
|----------|------------|-----------|
| Quản lý | manager | 123 |
| Nhân viên | staff | 123 |
| Khách hàng | customer | 123 |

### 👥 Thành viên nhóm  
| STT | Họ tên | Vai trò |
|-----|---------|----------|
| 1 | Vũ Long Quân | Full-stack Developer |

### 🏆 Kết luận  
Phiên bản **Java4** của dự án Quan-Dev là nền tảng quan trọng giúp người học nắm vững quy trình xây dựng ứng dụng Java Web theo mô hình **MVC**, làm việc với **JSP/Servlet**, **JDBC/JPA**, và thiết kế giao diện web hiện đại.  

---

## 🇬🇧 INTRODUCTION (English)

### 🔍 Overview  
This project was developed as part of the **JAVA 4 – Advanced Java Web Programming** course at **FPT Polytechnic**.  
It simulates a **PC component management system**, including modules for managing products, stock, orders, employees, and customers.  
There are three user roles: **Customer**, **Staff**, and **Manager**.

### 🛠 Technologies Used  
- Language: Java  
- Framework / Library: Servlet + JSP  
- ORM / Database: JDBC / Hibernate / JPA → MySQL  
- Frontend: JSP + Bootstrap  
- Tools: Git, GitHub, Eclipse / IntelliJ IDEA  
- Architecture: MVC with Role-Based Access Control  

### 📁 Project Structure  

<img width="616" height="313" alt="image" src="https://github.com/user-attachments/assets/157704c6-616c-4fc7-bc81-784fa7676037" />


### ✅ Main Features  
- User login / registration  
- CRUD for products, customers, and orders  
- Stock & inventory management  
- Role-based permissions (Admin / Staff / Customer)  
- Basic reports & statistics  
- Responsive UI built with Bootstrap  

### 🧮 How to Run  
1. **Clone the repository**
    ```bash
    git clone https://github.com/12Kidz34/quan-dev.git
    cd quan-dev
    git checkout Java4
    ```
2. **Configure the database**
    - Create a database named `quan_dev_db_java4`
    - Update connection details in `application.properties`:
      ```properties
      spring.datasource.url=jdbc:mysql://localhost:3306/quan_dev_db_java4
      spring.datasource.username=root
      spring.datasource.password=123456
      ```
3. **Run the application**
    - Deploy the project on **Apache Tomcat**
    - Open: `http://localhost:8080`

### 🧑‍💼 Sample Accounts  
| Role | Username | Password |
|------|-----------|-----------|
| Manager | manager | 123 |
| Staff | staff | 123 |
| Customer | customer | 123 |

### 👥 Team Members  
| No. | Name | Role |
|-----|------|------|
| 1 | Vũ Long Quân | Full-stack Developer |

### 🏆 Conclusion  
The **Java4** version of Quan-Dev lays the foundation for building robust **Java Web applications** using **Servlets, JSP, and JDBC/JPA** with MVC architecture.  
It helps learners understand how to connect front-end, back-end, and database layers effectively before moving on to more advanced frameworks in Java5+.

---

📌 _Made with ❤️ by Vũ Long Quân – FPT Polytechnic_
