FROM eclipse-temurin:25-jdk-jammy AS builder
WORKDIR /app
COPY . .
RUN chmod +x mvnw && ./mvnw clean package -DskipTests

# ---- Runtime stage ----
FROM eclipse-temurin:25-jdk-jammy
WORKDIR /app

# 환경변수는 -e 옵션으로 전달 (보안 강화)
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
