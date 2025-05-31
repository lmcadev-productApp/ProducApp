package com.poli.productApp.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;
import lombok.ToString;

/**
 * Entidad que representa un usuario en el sistema.
 * 
 * <p>Esta clase mapea la tabla "usuarios" en la base de datos y contiene la información
 * relevante de cada usuario, como correo electrónico, contraseña, rol, nombre, teléfono y dirección.</p>
 * 
 * <ul>
 *   <li><b>id</b>: Identificador único del usuario (clave primaria).</li>
 *   <li><b>correo</b>: Correo electrónico del usuario. Debe ser único y válido.</li>
 *   <li><b>contrasena</b>: Contraseña del usuario. Debe tener al menos 6 caracteres.</li>
 *   <li><b>rol</b>: Rol asignado al usuario (por ejemplo, administrador, cliente, etc.).</li>
 *   <li><b>nombre</b>: Nombre del usuario.</li>
 *   <li><b>telefono</b>: Teléfono de contacto del usuario (opcional).</li>
 *   <li><b>direccion</b>: Dirección del usuario (opcional).</li>
 * </ul>
 * 
 * <p>Las validaciones aseguran que los campos obligatorios no sean nulos o vacíos y que el correo tenga un formato válido.</p>
 */
@Entity
@Table(name = "usuarios")
@Data
@ToString(exclude = "contrasena")
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "El correo es obligatorio")
    @Email(message = "Debe ingresar un correo válido")
    @Column(nullable = false, unique = true)
    private String correo;

    @NotBlank(message = "La contraseña es obligatoria")
    @Size(min = 6, message = "La contraseña debe tener al menos 6 caracteres")
    @Column(nullable = false)
    private String contrasena;

    @NotBlank(message = "El rol es obligatorio")
    @Column(nullable = false)
    private String rol;

    @NotBlank(message = "Ingrese el nombre de usuario")
    @Column(nullable = false)
    private String nombre;

    @Column(nullable = true)
    private String telefono;

    @Column(nullable = true)
    private String direccion;

}
