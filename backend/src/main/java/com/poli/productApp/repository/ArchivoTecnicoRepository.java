package com.poli.productApp.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.poli.productApp.model.archivoTecnico.ArchivoTecnico;
import com.poli.productApp.model.ordenTrabajo.OrdenTrabajo;
import com.poli.productApp.model.usuario.Usuario;

public interface ArchivoTecnicoRepository extends JpaRepository<ArchivoTecnico, Long> {

    List<ArchivoTecnico> findByOrdenTrabajo(OrdenTrabajo ordenTrabajo);

    List<ArchivoTecnico> findByUsuario(Usuario usuario);

    boolean existsByOrdenTrabajoIdAndNombre(Long ordenTrabajoId, String nombre);
}
