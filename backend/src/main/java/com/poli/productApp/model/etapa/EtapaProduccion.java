package com.poli.productApp.model.etapa;

import java.sql.Date;

import com.poli.productApp.model.ordenTrabajo.OrdenTrabajo;
import com.poli.productApp.model.usuario.Usuario;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Entity
@Table(name = "etapa_produccion")
@Data
public class EtapaProduccion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull(message = "Estado no puede ser nulo")
    @Column(nullable = false)
    private String estado;

    @NotNull(message = "Ingrese la fecha de inicio")
    @Column(nullable = false)
    private Date fechaInicio;

    @NotNull(message = "Ingrese la fecha de fin")
    @Column(nullable = false)
    private Date fechaFin;

    // Relación con la orden de trabajo
    @ManyToOne(optional = false)
    @JoinColumn(name = "orden_trabajo_id", nullable = false)
    private OrdenTrabajo ordenTrabajo;

    // Relación con el tipo de etapa (como "Diseño", "Corte", etc.)
    @ManyToOne(optional = false)
    @JoinColumn(name = "etapa_id", nullable = false)
    private Etapa etapa;

    // Relación con el empleado asignado a esta etapa
    @ManyToOne(optional = false)
    @JoinColumn(name = "usuario_id", nullable = false)
    private Usuario usuario;
}
