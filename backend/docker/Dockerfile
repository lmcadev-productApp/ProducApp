FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=builder /app/target/productApp-0.0.1-SNAPSHOT.jar app.jar

RUN apt-get update && apt-get install -y netcat-openbsd && rm -rf /var/lib/apt/lists/*

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
