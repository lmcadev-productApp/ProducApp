package com.poli.productApp.model.ordenTrabajo;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.poli.productApp.model.ENUMS.Estado;
import com.poli.productApp.model.etapa.Etapa;
import com.poli.productApp.model.etapa.EtapaProduccion;
import com.poli.productApp.model.usuario.Usuario;

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
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "OrdenTrabajo")
@Data
@Getter @Setter
public class OrdenTrabajo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String descripcion;

    @NotNull(message = "Ingrese la fecha de inicio")
    @Column(nullable = false)
    private Date fechaInicio;

    @NotNull(message = "Ingrese la fecha de fin")
    @Column(nullable = false)
    private Date fechaFin;

    @Enumerated(EnumType.STRING)
    private Estado estado;

    @ManyToOne(optional = false)
    @JoinColumn(name = "usuario_id", nullable = false)
    private Usuario usuario;


    @OneToMany(mappedBy = "ordenTrabajo", cascade = CascadeType.ALL)
    private List<EtapaProduccion> etapasProduccion;

}