package com.poli.productApp.repository;


import com.poli.productApp.model.etapa.Etapa;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface EtapaRepository extends JpaRepository<Etapa, Long> {
    boolean existsByNombre(String nombre);

    boolean existsById(Long id);
    void deleteById(Long id);
    Optional<Etapa> findById(Long id);
    Etapa findByNombre(String nombre);
    Etapa save(Etapa etapa);
    List<Etapa> findAllByIdIn(List<Long> ids);




}
