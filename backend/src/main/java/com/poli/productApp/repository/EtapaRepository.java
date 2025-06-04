package com.poli.productApp.repository;


import com.poli.productApp.model.etapa.Etapa;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EtapaRepository extends JpaRepository<Etapa, Long> {
    boolean existsByNombre(String nombre);
}
