-- tabla especialidad
INSERT IGNORE INTO especialidad (nombre) VALUES 
('Diseño'),
('Desarrollo'),
('Marketing'),
('Administración'),
('Logística'),
('Calidad'),
('Producción'),
('Investigación y Desarrollo'),
('Soporte Técnico'),
('Atención al Cliente'),
('Ensamble'),
('Corte'),
('Impresión'),
('Montaje'),
('Mantenimiento'),
('Iluminación');




-- tabla usuarios
INSERT IGNORE INTO usuarios (correo, contrasena, rol, nombre, telefono, direccion, especialidad_id, suguro_social, arl) VALUES
('admin@productapp.com', '$2a$10$wZNqu2A3RrDE8y9ITV2sUOtffY4yNbc4Boq5phZlNGeZrRnGE7KOm', 'ADMINISTRADOR', 'Admin Principal', '3000000001', 'Cra 1 #1-01', NULL, NULL, NULL),
('supervisor1@productapp.com', '$2a$10$GqDp8HRyL/jgFZPV6IZF8eFzWXFeKz5ab8JkYXqQGrPWLoEj.2YjW', 'SUPERVISOR', 'Carlos Supervisor', '3000000002', 'Cra 2 #2-02', NULL, NULL, NULL),
('operario1@productapp.com', '$2a$10$MnArbO3/NdPgy2HMOZYCVu6gBlzz6M2G6JXxw6ukD3qDEoCPo1le2', 'OPERARIO', 'Ana Operaria', '3000000003', 'Cra 3 #3-03', 1, NULL, NULL),
('operario2@productapp.com', '$2a$10$MnArbO3/NdPgy2HMOZYCVu6gBlzz6M2G6JXxw6ukD3qDEoCPo1le2', 'OPERARIO', 'Luis Operario', '3000000004', 'Cra 4 #4-04', 2, 'Seguridad Total', 'ARL SURA'),
('operario3@productapp.com', '$2a$10$MnArbO3/NdPgy2HMOZYCVu6gBlzz6M2G6JXxw6ukD3qDEoCPo1le2', 'OPERARIO', 'Marta Operaria', NULL, NULL, 2, NULL, NULL),
('supervisor2@productapp.com', '$2a$10$GqDp8HRyL/jgFZPV6IZF8eFzWXFeKz5ab8JkYXqQGrPWLoEj.2YjW', 'SUPERVISOR', 'Juan Supervisor', '3000000005', 'Cra 5 #5-05', NULL, NULL, NULL),
('admin2@productapp.com', '$2a$10$wZNqu2A3RrDE8y9ITV2sUOtffY4yNbc4Boq5phZlNGeZrRnGE7KOm', 'ADMINISTRADOR', 'Lucía Admin', '3000000006', 'Cra 6 #6-06', NULL, NULL, NULL),
('usuario_incompleto@productapp.com', '$2a$10$MnArbO3/NdPgy2HMOZYCVu6gBlzz6M2G6JXxw6ukD3qDEoCPo1le2', 'OPERARIO', '', NULL, NULL, NULL, NULL, NULL),
('usuario_sin_rol@productapp.com', '$2a$10$MnArbO3/NdPgy2HMOZYCVu6gBlzz6M2G6JXxw6ukD3qDEoCPo1le2', NULL, 'CLIENTE', NULL, NULL, NULL, NULL, NULL);
