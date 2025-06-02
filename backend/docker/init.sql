CREATE TABLE IF NOT EXISTS usuarios (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    correo VARCHAR(255) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    rol VARCHAR(50) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    direccion VARCHAR(255)
);

INSERT INTO usuarios (correo, contrasena, rol, nombre, telefono, direccion)
VALUES (
    'admin@producapp.com',
    '$2a$10$Q9g1EycS4dUlJ64KNWZr5eXKoGLhJGUv1Af1Wr4N3ePHj6LzcmU.u', -- contraseña: Admin123
    'ADMIN',
    'Administrador',
    '3001234567',
    'Oficina Central'
);
