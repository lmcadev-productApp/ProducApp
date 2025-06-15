package com.poli.productApp.repository;

import com.poli.productApp.model.etapa.EtapaList;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EtapaListRepository extends JpaRepository<EtapaList, Long> {

    // Buscar todas las etapas asociadas a una producción específica
    List<EtapaList> findByEtapaProduccionId(Long etapaProduccionId);

    // Buscar por etapa específica
    List<EtapaList> findByEtapaId(Long etapaId);
}
