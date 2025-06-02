package com.poli.productApp.model.usuario;

import com.poli.productApp.model.especialidad.Especialidad;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Data;

import lombok.EqualsAndHashCode;

@Entity
@Data
@EqualsAndHashCode(callSuper = true)
public class Operario extends Usuario {

    public Operario() {
        super();
    }

    @ManyToOne
    @JoinColumn(name = "especialidad_id")
    private Especialidad especialidad;

    @Column(nullable = true)
    private String suguroSocial;

    @Column(nullable = true)
    private String arl;

    

}
