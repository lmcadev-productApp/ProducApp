package com.poli.productApp.model.etapa;

import java.sql.Date;

import com.poli.productApp.model.ordenTrabajo.OrdenTrabajo;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Entity
@Table(name = "etapa_produccion")
@Data
public class EtapaProduccion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long etapa_produccion_id;

    @NotNull(message = "Estado no puede ser nulo")
    @Column(nullable = false)
    private String estado;

    @NotNull(message = "Ingrese la fecha de inicio")
    @Column(nullable = false)
    private Date fecha_inicio;

    @NotNull(message = "Ingrese la fecha de fin")
    @Column(nullable = false)
    private Date fecha_fin;

    @ManyToOne(optional = false)
    @JoinColumn(name = "orden_trabajo_id", nullable = false)
    private OrdenTrabajo ordenTrabajo;

    @ManyToOne(optional = false)
    @JoinColumn(name = "etapa_id", nullable = false)
    private OrdenTrabajo id_etapa;

    @ManyToOne(optional = false)
    @JoinColumn(name = "empleado_id", nullable = false)
    private OrdenTrabajo id_empleado;

    
}
