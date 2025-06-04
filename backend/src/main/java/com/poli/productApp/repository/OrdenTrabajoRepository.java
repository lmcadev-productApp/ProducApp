package com.poli.productApp.repository;

import com.poli.productApp.model.ordenTrabajo.OrdenTrabajo;

import java.sql.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OrdenTrabajoRepository extends JpaRepository<OrdenTrabajo, Long> {


    List<OrdenTrabajo> findByUsuarioId(Long usuarioId);


    List<OrdenTrabajo> findByEstado(com.poli.productApp.model.ENUMS.Estado estado);


    List<OrdenTrabajo> findByFechaInicioBetween(Date fechaInicio, Date fechaFin);
}
