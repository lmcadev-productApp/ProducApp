package com.poli.productApp.model.etapa;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NonNull;
import lombok.Setter;
import jakarta.persistence.Id;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;


@Entity
@Table(name = "etapa_list")
@Getter @Setter
public class EtapaList {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false)
    @NonNull
    @JoinColumn(name = "etapa_produccion_id")
    private EtapaProduccion etapaProduccion;

    @ManyToOne(optional = false)
    @NonNull
    @JoinColumn(name = "etapa_id")
    private Etapa etapa;
}