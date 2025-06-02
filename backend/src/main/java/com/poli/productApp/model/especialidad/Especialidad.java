package com.poli.productApp.model.especialidad;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Entity
@Table(name = "especialidad")
@Data
public class Especialidad {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long especialidad_id;

    @NotBlank(message = "Ingrese el nombre de especialidad")
    @Column(nullable = false)
    private String nombre;

    @Column(nullable = true)
    private String descripcion;

}
