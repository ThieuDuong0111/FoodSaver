# Sử dụng một image chính thức của OpenJDK làm base image
FROM openjdk:17-jdk-alpine

# Copy file JAR của ứng dụng vào container
COPY target/foodsaveradmin-0.0.1-SNAPSHOT.jar foodsaveradmin-0.0.1.jar

# Lệnh để chạy ứng dụng khi container được khởi động
ENTRYPOINT ["java", "-jar", "/foodsaveradmin-0.0.1.jar"]