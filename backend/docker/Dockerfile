FROM maven:3.9.6-eclipse-temurin-21 AS builder

WORKDIR /app

# Copia los archivos del backend (pom.xml + src)
COPY . .

# Construye el jar
RUN mvn clean package -DskipTests

# Segunda etapa: imagen runtime
FROM eclipse-temurin:21-jre

WORKDIR /app

# Copia el jar generado
COPY --from=builder /app/target/productApp-0.0.1-SNAPSHOT.jar app.jar

# Instala netcat para wait-for-it.sh
RUN apt-get update && apt-get install -y netcat-openbsd && rm -rf /var/lib/apt/lists/*

# Copia el script para esperar a MySQL
#COPY ./docker/wait-for-it.sh /wait-for-it.sh


#RUN chmod +x /wait-for-it.sh

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
