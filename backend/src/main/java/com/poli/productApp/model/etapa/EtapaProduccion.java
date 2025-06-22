package com.poli.productApp.model.etapa;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.poli.productApp.model.ENUMS.Estado;
import com.poli.productApp.model.ordenTrabajo.OrdenTrabajo;
import com.poli.productApp.model.usuario.Usuario;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;

@Entity
@Table(name = "etapa_produccion")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@ToString(exclude = {"ordenTrabajo", "etapas"})
public class EtapaProduccion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull(message = "Estado no puede ser nulo")
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Estado estado;


    @Column(nullable = true)
    private Date fechaInicio;


    @Column(nullable = true)
    private Date fechaFin;

    // Relación con la orden de trabajo
    @ManyToOne(optional = false)
    @JoinColumn(name = "orden_trabajo_id", nullable = false)
    @JsonIgnoreProperties("etapas")
    private OrdenTrabajo ordenTrabajo;

    @ManyToOne(optional = false)
    @JoinColumn(name = "etapa_id", nullable = false)
    private Etapa etapa;

    // Relación con el empleado asignado a esta etapa
    @ManyToOne(optional = true)
    @JoinColumn(name = "usuario_id", nullable = true)
    private Usuario usuario;

    // Relación con el empleado que creo la Etapa de produccion
    @ManyToOne(optional = false)
    @JoinColumn(name = "registrado_por", nullable = false)
    private Usuario registradoPor;





}
