package com.poli.productApp.model.archivoTecnico;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;
import jakarta.persistence.Id;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Column;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.UniqueConstraint;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import com.poli.productApp.model.ordenTrabajo.OrdenTrabajo;
import com.poli.productApp.model.usuario.Usuario;

import java.util.Date;

import com.poli.productApp.model.etapa.EtapaProduccion;



@Entity
@Table(name = "archivo_tecnico",
       uniqueConstraints = @UniqueConstraint(columnNames = {"orden_trabajo_id", "nombre"}))
@Data
public class ArchivoTecnico {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long archivo_tecnico_id;

    @NotBlank(message = "El nombre del archivo no puede estar vacío")
    @Column(nullable = false)
    private String nombre;

  
    @Column(nullable = true)
    private String tipoArchivo; 

    @NotBlank(message = "la url el archivo no puede estar vacío")
    @Column(nullable = false)
    private String url; 

    @NotNull
    @ManyToOne
    @JoinColumn(name = "orden_trabajo_id", nullable = false)
    private OrdenTrabajo ordenTrabajo;

    @NotNull
    @ManyToOne
    @JoinColumn(name = "usuario_id", nullable = false)
    private Usuario usuario;

    @ManyToOne
    @JoinColumn(name = "etapa_produccion_id") 
    private EtapaProduccion etapaProduccion;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(nullable = false, updatable = false)
    private Date fechaSubida = new Date();
}
