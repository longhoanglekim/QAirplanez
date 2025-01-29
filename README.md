# ✈️ Flight Booking System - QAirplanez

## Assignment for Web Programming - INT3306 7

A web-based system for managing flight ticket bookings and checking flight information. Users can book tickets and check flight schedules, while administrators can manage flights and reservations.
## Features
- **For customers**
  - Book flight tickets online.
  - Check flight status (on-time, delayed, canceled).
  - View and manage booking history.
- **For admins**
  -  Add, update, and delete flight schedules.
  - Manage bookings and passenger details.
  - Update flight status.

## Project Overview

- **Backend**: Spring Boot
- **Frontend**: Vue.js
- **Database**: MySQL
- **Authentication**: JWT 

## Sample Account 
- Sample user account:
  - **Email**: quyenluong@gmail.com
  - **Phone number**: 0345675123
  - **Password**: quyen123

- Sample admin account:
  - **Email**: trannhanhot@gmail.com
  - **Phone number**: 01234546396
  - **Password**: darangcom
- Sample admin flight account:
  - **Email**: adminflight@gmail.com
  - **Phone number**: 0123567486
  - **Password**: adminflight
## Table of Contents
1. [Frontend Setup](#frontend-setup)
2. [Backend Setup](#backend-setup)
3. [Database Setup](#database-setup)
4. [Running the Application](#running-the-application)
5. [API Documentation](#api-documentation)
---

## Installation & Setup
### 1. Clone the repository
```bash
git clone https://github.com/longhoanglekim/QAirplanez
 ```
### 2. Configuration Database
- Update database in MySQL by running file `src/main/resources/static/data/data.sql`.
- Update src/main/resources/application.properties with your database configuration:
```bash
spring.datasource.url=jdbc:mysql://localhost:3306/qairplanez
spring.datasource.username=root
spring.datasource.password=yourpassword
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver

spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
spring.jpa.database-platform=org.hibernate.dialect.MySQL8Dialect
```
### 3. Installation & Run Backend
#### 🛠️ Prerequisites
- Before running the backend, ensure you have installed:
  - Java 17+ (or compatible version)
  - Maven 3.6+
  - PostgreSQL/MySQL (or any database of your choice)
  - Spring Boot 3.x
#### Install dependencies
```bash
mvn clean install
```
#### Run Spring boot
```bash
mvn spring-boot:run
```
- Backend will be available at: http://localhost:8080
### 4. Installation & Run Frontend
#### 🛠️ Prerequisites
- Before running the frontend, ensure you have installed:
    - Node.js (>= 14.x)
    - npm or yarn
#### Install & Run Frontend
```bash
cd frontend
npm install
npm start
```
- Access frontend at: http://localhost:3000
## 📡 API Endpoints
- ✈️ Flight APIs
  - 
- 🎟 Booking APIs
  -
## Contact
- Email : hlklonga5@gmail.com
- Github : https://github.com/longhoanglekim
