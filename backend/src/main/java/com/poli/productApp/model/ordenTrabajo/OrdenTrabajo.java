package com.poli.productApp.model.ordenTrabajo;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import com.poli.productApp.model.ENUMS.Estado;
import com.poli.productApp.model.etapa.EtapaProduccion;
import com.poli.productApp.model.usuario.Cliente;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import lombok.Data;


@Entity
@Table(name = "OrdenTrabajo")
@Data
public class OrdenTrabajo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long orden_trabajo_id;

    @Column(nullable = false)
    private String descripcion;

    @NotNull(message = "Ingrese la fecha de inicio")
    @Column(nullable = false)
    private Date fecha_inicio;

    @NotNull(message = "Ingrese la fecha de fin")
    @Column(nullable = false)
    private Date fecha_fin;

    @Enumerated(EnumType.STRING)
    private Estado estado;

    @ManyToOne(optional = false)
    @JoinColumn(name = "cliente_id", nullable = false)
    private Cliente cliente;

    @OneToMany(mappedBy = "ordenTrabajo", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<EtapaProduccion> etapas = new ArrayList<>();

}