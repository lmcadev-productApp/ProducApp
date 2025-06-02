package com.poli.productApp.model.etapa;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Entity
@Table(name = "etapa")
@Data
public class Etapa {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long etapa_id;

    @NotBlank(message = "Ingrese el nombre de la etapa")
    @Column(nullable = false)
    private String nombre;

    @Column(nullable = true)
    private String descripcion;
    
}
