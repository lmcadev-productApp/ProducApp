package com.poli.productApp.repository;

import com.poli.productApp.model.etapa.EtapaProduccion;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EtapaProduccionRepository extends JpaRepository<EtapaProduccion, Long> {

    // Todas las etapas de una orden específica
    List<EtapaProduccion> findByOrdenTrabajoId(Long id);

    // Todas las etapas asignadas a un empleado específico
    List<EtapaProduccion> findByUsuarioId(Long empleadoId);

    // Buscar por estado (como "en progreso", "completada", etc.)
    List<EtapaProduccion> findByEstado(com.poli.productApp.model.ENUMS.Estado estado); 


    // Buscar por fecha de inicio y fin
    List<EtapaProduccion> findByFechaInicioBetween(java.sql.Date fechaInicio, java.sql.Date fechaFin);

    // Buscar por fecha de fin y estado
    List<EtapaProduccion> findByFechaFinBetweenAndEstado(java.sql.Date fechaInicio, java.sql.Date fechaFin, com.poli.productApp.model.ENUMS.Estado estado); 
    // Buscar por nombre de etapa y estado





    
}

