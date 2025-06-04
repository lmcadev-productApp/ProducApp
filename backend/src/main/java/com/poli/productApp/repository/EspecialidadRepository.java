package com.poli.productApp.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.poli.productApp.model.especialidad.Especialidad;

@Repository
public interface EspecialidadRepository extends JpaRepository<Especialidad, Long> {
    // Puedes añadir métodos personalizados si los necesitas
}
