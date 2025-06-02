# Etapa 1: Construcción del .jar con Maven
FROM maven:3.9.6-eclipse-temurin-21 AS builder

WORKDIR /app

# Copia los archivos del proyecto (pom.xml y src/)
COPY . .

# Descarga dependencias y compila el proyecto
RUN mvn clean package -DskipTests

# Etapa 2: Imagen ligera con el .jar compilado
FROM eclipse-temurin:21-jre

WORKDIR /app

# Copia el .jar desde la etapa anterior y renómbralo a app.jar
COPY --from=builder /app/target/productApp-0.0.1-SNAPSHOT.jar app.jar

# Instalar netcat-openbsd (nc), necesario para wait-for-it.sh
RUN apt-get update && \
    apt-get install -y netcat-openbsd && \
    rm -rf /var/lib/apt/lists/*

# Copiar wait-for-it.sh y darle permisos de ejecución
COPY docker/wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

# Exponer el puerto por defecto de Spring Boot
EXPOSE 8080

# ENTRYPOINT: esperar a MySQL y luego arrancar la aplicación
ENTRYPOINT ["/wait-for-it.sh", "sql-db", "3306", "--"]
CMD ["java", "-jar", "app.jar"]
