📱 ProducApp
ProducApp es una aplicación móvil multiplataforma desarrollada para ayudar a microempresas manufactureras a gestionar sus órdenes de producción de forma más organizada, eficiente y visual. Permite dividir cada orden en etapas de trabajo específicas y asignarlas a empleados según su especialidad.

🚀 Características principales
📋 Creación y gestión de órdenes de producción.
🔄 División de órdenes en estapas personalizadas (ej: diseño, corte, ensamblaje, calidad).
👷 Asignación de empleados especializados por etapa.
📎 Carga de documentos técnicos (planos, esquemas, instrucciones).
📲 Notificaciones del avance y cambios en tiempo real.
📊 Tablero visual del estado de la producción.
🧑‍💼 Roles diferenciados para administrador, supervisor y operario.
🛠️ Tecnologías utilizadas
Frontend (Móvil)
Flutter 3.x
Provider
Firebase Messaging
Dio
Backend (API REST)
Java 21 con Spring Boot
Spring Security con JWT
MySQL / MariaDB
Maven
Docker
Otros
Swagger (documentación de API)
GitHub Actions (CI/CD en desarrollo)
Uptime Kuma (monitoring del backend)
🗂️ Estructura del proyecto
producapp/ ├── backend/ │ 
├── src/main/java/com/producapp/... │ 
├── pom.xml 
│ └── README.md 
├── frontend/ │ 
├── lib/ │ 
├── assets/ │ 
├── pubspec.yaml 
│ └── README.md 
└── docker/ 
└── docker-compose.yml

🧑‍💻 Instalación y ejecución
Requisitos
Java 21
Flutter SDK
Docker y Docker Compose
MySQL
Node.js
Backend
cd backend
./mvnw spring-boot:run

cd frontend
flutter pub get
flutter run

cd docker
docker-compose up -d

🧪 Pruebas
Pruebas unitarias disponibles para servicios principales en el backend con JUnit.

En el frontend, se usan pruebas con flutter_test.

📄 Licencia
Este proyecto está bajo la licencia MIT - consulta el archivo LICENSE para más información.


📬 Proyecto de materia ÉNFASIS EN PROGRAMACIÓN MÓVIL-[GRUPO B03]
[GRUPO B03]
EPMB03-G2
Cardenas Jaramillo Yuliana Aide
Castañeda Arciniegas Luis Miguel
Cortes Cubides Julian David
Cortes Guayara Juan Felipe
Cárdenas Peláez William Felipe 

Proyecto desarrollado como solución para la digitalización de procesos productivos en pequeñas industrias.
