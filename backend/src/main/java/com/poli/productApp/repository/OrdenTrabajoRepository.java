package com.poli.productApp.repository;

import com.poli.productApp.model.ordenTrabajo.OrdenTrabajo;
import com.poli.productApp.model.ENUMS.Estado;

import java.sql.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface OrdenTrabajoRepository extends JpaRepository<OrdenTrabajo, Long> {


    List<OrdenTrabajo> findByUsuarioId(Long usuarioId);


    List<OrdenTrabajo> findByEstado(Estado estado);


    List<OrdenTrabajo> findByFechaInicioBetween(Date fechaInicio, Date fechaFin);

    Optional<OrdenTrabajo> findById(Long id);
}
