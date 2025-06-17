package com.poli.productApp.repository;


import com.poli.productApp.model.etapa.Etapa;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;


public interface EtapaRepository extends JpaRepository<Etapa, Long> {
    boolean existsByNombre(String nombre);

    boolean existsById(@org.springframework.lang.NonNull Long id);
    void deleteById(@org.springframework.lang.NonNull Long id);
    Etapa findByNombre(String nombre);
    List<Etapa> findAllByIdIn(List<Long> ids);




}
