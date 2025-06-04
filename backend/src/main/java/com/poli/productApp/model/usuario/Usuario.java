package com.poli.productApp.model.usuario;

import com.poli.productApp.model.ENUMS.Rol;
import com.poli.productApp.model.especialidad.Especialidad;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;
import lombok.ToString;


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

    @Enumerated(EnumType.STRING)
    private Rol rol;

    @NotBlank(message = "Ingrese el nombre de usuario")
    @Column(nullable = false)
    private String nombre;

    @Column(nullable = true)
    private String telefono;

    @Column(nullable = true)
    private String direccion;


    public Long getId() {
        return id;
    }

     @ManyToOne
    @JoinColumn(name = "especialidad_id")
    private Especialidad especialidad;

    @Column(nullable = true)
    private String suguroSocial;

    @Column(nullable = true)
    private String arl;
}


