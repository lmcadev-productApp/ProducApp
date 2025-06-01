# Usamos la imagen oficial de OpenJDK 21
FROM eclipse-temurin:21-jdk-alpine

# Directorio de trabajo
WORKDIR /app

# Copiamos el archivo JAR (asegúrate que en target esté el jar)
COPY target/productApp-0.0.1-SNAPSHOT.jar app.jar

# Exponemos el puerto 8080
EXPOSE 8080

# Ejecutamos la app
ENTRYPOINT ["java","-jar","app.jar"]
