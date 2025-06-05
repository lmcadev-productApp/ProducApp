# Stage 1: build with Maven
FROM maven:3.9.6-eclipse-temurin-21 AS builder

WORKDIR /app

COPY . .

RUN mvn clean package -DskipTests

# Stage 2: runtime
FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=builder /app/target/productApp-0.0.1-SNAPSHOT.jar app.jar

RUN apt-get update && apt-get install -y netcat-openbsd && rm -rf /var/lib/apt/lists/*

EXPOSE 8081

CMD ["java", "-jar", "app.jar"]
