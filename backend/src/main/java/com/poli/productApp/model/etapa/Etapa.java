package com.poli.productApp.model.etapa;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.poli.productApp.model.ordenTrabajo.OrdenTrabajo;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "etapa")
@Data
@Getter
@Setter
public class Etapa {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Ingrese el nombre de la etapa")
    @Column(nullable = false)
    private String nombre;

    @Column(nullable = true)
    private String descripcion;



}
